Return-Path: <netdev+bounces-273476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFpjFl9ky2kUHQYAu9opvQ
	(envelope-from <netdev+bounces-273476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:06:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4357D3645D3
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FE9E300B9EC
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 06:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939F37CD54;
	Tue, 31 Mar 2026 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jrVsjYzS"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A0137BE85
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937176; cv=fail; b=Z5YQRubRi1/5ApIeo0fmyeKB5ObYk+4x6djIovfTzmYOwoa3hgkqBveo+212RVXiIC+TJq7srO/PkQUbO1IJ47V8QLguieNEuiS+65+Jj5E7DlZSCn+8wVahMCSR3sK2mQLCVTE7Rb4OnUx0/Binv0cuHwKvx+ZvQTxviG/X6Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937176; c=relaxed/simple;
	bh=iHf4OGSxjEfb4iGG9djrymR0h2ONt/MHdI+o0oyqwbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A/G1w7x9LuZ98gUSYGcORzTx48TB0VdDL1BSAknlW3dli21oBYm55pfhLZlUNoncX+2xWFcFqgkTEUl3JX27SDx7aZ3L0KObCRVgcfY7jHACNLJTaLOoMutBYOi36KM+HNfOhDxzk1ylbD/wafyfa096FyEoWfnSKYTLWY71awU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jrVsjYzS; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHaNTzo0yaaeQq4fVCT3e4g7xZvVn1YM/nuYsvYp1OO3v5c/kP0PjQR7uQm+ndN9ElmUM6xNgGHf5CmXQ7Bo1Qr3hcF9we/EvYqAJHjmzHHOaMA8IHDeNGvWZHSfD//frxhDpBEbUP3JVdB4CFaOT9VuGPi9R5M0PGYNfZsMX9kiJI0ZF5Vz1MXghTLzare9h+wqeJ6lgvfP32YifniLU30i2dK6eaT+86tgFm8Bpqu0H9kGhlcINYg7lv2ZdkafuJAL8gCDSqaAa2YnsjlngbCIJi2xln5O+Sy7UhI+iH+Ee7wU7MDEO5MgUsjjuH5DQZU2aPJTEXA1Y/j0hGf1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc+hnxwp6orkEjsfCMaOJ+EWXf48bWB2NMwuaDXpflA=;
 b=vanoaDSwOq44iRJ2S/yQpFMNyUZ+N9oK1O42+/kd45/yoapKq+N/cSC2iCpSL4Nc3Ewswy6I77lvU2rAGwQJKJBbkCCu/QbQ51VYrB6Qg2ot6+D67qqFbCp+j8B+NHCG/6VP+Np2h0/LqinKsjqG28c/Dx023Jj20dkztzRft0bkWDrWkNE3d2dasPUnbuS54CMfCvyArhz2OAmmotpuiJxKfZ34aBsl/q/YQ9DHmwAQTeIxI9ld0I2V86i08HBRdoKJcIRlKKZZ92jQ0SIZrtQORMiNSZ6qIcC8jww4W888nRfT94g8Mp3rIVuwCbxmuze0X+2s6/jcNI6zmLL1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc+hnxwp6orkEjsfCMaOJ+EWXf48bWB2NMwuaDXpflA=;
 b=jrVsjYzSMA9ZYO83qAsg+t1Fb3RStHuuW1mPcZM1u/NLtku4azQLrgnwYy7Xx2GR0Emlu4BJ8awmVjZLw5HMEfkjWn8tyz3Fd+i1Iu/gHucuUVhEx0Yb5aaKiGPmYylGTFeGGWdWxx5PYCjkedstClYO2Ynk0KZ+GBMqnDrksvO0KntYem96FG1sUntjJoipWZNxe6+TphC7IJnjk+1PA9+fq0uQXxEUAJda5b2JPyE56diY6951nKPzbn/rsmrz2/+jPy1HosO8nw3tKGtJfiC5CcZY1IW8UAFlowk5T7oSlKAOya3qbPBrYXx4CcHLsC7p+eHbP7pnrW4kMZffiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 06:06:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 06:05:58 +0000
Date: Tue, 31 Mar 2026 09:05:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, horms@kernel.org,
	razor@blackwall.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net v2] bridge: mrp: reject zero test interval to avoid
 OOM panic
Message-ID: <20260331060548.GA1500621@shredder>
References: <20260328063000.1845376-1-xmei5@asu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328063000.1845376-1-xmei5@asu.edu>
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f66558-1fd7-43a1-7f4f-08de8eeb9401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0DO/h5ux3Cv/Il+ufgKNSSbFoUpk8ivg16YH5DEjapyOuejZXAllWckg1kp8cz6bDogO5J3Wsyp9/YJpjBmzzICnKF1emFQTPOOYKmATysT79FVofuIPB8DoI19aQKDsrrKuw0byC+p2v9A5gPBR7Tg88UC8S0vs+sVeQHrkc+gKcnnn/8FrNKN2B2bFUR7cRBqQv+zP5TM/YZvZpU+hchiCceER1hDRC9iPl+GJG+dNwujvbtpqbQgmnhODEPK6QrgRR6Uwbj+MpEkyr51wNERBWqL22C/dLJ8zcBBArWe7U3yXxbkDERoi9oUlV356yMhty/W500VpD0Ey+eSsOqFugQ5wlzNqE/eaLdjo7hl8mCbmhYlehQZHhxOvAiM/OG3ka1HXIT1qr3qphDwHwok2Ws/i4eXwDqIKHax+BUkODD4gGNnVutNOgIWLn5wT47qQOk0rvsJQBi5Dyg9t7HWGC1ldRlc0NLDz42akKIwf290B9ZuSAakz257GDraKECHWphlIUkdfoM/KR/xVDR2X6Gb4rnoKUIjhvcHzIRDbpkw3YhVVUxhKJWcuRISI71mZAC5ooPZa4Aiu7D0YNGzy6T+o34daSklIrKkLph2G8Bo330BpQJZKHFMK1T+wSoYo4sFtIyxt42Zf+8D6skAx9qPWUpeSJhmXioYd+1Fg91vpv0lfcEZdhMWZfHB4eOP1dtohcehUdGzRsr9mtJX5RhbSCsG1TsuiEh27U2E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pgPxC+XE+Xji5PJj8YVGqHGvvzqLtFTmUCFdH1tKdsyi7iOE0dbbB21CWlns?=
 =?us-ascii?Q?Nn6I+00ClLQN8U4sZEijbRNe8rtCIrH0vH37Cskv1iTrSajG9Syprp+5KitK?=
 =?us-ascii?Q?PDVZG2mZt+568q8g5ZohtOdIKsDEeJINGUmMeSjxIbWqG3Vjqwo8OqSGH7oP?=
 =?us-ascii?Q?SDi2eZLoxxnaBvDNMJmfsrz2ACbR10WZBesTJ9I41HmnbErIyUSrMKwElljT?=
 =?us-ascii?Q?ljhAyJ+GimVahnLEDNc1QctnY2FHRCGGEH27YTYnXx59pLS3pyjFHMneppKG?=
 =?us-ascii?Q?vSMYk42GRS2VXFRe/zQx2E8sleAgndaBWULvgdqGfXKiN51anPZoTEyT19U/?=
 =?us-ascii?Q?zQmW47G8ca08zJxqg/0HWoOdD6UdotoezjHNwynEs6swAZLZZMUyBY3Zroa5?=
 =?us-ascii?Q?ikq3czpyWSZZzSyMotdCh1/9+50Dn22+jjyK3ebwyuPAE2r+GL6D7hNzxWIJ?=
 =?us-ascii?Q?q/jTBRB2dUcyyWyz0gveOyoheQIl7hH+LBpzwbDelrECOprh3oxCdNQieZxc?=
 =?us-ascii?Q?kLqHIIblX+hcZjPCCvzfRZweHzmr1pbJDbLwiBXFVhYQlNOnGZvfLRGVyJRC?=
 =?us-ascii?Q?NoVvlUA5mTG3todEKTiM5JBArieLjyMtqTz5ole4acExB1olUPfpuiC8MW3t?=
 =?us-ascii?Q?Pr4KJq7sb6k/t0s0drUfsx7LMftRalbtUIrl78O59i7MvEBEyysRPm0yJ3n7?=
 =?us-ascii?Q?Q5irr/d3UBqEomy5XlHsdjf4xPuHvTNgTlc1ITjwrrV+bSkFDZB4TklRmupF?=
 =?us-ascii?Q?rVSsx2Z7HSa6a6CnfGCZLD5A/CipTf1bdd5MDI7ojYGTfRYfORmCDUqB23pY?=
 =?us-ascii?Q?Y41l2UqDEBeRDKuSEsuiS6IkRXEJnlUvcbRA82W6f7vOoXohpMk9dLuc/T2d?=
 =?us-ascii?Q?NlV0PlEYzs65th24PhjlbalQZJL+KRzUf6n5/iP4M9uIbAg2bZwkAPi5Fljo?=
 =?us-ascii?Q?m6ecXC8Ex6whvhCYSn34rR7rDvjzGIOV/koFpmWykDOZCTMx7OdXWfSFUj0U?=
 =?us-ascii?Q?b5QQyY10jVHqn22VJdVJLypYgohEDAVjgA2vQJz+6KxlZhDsVSDS6wa+o/gy?=
 =?us-ascii?Q?Lx3kWDzZqTAZAEQjyywWKkXpnnduV0cIywUDWX1+dzmfkPMwCi4QrEmITKv1?=
 =?us-ascii?Q?vEQxX0y7++miYUUmuTfZfxbmVeQlefo3PjPjhHC1VNXnI7xdYv3nIguvB9+U?=
 =?us-ascii?Q?IyxQf43Mcsde/814H6RZkPKdk7pXE0iwB9nCiPO127SDeIdmy/zlvfXb6Ze2?=
 =?us-ascii?Q?M6d8DkipGSFMUrEQ4JfLvaeYQKapiK4R424Nyzt7UUHDuXFg3tK89D9cU9Wb?=
 =?us-ascii?Q?uKWlOEi+5dGzqZ5aHz/P9Hj4sKihWY3SQqldoutSJdSjKnWIFEIwmBaQdHdB?=
 =?us-ascii?Q?+4uAxC5tC32sSRFpkAqWeI8cYTlw0UX+auMPskA/yGBBJZBejwQ2lEddYwwE?=
 =?us-ascii?Q?pI19UheKOBK2QLczteDF6igNU1A0CIXC8vAI9dZbKkQ7YQdTPKYO/8YOYwXX?=
 =?us-ascii?Q?gH/cI8mNdzzSUXGMg67tVhJnBtHH1lmmo5xQCtOAFJBEoEOw4SahAlPkuErf?=
 =?us-ascii?Q?4o5IDRx0BSfneVxHKy+/DZnEf4k7L+lUy+o6vNjJNzcN2aC20/YtvqScX0ye?=
 =?us-ascii?Q?4mAD3JZEUoj6XBSSRKHlDNxk4u1bwm1jur1Cw837vqCWowlrPNd60TTSkzhw?=
 =?us-ascii?Q?o6pVvIsdYnGOgntkwq9mkX84q4oqPQjWTPZuEs5oU4hDB2vV8S7UIqQ9AGqE?=
 =?us-ascii?Q?sdoZWfUkwg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f66558-1fd7-43a1-7f4f-08de8eeb9401
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 06:05:58.5820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iviO6ejFrhckzuUriLyPbDMko3gGG89VVy5ektpw3Gx8aeRJvxcuqoO0QrfRxrt1BUNX+dfyfKZRQsjTWMUvfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,blackwall.org,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-273476-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 4357D3645D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:30:00PM -0700, Xiang Mei wrote:
> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> interval value from netlink without validation. When interval is 0,
> usecs_to_jiffies(0) yields 0, causing the delayed work
> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> itself with zero delay. This creates a tight loop on system_percpu_wq
> that allocates and transmits MRP test frames at maximum rate, exhausting
> all system memory and causing a kernel panic via OOM deadlock.
> 
> The same zero-interval issue applies to br_mrp_start_in_test_parse()
> for interconnect test frames.
> 
> Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> netlink attribute parsing layer before the value ever reaches the
> workqueue scheduling code. This is consistent with how other bridge
> subsystems (br_fdb, br_mst) enforce range constraints on netlink
> attributes.
> 
> Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

