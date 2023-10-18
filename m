Return-Path: <netdev+bounces-42128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052EC7CD466
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2AE281404
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7248F6D;
	Wed, 18 Oct 2023 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EoUzVCW+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08D4421
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 06:23:28 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55AD1FF5
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 23:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFjeYIp8yhb+GJCb80bY9DmkxlDIAxnMU9Vq0/SR00z+rslPqwFaqCOdDjH7WVE/er2bzDODtrGF9S9KG40YQAGMh6xYCCsuN1a9e2SYXpoJysXnGWLsrIMAEefVLdh1Aa+NOWgSWX5jWGIytFIUT1nqvYoAzMRJCkBzl+nYvqOGShESTo03DbgR2D2/ms7kHBq5RWNE7LWPZAdrdAWV0HJegesRJ1HJ766yGzuBHSFp+0bakYjEmimDjTNw7+2vZOu/KjGnGkHSyk0tK09kCuTi1DgoGxhjnSVMH28A+tZFvrU+gJtfIHVdjj/U2a9gt9oaXP9OGoxc+9lC1iTQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD8B7/bqaISz9w939Vm463F/sJs9rkM958H5val85C0=;
 b=co3u3gh9cglA+UHxjXFWqTXW4DXbUq4Oap/fscVDEI41+RKLZ1yng9GWhhtWsABgED0cN4HHjdh9O+xg/BzGEC4hYWDM/08CuzCIZR4WVqIozSWUP5jKqqF9ZQq9aVuSxkk2Ya9W4ydjOsmI1voEZwCqDI5AiMYFxccxZK02vfY97dekb/RHO8RIcakb6+J2FR0vbBTqvZb/D111ubtYt/1pa2YyP94dLJWjI8O9hnY26n+RmzxdEu5VAMB8WfVHzLxhkrS4sIejisI05rojEBjBrLwGxItXpgTlIJb/W3IamfxxCxa3+5abw9GwiC13P9LL3+RVeITd4mFpYZJmXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD8B7/bqaISz9w939Vm463F/sJs9rkM958H5val85C0=;
 b=EoUzVCW+R26gV0UpGNTORQW29uBuPBY6zfZ/OVABV181x5LR8fGAtyPHfHh9PHra83q094tjl4SDy601fKWLIBi1M7CTY/VxdzvFBjwZw8Rlodfpi7be12d9543FyvjJh3tkG0Wgqrl0mwkRH0DVZz4/izq75g1qOR28od6EtR1H4zu+0cdtRLN6I9Nw/LifdREmUds4t3D8F+DbLeRXpLidxlACr3Sjw1j0iqcHCLDB/8qapoU8Yx+g09djV60skGh4W8rhx/BAqMpjO3t8Yqi8AKw+fFau4dwaA0+FtuXF4ApTVpxmtmzSTZUL3EbAP6Wq+znhO/yvgtBa6QeqHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS4PR04MB9434.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 06:22:55 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 06:22:55 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: netdev@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH iproute2-next 0/2] Increase BPF verifier verbosity when in verbose mode
Date: Wed, 18 Oct 2023 14:22:32 +0800
Message-ID: <20231018062234.20492-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS4PR04MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: e348762e-6193-4fb1-a85b-08dbcfa2aa1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aZIDFdVwNHfE/lbo/RffwlBznvR8Y9odIakEYEdVMmTOYlBe8qOlziDo2dBnDzEQ6FW4Slnvd/ng0Db7uWA7XTtAUVfJcQMnoCY+mCXkf8FySHGF5rgJKNjGhJaFF1FuESZKSjOLAm1JrCLFwKUmbXARsF2iQ4i+RU3EInMp8QFgj9fa/9L6M+6NG7AxK6cynaHlYKziBbjyjrrQ8tLFVT2r4f3TTbIVdX62FHF1AERvHWe4WVKXbCfPxRoceppXvXUu4yXdJV0GFyNvQ1IvGBzRkdRL42ySvMk7p2ZwxUQujMBKXLfupCOTP9tZC3fKtOVwsIhI/XT8Aj/EdErceAWILLyaBA4//LRrQAFJwN35YKv4QKsLMF0Py9yLkURZpuJ+BWaL4ljVYzHXdU0jm7xm++5bMonhnk5BOQLxbgfdlblxKmBlRJtdVByI1CEoQJfYHDPRi4VWi0l/8CLi/5Y7/Zv4EphlPHnUSNqsJhMgKRfz0201jpemFWusEDxxxiCWkx8H7Ju8QDSH+W1ejPJtyHo9dtpWWp39+MyShxgyCD3boLHxxxsCwRZu9efv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2616005)(54906003)(478600001)(6916009)(6486002)(66946007)(6666004)(66556008)(83380400001)(66476007)(86362001)(38100700002)(1076003)(6512007)(6506007)(316002)(41300700001)(5660300002)(4326008)(8936002)(36756003)(4744005)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wJZgUzHXDq/AL+uhBHW6ajUARLhufXmqSdmPq2gCW926LZArvyBi3THcVadX?=
 =?us-ascii?Q?X2phu+Kz3oK4gYm48oM6VgWB14NkODCf+XeiZJQLDLhrJS68STUvA9sBZKsm?=
 =?us-ascii?Q?2KXXUKz84XRhEZQ88vBIOQHFJA7G29TtYf9F1/oxeJJnXSrSDUeL90WwhmXz?=
 =?us-ascii?Q?NDh1lkdqkzaEpbP8NOM2JiAt44f91bKRyDAuKkfL/4LM9Rq6l9MC+LHF4JjC?=
 =?us-ascii?Q?3G1XwUqSekIY9JkZin2P2XUqSNw1jRYQtE8FRc9RSyhnV/B6srb6sJJ3Jijz?=
 =?us-ascii?Q?/Q9SdUrHr7Xn5ufMVlIRBNyJMPOSUYRSme/VBpRYCc1G//y1l/FJQ2enDb2I?=
 =?us-ascii?Q?TkTG8/ODodIx2YMBK9AW7h4Ba32wtP8zmOZMufbstkdziXyK1o+ceXlV+Fv8?=
 =?us-ascii?Q?BIyLgfg+4oCr90IQrv0jkiA1B4ALYC3/ScGl5SgrBQnhX8AXdxbeRxmmW2NN?=
 =?us-ascii?Q?IKtTMu8URIjB4oe+TfVL6ofeTdHOdsRaLJA8FgpKXR6PpiMjmJ6rEWhehi9Q?=
 =?us-ascii?Q?yUJEpkkOD0vqG8pg+yBw9Zz+YJU6EEGwPK6sFSpw4muI8obiYRGsH8zc0j2f?=
 =?us-ascii?Q?o0lCvxkzyhayzJ/Iqs9r7DoBwN3zdOAeNb/ZALSVQSFWcqtLee4q3RWVdzSH?=
 =?us-ascii?Q?oPHZiTd8PM0YfEONKmPtHs8wz3GccGl96ufi43o8wwhOsBjSa6XYCAdLhNMn?=
 =?us-ascii?Q?1rT6IHlfnyHPWxp45qs/DjjgiiBNY//v9Cn7FW0FjQ/3HudoYDp94vkXODRH?=
 =?us-ascii?Q?rHgFhKzmqSPdS5VoyZ04G/05dPvKNYWBKW58aeED3ivNo8QSAROsf46SsS6r?=
 =?us-ascii?Q?IPIFhdnqRq+cJQ6LZCMaFs3xw2U6uaejl+cZCrU+2qw2EjxtEsMKiXMza+jX?=
 =?us-ascii?Q?etULFobueCKivO+BqDtKhZJ/4zz0b5sw81tHo5eR43XCv/Fa36aZzzPIWaVa?=
 =?us-ascii?Q?abNEtMM1ulAcEeE7kBmkJOy/UM8OzmBRQyl4QsB6XRNMJOevTmM5igIZS7ZG?=
 =?us-ascii?Q?sgRywNUvvsHqlYXMLkaX25ti6RB1EIUs04cV8Ly/p9W6GQmeUzpVZA7kSViy?=
 =?us-ascii?Q?WhjaTfP/W0vUKQb33alTTz1xmzhJGNRVoNAKvMLKPPG7ivmxVwydeR+dajxp?=
 =?us-ascii?Q?nfIRA/xz0fHbZPxNaXSCEc8YUYGrwjOXpgpRc9GT7uwf8rw760iFTzJUItWI?=
 =?us-ascii?Q?O/rJnJy2Os3ASaZINAnmlac/MKgnxC/0GvkciVb7BH/bCLbwpubAMUzTJZGz?=
 =?us-ascii?Q?TNSDVTroWRsQLmcrKVf3zJgfE+LyhhPwmlmQ1PwD0rUx8++4FdxQTvsCBZ/M?=
 =?us-ascii?Q?A3TvPVX/pbmmcZN+RYKd0RBXtsk0N3js7QpTXjccBfcrB+SGBX2uL67ZF3uR?=
 =?us-ascii?Q?VEKOZU34CnWtZP4cGrPFF4jydDxF+tAAi7nFp0Bkxqm/X/B59yedy2zxTDL/?=
 =?us-ascii?Q?fMoBPA6pqUsee6WljdMZBQJaE0jixSt7V386og/qH/WtXsbLABCYxxd5f5Gr?=
 =?us-ascii?Q?qGChuc2LCISCBRVfz6FKEnjVYD5BE52p2ANUGqkDJTMwYHWewaAoD/4n2uP/?=
 =?us-ascii?Q?0aA9CJV6b2rtVgSar1zfqSXd+/VCgM2pYNJJbLoaqc0fHviwKbpzv15vgXV3?=
 =?us-ascii?Q?pFkL2GGhbMit1bkRQsbQHQ+920lEUm+jxrHGyn+Lj3Y5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e348762e-6193-4fb1-a85b-08dbcfa2aa1a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 06:22:55.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YIYUelDtGWVI9IJMPUodlWmKkgmH6fJ9L30d9sg95dYLlCWoYLEc70NbXIPP1rFLMXlQ65fCu8KAXbT5FTEsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9434
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When debugging BPF verifier issue, it is useful get as much information
out of the verifier as possible to help diagnostic, but right now that
is not possible because load_bpf_object() does not set the
kernel_log_level in bpf_open_opts, which is addressed in patch 1.

Patch 2 further allows increasing the log level in verbose mode, so even
more information can be retrieved out of the verifier, and most
importlantly, show verifier log even on successful BPF program load.


Shung-Hsi Yu (2):
  libbpf: set kernel_log_level when available
  bpf: increase verifier verbosity when in verbose mode

 include/bpf_util.h |  4 ++--
 ip/ipvrf.c         |  3 ++-
 lib/bpf_legacy.c   | 10 ++++++----
 lib/bpf_libbpf.c   |  6 ++++++
 4 files changed, 16 insertions(+), 7 deletions(-)


base-commit: 575322b09c3c6bc1806f2faa31edcfb64df302bb
-- 
2.42.0


