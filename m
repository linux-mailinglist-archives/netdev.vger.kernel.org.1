Return-Path: <netdev+bounces-44682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 977897D92E2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62F3B21308
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96B5156D0;
	Fri, 27 Oct 2023 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aC+hqYxc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D84156C8
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:57:40 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F0D186
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCdDuUFC00B0ILzVDcgHQA6WJIrsrPwUBSPMz2RUSC+leC0FljVsBLA/fQ+5CVFWZJ0EkmGhB9KQ/ckxHZd8+32g/9Gt/DcUTcyO1zg2w1elnmla7SEymyiWGYRKF0iCFwahp2TZwcI6r55GCor/CJAQchsrpuTgRpA7lfnSegF53ww8cCD3TiyaRqLo6LjUKbfkHzb68qVmo6lytKN0PnBGkilcufNJxmuirsq2/C2NrWaExUuN/AFn50A7ic2N1KxhD8D73CCY2PE3oLEfL4ZvjYIyg3aKmjYEGM7l5Vep7jfSQIUbfzixWcb0mG7da6GCFS2PpMZfo1teuo6mww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIiI9qsQ8Xuw4D4R5MFosCNUwOX2WmcjdGock7dwE54=;
 b=lC5Ca+KzCyEBe0gwQ2mWqYj/Y7ju0GCOrBU9wp/7b/zZlYSfrs2eIkPf7Ja4aWPufSw1+oDZ8K0aK44ZvmbsE884GragBzzJ63xjs3EmvQHpnRWzFucBZ3xb7KOdy0dfzOUpDLrDW9/PEcQZI6/mjivgNPTdvzHenQtmIIKBOn4dJgQwjyBYXE6Wd5D2YcpKeBoXgsSJIdz2MDoxFgnXjXYmkVzorFFXtc9O2HVKatu9MKqs8q76uAKAKUDSdYPY5FtHu57Agzv2ODxEF847TDy76k+QywxMmp4sbby/J4Jmcf20aQTyzO3crOnO0dEB61zuksw+qD5DFWcO9t8GmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIiI9qsQ8Xuw4D4R5MFosCNUwOX2WmcjdGock7dwE54=;
 b=aC+hqYxcpiGgLwAejPvGr0uCaZh6xEmbnj2Cst8A/X/1+Oh997j3kxiO9PNSFAJgwxTUtVTde10dJfFmjs4r1GAonbdEArVJe1JG0ZlQxe/HA/DbiZH/Al/2qRXaOn19uQ/O0EaWOTlGWxHR3mIU1NBC9H3BoJT17RsCN6UUUhTTld6fBaLSI7BXpGCjIJcIwD6NFKYaRNky1HrQLXNxLIejhmYcbuuTcAcqhcgv2EwrJZ9YFxVlcMGrp4Cb08s9M6WzLK7LBy00Yn0dkzr63eBie+LeMFrw2Rxo7+fAkzZ9LuqteTrNeJ87sem9Mxx6PKWSM+933VyDAy1rzqjOjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB9303.eurprd04.prod.outlook.com (2603:10a6:102:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 08:57:36 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.008; Fri, 27 Oct 2023
 08:57:36 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: netdev@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	dsahern@gmail.com
Subject: [PATCH iproute2-next v2 1/2] libbpf: set kernel_log_level when available
Date: Fri, 27 Oct 2023 16:57:05 +0800
Message-ID: <20231027085706.25718-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027085706.25718-1-shung-hsi.yu@suse.com>
References: <20231027085706.25718-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:404:56::30) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB9303:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d2e6f9-5c9e-485f-c2ee-08dbd6cac3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DcJYT0sRnhR8s46vdktQIZkIneVZcGndNsccZD3S408TIBfc3NwZ9M/6qjle3ykNaTKLXo3vmNVUO5feV8kedMqYlgLxkBr3gRUpLO+s5fNzLnUczSSmLFF4iu/vXQ+ehiHRVko0yRrc0lEF0LRo2y1qu6AocbEYDj5TZMTRR2jnBYuZSUh3lzgLe6KXVybTDOibucmwlfbyhKCK4jospW30g+EA43XGywpcfDcYUXFgAn0TozDSxiJPlsSoVlzC68HdWsS4KbGJUlgmFDKDD9PRgKiOFUjKIHV8qMSeUJqiDsB32IV95xlVUTWD6XGOEGZPay8r1c1uIPvyYTa63UeGlALfPsQbWlRIFUrZoWB4AHBJKF4FQ1LrkLwjIw+SqJfChNExPcVIttOjJsPYMQYPTD6fSDqX+CEjsBuIx2ORksXk69sc8R2mcvb+KJYX7LBZFPbg9KYIzq+8X+haLyzsifVKnGqdzVHWUu+rMCuRNvJ4vpJv6L3WS65hRDUIu/DcBPneIalKJPOSS01u3eW2QjBO5jeetMKGqQRj5gExXa/dUh/905r2P7T5qjgg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(4744005)(41300700001)(478600001)(4326008)(8936002)(8676002)(6486002)(66946007)(66556008)(54906003)(5660300002)(86362001)(316002)(6916009)(66476007)(6666004)(38100700002)(2616005)(1076003)(6506007)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J6T8Ff1+L0tmq0aOn/dOhADirnY6nDP+Jkfk0yGo+aY1/KuQFADCkiOlLIka?=
 =?us-ascii?Q?hcK4YpxxXY/YJSj07d1l5YGyoXQ9RHZ6e5LTtPkgMOflNQjpXqu4CQ6xSpW9?=
 =?us-ascii?Q?gnDOoKW7jR5pbVX41EXj+Zh7m40qAjSB9NcLK5OCWF5+F/AcjJlHhejCjfSn?=
 =?us-ascii?Q?cFczl/9zavPiIRHGAL5aum7in8m52zKxkJYC0dA7X3zRZ8Hu+ISvGvyRDCew?=
 =?us-ascii?Q?A/Q7ecp5i2GJaaH/UIqrL8TM+tEDpBbU/XIAp9ipCz2pRczrgGLWPhzWorUb?=
 =?us-ascii?Q?cZKD5Ay837Mc6SYYlZ3+Q/Zr9GJm9K+mSVlEHyG5AG9ZZpt6qBSfHaKD6lSI?=
 =?us-ascii?Q?+dgxwyUGG1LxVwscGNBMFs5Zd5rRYarXWlb1sPqlO+kusB4khNz5q/+G0LFW?=
 =?us-ascii?Q?is2CJIcnBQ4VsQtFFDgv5xr7j/QH0w7+dj7BC/HHRQBZFh1sa+Vmgo7JUmkh?=
 =?us-ascii?Q?nrM5uhljY3OVEbWOkXZWlleP+HbhBElHZL8gOgYfNfzBkKggLckL6GnkP/bO?=
 =?us-ascii?Q?o/SoUtiQ9AnYwBBv6XjkosXxZLKztwfT1EPo+yG/X1t58yAGYt58CheE7G26?=
 =?us-ascii?Q?DZZt37+T2Wr2QWDVrggiG6WHQaouAr2yj5QcUNdqGLSOy/+F7+6H/5A3CzOG?=
 =?us-ascii?Q?6kbi2yT0CZ5TbQOdpwfPSw1fRgf/bEsDNxTmzpZc5MmxrPoGS0wTofs8fdnr?=
 =?us-ascii?Q?Jn+XT9+M11avdL8raD1puyW249VJzKz0cXNVZ+4QXA432iViILkbflIKducX?=
 =?us-ascii?Q?kmhrGd0QFJhRjMOOKoYryZ1E/BZX/u+/LcS7Bk0llX0R4965UwZWAwz9lcSw?=
 =?us-ascii?Q?bcB5ks2kutK0FWOVlQepdZaKxm5bZXAL4H8q2/GklPMklxyxiaGRYYvXKga6?=
 =?us-ascii?Q?WuKboQ7PBgLlWqBVGhW0myWnt5VVFrTlnHfNPkwf896hE3uO/p524c2qrriT?=
 =?us-ascii?Q?8yDcS9jC9zh7Mm9jptGpomdifjgwLqoLqhQo85nlqukzUHl1D4d7pcaACT0o?=
 =?us-ascii?Q?oTSVLieY3YW9P5TtYB0Og+bZr0QLP00bjuLeC8a1hpCJXqxcnpAIoefgFcQx?=
 =?us-ascii?Q?xUL2WJUVil71qOxEnV0x0Kh/64YB8RBbNuP1YCTcU+VnTGeNjvi1r2A07u5j?=
 =?us-ascii?Q?REA9+wokHgqlHmQtPnmhY+IxYtNzSN479pFhskw+y/KQ8zNxBVoaDNwLJWqU?=
 =?us-ascii?Q?6d8nKNqiJlsEClgiIbwjqVFl8OSfVZwBeTONo6x/xcIddPKzAtk89TGr6Xgw?=
 =?us-ascii?Q?vh/kZXS0/cwJqbpK0UzLXcySDobUTyisjJB2Yec5OtXe7MLduHSvYSsPqZnx?=
 =?us-ascii?Q?9w2q/VMh0FkXEE+TQ/1zG9L51I7BbjGIhREITzzjIWoykd3YccGZy+8F1yAK?=
 =?us-ascii?Q?m20OWL49BNCsONMdms0d6mFqx3HgXHa2oOWwghtud3SvGeTzkLXsR3ynPrv8?=
 =?us-ascii?Q?gLiKG/HBxnEap1Ebgu5jBwtdVpUcJwpjC6rZRzliLVSh+MO9tRKzDM+HFYG5?=
 =?us-ascii?Q?d4E5YIH1Ea9AagIIM7ZF2GPD0YxqD60It1uD7PnBWDlA/O4ictaC5c0+GyEM?=
 =?us-ascii?Q?Y4PYeQZ1RmMB+1OEsUzsvCAuxDVYoyyacAX7QwARohHWLqbbzzW72NEiuQew?=
 =?us-ascii?Q?fq+oZ736D/9G8RZ7mjs0zGbdnpGkjsINbB+fEZXhGklFfu1E3UfRTi3tOTpi?=
 =?us-ascii?Q?7Wbpbg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d2e6f9-5c9e-485f-c2ee-08dbd6cac3cc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 08:57:36.0534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkxlPQiMfThacebKsMjgog0clWLpTAkAQJJ8chXemI2COej7qXl5Jg6+/NbDXusI86FmzTedLRyAZiEmfW/uHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9303

libbpf allows setting the log_level in struct bpf_object_open_opts
through the kernel_log_level field since v0.7, use it to set log level
to align with bpf_prog_load_dev() and bpf_btf_load().

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 lib/bpf_libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bpf_libbpf.c b/lib/bpf_libbpf.c
index e1c211a1..4a8a2032 100644
--- a/lib/bpf_libbpf.c
+++ b/lib/bpf_libbpf.c
@@ -287,6 +287,10 @@ static int load_bpf_object(struct bpf_cfg_in *cfg)
 			.pin_root_path = root_path,
 	);
 
+#if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
+	open_opts.kernel_log_level = 1;
+#endif
+
 	obj = bpf_object__open_file(cfg->object, &open_opts);
 	if (libbpf_get_error(obj)) {
 		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-- 
2.42.0


