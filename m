Return-Path: <netdev+bounces-51429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D079E7FA993
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 20:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3362818D4
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF23EA95;
	Mon, 27 Nov 2023 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGy2yYij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF351131
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 11:03:38 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ccaa0da231so58540817b3.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 11:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111818; x=1701716618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIZwWc9a6llwfy/GJ9Hn1wyFbDKHqDafvICOFwSzkaA=;
        b=YGy2yYijMlf1v8lscnCk8S1rmGLTo7DiO65mq6NyRR2ESO+ajSQwgHBpCOnynb7D/R
         MwM4dUZLQ+WmRRieTObi0dzgLnUxpLAndzP8Z7XuFDKwEjOShU4eDlndqNBlI6wXI8zN
         D4rySoLVPPpQJPvWn0WQzgal6VSprZ8t50aDw4jBPOlJqJWTZbqAkzUBQ7/XSDXnIPBX
         p+c1q4nibtRjHzQKH+XSyrVepe2k1MU0UkGzn3FvM/DXCkTtMFg2pRK6VT29+lUf1Am9
         jZoqIeWGgRQ91m3MsUW7e4DhhwBQJg+c7Aj7xww7hKwPnqgcGLNztsf4W6qi8TaaCexJ
         G3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111818; x=1701716618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIZwWc9a6llwfy/GJ9Hn1wyFbDKHqDafvICOFwSzkaA=;
        b=qVsLFl2JEXbO5/jNy/Aa8opiGpM7QbmYL+HJZoz0q/Ap5OSMa1did2VWj/JdiHr4Yx
         nngOtaNgqHk7fYauhW3+m0/4CzcWBdJ/0qKDYhkvM+RmM31oGqjlw+AThbzX6nO/Bxng
         /8OB6Y4zIFE8m+EJPjHJjU5XsScUl35lfG+Vma68OvAhh46ULtNQDjc/2mLuU6pKksWQ
         1IfgHoOuO0Dmgrjb9FPdA3i8a1F62ljsf4yUEYzxOH31/9CLJizLDPnZGEQAFsgJZpO6
         7ylcSDTWJdxv9Mr3NXIdwVQfvLCJapPDr9VeW0c4cbS1Wlu55MwAZSO+dheuqqy1yHG8
         wf7g==
X-Gm-Message-State: AOJu0YxJuN+heCQ0IIrOVYhbpzArTx4s36DOMBn4egWZvgc7iAlAdcSK
	drT/jmpbswDxUBMZCozxjQXHf+k=
X-Google-Smtp-Source: AGHT+IE8EPn2D8FiPemXYIFXefsg8Tsk7m3Yd2lEnAXCBSDAZJZtgbnRhsMN5Z+iMFgisc45OHcT14o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:3209:b0:5cc:234f:1860 with SMTP id
 ff9-20020a05690c320900b005cc234f1860mr371027ywb.3.1701111818184; Mon, 27 Nov
 2023 11:03:38 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:15 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-10-sdf@google.com>
Subject: [PATCH bpf-next v6 09/13] selftests/xsk: Support tx_metadata_len
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
2.43.0.rc1.413.gea7ed67945-goog


