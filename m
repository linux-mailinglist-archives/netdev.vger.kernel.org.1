Return-Path: <netdev+bounces-51502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F77C7FAF03
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28E81C20E48
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA60A46;
	Tue, 28 Nov 2023 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBSInZYN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E67119D
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cb6271b225so72898987b3.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701131246; x=1701736046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WivxbZ9dw1KXjCGb/iIEv0+mZOVEPFRyY+vy9pp8ozo=;
        b=qBSInZYNVFOvVGPwpSTO1V9PRe2SGj20FiseKo2jRaGZEBceYkG4aR5U/HANdUeOf8
         bA0vL6QFHrJcTiKZcDtaz2zsln+MW3cRa8bbdGpya6pPJI8g+j2Rq/vWTJNqV0iFRGJb
         26DSXIrAZiJ8bjdJF6l3nhyKoy40vpF1p+sHPa1nioFGbMKQkH901bvQgk82j7Oqw4fQ
         5PCuR+AMFOjk9P4U5hK0MrFBdfgM0h2YNX37xF28Cv67Y8ndjMU8QYQxfEwME9RsL81T
         EHJ1DUkQlQ+SBlYxp+gA7FPjGpW+vmIZaO01N/R09VCLraztkRbvI1rnARe6OzjjXmSA
         KtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131246; x=1701736046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WivxbZ9dw1KXjCGb/iIEv0+mZOVEPFRyY+vy9pp8ozo=;
        b=J77lSaJWD/2fMC0+/MfPSG1QI7+f7XtWg1qJhJ5QChrDckZ3YK1aT+cEP9HQG0G8gK
         r/CiZmq1/ZEdoXS0Q2EEYZfeF/rxdlLWhymp/njATnMO2jWyeiuGzxxwPbW5gSSbJy8i
         CufV/oZ/A2P1sEJ2wJgVGQiErxCWrJarNRrMxFzbzRayRICaI5SCvVrqu2scfgcC6g6I
         BxlWgw/7OJ2DqXIUznu1mFWsod75YVSTfKShrzfoi0ufCJFHhh4bBmEi0+c7texDFK8D
         vzu4jJaWX0/SiLZBDId0+M2ShrK7bU8P4aaerB3+MScbZthjtuACpcorqoKC6nnS4Pw4
         BKbQ==
X-Gm-Message-State: AOJu0YyiDcVe61e/+n8j0lkze1hxHzhP9JVhTfZKUUWMqJV8GegR3ENO
	F8y/O9SGPCBmLj05MtGoSz9+fLvFakLScinaBIrxPRrnyzEeLRPOS00wnvpOojt2Rpihm5aJw9u
	wKtuiUIUbElecYEq7GeArKoWBH7y1Vnpk/ymu7NrYkFZp/xwEoYUxy5LpdXQa6YaF
X-Google-Smtp-Source: AGHT+IEoAJxrDCMkPF1DVUUGDvKQbPlNETXVO9knOBDKuwOyWrBd1fk+95/5LJ/j3L0BnUJ7t2YE7z7t6B3B
X-Received: from jfraker202.plv.corp.google.com ([2620:15c:11c:202:19d5:f826:3460:9345])
 (user=jfraker job=sendgmr) by 2002:a05:690c:3209:b0:5ca:f1d:6131 with SMTP id
 ff9-20020a05690c320900b005ca0f1d6131mr379437ywb.7.1701131246314; Mon, 27 Nov
 2023 16:27:26 -0800 (PST)
Date: Mon, 27 Nov 2023 16:26:46 -0800
In-Reply-To: <20231128002648.320892-1-jfraker@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231128002648.320892-1-jfraker@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128002648.320892-4-jfraker@google.com>
Subject: [PATCH net-next 3/5] gve: Remove obsolete checks that rely on page size.
From: John Fraker <jfraker@google.com>
To: netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>, Jordan Kimbrough <jrkim@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

These checks are safe to remove as they are no longer enforced by the
backend. Retaining them would require updating them to work differently
with page sizes larger than 4k.

Signed-off-by: Jordan Kimbrough <jrkim@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 11 -----------
 drivers/net/ethernet/google/gve/gve_rx.c     |  8 +-------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index f81ed6f62..bebb7ed11 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -727,18 +727,7 @@ static int gve_set_desc_cnt(struct gve_priv *priv,
 			    struct gve_device_descriptor *descriptor)
 {
 	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
-	if (priv->tx_desc_cnt * sizeof(priv->tx->desc[0]) < PAGE_SIZE) {
-		dev_err(&priv->pdev->dev, "Tx desc count %d too low\n",
-			priv->tx_desc_cnt);
-		return -EINVAL;
-	}
 	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
-	if (priv->rx_desc_cnt * sizeof(priv->rx->desc.desc_ring[0])
-	    < PAGE_SIZE) {
-		dev_err(&priv->pdev->dev, "Rx desc count %d too low\n",
-			priv->rx_desc_cnt);
-		return -EINVAL;
-	}
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 3c8a80d18..3d6b26ac6 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -210,9 +210,9 @@ static int gve_rx_alloc_ring(struct gve_priv *priv, int idx)
 {
 	struct gve_rx_ring *rx = &priv->rx[idx];
 	struct device *hdev = &priv->pdev->dev;
-	u32 slots, npages;
 	int filled_pages;
 	size_t bytes;
+	u32 slots;
 	int err;
 
 	netif_dbg(priv, drv, priv->dev, "allocating rx ring\n");
@@ -269,12 +269,6 @@ static int gve_rx_alloc_ring(struct gve_priv *priv, int idx)
 
 	/* alloc rx desc ring */
 	bytes = sizeof(struct gve_rx_desc) * priv->rx_desc_cnt;
-	npages = bytes / PAGE_SIZE;
-	if (npages * PAGE_SIZE != bytes) {
-		err = -EIO;
-		goto abort_with_q_resources;
-	}
-
 	rx->desc.desc_ring = dma_alloc_coherent(hdev, bytes, &rx->desc.bus,
 						GFP_KERNEL);
 	if (!rx->desc.desc_ring) {
-- 
2.43.0.rc1.413.gea7ed67945-goog


