Return-Path: <netdev+bounces-79873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF187BD18
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 13:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245E428166A
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853A05789B;
	Thu, 14 Mar 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="GX6Rk+sN"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB305266A7
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421049; cv=none; b=FiHy4NFoAZTiQKaWILpnVqAESJVtwMfHOwGGGjjZwg5OqLirqhABE4EZYcybgKLBGuoBgS3NxAHm+ePxT/8ttSuILPB+uVd6f9cq9ZPKs+OJW6YdXoqMsZ3Mctquk/ynuG8wtA4hgzJ6Zb/gNprNliMuOCz3bv4awd6CorAuEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421049; c=relaxed/simple;
	bh=6GfFJjlfDTajxioHQ4PR/rr6PYCiHEtUONdjE5qqDnU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=fYABa7yn89ZLGeDkR1OAGHNHNvn/VKUIKKTwsAZhZCsBXV9+e4/+BWl4+y5C53UuO784xdYFmhF/EW9/LpGpHsFWnGErLs9PgyMa8gSC8USe/tgRncTbzBgsRf43ib3qxL85ZhYJQSVHMVe4erx5S7dCWmwSgOFgiMV2BDlt5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=GX6Rk+sN; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 609C41C0006;
	Thu, 14 Mar 2024 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710421045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BKTABrW66JyvVQYwdyjL7ZY8/qBVfLI8e6pxuRKLM40=;
	b=GX6Rk+sNj1KaydUjPY+XQKpmDMMrt0LrLXF5C3zrQvUfGhi860kgrOxcXnRdOXE1yHbd6w
	gxC4F3rEdG7Qx19xJ1KrezIyua9V0b7JzBfS8DaNJTRepURLYFj+dnfSpOU6H1mLjmq0+M
	1Hug/AGYx/zYKkuC12SkS/6a7vr7qh4rESibQX8gLaQgY2aU+nYKZoInoXrQGqv0wTubrV
	FpO5UmN3n0TbbwpRkefC58ehVFjVIpTI3bQTvP/fHO7hFQIeFK1A3EOBw336PZCoRBtXGC
	/U8rEksglR8+TBi1fHyflTjIN/OoZG3JDZ1Tx99gP8IdTUMESvXmdGDmqwQg5g==
Message-ID: <5f1f8827-730e-4f36-bc0a-fec6f5558e93@arinc9.com>
Date: Thu, 14 Mar 2024 15:57:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Frank Wunderlich <frank-w@public-files.de>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Energy Efficient Ethernet on MT7531 switch
Cc: Daniel Golle <daniel@makrotopia.org>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

Hi Frank.

Do you have a board with an external PHY that supports EEE connected to an
MT7531 switch? I've stumbled across an option on the trap register of
MT7531 that claims that EEE is disabled switch-wide by default after reset.

I'm specifically asking for an external PHY because the MT7531 switch PHYs
don't support EEE yet. But the MT753X DSA subdriver claims to support EEE,
so the remaining option is external PHYs.

It'd be great if you can test with and without this diff [1] and see if you
see EEE supported on ethtool on a computer connected to the external PHY.

Example output on the computer side:

$ sudo ethtool --show-eee eno1
EEE settings for eno1:
	EEE status: enabled - active
	Tx LPI: 17 (us)
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  100baseT/Full
	                            1000baseT/Full
	Link partner advertised EEE link modes:  100baseT/Full
	                                         1000baseT/Full

I'm also CC'ing Daniel and the netdev mailing list, if someone else would
like to chime in.

[1]
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index b347d8ab2541..4ef3948d310d 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2499,6 +2499,8 @@ mt7531_setup(struct dsa_switch *ds)
  	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
  				 CORE_PLL_GROUP4, val);
  
+	mt7530_rmw(priv, MT7530_MHWTRAP, CHG_STRAP | EEE_DIS, CHG_STRAP);
+
  	mt7531_setup_common(ds);
  
  	/* Setup VLAN ID 0 for VLAN-unaware bridges */
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 3c3e7ae0e09b..1b3e81f6c90e 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -299,11 +299,15 @@ enum mt7530_vlan_port_acc_frm {
  #define  MT7531_FORCE_DPX		BIT(29)
  #define  MT7531_FORCE_RX_FC		BIT(28)
  #define  MT7531_FORCE_TX_FC		BIT(27)
+#define  MT7531_FORCE_EEE100		BIT(26)
+#define  MT7531_FORCE_EEE1G		BIT(25)
  #define  MT7531_FORCE_MODE		(MT7531_FORCE_LNK | \
  					 MT7531_FORCE_SPD | \
  					 MT7531_FORCE_DPX | \
  					 MT7531_FORCE_RX_FC | \
-					 MT7531_FORCE_TX_FC)
+					 MT7531_FORCE_TX_FC | \
+					 MT7531_FORCE_EEE100 | \
+					 MT7531_FORCE_EEE1G)
  #define  PMCR_LINK_SETTINGS_MASK	(PMCR_TX_EN | PMCR_FORCE_SPEED_1000 | \
  					 PMCR_RX_EN | PMCR_FORCE_SPEED_100 | \
  					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \
@@ -457,6 +461,7 @@ enum mt7531_clk_skew {
  #define  XTAL_FSEL_M			BIT(7)
  #define  PHY_EN				BIT(6)
  #define  CHG_STRAP			BIT(8)
+#define  EEE_DIS			BIT(4)
  
  /* Register for hw trap modification */
  #define MT7530_MHWTRAP			0x7804

Thanks a lot!
Arınç

