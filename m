Return-Path: <netdev+bounces-225515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF92FB94FC6
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D584418989EC
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17793191BD;
	Tue, 23 Sep 2025 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="Wcxq6qDm";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="YHDbOBHR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-edgeMUC221.fraunhofer.de (mail-edgemuc221.fraunhofer.de [192.102.154.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C919F464;
	Tue, 23 Sep 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.154.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616036; cv=fail; b=ZF6EljecNUYZwE31w1HCMBi9Usm8+SA05ODU37PAB8DYLzB4+QHMmXTtMApxPFUvTPjH10Sv8na7R4OJRJi+xsBk0cGdrWwLvPKLu/zTCpxmF0AGlFjI7a3uUh40lochD3nHfKkkYN0x+FRMrNCXKJoUKj3BmAevu85O0UPgMBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616036; c=relaxed/simple;
	bh=oKQNQeOpKov3YiKYFCQx6ymcb7e/S14xDG4Tc2fmrY8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lf+uo+cT7G1EJsxX9RSk7Uct+SL+2LatXMll311zLQ5X+0GGhT3aalIiE/KTJHOYb4JeJv3l902LAXU1/EJMoZfLhckKwYLUwWKq2frstrCA9SquNY7SGCOcyqcFfUbUfWLdiZQUH4zXonAPrpCUyzd+pg1L0g7+4jr7fgTjBbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=Wcxq6qDm; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=YHDbOBHR; arc=fail smtp.client-ip=192.102.154.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1758616030; x=1790152030;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=oKQNQeOpKov3YiKYFCQx6ymcb7e/S14xDG4Tc2fmrY8=;
  b=Wcxq6qDmrMwR9ZV6eQMCY7Fc0S6wTVL4VCmVdO/9IQ7EyzwzoV7k95Ki
   0DKcO+j3vJg0zCsv8rcbCKSn3cS33cmtyu+MhWSiLYxEyUUBPrbSe766f
   +4ZB1m/EZTAOFYN3+aA4vle6p/W978dTith2vZl6gcaVFZ43dXyH5eIyj
   +et3U77FhzCdHgxEcYGaIxIDhl7UNFOSxKnITZPboclY+EhUCHEXYuEyD
   KGUPX0Q+1xcHRGTf+u1J4C8gyS2/13osLP3KmMiMpletdnhiD+RT+DjXr
   ww7KXz3pVOnlVKqE7MRBBFb7pzmcMG61iWiTR1MwsXLYrnmXkx1792M9w
   A==;
X-CSE-ConnectionGUID: nGLO02bkQd6AXzDQ0Rle8A==
X-CSE-MsgGUID: 4a58rtJtQ3GGJ5RVlTE6Qg==
Authentication-Results: mail-edgeMUC221.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2H6CgCWRZ5o/ycF4gpaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VMCgj5AATILgTwrhFWRcZxygSuBJQNXDwEBAQEBAQEBAQgBFBMqBAEBAwSEd?=
 =?us-ascii?q?gqMJyc0CQ4BAQEBAwEBAQEBAgUBAQEBAQEBAQEBAQsBAQYBAgEBAQQIAQKBH?=
 =?us-ascii?q?YYJRg2CYoElgSYBAQEBAQEBAQEBAQEdAjVNMg8BDQEBNwE0AiYCMzkFW4InA?=
 =?us-ascii?q?YIjBBIDMrFzgTKBAYIMAQEG2ykYgSeBIAkJAYERLgGDfIRUAYR8iDaBSoJEb?=
 =?us-ascii?q?4QKToNGFoJTgzyQZYoegQIcA4FuDQoSgWgDNQwLLhVtMx2KZytPhQ5BWINTJ?=
 =?us-ascii?q?GuBKoNsgiYLGA1IESw3cgFuB5M2gyoBSUSCFB0PNJZGAbAfB4I4gWehVxozl?=
 =?us-ascii?q?2CTCgHCHAIEAgQFAhAIgWiCFjM+gW0JgUBSGQ+OLRaDXrMidgI6AgcBCgEBA?=
 =?us-ascii?q?wmCOY8xNIFLAQ?=
IronPort-PHdr: A9a23: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
X-Talos-CUID: =?us-ascii?q?9a23=3AC4fSX2gZqTlzALKtDMsZVpVo1jJudFL56y+KKUy?=
 =?us-ascii?q?BBThAeK+5cAeq/K40up87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ALmj92wwh5QPTBqDTA6ui4kDwIDOaqPinVRAXjbc?=
 =?us-ascii?q?agpKrGg4tAQmZsBnpe4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,290,1747692000"; 
   d="scan'208";a="12843143"
Received: from mail-mtamuc217-intra.mx.fraunhofer.de (HELO mail-mtaMUC217.fraunhofer.de) ([10.226.5.39])
  by mail-edgeMUC221.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Sep 2025 10:25:56 +0200
X-CSE-ConnectionGUID: K9xpJ9O4RMaIfPDEpGyqiA==
X-CSE-MsgGUID: T0EG4JL+SjOfT324x91U/A==
IronPort-SDR: 68d25993_EfM+wcHwkEEZ/wqRS0JNOQPSYaGNsNxCJdwmspLXA+T9fXV
 fwTSRVrMwvcUggCB9HZiMvzTEdxSCU72Mq4PIOQ==
X-IPAS-Result: =?us-ascii?q?A0BAAAAuWNJo/3+zYZlaHQEBAQEJARIBBQUBQCWBGggBC?=
 =?us-ascii?q?wGBbVJAATINXl4rhFSDTQEBhE1fiHaccoErgSUDVw8BAwEBAQEBCAFRBAEBh?=
 =?us-ascii?q?H0KjEMnNAkOAQIBAQIBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEBBgWBD?=
 =?us-ascii?q?hOGTw2GUgsWEQ8BDQEBNwE0AiYCMzkFIjmCJwGCJAQSAzUCAgKpBQGBQAKLJ?=
 =?us-ascii?q?YEygQGCDAEBBgQE2yIYgSeBIAkJAYERLgGDe4RUAYR8iDaBSoJEb4QKhBQWg?=
 =?us-ascii?q?lODPJAxjVKBAhwDgW4NChKBaAM1DAsuFW0zHYpQK0+FAj5ag1Mka4Eqg2GIR?=
 =?us-ascii?q?QsYDUgRLDdyAW4HlkKDMQFJRIIUHQ80lkYBsB8HgjiBZ6FXGjOXYJMKAcIcA?=
 =?us-ascii?q?gQCBAUCEAEBBoFoPIFZMz6BbQmBQE8DGQ+OIQwWg17IMkMzAjoCBwEKAQEDC?=
 =?us-ascii?q?YI5jzGBfQE?=
IronPort-PHdr: A9a23:VzTAFxyjkGvpxlzXCzKOy1BlVkEcU8jcIFtMudIu3qhVe+G4/524Y
 RKMrf44llLNVJXW57Vehu7fo63sCgliqZrUvmoLbZpMUBEIk4MRmQkhC9SCEkr1MLjhaClpV
 N8XT1Jh8nqnNlIPXcjkbkDUonq84CRXHRP6NAFvIf/yFJKXhMOyhIXQs52GTR9PgWiRaK9/f
 i6rpwfcvdVEpIZ5Ma8+x17ojiljfOJKyGV0YG6Chxuuw+aV0dtd/j5LuvUnpf4FdJ6/UrQzT
 bVeAzljCG0z6MDxnDXoTQaE5Sh5MC0ckk9KXxPc9UHEfZbKnyT5lcpUhAybJZLKdOEseG+zx
 bZRVDLssnxWMyEdwlru358V7upR9SOBixZY6a7uQ4fKaNFbQYL5VNMZeGxkYe9yXSdbMKaEa
 oYsNeQjEcFp8NXPv2Eoqgq8OzKjJ8/Q8mFohlX75q0g9s4vAxjWhQcjR94S7EvugdHMOqkwb
 LiMyJbB0mvtcdNY8m7Q0ayTTkw5sN+gYpkpaPfD51t/EFPspAmLhLTDIBCp6ccm6kaQ4sFJa
 Nrsq1AIrS8shz61mN4FkNXngp5OlVPHqiJ6n5lsFIjrAF4+YMSjFoNXrT3fLYZtX8c+Fnlho
 z1polVnkZuyfSxPzYgu4iP0MaXYNYaS6w/lVOGfLC0+iH82ML68hhPn6UG70aW8Tci71l9Ws
 zBI2sfBrHED1hHfq4CHR/Jx813n2GOn2Rra9+dEJk45j+zcLZsgyaQ3jZ0drQLIGSqepQ==
IronPort-Data: A9a23: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
 bQdHgiomH2GdHM=
IronPort-HdrOrdr: A9a23:9dJVkakUpXo+Cyny6MyjGD5h6T/pDfOrimdD5ihNYBxZY6Wkfp
 +V88jzhCWZtN9OYhwdcLG7SeW9qBbnm6KdjrNhW4tKMDOW21dAabsSlrcKoAeQVBEWlNQtrJ
 uIGpIWYLabbDhHZITBkXGF+r4bsZ66GcuT9ILjJgJWPGZXgtZbnmNE42igYy9LrSB9dOcEPa
 vZwvACiyureHwRYMj+LGICRfL/q9rCk4+jSQIaBjY8gTP+ww+A2frfKVy1zx0eWzRAzfMJ6m
 7eiTH04a2lrrWS1gLc7WnO9J5b8eGRi+erRfb8yvT9GA+cyDpAV74RHoFqiQpF491Gsj4R4a
 XxSlkbToBOAjjqDxuISFPWqnbdOXAVmjnfIBaj8AXeSZmQfkNLN+NRwY1eaRfX8EwmoZV117
 9KxXuQs95NAQrHhzmV3amCa/hGrDv8nZMZq59as1VPFY8FLLNBp40W+01YVJ8GASLh8YgiVO
 1jFtvV6vpaeU6TKymxhBgj/PW8GnAoWhuWSEkLvcKYlzBQgXBi1kMdgMgShG0J+p4xQ4RNo+
 7ELqNrnrdTSdJ+V9M2OM4RBc+sTmDdSxPFN2yfZVzhCaEcInrI74X65b0kjdvaDqDh5PMJ6e
 f8uHoxjx9CR6svM7z44HRmyGG4fIzmZ0We9ih33ekNhoHB
X-Talos-CUID: =?us-ascii?q?9a23=3A7u37immrrqzre8INvHMZQmfTe1DXOV6M3G/ycmj?=
 =?us-ascii?q?kM0NgabOtZXKI17J9kuM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AP2wjEw4P0ty91VYrvDAv0kC1xoxUu4mBVGIp0q4?=
 =?us-ascii?q?EnMe4bnYsK2bEsXOeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,287,1751234400"; 
   d="scan'208";a="28399598"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaMUC217.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 10:25:55 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Tue, 23 Sep 2025 10:25:55 +0200
Received: from FR6P281CU001.outbound.protection.outlook.com (40.93.78.5) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33 via Frontend Transport; Tue, 23 Sep 2025 10:25:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MI4TuKud96ZjKhJmxATpL2+ZYoHjvIvdYiyQci7ZcZR1PkNdppr3lZjs6Q3cyc1+q44LCvnUXPfWb60UGWOGu+AxG2XjKSm63sRpAWhbq567gCh/c7KFHfh4tJXfLXvLALl3saYgsRScMr0xxxKwa/UjVKikb2VY4gMmtTkS9RpEoWerN3Nc0qn0DUBkF5q/seu+tDu45yqG3qiAmo5kjoubPtKP+BzqAovWfwU+/zsfYsNFukgu7mXgnTAqGawEUa5usSUJFpYMJ3EmsAd3/SKAzT23eYochChYUu6+oEatZWqHXka7eUQWU5BqVMDj/FHmHT2rMnpx28WpF1ueyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4sqq8VKiSEgkKHA4Mip7TQ9pI3yByRtElR39lwLZSQ=;
 b=g5IiZzsuSitfh0x4Wl/Nrs8RqmjRqhrr+lApdW/EacgSLDsWwPbldYpaRLq8mo2mumNeMoKisttzp6u3dmyrE5fMpMg+w6XuSiNpEQpRQn+jbtim/IKuspNk6tgv1goBj0wknr0tBnIqnOkF/czBsi1xajnYGginmRJY/XOxsFocV+RcPCRFeG8hSR3kNdroBWzl6MeA3PE9LnBx4Rzacqlq7AOafldQf3PubLGNTXxz5RCuSzzDlMcUiICGmVwGlp1Me6e4IYcehvWWHOFpjl6SH0v/u5gZ2c4R14O8sd5ULUGBhhVPfWi9SQzt+KXTq8ukqKu8m7aPY7X9Yc5xjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4sqq8VKiSEgkKHA4Mip7TQ9pI3yByRtElR39lwLZSQ=;
 b=YHDbOBHRKn74CMWILAhkUnMWAKbcrZMPmeKRfJDOY74ZpRNoyjVSgKDWP6HhBeShrMBfzqx1ck0dt4WRElQffJU0QlWaw6FvHfC1EQL3T4pyFDWC1qUzFz8o8AB4sEPNwKTWKC1FceCAUP+HVGnF5Mnr6qAr4Flt37kk7ok7w1Y=
Received: from BE1P281MB2065.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:40::5) by
 FR6P281MB4467.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:134::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Tue, 23 Sep 2025 08:25:52 +0000
Received: from BE1P281MB2065.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b1e7:5699:2a3:81dd]) by BE1P281MB2065.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b1e7:5699:2a3:81dd%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 08:25:52 +0000
From: =?UTF-8?q?Johannes=20Wiesb=C3=B6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>
To:
CC: <gyroidos@aisec.fraunhofer.de>, <sw@simonwunderlich.de>,
	=?UTF-8?q?Johannes=20Wiesb=C3=B6ck?=
	<johannes.wiesboeck@aisec.fraunhofer.de>, =?UTF-8?q?Michael=20Wei=C3=9F?=
	<michael.weiss@aisec.fraunhofer.de>, Harshal Gohel <hg@simonwunderlich.de>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtnetlink: Allow deleting FDB entries in user namespace
Date: Tue, 23 Sep 2025 10:21:40 +0200
Message-ID: <20250923082153.60030-1-johannes.wiesboeck@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::19) To BE1P281MB2065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:40::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2065:EE_|FR6P281MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 9960b3e2-b40e-4980-a996-08ddfa7ace9a
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnBLMWlzTjU3WGhyOXRjL3ZOY1dQdDk4T1JVR1VESGkzK3l6Q0pxOVhBMGF6?=
 =?utf-8?B?VzBOQnB0OXFhZGhuT3d3anFCUE1jdldkRFY5OFN3OVBpR2FIZUlDZ2ErdHd1?=
 =?utf-8?B?YWg3aC92Q1R2bWF0cnVJa2lWZDdvV1E3Y3BNT2JaZlFXalhTWHZLRFRXVWVi?=
 =?utf-8?B?bmRUUWNaYTRKWS95NWF1Nk9HM1dYbm53c1hYYmdmUzlWdDd1QUZYeXo5UWNX?=
 =?utf-8?B?T0RDWWxyUDlQeTRhNmtCcUdJSXZ2WVowRzZ3UkNsYkx4b3NRWXdJTVNlbU1q?=
 =?utf-8?B?YUg1aHJKQm5SdWx2YUN0NWlDRm0wOW9iOFhlM2RBM3ZoMEFTM0tZZXQydXhO?=
 =?utf-8?B?bS8zUnRrc2pLUTgyNnhxd2Y3WS9YWStXNUU1YkdscDBnZU96c0ppR0xGOGFt?=
 =?utf-8?B?eWhpVlN0NVMyNnNqZ2lBZVY3Z0I0eGJsbzBtaGg2bnlDdVRoUDYwc2V4TmdQ?=
 =?utf-8?B?WHpqa3RFUlpicEdINVY5NUVKTDFrTktVWnR3d1FwZURxYVBrV1RKUnE2SHpR?=
 =?utf-8?B?SE52QTh3YnFBazFWL3ZDcXNxVExpLzluVWVsQVBwdG9aK2ZsNzN3bldUTEll?=
 =?utf-8?B?U3hNRGZTWlRUQmp0NEpUeCtnVm5xejc4d2FXU0ZqL0NKNDU2MFBIZFFSMVNw?=
 =?utf-8?B?N3dsNHo5NzdGSlhlcVVwTk9QWUNNRFQ1U1F6REd4cTRzeHo4Y1I1UENZSjVy?=
 =?utf-8?B?dmZkU1BoY0R2UzFHSnRwanJ5bHkvOHNjU0cxNUZWOTFpZU0zSWYyTlMyekxG?=
 =?utf-8?B?MERWcjJBeEpVaUk4aGJYUDdlRjBwUTJOUzNucUl0SndKNDRkYmQrOWhyR2tW?=
 =?utf-8?B?MGRtLzFvYUJFWmVrU0wvRGgvdlRqZkVtMzVjR2hnVHp6NFRHZGhWRGNSZFFD?=
 =?utf-8?B?T3VKTjc2aWl2N0R5eFd1SkpCUlQrcDlPaU5nQW9oRU5rNkFsdzcxbjZDdVFL?=
 =?utf-8?B?WGFyWFpUOFViK0I5OHV1dWFzWVh0a0N2cDlWa3pwcE02Y3B4UjJwcG5iK2Vk?=
 =?utf-8?B?OUJZTjdKQ3AwUjVYOHZKZEFXc2FyNzFqc3hoek5qMHFMTkE5N3ozbm1NUWFK?=
 =?utf-8?B?c2tQSjEvdGZwNVZRamkvU1B3aHpuK0RpY0x4VzhISGtBdEkwTWlaTE9oOFJs?=
 =?utf-8?B?U1lGT3lHZVBXL3E2a0RhRHozU0lQNXFLbFFVOEhuSkRWQ3BkWmlHRFdpSkFp?=
 =?utf-8?B?dkJMZ1ZhR1d6Q0N1aHU1aGtmaHZGc0RoNytHd1pueTFCampZQThEMk90YXEz?=
 =?utf-8?B?TEorVzF0SGdmbnpXL3JSS3lqb1pXV2diUjdyMis0TldYc0h1M3RFc252bE9y?=
 =?utf-8?B?aFBlY09pNFIrbWU0V2JyaXdQQzNiRXAyUXVuQjBWTUt1UnhkNnRmd3dlV3Ji?=
 =?utf-8?B?d05zMVVrdTdLRzJuZWg2ZVlaZ1FWTHkvckM4NHEzNnlaOGVxN0lGM3p1Tjhp?=
 =?utf-8?B?OEpHOVRMUkhqd1lEdTJqYnZmRHJZNkFQRldOd2NwVW9ibGQwekpmRzdSdUVG?=
 =?utf-8?B?TTlZVkdZR3ozY3ozYVFKbHRtM1dGM2MzREk2RUpoSFJkU0NsaXFiV3lBQ1U2?=
 =?utf-8?B?SnVYSGpJd2htNFBaVkVRSU00ZGlzV3U3YlBZbnd3cFZtWjByR0o1ZjR1ZGxr?=
 =?utf-8?B?S3RBeHZ4cXdxUGthczJDZmFnZzZJakpQdi9lb0lKa3FoaTFxZ3oyUEUwY3Vs?=
 =?utf-8?B?UndOZW9jNFFOWFJoRmJnZ3hpR0pzcHZKbTgzbmRObU1qd0RwVnJ4K212eWhE?=
 =?utf-8?B?ekQ3OW1ETzVsbUhmZEtwN0xzNzdKMk9zbnJUNEdyc3ZXQUNlUXVydDVLU3Jv?=
 =?utf-8?B?TzZxcGNhZy9ObHVYOThMdTQvcFJaU1dadVRheGx1L21IMVVoNVBKNmhUQm9G?=
 =?utf-8?B?TkcyUFhrNDl2YXQzYWhHODBOMy94WFFXWWVMbi9EcnBJTUhVN2JyVkYvUnRL?=
 =?utf-8?Q?XT+tWq0kQuM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2065.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1MrNldwTllYcVVialpGbmRkNnkzQkc4cCs3cDdJWmpXcHlCTkVOS2diVEdI?=
 =?utf-8?B?MEhWdTVoUGhodXBjOGsrMW9GT0NoM3pnSWs2cFFXTUk0Z0hqQ0xQcEhxM0Vs?=
 =?utf-8?B?MFFBWW9mV0h5UW83UzVOanVQb25pMUl2OWN4RzhGR0t5UTRVVzFhbkxKTjc1?=
 =?utf-8?B?eVV1RmFkT1FlQS9xMmlsR2U4NkdkUDIyWGo5N2pqOWZqNExFWmtpU1Nhd0hj?=
 =?utf-8?B?bUVRdnRNL29UOGdVTVAxSVVhK3l1bmNmZjNkbFQ2dW1uWkh3WGVJdDAzbG9N?=
 =?utf-8?B?RllQNHNkOTJlL2hBbW5tUVc5K2J1RUYyQU9wZmg4bVJKazAvS2MvSlNvSXA4?=
 =?utf-8?B?U1o1NVFHcTFhaE80Ym16bmtCaXlldHlaS0lDQmNWTm4vMC8xL1ZoYTNxTzZG?=
 =?utf-8?B?aVJkZWlXdVdOb1VSd0lnaDFHcHZGNWpHYkYxN08rbnk5c0FTYXlCcXFBUnJo?=
 =?utf-8?B?R3p1V0FPaVhNL0NPTXZRemJXVXlnejh2WUxMT1FjMjk0RWlGL05OTElMbWU3?=
 =?utf-8?B?Y1ROaXZJcVc3ZmZZZzdCN1QwazZReUg5blIyVFNRSGs5ZW01SnNPZTJFWEwz?=
 =?utf-8?B?cUtFd05heGljQ2pnWnE4dUdyR0w3OUtSU2YzR2Uyak1iUXQ1UXE2SXE5bE5o?=
 =?utf-8?B?UzIvdkw4WHVkaksxWnZGdndJMjYyR0RxT2t5ZVlXSktEVnZlcGpzTW1JUUxN?=
 =?utf-8?B?SzBZQkFrSTg4N0ZrNkhQM3hvcWpoOThUTlkyQXBrc3ZmVzFLMGt0dkdyYy9n?=
 =?utf-8?B?dVdCcmhpcFlTMUlhcWNuWEw4aDlCcUtxeE9uSkF4bnVQWFRXR2l1SkQ1UElr?=
 =?utf-8?B?Nmk3UVNLZ251TVhkUkJVdXhFN1N4ZGpYelFOaE04WGR5QlBlbmh4dENCMmdP?=
 =?utf-8?B?UjJOUHpyQndTS2JSSEZyTUU2c2NzRGd0dGhuTEQ1R0tQSUJjZUhyaXhxazhk?=
 =?utf-8?B?NTdTWnFwODVGcHhmMUJWS3VNdWlubXJJTE5seTlDM3VkSWNwdUNOQ012ek5F?=
 =?utf-8?B?TXk5MWxZSE1HbEQ3RHFlUkFXUlNkLys1TytiMU0ybGdzN2VzRlQrUFhlT2h6?=
 =?utf-8?B?SVpmcFRaSlQwWFVHeHgxcHhUOUp3RHdpUDV0a3ZhZHNPL3RjR1ROOEV6VFNn?=
 =?utf-8?B?TmxmWmtCd1Iyb2tlVXhKMk0zeC9OSjkyVk5vSThNV2JBUUxLWW15RXduSTBa?=
 =?utf-8?B?TEUxRVBLVDMwSHJUN3p6VldzVnFYVEJkRWVBeDd2WEdCWFp0dzNzZlA4emtx?=
 =?utf-8?B?YkVqQTdhdHBEMzNvRDFiZGl6UmgrOFpNTmI2SjlCeSt4bnRMc2pJL3ZsbXd4?=
 =?utf-8?B?OFhiNVIzdHRhVHRJRkdHRnN5MW5iWXd6eXJDVFlod3dsK1RKRlcwT3kyaGF6?=
 =?utf-8?B?R2VCSDkzTllRNVpNSHNSOCtMOGtjOXlDQW0wR3d0WWJpc0VrVHdNQTJId2lh?=
 =?utf-8?B?NFU3OW9GR1VpSjBJQ2JBd3IxRERYZ1Z6ZXBsOVZVbkVRUkhObGMxMUZVZkRi?=
 =?utf-8?B?TmU1M2FBdVBnT3VvUElHcHlMQURxbXhLYXBkMHlJU0dzTE1YOGwyTFBwZTJE?=
 =?utf-8?B?SmJBS3BPRnEwRXZqYTIzeSt3NFgvY1dGUFMyMUh1aFNHSmJIV0NWbmdmUDJv?=
 =?utf-8?B?SlBacXR3TXVnK3BXOGlmSElnd1JDZzU1aGl3SFBmLy9Ia2x0ODBZQ1VjdXdL?=
 =?utf-8?B?aTYyeXhDTmVleHlpSDhqSDFUSHIzMFhUeXBEeS9RT1ZuNEp1S3NYeDY2VVoy?=
 =?utf-8?B?d1MwTnRjN0lHK3JRQmJIKzVQZXRaTm1BMkF4cDNqVDZLTUNkVVMzNENlTjFG?=
 =?utf-8?B?R3BGZzJsUE9VZkRCSEMzcmFzYU9yeTNkSUc1djdGTkoxNVQ2QzBYTUpCOHBs?=
 =?utf-8?B?SzNZNThwaCtvS1JPRmJ2YzlsNWJGS0VlalFBenpRNUVnUEpxdHpuNEJ5dTI2?=
 =?utf-8?B?Mi92OWJRNE9WT0RtV0VOOXZiRlludXVXMGxqU3FnWjh1OFVtTUZJUlh0aTJS?=
 =?utf-8?B?aTRKZDFxRFAra0hhOG5tR3lGTVR0UUJOanFIMDVaeHpjL2RpRmJPc2Fuczlp?=
 =?utf-8?B?a3MzU1NiQkJLYUphd1pTWlByR3BITW01Q2I3Ym5LUTN1VjYxaWhVeHZFTC9C?=
 =?utf-8?B?ZEFwdGVIQVpXMzFTeWU0TmJSWkFZWEttQ29HS0ZWOG5sRkVLSkRiaGZDVGRL?=
 =?utf-8?Q?PoeskMpobW/IRVPLPZOnto6xGZ99R66lmIuybLPaAyuY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9960b3e2-b40e-4980-a996-08ddfa7ace9a
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2065.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:25:51.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlrMAm8jVbb5QBPkS3uFROhMRdXbUnImImloRVwpTr8i6eWDnb+VdprJulRDForJhscB5iqyb+7hYCYnopG1+j8QX+SgwWoGInUJ+v/1SfIgRKsh/Retxl1HAO8Kbq98
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4467
X-OriginatorOrg: aisec.fraunhofer.de

Deletion of FDB entries requires CAP_NET_ADMIN, yet, processes in a
non-initial user namespace receive an EPERM because the capability is
always checked against the initial user namespace. This restricts the
FDB management from unprivileged containers.

Replace netlink_capable with netlink_net_capable that performs the
capability check on the user namespace the netlink socket was opened in.

This patch was tested using a container on GyroidOS, where it was
possible to delete FDB entries from an unprivileged user namespace and
private network namespace.

Reviewed-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
Tested-by: Harshal Gohel <hg@simonwunderlich.de>
Signed-off-by: Johannes Wiesböck <johannes.wiesboeck@aisec.fraunhofer.de>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 094b085cff206..2f96258bd4fd7 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4707,7 +4707,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	u16 vid;
 
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
+	if (!netlink_net_capable(skb, CAP_NET_ADMIN))
 		return -EPERM;
 
 	if (!del_bulk) {
-- 
2.51.0


