Return-Path: <netdev+bounces-38634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEF57BBC7F
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77E51C20986
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6528DAD;
	Fri,  6 Oct 2023 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN1gdIl2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7D286B4
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:13:45 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C919E;
	Fri,  6 Oct 2023 09:13:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3231dff4343so1464559f8f.0;
        Fri, 06 Oct 2023 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696608822; x=1697213622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=42iuHwuqbkZujSXR+0sYzIY5CpxMUDYyAkkaO/7JfyI=;
        b=DN1gdIl2EtxBRihKRjMcBKOVqyRoY2DWrGmuanFMIX+xBgPIpfquTCYXK2qN0Efbc3
         UUruxxRRco6uYyVY125L1w7aCXDdvcqlIscr9gvat4xcY9jIeZu3T0DkXpo7cUaYA05i
         TiWBBoqoBZbnMBRdvtWXrL/+Q2dAeKFXXpyNyAeHsGdGcMe43YIl9W4nv4h3bib86SF0
         27T6/NEWQSdKIvhnXO25gyUllGoI3psPzwrrgbmyvkHXo0OU5kbKupJowHhdKXIJ9N3u
         OFBoCXskVE6qZw7ObMroz9XXZFwVng5MYLoi+cQpJkNdnPTeUV+8vG7pYQlWKhSzqWk3
         Jcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696608822; x=1697213622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42iuHwuqbkZujSXR+0sYzIY5CpxMUDYyAkkaO/7JfyI=;
        b=aqdmEjWaIqwV8OqMADlfY+qr+53MvGERnCRIPMaNgapA8odpTHgORT6mTf3e4nDRHG
         oid72twVVBSmOD9GdA8yW5uXax/0+VtkUOuehXpW3S/m08PUKcB4x2W+zJs0uTcPnpvW
         YLyHtWCztmnBzGCvPE54PTkNg+OpJ40T9Loy/BJcTB56u68KuCsaGs1Zyl8969xM20vz
         PPaGERYs+g4CLXok/ANXekYoyrA8vxD3ANDjjRgP0DXuDfOyBwkB1RgN6DTkC0J9Ma6h
         gZVuFx8aOVqdqcbUutj980gVSjsUdsGNSVKAU0WL3QloJEAjWzRIjswkmH5WP4EqmSBQ
         hMcQ==
X-Gm-Message-State: AOJu0YwmZoceh0AuoNqB6yBtzliqdzRUmk0X+wtpXKdQTlvqEsigqGNM
	sQP6KZKTBJVHCJ6EwTrc6Gw40roVfOE=
X-Google-Smtp-Source: AGHT+IFWlJEd5lcJuO7NBXcmyzk/NQufpyDojp9c/24EWOp99ni3EczYohi8bG69H5WqdF1FOhglbQ==
X-Received: by 2002:adf:e641:0:b0:320:a4e:acf5 with SMTP id b1-20020adfe641000000b003200a4eacf5mr5026301wrn.34.1696608822284;
        Fri, 06 Oct 2023 09:13:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:818:e906:400:b2bc:40c:b83d:9c16])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d6a84000000b00327bf4f2f14sm1944289wru.88.2023.10.06.09.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:13:41 -0700 (PDT)
From: Ricardo Lopes <ricardoapl.dev@gmail.com>
To: manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	coiby.xu@gmail.com,
	gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: qlge: Replace strncpy with strscpy
Date: Fri,  6 Oct 2023 17:12:24 +0100
Message-ID: <20231006161240.28048-1-ricardoapl.dev@gmail.com>
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

Reported by checkpatch:

WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy

Signed-off-by: Ricardo Lopes <ricardoapl.dev@gmail.com>
---
v2: Redo changelog text

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


