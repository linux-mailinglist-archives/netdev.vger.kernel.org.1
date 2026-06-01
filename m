Return-Path: <netdev+bounces-293712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCOCBhJzHWp8bAkAu9opvQ
	(envelope-from <netdev+bounces-293712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:54:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B232F61EAC0
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D0FA3025C5E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814D436AB4B;
	Mon,  1 Jun 2026 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAd8ziZp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D5374735
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314886; cv=none; b=HzQBh8XZx4QlsDrBdhu57otBZmQdRxnLSaCmKO5LzyvbSdB3Gukm6OyfC8YLMeOGX0DAtXyGbVnaVEnfOEiAlCkCXFMZcxIGs4AvIckP1yg2XKRL8VDeu3e6AOlGBhnIPB40Ktb4Ub2ZGyy93MPcbq8nAKBaWThiNB967/aTfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314886; c=relaxed/simple;
	bh=/MJFSPlvs5mZWGhdecQ4fcijYscXLZSLokdxWNxoZuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WS9E5R3kkIAiKzD+pUYPN25efXZpYShmjWUKk2qKNljXWKIKNRHG5oAnmez4A9BeGdPWeLsXvyPNQW/s2W7x+dq2giGuEsvJuCcAyS1qWB5x4d2QyHDRZY2SNF+eoMJ2GUNUsj63SFF44LOawyf8Cij6KJdGake/SuqL3gelx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAd8ziZp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4905529b933so76542555e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780314883; x=1780919683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trrNXQGXY7+MtELdar3MOROhYjZWKsC5AzJ+xzOQrGI=;
        b=bAd8ziZpHepexlgs3YvuqLHGLg0nlcC0RspV+SrYJNr/31LVT/UCR60i/6A1Za0mOH
         iRv4AL4MVuG3E0bUGQXdrMySZQkYhCFe6wJRUyS+EOulEH9TYpFmMaLVbArHJNHDwtBz
         fQ5ted5UucfUJF9zVdq+pTPxhgY3JZiZPd527n42w5OpIRP/LZfIL/4QG789VgeW5feN
         9+3rJNUe2rzcwQUIkr3RW0HWMcOgPfwezcjIxAO2wMeklZc+aikjNdreuHXfpGOZgauK
         F5BLhCE3Y8DaJNJiPSP1ua9UUXF1sVodQAabX9CmKoLIMAl5POPurnTJjS39ye+43WUB
         zQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780314883; x=1780919683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=trrNXQGXY7+MtELdar3MOROhYjZWKsC5AzJ+xzOQrGI=;
        b=K8fMgakvguvZYgq7MBMwaYBOiVUdvsGWK2klLvFH5jvh1c3ZS5jvWXTng4YXUc+NwJ
         +dbXnxr4TJzejYgOIQ89pR+Quj///3G1qE0ESMwx4aBGv66fzUQi4wVoLxhJoPo86RoD
         SVU1Xxgpl/GleVN98epTptYm6zIN10btr92UQfv3iHFkQfP78UHaYdm5LbQoWO+zqopy
         BCc+1uE4JJX6cBOMvTpOI1pftwDutinZdTJp/GpeMwe86lUt1qsTEjlkSsKFpPB6ObkU
         VLHzGCOGj3ED4yMBDwHUI0Ocmfdxa0zteBcN0X0+mocoXKjqEVasVeDpFaWukI7Vv0Ot
         6jmw==
X-Forwarded-Encrypted: i=1; AFNElJ8XAEUSLqgWpx/KXnJ6CH6MEq9t+VpOXdJtYDHSt12ckpYXudD39brHwslr6dsrpPsSiYZMGbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzftrd7UZPNde62Pb45Ifu7TbtiPBAy9rhn8huZ2UX/JO64FwZ3
	3id23rIk+xhViC0qrkAaWwIKxCoAY0DsV+a9Skr8B9Moh5vO4O6kz6mY
X-Gm-Gg: Acq92OEfrDtHXemntqcuTXpDAUlb3lhLUdcpKVU8KCQPmnbJOY/wGHaUM7Ll/jLzUTz
	fT5B9tvNFLZca1bgqaWb+Etid4MGJ8YyKZDTcReTCA1zXvJrfoSQb2sLCm5l1qKByKqV2cH0CWL
	mBwZfozxox1x0Lzd3iTiBSR0SWIzmpPZx6yrErBvzJk8Pvp2PMjNm8aOQPN+DHowB/2e77CrrSh
	GEQUrH8NFEC3YVt3gojWt8lQDQsjCH5RduPbdKGjXzEruWn91DlwmkkGkTPj6f16+ry7dXjaDzF
	pYWvQcQOABAiCOUYd06us5CkXIU8tuw5keqpLezXSVIPXNwtkyxQFsq8vhSTf6cD6jFcsLrfUJL
	gDTgQDNKOJ0jvO3+D5utZyUx2uVLqEfWqY/y6BTwEyNANaUcJZxmOILM7IIEUjp5SEN2/TQWkHG
	v/2IUg1LThIQ61VnkCsqGtMYS/RdnAjd4HV+s+k8X2IEK5sbBDjE90DcBgTCZT2jY4B/8xPIcmC
	s1y5VjxP3vSUd9rXRp9
X-Received: by 2002:a7b:c854:0:b0:490:9699:4428 with SMTP id 5b1f17b1804b1-490a2964057mr139027225e9.26.1780314882815;
        Mon, 01 Jun 2026 04:54:42 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c121d63sm74376765e9.29.2026.06.01.04.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:54:41 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Mon, 01 Jun 2026 13:54:13 +0200
Subject: [PATCH net-next v8 2/3] net: ethtool: add KSZ87xx low-loss cable
 PHY tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ksz87xx_errata_low_loss_connections-v8-2-cfa102cf62c0@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com>
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tristram Ha <Tristram.Ha@microchip.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>, 
 Fidelio Lawson <fidelio.lawson@exotec.com>, 
 Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780314877; l=2628;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=/MJFSPlvs5mZWGhdecQ4fcijYscXLZSLokdxWNxoZuI=;
 b=JC/m7aYSN+Sm1pL5b5qBroXrn2nvj+teX04iGXNoCFfOFa3XXDmvBS0CbP2cdkNof8k97AlCz
 /TEYDRUt/ZeDhWY4a2xsHlpRSOl9EEJr0TyLXCF1mkDicLLJB0gsQJn
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293712-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nabladev.com:email]
X-Rspamd-Queue-Id: B232F61EAC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce vendor-specific PHY tunable identifiers to control the
KSZ87xx low-loss cable erratum handling through the ethtool PHY
tunable interface.

The following tunables are added:

- a boolean "short-cable" tunable, applying a documented and
  conservative preset intended for short or low-loss Ethernet cables;

- an integer LPF bandwidth tunable, allowing advanced adjustment of the
  receiver low-pass filter bandwidth;

- an integer DSP EQ initial value tunable, allowing advanced tuning of
  the PHY equalizer initialization.

The actual behavior is implemented by the corresponding PHY and switch
drivers.

Reviewed-by: Marek Vasut <marex@nabladev.com>
Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 include/uapi/linux/ethtool.h | 3 +++
 net/ethtool/common.c         | 3 +++
 net/ethtool/ioctl.c          | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 1cdfb8341df2..a2091d4e00f3 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -291,6 +291,9 @@ enum phy_tunable_id {
 	ETHTOOL_PHY_DOWNSHIFT,
 	ETHTOOL_PHY_FAST_LINK_DOWN,
 	ETHTOOL_PHY_EDPD,
+	ETHTOOL_PHY_SHORT_CABLE_PRESET,
+	ETHTOOL_PHY_LPF_BW,
+	ETHTOOL_PHY_DSP_EQ_INIT_VALUE,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/ethtool/common.c
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 84ec88dee05c..a24d3a8a9ec1 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -101,6 +101,9 @@ phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_PHY_DOWNSHIFT]	= "phy-downshift",
 	[ETHTOOL_PHY_FAST_LINK_DOWN] = "phy-fast-link-down",
 	[ETHTOOL_PHY_EDPD]	= "phy-energy-detect-power-down",
+	[ETHTOOL_PHY_SHORT_CABLE_PRESET] = "phy-short-cable-preset",
+	[ETHTOOL_PHY_LPF_BW]	= "phy-lpf-bandwidth",
+	[ETHTOOL_PHY_DSP_EQ_INIT_VALUE] = "phy-dsp-eq-init-value",
 };
 
 #define __LINK_MODE_NAME(speed, type, duplex) \
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index bd97f9b9bf18..fc2542422824 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3114,6 +3114,9 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
 	switch (tuna->id) {
 	case ETHTOOL_PHY_DOWNSHIFT:
 	case ETHTOOL_PHY_FAST_LINK_DOWN:
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
+	case ETHTOOL_PHY_LPF_BW:
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
 		if (tuna->len != sizeof(u8) ||
 		    tuna->type_id != ETHTOOL_TUNABLE_U8)
 			return -EINVAL;

-- 
2.54.0


