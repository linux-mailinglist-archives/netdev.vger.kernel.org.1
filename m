Return-Path: <netdev+bounces-55452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A8580AE93
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DE71C20318
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EE15732B;
	Fri,  8 Dec 2023 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7BdHG8V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF9A1994
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 13:07:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbc65c58e78so237867276.0
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 13:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702069634; x=1702674434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=atKYixDgc1IYLIAixNFTtgRe8JLDt6J5MMwxSW6b7Pg=;
        b=r7BdHG8VStUbm+h4QyUFMMRIhoNDnQY0D3t/d7dmkMDYDKOyP4v1tYRszFTXTUO31n
         MxsZetvujkvUK41OaJBcqx0zUSrEdjFPyGJPUMcPxJK1oteunVwzTg48fuUuRaJAyy6d
         7NWpv1EzHYhMIgyS6r57tlO22qtO711ZfbkMCADPpV+OPF4klJnRZ+1UBbuOSSarB3G8
         NBAYeJHhb0DQHxsgNwPLd9ozu0J8gQMWNTD7YSwswLPzdhF+p2qVNWx/fzAendxYXIWJ
         pM63C4V06AW4dRnquvD5EepNv8eamaMt1UunBvdTvkKPajW05e5VgtXtEOyc1wcAMmMp
         Bh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069634; x=1702674434;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atKYixDgc1IYLIAixNFTtgRe8JLDt6J5MMwxSW6b7Pg=;
        b=EigX35FwYbF8qNcLqCXKKNFQsMiySef5ztc/IsRjSK29bzXhC5tW1RtyyrX2xgxzZx
         97Bsf3o08z7Yc18NCTt8kaqunOefR+5bAkAMUvSBz1Htq3lNiJBnSx47BNiq/VphfxEf
         IcGgwj7WdYWj38hCmNjvOLqQSBdCx3Ek5dblWpx9kF+6tHjQC39DiIYjUGDh4Zjtgo2/
         6yN2a15YrL2uMyFDl8H9doehlcFuJ0p7H6Pb5VtSBMuHeS/Qr8p055TCxBzpC/7rpYDQ
         BPAnqqtC1QS7ScGXN3aF3ExtMiRNmwM5aWPopXoNjTjbUjrJ9oEzXF6CBcKnjh7yPUzb
         ZWmQ==
X-Gm-Message-State: AOJu0YyFD5EzXUZ4zMIAAZwt8SOEE/CUNlnGl7O4aLx4abVnH2BmSV54
	qRbC0k7nJSi4jQUx7BxPNTUnz/K4GHXM
X-Google-Smtp-Source: AGHT+IHzeDvqNFdRZWKrYRWtX4T16qXBWuRFYuGxk14i3a32wrWAEXwhbb0Cto5r9VdTV4zgSQTlXO1gQzao
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:38e4])
 (user=jiangzp job=sendgmr) by 2002:a25:ce4e:0:b0:d9a:61d2:38ca with SMTP id
 x75-20020a25ce4e000000b00d9a61d238camr7101ybe.10.1702069634325; Fri, 08 Dec
 2023 13:07:14 -0800 (PST)
Date: Fri,  8 Dec 2023 13:07:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208130705.kernel.v1.1.Ic5024b3da99b11e39c247a5b8ba44876c18880a0@changeid>
Subject: [kernel PATCH v1] Bluetooth: btmtksdio: clear BTMTKSDIO_BT_WAKE_ENABLED
 after resume
From: Zhengping Jiang <jiangzp@google.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Zhengping Jiang <jiangzp@google.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Always clear BTMTKSDIO_BT_WAKE_ENABLED bit after resume. When Bluetooth
does not generate interrupts, the bit will not be cleared and causes
premature wakeup.

Fixes: 4ed924fc122f ("Bluetooth: btmtksdio: enable bluetooth wakeup in system suspend")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Clear BTMTKSDIO_BT_WAKE_ENABLED flag on resume

 drivers/bluetooth/btmtksdio.c    | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_sync.c         |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index ff4868c83cd8..8f00b71573c8 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1296,6 +1296,15 @@ static bool btmtksdio_sdio_inband_wakeup(struct hci_dev *hdev)
 	return device_may_wakeup(bdev->dev);
 }
 
+static void btmtksdio_disable_bt_wakeup(struct hci_dev *hdev)
+{
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
+
+	if (!bdev)
+		return;
+	clear_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state);
+}
+
 static bool btmtksdio_sdio_wakeup(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
@@ -1363,6 +1372,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 	hdev->shutdown = btmtksdio_shutdown;
 	hdev->send     = btmtksdio_send_frame;
 	hdev->wakeup   = btmtksdio_sdio_wakeup;
+	hdev->clear_wakeup = btmtksdio_disable_bt_wakeup;
 	/*
 	 * If SDIO controller supports wake on Bluetooth, sending a wakeon
 	 * command is not necessary.
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0c1754f416bd..4bbd55335269 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -672,6 +672,7 @@ struct hci_dev {
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
+	void (*clear_wakeup)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3563a90ed2ac..6c4d5ce40524 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5947,6 +5947,8 @@ int hci_resume_sync(struct hci_dev *hdev)
 		return 0;
 
 	hdev->suspended = false;
+	if (hdev->clear_wakeup)
+		hdev->clear_wakeup(hdev);
 
 	/* Restore event mask */
 	hci_set_event_mask_sync(hdev);
-- 
2.43.0.472.g3155946c3a-goog


