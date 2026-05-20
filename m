Return-Path: <netdev+bounces-289848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJv5KcF9DWpEyAUAu9opvQ
	(envelope-from <netdev+bounces-289848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:24:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF958AB1E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1237B324CE28
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8634B3AFD1D;
	Wed, 20 May 2026 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fihijkvt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9829364E84
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266952; cv=none; b=Q+CUzDS6LOZ4hWIwRpm7JjXyLIFTvj+3rSO49+TVE/ukE1cNrpDdM1/vzAdi5GsKlSBJSkMHhO7lwKtTGqz0MNJ9Tncxl+4tVtxgAoraDhaBLEMHwEDh0GcsZ1Y+Ml7tm0OdW2odAdwCMSoQGHUK8cFwkYS1UZZhPa51tgORXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266952; c=relaxed/simple;
	bh=gx7A00isc7RmHttEx52KE0RV6KvQzLxU1Ys+dmiy2c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDkxibJu6xaSLOvONP4KggrNo+2E5xRRyuxeZvPcbkIj79HvrP8Aoeq+ad/x2eprrsR9pPSyiddHIOzwoJQ1mURCBCprR3xc0i5hU6Ro7JAtPZemi+eBPueqc/mhunGdOb3bTcLJoFQTxT8VWbZPy1XT6fhXM3BDni4GA8lyHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fihijkvt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-441209fb77eso2801270f8f.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779266949; x=1779871749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4cXplLEpKYnCchclmkDMqifsuTXLnl5XMB3nAYB268=;
        b=Fihijkvtv5ek77Toz+4RbbFspq5BlGMZ1YCIYGFGp3UFTCHblO5rb/RQWBxCnIi6PS
         fH4aiF9RB6b4NHEXxh4/xz1gO5wVK/UO9HjFrI+8VXhI8M5Y4eHQW2s/06qtFkewVcd5
         Tkw7nCB7+LF2zTzalbEWKDHWOtG53FRLI+oDs/SrVkaWCPmtNFsR0X1KlMZQ8hFnojUJ
         0i9DHVzpJMb4x7lTlWsx+z4NgcBWI7RTKoYatoHldnILMl7nfIneL+X0aldq9XelZ/r3
         CQylgCVaMkjZOOcNEUx3UEECX5vk6yMbmihgILpzyHQLF9MuB9kY2j4rLdquXIyRFBXy
         JqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779266949; x=1779871749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x4cXplLEpKYnCchclmkDMqifsuTXLnl5XMB3nAYB268=;
        b=VOp7KiLKG55xaf2nyu4upRfZtx/LjVrXClowaG0OPTWuXmn5wwTuRogEIffsgPoVeJ
         3IoAiGWWa1zyuN9JmRF/nvBIab+GSVJ9etDK+6wSLIjo9pdb7fge7CTd1Vap2Vvn8Vfl
         /0k2bgy/f2kubPAuiXaeZucigTPzlfKILXDFuw+Q8xCSSGwuhItzs1O+DBMRGs0r+Lhg
         UpXZqN9WLQJEBV3V37Ux6BijDmVeFto970rhRiipQ3nlV9CIT8Ue+OT7QKyIjq4RXc0a
         eDSmj9eMQRR8U2d7G8bp3JrcSaRAhvz4i7NqBczgAtBGy1YD2CTM6eya8MiypZEwRUDf
         2pXw==
X-Forwarded-Encrypted: i=1; AFNElJ/ALnt4QTKW9NUpqMWRzulzm4hHNWvN9qmS0iCVF8ynxFjKeT8cHTbMjA6Iz+7U7tm7RWN0Zvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPap/5qxFTYyg2TdRsqvQm9QYFvmdAw7Ve2FN6hcv3InvXVkS
	go1XpmI9Zezh1vhm4aQaAgjMQ9NWTa5DeExhxYLooCFMgLJQ2hLkK0js
X-Gm-Gg: Acq92OHSIA3ylMi2uaEML3zhNl4+skDcJ/q7G6IXSYqZlmJ6Zh5AufPc6RlpH3KiZ9P
	3Evgc6+4oIjMgcIbOB0xnfL7IWEQH/pdCaU2E8bZPqnX+LVsxeuqfCbUUQXRmSjDGIAJt3ZlTYl
	i8y8HumV7DoXgx74drke78u1nWqP2Pr/B4rdzPIWh7MHM+P/faP166KuiVpoHdHrQW5Y6gN0F09
	sohLiO8z0TaJRvP6DgqntBuy9ZLuj0oCRJRenzBK7/G6laoDGfC7Wg4Mnh7wvSFsGTCQw4K8Itu
	ursz/dvMZ61Y6rG7ykxci+qfvRkMoCl+999pmcnVvEKtdlre3a+Fhh1itjgtAVvoheNYz85f1yn
	lRu9qmp6NdDXYST95uGkHF6uqFEJ4y+R5HJGu+0UhetQnBTXOQz7OQ0BDMJVqj/F0ZSURB4Xjye
	IVi1fdEKD7VLDmuZwpS/TOUdt77nVbC5YvJUilC/X3CICOWK4OXyEWBdisWAQjdzwcI2P3tklpk
	YGIzKRMBg==
X-Received: by 2002:a05:6000:2885:b0:44b:5a37:36c4 with SMTP id ffacd0b85a97d-45d941b198fmr44851329f8f.26.1779266949221;
        Wed, 20 May 2026 01:49:09 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm51244283f8f.9.2026.05.20.01.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:49:09 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Wed, 20 May 2026 10:48:57 +0200
Subject: [PATCH v6 2/3] net: ethtool: add KSZ87xx low-loss cable PHY
 tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ksz87xx_errata_low_loss_connections-v6-2-43f33d4aaf0f@exotec.com>
References: <20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com>
In-Reply-To: <20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com>
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
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266946; l=2581;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=gx7A00isc7RmHttEx52KE0RV6KvQzLxU1Ys+dmiy2c8=;
 b=PAjhy3pxHd5CswMBeXxsyZ7t2LNWU1+WZ8sWa6vob26nuZODzTgIffh8LY87HPoFCHJyWbkcf
 qVMrIF21RatB4O6a3U4zBVsR96hKF4nuKEbAPTLc2cGoSnUH+wmfIcQ
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289848-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:mid,exotec.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 01BF958AB1E
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

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 include/uapi/linux/ethtool.h | 3 +++
 net/ethtool/common.c         | 3 +++
 net/ethtool/ioctl.c          | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..081d8f2191b6 100644
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
index e252cf20c22f..9c2fe5b626d6 100644
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
index ff4b4780d6af..5b66e4a96f67 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3109,6 +3109,9 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
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


