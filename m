Return-Path: <netdev+bounces-286551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEnRIUKeAWpKgwEAu9opvQ
	(envelope-from <netdev+bounces-286551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:15:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 099BA50AB6A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7CAA305635A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A163CAE63;
	Mon, 11 May 2026 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="R7mlUukx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAB3CA486
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490042; cv=none; b=q57kEumHycShXTfP0FaM3JZ8wfpJxlfMWtrQ2C9FGnNEKIeK/B7YuXG/ToBiz2+oBGPl2jexK9Imykqg5OJMvLmu+JMG7me63BWwwXu9Uu2yhLb+CnnG0CxxCCvCaC0QcTAPWAlbCV+fgRCyOmHVMEbwD0jvU/ys57oaMJEu9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490042; c=relaxed/simple;
	bh=Kmkdv+JItc7RXFEYypWz1eqdH06BDJgHgWvSOlnnFwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHtoT0BQg39kZzm8reLDIMI3ujlcj6lcSfbsTMhrrCWmMWwvUVhG7LVlQfFDknx6UgdvMOx+2OshZGEgzqdmTir0S1nUlkNj8JXLyqLNMhQHpN2h00lT+noI9XV4zGcHwhGN7kS2YeQW/EPfyumhHv31G4GD/P4qLxLGTqHcyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=R7mlUukx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso44341655e9.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778490039; x=1779094839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvfLvRzUMTYBwDVHoxegDDMFQnJDzs2qD2f5nvtjo08=;
        b=R7mlUukxr/Gz4+MQ2d6twzuvU3DEkc/C5wV6dyqYMHrzIls878ycYusmIS4Bg/vebe
         L1/zrE4b/g9Md4xsia89Ih60ctRUDbMpN+WzFfYZh6pIKOlOo/NTA6MFAzMRa3eqmOAP
         UHATcL5xHY2kb4j+WLJPu1izhX9dmwNM0xM8B5D9yfbMVlEziZrKPYSzv5Xzfosm3Jcv
         AoMqzzuh/2HcZIhHbVqpBL5JkdDxlGg5iOTNBmCdwa2xASex8Y54ilm6wZi2TFk2qE5P
         J0jse8vCd/B6ytYf/NyWBXDfi7rl81zUOmD0nHXZwgiwd4OWEE6NA3963BV99wPsmaLo
         HFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490039; x=1779094839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BvfLvRzUMTYBwDVHoxegDDMFQnJDzs2qD2f5nvtjo08=;
        b=nQP+fSKS1ydz1QyFcyc+YCPmRCB4rqYxv8CaNpTee9QVpOrWwkPbJnPZ1uBZmdfaIz
         9Iq36xSXYO5OQLDsjXvET40uWsEv1DGcuHYwL5RPTlROgJvzfEDVu3pq/hZ14HU8sjTc
         KFPxO9+Ysfoa4kgFXeUNsSImNEZqRvLIEU5+OSdYAltpoBnSpxO/PurCnEFmpEdB1lgu
         WAfcCQNyNDYrJID7/EST1XW53rlY6+Lb4SrUs1wNFsFfNMw9+AFkUvup9OSGoD8E0xm9
         Mm5spAVPsSUdL9dyHM8OREblfZeljvk2OYGw8eTYp7ng7z8YdZxRWRkV3hO74Zrs6vm5
         8+tQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lg5mPW/ugZZZmUPUcm0ldvinN9UZcRS0wJIUbfvqO54G3E3jrcBDs7ocpJZZOg3tpDjx7TgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRGOcbE8Ih6iOudeYPT7h9bMlS8apPzebTZ6Xrz1m0c+7+g6E
	Moq3ad/RGK756ws6pspd3O+z4vPBA2MwnNpXtLPRyvXqzgTTU12elQpaC3vVhN3qdM4=
X-Gm-Gg: Acq92OG0E7JpJltV/QuDy9Tt+btlHVCQR27Dy5mul5VG8aQsGdpYewvoA7iveFYUZzc
	3i8LIgx4XtXvGvkJ8KWP8DrjtMkHtF1WGLUwz4DLCnAp4IUt4HwSbLa3QfTDq87wmvTyyDaV1qU
	PLHEaMG57FAE58igMl+kVeRamiAE+c4e4mtn5LPl0Ki5ZtkzW0aWaKoTKMCeOIu7KvoU/6r+FL0
	ywKbztnmhQ7NzqUKhmDpLX53DXFIfoZA/mCPuKDdjxBP+rj5e7AOewV+UmBTr98+n1aXixAEU0k
	/VZzddVdzZ8iM7905bPWYx6+FLePj0UGODPaTE2GxldBZgSpjU6IdKjOqecmFL4B0hqO6a/C8dR
	i2YQCs/clz5CTCSTn24EgzaaA6VbPXmkdZIottnYBcWdUV3tb5e11pFIl/GBAY4kpkbc93tCW1J
	nNMxKBD96omXoblNNKjA5HlrsHcaPkXBpFC0O74LXd43brxpk/VtXvSAqRf7Zy2+WrBdTYvMfBh
	awm7hrXFFHGEpY=
X-Received: by 2002:a05:600c:35d2:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48e51e15589mr390579025e9.9.1778490038760;
        Mon, 11 May 2026 02:00:38 -0700 (PDT)
Received: from localhost (p200300f65f114e0841c796eda31a14b3.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:41c7:96ed:a31a:14b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e6d8d30dbsm91750895e9.1.2026.05.11.02.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:00:38 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Petr Machata <petrm@nvidia.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH net-next v3 1/2] net: nfp: Drop PCI class entries with .class_mask = 0
Date: Mon, 11 May 2026 11:00:23 +0200
Message-ID: <20260511090023.1634387-5-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511090023.1634387-4-u.kleine-koenig@baylibre.com>
References: <20260511090023.1634387-4-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3842; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Kmkdv+JItc7RXFEYypWz1eqdH06BDJgHgWvSOlnnFwo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqAZqqsFoyfw/h9GxEoUsS80aIp3ndnt8y2xmVY N7LWkFMtMiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagGaqgAKCRCPgPtYfRL+ ThvDCAChESklssChquHPcnA2/M/pJmyuKBdZKFr+2THOTSiUzNu2S6OzNp9BV7RPUF3SDLmeOc5 Xe9vrIU2ahH3VyedbMdgzpfCZnVEAlG40w+f4Yp/FjPWhQLWGZ83qMTmjx4Cp9SBbkObUCFQimz yds5zVmt3FeGBTQUE/Vv6pc/7mHyzlfczwKqEcEAFDpKia7mpmDqTVrKo4mH5ZglTgSzkwMphX0 YYSliRILeTz/beJqjdpqAUZYsMqE9UbEX24gpZVqWafGBw39V/+Ed3ZJTAeqll5Nl/cb7RwRZHL hMa6lQ82E7fbXyVq8cCmKVnHWXPSPV+cTjLmAjZGL37i6Sem
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 099BA50AB6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286551-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,baylibre.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

With .class_mask being zero the value of .class doesn't matter because
to check if a pci_device_id entry matches a given device the expression

	(id->class ^ dev->class) & id->class_mask

is checked for being zero (see pci_match_one_device()). So drop the
useless and irritating assignment for .class to match what (I think) all
other drivers are doing that don't need to match on .class, i.e. set
both members to zero.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the equivalent of this patch got a Reviewed-by tag from Aleksandr
Loktionov. As the patch changed how it looks considerably due to
reordering the patches I didn't add it here.

Best regards
Uwe
	
 drivers/net/ethernet/netronome/nfp/nfp_main.c    | 16 ++++++++--------
 .../net/ethernet/netronome/nfp/nfp_netvf_main.c  |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index 48390b2fd44d..2dd8ff330fd7 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -35,35 +35,35 @@ static const char nfp_driver_name[] = "nfp";
 static const struct pci_device_id nfp_pci_device_ids[] = {
 	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP3800,
 	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP3800,
+	  0, 0, NFP_DEV_NFP3800,
 	},
 	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP4000,
 	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
+	  0, 0, NFP_DEV_NFP6000,
 	},
 	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP5000,
 	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
+	  0, 0, NFP_DEV_NFP6000,
 	},
 	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP6000,
 	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
+	  0, 0, NFP_DEV_NFP6000,
 	},
 	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP3800,
 	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP3800,
+	  0, 0, NFP_DEV_NFP3800,
 	},
 	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP4000,
 	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
+	  0, 0, NFP_DEV_NFP6000,
 	},
 	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP5000,
 	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
+	  0, 0, NFP_DEV_NFP6000,
 	},
 	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP6000,
 	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000,
+	  0, 0, NFP_DEV_NFP6000,
 	},
 	{ 0, } /* Required last entry. */
 };
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
index b5646c884371..2414bcd319b1 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
@@ -40,19 +40,19 @@ static const char nfp_net_driver_name[] = "nfp_netvf";
 static const struct pci_device_id nfp_netvf_pci_device_ids[] = {
 	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP3800_VF,
 	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP3800_VF,
+	  0, 0, NFP_DEV_NFP3800_VF,
 	},
 	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP6000_VF,
 	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000_VF,
+	  0, 0, NFP_DEV_NFP6000_VF,
 	},
 	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP3800_VF,
 	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP3800_VF,
+	  0, 0, NFP_DEV_NFP3800_VF,
 	},
 	{ PCI_VENDOR_ID_CORIGINE, PCI_DEVICE_ID_NFP6000_VF,
 	  PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID,
-	  PCI_ANY_ID, 0, NFP_DEV_NFP6000_VF,
+	  0, 0, NFP_DEV_NFP6000_VF,
 	},
 	{ 0, } /* Required last entry. */
 };
-- 
2.47.3


