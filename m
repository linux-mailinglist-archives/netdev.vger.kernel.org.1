Return-Path: <netdev+bounces-285242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO3TNLZu/GknQAAAu9opvQ
	(envelope-from <netdev+bounces-285242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:51:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D471E4E70AE
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B571300AD84
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42E3ED117;
	Thu,  7 May 2026 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="VuLnmV1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D473ED12B
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151051; cv=none; b=HQdrTGkSWfpR6yowSulIv8u5OFwD3leeuNlpMJx5bCtxDZe3tIBPH3Xnnayephdy+vFrbLNBzTQrIN+XXG16oU5G3p/o9Cngm8rIfW7ilsHWclK539kF+h9spJnFwVolur6gzSxn4tyf7pGl8TK9nuihYQ02b6hTwwDhYB3oG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151051; c=relaxed/simple;
	bh=QBDRVKMHiC38ua/WqXZfu2WimUgpapC8UXjmRJjp8tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUDFNozE7UvkY83ET9fWa2zZGIDJjrRIGZzJtmuzTkPtavhp00Z3+LzYosDieV02tehG5lI08QQf2M9PGauuAIrnhRAjJ6pXAdkxydaR1Ot2VYFLynSUk1t1bm5s5VOlzDH44CPlLZQNIbxMBGBOEgVrmqbNjtcZxDfhjAu7B9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=VuLnmV1m; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so6686285e9.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778151034; x=1778755834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKPIZuTHrD4PJDRdCBm3rauwc6LXlrUOHX/U9Kam4Uc=;
        b=VuLnmV1mnDHKKFGC0xBoyTtgclWAKs5Be6MWs+tLY/A2nqzNoC6IMXSG0bWH4He4FZ
         IK4BORmn+XJTDrT52MaUXyKspkDWGy3ckaCRgG6xBPz6px1qjVKbRive8QSAOdmWSjt5
         ep40EtjBj08VxnVU/zzYT/o6H3TE+BgBmSWntuH0+uJcYXU3z0b5CS6zPQDV3TE4tine
         PIYWGkGF09kh/RwaZ1BU6Stp3qUwdDclqIt+8RYcRV6VBcBI2xZqXEMc6Z8U/74JU+o0
         0DSYh3NRc+gv0+A5FVLEkZISHTqKa8apy4p6ycAXTKm4X1SGDGacCkTIAgdt9evJz9fV
         DD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151034; x=1778755834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OKPIZuTHrD4PJDRdCBm3rauwc6LXlrUOHX/U9Kam4Uc=;
        b=CexVKesuiq3yGQZv2BmZ1bywCOpk4t/K6WzaO34ag4NUqgSD+spXEEGDPUthj326fm
         n2hmKm8gK6F/IzUdGw8RpPJuUACjLonRnkLvGlmGY3aR7RlSAJHah0NaW2kD2aHJDbM0
         Qn+rmwdgKb99lVjvVf/ppg5d8xIN3K+45FaAnyMeixHQcYgmXQwDz2TpDHnzHZh/3EJ/
         n5QTlVUf05xR1qAvoog2H+rs2FG/pXKxY8etUNqKLcDWXmzLg1V1LrIeCWzhcZuClHjd
         cbnMhAT+itfq5/lFIkngkUFZONpvwrRrWTVgoixW5TZeKaiJQaVMfVDB7GOvSa1GQLmH
         kTJA==
X-Forwarded-Encrypted: i=1; AFNElJ85TRoDb9DdqZxnwmYo4BUE7GHGiKWsbE6zY8BFhHvZLD4I7XQu+S9H+kQtFw82s0rB5E9aSOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZ3eKgW/8LJLM8QpMCCe+aIKFebJDKenZFRZORZauwV/UjsQX
	RUVJNY6v7rU5zbbjuDQMer6cxqtw9VL+Ich90/h5yT5nzFQfWg4BZUbCjiyVxiyK1LE=
X-Gm-Gg: AeBDieuJ0lNM9PBa8rXSNO/VQxtZqNp+WbXDHMzeoD3OVOPmr1HaBPEqvS7i8j3bM09
	pQef1sN1u1b9HVdVy94KG3/Y5JmmZvCjz5BrJrxwS4XuyPopJhUXYV7woK7No5vd9eoGS0WeVcq
	Dqjn8j0IkD+ZQDL9oD+qlWxQ36jOH/9xQTikbLZ7jCskOOOlLrJTd4Kz/PMKxNntIQ9Zrb14Qef
	Sj4VhaeHbHWxx4ECpdYV0KinP9sDL4SoGsAz5R4NmCjDsdS1Wv0bUby2VY+cy5+voXSEr6YApYx
	uwjTNFbc3iK+Cq/em8FLXNE3qZt4lDcwBCG66VCKkiz9cjLMCb8aez8HxPx3E/ZoFVk96fsYuPK
	hRXg3y5aeXtjhPO/m1pFdOfleWS8SP/bFba/a/30jPhlXHAnXNmLy64IMcUJ93J7PR0rQDAC1ZT
	nuMU7CbupICUyYzwo8me0IWVOgzSeAndCfOicJzBAT6oDEqml4sKTgv7SJriNJe+w72rxf6x1a2
	cA9GE8cErBv0HKh+oILVpUDxWc/jVdBRDKE
X-Received: by 2002:a05:600c:c11c:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-48e51f2a79bmr87390495e9.8.1778151034179;
        Thu, 07 May 2026 03:50:34 -0700 (PDT)
Received: from localhost (p200300f65f114e08ac341e0bb79e5496.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:ac34:1e0b:b79e:5496])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e530b05d9sm52669025e9.3.2026.05.07.03.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:50:33 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] net: nfp: Drop PCI class entries with .class_mask = 0
Date: Thu,  7 May 2026 12:50:20 +0200
Message-ID:  <e853a41d232ca831a93a84545dab322cbe5d49f9.1778149923.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778149923.git.u.kleine-koenig@baylibre.com>
References: <cover.1778149923.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3859; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=QBDRVKMHiC38ua/WqXZfu2WimUgpapC8UXjmRJjp8tY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp/G5vd/uWszppDdCGFbGwoudF8gIUzzL0bwcRn 94WxpDvJTWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafxubwAKCRCPgPtYfRL+ TqdxCAC2/jElg2cWBDtgrUyOeGF/xeGQNVHpIDiGLPUPtE2h3ImAtHV7qzYD9HCcmyS1JglkUBf tPQds3Y6QhMrIjEz9dBHXyI8sPn6nSSp8IYNom5/yxSvwvmcGav3UMaQ8HRur9OCGjhGAsGPV2G yD+47PKTTJYPiUhB36WhhHOAPV66lr6Wf+hhG/xC0vA2Lltb9NcfUX7qhMo2t/NX+xTk5BeyrQJ c5f2xLyPXetEjnWrUkp+GihEbylLHcvKC1bTnruWN/M2srdEBZKGcht6qvWHZ7bRs3ZgPkxfWWY 5zSKiTEouZ70vF4qfKVwEY4/vJJGq0UGQhyCRU/4wiFofoth
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D471E4E70AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285242-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

With .class_mask being zero the value of .class doesn't matter because
to check if a pci_device_id entry matches a given device the expression

	(id->class ^ dev->class) & id->class_mask

is checked for being zero (see pci_match_one_device()). So drop the
useless assignment for .class and .class_mask to match what (I think)
all other drivers are doing.

This also resolves an ambiguity because PCI_VDEVICE_SUB() already
contains values for .class and .class_mask (which gcc ignores in the
presence of the named initializer).

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c    | 16 ----------------
 .../net/ethernet/netronome/nfp/nfp_netvf_main.c  |  8 --------
 2 files changed, 24 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index e8e4b84d505a..5a9fb5bad405 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -36,50 +36,34 @@ static const struct pci_device_id nfp_pci_device_ids[] = {
 	{
 		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP3800,
 				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP3800,
 	}, {
 		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP4000,
 				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP6000,
 	}, {
 		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP5000,
 				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP6000,
 	}, {
 		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP6000,
 				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP6000,
 	}, {
 		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP3800,
 				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP3800,
 	}, {
 		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP4000,
 				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP6000,
 	}, {
 		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP5000,
 				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP6000,
 	}, {
 		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP6000,
 				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP6000,
 	},
 	{ } /* Required last entry. */
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
index cf557e0ce011..6c8f3321048a 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
@@ -41,26 +41,18 @@ static const struct pci_device_id nfp_netvf_pci_device_ids[] = {
 	{
 		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP3800_VF,
 				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP3800_VF,
 	}, {
 		PCI_VDEVICE_SUB(NETRONOME, PCI_DEVICE_ID_NFP6000_VF,
 				PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP6000_VF,
 	}, {
 		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP3800_VF,
 				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP3800_VF,
 	}, {
 		PCI_VDEVICE_SUB(CORIGINE, PCI_DEVICE_ID_NFP6000_VF,
 				PCI_VENDOR_ID_CORIGINE, PCI_ANY_ID),
-		.class = PCI_ANY_ID,
-		.class_mask = 0,
 		.driver_data = NFP_DEV_NFP6000_VF,
 	},
 	{ } /* Required last entry. */
-- 
2.47.3


