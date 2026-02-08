Return-Path: <netdev+bounces-257840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BAgBze1iGm9uwQAu9opvQ
	(envelope-from <netdev+bounces-257840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:09:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 921811095AB
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF46230125D6
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66082346E55;
	Sun,  8 Feb 2026 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KgyM/CUK"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34597258ED4;
	Sun,  8 Feb 2026 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770566931; cv=fail; b=IbS5/iGCKW7oh6X9LEiwOuLlw7J7G5GmGChd5E7RbE2moQBNfYSc8vtFWKuH+sTcYvznLEbab+QKKW/dIZoxN3kYsV5ndpjlScDY5Ld2yOqYqZdTkkFBUp9yGu1FjdiQmTQiA2rF1TukY6s+/X3+ziTmdpERJ+UuPDBcaLZBMMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770566931; c=relaxed/simple;
	bh=UPIPjkgPJnSxWDOuCjP9Z0FYk/4oYCSEF26bJalNWOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TJ62wQrBi9r+Uj7ynOkCvQRgXkcFuuY5jNNX6RRgWCoKzNZaniddSGXCqbdGWZr1oEVnEFCtx+jcf4kgdBfZ2Ddp7/FMqpqQ1UYZY+6Iu+9SwlsG5aRr3EZjmfHOQUXhiWf+9IeJ5+Yz8JB2NUSXlT+zze/lbPYmyO1jktRs+jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KgyM/CUK reason="signature verification failed"; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XucnYvePaPtvPxMi50ngze4Zp7Vr7oyEl9CracwI7olTeLacKieGUgNy6EYqzM2z1BP9oMYFFrc+vazwugfmH8EDe+2R6xDs7mLxLhrkUU2Xb+bQUMk2TpTaSBFyJsJt5ps5W+CgulkeIrDbjZ76yhgkmH4qO+89Qy3OswoWB4T8fFEAgrfeKjVp8sPkTFf4slSav4vc4xNiQ1Q3fc0i9vjgdlFrwi3Edt5AuTWRaibF7Ho+9Ydt+ASR0LtffoCTVddVCdKwW9S0wJn12KWwSBykHxWw/1k3TZPCT0ZLtUzc+2E+fr3t9ClgKV6kVGkSzdxZeFt7CBKctfx6K+H83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQYJ19t6a8JeqZw88vSkxkJON5AevHDO6D8pqbRl8lw=;
 b=EE4I+r9m4Td68Sf35tWoesBh7UsPeRPEF4Upbj0jopKLXKu+mBhGXiUwhRyPbQ8q4iayIrAj9RKmQwznEb41ybIchZcnRD5PZVUACZr/J6cBgAC81VG8yHb2aqHx563k3I1TyqF6HFQcsk68xZY3WgDanazoQiR8zYz+8btMGgfVgbzwIvu9uHVN2n8Yxmu6zIDSFXCLmvmYYLbHE0ESEO6utdb/0bFFqqKFjBpWyeYsaqT83Zq6l1wDBs9EOGO9ajY1HkvzSFW+DJcwDDszwi4JjdZ2YwEasZj0ezeHz3kL27xzJi86WGSAz2a0IjsxBGjnXilgkYk3gFirvPIs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQYJ19t6a8JeqZw88vSkxkJON5AevHDO6D8pqbRl8lw=;
 b=KgyM/CUKmIrhZSa7lJ7/QlXLnQ87/DC9fHsRIrFr5aD5bIh9Z8T+mkyXM1xzL7DslmtPHmiQ2rrf4GxRg/4TOjU1UXoQToPxPEUgZoXoAwgWNhydrUwcLdyavMSQ/8fSjVTkbAIsPDp7mTNb7qK/2a/3KC8w29aFnztEDMKgwVpAYk9erDP3dVgcmVuBJeI6D/TBqppUi1k8LLfnpjbS+i4nNilQTrSUnT5e4Xi0iXAAdF2ZHqtWGuY3AzCU0uvInumx+yOyoEyaxlCG2qYPeTpNUMzzSWfheVQsSeXnaqpJT2db36gGd7Zi3N5XuPMRDeX0bqjugZ7+SQxJQuur/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:08:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:08:48 +0000
Date: Sun, 8 Feb 2026 18:08:40 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 06/14] net: bridge: mcast: track active
 state, IPv6 address availability
Message-ID: <20260208160840.GF154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-7-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-7-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: d0287eed-375d-4648-3173-08de672c5818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?JaWUNguVyHt5BDXhqeOuVGuZuAow1LmuKJwzEOT/sORZN4BbU38soiE79C?=
 =?iso-8859-1?Q?WQVaZo4ANtuSKJ1Gd9SJ3VnFOY0g+XjUdxzeubN0P9h/6oYcGtZkvOkDgn?=
 =?iso-8859-1?Q?i+mHLJpx3i6aCgwEew9VS0xLxYlRG4T0YPSlZjFdHQ+BIumlAtLLNxR13Z?=
 =?iso-8859-1?Q?bO0IkwX7AW5NHU75rkImmRDdg/PmzsYod8wQqD9TLeB/bE+bf10RLlAfLY?=
 =?iso-8859-1?Q?fHlc4BGeGfyD4D5QoK39VTQ12qe1tGdsSIhE+7loSeZQaMhyzWdyAQSEYR?=
 =?iso-8859-1?Q?miWRiJ/XIX+GP4g/6BfVxABLcaFweNekVC3hkpwpitFVL9a1KGD94DTGvx?=
 =?iso-8859-1?Q?Yzpqy1gMT1IdunKLrrYbjuuimO9vwXF0l9IlHcA3onMpE+YD7gQI5Clioq?=
 =?iso-8859-1?Q?2XGVnYStYN9LXg2KtJLp6Cj/iWEd67sUVneUlkY5Kiv+AODFSbhO+qke+t?=
 =?iso-8859-1?Q?jHM1PGGFWFCh3rzgkqjRjWUZHjhv4R3gejFAJMBsgEJkwqWW0wp33lpayz?=
 =?iso-8859-1?Q?f6uoN0oRFsXRXXvRiL5WpXRQPIlKK1TQHOJrTHWPNHxVRqO2u/EYCuZfxJ?=
 =?iso-8859-1?Q?rstnA+w2Ds4uRsYnnqiAf7rRKnhELeYDdWBeKCfTSZd0iV8CI1SCDAlDmm?=
 =?iso-8859-1?Q?0wAeYkuF074rDKeQZNLG7zy82yo+py7fMzSCBN8dSaNfQVKtp95JUH1hha?=
 =?iso-8859-1?Q?h+GPIfOHMnTbm6FHAJQRdyV+mNTLxMhH9Q7cWJpuOPmunlqJ5ts2hKQzCt?=
 =?iso-8859-1?Q?3XuQLbJMFQxUMPjJZl0x4Hp/1vBVU7xFMsRUlHEUc9nQPRl9KOjDfrfMEM?=
 =?iso-8859-1?Q?3souqmipRZtNalXCSW+t+BSPXqV+lqa2DZm8cRSOiPPJ1sU7r/MLptst8s?=
 =?iso-8859-1?Q?aTH9nosVCE0f0hhRIRDvkOa6+HOzhcKzg5yCj+80zucGJe8afQ+LJPw+g0?=
 =?iso-8859-1?Q?ziEqY7i38LBzLyjxsEPwyJm7VquPU5O0shumwQJGNoaEcqmDM0dtefWSoe?=
 =?iso-8859-1?Q?UlhSyrAMxGbfjyL0B7tDdTUHdAJCD2w6SChwMZ316wg+wv9SSioviWEX4I?=
 =?iso-8859-1?Q?xPr53B491/IQvwYqCKZ6FdpEN7s5rQO9TO2Ai/y9cL6reHDIwlj24ccs3o?=
 =?iso-8859-1?Q?3PK3lnCNa3/OAFGjvrk0j/lCbc0CVmhijMLiDPwg7F7pwJWchuvVPiNaO6?=
 =?iso-8859-1?Q?qTo83s3qSkX+LRvmCjcLfLuxpqjFsXZvdtqfpX+HDXIEVbO5hTp9e/iRuR?=
 =?iso-8859-1?Q?oSA4zwaK7T8Jb5dUFR6W/R4I9s9SluWHd4Bf6OAOIdmfbTs53UGj7KNR7t?=
 =?iso-8859-1?Q?rL0AxrskpHXRKzpzp7TR8V3x17uOhYYZP9F7A2+5xGmnGrps3nbH9k5Bto?=
 =?iso-8859-1?Q?D8CCKbSVMLXY7DRJnW8PBfekLu4D/iCjcFnA+GpYW8MX6etj3FQCewuvyP?=
 =?iso-8859-1?Q?fINHWLC/ggE9gwp3BsZU+2Wsdt4QSIwZay1qMkTBT0TzYkcLhoO0YBp/9U?=
 =?iso-8859-1?Q?g+V64HEdkmDFChcEJZZlfe3J9Mfa84SqvpzGw3aRumYIp12YNUMiMpFWcr?=
 =?iso-8859-1?Q?7G0NyYiTGBOzkJeVkGa2XkvryImN1tQpNlD5atBpTorH5ds8NGJdldF0jd?=
 =?iso-8859-1?Q?0+AwRBs5+2Dpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?6kRrzXv1fGhQSfllMFsTE8uzLHDSmCbxEUlRcPXTkL0qI4mH9XaO3RTKMV?=
 =?iso-8859-1?Q?6y67t5NR6/TCyzoArFiH7/vq+lY/ao5R9+HUalvQZjB1mNKanpp7W6ohtu?=
 =?iso-8859-1?Q?QDzWW7aERwsQb/Ji+alArz6mqlckVlma5IkIXyLy+/DruS8DkFzwQhhO7c?=
 =?iso-8859-1?Q?y5LILwWLZa2T2ZFC9dc4RdiLka3iKqWJg9qb3skASwGG2OBWLwvH+TR7wn?=
 =?iso-8859-1?Q?C6evEHz1+7BVuJgP0Mc6kbhFHv9qdToGyVNYvvlZI4FgRwBO9MA0hDyD1X?=
 =?iso-8859-1?Q?buWc/IX9oVJvXuKWZydR6fmZaIiCfL4bRVe7FRnA3X+tcyflGUZjY411yZ?=
 =?iso-8859-1?Q?fzSk/VQUE7EqD8BzKu5+Nk/sMB0vINg7YmIkgI7FGDloLoSfErpF6f4YpD?=
 =?iso-8859-1?Q?iPe7Dxe7wBu2rPSu6A7pVgRbiCFZustdJp2Q0WOm693JzHjutuxXywmutA?=
 =?iso-8859-1?Q?unEBGAEEP3IygIeP5CkwtQ3kvhnk0BK3Qe+PyGdCUZU9/5BLDFZcMCT38P?=
 =?iso-8859-1?Q?IsSbI5IOk2/fmMuKlo38XV3H+y0vZxnHnMT8CR5D1sap1oSrcYej8feJva?=
 =?iso-8859-1?Q?aE57M/M0Uv+qtMwgTtFFTpP5BSm5QZW8+fPBnhn4kLKDhWgky7DlLqUvtP?=
 =?iso-8859-1?Q?w0oE7UKsZVjPxbjvhpsUgaBawx27S35hcHkA2xBPl85HOvCCF4sVwbTyaI?=
 =?iso-8859-1?Q?edRnSuf9Ga0EYX+WdwIBe0OmHHvMifu42WBQpERK6Zw+76F4Vrcoge6vMp?=
 =?iso-8859-1?Q?zleNTudQFuDq1fi2YpfDhTw/80LvGjc3v1vdwaQFot5A1XfBk2R9S2W6CT?=
 =?iso-8859-1?Q?GPxMFz1ce+uwO+a3oyVDCEfOjgQgZuDBU61hRAtf8ZXqlfFVoSJIgW0v8n?=
 =?iso-8859-1?Q?Du9Xk62MtBrXkdDJqhYQ58bbsAxTBGCIvzZPP/gYvrJ2I96I4whZ+H+4lS?=
 =?iso-8859-1?Q?M5No7xExujKahVpJxCXqV09/+jL+rXn6kSaN5Sb/5WWzW5T/Mduf98x86l?=
 =?iso-8859-1?Q?jwYGCl/uBXMGuuztSCyTCTVM1imgMEo/nv0JzG06FWTa49Bf/32zZvqnSq?=
 =?iso-8859-1?Q?MSlPWdjkW7RDWoRJeXmDoJ8KLBqHoALwKYko+KxBPnOs5pRK09Cwfgj+sH?=
 =?iso-8859-1?Q?ajfT7ylg3bODxDGU+YUj5Uq7h1yWMHq0uu4irT5ESeH8hi4uvjN+zsdxqF?=
 =?iso-8859-1?Q?dzgIu6eNO6bvSOTtQ6e8U1vVzaYIVEq13827tkxWRlR/ARRLnD2eihH4Ey?=
 =?iso-8859-1?Q?ypyAZspueT+AU9VhOHRPAEevP0Jk2IwUbZlRDT4D9jHREn56gkqh2dlT93?=
 =?iso-8859-1?Q?/KEhmDyC67BSWLQmRe74DZQuannaJ1AWFR5mKkIlVnljN+CPkGOq0tx0BS?=
 =?iso-8859-1?Q?5gINBFKPXGiOmembBUa6A0lE6gzfd2NQcc9e98AIRTkOypd1n4gjnAOUGZ?=
 =?iso-8859-1?Q?xi3HfqRLvS7I8EgtINPsFo7eSXB4jzzI5pfcRMi66srI8wN3EgsxJlBTxR?=
 =?iso-8859-1?Q?hW758X16iUjrwd865KRpktFRvfK76OUOf1eoh8BnV2BY0orWCO5Y0ygpMY?=
 =?iso-8859-1?Q?uT2m8NDSNF6pqFFo0IfMtt4FlnmWIrs5NX/YyAU+Wk6/QqcXbk15bb4D/X?=
 =?iso-8859-1?Q?uNbzkyfTCmL6Ukeb1xmgcKf8dG5QfdN2BFEK8T0X49Ko+iZu5S69CvzPsW?=
 =?iso-8859-1?Q?eUokzSrZu/7faR66elvXNse+Rt39bzVgplkyabUlsfgJDa12CvNUTV30y6?=
 =?iso-8859-1?Q?XTITHCv/ZxEcxPli1UeqLjvnfkGahKwne6MpUnnHmV0DP+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0287eed-375d-4648-3173-08de672c5818
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:08:48.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVpqNPV0rYhLnyi2mPTHQlK2N732bwHOMLGsPRAouYJzSYCCvz4st6FHqeWKAJzplsyiZrWniviOviHEkULl6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257840-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 921811095AB
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:12AM +0100, Linus Lüssing wrote:
> If we are the only potential MLD querier but don't have an IPv6
> link-local address configured on our bridge interface then we can't
> create a valid MLD query and in turn can't reliably receive MLD reports
> and can't build a complete MDB. Hence disable the new multicast active
> state variable then. Or reenable it if an IPv6 link-local address
> became available.
> 
> No functional change for the fast/data path yet.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
>  net/bridge/br_multicast.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 0fc29875db9c..a1cde2ba2a3e 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1125,6 +1125,7 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
>   * The multicast active state is set, per protocol family, if:
>   *
>   * - an IGMP/MLD querier is present
> + * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge

an IPv6 link-local address

>   *
>   * And is unset otherwise.
>   *
> @@ -1222,10 +1223,12 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
>  			       &ip6h->daddr, 0, &ip6h->saddr)) {
>  		kfree_skb(skb);
>  		br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, false);
> +		br_multicast_update_active(brmctx);
>  		return NULL;
>  	}
>  
>  	br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, true);
> +	br_multicast_update_active(brmctx);
>  	ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
>  
>  	hopopt = (u8 *)(ip6h + 1);
> -- 
> 2.51.0
> 

