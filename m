Return-Path: <netdev+bounces-303060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HGl0AQuRQ2r2cAoAu9opvQ
	(envelope-from <netdev+bounces-303060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:48:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113586E2706
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:48:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=TzBthXtw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303060-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303060-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01402304AFD1
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15513AC0F2;
	Tue, 30 Jun 2026 09:31:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E605231842;
	Tue, 30 Jun 2026 09:31:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811875; cv=fail; b=Oq0qsy8FfakfnW5Wg0J9jIz7Ok5TZCfifPTLQ6D1vaC15fB1cz1QRArvYIkbZUl3fzf9oA6V7NtOpNXfMrBsCwL90HgiFYtTdAPvWuw5dQ0+jay/3QjaX4GPejOz34Pui0Hi98CGmGci2OhjpXa0z6ApSYtBhnd1vC7suWDJUQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811875; c=relaxed/simple;
	bh=1TTwfQvoGiPGJz458j1LKmagvc93nFj8jWNiwfHZAi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P1z2rbCFpIpqlOy94c765WCKUN4UDlIhaUTa66GOiipaJo9SGrj7rGndjGLZWHG3zffOS6Xt1jMmbxCDRpIEhP8RoDSknXkfiPOti0qRWaXghzfnyxLJWIvFkSkq46kv4cwYPql3ziyNVdGDdxU2fyTqo3kKD0W/VCHTU9zBgKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TzBthXtw; arc=fail smtp.client-ip=40.107.209.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQU7PL8206Ykc+Gs92VTdm5jGhiI9VRN3uSXOiledgsBfVeOBViCUzOcTISuOBOOGOC14TWDncYC1gLNaSPrA/Mk1sd11GcBXRpqNCvFiopgCWTdsnu8HgJL5MGqu4GCNDVwFrqmsDyfYh2W2rie9Ra2OC83TZyMvSrDk+g5iaLzjCXyNAC4wDcEMeaXaPH/W1SI58vCxf1jwFbizrUtF+vJQb5eOL5VSkXe1WWQa1XxhEL+rnX6gZBUfKTgslFl74EwPqtdxE0Uoc046lBh8S7D+2yhEaGI9g56CzbW6T/eataXWM8gTf7LJy/H5itmzrUZnaELEvdvVZuWYqKBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARWaE9abOEwX56BQJjSbqJEP+pTLmZ6pjC770Pjs89Q=;
 b=BXT/LB+9Aha0csfAxgkA1bf6hI/Pg8SeSLkPtjQo+umsfpJivEJ8W0t7QYBsgFAbYJu7cRZB0ldRL/YTQtkhk9m5PIpucE6bgy5jsqwOjfQPiC12AFZhep/xRD2toXTgEzaXo6WDGPdZq1+BQyrUCQWeXfrkJe+3hf8D8MzXn94dJs6pELUFQLHhvfCI/Csu1LhzlgXIBDDvh2Ft6tS8RQaGlW5123Azk6gUQIE///scTfMJ3HTNQBpUngLNRWe1NWVJ0BkaR3lZjRjYDLAQF0DaTTuRHXNK89dnf7FbfUVu5XYKORtKUVErGB/UDh5JB35IlyNP+KrY5ZlkRw41ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARWaE9abOEwX56BQJjSbqJEP+pTLmZ6pjC770Pjs89Q=;
 b=TzBthXtwYGZjolGJ2hhE+YiXVLDgYIMT87IEDKAnplG+MtdGMkcZGC+sPxJsjCGZeqc0UuE8jUE1hO7XBe6AXrfqY13JW7carpBF1Q682J5qKrBE4TtHeOKrhFGa3Fxmj9NQ2f7ovp+vuYpUGLe6DiaHJNpVq4XD3qZKWAu5UNL/I5xF4sntNSEmVjLILNDgh2tKJmlpBuGaLpIfrYeaU29VXPGmbaLQPLx/pJbAQ3Usxgvzlj6rx+FPKvnvUzdtnDugnqzMHiGoil9vZxSBmAMbxLyEJk0Jgm0jNudi4gBavN67eHbzDy4aT41/iTGlhtZuuhSItmkJzx0AUa5EtQ==
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 09:31:10 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 09:31:10 +0000
Date: Tue, 30 Jun 2026 17:31:05 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, 
	netdev@vger.kernel.org, dan.j.williams@kernel.org, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	dave.jiang@intel.com, Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v29 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Message-ID: <akOMnchDu6Y_Nr_L@MWDK4CY14F>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
 <aj32gUuoZuTUODry@MWDK4CY14F>
 <bde77dd7-fa7b-4d28-9a7b-3f0ce6587bf4@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde77dd7-fa7b-4d28-9a7b-3f0ce6587bf4@amd.com>
X-ClientProxiedBy: TP0P295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 351d98e5-3aad-45f0-30eb-08ded68a51bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6lOt+RtQdAAvK3tbE9qYZMFPxXxxiMTj1dPoMvUIQ0eaIkvbT8aaTmXVhq9X3H42xTaKLHZgzdNV9jEGLRE6jTQV2mzF2toXI3XnDo8WGClck+iV0lj+SzCMmGuZRpo5KeDyNtZmifv7pNtFVXq6OvQ/ouQtLfoM6ZuzH8FmNfjugR0z9rwCzipSBrjSlhAiGYoRrNIMpl84GMrU4I0tzu0qg++NYuKn5k2vjlZqfzm1Hq5RtlvGS1WGM+JzuUo0W4zzKPvudrd+iZRK5Em9924zwv61lgbxPeiipypFX0z1gekYwiZa2gNRXQjhs6Ca2+HGaAsj/ZU0h7Mkoa1/wmZXUgP8V7YrvpEJntOHDtkfCjBiGxgeQz2z51BNHqscwcXJnwLID5z6ZH/rlEkidHFizEWd/wNrRoug/GbZuaNqoSAcImU7Pato4QMeC7CDt1H3pUtPKkcrweqq6qrDUHb1JiK1InE9ukWhCxgxupBFbQYYOHp8UMaNj3Ja95WS6ngu3W7sRcGlL6qOisPoSDv1HZVvj/I9MTW0XKJbARHpmBRjk347I0VKVGpfmwmc+4mLAhg8I6ksrom0yfPeol3I3sfl111SK5cjc9dYisNgupvvp5B84Wv1AO4qkVofXVsmNB+H8/nHj/vLg3oppABmAjWwbPsdLt0VT+8IPg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?riVVRcY4DhNfqDv0n/LmWdJKWBY5WdLMJYSUJfFbnz3kzn4+ffPMay034hzP?=
 =?us-ascii?Q?nukOTu88c4GIhF9HeTAipohxRFo0OAYiEVlcuZXCWKZ1o0z4wtumw5+DOVKj?=
 =?us-ascii?Q?BO8x9dbtt5yU6VGPYBQGwlVTAUmMWoyXkB4LxvhjMePu3KscgCHWqeUS0m89?=
 =?us-ascii?Q?naJU5uphHs4hzhLfrcInOW4G6dt/KhhxtAIjDFXKemwNPcgvKLrqBRuqrTqH?=
 =?us-ascii?Q?UrMztFsj5vtL50f/YUM/AaG8Zyt24lYPHObYqMzEygJU8T4/0ZSFgQVMqkYk?=
 =?us-ascii?Q?3KSdX2J3J5x6CjK1Vw5bujPOcMnG00fYapVaIlu0UkSpUCIhTLdJr0duEt4c?=
 =?us-ascii?Q?xVn5RkFvf3zmIalq6egPPZvQxV8k40Z7sObgfO0Fna+xmQdMyYLnyWr2knJ6?=
 =?us-ascii?Q?qG/PWIGhmg3mVQEVRscgSRovuDy+tlgxk1ZJv6LojIMnVBTopZTR+uw4T/qH?=
 =?us-ascii?Q?7MPDOj66QQHueDNDEhSKN6tSO6h1tbK1quOzlfp+WQyDYn6LqGlf6SduM0Yx?=
 =?us-ascii?Q?DiHWi78+U9HJxFG62eS5AQsqRnfOIezzmDLxb4zqR4sa9Pf7ayoubT+3Mabh?=
 =?us-ascii?Q?UlXbUMleuns3GvtHpTVSB6fm5lQTBedzraep5T6uLmHXstHDfZw+BcS5WeB7?=
 =?us-ascii?Q?34JpiUi2K0HEDZdDeH9H6zFsRkr5GwzgkXV52BgmFq7UY4lFIykmWDHMQGwJ?=
 =?us-ascii?Q?AXGoj0K5XkT93CvPNomsn4FToU7uFHRiGFgHyRVDpihbiH1ACPWr1Dqg9WZ4?=
 =?us-ascii?Q?deIc+mnOTG230fHH2NyuBRN3lKi/0QuOBhJ6Hdj9rVD9rncQijcRC8PrJQSt?=
 =?us-ascii?Q?BjvNmyJGLo3CpAw/bweuXAx+HXjg/JLVOr4UKOKE7ZekgFcnZt8qo3cioZDS?=
 =?us-ascii?Q?O7ZzSSr5/KJC9Q+mj1Tby3atm04uo6tdp26Q5xHiwrrWN+cXl1RK8Hb+COb1?=
 =?us-ascii?Q?9DMnQLFXD7FSZMcxDZ+HGME7N0p2mPN+rcVGk7+zJjP4mD8XqZK5IBbKo0OX?=
 =?us-ascii?Q?Xudm64EwdnYo3rQo16I7hSCYvlZxJpcTLVwuwxOHhLPk93IOuwSXjFsFzftl?=
 =?us-ascii?Q?OhgP+QuIers4Z3iVqqAy9VxaC6zDwH70M10VvLlIXyCJAjnRWSRItfkoNyAn?=
 =?us-ascii?Q?lhfLOUmRK11oEJKEeGH/zYxrD7v6AIyEJHlhYPQ87rsi9P2EIDW//zfhTTp3?=
 =?us-ascii?Q?LDWXd0lEvcSuhUOoC5aqS5h22uLQYM1imtJuJNHFKu/67zQvOWkSIo6aLezv?=
 =?us-ascii?Q?v4JI/WtrbqCzKIJFsXScBZb0zOkrQy86/0cBnAGBqA18+3rqGrrznp2QW0dH?=
 =?us-ascii?Q?HsMuSx2eh8nrqhB9UOtmnTtzznpAYdYERKd4OKxfGAglL49zD6l6EfP6T0gl?=
 =?us-ascii?Q?jnFGDzp+GEk4z8G/a8v0ZLb0RZiSMn3NjOnlhVljptBC+TQPUDmyt/9K8fog?=
 =?us-ascii?Q?cq3Y728vHgSHz3Qpo9W5NXgdUipJfUiZrcrEr3kQ5+Ho2dPBcw/BmLgy25pv?=
 =?us-ascii?Q?fR/fyGpGmBUEV3QRP6BrN2Hk4pyTXUtNQt4WT1vBDwKonX313YgVVhipeJ/9?=
 =?us-ascii?Q?RqO5sFnfJ4/iWTBRtTsUKsaWeBvkUi/dhwI4HNT7h2K0HxEvPpG/1Pj7+8Cf?=
 =?us-ascii?Q?EPTVfnbQ5miFwiEZU47o4C5UXxZglvXFca41yjvWM5Ov6lfY1GF7gHTms7bt?=
 =?us-ascii?Q?9234MUxPT5/W7J6CwjhlPo4TyIWmw2H9D12/Cgh04USIKtIBNwnIF6osWp98?=
 =?us-ascii?Q?/2oVlCXD0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351d98e5-3aad-45f0-30eb-08ded68a51bb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 09:31:10.1228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5roCaQCop5iiQaoDOoIwIWbvNRFZQEf9xSrUHkCFtM8UyJrvoDhWRUD4G2p68UdL/E1zY3rqsMCsES230fe7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303060-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[icheng@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alucerop@amd.com,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:dan.j.williams@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,kernel.org,davemloft.net,redhat.com,google.com,intel.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[icheng@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 113586E2706

On Mon, Jun 29, 2026 at 02:20:03PM +0800, Alejandro Lucero Palau wrote:
> 
> On 6/26/26 04:52, Richard Cheng wrote:
> > On Mon, Jun 22, 2026 at 01:40:09PM +0800, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Use core API for safely obtain the CXL range linked to an HDM committed
> > > by the BIOS. Map such a range for being used as the ctpio buffer.
> > > 
> > > A potential user space action through sysfs unbinding or core cxl
> > > modules remove will trigger sfc driver device detachment, with that case
> > > not racing with this mapping as this is done during driver probe and
> > > therefore protected with device lock against those user space actions.
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> > > ---
> > >   drivers/net/ethernet/sfc/efx.c     |  2 ++
> > >   drivers/net/ethernet/sfc/efx_cxl.c | 23 +++++++++++++++++++++++
> > >   drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
> > >   3 files changed, 28 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> > > index 61cbb6cfc360..3806cd3dd7f4 100644
> > > --- a/drivers/net/ethernet/sfc/efx.c
> > > +++ b/drivers/net/ethernet/sfc/efx.c
> > > @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
> > >   	efx_fini_io(efx);
> > >   	probe_data = container_of(efx, struct efx_probe_data, efx);
> > > +	efx_cxl_exit(probe_data);
> > >   	pci_dbg(efx->pci_dev, "shutdown successful\n");
> > > @@ -1242,6 +1243,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
> > >   	return 0;
> > >    fail3:
> > > +	efx_cxl_exit(probe_data);
> > >   	efx_fini_io(efx);
> > >    fail2:
> > >   	efx_fini_struct(efx);
> > > diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> > > index 18b535b3ea40..3e7c950f83e9 100644
> > > --- a/drivers/net/ethernet/sfc/efx_cxl.c
> > > +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> > > @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> > >   {
> > >   	struct efx_nic *efx = &probe_data->efx;
> > >   	struct pci_dev *pci_dev = efx->pci_dev;
> > > +	struct range cxl_pio_range;
> > >   	struct efx_cxl *cxl;
> > >   	u16 dvsec;
> > >   	int rc;
> > > @@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> > >   		return -ENODEV;
> > >   	}
> > > +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
> > > +	if (IS_ERR(cxl->cxlmd)) {
> > > +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
> > > +		return PTR_ERR(cxl->cxlmd);
> > > +	}
> > > +
> > > +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
> > > +				    range_len(&cxl_pio_range));
> > Hi Alejandro,
> > 
> > A small question here,
> > Is it possible that the FW would commit a region bigger than the range ?
> 
> 
> Hi Richard,
> 
> 
> Not really. We are using the minimum size for CXL mem, 256MB, and it is not
> configurable. If CXL is enabled by the sfc device firmware, this is the only
> possibility.
> 
> It could be a good sanity check though, but I prefer to keep v29 as it is
> now ... Dan Williams is happy enough with it, so I expect Dave to merge it
> soon ...
> 
> 
> Maybe as a follow up path.
> 
> 
> Thank you,
> 
> Alejandro
> 
>

Hi Alejandro,

I see, thanks for the head up .

Np for me then, thanks.

--Richard
 
> > The committed CXL region length is never validated against the PIO window size.
> > The legacy patch sizes wc_mem_map_size to cover the VI-strided PIO offset, but
> > here we ioremap whatever the BIOS comitted and assume it's EFX_CTPIO_BUFFER_SIZE.
> > 
> > Maybe adding
> > """
> > if (range_len(&cxl_pio_range) < EFX_CTPIO_BUFFER_SIZE)
> >      return -EINVAL;
> > """
> > Would be worthy ?
> > 
> > Let me know what you think.
> > 
> > Best regards,
> > Richard Cheng
> > 
> > > +	if (!cxl->ctpio_cxl) {
> > > +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> > > +			&cxl_pio_range);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > >   	probe_data->cxl = cxl;
> > >   	return 0;
> > >   }
> > > +void efx_cxl_exit(struct efx_probe_data *probe_data)
> > > +{
> > > +	if (!probe_data->cxl)
> > > +		return;
> > > +
> > > +	iounmap(probe_data->cxl->ctpio_cxl);
> > > +}
> > > +
> > >   MODULE_IMPORT_NS("CXL");
> > > diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> > > index 04e46278464d..3e2705cb063f 100644
> > > --- a/drivers/net/ethernet/sfc/efx_cxl.h
> > > +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> > > @@ -20,10 +20,13 @@ struct efx_probe_data;
> > >   struct efx_cxl {
> > >   	struct cxl_dev_state cxlds;
> > >   	struct cxl_memdev *cxlmd;
> > > +	void __iomem *ctpio_cxl;
> > >   };
> > >   int efx_cxl_init(struct efx_probe_data *probe_data);
> > > +void efx_cxl_exit(struct efx_probe_data *probe_data);
> > >   #else
> > >   static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
> > > +static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
> > >   #endif
> > >   #endif
> > > -- 
> > > 2.34.1
> > > 
> > > 

