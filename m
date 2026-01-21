Return-Path: <netdev+bounces-252000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDu6HIktcWmcfAAAu9opvQ
	(envelope-from <netdev+bounces-252000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:48:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1C5C81E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A787A38C823
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA96A42189A;
	Wed, 21 Jan 2026 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gnbBfGFc"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01F4218AF
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013879; cv=fail; b=u5QSxMovo2qLl93otbLrgJniJoS2Gdc3M2HwvdVjnk2LIXJnlGzzK52zVuIWEmwrjL3YRdEZ4+ZASy5dtpbvC2LJodpapS0ZHZ1urlv1OBuG3iUzgymho/YvQICRdHH71mMTDwpsNM3ijKJgBReiSK9LH6FixQsspo+nnRJ3nts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013879; c=relaxed/simple;
	bh=Ov+K8f5Y1jctjikaI1N8Cm/uIkgSIIw1mqfVJFekoN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dTzs4o3t12r8WbontuXp4zbR61EYa6ZNtLw1of5ppyqa8vuQDy1caFvK5mNLYGCj2HoTDQVcWwahYsqtDHA1/rpwEeLG4JQYdUceZfuLBR+IajL6UoK0Whsnkuwmz9pStLAI3ckKas0eI8/w24v+4wgJD7Pa5uUzRFBmVFKNmyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gnbBfGFc; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbUSZLnq7AT+up0oynA28YPyapxgVuKUxvvkMdbrc5W/fN5RkqNqv+b2VjIHP8eKqs9DlyHD9QU9d/DF66VbzzMdOJ1oM/4UEfIzf0nrQXtYZOFiUKGkSBMRpGdrncqdXaGEBbeREEtWlGM7c2R2q+fMN07lTIFI/B/FSsNkZLbmk34CaFAY6wMvgeesd/84mAswVgEfr91+y9Vji8JydTZ++qXpmyNQM18q1+FywLkNdsTfbomYlsRRyo1ThdDmVg4s6DZ4us8OY8MFNMzyTQgnRHhNZluAlUIdcdcDd+4Gsk6SzX7UBaU4/N9ff3wVFvBPZG0odrrC1YIVyFJImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6nAI+lIeqdYNkm8M+BwxA9Jqmx4IAxdcXtMRSGfsNs=;
 b=XvoTxScuPopz9qgOubxkZkH4n14OIdSpH55zPVaQ9IeITDuBZihPyBaxj9k8F9hssUXQ1EzILW7p/7TsqTx8f106k3j4ksiwZ9DaY+vEHZlBXlfwxFba13vXgEX6wVKHmNUK35kiZqe/HDBI9vYs7HB/vkBqi0qoQ2mSuByio/BHIryWrVGss6TmBc+PEh8MfKwdyFR5IqPcq6p5oLxH3U6f17QLTZQcZwvzcoEw8OaRvsUK2CWHKoJ+PpYaz1euSs6+9EF1r3cYGHeRqSzi/aJaTPuEe396M4nz4FeZfbFDMS3xtRBrX1nBbtNH+0QHLANqLEvJ71zfgmixPaJJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6nAI+lIeqdYNkm8M+BwxA9Jqmx4IAxdcXtMRSGfsNs=;
 b=gnbBfGFcnAEEj8d1R/AjZsgyIte7fn4g7LojlnNIvGfEuwJUCOh7pq2NoHlakHSoc/UdYXHZlwTAIUIaUYmG8S0kH+avvtWQyPn27dYR3sEyCG+0bsNkNUylSINBpL2Lci9MdkOLwHlN3uvGaN6GtSW2YQkk8oGsVS0tdVGS7K2caA+0LpKzXElWp3RWy9mdIerjfsT9BpcbFh0IUy+dvxYFj4lBGWZ3AfVPRTKp2n5T9ntzq8UOiPo8XVEfawBP4QMD67iwFYiPMlOPC9VJXl4lw8CAp1BkCwWAmNSAvBCO5LWZbHpw5jS2c+fYSqv5bdXSO9lcIgPk5mwwBsrHbQ==
Received: from PH8PR22CA0004.namprd22.prod.outlook.com (2603:10b6:510:2d1::19)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:44:25 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::57) by PH8PR22CA0004.outlook.office365.com
 (2603:10b6:510:2d1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 16:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 16:44:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 08:44:00 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 08:43:54 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 0/8] net: neighbour: Notify changes atomically
Date: Wed, 21 Jan 2026 17:43:34 +0100
Message-ID: <cover.1769012464.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2abe6c-e8bb-4682-3e21-08de590c5407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WXGi/EfZhDDa4XDOGKWPGzRAPkaPSRGBwZxW82KqDxzu9OhU/2TKfKSJ0Bp2?=
 =?us-ascii?Q?Sp5cn+kr11btA3gbEqX+qy79Amc6dxIginjkZnhMOsBl0IEi9j+P9IIIH4yv?=
 =?us-ascii?Q?/c8EuybGP8LIOdcOVnacsMv88rLRoTPl+yjBDLfFgSV2H/pWEscuwrllojfb?=
 =?us-ascii?Q?csEIl0g3TlSxJQQ0dQe6P7zpBlhAecLYiiaQ8VLGDoOf8lIzqD5nNtU8D5g4?=
 =?us-ascii?Q?CVJ1fwzZC6+nbh9P1sM2wESfS4Kc6IOWh78rXAbX1j/a9ZchKlcmwdykL4Rm?=
 =?us-ascii?Q?eSOvmMv7FcqRZf0d0GwmtHFo0qAx28xwxaSTcFqfMGVZqkXfp57OZvdxyPai?=
 =?us-ascii?Q?Q1QDim9Z8SNnsq4x1+lfCH5/TqxncvTpQnYhjf4yjq0XNQHzJw2NJBinIwBm?=
 =?us-ascii?Q?gBcH3+tP43gRKN/zksRvoG3qFT/lbczaSU1+a6oSfcNb8Amq9ZmP49S0AQ98?=
 =?us-ascii?Q?kOTRoqxpIt3dCKpjthdql6F86hduKdYu/2nMz+mpegkB8T2rPfzsVkxuiPVp?=
 =?us-ascii?Q?pIQO72zSwPdfnIjeuT2GERb8JNRJsn6mifObjDlgQwCFOhZlsXCOV4LT5Dfu?=
 =?us-ascii?Q?XqFfzdrAR5YB001EkzbUFjOlLVIX5NpI1iPZU7lLS1tZ3Qkwql7i9hhlRhBb?=
 =?us-ascii?Q?kZ5BAKLJ6E4+SO4X4BdgVedzi8sFWJAuWdx9o3qe897Rp85dFjFDTyAf9iwk?=
 =?us-ascii?Q?LjDf2W40rgFDtNOaEf3X3ChmerpgKWL3hSWiw2qDNdwpe83GUbgL3x9KKQgk?=
 =?us-ascii?Q?mVqBGlkg0Zb3mbvxeKJXSrtI38m39UHVNnl6+bxieIL3oS2i1m5509sdbw7+?=
 =?us-ascii?Q?6TXGg+yCwWcsiG0oc9WM0KRLSfPWvYQQkYBXqk+qRGnVU+v9CNcUUdT8QFkZ?=
 =?us-ascii?Q?kvaImuas+gl0btZ5AbE8Eak4MdCzqYdm3ExYXS83V8MXuLJwJcJKgO0AkHa+?=
 =?us-ascii?Q?JbC6YutoLRr2yF2VIVc9shXpZm/X48bJQIgELJBfzWQlgN791i15y9T4A2fc?=
 =?us-ascii?Q?OgkNi4bG+tihH0Gqna4bTNcwjmvZI8e0umeySiG7g5LFLWph2C7C1Z2t5fuC?=
 =?us-ascii?Q?VBJZLIXf7GblyEK3McM7GEbDnw6wePDl4oahubMzEo30ZRPxK52PD0ZWM8/j?=
 =?us-ascii?Q?e7PrMaiTBw8A8Zf5h/Crrw0bkmAAhRb96e5x3vHPNFk/Rv6AXzOPHq1O/ibo?=
 =?us-ascii?Q?+7retIEc8uc9tHvTebgrEvaD0p9v1mF/PepqSqQy/McwhZxtjQuanCzP4+ys?=
 =?us-ascii?Q?KpKzjpp7mwjUC2exZ+FkAlScNfNDyGq1vobRksb4X9NKRiSaA4p9EGhRNLMG?=
 =?us-ascii?Q?yAWaeTmOIdAbEHrr1JuzLiFrowyJkJNlFKvuvv6hkrs7rVat4+9CJU2yiwDp?=
 =?us-ascii?Q?MwASxuHhTUExy5pavAXEuMjLjPNPK++kjy78KobYt7aT/NDSHCgWfAKQkAdm?=
 =?us-ascii?Q?bi5sgNTtUmaWfqvuw3wfdkHzwqzlzhXEf9/QtjDIedD0iouEJWQq/Yf8Qdva?=
 =?us-ascii?Q?Uqw5xgF07T+w2Ls+Ar6BVkwVOCV4z0q/HGvNLLdJ0RfPc93EuFnBGESkajIf?=
 =?us-ascii?Q?TD1Q+T32Zk6tqwcJWxDwOmKkIg2pnEVYF2j2K9HgZhwnphWt1IOOmDaDn6Hb?=
 =?us-ascii?Q?2C68r3S311UekVkqFNpZCJVOjTLsha+qBiAmmO4fiUM5NfTVJT5cjWH5qmEd?=
 =?us-ascii?Q?We1OeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:44:21.5907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2abe6c-e8bb-4682-3e21-08de590c5407
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252000-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,Nvidia.com:dkim];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 19C1C5C81E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Andy Roulin and Francesco Ruggeri have apparently independently both hit an
issue with the current neighbor notification scheme. Francesco reported the
issue in [1]. In a response[2] to that report, Andy said:

    neigh_update sends a rtnl notification if an update, e.g.,
    nud_state change, was done but there is no guarantee of
    ordering of the rtnl notifications. Consider the following
    scenario:

    userspace thread                   kernel thread
    ================                   =============
    neigh_update
       write_lock_bh(n->lock)
       n->nud_state = STALE
       write_unlock_bh(n->lock)
       neigh_notify
         neigh_fill_info
           read_lock_bh(n->lock)
           ndm->nud_state = STALE
           read_unlock_bh(n->lock)
         -------------------------->
                                      neigh:update
                                      write_lock_bh(n->lock)
                                      n->nud_state = REACHABLE
                                      write_unlock_bh(n->lock)
                                      neigh_notify
                                        neigh_fill_info
                                           read_lock_bh(n->lock)
                                           ndm->nud_state = REACHABLE
                                           read_unlock_bh(n->lock)
                                        rtnl_nofify
                                      RTNL REACHABLE sent
                            <--------
        rtnl_notify
        RTNL STALE sent

    In this scenario, the kernel neigh is updated first to STALE and
    then REACHABLE but the netlink notifications are sent out of order,
    first REACHABLE and then STALE.

The solution presented in [2] was to extend the critical region to include
both the call to neigh_fill_info(), as well as rtnl_notify(). Then we have
a guarantee that whatever state was captured by neigh_fill_info(), will be
sent right away. The above scenario can thus not happen.

This is how this patchset begins: patches #1 and #2 add helper duals to
neigh_fill_info() and __neigh_notify() such that the __-prefixed function
assumes the neighbor lock is held, and the unprefixed one is a thin wrapper
that manages locking. This extends locking further than Andy's patch, but
makes for a clear code and supports the following part.

At that point, the original race is gone. But what can happen is the
following race, where the notification does not reflect the change that was
made:

    userspace thread		       kernel thread
    ================		       =============
    neigh_update
       write_lock_bh(n->lock)
       n->nud_state = STALE
       write_unlock_bh(n->lock)
	 -------------------------->
				      neigh:update
				      write_lock_bh(n->lock)
				      n->nud_state = REACHABLE
				      write_unlock_bh(n->lock)
				      neigh_notify
					read_lock_bh(n->lock)
					__neigh_fill_info
					   ndm->nud_state = REACHABLE
					rtnl_notify
					read_unlock_bh(n->lock)
				      RTNL REACHABLE sent
			    <--------
       neigh_notify
	 read_lock_bh(n->lock)
	 __neigh_fill_info
	   ndm->nud_state = REACHABLE
	 rtnl_notify
	 read_unlock_bh(n->lock)
       RTNL REACHABLE sent again

Here, even though neigh_update() made a change to STALE, it later sends a
notification with a NUD of REACHABLE. The obvious solution to fix this race
is to move the notifier to the same critical section that actually makes
the change.

Sending a notification in fact involves two things: invoking the internal
notifier chain, and sending the netlink notification. The overall approach
in this patchset is to move the netlink notification to the critical
section of the change, while keeping the internal notifier intact. Since
the motion is not obviously correct, the patchset presents the change in
series of incremental steps with discussion in commit messages. Please see
details in the patches themselves.


Reproducer
==========

To consistently reproduce, I injected an mdelay before the rtnl_notify()
call. Since only one thread should delay, a bit of instrumentation was
needed to see where the call originates. The mdelay was then only issued on
the call stack rooted in the RTNL request.

Then the general idea is to issue an "ip neigh replace" to mark a neighbor
entry as failed. In parallel to that, inject an ARP burst that validates
the entry. This is all observed with an "ip monitor neigh", where one can
see either a REACHABLE->FAILED transition, or FAILED->REACHABLE, while the
actual state at the end of the sequence is always REACHABLE.

With the patchset, only FAILED->REACHABLE is ever observed in the monitor.


Alternatives
============

Another approach to solving the issue would be to have a per-neighbor queue
of notification digests, each with a set of fields necessary for formatting
a notification. In pseudocode, a neighbor update would look something like
this:

  neighbor_update:
    - lock
    -   do update
    -   allocate notification digest, fill partially, mark not-committed
    - unlock
    - critical-section-breaking stuff (probes, ARP Q, etc.)
    - lock
    -   fill in missing details to the digest (notably neigh->probes)
    -   mark the digest as committed
    -   while (front of the digest queue is committed)
    -     pop it, convert to notifier, send the notification
    - unlock

This adds more complexity and would imply more changes to the code, which
is why I think the approach presented in this patchset is better. But it
would allow us to retain the overall structure of the code while giving us
accurate notifications.


A third approach would be to consider the second race not very serious and
be OK with seeing a notification that does not reflect the change that
prompted it. Then a two-patch prefix of this patchset would be all that is
needed.

[1]: https://lore.kernel.org/netdev/20220606230107.D70B55EC0B30@us226.sjc.aristanetworks.com/
[2]: https://lore.kernel.org/netdev/ed6768c1-80b8-aee2-e545-b51661d49336@nvidia.com/

v2:
- Patch #2:
    - Drop the __acquires / __releases annotations at neigh_notify().
      They are not necessary with a symmetrically locking function.
    - Retain the R-b tag for this change.
- Patch #8:
    - Do not skip the notification from inside the
      atomic_read(&neigh->probes) >= neigh_max_probes(neigh)
      conditional. Instead set a flag, and goto out after the
      notification if the flag is set.
    - Move the __neigh_notify() call another block up above the
      NUD_IN_TIMER check. That belongs logically together with
      the (NUD_INCOMPLETE | NUD_PROBE) check afterwards, no sense
      to split the two conditionals with the notifier.

Petr Machata (8):
  net: core: neighbour: Add a neigh_fill_info() helper for when lock not
    held
  net: core: neighbour: Call __neigh_notify() under a lock
  net: core: neighbour: Extract ARP queue processing to a helper
    function
  net: core: neighbour: Process ARP queue later
  net: core: neighbour: Inline neigh_update_notify() calls
  net: core: neighbour: Reorder netlink & internal notification
  net: core: neighbour: Make one netlink notification atomically
  net: core: neighbour: Make another netlink notification atomically

 net/core/neighbour.c | 150 +++++++++++++++++++++++++++----------------
 1 file changed, 93 insertions(+), 57 deletions(-)

-- 
2.51.1


