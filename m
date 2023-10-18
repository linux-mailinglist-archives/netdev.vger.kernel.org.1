Return-Path: <netdev+bounces-42129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8986C7CD467
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACDE1C20D0D
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045118F6D;
	Wed, 18 Oct 2023 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EU/SoIHm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E29BE5D
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 06:23:36 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DD119B4
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 23:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjQy0vAtydbz4cQDS3ENunGNL0TFYus2wkNPX0YK/kMxssc1o8x0ZVX25lhsq/oDlQrpDlXaEWJpnJYHTAaIVrc5KVV12yt9Pbcyp13g0UkNV+0BFVjLb96wr2c5sOdOjn7pVuJQoISQ4GsUi7X/bqFuiXFpNiZ8X51dDhSrtsSZ9K3JVVcTLBW4D66754rFO4HncPPnX3qsRjc/st0YRJNHsebeM8GqRtxU0b4S78EowSQMyv+t/4W6zUP3g0RQIqWZywVL3SZluamYNeGxZpTvXqxkOqTL+PvOS7uL/3GhNYhkiyBk5/4M62E6NBkwkBDhWSVw2KlaT1lIzN5X8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jsk7n667X1+bbFH1+881aR7KrBz9RB0nv2fFFJP6jcw=;
 b=SnHZCz8dwQYWKPeQdZqurOT2xt2psiYnDPIPtd2aEh8eHaeQQ/zk5WykcFZm9213xq9xjjN+uFy9qDtDd2+LvDXn7hdgOzVaCh2rumPWXcUFfs+2B6IL1WQ+yn+WHeQDf0aKHyvaBl/OMbNJZ6CZhjJl8cALKsaspt+luUSVuGcZB9dUtgQ8sq6OMRcKdnfJZvkNn65rLVc/yC7qGRj6bbn6rOlGu6wfF2sjX9YJgdg48PtwA+WbGTebLopOb7JHsQARZV8hV1TMq60YL0exgX/cygK5R5aFNJYpmWKsuQA60bLo8QCTmkaSt3blViURvL0Y5+xYKmaD9Zh6tK8xNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jsk7n667X1+bbFH1+881aR7KrBz9RB0nv2fFFJP6jcw=;
 b=EU/SoIHm0dtLQXACUCba9X/LvlaugIfOsNMqbFxVyZjlN2GpSqyJzxL4Clw3nsI1+SpXThwWQQe5x4BoxNMYZCrgupIlwNykNsmPEeCUqRMZXqiCTBlil+WTSLgx/Hhuc4giiVOQEOWrLxChZEcA2VytCi66Nbo+Fmr/wfxMRKn4uIBO7CM9NHWV9vOJqmWFXk9Hze54CLBRaaz7MDeMe2PiMux3II+L4MvzQy7gyCRQG1YZ9JJbR5YI5IABYd/U0tQUjAC8bKTNBQ78J/ZJFWlnMAshFjvGoY859Vvd4EraM39pRFVqzSa6+ZVPkpd7yCze8OyRS6ULtCMYMbWdog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 06:23:09 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 06:23:09 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: netdev@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH iproute2-next 1/2] libbpf: set kernel_log_level when available
Date: Wed, 18 Oct 2023 14:22:33 +0800
Message-ID: <20231018062234.20492-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018062234.20492-1-shung-hsi.yu@suse.com>
References: <20231018062234.20492-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU2PR04MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae7d536-19e6-48d4-4baa-08dbcfa2b294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mNnfbzrQ7l5kcebMXwbidVzO+DwtyuFv8G8dfH2yVrk4vQzevidag5pU++wwldSVRpk3tYDbC8oOfez3j9QDg3DTDoJMJ/XYUErOjZUgdJvNC7QyAMxWWUh6odlfr1825PhLCDp2uDxPyWBtlk2dlzYpjYTVJHeXubhUYGhkM5e/QfDj+fCASbePUs4BuX5RSpw3j48Fg30FjaHQokcS0NA9a3NxDewz0xK50cZ7dKTtXIfAnBI7nAFS5jwBu9cyd03UcmShOB+lgjReQxLALIv4VTxTLTHiIv4hhzK44T6LoxCGfbuM6io6eLrnZz7DoxfUDqqAQZDu84ORznN2hIbPEwq2FRBdKCmCH/l2+p5LwQy/QJDk0Lsxu/SPw+j9GWbKWAjmYuEJRhBsVRuSeLRgcECDrOiGH7MBI132PK1VudVB3icNuwk9hL6NE+1PVNWKgRFodbv4D6JpUOTsazdnXMBASyapNq/9MZpmzVLRBf0NQtkvSYvJmHGzXHM/5guB5Sdl9AU7+x3rjUhsuX9Xge2jMWYm4OLQhmLA6qW0RQKLqWPs9HVj+LMCPJed
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(5660300002)(54906003)(8936002)(66946007)(8676002)(4326008)(66556008)(66476007)(41300700001)(316002)(6916009)(2906002)(4744005)(6486002)(478600001)(38100700002)(1076003)(6512007)(2616005)(6506007)(36756003)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V4DgJ4XJx4VhxG8CL759v47qMSeM3RCUQ6OSVwF6PsxWrYiXBQE1YP9iCfKn?=
 =?us-ascii?Q?T6snyZzCvKwTr9xiOEHsx5je1VAdTnTh2YwvBzLqr6kuvlX/Vc9iubhpsZAM?=
 =?us-ascii?Q?Z1oxw+/9fZc761bWjFK74vupbi5qzKhwl+rlSiOppcHJFClRX77tpVztVmhu?=
 =?us-ascii?Q?Y3YQG9jYIv1AalI8fvSqfRa8YQRfu3FM9C9lzIEkQR1BcyjL3ocjX+3oMx7n?=
 =?us-ascii?Q?tmhmBxTSTFRRk9RnXbU2MTNfzFFty0iq2o8lxcz1M6diuxCzYPWVutAEPeJS?=
 =?us-ascii?Q?t5OLRmwIbukf9abk88pMIv+LgvDNb0ZC4tUtEr0JGW0Y4fdXyQfMvLbQYK/R?=
 =?us-ascii?Q?8+1Sh/746eqkwDZ0HKjKmfT72DL4xM90cYAcr3v6fqCMMxCt1c3NDnjH5HAk?=
 =?us-ascii?Q?5n9xNhyDaXj9w0VcpsNEn4NLtb8gjMurkcBD6vbMyHpjb8jQ4FKVzVgh1aI2?=
 =?us-ascii?Q?HZsdcgtpXFoOXOCD8kWh3iWR+7RQJABSdCNFTKiLSI3gNq361vW7FMLlfiwx?=
 =?us-ascii?Q?pHFHzO3HRiak3mm32ObFemH+MmtXC4g+efaFkpO7EQdIZAjNA/h9P9DMZRXF?=
 =?us-ascii?Q?6E3GCTqpaDHMJUhNGOO/+EJEfHmh5Cj/jEAMjIryR4TuvYcS3ShWLMwBsS5E?=
 =?us-ascii?Q?RIhxkzE3Y13++hiiAwvH8Pb93exQ9kkcI1WrlMT320QlMTpSBOzPodoU/VkB?=
 =?us-ascii?Q?JZ0DFHI71rwyw+7WeanjFVgJUBbexQJnDrYPnfZrrXUySpc5xuxaNTbC2Zdz?=
 =?us-ascii?Q?Qx902LgijIig2IljQTJ/17kBfZInzgin6Pebecy3bTTUGuMqJENsU3pgLhn+?=
 =?us-ascii?Q?0LFVNHp6KRdz50vh0F8Nix0BAoPstWly2GAi3fsyXDueHa6v6Pp1XFfBcYwj?=
 =?us-ascii?Q?8k+++HXBEoF0CIi9j8cNTa3fPUxu5tcSz3UddpiPYxD6BgERFlTpHYMStXU+?=
 =?us-ascii?Q?aR+AoA+bmTIOlLXL8G/dLMl4bfP+CCdYB1qekUkwT4gicIBcGM53fFfCpaHL?=
 =?us-ascii?Q?sc3I78JPHYWwhNFq4bfg4stzSMOAT3PXp+noO9Jiontscd7kciB59AnE71yk?=
 =?us-ascii?Q?/wsF5ExEFGsATYBGJX7Hkxm1KqMFX3gB3W21ym8j3vpEOU0LLZcBrxOfePTt?=
 =?us-ascii?Q?o9lnW+zvVO4N/fRABRMi1ZEfeOpbMhGx4z3hBQ7yxP07zq/8r7bJmAmK3PGx?=
 =?us-ascii?Q?yfwqwoW3isVTU1jofRX8Nxpv4TAYHotWKTvuI1ganEV+vo7a46qkiRHNwt7J?=
 =?us-ascii?Q?MzkDwsa3lmpse3UFwIUh+mHVonFuLvDJx6q+N4VgoWaUKwvFG3+nIh/JrQOI?=
 =?us-ascii?Q?Bt+/ba7mOit3N1L+w7gPzKt9mg6NbpsOO9PwCcp+OrO7U2NO2zkeVtObOEnu?=
 =?us-ascii?Q?Y9DVpR76xfxuTpcDaaDK5iWF2PDVDtceo6gSGSCVK0vYPMtuNdGkmtNGYA2j?=
 =?us-ascii?Q?cwBNBPA4l9gqP+t/pkcppCG/h4XjYy9RSEXo7vLV+50kdEesuafNpeJFmJ1N?=
 =?us-ascii?Q?JAF3GwolIflFm/MBnlA1dUZ/Od6NrE1KrIDOW2TBsDObbjRAfR1NTd7V3sOX?=
 =?us-ascii?Q?L3dN0Ti89c3d9R9G5Xx6lO8BXt3KSMDv12MbMgLDFYZ4aV/u8U9A3/6sIBkw?=
 =?us-ascii?Q?849UCvVPPQEXllQU0VnjWPHd8Jqlf+Grv6pPYVU9e3wJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae7d536-19e6-48d4-4baa-08dbcfa2b294
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 06:23:09.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdZSm8LObZGgsxnc65Aoxr6fg6afM604RlTA0iDwBAhaPAG+W8XmqvX5Re7mv5MPEqSv0j1ZLl/lVnWqPe9pGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

libbpf allows setting the log_level in struct bpf_open_opts through the
kernel_log_level field since v0.7, use it to set log level to align with
bpf_prog_load_dev() and bpf_btf_load().

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 lib/bpf_libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bpf_libbpf.c b/lib/bpf_libbpf.c
index e1c211a1..f678a710 100644
--- a/lib/bpf_libbpf.c
+++ b/lib/bpf_libbpf.c
@@ -285,6 +285,9 @@ static int load_bpf_object(struct bpf_cfg_in *cfg)
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
 			.relaxed_maps = true,
 			.pin_root_path = root_path,
+#ifdef (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
+			.kernel_log_level = 1,
+#endif
 	);
 
 	obj = bpf_object__open_file(cfg->object, &open_opts);
-- 
2.42.0


