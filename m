Return-Path: <netdev+bounces-46597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF407E54A4
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 12:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642B9281312
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206F81094A;
	Wed,  8 Nov 2023 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dn8YfB6o"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824B14F97
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 11:01:00 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC5E19BA
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 03:00:59 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507be298d2aso8765121e87.1
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 03:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699441258; x=1700046058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5RdWI5Otzj/22CmXWTC0LvstaBILxuomd2KxfErMzrE=;
        b=Dn8YfB6otazAqK+5hS7E9HqmNVRnA9FrMWIjRU5CLMnIwQui7qrYud0SMKBL/1Iskc
         ba+J3Ukz6ZPHiL9RbD5YtRUR+23o+X99Td9p8s1abhP2THoMym68KneROuQ4+GJs33s5
         4l+6/kPbLLnkOWbM3Taxtqe2aLnKgdPaIecN0JS7EGEa+5kog/nBidT4K2+Fk1InR+I5
         13pqIqg5MH1ufZCGqvl6YnoT+QuxrFgcuHsOPcaniy9miIOxJ2L3e3Xty5E9GziommZf
         o3LeHXNePduIuk7Lv3MmzDCjM74R5VSk3eFfcZbGndWwRA2ZzSJhA+sTXFg7H0uVV8Mu
         eFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699441258; x=1700046058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RdWI5Otzj/22CmXWTC0LvstaBILxuomd2KxfErMzrE=;
        b=RyfFzTQrfp33krM7EjPowoXtTxl2DPZTSQ28pPPwAs4PosgYelXvtOV4NnP0GSpa++
         tgZEXKx/IdWHSzKh7bPlP6Z/9A7dYvjAtBgevrdhSDDBMDYa7RkR5RhBPna9/HC6YvWI
         BduTq4lFev/TZH0cQO1PkP/NurfzUAiRaysjzW7WxObSFJeCGcc6XRdC2yCkDZCAM5Se
         zwooWs1/DXk6pGpqqsLfli41CoEkVIyznXY6fGAQ0Lknyp39BzaKmbl5e1IS9UQ0WLVx
         /W9ossj0Y5Da9wyGZV6bTvNlF8+51pZeouxBRmLBf/CTyY7Ob8OiOz1IDoc4yxzBN2uW
         x8Rg==
X-Gm-Message-State: AOJu0Yyfhvdv6p+QPNCVd39cbfEJ9tOksEtRCyj8PA+THW3kN2iXzInT
	no0/3MTv+5Y0S69BEyOvfo3YBA==
X-Google-Smtp-Source: AGHT+IF/QT7y6mmtdbC3qDd9Bu2J9wX51lY1OjPWxmAl63DpQNTQLt3kUbIV9xOmqprPINgAZ7sbSw==
X-Received: by 2002:a05:6512:3497:b0:500:79f7:1738 with SMTP id v23-20020a056512349700b0050079f71738mr866908lfr.17.1699441257985;
        Wed, 08 Nov 2023 03:00:57 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id b18-20020a056512061200b00502ae64f46asm631443lfe.126.2023.11.08.03.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 03:00:57 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	andrii.nakryiko@gmail.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCHv2] selftests: bpf: xskxceiver: ksft_print_msg: fix format type error
Date: Wed,  8 Nov 2023 12:00:48 +0100
Message-ID: <20231108110048.1988128-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Crossbuilding selftests/bpf for architecture arm64, format specifies
type error show up like.

xskxceiver.c:912:34: error: format specifies type 'int' but the argument
has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
 ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
                                                                ~~
                                                                %llu
                __func__, pkt->pkt_nb, meta->count);
                                       ^~~~~~~~~~~
xskxceiver.c:929:55: error: format specifies type 'unsigned long long' but
 the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
 ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
                                    ~~~~             ^~~~

Fixing the issues by casting to (unsigned long long) and changing the
specifiers to be %llx, since with u64s it might be %llx or %lx,
depending on architecture.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/xskxceiver.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 591ca9637b23..1ab9512f5aa2 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -908,8 +908,9 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	struct xdp_info *meta = data - sizeof(struct xdp_info);
 
 	if (meta->count != pkt->pkt_nb) {
-		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
-			       __func__, pkt->pkt_nb, meta->count);
+		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%llx]\n",
+			       __func__, pkt->pkt_nb,
+			       (unsigned long long)meta->count);
 		return false;
 	}
 
@@ -926,11 +927,13 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 
 	if (addr >= umem->num_frames * umem->frame_size ||
 	    addr + len > umem->num_frames * umem->frame_size) {
-		ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
+		ksft_print_msg("Frag invalid addr: %llx len: %u\n",
+			       (unsigned long long)addr, len);
 		return false;
 	}
 	if (!umem->unaligned_mode && addr % umem->frame_size + len > umem->frame_size) {
-		ksft_print_msg("Frag crosses frame boundary addr: %llx len: %u\n", addr, len);
+		ksft_print_msg("Frag crosses frame boundary addr: %llx len: %u\n",
+			       (unsigned long long)addr, len);
 		return false;
 	}
 
@@ -1029,7 +1032,8 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 			u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
 
 			ksft_print_msg("[%s] Too many packets completed\n", __func__);
-			ksft_print_msg("Last completion address: %llx\n", addr);
+			ksft_print_msg("Last completion address: %llx\n",
+				       (unsigned long long)addr);
 			return TEST_FAILURE;
 		}
 
@@ -1513,8 +1517,9 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 	}
 
 	if (stats.tx_invalid_descs != ifobject->xsk->pkt_stream->nb_pkts / 2) {
-		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%u] expected [%u]\n",
-			       __func__, stats.tx_invalid_descs,
+		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%llx] expected [%u]\n",
+			       __func__,
+			       (unsigned long long)stats.tx_invalid_descs,
 			       ifobject->xsk->pkt_stream->nb_pkts);
 		return TEST_FAILURE;
 	}
-- 
2.42.0


