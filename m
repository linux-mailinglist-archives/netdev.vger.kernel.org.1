Return-Path: <netdev+bounces-51503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C77FAF04
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6944CB2115F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A0E7F4;
	Tue, 28 Nov 2023 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYTMihHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E940C1
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:29 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c19a2f606dso4900889a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701131248; x=1701736048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYowvgqz4YCAb9fWpxc3YDJE9fwRyx0aEGPB1qlGo5k=;
        b=MYTMihHEjlwf/Qjm8esxvpu5tQ3HZt9O3UYURJsSqbesEEQeWDShlHZYJ6FIcgaQ4n
         HBQD2PRWR7tlGu2LL5JpOtbZ69lJQCn0ZLwrQfP0v4vElSziCpImo0fX2KGVciKYcS8e
         cBTH9msLGj99Wv8Ly+PQyrc4zU5OoFO23Icw9mqGbwuNOIQ/m63q+6yKKst9TthFGy7b
         54O9ig5S1qeHuomN/lazZEBAqSoswk4VvkNkhg5GabANcgbJy0BYw6nGvUYzFIBIeP3k
         w0QSjcvQcFp809ZFtP1Sy83E0dryzgCSfdLF25w/LBCX+K7u6/kimqoAXE65Zy1cCM12
         EZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131248; x=1701736048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYowvgqz4YCAb9fWpxc3YDJE9fwRyx0aEGPB1qlGo5k=;
        b=CUv8Sb6Ze1OmQNNxUta+q+GQdtlryXBeBjKwWIfHhO3hFdEECqZ8HgXkWzF1f27INT
         FdghXW1CRGwLoXgrMKyUISPlfBlKWvpMaoaWMJ4bX5GBLNKkErxJJzBmIUCX2bbajQ+p
         eJka114XrxIaGYbL7OEcz6OSJ40Z4kjzEcSsdnwWksH6USEb9I1RbCK80qAIjh6oURC0
         ntJ46NVRHCP6tFf3YXDN5e2n9PBDnoDjB6vXvyp4+ijRGY2sn+xZn05w3PDiiouSuIdg
         X0E1eY1Qek7nOaS6aM5OW/EmTZzpTePiI/DP7KjWF8x+pBCNKd3T2ZMdeuagLDJBXABZ
         J42Q==
X-Gm-Message-State: AOJu0YxcCI/Wa4C9kv3djqSWXJuOEeY+MBkZumHG1CcC4Tdl8s5Of0yU
	P/o1ihUMEWihE+PqGQhMAfKWynMO56KMakcXdnuPHiJE5FYPEIliDLUHHg44WlsJNNo1Wl/cicW
	YUIBANxLi+59TOrg/pVhUAzjkYEnQqWW/jo55I4eQ1KijCdlrYcgHqU2i1OZFCZV0
X-Google-Smtp-Source: AGHT+IESuj4pI5rCCot9Y2YIdnfc3JPd7ehNjMvHeqJYc74hWhgmPnGPQ/CrIj7vZVrA8Seb/3wpolt4EOHk
X-Received: from jfraker202.plv.corp.google.com ([2620:15c:11c:202:19d5:f826:3460:9345])
 (user=jfraker job=sendgmr) by 2002:a63:f608:0:b0:5be:4aa:616c with SMTP id
 m8-20020a63f608000000b005be04aa616cmr2220213pgh.4.1701131248518; Mon, 27 Nov
 2023 16:27:28 -0800 (PST)
Date: Mon, 27 Nov 2023 16:26:47 -0800
In-Reply-To: <20231128002648.320892-1-jfraker@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231128002648.320892-1-jfraker@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128002648.320892-5-jfraker@google.com>
Subject: [PATCH net-next 4/5] gve: Add page size register to the
 register_page_list command.
From: John Fraker <jfraker@google.com>
To: netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>, Jordan Kimbrough <jrkim@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

This register is required on platforms with page sizes greater than 4k.
This is because the tx side of the driver vmaps the entire queue page
list of pages into a single flat address space, then uses the entire
space. Without communicating the guest page size to the backend, the
backend will only access the first 4k of each page in the queue page list.

Signed-off-by: Jordan Kimbrough <jrkim@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 1 +
 drivers/net/ethernet/google/gve/gve_adminq.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index bebb7ed11..12fbd723e 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -917,6 +917,7 @@ int gve_adminq_register_page_list(struct gve_priv *priv,
 		.page_list_id = cpu_to_be32(qpl->id),
 		.num_pages = cpu_to_be32(num_entries),
 		.page_address_list_addr = cpu_to_be64(page_list_bus),
+		.page_size = cpu_to_be64(PAGE_SIZE),
 	};
 
 	err = gve_adminq_execute_cmd(priv, &cmd);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 38a22279e..5865ccdcc 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -219,9 +219,10 @@ struct gve_adminq_register_page_list {
 	__be32 page_list_id;
 	__be32 num_pages;
 	__be64 page_address_list_addr;
+	__be64 page_size;
 };
 
-static_assert(sizeof(struct gve_adminq_register_page_list) == 16);
+static_assert(sizeof(struct gve_adminq_register_page_list) == 24);
 
 struct gve_adminq_unregister_page_list {
 	__be32 page_list_id;
-- 
2.43.0.rc1.413.gea7ed67945-goog


