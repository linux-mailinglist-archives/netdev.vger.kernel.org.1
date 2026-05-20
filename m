Return-Path: <netdev+bounces-289779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGkjD8RaDWrBwQUAu9opvQ
	(envelope-from <netdev+bounces-289779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:55:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 746EC58882D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA2E2302A18E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3133FE05;
	Wed, 20 May 2026 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NHeYXAtv"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB7322768;
	Wed, 20 May 2026 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259326; cv=fail; b=nOHE3kjLsL6UNKMHtnmel5zsjCZ9H1THYT6CqOHK76lJZ0AvJcPLIEluLtWwrE7RfVQghoSYVY4292kRS+QmK+Vv72B8EMZCtoHM1ABiNLEC9dOdmBxufnb3yO/PXNx8A74hIW5Gb85J2Yz5kQp43tvE0JRXpN0ypJKDDQJ4jpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259326; c=relaxed/simple;
	bh=c4+vDv23EbKtMVPMCmHUV1t3yQbbJGNWYwTeMSBEieE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E1glsPw4G6hL1yaJhCfr1K6aNQmfLEPEMqWnPFTKVpm6Q6mdfNqw3e4HL1ftpGFeVnr8VhevjBJCgeIUonx0QvQl9AaZM9UXw019zaGFvqxLpANxbgyl6I02eBTHTvs+W4RftHJcQE79S63WmDNHVCQ47Dd4hY84c26Ee8zQt6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NHeYXAtv reason="signature verification failed"; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxFCrL1TBLY4ESrOrJUQQewfEJYsIE+VFNt8H+ceFcyOqVIQOpqOCsdJ5T3/yrTM/4wD3adVlYC6LPhHq/SY3iPANYe4NKA/xFiiVPMJuQwF5DhpvrMJoMOPv5ClktpO2guo+hnK5z3qP6IQDYui/yrhXwK9uI6013oMBw6Oa/Ri2wEA2A1Pku0in8LlOiPiB5DFCfrNj+CkENRdB9pQpduNd20xGsJQQyO5DQU5eACnLp2oiSfGUyqjuZow5LKUHACmKgMj9yXxrXfQeHzBeLVyTBLHEqELWF2Mkcc3uaMwfPb2miGEUD37H04JZDpcdNU20O+GB5LphY7CrmU90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AsAlwxXKOXW7Ow142/rf2GOapaFidwwOrCt8/DpTk8=;
 b=KOKRr1DS5WYCQsg7rM8NhoIWkW/IqmkkNUBmnalN3ciWNLD/hvrXaDyRjAdLtSe8XxGB1YXqL8NgHsIrZk+GTO6q4Ax8mVV+xFzUSISxEayi8bwVlF+7IE6s22noTConGBQxL8iHrZWir2WGwmzv5mwuC7iaPkyWI5nrq8Zc2/T27xnMwejPvzRZFX34BDYxfAMCVJM2VvaZBjqWXFnHODdD0NCVVP6pzHeO79qI2ccSC0hztXbUXcz+siu6r5Du4SGQ28gyTAXuMPwak/vKvMImb8327q4EdunfMWk1I/Z9oFCWxeX3DcW3lHKaE3ENJzrqlw4kvpFQtXx+8i8oQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AsAlwxXKOXW7Ow142/rf2GOapaFidwwOrCt8/DpTk8=;
 b=NHeYXAtvWiKuyjuLHyYaHkSNL2Y+XptgYaTrTGl64+0/ujgS5KZugZuCH2i2S18ZPiyHL8+St4FmtoFb/GrH8jPlnc0yn/n1vi70/bhRcYpTm4re660+fNv23coYtUa9CajcU0H4UHBnBYSMM2p+HXUBxD9rlj3r+tiZ2Xwed1lt6DBEnf8ae5viAOl35QG3Y1IC0tOC8Fvr+3aiwyfA0NpUv5WSfQsiD/MBh6W0CEfV75h7VzOcmD6mtbi/iye9rv9S4WM0VztMCpuBDcIcoPmmMsaEkVKVu6mfzyp2jdZ3TnRWcsi9kwYx4Ccyq+GD7Q+dJmvQfQcqQSZroTAUTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Wed, 20 May
 2026 06:41:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 06:41:59 +0000
Date: Wed, 20 May 2026 09:41:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] mlxsw: minimal: Use named initializers for
 struct i2c_device_id
Message-ID: <20260520064149.GA544328@shredder>
References: <20260519160721.1597568-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519160721.1597568-2-u.kleine-koenig@baylibre.com>
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f018854-fd3c-4971-f6bd-08deb63ae4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	WzE4yeyvmYTFLTMxMXTPIzWqP0G12fIsxBu4cntSc/jE6bbxmwbYZwuEfVfMUNsIQSMKzWM+E/a2jNF+P1Jt+Qyh+jYuaRoTYPEUIj13tU8mipAH5Gb2fdBSBSWHkqpCygyX+PS0y2G8VCAHvpD2vv2Solxllk5+mgjiGsJxKAdX8OAxtBB22mRakMqT/OiZomar9Uy7IXcfEqSjsL10fbc0QYnKNVDY71Ifjtd8sZywfCM896XCYvSvwbHMqmuq/AuJueqRVW1oqFbh0KmpwAlcFJmnS3Pbq2x5dunmvPi9uz9ONAaP8EshHYaOdz2d0O5N5tJ+T+bkHfuZn3YGXHh7OzLdwHfkFYLIfqw0DWZjtS/6B05NBGSWbvwhDx0ZBA1CkHeSw3wVpyITVXut5TDp7xmZR7N7VFfUC6MeiE7uDMkRwCb+ThVFT0Gy0/d3JdRIl0PCFdy73MVadU2Okd6OJsXZNCtxn3izjAkptVKTpoMNzeEP5VMfDK0IHeMrh5rtc3p1ogDpXZRdKxK0yi3lN7mv9c006SIkYLBhJKBFzAkUTewO1Nj5jZMCH0q8624S5rS05xFYcjjQBFEHDnswkiChuJOAOiX5QjKe3UumRpDd543xzCiNT/N4Q3lwVeH4jPHqxq3KSauIrHkgRe7obg06tboEq68EqOZURpfBe6GKFNIhmI1l7dWorEKE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?2960py+JxyZt2tUHtVapmmaXkkzdfCriWpLDxBoFvQmqsfiptn+KSSJaOC?=
 =?iso-8859-1?Q?YKFPp5rwdYF7q6QqgfFtxGBIerMfoF506eCoGoWGGrr5pchOJ5q28C57HK?=
 =?iso-8859-1?Q?8irLdOIDhd3spajc2q+XOcWVcgfMeZmHbOvSe6dnn2sQpTPEC0sBHZw//s?=
 =?iso-8859-1?Q?pd59cFfrSY6TfH5I7J8xkKYxFu3pJCvPT7N6RHKYKt0XtcoEoenWpllSZr?=
 =?iso-8859-1?Q?bpZqs/LZZP2DusPMzOKipgZLvAcZleW6QlIuk//7VeEG87SPMDTE6ZjKe0?=
 =?iso-8859-1?Q?42A20CwD38u/EfKrCcA/l0xCqiQ0VuI93dNnGjT3qkJQZt7+0seJnOvpNz?=
 =?iso-8859-1?Q?S0dzFUQPiXudsNftF967s707f7cDbgeh+GWBpXoGSPbshvl6Fh1TsXCsvP?=
 =?iso-8859-1?Q?sS4suFBnsPHFgzpG2g5UOiB7MhQWEs5pTPTE85tWI+gpknzqc3k33JrPSv?=
 =?iso-8859-1?Q?m9m5lK7hQf3C6y0MLvRyR6vO6oj0zK+Kpxhatn7i+kyTJkHFgdvtVCThWi?=
 =?iso-8859-1?Q?mYotFZxfOGF8cMgBDaTUSCyzWNt4Hx5KgW++XBAkwcbJEcvc75dNFIRN6b?=
 =?iso-8859-1?Q?ToOnUohionzN06/9ihfzpZDnNKBgJdloGn9Iu+zC8yAtPZj2/GBabP+oK4?=
 =?iso-8859-1?Q?wo6k71peuXGwzNhPkagQJoIRKdIBO+5/RskZKZajHqDgtDA1anDz9X48LX?=
 =?iso-8859-1?Q?Cipf8rAqZrFObutFfk5/+ZQpGnD2ThFSr6bFkeYaan2tchOlZqRIKCPCA9?=
 =?iso-8859-1?Q?WV17MJtdaKoebNGi5rSctYAf5luYELaLBXlj29D0ku3AEE8ERi8c6G0GTQ?=
 =?iso-8859-1?Q?QIIBFlVy1qFzy+8DdqbjNXgtVbGVsoNQDHSncloaKTEOMujAvPdYWRl28c?=
 =?iso-8859-1?Q?GPJHH/RmY5OdWCIEZh8FtSuGPehZbbtFpHApdCcdbiroYy+MvdB766075Q?=
 =?iso-8859-1?Q?FkoFy1wPaep51G26h/XJSkfUa0Ml4ntE3J7tqzeHelja9qPQrd1Yzaa4Lv?=
 =?iso-8859-1?Q?l3fggexZ8Z3Ftu7b2DRKFARVCroR2mQEUF4CxMiBUT9dRos+3PLVUL3YDi?=
 =?iso-8859-1?Q?3vTn2rr4XHt/uCffYR+4c+PmPNp0eQxCGtWyeKDx2qYlO+1GBIuhYxAibH?=
 =?iso-8859-1?Q?OFCmVFr41Aw+IQSPw9HOe+h4MI2zUtUjMxyNojy10i5hzzQcWJg8in6DiS?=
 =?iso-8859-1?Q?LKKuoq4VxahilGvAzLS1VsXyQP19Fl04nOVCnV4tgYRUHtwPCWbBj7akOW?=
 =?iso-8859-1?Q?n+/Xr1iNIJEEReYGDdy54hiGYejm5sF40CX721aDWo0O0zmfdsQiDLOiDf?=
 =?iso-8859-1?Q?wXZdCEebjk4UjJRdmpe/ha2K1NxBJGr1qLjYhQ4v1m7DehqhmjSeQJfxo1?=
 =?iso-8859-1?Q?pQxnJOjp9sqscRftZcCnV5nJ1tf9zHaJQzDujA1x9WWhl1ZHWkV+7l50y4?=
 =?iso-8859-1?Q?R8iPegtgWoYCWEsbSVz/XnfIM4Wx8l2HXO0NS9CEgoVDWITaeaW46KU9M8?=
 =?iso-8859-1?Q?xuP5W94ANFZWEk0dQaHvxBZbjC83MnyHp5RVV1q61ylmWi3Vt+Mns46iZU?=
 =?iso-8859-1?Q?TJaVvXzmEIeLXV+44FgoChqQdUSMcVFUzJ0bxUJmYA3iP5WsT4nD4fb/Sq?=
 =?iso-8859-1?Q?Pb7mcJiyccPBFyGxhfpQ8RupdoWUhYLxmxylL8IqN+gaTGEuXjrUn9Zp/Z?=
 =?iso-8859-1?Q?iJ87Kpg9xjCjvgQmJae4GZQOvZrTeSNGHL91pHHt3cIBlVqK9N0m4QgeCa?=
 =?iso-8859-1?Q?q6zE4IHkaqMgW4TusxhRhV051BO7Z8snG2pc3tPU0WPvez?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f018854-fd3c-4971-f6bd-08deb63ae4ad
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:41:59.6121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4kAahCvBXEjXTBXhmWYwID7Cve5gj6Z/XOzEYUkc61jKtTTNr7CnDCt5LBfYBvZL9xf9yAWwhKKuArg4FbE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289779-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,baylibre.com:email]
X-Rspamd-Queue-Id: 746EC58882D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 06:07:21PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> This patch doesn't modify the compiled array, only its representation in
> source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

