Return-Path: <netdev+bounces-39738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7997C43FB
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6BA281E7B
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA635500;
	Tue, 10 Oct 2023 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8ePxtLU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86952354F5
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:27:17 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA066AF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:27:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a4fb3e096so1941793276.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976835; x=1697581635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlakbgGWTqcDQ2xuVKeK3nhNuDzBfPQq0/+GRmlX5C8=;
        b=w8ePxtLUgoM/h+NoEz/90TBSsGTZpWch4xp1qa0oYaJh/mhwbSnEw7kITkwz/7cOTE
         nW9rypZvVYgCTjEjxthXs6MJP8KcmCUnT/vbQOAToegTk/HX5027pKZnhDyh535JVuWL
         lWGPdpH+xIiT737RglR+ioIoBJx7PiTtVB08gKeMMAkIGPL2S2vDe8YOYWlDhwpweIH5
         CQRyBz78JB3NcmuLjdYYZPMW92RKetaGcG8pslc9hcd6RkniFvNvZtdfLR0zBZrOKdgp
         p2OtDXW5Dpb3XcSLxqVO1YX80mlaNBTMozgjI6+sxSHvcG2J2cI2pwidAq5vbwaGIpne
         OOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976835; x=1697581635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlakbgGWTqcDQ2xuVKeK3nhNuDzBfPQq0/+GRmlX5C8=;
        b=N9UN2dZx96+MzpuZ899KvRtEp+tlEQsX086P5MJ8VhCpOrMhh2a48Fa6+bdsSus4pV
         YSuyY4lyrfpLsgy8cdvG01KEFIGvD966KK/nJHBXhB0b2v5Y+W52rNUCA4iVv1iSyRHi
         2hbYiYp/id4mFi68UNNv4TdWYdrOYjBDYYzmPUGcQsFxn4g9Lk0sd979a/cc01ZaryyH
         x606qux/f14qzvgbR/8LEG3vhsvjiOqOF8b8XQqJaNZvvABaCQnpK0qLr6lZ4FJetpR3
         DTJkG4MfIkBmNtXV3ZuFh1Yy1vBeHSh/G8jUA76O2oGjS593jGnUJTVTMKOysk1XCrHS
         powg==
X-Gm-Message-State: AOJu0YzcK02XloLRAxzzUJUGwAoLKcq7pA8BRcgw/ouOVq8r/um1gPFh
	2bg8AGOtR4DB9jI2PqqB4DnfyOIgkvReerPkwQ==
X-Google-Smtp-Source: AGHT+IGzYEq54Il7W2YEgs1cfyYc8gNX6HEw1AL6yXL3SCPfuWpHyotzmuT619yMLidQOlA9hNzRlpWN7L1xRgRrQA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:a162:0:b0:d85:ad61:1591 with SMTP
 id z89-20020a25a162000000b00d85ad611591mr315298ybh.11.1696976835057; Tue, 10
 Oct 2023 15:27:15 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:27:00 +0000
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976825; l=1942;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=6jGMK+cCOOSLNNUn0TBt6IBLIOJaTfgy8BwlGd7P468=; b=35oBACPXlL3wg2v3AbE8axFEM9yJJX/Bfv5dcLDCY+rrP7a8HRLOAFEg/ZA8gNWEWwSfT6QVK
 J4O6EmvMtglD6nXKST7OY8ieVbM+DsbZ81c8dF/wyiqDDJWJ1HsPtah
X-Mailer: b4 0.12.3
Message-ID: <20231010-netdev-replace-strncpy-resend-as-series-v1-7-caf9f0f2f021@google.com>
Subject: [PATCH v1 net-next 7/7] igc: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect netdev->name to be NUL-terminated based on its use with format
strings:
|       if (q_vector->rx.ring && q_vector->tx.ring)
|               sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,

Furthermore, we do not need NUL-padding as netdev is already
zero-allocated:
|       netdev = alloc_etherdev_mq(sizeof(struct igc_adapter),
|                                  IGC_MAX_TX_QUEUES);
...
alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
alloc_netdev_mqs() ...
|       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: build-tested only.
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 98de34d0ce07..e9bb403bbacf 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6935,7 +6935,7 @@ static int igc_probe(struct pci_dev *pdev,
 	 */
 	igc_get_hw_control(adapter);
 
-	strncpy(netdev->name, "eth%d", IFNAMSIZ);
+	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;

-- 
2.42.0.609.gbb76f46606-goog


