Return-Path: <netdev+bounces-45830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2EB7DFCCA
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 23:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA03C281E42
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6922374E;
	Thu,  2 Nov 2023 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKWSp+R+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79A22F17
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 22:58:57 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A742F197
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:58:55 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc5ef7e815so11808215ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965935; x=1699570735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeQrdnKYuBooTnpvZQFnSOSMYJ4ZuSmlztUMmTptENE=;
        b=KKWSp+R+WRzLEK271S81ldoCKkzX5cDVo97yrkKi/tYQDJTlbUwkl8JZevIRMwi5nr
         Ha3PweiL3u3RG/6vAL9QrGPqyFHFWWsYKBzP7vjk84SjVh+BGbkRHp7vehtZeOv86p2j
         VlPTYJYwrSfnoBgAW8KkzLknbA2VnjZgrsyeNI0LTKF3vztRXKZq1rUqSn72bWPAw4K7
         RNVnnMsCJuv4z3FFakzA9aEWPV2SZanJ7nfO24ECRd7Or6BdgdYx1M8lhQcdCgUu+SNQ
         cwlnnlEWPM2hHBXmrgASvzvbGjt8AnWFOvvdKvG9ezZAxRCdMwB1rAfi544YUMeAh1Yi
         QMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965935; x=1699570735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeQrdnKYuBooTnpvZQFnSOSMYJ4ZuSmlztUMmTptENE=;
        b=MxmlDy6Lr96Uce9HBqHLCHKS2C9wBXeZ21hKUNqFyusr9owe7ldvzsx3E31UPHiuEV
         vGicMrOl7U5NJ37/9kbrS1cp7vVQQ4t8KaFwW0PeBrcc44iiBbzjn6P/TKYb5f0s9OAo
         lZ3Gd9XDR0j1qOwxkzFwTPwd740NmYJnO2gd9F7Q4O8G/Bsdx/qtX/FO6ODJ/ozBsnsy
         FjpPtTvH6E4d8/XC1nS9ghZwn89MW5ML+dahYsZmFuZNSnTCHUFTWl0hSSmiBY9C01Lu
         zWukh4nKUWyicimPGqZL9H+lVtcAHJhJHQTlCIlpbjwnVk8pJgVgpAvYqUiyPs3vzkwp
         XZHw==
X-Gm-Message-State: AOJu0YxE/o89O+tGQLKWjcmVacy7b0jT3C3a1rUFMcy8QzNI7NMpgG2F
	9PXAi4sFu26aqmGYH7gY6CQDLV8=
X-Google-Smtp-Source: AGHT+IE30pQeNxwTIxy6isUW+aAqMiu0jHID3fpIuTjvgcz86AcrLPHw0kA5islC10OPVkIGp4LNh+A=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:328e:b0:1ca:1e12:7c85 with SMTP id
 jh14-20020a170903328e00b001ca1e127c85mr341274plb.3.1698965935122; Thu, 02 Nov
 2023 15:58:55 -0700 (PDT)
Date: Thu,  2 Nov 2023 15:58:33 -0700
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102225837.1141915-10-sdf@google.com>
Subject: [PATCH bpf-next v5 09/13] selftests/xsk: Support tx_metadata_len
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

Add new config field and propagate to UMEM registration setsockopt.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xsk.c | 3 +++
 tools/testing/selftests/bpf/xsk.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index e574711eeb84..25d568abf0f2 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -115,6 +115,7 @@ static void xsk_set_umem_config(struct xsk_umem_config *cfg,
 		cfg->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 		cfg->frame_headroom = XSK_UMEM__DEFAULT_FRAME_HEADROOM;
 		cfg->flags = XSK_UMEM__DEFAULT_FLAGS;
+		cfg->tx_metadata_len = 0;
 		return;
 	}
 
@@ -123,6 +124,7 @@ static void xsk_set_umem_config(struct xsk_umem_config *cfg,
 	cfg->frame_size = usr_cfg->frame_size;
 	cfg->frame_headroom = usr_cfg->frame_headroom;
 	cfg->flags = usr_cfg->flags;
+	cfg->tx_metadata_len = usr_cfg->tx_metadata_len;
 }
 
 static int xsk_set_xdp_socket_config(struct xsk_socket_config *cfg,
@@ -252,6 +254,7 @@ int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area,
 	mr.chunk_size = umem->config.frame_size;
 	mr.headroom = umem->config.frame_headroom;
 	mr.flags = umem->config.flags;
+	mr.tx_metadata_len = umem->config.tx_metadata_len;
 
 	err = setsockopt(umem->fd, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr));
 	if (err) {
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/bpf/xsk.h
index 771570bc3731..93c2cc413cfc 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/bpf/xsk.h
@@ -200,6 +200,7 @@ struct xsk_umem_config {
 	__u32 frame_size;
 	__u32 frame_headroom;
 	__u32 flags;
+	__u32 tx_metadata_len;
 };
 
 int xsk_attach_xdp_program(struct bpf_program *prog, int ifindex, u32 xdp_flags);
-- 
2.42.0.869.gea05f2083d-goog


