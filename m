Return-Path: <netdev+bounces-291162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JqNK7fWEmom4gYAu9opvQ
	(envelope-from <netdev+bounces-291162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:45:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 481AC5C2170
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CC653004D34
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF683932DE;
	Sun, 24 May 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYfnCYPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B02BE7BE
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779619503; cv=none; b=cFv3TVm8cYcgjOca/oa6wCgkiIQxOTrWS//I4eeChIBhGh2ACEe0X08mSR1YM4fWuHGUAvwRXgc5h+QhrPzPkyYW7dnrXcQ9rVlCVeqmHuBGfQtPdLET7fnLGPMK41+K/5Tj3nAyqjjcSlZL+aDjSYR831rpawdQ2JtGPl7mrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779619503; c=relaxed/simple;
	bh=weMwyhsBK/y7RsspN0KWN1ceSl6cDFrR3kYlEQ7OtRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJU3vNB6uAhXuZdGUbJK70K+u/eLnUVhdBPALOwncdZRKT/Z2JuWfR86eq42AKEWS9aw6A0ToHxsU3nBS3MXNRJ4x8RA5ZWw7nLr+9YY1cFqI8b+rzOHakqUHZkOet4so8bSOHyZpUjnFUgZeQWRRU37E7H2x1fbnlE4b8RO2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYfnCYPQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4903fd19957so27231805e9.1
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779619496; x=1780224296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6Ilw3lJxE3L7HPaKc4glBNQa4+87Odew/GEo8ssTuM=;
        b=EYfnCYPQc1u2/Pu3u1vrXBdiN3mpCEWMPyqKJvAypIz1dLGbPXR3j+VmaXJPu+GUVM
         yV9V4ibt2EiXxPejJS4wTeYCxNqXE7+xOaPbLPhgGGDx22J/NUfL+DN6VX7I+/3hSwA2
         D+p2EnlqJ/BMQ30WM78daTNW9YfWgcUUXPP4oIlFfwLyGbKy0QGsF/fe7j8xZQ39d+5C
         tJh1JOtDkWYgZiIro6Vt/BQU/IVjPKoJtdPtIko8CmLzfVD5TbPAVK+7bAOT5JWYocbD
         goar4pXVJCbednS+nidYnfqy5Q8ALnFQBxkyTail+tIUnaMPi7ueRvohx8TCb+Oa3g/2
         RrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779619496; x=1780224296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k6Ilw3lJxE3L7HPaKc4glBNQa4+87Odew/GEo8ssTuM=;
        b=eIeDCfrzJCf8sxExGAKgJ/Acbgakfs0lBZ/BtJZ3UJ2rvx7BS4/tz8FDEKqIUz23xo
         xxnoklCJGFjzHtMPy1G1MJ8QGgmqXB6QyDP+6csDD7Dg1rq9U8q5qHA+kQSacIYIPDiC
         EypTjKjAcGBns32H625ktw5fSIx5HmmazwRjCKtzXAlKMhQ7op2fHZ/RZrC6Da5NTFK+
         foASq5KJAk4Tti0DFeRtpFg4oMe3AFQVHb3fCUj/+TfGbxPDQZoUvuzGGxhb1IYji/Cx
         v3yqDMEpzj+vcR7RscFnNLYTW7FJFb3F0qdqF9kXoZEgQkH38nhXBRj7e45ufHc0Cx+z
         5KqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Hi6ixf7oACnEan2htrYkEAzT+iyQFcwLfH4bHoWSGh1Jc4g+uLMtHxm6VKCPJt4D13FA4u/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32rEW8S/ZTFSmpZo/D3crPol0Qwjd7NgXfn9Es1RA2ogQ7RjA
	cnojyt1m4C6Jwky58p0fMCeXqN/7ZhtMaVOvk7vLCWbU9I6mcL4EnWUx
X-Gm-Gg: Acq92OFNhwlT9whvYatEp461eHnLCvMqf9rZw6vnGJO8KzSiCDolzJkxoryyPHrwzUD
	IeGsOBht0BZEQpsrnD4GvhGHuhXt+s4luh1WAJPhCqrej0XRZibQnC52aroS7PAcgxfN+1+0IM/
	5GItuKE71iSn6hXoT4lcG4///LmkzGFlNmJLMxpPs4YSX70kyXvB+4dvm4Qawkcgu/4IfvpYmfH
	vKlY2j1bfdtUu3w6Pbeg6m7/sfiyOivoOAgbQgafIIHJtF9fZozIDt3UXv3KA+8El7D4AOWkP6n
	upagSu7DU9+/GuS1Rz9UWShqIG+TnfzpHzVQlw9/48kntFIn0bMklCLjvEv+ENdQji3ojdlZ8/l
	gXAu7cQAhuAZ9P5uW7Quu1SuYLMadV5GdDPj2OknLfDSuzOl8K9lmi26PUGpmXY+Kv1o6gOMnkI
	jY2rUzGLwZ5qa9Wp3zQWN3exC61PFFx3fpB5Rd6/FOascKw3Mfc1uOmqpsJSMHKRz7Ptcz3eXVx
	CPgQ8LOWJYrhtHK2SjD
X-Received: by 2002:a05:600c:4510:b0:48f:d5a0:284e with SMTP id 5b1f17b1804b1-490428e03b8mr163927125e9.28.1779619495411;
        Sun, 24 May 2026 03:44:55 -0700 (PDT)
Received: from [127.0.1.1] (2a01cb0c131d7300e352009073da06b6.ipv6.abo.wanadoo.fr. [2a01:cb0c:131d:7300:e352:90:73da:6b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm258967105e9.7.2026.05.24.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 03:44:55 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Sun, 24 May 2026 12:44:25 +0200
Subject: [PATCH net-next v7 2/3] net: ethtool: add KSZ87xx low-loss cable
 PHY tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ksz87xx_errata_low_loss_connections-v7-2-1cd49cfa24f0@exotec.com>
References: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
In-Reply-To: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779619492; l=2581;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=weMwyhsBK/y7RsspN0KWN1ceSl6cDFrR3kYlEQ7OtRU=;
 b=WDmQMt2K0Srh5o0np0OvB2YWL9e4ZVEmmhlhs5WWXPu3WA/fLSCshvH75sA8sFH9sSnU+RFRy
 RkofLLQU5euC1tHErbSALRS59fnwS2BwzV5QDExwZjLeXHNpuvuiIGK
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291162-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 481AC5C2170
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


