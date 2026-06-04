Return-Path: <netdev+bounces-295160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZTBYIFxSIWpiDQEAu9opvQ
	(envelope-from <netdev+bounces-295160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:24:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4716863EFBA
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:24:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=E7f8ohdB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295160-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295160-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C8DE306E50E
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B7B35292A;
	Thu,  4 Jun 2026 10:18:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421A1202963;
	Thu,  4 Jun 2026 10:18:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568295; cv=fail; b=ZN5YAGDKzG1HLHuWKLdtzK04SNSbmWxJH8GcuUBpfskzCiEozL2V4HXaMgrUqb/vhhCKMQFZvX0holzb1MpoNl3cdhUHqKiTkgWPUiZ7Zfvxa2MmfV2hJaQX/EqYlF6CTZzMMN86F0tEBvpcfRvI+PCSKLVbk5aY4eto9gvw1FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568295; c=relaxed/simple;
	bh=9JzqbWt7HRX+WCYkhs1mjRG+J8h67nysfecwpl3+h+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tmBzKUIhr7FEfK6sjsc1RxtrJ/0vO26Zwjqw0QCS1DbejbMNTYp038+McYKynpHb0/D1O4U5U6y/tDRUz2OUdmkuxqaPSluwkQu74I4Em7Y09aK0vkuUxf2mHQf7gLk1AVOLFP7GN+kqNkWbDfW5mC5MrObTvctHVrNDikJ/uCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E7f8ohdB; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rpu6Xj8lw9p5e8SMvVpMxCD0xFD9So+psj/0BjP43MQMtAMy0Wigkt3FR8DWZ+jbVLhQMU8WDzYL/aTlRiMB8qDHKbGF2VGmlWRkpxZaBtj5YBQE7ip4Rzafo+00V52Tp7KemQGuW9dlcm94dFHepP5Sr2HR1pTnZcna59JOxgaInJ9VDHPQk4qbxH6zd7PeeNpRufiS6CldhStcT8JQ+MHj+4tfn8XCeSPMeL/MSPUzZjwpIHwiydVuac3yfK8Rbxc2M5BD/6/z2hOVR8XQy12xvXlr7yPXNciNVNOpqxDDoHtVmX8QU1LOflTL5TPllP4OTWECq6pmhJTrRl1FJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCzADedvTwY3rJ6qh4tAUMGe1ySM24axM7+B+qh7Xiw=;
 b=H1aSLADf+QIXJ4xFdRfODgy7n8rZhXVWvss39naJDua12L1iSP+HHesQOpAeM65SLW3WY+kLK7SsysNvvkg6zCMuSUNNKiAT/gYRD2jUxU5txY5vIWDCH026NqYbGmSsm1WfA3KiydpOzZTuazDFIbi4hiMQ9VsrGeg+xTAK32mwXNTzNBhdQoog52ka5T22xNjt79IsuPp6LRP8LZeuBD47/s3eklbECaQ8dw1XmryibW8UfjeJDZfXFZWFUqlBQ9w9ra9fhHP/K3SlVm1yywDacMTj06kATiYrZpMmUDPchAn0TWztGT8NhJqiIiCUhdl3/faKTuHtndD8l12r3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCzADedvTwY3rJ6qh4tAUMGe1ySM24axM7+B+qh7Xiw=;
 b=E7f8ohdBnNE+QLbqBDHTKaSmNhrQZPb1UsbaoVbHS6YPX0mRJmrVmPZ9fUvXXNnkWW8IRWwnDZg+kZ6NrjLn7vxQ0toe76b8OxD/6PpRgR4SzIlRFvyJfg4t/4jp3TNXDFpBOYAFSVx6ixyOiZV5SkurnYLec2BOSUo/09QiJ+5leby3hk2Qc1gFXVk+eW+8ZdTqcXVr+S2FG4v2VdA4uyI1uMRXazjHlvxkvbkIifcu0kbF42S73LOEI32VCxWQ68aBpHiquAzz6V54CiU5lkf/9IULxPkSByG+NhbCOI6fbRagbi6XnFOjFOFUzt3QrLl2KK5DiUBlv8KX9U75iw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 10:18:09 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:18:09 +0000
Date: Thu, 4 Jun 2026 13:17:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yuyang Huang <yuyanghuang@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] ipv4: igmp: annotate data-races around
 in_dev->mc_count
Message-ID: <20260604101728.GA771160@shredder>
References: <20260531030705.3754389-1-yuyanghuang@google.com>
 <20260531030705.3754389-2-yuyanghuang@google.com>
 <95adff35-ee56-49d3-8567-382ac17810b3@redhat.com>
 <bcffe05b-c10c-4a27-b260-e6ae872c795e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcffe05b-c10c-4a27-b260-e6ae872c795e@redhat.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 32acfc60-7539-4e20-a4c1-08dec222933f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|4143699003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Wa9ZyvY9QPpvTmJ+ia2+7lyJ7PtQky98kaoQXAdmwpPllU8bMB0B3DK+BrEwG+qE36E7tobueARteoEizKZAawTrPK5C4QDY1tXCpDjaV+ByOx9DaoW0WuLmYO3fNO4mV4lpZZfRINA+KGWdI4hdBJNR1YctNqZZaN7SA+7c3TIcW97AabtIZ5P7rpyp6wnNx2SR9bR2F4iocM96ez9CrREFajehqPTWCo6e/rOhG5eSQo9h1N3ekjCvnm9TDMFD0KGQaYecdAZ+TEErLNR9ynJpYFQBmcBz6tiewjbDtSc9fJOn6ByRKf38g65BipfN0oTsXS1a2wFTo0Gwd1WyLhuAWYK8lSutxgmiGs0gFGL4OPEd5Rnx8nR1oDiHlM6TqeIRwQSHjh3uouBJAby9vtsL89U4mRey12iP7d9GLDVFK5Fu/MoDR2Ol5M7pe07Xw5POHdmhGiQeE4fOuyrax94lpRToB7F991uMxQy+U3fQAo6YZxYyRGeDZPuqxlLpbiBQiOdMowCh5yayQsbDsepDlK3sHculWp5mXT9e+q2JaE0Y5aRTmvv0eaGQZyPtO9yRyK6z7xIPwqVaZh/Mwn7AIrga5S9yosXPbKKuOrd/ga4eUT9c46CgDMtZz6+g6XOsTIg7ZtpJrplFy8iyGZ3+PcIk6xIbKUPqtY/31rSf/+qp7ugC7N53ijQ6pgEmDErn2Hk2pMXCWHREg8eEZg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gpJvPDU24d8bBNclVnXPYTZwB/OS6vHdhKJO8sWl6rmaefuHtPVMl2QVipLj?=
 =?us-ascii?Q?5rwb4c5H+uCVfPOjb7Jj3Exv+Z79dRIRk9f0Ighgj7zhe3R2pGt0B4rL09py?=
 =?us-ascii?Q?l/fV3iuCHeGUmVdkR5x5mWAq4tNNN+0iM43ixxY7Ff7IYBu3eoosHRawsf1k?=
 =?us-ascii?Q?275/3QO0wVO27LjnjYvUbu9SF83r5u2Hr2aEpbI7D9DGapXiG9tc6htIBeEF?=
 =?us-ascii?Q?aDelpgiMhaaNJCPqO97Yr/mmwLhjNqLLRAwbUDuOArOHTjqm348atcly3N0a?=
 =?us-ascii?Q?gOOyUGQLYm9Z7jy3+dz8ELwbEUF4A+ftRW5zX3/bf4TcidMBxjU2V7D387yP?=
 =?us-ascii?Q?mzB4s1K/4Zg7p51LFxUmtwTq2faZ/7X1VrBgR3OgedXTNaRkV/Ek/q0kkAI7?=
 =?us-ascii?Q?BTb8XIpMKIKpOdeXXMJEw4SwmVRe+8flEZmthzoLCJB0QVL2fCIaS+YH99Mz?=
 =?us-ascii?Q?St3ecnIL690ONNype8Wnx0uiNmHY4Zs3+xWa+JvvuzWSFQgyi+smJNMH1SxS?=
 =?us-ascii?Q?TwD7IzCa7g0ulzpmwHzH7krOpPDP+vZ8C2ueVvhWLaUOj44ZjlMzcWm/szGS?=
 =?us-ascii?Q?4Bbix74vn+U27Hfv96LmLVuybCPuSAc1YpA/XfzStbdC/f2dfml10w6h0WzV?=
 =?us-ascii?Q?PDgeCeNVc3Kzm18XGjXXDqhLQ+Ns32cCKRrxeTZqRNM+IUcKzbSwhFH3mpWh?=
 =?us-ascii?Q?JTuVHtWSUV/WcSXAHp6RAwPSSHNrGlAK0CIc6094wPUYp+i6r7QozhrvE88E?=
 =?us-ascii?Q?XTAEvJacIc3TDbnWtWCUcTzsjeG4IQlfg3jYTdq+1ZL1kyh8VYWbrthgzoRW?=
 =?us-ascii?Q?ogGpxKP/kGsHZJq6E2p6iYw6lmkNh0cf5dP/NoQiuYmUgrBTgx1PvM4WuxFo?=
 =?us-ascii?Q?UdQhupp+lcY9dIjqcRex0Bnpii4CG0rIA0RxyHuAvVGKZeCt1wx32y8/V86t?=
 =?us-ascii?Q?soPFd13Lev04wr5SLO1Yab6UJttIxEmYC4RW3IgAHnA4Et4XruibRoAZ4X7R?=
 =?us-ascii?Q?O3zBczwSt+x6ykbV+Govxp1mVoYHCBrhXMikFszX8uBLDLfTyIodgOx3fGMD?=
 =?us-ascii?Q?rb6j9bAg7QREgOapLoAYt6s6OwwUkK7P/VZLdE2AYfIAgCoPvhLQUKcxKGsI?=
 =?us-ascii?Q?egnS51Zu4NddCIrp4EfovpawPtfK8Hdmw0lpX7aoQEEymMebk+3mHNk8v1I1?=
 =?us-ascii?Q?1/uftfviWWsUGNKA3xQPQf5zB+F7zYZ/sMfjqB6TDPWN9hIThPtos9JPf0vB?=
 =?us-ascii?Q?9UrfpjbWc792CpkWBOgGWUPi20Y8ZU2Wwfv+qEHa+Ri603kPDKy4XoZTJrLK?=
 =?us-ascii?Q?H93/yTJHs5+xGUvwRWhQE5PUiU0z6AqhaTYdl7NqmToMypbGH7mToHAF7ez9?=
 =?us-ascii?Q?o73l9YymLmtmS6igFt/vdzGNqXOEMhDWknDq87LKlM8mPNbqwOy78E8tWFTA?=
 =?us-ascii?Q?epOg7/ZzloBqsyheeWOdwYVdhUPgtrpfOohC4kuitM6U3CYZScckCmRZtgDH?=
 =?us-ascii?Q?K8j8z8eNDNKKmgr5qjnW5MVYBt5CFqteOxubdcRf1yV55z8wR1GYJI8qugLg?=
 =?us-ascii?Q?CzKlVJUpnyIPMD/Tq4j3hZO4+nm/ouErZTZZL+TqJv0I4i7IGSwIfuQ9Xi3B?=
 =?us-ascii?Q?bCK4cLUgB+sciD/hXSRVmjg3lpnzV7h035SvbiWpTA9R+5BhL+Sr0+wztVup?=
 =?us-ascii?Q?hS/WXPxugkfcxf5aiOCzUaiPrLGh3otGqfuodXA3Hpy2/mJxOp56/DRaz7DG?=
 =?us-ascii?Q?LH/fs9fOcw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32acfc60-7539-4e20-a4c1-08dec222933f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:18:09.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBY7khAlmSi2L8ki9NyZylhnD1RkVucUhJaSw6Re4wuxEa4m5eI375NLsSvrs21Jynu8XpXsnXHL98PpJYMoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4716863EFBA

On Thu, Jun 04, 2026 at 11:15:29AM +0200, Paolo Abeni wrote:
> On 6/4/26 11:11 AM, Paolo Abeni wrote:
> > On 5/31/26 5:07 AM, Yuyang Huang wrote:
> >> @@ -1922,7 +1923,7 @@ void ip_mc_destroy_dev(struct in_device *in_dev)
> >>  
> >>  	while ((i = rtnl_dereference(in_dev->mc_list)) != NULL) {
> >>  		in_dev->mc_list = i->next_rcu;
> >> -		in_dev->mc_count--;
> >> +		WRITE_ONCE(in_dev->mc_count, in_dev->mc_count - 1);
> >>  		ip_mc_clear_src(i);
> >>  		ip_ma_put(i);
> > 
> > The patch LGTM,
> But it does not apply cleanly to net. Please rebase and report, adding
> the target tree (`net`) and a revision number (`v2`) in the subj prefix.

Paolo, I think it's better to target such patches at net-next and
dropping the fixes tag. 

See for example this recent patch that went into net-next:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/net/ipv4/igmp.c?id=061c0aa740d5d3847cd600a74c66a165bee1fbe0

And this message from Linus:

https://lwn.net/Articles/1074171/

