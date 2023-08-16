Return-Path: <netdev+bounces-28100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC47377E3C9
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C381C2106B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35EB125B3;
	Wed, 16 Aug 2023 14:40:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31F1094D
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:40:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD19A2D4A
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRpVcejBHF44C2/TZ1OKIHrqJiPnfSGUJAuFTDc8OZ+SkNJhp1R+5kl6Tv0abgcH08L8XV13pzdCFCCb1kGb3dGDXK/4ZbVjphYCQd2biCDVUXSUC1D87NhUAinOo/pxpoo9245hEA+5UE50UizMT0iR2gy7KvbnHBqwc4P5qRWS2QHIm55upYQfF3QNoGU1WhQkEfifinkctQ/599T58TOVT848L4USpXMLp35Bhidv9SThgfJjGvwNTe4PhL6sjQbBTkUNGBzdhzllEVKZL1jNCvDpq2rBjwI1MU2DdAxu0PqGPZnWrquA99JUgMXGpyTajFyU6rgjhkac262Kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tqeTCTU5Sf8oeKaJo6AX1oq2JfxzQO2UkdJ56mYYeg=;
 b=HUJ7H1O+XSGnEXivNayLABsp2l0Ehz1VAoX0srXQuBiSW+ZIVMcePan3yPI7xhJ0w0MB0Jbzoa5IEtxzIYToFysiVdfo4RFvB8/i/vdCvm5K+ovBxKo+ZiRVMqc+nkXnUZU8Jdxa6ScHrZQfJE8dcq2CpPGiiicSgjOcSPyQ9sKb/3qT/X/gWMNPr8Y1Fchh9qIGLIIUza/rFHM8jdZ5w/IR5ZRmf+km8iPJBQowQ14WKYz42xEftnpmE4L6YLjuhwmiZmwQyUxr5Fi1t2uNRoroMhmodikehpb/TwNXCcd2MGL+EbSPgh5zfHrQ0e0PKEpWwoNr/Rj9KwKOtWMXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tqeTCTU5Sf8oeKaJo6AX1oq2JfxzQO2UkdJ56mYYeg=;
 b=b0vksDa3Fn/jZMY0y1OsQFgaEZ+1TNVqTftpDYBk8bHqEnM1UWJG6pOhdgSJXhSxCdwJneojhPzVtDX1PqGCmeXOfFi3NYdNjFve5Y7kznVchg3W+m0j80TSxL/rWVcYV2PoAk9YG+/+1DZkXttGih+R0vzx7bEcEXQY/bC3xXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 DM6PR13MB4097.namprd13.prod.outlook.com (2603:10b6:5:2a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 14:39:52 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::8de6:efe3:ad0f:2a23%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:39:52 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 00/13] nfp: add support for multi-pf configuration
Date: Wed, 16 Aug 2023 16:38:59 +0200
Message-Id: <20230816143912.34540-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|DM6PR13MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f1d584-89bd-4e2c-09f6-08db9e66a6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gz7N5OXRtsQIKMQeQoX9PfErwCkqJ1z8THRMIZc/ugJH0Vd+1tuRgrf2p6+Lsek4aonqn+hJE8nhhxCCq2fAJJZhrk47VvgtG4Gfc7mO5a7Gik8adPXXhd4Ah6dAaZ0eUxIr0Dg4ITl4lA1cRS+j4YZMHXc5LokEEXkONmYfwI06gmPmag2mnFNIoeQArSwdI6hf7P0PxCIL0f1wZhVy6WIiv4t/NzbLVMF4hNpJb0qoYB5BOshq5yFUJXOt9nE6oF6Scb89yDU4MGV3h1RYpXfu3TOttUemLhEV6UWj2jwCJg7neYsX+xnLeYgJ/AmzpPtlENRVesCb9PG3Zyd/XMmtKb+VyeDY2BQ1+0j7kXds677+OIjv9YJVyeSkO4ypZpJFgZi2yABbXU3mLgleaz8JISp6/ICvJBeUywSSh5D5yqQE4HOPtRDU4Ql/Qi9fzEADOof1a3S+KoTx4Cp8J3ReDNYr6sxUV/LBuB04KF2O0YJkyriM6zvFhL8oFryJTiYg59SvcysqK2xKh4JLyx7t5ZOtC9Hv3D9vq4urzowXcK5x598/SB2VV03eVEQaWPg0VOosr4y+vuPd4Z1H7WK7HVniCF85AwUpefmC15e8kmJPEHFmAvl3FKFclXtJkJmDhJRqvZxF/C6XOhxmVHUWzaRvqbZOdO8k4CfatkGTBtWQ2oIjOa8eJLnGiSA8BVkTa8Lo3VvYty9ISeTQMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39830400003)(136003)(396003)(346002)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(12101799020)(41300700001)(5660300002)(44832011)(8936002)(8676002)(38100700002)(38350700002)(4326008)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(107886003)(1076003)(36756003)(2616005)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFRmSnRKaWtLSDFBTStRQjBKV3Z0bVVjSEtvWDlYUVdJL0pJdnZCdkdBR2x2?=
 =?utf-8?B?VEFOT0F6aEtzYW5SWkJHaWNPRTBrL3BBWlJvMW1XVjR3b3VjVTlJL0RtL1dy?=
 =?utf-8?B?ai9ZaTFhNExlQnUrcG5QRjNNWHNkMXQ0L1ZhVEtGTnFSTWRQYmM5WlFENlEw?=
 =?utf-8?B?a3drdktmeG1UVjNJMFhBQXhjTUFjZ2lOclByaTJNZUhLd3AyZ1RIdG5WV3Nw?=
 =?utf-8?B?Y2FobUJoa1h6aTBrT3R3Qld1VFp1QkZyRzc1dDhpSTZzZVpEaXBQS2J3cE9C?=
 =?utf-8?B?MjNIWGM0UU1Zd2tXRDk4dHdGdGVqK3hVQm51SDFZVzJZSkFwRjZoUTNCSTBE?=
 =?utf-8?B?d0pOVE8wM2VjT1M4V0ZpZHhaR29ZbXJuRWxYVm9qSDVZcy94YTF5WWxwU3Bq?=
 =?utf-8?B?MHFyajNZV0lMbmNvL2k2RlpMOWRNVWFyeVhWRjNEOXFoalVNZzVmeW9YNnVm?=
 =?utf-8?B?d0hVOE5YVkNrN0VnMFRuTkdkMHcxTFYrVGFMOTZQN0crdUhJblFxQi9iTXlW?=
 =?utf-8?B?OExrMkRac1JVRnAzRzhqNDZWUE03eGNRTVdFdUp4UEJXZnp4QkhsUFUvTVAz?=
 =?utf-8?B?YTZjNmhCTU1PRlg1RDdBWk96UnR3MUxxcW1uQjEvVzd2SlYwTGFsclMrZE9X?=
 =?utf-8?B?blVKRWR3eGhyck5IWnlIZGF0aWtXYktOTVo3NmE3bFZwSXhHRDZtb3A0T0Ns?=
 =?utf-8?B?MHJ0RG4rb2ZNWXJPRG9VeTA5aG1tSU13UVRNVUlFcXZWdmk1eEQ0OEwrbUg2?=
 =?utf-8?B?NlBTcmUrSFhLL0VjNVRUS0xmaHIxZ0RFbjdlUXVHK0JRUnpEN3BVQmx2a1Bh?=
 =?utf-8?B?T1kvdG1wZEIwdERaeXhnYUREcDYzRkxtZmdmMHlzRXNvdTJ5SEdkVXM4OGpJ?=
 =?utf-8?B?eWZONlNYM2xHKzBYMWlQY1RUS21JUlMrSXFFRnlYaG0rSG5MenIxVnBlUUt0?=
 =?utf-8?B?VFNZdVN0QlBLMGJKdCs2Q3ZGWVZaOE5aNXY4Yk4wMTMzSitwTUM3MjZGR1pE?=
 =?utf-8?B?TGcxb2l6TjlSbjdCckJrNFdlVlc2MGNnYk9sbWFlOFhoalFBeGpjNWtqaGZD?=
 =?utf-8?B?OTZaVTFvYmZoOUxJbDlid2NkUDFUV1ltb3U0RFJzRGsyTmFBdlVKZnhwT3JH?=
 =?utf-8?B?U3E0Zmwya0FNU2hqT1BNSGR4N3lQNTN0NWMwYjdxR0VIMUpCdGZ6U0hSdGxr?=
 =?utf-8?B?ZmhuZy8zU2R4MUFLQ0hTV0FLSXhtcjdiNStZMkx5WTRXRHE3QXBtbzJBVkg5?=
 =?utf-8?B?RGdpSjUra3lxcHJRdHRmMlIydUZPVTRLM0g1LytGRlZwVXc3U0xXQTU3SlJj?=
 =?utf-8?B?d2puNVpYTUZ2TWpGL0NwbnJnWlZyR3hWQ1J6MUo5Y2ZIc0htV0xBSHl5YitS?=
 =?utf-8?B?M1U5ckdrUjBKMFlQZVp3T2RXRzlWNWxxSUIycVo5OGp0d2NpTjk0QVNNR2tm?=
 =?utf-8?B?cUxmcVJmYlZwUk5TNU5SNURyemMzMGJ2MEJaaXh3UnNwVkJMWUMwdjJUSldu?=
 =?utf-8?B?M1liaS8vRnRicUE3bXRKWmVFUEs4V2VYN0Zxd0g1eDlrcGlhZGJDVlpxY0ZC?=
 =?utf-8?B?MHF0cWpPMWMrSjN2dXJzVXg3UjFRY0VObFhiVktmdy9uSTFiblFzQ2tUbkVL?=
 =?utf-8?B?M3JrY0lTbFpyL3VRSkNKdzlGZFhnN1U0M1dYSmpaSmtLUVBUcldQOHd0SmE4?=
 =?utf-8?B?V1JiT1NWYUhFUEh1VW9XY1Rvbmk1V2RGcWFHVTY0clZUVjNHMEtHRktRd3M3?=
 =?utf-8?B?amFUZzAvYzBQVlNPWlpOdjlCdmpHVnpKdWV6a09MckdlUEtKQ21rRjNSaFpI?=
 =?utf-8?B?OEJaUGxHRUtzdUgyZFNmOFcyT1lOTHRjU1pEL0R5Z2U0RVNnK1I1NlR0SlFQ?=
 =?utf-8?B?eE9DbEtDb2NFUVV5VjFXL2FLYjJDbE53SnZOSEpwZUxiUEh2MGYwVVZpeE5y?=
 =?utf-8?B?T1JyUDVyNXN1K2xGa2M4cWY2dGNwQm5aZUtsYjJzRmxGTEg0V2RWVyt5cFRo?=
 =?utf-8?B?SzcvNGg2TGV3V1dUa2U3SVkxM3FUMVFrZnVQNm13SWc3UWhIS216M1pWMmpH?=
 =?utf-8?B?RXdwdEZOSis4ZVVZVWtxRmJiTUtqVEgxRXdjcnJ0TEZIUzhJdk5yWjcvRTRT?=
 =?utf-8?B?eDJMRmZ0VlFLcTJ0c2ljZlR2T3hxZmRxa3ZJQ1ZnR2s1ZmN6SHhvR25SdGF3?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f1d584-89bd-4e2c-09f6-08db9e66a6e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:39:52.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByrFPhnCh+NS2pSfHsp6WZDXpVgFWDhG4UJuluUIPtHrm06k1+fhyTuuOP1j4HG6ODdfB798d2P62WDmZ1aAcJlMoNGCwxKbsZ5drE9Pnfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4097
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series is introducing multiple PFs for multiple ports NIC
assembled with NFP3800 chip. This is done since the NFP3800 can
support up to 4 PFs, and is more in-line with the modern expectation
that each port/netdev is associated with a unique PF.

For compatibility concern with NFP4000/6000 cards, and older management
firmware on NFP3800, multiple ports sharing single PF is still supported
with this change. Whether it's multi-PF setup or single-PF setup is
determined by management firmware, and driver will notify the
application firmware of the setup so that both are well handled.

* Patch 1/13 and 2/13 are to support new management firmware with bumped
  major version.
* Patch 3/13, 4/13, 6/13, adjust the application firmware loading
  and unloading mechanism since multi PFs share the same application
  firmware.
* Patch 5/16 is a small fix to fix an issue sparse is complaining about.
* Patch 7/13 is a small fix to avoid reclaiming resources by mistake in
  multi-PF setup.
* Patch 8/13 re-formats the symbols to communicate with application
  firmware to adapt multi-PF setup.
* Patch 9/13 applies one port/netdev per PF.
* Patch 10/13 is to support both single-PF and multi-PF setup by a
  configuration in application firmware.
* Patch 11/13, 12/13, 13/13 are some necessary adaption to use SR-IOV
  for multi-PF setup.


Since v1:
    Modify 64-bit non-atomic write functions to avoid sparse
    warning

As part of v1 there was also some partially finished discussion about
devlink allowing to bind to multiple bus devices. This series creates a
devlink instance per PF, and the comment was asking if this should maybe
change to be a single instance, since it is still a single device. For
the moment we feel that this is a parallel issue to this specific
series, as it seems to be already implemented this way in other places,
and this series would be matching that.

We are curious about this idea though, as it does seem to make sense if
the original devlink idea was that it should have a one-to-one
correspondence per ASIC. Not sure where one would start with this
though, on first glance it looks like the assumption that devlink is
only connected to a single bus device is embedded quite deep. This
probably needs commenting/discussion with somebody that has pretty good
knowledge of devlink core.

Tianyu Yuan (4):
  nsp: generate nsp command with variable nsp major version
  nfp: bump the nsp major version to support multi-PF
  nfp: apply one port per PF for multi-PF setup
  nfp: configure VF total count for each PF

Yinjun Zhang (9):
  nfp: change application firmware loading flow in multi-PF setup
  nfp: don't skip firmware loading when it's pxe firmware in running
  io-64-nonatomic: truncate bits explicitly to avoid warning
  nfp: introduce keepalive mechanism for multi-PF setup
  nfp: avoid reclaiming resource mutex by mistake
  nfp: redefine PF id used to format symbols
  nfp: enable multi-PF in application firmware if supported
  nfp: configure VF split info into application firmware
  nfp: use absolute vf id for multi-PF case

 drivers/net/ethernet/netronome/nfp/abm/ctrl.c |   2 +-
 drivers/net/ethernet/netronome/nfp/abm/main.c |   2 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.c |   2 +-
 .../net/ethernet/netronome/nfp/flower/main.c  |  19 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 227 ++++++++++++++++--
 drivers/net/ethernet/netronome/nfp/nfp_main.h |  28 +++
 .../net/ethernet/netronome/nfp/nfp_net_ctrl.h |   1 +
 .../net/ethernet/netronome/nfp/nfp_net_main.c | 166 ++++++++++---
 .../ethernet/netronome/nfp/nfp_net_sriov.c    |  39 ++-
 .../ethernet/netronome/nfp/nfp_net_sriov.h    |   5 +
 drivers/net/ethernet/netronome/nfp/nfp_port.c |   4 +-
 .../net/ethernet/netronome/nfp/nfpcore/nfp.h  |   4 +
 .../ethernet/netronome/nfp/nfpcore/nfp_dev.c  |   2 +
 .../ethernet/netronome/nfp/nfpcore/nfp_dev.h  |   1 +
 .../netronome/nfp/nfpcore/nfp_mutex.c         |  21 +-
 .../ethernet/netronome/nfp/nfpcore/nfp_nffw.h |   4 +
 .../ethernet/netronome/nfp/nfpcore/nfp_nsp.c  |  18 +-
 .../netronome/nfp/nfpcore/nfp_rtsym.c         |  16 +-
 drivers/net/ethernet/netronome/nfp/nic/main.c |   3 +-
 include/linux/io-64-nonatomic-hi-lo.h         |   8 +-
 include/linux/io-64-nonatomic-lo-hi.h         |   8 +-
 21 files changed, 482 insertions(+), 98 deletions(-)

-- 
2.34.1


