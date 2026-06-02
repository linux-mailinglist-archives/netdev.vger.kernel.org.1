Return-Path: <netdev+bounces-294352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9bVrAY4mH2qsiAAAu9opvQ
	(envelope-from <netdev+bounces-294352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:53:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F667631392
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:53:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=iJi9CQGC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294352-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294352-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E62733036F8C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0939A076;
	Tue,  2 Jun 2026 18:52:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A63396D1A;
	Tue,  2 Jun 2026 18:51:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426323; cv=fail; b=hBBEIy1GubcE1y39YLTtHFazhGI4VvOv/i82ZkXZS7f7jSR42+9kH2XkWg2U1jnGoUbB7eNzLa+NR0WSj1LeF54n7PneH38VL+TKIK+aMTgSC/LUGi4y3Lr6xlDtSRo2g3eZ6krEHr2knXsx17bmHYiocU3xZhhPXAmaPk1Q4I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426323; c=relaxed/simple;
	bh=6GNBkse2fP9naqV+o8XRxSAS3ogI8NwGVtKOH+A3Vso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKFzT+6qqYtE8hKhriUyuAVY1ibMsNROTuAfpJoyt0ipJhG0orq/LC6AOLdKvGeoF9bJjryung+rElVdmGXmMAd383+4bwvGV627VPrkbSU/1d/O7fYjPf97XkH2zc3bw/1FuqCrNruVo5gtc7X8PukAIp1cyKOuNWMHf1sP49g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJi9CQGC; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7YyACatgxKEv459lgI9ggOmHADItyPn7JcQNpIK9hYcnyGtYbKieIwoCwA79CLV307zg4BlxehN0yFFeEMZBha6Yo6EpPfTLcIybHFn2qkbR1UUMFyrv45z7LI6975nj3V9DSeQTNIwcxL1o/QuSE0MUdIyhKkiY919brYjY6hNDsbazWkn/dY3fgTsTjKkamncjF6MijzHG6kGKqS80M0qjJ9HM7QtyCc9VTH5YCpURmzJlvgeoIUyIWLDAsAZf0+VALxx93kndgLkT48VQpDnU/UrhUsz1dfMYMXFjVeHNdyx5iFUe7lFYP+1yY4guCo9kHNeizYG77Nxh2C9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oekl1LhEmOXOfptaStQK2mrjRVj5Ojs53yqW6VXv3PA=;
 b=RdfctUTxK1VkSgmMaqLpuLDnA++KsoIi0PAGZ57wqAD5OmjtIJK9+rpzsNFq2RqsVPdmJRpE+198cxM2/nZPOz+gFGjMRwpj7bMGrJMtsvjhpk7W7hlzpzkfwNKSYgL4BuuplPGYPuywV61nzRdDKmpRaRDXbCuUEIv2n8JZSVaOXM2Is3eMpmFYceDnXLTtfNkZbOKDeoMhoNI5zDCZYnMDOyzokfoIlRQjLlFw/Xd9LRxZG28r5he31pLA3eaFsaw/5fyctntcrI6zJ4C3K0DBbd2vSrm35qZ/+EuR9ubCBB+BQcW4yWing7jCF0s+uWzy4vcv7DqX7mgpMHujEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oekl1LhEmOXOfptaStQK2mrjRVj5Ojs53yqW6VXv3PA=;
 b=iJi9CQGCP7Zed5/FG/9Om0NRKm3wyMlzEjyDXWGBZ7o46zvrukYU1l1Q4NIW3lwQk+Prhf/Ubx90UwabrtBBiZCsIWwaNS4aDEwQpV7LgPDx5VzyokaCDJl14gpsy44XloHnmHwjqeg7Fp5IDcqjiurbd8c86J0f0zg4G5ZPQ09n9lvi1sCBE7rs9KepIDdUG8flYBVOtOUC26X7vrKuFESCNOa/3C7dRGiYqbXka/RYLSXUEzsBmBMg9LRIOIlSNxLX8DWYzQ6HnmCDR7bKV+uW5wjvToABTCjM8ODTTlCN90Fm2nR3ZwaD2faeTpFqRESaiKNVIgPyOH0GQgYrRQ==
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Tue, 2 Jun 2026 18:51:44 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 18:51:43 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Roopa Prabhu <roopa@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Chirag Shah <chirag@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/3] selftests: net: add vxlan vnifilter notification test
Date: Tue,  2 Jun 2026 11:51:38 -0700
Message-ID: <20260602185138.253265-4-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602185138.253265-1-aroulin@nvidia.com>
References: <20260602185138.253265-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4f8315-8089-4357-66e2-08dec0d7fd59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|6133799003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	Nlex5UCF9faNr1I/zHOTrpY8LbIA0FMPHmGKiVOt6WXPz8TWvGlYp5rl86hdnbzBE/Y0D7LAQfHpMPsuYdfITfNCGlDc49AtDn96TFmAVPjw/oivoZsqfDTeXqhtNZczqaq96bhoNrQFd05V8DDI2Jona5CiXn8SdZU1/nMjnwXVi/k0l5pHkoYt3QN7yh8GMdeYjb6HM1ieR0Qh6rTVk7XuS2KyzFIh+oBD7jj42FQkTkA68NE5VaHGyecGevPGiwIAeksIZZqo/TfZyYRcG/J5juJwNLQvbzLjQ/ylI5NBASOdoWRhlI1hvXD4GONKMqcSWYqKM4iafXx6L2cSHwFffs6pYw2F01ayzZeMO31Om1bT625UKCaQSO0ihKRNp8IbvY7dvIbdn4nBtXEB1sR01yGptkCPFiRm/FXrTjHJosCh6nSlvFJzbER+LitSjfUR1MC+SYJpTdxTXxo/oXaObiQNHgqqQIWC9wsjQDTkP2S/BPWxQgXSke+ofBupuQBu+snwkV3pnJbjh4/jsoM8uOMVK26YolJxE2VcdevULmf2jKIWbYq8V11cs98QqwIn3HbprrPg+7oUOHmkybG2ORhymRnj10Iru0E9i5AdOXvPP/DVcn1+/Ra8v3tdTJWnPT6yIzBH4QlKeyZnyGT7KQ3C0icwVT9NGEALvD+2BVEmfb+oblW9yQigJrBj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(6133799003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHOSAHiC7EF68l5VqhMc8yNW04bIUZ9Djx9VXzErnSMNZOF6O3/YGpRqpkN8?=
 =?us-ascii?Q?uOkAa2rBWQJtpjivR2lrXBLjeYDbHTtmy4F5PJIXtR/TkGB2x6aWoPgDQtwn?=
 =?us-ascii?Q?izrnEYl4K8jRMIEKM8KYv+6TF9X934Evi0ODHe4zDZdP6JYI3AmdUkw9nEHZ?=
 =?us-ascii?Q?ElLzT1cIqPb7hNvviKcNu9DacJuNO0c0GF60YmeUCPT9Aw7NVYmdP8hn1TD+?=
 =?us-ascii?Q?vUVvgcaxiRnvuaO97Kh7+j2mOGzKyJwZf1M4pz8tLLpZ0htsQOzCSIPmqa4Z?=
 =?us-ascii?Q?wYVs6B/Me3U7prpyUd35Ez8/vfBpoo+jdZ03VmBRtlCnztTsDGeFnGv30OMl?=
 =?us-ascii?Q?5RGn/hQOLnWEv16q4j790ETvzXZj82c0bt8Zy98ASEJS9l9xL9Q8+5ODBJnH?=
 =?us-ascii?Q?45YAiXH7q2jalvhsH+ctylYCmJeOO04MVSsa5ARpowmSgWlJ7vVtAGIFM9UB?=
 =?us-ascii?Q?fDdYX+yAKUIEC5ENxG6sLaqkbsK1lo7LucXovWopBc8vLz1UsHkYg4MxncH+?=
 =?us-ascii?Q?jenqaQhMr1hqWGtkWS77Ngb2csxWYv6m/CQ6nkQOyWGawV1D7rdu2Ufp/oA8?=
 =?us-ascii?Q?0Rkyfr2Fc136mpdwFb1ffA3RmUQ19JCzbZRKlm0Vsi2YC3Le91kVQ4xbcH2O?=
 =?us-ascii?Q?xoxjOtAB5mdqY2FnEzhvgFNcChlwG7hSxTwMRuMoN+hldN+rP7qZ94uVJy1a?=
 =?us-ascii?Q?DhLXCYWg+kgPITpQaVC7Wujb9384gxFidA9iswrIhfnW7RAw93DWJ8zJtzKF?=
 =?us-ascii?Q?hxbLFZ/bLTewyvF3inzHK9mvKH92MYaOwF5Br47VofNrwbExJ1kyjFuBgf0c?=
 =?us-ascii?Q?UUPPqoy+6Z4lxZ4LD33pM4bBBtJ268/TvpFFZWOtApMK7zAq6Orj7yKXGyLL?=
 =?us-ascii?Q?Bo/1C93h3jxGz/604jGTluSKOvs4/9ejOwH9MT4yO7sNhs7OKNokq/7zgnkp?=
 =?us-ascii?Q?GUXzsNG8QqhyI1ZeZg1bBvLvg1o2LHY5+0H2COQqqdsmDsTh5E4BNLdx0Cr0?=
 =?us-ascii?Q?ZDk1BbOkRKJBmXy0DAVw2JsBOzRt717e4vwk+GYqy0yVBcqf9rsB2y769iAz?=
 =?us-ascii?Q?ek516hnRsMCowSp5InaWCi56WNsUIQ4LEjnQoJpcjP0cModEAy+xeR8q9XIm?=
 =?us-ascii?Q?6LJZFGIJ/GOzq1c3/APbrGUfgH8dHtZDmNJcNyDmKehRR0Oj95yOSX0G3d7G?=
 =?us-ascii?Q?u7Xn208AgEmtPGKyCZQbNfDtpMepSNBkD+vrrFMb/IprA02S//aNAwn8C641?=
 =?us-ascii?Q?ECpqFThhUC5GMAd6E4+6K7l3o407PqNVTE6s++c1lOOR8gH3DfZPhsOOt03q?=
 =?us-ascii?Q?xI8uUMuY1uQ4fi6mJxX53VS/H/Y/z5avK71mBi/RXuY1bw7o4i6TkNz0MDJt?=
 =?us-ascii?Q?H7JnzCIZplyQQXicj2LbyRGBe3GmmxWdq2t9nY7r/hVYzGg517g9NNlvIera?=
 =?us-ascii?Q?FBQNAAJp10HxVdAsSMH8tfUVKmIkAi5xGyMME04HG9WrzW70bAHmCSDKL6LA?=
 =?us-ascii?Q?vpy7hlWj1PSgpoARmZVvjTO28uhVVvKMCSrvk+87EMdkDipdjfcSW6+S50c3?=
 =?us-ascii?Q?Ehp5BMhHxjWgUjfysC18vES4NzVWR+Am/rBB6pWsggbrhMe4FiYD1UDR1YlS?=
 =?us-ascii?Q?mNu0BYu5rMw0WVTOTJflCWozDBOpb3avo7Sd2qCQTu497GPd+RuuJO4Qj91F?=
 =?us-ascii?Q?XmJPcXgQXepzQjJfUGocOneR2kDOSxAFhTeooCR0JW1MehmIOWdgkNg4ZRWH?=
 =?us-ascii?Q?5X6Ahrs8mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4f8315-8089-4357-66e2-08dec0d7fd59
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:51:43.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2EDnPdYkX9hPj3VVfb3CouncOAQJBUVDEv6amOoKS73CKy5oyE4iOV/Xiko7FzGjakVDo3LkDD8ry/mI0YKiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-294352-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:roopa@nvidia.com,m:petrm@nvidia.com,m:idosch@nvidia.com,m:chirag@nvidia.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F667631392

Add a selftest for VXLAN vnifilter netlink notifications that verifies
RTM_NEWTUNNEL and RTM_DELTUNNEL are sent correctly when VNIs are added,
deleted, or updated, and that no spurious notifications are sent when
a VNI is re-added with the same attributes.

Signed-off-by: Andy Roulin <aroulin@nvidia.com>
Acked-by: Petr Machata <petrm@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
---

Notes:
    Changes since v1:
    - Improved vni_notify_check helper based on review by sashiko.dev:
      * Bump pre-cmd sleep 0.1s -> 0.5s.
      * Add /proc/$monitor_pid liveness check and ksft_skip if
        iproute2 doesn't support 'bridge monitor vni'.
      * Capture and propagate "$@"'s exit status so check_err
        $? actually validates the bridge command's return.

 tools/testing/selftests/net/Makefile          |   1 +
 .../net/test_vxlan_vnifilter_notify.sh        | 184 ++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100755 tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index f3da38c54d276..2ed7d803eb548 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -109,6 +109,7 @@ TEST_PROGS := \
 	test_vxlan_nh.sh \
 	test_vxlan_nolocalbypass.sh \
 	test_vxlan_under_vrf.sh \
+	test_vxlan_vnifilter_notify.sh \
 	test_vxlan_vnifiltering.sh \
 	tfo_passive.sh \
 	traceroute.sh \
diff --git a/tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh b/tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh
new file mode 100755
index 0000000000000..9d51a9e02ae0c
--- /dev/null
+++ b/tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh
@@ -0,0 +1,184 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2034,SC2154,SC2317,SC2329
+#
+# Test for VXLAN vnifilter netlink notifications (RTM_NEWTUNNEL /
+# RTM_DELTUNNEL).
+#
+# Verifies that:
+# - Adding a new VNI sends a notification
+# - Adding a new VNI with a remote sends a notification
+# - Deleting a VNI sends a notification
+# - Re-adding an existing VNI with the same attributes does not send
+#   a spurious notification
+# - Updating an existing VNI's remote sends a notification
+# - Deleting a non-existent VNI does not send a notification
+
+source lib.sh
+
+require_command bridge
+
+VXLAN_DEV=vxlan100
+
+ALL_TESTS="
+	test_vni_add_notify
+	test_vni_add_remote_notify
+	test_vni_del_notify
+	test_vni_readd_no_notify
+	test_vni_update_remote_notify
+	test_vni_del_nonexistent_no_notify
+"
+
+setup_prepare()
+{
+	setup_ns NS1
+	defer cleanup_all_ns
+
+	ip -n "$NS1" link add $VXLAN_DEV type vxlan dstport 4789 \
+		local 10.0.0.1 nolearning external vnifilter
+	ip -n "$NS1" link set $VXLAN_DEV up
+}
+
+# Run bridge monitor in the background, execute a command, then count
+# the notification lines.
+# Usage: vni_notify_check <command> [args...]
+# Sets: NOTIFY_COUNT with the number of notifications observed.
+vni_notify_check()
+{
+	local tmpf cmd_ret monitor_pid
+
+	tmpf=$(mktemp)
+	defer rm "$tmpf"
+
+	defer_scope_push
+		ip netns exec "$NS1" bridge monitor vni > "$tmpf" 2>/dev/null &
+		monitor_pid=$!
+		defer kill_process "$monitor_pid"
+
+		sleep 0.5
+		if [ ! -e "/proc/$monitor_pid" ]; then
+			RET=$ksft_skip
+			log_test "iproute2 'bridge monitor vni' not supported"
+			return "$RET"
+		fi
+
+		"$@"
+		cmd_ret=$?
+		sleep 0.2
+	defer_scope_pop
+
+	NOTIFY_COUNT=$(grep -c "$VXLAN_DEV" "$tmpf")
+	NOTIFY_COUNT=${NOTIFY_COUNT:-0}
+	return "$cmd_ret"
+}
+
+# Adding a brand new VNI should produce a notification.
+test_vni_add_notify()
+{
+	RET=0
+
+	vni_notify_check \
+		bridge -n "$NS1" vni add vni 1000 dev "$VXLAN_DEV"
+	check_err $? "Failed to add VNI"
+
+	[ "$NOTIFY_COUNT" -eq 1 ]
+	check_err $? "Expected 1 notification for VNI add, got $NOTIFY_COUNT"
+
+	bridge -n "$NS1" vni delete vni 1000 dev "$VXLAN_DEV" 2>/dev/null
+
+	log_test "VNI add sends notification"
+}
+
+# Adding a VNI with a remote should produce a notification.
+test_vni_add_remote_notify()
+{
+	RET=0
+
+	vni_notify_check \
+		bridge -n "$NS1" vni add vni 4000 remote 10.0.0.2 dev "$VXLAN_DEV"
+	check_err $? "Failed to add VNI with remote"
+
+	[ "$NOTIFY_COUNT" -eq 1 ]
+	check_err $? "Expected 1 notification for VNI add with remote, got $NOTIFY_COUNT"
+
+	bridge -n "$NS1" vni delete vni 4000 dev "$VXLAN_DEV"
+
+	log_test "VNI add with remote sends notification"
+}
+
+# Deleting a VNI should produce a notification.
+test_vni_del_notify()
+{
+	RET=0
+
+	bridge -n "$NS1" vni add vni 2000 dev "$VXLAN_DEV"
+
+	vni_notify_check \
+		bridge -n "$NS1" vni delete vni 2000 dev "$VXLAN_DEV"
+	check_err $? "Failed to delete VNI"
+
+	[ "$NOTIFY_COUNT" -eq 1 ]
+	check_err $? "Expected 1 notification for VNI del, got $NOTIFY_COUNT"
+
+	log_test "VNI delete sends notification"
+}
+
+# Re-adding an existing VNI with the same attributes should not produce
+# a notification.
+test_vni_readd_no_notify()
+{
+	RET=0
+
+	bridge -n "$NS1" vni add vni 3000 dev "$VXLAN_DEV"
+
+	vni_notify_check \
+		bridge -n "$NS1" vni add vni 3000 dev "$VXLAN_DEV"
+	check_err $? "Failed to re-add VNI"
+
+	[ "$NOTIFY_COUNT" -eq 0 ]
+	check_err $? "Expected 0 notifications for VNI re-add, got $NOTIFY_COUNT"
+
+	bridge -n "$NS1" vni delete vni 3000 dev "$VXLAN_DEV"
+
+	log_test "VNI re-add does not send spurious notification"
+}
+
+# Updating an existing VNI's remote should produce a notification.
+test_vni_update_remote_notify()
+{
+	RET=0
+
+	bridge -n "$NS1" vni add vni 5000 remote 10.0.0.2 dev "$VXLAN_DEV"
+
+	vni_notify_check \
+		bridge -n "$NS1" vni add vni 5000 remote 10.0.0.3 dev "$VXLAN_DEV"
+	check_err $? "Failed to update VNI remote"
+
+	[ "$NOTIFY_COUNT" -eq 1 ]
+	check_err $? "Expected 1 notification for VNI remote update, got $NOTIFY_COUNT"
+
+	bridge -n "$NS1" vni delete vni 5000 dev "$VXLAN_DEV"
+
+	log_test "VNI remote update sends notification"
+}
+
+# Deleting a non-existent VNI should not produce a notification.
+test_vni_del_nonexistent_no_notify()
+{
+	RET=0
+
+	vni_notify_check \
+		bridge -n "$NS1" vni delete vni 9999 dev "$VXLAN_DEV" 2>/dev/null
+
+	[ "$NOTIFY_COUNT" -eq 0 ]
+	check_err $? "Expected 0 notifications for non-existent VNI del, got $NOTIFY_COUNT"
+
+	log_test "Non-existent VNI delete does not send notification"
+}
+
+trap defer_scopes_cleanup EXIT
+
+setup_prepare
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.43.0


