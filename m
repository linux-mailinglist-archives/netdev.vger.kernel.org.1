Return-Path: <netdev+bounces-40491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A247C7883
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122451C20BAC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FF53E478;
	Thu, 12 Oct 2023 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkLaD7X7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652733E472
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:20:07 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C651A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:20:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7c97d5d5aso21674067b3.3
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697145604; x=1697750404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hnx2hMUROy5hPaWMuQS6wGUcTD4C+Y8X52y6T46QNnk=;
        b=XkLaD7X7q8fkKutL6vUFBc68A+tAQ9/sIOS21rjfw57sGiz+TOYsD85qQSv+C2xgxb
         lQDhbPztXnHeZES2/gdkdSUtRMUy8REZ4UJFj9Wo4iRMZ84Dd5/liVwuL3Qa1TqBW3BH
         jlpV7rdPPrLIYATw07Jk3evdgmyuXvzIHkEGEk1MHCN+1ZQ+EE4jMRSvwSBWHHzOEPAk
         j1ScvGrYxWsfh5SFjmTTKze7NVdYdnL+tG8UWmick/5GdFthB9vlwYaNSPzlI2hnWGs9
         EfgIFe99jOKuRqoGvITo5UTaq3jlPGHSrrVVVCoAM0y2QIbIcL9a34qRo7VFpnpf7FAi
         zQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145604; x=1697750404;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hnx2hMUROy5hPaWMuQS6wGUcTD4C+Y8X52y6T46QNnk=;
        b=PRsAD6ZPO7LbugfzMUZSfidKPzpebsciQy/XXLOuHj5uzPFrW0RXhXgeGRrQ3KXdRG
         /6Csj4neYRrp12iq5v3GXsSDSqkYwjF43CRJm+2of+dXbidTro+LWqN16fOzJpEuP88O
         hrKsrPvvv8N5oEXaUx1oJYwQDTi/mncr5YtV4X0FRyHIj4YSMvvTQCqve8tutQ3sFNcY
         rEJbldRVp+tQYMd4JubB88NnUEztuiUEtGh022LKwk5tnIQCJR6zxEIlW+GyPK+N0Sdd
         Wwyyt8FDUHtLeDGwbHYc879rB9UTP6WYFI/HJzLS4ob57kYWBxTwqpmSU6zXRi5Gvr94
         cONg==
X-Gm-Message-State: AOJu0Ywir+g4Ud4itOvGJG2y1D6Ud4BpmH9wBN+iTuQqnXr7WfIu5xSt
	T/PcPn23gHNeWr+zHAeOIiSIfsNvFbrPYQElOw==
X-Google-Smtp-Source: AGHT+IGEz38HdWBwXZW+qHolz7YTUuV4PlFesGO+loEhl5nFIdEKYX6auuR5XKLavYAKjeNoVukACpRoPzbikawFBw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:af27:0:b0:5a7:b54e:bfc1 with SMTP
 id n39-20020a81af27000000b005a7b54ebfc1mr243135ywh.10.1697145604749; Thu, 12
 Oct 2023 14:20:04 -0700 (PDT)
Date: Thu, 12 Oct 2023 21:20:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAANjKGUC/yWNQQ6DMAwEv4J8rqUkFRe+UlVVCAZ8qIvsFFIh/
 t60XFY7h9ndwUiZDLpmB6WVjV9SwV8aSHOUiZCHyhBcuHrnA1pWScsHB+WV1FAoI+WZ9Fe2apS 3YC5TT2c+npEFE7rWt6GPY0zBQV1flEYu/+fb/Ti++Q+lF4kAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697145603; l=2721;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=K5JHCGxkEZHPygsVoHqfoDZGkV0pxG6IhwPB2u479/U=; b=bsjP3OcLje0SPvVnGKRcZtcvFRKAeLjmhv0CkhKsA5enluy6XHRLQ3iodA/qzFgN/6BR552D8
 h2380adLrRVA7mWJ7s69+bGSfcNmC0XDqvDOKG9KsHHWLGb/SSqaOQU
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-ethernet-wangxun-txgbe-txgbe_main-c-v1-1-c9bb3270ac98@google.com>
Subject: [PATCH] net: txgbe: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Based on usage part_str usage within txgbe_read_pba_string(), we expect
part_str to be NUL-terminated but not necessarily NUL-padded:
|       /* put a null character on the end of our string */
|       pba_num[10] = '\0';

Interestingly, part_str is not used after txgbe_read_pba_string():
| ...
|	err = txgbe_read_pba_string(wx, part_str, TXGBE_PBANUM_LENGTH);
|	if (err)
|		strscpy(part_str, "Unknown", sizeof(part_str));
|
|	netif_info(wx, probe, netdev, "%pM\n", netdev->dev_addr);
|
|	return 0;
|
|err_remove_phy:
|	txgbe_remove_phy(txgbe);
|err_release_hw:
|	wx_clear_interrupt_scheme(wx);
|	wx_control_hw(wx, false);
|err_free_mac_table:
|	kfree(wx->mac_table);
|err_pci_release_regions:
|	pci_release_selected_regions(pdev,
|				     pci_select_bars(pdev, IORESOURCE_MEM));
|err_pci_disable_dev:
|	pci_disable_device(pdev);
|	return err;
|}
... this means this strncpy (or now strscpy) is probably useless. For
now, let's make the swap to strscpy() as I am not sure if this is truly
dead code or not.

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

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 5c3aed516ac2..c795fbab37be 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -739,7 +739,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	/* First try to read PBA as a string */
 	err = txgbe_read_pba_string(wx, part_str, TXGBE_PBANUM_LENGTH);
 	if (err)
-		strncpy(part_str, "Unknown", TXGBE_PBANUM_LENGTH);
+		strscpy(part_str, "Unknown", sizeof(part_str));
 
 	netif_info(wx, probe, netdev, "%pM\n", netdev->dev_addr);
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-ethernet-wangxun-txgbe-txgbe_main-c-05152bafac20

Best regards,
--
Justin Stitt <justinstitt@google.com>


