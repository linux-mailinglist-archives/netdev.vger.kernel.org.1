Return-Path: <netdev+bounces-38169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8157A7B9997
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 03:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1FB11281D84
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E4D1373;
	Thu,  5 Oct 2023 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mk4Ts3hk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D101116
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 01:29:48 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87920CE
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 18:29:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d868842eda1so806003276.0
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 18:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696469385; x=1697074185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=seOtURC6fBxwejJy6k6WWhSAcd7bSEPQZUE94/fyJ08=;
        b=mk4Ts3hk9+gNSaj9j1fALfv2XOxIpoXKA1wjNfttziQRjOwmpee+SLP/tE9bmk5S1m
         70hR7OtsylHTPeJDRP0JASE0VtKMvsFYthfslrdRwIwk2F23AOJP94yPGF5zgyUNcGs2
         eOQRt5JJSO9GL41t5pAABACAL0XHeFyxWGTLgFz0JRX7IA7zJmDED1PwP8u74OutNHus
         0c1JqhIyrfty29Sjy7194BvaBnkOlnmxeyRaoPPeKesDVbsOEgWtGezbp3Rlg4ti7lDD
         Ivpn70uEJxUsLg4FDoB1sG3wvNvtbyEUjphfTGHjQcPU6u3/4b23m0GotFSO+cXnFp2+
         bSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696469385; x=1697074185;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seOtURC6fBxwejJy6k6WWhSAcd7bSEPQZUE94/fyJ08=;
        b=ppByfQ4sslsnEdA1hoLLm9Vl194eSU3HjvNbBjf/F6hjRXp2x9xlKAu0y8wd/sO7h8
         qMIoFd3+S/zibQ+hTNmjqdMHXFaPjEJpf1V8Y3J35Z9r9i8XriblW/duYcGzzy9sMWgQ
         a/Apc5We/kbjrSMuOkJHWuVyYhQ17s66lxEeTXmSxBG4M9Ipg/Du2qaT9Os3xASSaV/l
         4qt9NBky1BjHdYyHh2ZnVTOAllI7fxIy4to6BUuxEC5JRUEyV6MKF4IniiWAL1FeZCJj
         uOeprvIPDXyCl/bQ85bk2hSmHNG7XyL1I2F5EM4Ox/IBEoWB1RQzTCIj8kzTdsD2eRe8
         R2zA==
X-Gm-Message-State: AOJu0Yyxw0iJ7F7YtbuIZkbMht4203RbujGZjqaMOgz6nZkc2KclFYFm
	dxgLdMKu+y/ee8Ok7XvOzaZ8nSNgn4RT2lnwag==
X-Google-Smtp-Source: AGHT+IHGlUdBnRQgAUkJbTUD5bhZpKVCzmIJHzuIezZEtvNkFHMjMTUnquqEGw5iJVx3Upqhvllv2Qm2UrKMLjL1QQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d42:0:b0:d7f:8e0a:4b3f with SMTP
 id 63-20020a250d42000000b00d7f8e0a4b3fmr58588ybn.3.1696469385723; Wed, 04 Oct
 2023 18:29:45 -0700 (PDT)
Date: Thu, 05 Oct 2023 01:29:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIgRHmUC/x2NzQqDMBCEX0X23IUk/rV9FfEgybYuSJTdIIr47
 k16mfm+y8wFSsKk8K4uENpZeY1Z7KMCP0/xS8ghOzjjamtMi5ok+u3EILyTKEZKSGkmKTAVWDX 3cpRw6DE8++7VtKGrGwt5dhP68PG/HMb7/gGZNBCkggAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696469384; l=2106;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=X2VGMiD2VyU3UNmwOeb3Zcy55vlwL+eXR2GtGCju9sw=; b=Na69FtdFYr6hWbOU/LN2ileJHX4Vn+VWR5fpviGG/UesKWcaHIRD05Hj/H0r1oeNn8TTEdQYY
 5SCvfX7QZAGB2eaD8GVNAjSMnK+zuim5ZrxZ1T4ZtpSiUZXLb5qHBAr
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-atheros-atlx-atl2-c-v1-1-493f113ebfc7@google.com>
Subject: [PATCH] net: atheros: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Chris Snook <chris.snook@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
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
strings and dev_info():
|     dev_info(&adapter->pdev->dev,
|             "%s link is up %d Mbps %s\n",
|             netdev->name, adapter->link_speed,
|             adapter->link_duplex == FULL_DUPLEX ?
|             "full duplex" : "half duplex");

Furthermore, NUL-padding is not required as netdev is already
zero-initialized through alloc_etherdev().

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
 drivers/net/ethernet/atheros/atlx/atl2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index 1b487c071cb6..bcfc9488125b 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1377,7 +1377,7 @@ static int atl2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->watchdog_timeo = 5 * HZ;
 	netdev->min_mtu = 40;
 	netdev->max_mtu = ETH_DATA_LEN + VLAN_HLEN;
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	netdev->mem_start = mmio_start;
 	netdev->mem_end = mmio_start + mmio_len;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-atheros-atlx-atl2-c-d876945d6341

Best regards,
--
Justin Stitt <justinstitt@google.com>


