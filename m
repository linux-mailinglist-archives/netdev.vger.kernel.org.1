Return-Path: <netdev+bounces-63294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F359382C29B
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 16:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A248F1F24501
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368D6E2C7;
	Fri, 12 Jan 2024 15:16:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 1.mo619.mail-out.ovh.net (1.mo619.mail-out.ovh.net [178.33.253.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43228101E7
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=naccy.de
Received: from ex4.mail.ovh.net (unknown [10.108.9.49])
	by mo619.mail-out.ovh.net (Postfix) with ESMTPS id BC92626622;
	Fri, 12 Jan 2024 14:00:13 +0000 (UTC)
Received: from bf-dev-miffies.localdomain (130.93.52.54) by
 DAG10EX1.indiv4.local (172.16.2.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 15:00:12 +0100
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>, <kernel-team@meta.com>
Subject: [PATCH v4 3/3] ss: update man page to document --bpf-maps and --bpf-map-id=
Date: Fri, 12 Jan 2024 15:04:29 +0100
Message-ID: <20240112140429.183344-4-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112140429.183344-1-qde@naccy.de>
References: <20240112140429.183344-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS13.indiv4.local (172.16.1.13) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 5038683558890303228
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnhepudeludfgieeltedvleeiueejtdettdevtdfgteetveefjefhffekueejteffgfdunecukfhppeduvdejrddtrddtrddupddufedtrdelfedrhedvrdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdgushgrhhgvrhhnsehgmhgrihhlrdgtohhmpdhmrghrthhinhdrlhgruheskhgvrhhnvghlrdhorhhgpdhkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomhdpoffvtefjohhsthepmhhoieduledpmhhouggvpehsmhhtphhouhht

Document new --bpf-maps and --bpf-map-id= options.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 man/man8/ss.8 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 4ece41fa..0ab212d0 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -423,6 +423,12 @@ to FILE after applying filters. If FILE is - stdout is used.
 Read filter information from FILE.  Each line of FILE is interpreted
 like single command line option. If FILE is - stdin is used.
 .TP
+.B \-\-bpf-maps
+Pretty-print all the BPF socket-local data entries for each socket.
+.TP
+.B \-\-bpf-map-id=MAP_ID
+Pretty-print the BPF socket-local data entries for the requested map ID. Can be used more than once.
+.TP
 .B FILTER := [ state STATE-FILTER ] [ EXPRESSION ]
 Please take a look at the official documentation for details regarding filters.
 
-- 
2.43.0


