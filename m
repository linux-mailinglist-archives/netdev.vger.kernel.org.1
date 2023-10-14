Return-Path: <netdev+bounces-40938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D747C9223
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CF51C20995
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7005310F2;
	Sat, 14 Oct 2023 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmk7gvlU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DAC7E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 01:41:42 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426B83
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 18:41:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7be940fe1so41815917b3.2
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 18:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697247701; x=1697852501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hvtncZbOb7lZ1oJ79TiFLQLKFgwfoftKLRCyWPRpkhw=;
        b=fmk7gvlUUMoNk3SOfpeomDLXGET2zY+vnzeywTqJpOVeE1w6NbE+M34E0V6ONVrYdo
         Sus475OMnkybNSDlBtQkfTy7XCequH0fLu4CMEwyIvMd2h+tZr2RF4xs6rd04w+x5t2Q
         /oNXnfI4NAv3iwAjmHFr+3HCWvVNILzWWqP6BlWKx5DPqA2QGxthKbVcpKoERPXGXW6S
         CZ73TmfUDDgIaO6O+b6we07xo2UIYn8tNZQ6d7p9uIGep2CeS5KuX6O78ze6x81spM4+
         fAJa6wf99y3Lx30lFMNVxFuV1dk3Dzw+ekT1Mr+rIl0FzCOvw2qFPu8ZcreE00TmX+QB
         Mv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697247701; x=1697852501;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvtncZbOb7lZ1oJ79TiFLQLKFgwfoftKLRCyWPRpkhw=;
        b=h16xRkFKlfVXxJ7liCCFpSBhey/M4aox7oDtWiO+P1wvQY0dHniF5dMYl/aBk0Tuld
         Td/aJvrzLSf3r8SSEiScsRWTBrWXZeR6LqQUFJB5QtpD4fjhXlT4aWPhu9IcuOvZhgnO
         5cPLGdbWdGzBhgocuye6mdxUsQIG2MDml4vnyAeIsLJ3SO9qWCBonlXhYb+b6NW0A9kR
         6Rr7gQErysAwsjABbtP8o4NaUaWWQU7lKcjmbZf2dV+mcW5+aHn1cUxPKOoHWJXg3Z/t
         7KSgQPmdD8EKoC18zwEHCWjeRNgY6MoHF+vMzyZcawwj+VgmxG8X31leE/iTJ8ZP3274
         G3tQ==
X-Gm-Message-State: AOJu0Yx8d+gY9ANqciDHo5xdGfBB6HiMUDzx5smIPdT7RqW/sZzwQ+pn
	B3p14nSfH5k+k3sr623oup4Hv+DYli85aRUCwiHH9ynv2VAa9WGtForhOp0D5JXt2sfUzL88VDa
	Bhvh29Opgiy57WN8Qs5iCOqf0idP6HWaPAkv2mzYNEoD5tOcE4IwktuS+SzWUCTQj2ow=
X-Google-Smtp-Source: AGHT+IFmXAzjPJnwmxNnXgCr08aOlafHN1em7JEXU6gPn85/l3ifnh324DfFMHWfFkZD0Sjsn2mhfM4DXWWe5A==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a0d:df06:0:b0:5a8:3f07:ddd6 with SMTP id
 i6-20020a0ddf06000000b005a83f07ddd6mr37374ywe.6.1697247700773; Fri, 13 Oct
 2023 18:41:40 -0700 (PDT)
Date: Sat, 14 Oct 2023 01:41:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014014121.2843922-1-shailend@google.com>
Subject: [PATCH net] gve: Do not fully free QPL pages on prefill errors
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The prefill function should have only removed the page count bias it
added. Fully freeing the page will cause gve_free_queue_page_list to
free a page the driver no longer owns.

Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path")
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index d1da7413dc4d..e84a066aa1a4 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -146,7 +146,7 @@ static int gve_prefill_rx_pages(struct gve_rx_ring *rx)
 		err = gve_rx_alloc_buffer(priv, &priv->pdev->dev, &rx->data.page_info[i],
 					  &rx->data.data_ring[i]);
 		if (err)
-			goto alloc_err;
+			goto alloc_err_rda;
 	}
 
 	if (!rx->data.raw_addressing) {
@@ -171,12 +171,26 @@ static int gve_prefill_rx_pages(struct gve_rx_ring *rx)
 	return slots;
 
 alloc_err_qpl:
+	/* Fully free the copy pool pages. */
 	while (j--) {
 		page_ref_sub(rx->qpl_copy_pool[j].page,
 			     rx->qpl_copy_pool[j].pagecnt_bias - 1);
 		put_page(rx->qpl_copy_pool[j].page);
 	}
-alloc_err:
+
+	/* Do not fully free QPL pages - only remove the bias added in this
+	 * function with gve_setup_rx_buffer.
+	 */
+	while (i--)
+		page_ref_sub(rx->data.page_info[i].page,
+			     rx->data.page_info[i].pagecnt_bias - 1);
+
+	gve_unassign_qpl(priv, rx->data.qpl->id);
+	rx->data.qpl = NULL;
+
+	return err;
+
+alloc_err_rda:
 	while (i--)
 		gve_rx_free_buffer(&priv->pdev->dev,
 				   &rx->data.page_info[i],
-- 
2.42.0.655.g421f12c284-goog


