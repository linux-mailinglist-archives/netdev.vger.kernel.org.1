Return-Path: <netdev+bounces-20312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37DC75F08D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231C21C2095C
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A0C8495;
	Mon, 24 Jul 2023 09:49:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E98460
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:49:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4945F49CC
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYWgHAqlyegtSzn4+Vbvgqg61yivLwss5bSpfzCApN6ZAnMqQBnNuAEnBz+nusboqtt3nFBygOEYXh0GdesnrEVFNh0UGRT8A2C9Ia9uz0z+lLi5XIfB8HZPaqscaRzA3GQc7UtyKSLYM8zGIVVajk0G5j8yIpvNtJyWOpW8HWhF76os7kiBBVoQhiPaY+Vcw0OKzJEYjxjByFC/Dru8idGDlnxsCebp/PVnqphvnh7cO1DAgMufK1epvLl+3xNQRV+/8j0HEugnSB9Gb2DUpbpM//+0ti18PVPVp742B6uY+tGC3cUkmZ3fjl9mzOyFV7N6CMa8Eim7FaTTXCh14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTz3tLk+RbBDh5f+BY0XoOh4y69MiZIINLg5LMsirM0=;
 b=lyrjBpDf3Jcmzjb6Dilu+F40DsxzLXBexhuRewR/ETKs7YYVNATVT0IjTv2PWI6SrYyvXe+pcs+jIYx0OJzjzpBWA+SH71TWruOLF9z/YYIBLAhP1yPgoE/Q2t6bMwKyJUAw2wF3rDzwo0zGs4jVge0H0Y3o4sswfPTLNbu2E5fosWrt3w7vlpRuXIDxzeRpAXCPQVWmgYpv2r021QJf3bi0wgH94ErgHdN8k98ihD8K0m5WTp+emnOWLU2zc8p9b+YwF2e4BPyMHSp/pvqsVVrCljZr8nY0fWCgzc/Chpm3vhgDHivtaAAsFSsCpsrWL9Y87zPEcy3cwhCgyWCnWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTz3tLk+RbBDh5f+BY0XoOh4y69MiZIINLg5LMsirM0=;
 b=lAfYAWGhFlxUq1rOQxo67ssr4eYFJwt2Y4uzKgE4MVfrJmZs5CjRvbxRaLN9T7xZc23DQYsSO1jjpyzxtT9XzFkCJyAOj9TidGiQNkrW/z4Tsg2fzzY3ov9nZNWX7JQSwrAaaO4rg+dOUvscZq+q/MkAKcPpc4HpV43KawxZV9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH0PR13MB6020.namprd13.prod.outlook.com (2603:10b6:510:fd::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 09:48:50 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::c131:407c:3679:b781%5]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 09:48:50 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Tianyu Yuan <tianyu.yuan@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 00/12] nfp: add support for multi-pf configuration
Date: Mon, 24 Jul 2023 11:48:09 +0200
Message-Id: <20230724094821.14295-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH0PR13MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e9a586-32f8-4b1b-af06-08db8c2b2ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Okrn2Alth0d4UDg/FBQ6cirvcoZKa+1N+GVSvq7xoovYlkDxObE57tJVraKOddh2H6mL1LG89GwVsImnPm1iSmdesF9U2Gxjya42EMmapvCgaWPsaYEI3XHISoT0Krftwpg0DgMhttcQ9LwXUl9dsMWr4a6auczERAeInJKEDWhPEw8LmbLesBB7KEkWZ5L+emSkiO6C9/TtyMS7Lh/GkDWQozRzcC+g1fvCDBNuWMk9JywWtxceIQO6pbcE/f1V5GTjNrNxz+MJracghtl89RT4xdb4ubakPigITm7eJOc6XeeYCJ4j4tsNZcNH3MeXOf1peaLT/Ck6ZzbxSyIl24tjdMC2frbIzKlCABq6PdoPbfO4P1pru7d7ee5ki3KB2MOJd7dnAR8upgF4i47/G1DGOWny8cBNx6WiUfw/f+ZmQRG/redG4cge6SqdS8zuIKUK5m+z0fJWHH27uxe0acz/+C5LDFx1RN1jcw0sdfLYcZKCQytpFZMJCCMEdyDJpaI4OjahGrn8khoCaOBwGdJzrmj6nGhuMbJ6VU+L8K4zFIRe5dFo84gzI4mPam9LqFVy7UDDn3qYko8pFnkVQtN9r6RS1sSM+CuPtbS2m9tDaHT++f22koX5WwgaZNqD9xi4J4Pdriof8ymOYiBaW+hm4QiMHW+2RySpB0iuu9A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(451199021)(1076003)(26005)(8936002)(8676002)(316002)(6486002)(52116002)(6666004)(86362001)(54906003)(107886003)(36756003)(38350700002)(38100700002)(186003)(6506007)(5660300002)(6512007)(41300700001)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(2616005)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVg1ZHIzUzhpdjUvSEMrcThWT095SXV4K1NUeU5rZTBFLzFreHNtRVg4dE0y?=
 =?utf-8?B?a0FNR1NlUmcxd0JYc29iV3p1Ni9RRHpWNTQvWldKcUc1ZUk5QkcxdUJmUXQx?=
 =?utf-8?B?Q1hoY29QR3kzZFVkMlhraGlQS1NkUVordE00KzZUQkROdi9EZjNEWkFIZWV3?=
 =?utf-8?B?UE1RdjVydFplRHg4Zmx4c0hTK1Q4ZTl4YWd5eXFrUzNMSjloM1JnZHpmSjZ0?=
 =?utf-8?B?cmticUJST1FDRnNXQnllQ3hWSzA5SVY2THc4djU4aUJOakpuSzV0STN1YStu?=
 =?utf-8?B?MjlTV0JGVFpGYWRDWkZpMzhXa1BXYmdhamxGODZiMlkybnBOU096K0xZYXZu?=
 =?utf-8?B?bVpkZEJJaTUxVS95WTlCcTdoVDFhTlFQRUpXWXhxV1NLOGhBd2p6clJKMlFG?=
 =?utf-8?B?OW9RTzdNaHFldklQaHhkYll1ZTByWFk2b2NYQTZuUjIvU0ErOTd0cUpUWDkw?=
 =?utf-8?B?ekl3b1I1ZU56MUF6b01IN0RMMUdVTERDOGFMd1hNTmpqZ0k2T1NIRUlLbmlk?=
 =?utf-8?B?UURzQ3JJL0xiRnRsN3J3RXU1MTk2eWJ2WEgzZnBYbzV3aXAwL1JJNVNHQXhL?=
 =?utf-8?B?VmE4ZTBIQmM3Wkh5V2RsQmFGbmhEVWdza2psR1lGdWJOcmlaa2xmajZoYU5W?=
 =?utf-8?B?LzJyTXQ1T2NMT1dsUWlzNWNVZStzSm00TWIyVThrd2UvN1ozL3ZwVjF3L0VO?=
 =?utf-8?B?WnFIMUhLYlNEUm1iNGFSbkcvMmdQa1hYOU1DZldpV0M1c2JpMkh0MENqYnkw?=
 =?utf-8?B?amt0bXNqMWhPbnBxSVhteEpiQkFjVyt2aTcwcG02Z0ZRY0RXNjB0MU91cXhx?=
 =?utf-8?B?YjZvejFDS3BjYjNjNSs3M2tqcEdqVmU1azM0eEFRY2h5K1Vnenp3M1ZPWEtl?=
 =?utf-8?B?TllyVUNJTVJlN3RXa0xNbGRrdFZGSXBFY2p5dVdzM2xGdjQ4ZTgvYjY3dzhr?=
 =?utf-8?B?OCtIY0pEUDlldXVvZTNRR1hLUTJ2clA5cEhqNWpNVXBhNVdVUVhmSHQ2eDRD?=
 =?utf-8?B?WHlQTS9mRUMxV1VVWkMzRkVUd1RjVnJtYmVhbnhTNnJzVURFT081RSs0Y1Ax?=
 =?utf-8?B?VjhDdGFoNjNEQXBFR0pBSThMenJhMkIxQ0c1VWpTYnZneWRtU1VielRHQUZF?=
 =?utf-8?B?bTVCSVZOTDFZWFAyRkFub2dlNFhCeHl6dU1rY2hMQUhzWEtsS00wNFNsdUN4?=
 =?utf-8?B?OTR4SGprdmVwQS9ZS2FtamdsRytmbDR1cnNwZi9BZ29lREdJanhXYStnVGZ4?=
 =?utf-8?B?djAreFRNazNRUVg0VTI5ODZEZnlPZHc0V1N5RGJJR1dNYTFacStZN1pIWTlW?=
 =?utf-8?B?MXJvT1IyZ3NqenR4NWFRN2V3T2NCUGNFak5XU1dvcDhLQUVleDltK0hHTjVR?=
 =?utf-8?B?Z3VtSDBGWDhXOEZGZVpNblc1eU1OR0E5ckVyc0tjdkxYTUxXVk4ydlJqSGNt?=
 =?utf-8?B?dzRqZ2ttNG50a2xxMG5jZXRCNzIybTYxQnJrdFdqeDlTckRDblphdUt1S3F1?=
 =?utf-8?B?WmJQYnBUZmZsQkZoOHJGbzIyekVNU3RDbWdkVENKOEJSMkJTMEU1S0ZDNUMw?=
 =?utf-8?B?T0p0cGZTWjhDVEIvL3VOMnA0ejdKU0NSdVo5TC9tYkdJVzQwa3ZCZ3U2NTd3?=
 =?utf-8?B?VE8vdSt5dWtBcUFhWHpleGlVWmh6eEk3dTgrR2xMQkpJUmVTSUIrWkdFTWhP?=
 =?utf-8?B?R3ZWWkhLcTdNZ2NybGxUMlRCRkNXeGZXcHY5aG5jeTEzVGFhWE1yNm5LNVVj?=
 =?utf-8?B?N2pSaXdLSVpObnA5clRNSUhqQjQ3NzAyUWpZRVFDdUFpbWkwdXdhUFJGYm9t?=
 =?utf-8?B?QVJEQ2Njd0l2aHlGbGZiZFN4S2Z4REhlU0taUW5oR0dYS1NIc3VDdExzNFNv?=
 =?utf-8?B?SGx6d09FYVlLdVE4eXlXZHpEdmpZRmpJamlOZTM3VGhTRmRacWV3S3VxMnhW?=
 =?utf-8?B?TU9BOCtBa0t1ZWNJdEROSTkyMnhVd1dIRkFNRFduR2FOdnp0OWdxeWlJZVNJ?=
 =?utf-8?B?YWZGUGtFekFIM0UxRW9SYlFGZEhjRXArWVMzanloL05mZ3VpV0ZyZ2tEWHM5?=
 =?utf-8?B?TERwK2p5TSsxenc5VVRVZWVHd1RkWFZwY091NHdRMmh6Q0dZWDRxc3VlLzhr?=
 =?utf-8?B?NXloMUVVb3BNb2tOd2xlcms3Sk5LWCt4cVN3dVZHbmt0R2wzZmNVVVNqZUdt?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e9a586-32f8-4b1b-af06-08db8c2b2ed7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 09:48:50.1659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDuXVUCZ0Ik5TDmhNRZ1RApivLB4xt1C1r+8qqY0A6jpNI6Nl5SoA1hYGgE6ZHE9WKrChOaj3XV1qB7RBZKc3G626ZYHupKJqA1KFvsbQFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

* Patch 1/12 and 2/12 are to support new management firmware with bumped
  major version.
* Patch 3/12, 4/12, 5/12 adjust the application firmware loading and
  unloading mechanism since multi PFs share the same application
  firmware.
* Patch 6/12 is a small fix to avoid reclaiming resources by mistake in
  multi-PF setup.
* Patch 7/12 re-formats the symbols to communicate with application
  firmware to adapt multi-PF setup.
* Patch 8/12 applies one port/netdev per PF.
* Patch 9/12 is to support both single-PF and multi-PF setup by a
  configuration in application firmware.
* Patch 10/12, 11/12, 12/12 are some necessary adaption to use SR-IOV
  for multi-PF setup.

Tianyu Yuan (4):
  nsp: generate nsp command with variable nsp major version
  nfp: bump the nsp major version to support multi-PF
  nfp: apply one port per PF for multi-PF setup
  nfp: configure VF total count for each PF

Yinjun Zhang (8):
  nfp: change application firmware loading flow in multi-PF setup
  nfp: don't skip firmware loading when it's pxe firmware in running
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
 19 files changed, 474 insertions(+), 90 deletions(-)

-- 
2.34.1


