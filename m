Return-Path: <netdev+bounces-80253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E6087DD2F
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 13:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5967B20CF7
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25614265;
	Sun, 17 Mar 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="LZt8VtsX"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DB179AE
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710679179; cv=none; b=TZf0zsCe0oEUYvtnt0Wf/ur8VDjuqFHKfTLwlwhmMnn7aWz4wMrOis7tn5zuIngODZimpsYaZ9XwV0CCIfTNWEM4AULn5ayOzuRhzP4XvyM9+VXsKZ8JfeHlWOuQoKhGfXOyttWqaw7MfGryB13RR/JAlRCElAHyefk1d1FQs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710679179; c=relaxed/simple;
	bh=NY866DNRqLd1NXmhYXnVpe8bm8IS/obcHoOGPR8fpqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snH+EcMEouW4JyBpIU/yTs/QpKp+grcz+kzzhS+9nfTO9jilIbVZkBbi6X3oiA2G9GCq+PL5CASpHauSBr+ELyHYQiIUSYbk6DMlfrf1mnmhBbc3cNJId6ZMrtTkINWeeITT/zFCfdEf91Dx+TwIaVw9T1rmQ3wkl4+8uz6jJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=LZt8VtsX; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: from relay4-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::224])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 8DD85C23DB
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 12:38:35 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED337E0004;
	Sun, 17 Mar 2024 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710679108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coKb1O4CdU84t5slvyqR/mbjebiarZSRbiUUESghYxw=;
	b=LZt8VtsXm2E1Hi21fymDC7Izi5o521gcWogpOdM/FlsbyZQZscCS+xefE1EFH218qXiOqd
	Uo3lhPpfaMdGN6EdMhrfLEd4RUq8UiH/EZH056z+JN44e0RRcEax8ZbeScl62q81y4E5y2
	RffmYxDAk+NKG1y+bSioq3MKmIQcUHHltrptDQrE7ZdKZbUeLOBo+ym5LeAA2MqBNnRr3X
	+8LlvZXXrOKLRBl04TYjBV3NUnuKlWZ8wDJQKLmzck94+OuuHSVSEPwMkTdw5ADie7Uue5
	rd6nWK0TwdEJuEjtm8GjLtiKWQRSDvK6cqnOSjxTwdJpf1E0nzquy15iI/d6Fg==
Message-ID: <2ef6fb53-eee6-4c19-bb58-284ba8aa34f9@arinc9.com>
Date: Sun, 17 Mar 2024 15:38:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Energy Efficient Ethernet on MT7531 switch
To: Daniel Golle <daniel@makrotopia.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 netdev <netdev@vger.kernel.org>
References: <5f1f8827-730e-4f36-bc0a-fec6f5558e93@arinc9.com>
 <ZfMQkL2iizhG96Wh@makrotopia.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZfMQkL2iizhG96Wh@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 14.03.2024 17:58, Daniel Golle wrote:
> Hi,
> 
> On Thu, Mar 14, 2024 at 03:57:09PM +0300, Arınç ÜNAL wrote:
>> Hi Frank.
>>
>> Do you have a board with an external PHY that supports EEE connected to an
>> MT7531 switch?
> 
> Good to hear you are working on supporting EEE -- something which has
> been neglected for too long imho.
> 
> I got a bunch of such boards, all of them with different generations
> of RealTek RTL8226 or RTL8221 2.5G PHY which in theory supports EEE
> but the PHY driver in Linux at this point does not support EEE.
> 
> However, as one of the SFP cages of the BPi-R3 is connected to the on-board
> MT7531 switch port 5 this would provide the option to basically test EEE
> with practically every PHY you could find inside an RJ-45 SFP module
> (spoiler: you will mostly find Marvell 88E1111, and I don't see support for
> EEE in neither the datasheet nor the responsible sub-driver in Linux).
> 
> So looks like we will have to implement support for EEE for either
> RealTek's RTL8221B or the built-in PHYs of any of the MT753x, MT7621
> or MT7988 switch first.

I've got news. I believe I've made EEE work with MT7531 switch PHYs and
MACs.

I stated that EEE wasn't supported yet on MT7531 (and MT7530) switch PHYs
because EEE advertisement on switch PHYs is disabled on mediatek-ge [1].

In reality, the EEE advertisement disablement goes away once the DSA
subdriver starts controlling the switch and its PHYs. This goes for MT7530
too.

So I don't see any reason for that code on mediatek-ge to exist, I'd like
to remove it. I think there's a possible race condition with mediatek-ge
kicking in after the DSA subdriver so I'd like to submit the removal of
disabling EEE advertisement on mediatek-ge to the net tree. What do you
think Daniel?

EEE on MT7530 works without any changes to the current linux-next tree.
There's another step needed to enable EEE on MT7531 switch MACs. With this
diff [2], EEE is now enabled on the MAC side. So EEE starts working.
Testing EEE on MT7988 SoC PHYs is up to you, I don't have the hardware.

Without the diff:

# ethtool --show-eee lan0
EEE settings for lan0:
	EEE status: not supported

With the diff:

# ethtool --show-eee lan0
EEE settings for lan0:
	EEE status: enabled - active
	Tx LPI: 30 (us)
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  100baseT/Full
	                            1000baseT/Full
	Link partner advertised EEE link modes:  100baseT/Full
	                                         1000baseT/Full

To confirm that the EEE advertisement disablement goes away once the DSA
subdriver starts controlling the switch and its PHYs, I've written this
debugfs code [3] to run code from userspace on demand. Testing disabling
EEE on the PHY, disable_eee1 pertains to lan0:

# mount -t debugfs none /sys/kernel/debug
# echo go > /sys/kernel/debug/mt7530/disable_eee1
# ethtool --show-eee lan0
EEE settings for lan0:
	EEE status: disabled
	Tx LPI: 30 (us)
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  Not reported
	Link partner advertised EEE link modes:  100baseT/Full
	                                         1000baseT/Full
# ethtool --set-eee lan0 eee on
[ 1781.317488] mt7530-mdio mdio-bus:1f lan0: Link is Down
[ 1787.308087] mt7530-mdio mdio-bus:1f lan0: Link is Up - 1Gbps/Full - flow control rx/tx
# ethtool --show-eee lan0
EEE settings for lan0:
	EEE status: enabled - active
	Tx LPI: 30 (us)
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  100baseT/Full
	                            1000baseT/Full
	Link partner advertised EEE link modes:  100baseT/Full
	                                         1000baseT/Full

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/phy/mediatek-ge.c?id=98c485eaf509bc0e2a85f9b58d17cd501f274c4e#n26
[2]
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index e2a8ea337ab0..dfa5e610a6ee 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2554,6 +2554,13 @@ mt7531_setup(struct dsa_switch *ds)
  	/* Reset the switch through internal reset */
  	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_SW_RST | SYS_CTRL_REG_RST);
  
+	/* Allow modifying the trap and enable Energy-Efficient Ethernet (EEE).
+	 */
+	val = mt7530_read(priv, MT7531_HWTRAP);
+	val |= CHG_STRAP;
+	val &= ~EEE_DIS;
+	mt7530_write(priv, MT7530_MHWTRAP, val);
+
  	if (!priv->p5_sgmii) {
  		mt7531_pll_setup(priv);
  	} else {
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index a71166e0a7fc..509ed5362236 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -457,6 +457,7 @@ enum mt7531_clk_skew {
  #define  XTAL_FSEL_M			BIT(7)
  #define  PHY_EN				BIT(6)
  #define  CHG_STRAP			BIT(8)
+#define  EEE_DIS			BIT(4)
  
  /* Register for hw trap modification */
  #define MT7530_MHWTRAP			0x7804

[3]
diff --git a/drivers/net/phy/mediatek-ge.c b/drivers/net/phy/mediatek-ge.c
index a493ae01b267..e8822adbf3bc 100644
--- a/drivers/net/phy/mediatek-ge.c
+++ b/drivers/net/phy/mediatek-ge.c
@@ -1,5 +1,6 @@
  // SPDX-License-Identifier: GPL-2.0+
  #include <linux/bitfield.h>
+#include <linux/debugfs.h>
  #include <linux/module.h>
  #include <linux/phy.h>
  
@@ -11,6 +12,53 @@
  #define MTK_PHY_PAGE_EXTENDED_2A30	0x2a30
  #define MTK_PHY_PAGE_EXTENDED_52B5	0x52b5
  
+static int phy_number = 0;
+
+static ssize_t disable_eee_write(struct file *filp, const char __user *buffer,
+				 size_t count, loff_t *ppos)
+{
+	struct phy_device *phydev = filp->private_data;
+
+	phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
+
+	return count;
+}
+
+static const struct file_operations disable_eee_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = disable_eee_write,
+};
+
+static void mtk_gephy_debugfs_init(struct phy_device *phydev)
+{
+	struct dentry *dir;
+
+	dir = debugfs_lookup("mt7530", 0);
+	if (dir == NULL)
+		dir = debugfs_create_dir("mt7530", 0);
+
+	if (phy_number == 0) {
+		debugfs_create_file("disable_eee0", 0644, dir, phydev,
+				    &disable_eee_fops);
+	} else if (phy_number == 1) {
+		debugfs_create_file("disable_eee1", 0644, dir, phydev,
+				    &disable_eee_fops);
+	} else if (phy_number == 2) {
+		debugfs_create_file("disable_eee2", 0644, dir, phydev,
+				    &disable_eee_fops);
+	} else if (phy_number == 3) {
+		debugfs_create_file("disable_eee3", 0644, dir, phydev,
+				    &disable_eee_fops);
+	} else if (phy_number == 4) {
+		debugfs_create_file("disable_eee4", 0644, dir, phydev,
+				    &disable_eee_fops);
+	}
+
+	if (phy_number < 4)
+		phy_number++;
+}
+
  static int mtk_gephy_read_page(struct phy_device *phydev)
  {
  	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
@@ -41,6 +89,8 @@ static void mtk_gephy_config_init(struct phy_device *phydev)
  
  	/* Disable mcc */
  	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xa6, 0x300);
+
+	mtk_gephy_debugfs_init(phydev);
  }
  
  static int mt7530_phy_config_init(struct phy_device *phydev)

Arınç

