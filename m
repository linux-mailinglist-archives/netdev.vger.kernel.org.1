Return-Path: <netdev+bounces-39675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0779B7C4069
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E6F1C20B86
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDA9321B2;
	Tue, 10 Oct 2023 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aiQQO/ru"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E3321AB
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 19:53:35 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B1693
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 12:53:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a581346c4so1550015276.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696967613; x=1697572413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w5E9MxIyYhKzMBpNRM6CeDwnSabl1YmaOv2YrvO7ZwA=;
        b=aiQQO/rurAS5Lnl/Q2g2+N5y+Yflc4WrKFmJcUT10ZAxVnQYiJayZdAJht6JSma8nn
         ADTCEnoq9gNSnPa6P/NTVhjeq6U6MhQZQh4ua6XV+6Mqn40K9Hjy4d1+z7vbXNcxRtMT
         gPEv9zI8NeQ3/5ARcfC9tKSgmTjxCS0+T7whSWFrlPfbv9iJtK9z8i4s8h9e57SOMqHr
         yt1pxTxt5JKhjkFxvD00vofri7Z7PAjuZhJDc4zwg3os7ak+8c1iYb+KEvY2Xuc5VCvc
         m2p4u9uH2RkacQHoNobL349x8VxGU0vZiy6DpWxJ7L/Sg4B2AAm0dg7lLhNpJD5ZESeg
         +RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967613; x=1697572413;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5E9MxIyYhKzMBpNRM6CeDwnSabl1YmaOv2YrvO7ZwA=;
        b=o4vHPmqRW4kjcIWIvG9SLryPnqMAN7IZnM7pJxh7F8tg34UgZpzbPlvXkhz6cGifOy
         hAO2BvnTl7ba94haE9C/ypTSJv5ixram72g0AcERzyqpwacyLVbo36/L6mBmEkjYCnI/
         /VuAxyk6Pg4oYXrz/Jq0bJSyHJDtbCL7Nu8967ATG6FvftzYWQg2zkpErHttS4mWSFut
         TuyVCxQME74ilnDl6tAAIAT2TJx4YsMWgGuoYc6nOuPyfMQFb5Bn805iryK7KEuAMCLJ
         /efiV0WRV0IXIaF39c4lvTofZ2in85LCYMV4GI2EgG1wcjNc4ffJ0WGVJexjNidXSs3F
         Cjkg==
X-Gm-Message-State: AOJu0Yza7qkDWfHmco/QK4/H17jO6pOJULjZ1bdSg0Ev6LvGMtftQrJV
	WLEg2dU/A8FrppQ7jT2s9ZgOIwAgUC0gjarTeQ==
X-Google-Smtp-Source: AGHT+IFf+EcNSed1EvzahNf05j6H+bR8LMoGehNG9vtR75/usZMZPFVfBU6LyeUKu8sWdgNzGSviQJZCAAOpdfkScA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:85:b0:d86:5644:5d12 with SMTP
 id h5-20020a056902008500b00d8656445d12mr357348ybs.4.1696967613332; Tue, 10
 Oct 2023 12:53:33 -0700 (PDT)
Date: Tue, 10 Oct 2023 19:53:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALurJWUC/yWNUQrCMBBEr1L224VsFRu8ikgp6cYu1qTshqKU3
 t2oP8M8HsxsYKzCBpdmA+VVTHKqQIcGwjSkO6OMlaF17ZEcObSiKSxvHFVWVsPEBblMrN8iqfC M8Unu8c++qpLzjAE9+RMPXefPFKHOL8pRXr/r623fP2N/8+eKAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696967612; l=2330;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Kd8rwBEMi1NtM8y4ozGswyeCAqmu3EbqiQJnq7rYFR0=; b=OC+eT0HLH7q5dOLGigWF8Rx7ymgW1poduMQ2TkjiGHXmUxXOMiXpMWi9S1WtDr2E1QqE/23iD
 A1dqQ8QKh0RBofrRZ+itXkeKDgltYr22tc53NO8eW+Zm9I7v62Xp+fW
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-ethernet-intel-fm10k-fm10k_ethtool-c-v1-1-dbdc4570c5a6@google.com>
Subject: [PATCH] fm10k: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Other implementations of .*get_drvinfo also use strscpy so this patch
brings fm10k_get_drvinfo in line as well:

igb/igb_ethtool.c +851
static void igb_get_drvinfo(struct net_device *netdev,

igbvf/ethtool.c
167:static void igbvf_get_drvinfo(struct net_device *netdev,

i40e/i40e_ethtool.c
1999:static void i40e_get_drvinfo(struct net_device *netdev,

e1000/e1000_ethtool.c
529:static void e1000_get_drvinfo(struct net_device *netdev,

ixgbevf/ethtool.c
211:static void ixgbevf_get_drvinfo(struct net_device *netdev,

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index d53369e30040..13a05604dcc0 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -448,10 +448,10 @@ static void fm10k_get_drvinfo(struct net_device *dev,
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
 
-	strncpy(info->driver, fm10k_driver_name,
-		sizeof(info->driver) - 1);
-	strncpy(info->bus_info, pci_name(interface->pdev),
-		sizeof(info->bus_info) - 1);
+	strscpy(info->driver, fm10k_driver_name,
+		sizeof(info->driver));
+	strscpy(info->bus_info, pci_name(interface->pdev),
+		sizeof(info->bus_info));
 }
 
 static void fm10k_get_pauseparam(struct net_device *dev,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-strncpy-drivers-net-ethernet-intel-fm10k-fm10k_ethtool-c-8184ea77861f

Best regards,
--
Justin Stitt <justinstitt@google.com>


