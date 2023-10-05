Return-Path: <netdev+bounces-38374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E477BA9DB
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 34391B2097C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010884122E;
	Thu,  5 Oct 2023 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddCiNOuF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497B29422
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:15:24 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3868D9;
	Thu,  5 Oct 2023 12:15:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40572aeb673so12896585e9.0;
        Thu, 05 Oct 2023 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696533320; x=1697138120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aT0LmIsvnpX1kglnb6ckTRuS7J+F7V3HjLnCaWyOAWA=;
        b=ddCiNOuF1B43oVIe0WuZA5qVAS5WvLJQqsyxHnwtMgP/l609NMZ0/H3G8+0e3j7IVv
         SienX65ftG31St1G2ymNpX7R1I0iaWRG0jmQJdcCtw/VB3kCCT02yUxv1Rimc0Lg1QAd
         ZKXoU9xF/Z9RNd+Leaiu/TEdlkW6EQm8WBSfR6q3cM5qpVD9r/m5skjmZUcLcBxHTt9C
         JYZ/6CYM76c6GJDg0URUFXlkTRrLY0ZSguK+jp6Ftg2tTYTCFUs2W2aUowyBc5McDLVd
         s664/d+XSARr89z7dKEviogx7XmSEXMMdcY4J1gfZLVEWiixPIvysENXpge3fECb9L4V
         r92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696533320; x=1697138120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aT0LmIsvnpX1kglnb6ckTRuS7J+F7V3HjLnCaWyOAWA=;
        b=meG2qotec99EKNu0f9lzn2eaMLIZ4nsUEs6USSxWTF97S16fTJR8RMaP6TzdMbSKCd
         /gZvNqX7W90O7vaVxLzYejxyLR0wN3vezeZQIHkHduKwvZ9IXs8y+dkuBQB5BPyByxmd
         cGh6OKHh968VlHzTkCVSH4bWNmziqQEfT90PmkUf4diRKM3aptE3NwUwibQxMrZvxGLB
         2ylBlQpfe+uuHGX2np2fojg4XzVuZglBXgjpgCgkvmbpeke3CHq79bl1i8CAtKHxjrXI
         TxAqSqcU6Wk7Ig9smfk5lnruAmKMfGHZBPetNKkXDVYwfVr+AKt/A3Nj/w9ZZwZPHn6o
         iC/g==
X-Gm-Message-State: AOJu0Yyyv06gTw6DmMTR50DZ9C/GhMlv47//lLkkCy6/OV/5nDf6DWpC
	EB/yq9PB1BqPyhsoU86Bwgc=
X-Google-Smtp-Source: AGHT+IEhZPgfkx8mQXQXOTrcuxb3QDkXOODotGOIc9va7MNCtseyZWgXnTuij5CEQYcIdxu+L4NXdw==
X-Received: by 2002:a1c:721a:0:b0:405:1baf:cedf with SMTP id n26-20020a1c721a000000b004051bafcedfmr5855968wmc.24.1696533319961;
        Thu, 05 Oct 2023 12:15:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:818:e906:400:b2bc:40c:b83d:9c16])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c025300b00401d8181f8bsm4407235wmj.25.2023.10.05.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:15:19 -0700 (PDT)
From: Ricardo Lopes <ricardoapl.dev@gmail.com>
To: manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	coiby.xu@gmail.com,
	gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: qlge: Replace strncpy with strscpy
Date: Thu,  5 Oct 2023 20:14:55 +0100
Message-ID: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Avoid read overflows and other misbehavior due to missing termination.

Reported by checkpatch:

WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy

Signed-off-by: Ricardo Lopes <ricardoapl.dev@gmail.com>
---
 drivers/staging/qlge/qlge_dbg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index c7e865f51..5f08a8492 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -696,7 +696,7 @@ static void qlge_build_coredump_seg_header(struct mpi_coredump_segment_header *s
 	seg_hdr->cookie = MPI_COREDUMP_COOKIE;
 	seg_hdr->seg_num = seg_number;
 	seg_hdr->seg_size = seg_size;
-	strncpy(seg_hdr->description, desc, (sizeof(seg_hdr->description)) - 1);
+	strscpy(seg_hdr->description, desc, sizeof(seg_hdr->description));
 }
 
 /*
@@ -737,7 +737,7 @@ int qlge_core_dump(struct qlge_adapter *qdev, struct qlge_mpi_coredump *mpi_core
 		sizeof(struct mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.image_size =
 		sizeof(struct qlge_mpi_coredump);
-	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
+	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.id_string));
 
 	/* Get generic NIC reg dump */
@@ -1225,7 +1225,7 @@ static void qlge_gen_reg_dump(struct qlge_adapter *qdev,
 		sizeof(struct mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.image_size =
 		sizeof(struct qlge_reg_dump);
-	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
+	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.id_string));
 
 	/* segment 16 */
-- 
2.41.0


