Return-Path: <netdev+bounces-290861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KFgOF5uEGqgXAYAu9opvQ
	(envelope-from <netdev+bounces-290861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:55:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC915B68A7
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F477316DCB9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16B44CAF5;
	Fri, 22 May 2026 14:35:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b03.edpnet.be (relay-b03.edpnet.be [212.71.1.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE1441037
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460520; cv=none; b=FfKbt1zsWN3nJjBUXSqSqSQMuDbYYsmNsE56YDTtXiEWKIDbH3sRKKvPdDb4/xSmSudyND+AaBTOU6LhnNaqT1bJNtFS8d6ZdFdnnj1FJu2MPxlY3y7YEb9M26wCMmF7FRbpAqIgE/PXtihWppK7w3DBtKq8k1TS9NMqplERK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460520; c=relaxed/simple;
	bh=CDu+70iWbw48hxp9LcSdeNQ5qsKZurF8XzoAo82CLAE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cuEqiAr9UQeuqoLzaHdQ4J5iHpJHUJBWONJZgqL2wFmsvuZcCh3Sv+twL6h2/D5muxK5qXeXga6ZiDNj4QHD9+hI+8GN0qk7dWa6xqnMxzbO6du5brHMqnWd7F4ZWexcrcguuMRIwt8ZTJP68Z1on+n9tizvIWQ44n/W2xmsAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
Received: from [192.168.177.118] (212.71.13.3.static.edpnet.net [212.71.13.3]) by relay-b03.edpnet.be with ESMTP id 58h3AOPbTDaUI1XM; Fri, 22 May 2026 16:19:12 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 212.71.13.3.static.edpnet.net[212.71.13.3]
X-Barracuda-Apparent-Source-IP: 212.71.13.3
Message-ID: <17103132-5732-468a-a320-771f419d432a@kabelmail.de>
Date: Fri, 22 May 2026 16:18:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: nl
To: wagner.daniel.t@gmail.com
Cc: netdev@vger.kernel.org
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Subject: Request for support: bring up a BCM84891 phy
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
X-ASG-Orig-Subj: Request for support: bring up a BCM84891 phy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: 212.71.13.3.static.edpnet.net[212.71.13.3]
X-Barracuda-Start-Time: 1779459552
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 16830
X-Barracuda-BRTS-Status: 1
X-ASG-Debug-ID: 1779459552-24639c1f923823b0001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	
X-Spamd-Result: default: False [0.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[kabelmail.de : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-290861-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[janpieter.sollie@kabelmail.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3DC915B68A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Daniel,

I'm trying to bring up my new 10GTek ASF-10G-T80 modules,
Which should (according to manufacturer info) contain a BCM84891 chip.
Support for those was added in linux 7.1 thanks to commit 75171eeff3538c6859b50f6a516342c8f1ed6e00.
As I'm running openwrt on my BPI-R4 device (mtk7988 SOC), I cherry-picked the patches.

I wrote a quick-and-dirty hack to investigate how the module responds to MDIO commands.
The patch below is ugly. not a real useful thing.
I tried this patch with every sfp->mdio_protocol to check what would happen, the results are below.
Please note that I also changed the rollball password in mdio-i2c.c, simply to see "what happens?"
this Rollball password was extracted using the i2csfp tool.

As the C22 protocol looked promising (it shows an ID), I started further investigation.
I added this ID to the supported devices of the bcm84881 driver.
Unfortunately, I can't get it to work.  I'm showing the dynamic debug output here.
Why doesn't the phy connect to the driver?

Below, you'll see:
1) the output of the "as far as I got" situation
2) ugly hack to investigate whether I could get it working
3) Initial research using different mdio communication protocols
4) i2cdetect / dump of most relevant pages

Any suggestion would be welcome

Thank you for your support,

Janpieter Sollie

1) most recent dynamic debug output using patched bcm84881 driver:
# ip link set sfp-wan up
[  827.379458] mtk_soc_eth 15100000.ethernet sfp-wan: configuring for inband/usxgmii link mode
[  827.387848] mtk_soc_eth 15100000.ethernet sfp-wan: major config, requested inband/usxgmii
[  827.396026] mtk_soc_eth 15100000.ethernet sfp-wan: interface usxgmii inband modes: pcs=02 phy=00
[  827.404831] mtk_soc_eth 15100000.ethernet sfp-wan: major config, active 
inband/inband,an-enabled/usxgmii
[  827.414306] mtk_soc_eth 15100000.ethernet sfp-wan: phylink_mac_config: 
mode=inband/usxgmii/none adv=0000078,1c000018,0001fe00,001ef27f pause=04
[  827.440187] sfp sfp1: SM: enter present:down:down event dev_up
[  827.446034] sfp sfp1: tx disable 1 -> 0
[  827.449897] sfp sfp1: SM: exit present:up:wait
[  832.505789] sfp sfp1: SM: enter present:up:wait event timeout
[  832.511782] mdio_bus i2c:sfp1: probed
[  832.515459] i2c-core: using bounce buffer for addr=0x70, len=1
[  832.521552] i2c-core: using bounce buffer for addr=0x56, len=1
[  832.527388] i2c-core: using bounce buffer for addr=0x56, len=2
[  832.533757] i2c-core: using bounce buffer for addr=0x56, len=1
[  832.539589] i2c-core: using bounce buffer for addr=0x56, len=2
[  832.586813] mtk_soc_eth 15100000.ethernet sfp-wan: validation with support 
0000000,00000000,00000000,00000000 failed: -EINVAL
[  832.598208] sfp sfp1: sfp_add_phy failed: -EINVAL
[  832.602905] sfp sfp1: SM: exit present:up:fail
[  833.640353] sfp sfp1: los 1 -> 0
[  833.643591] sfp sfp1: SM: enter present:up:fail event los_low
[  833.649343] sfp sfp1: SM: exit present:up:fail

ls /sys/class/mdio_bus/i2c:sfp1/statistics/
errors  ... errors_31
reads ... reads_31
transfers ... transfers_31
writes ... writes_31

2) hack applied on top of 6.18 kernel + BCM84891 patches:
--- a/drivers/net/phy/bcm84881.c        2026-05-20 13:04:56.955751500 +0200
+++ b/drivers/net/phy/bcm84881.c        2026-05-20 13:14:46.045711979 +0200
@@ -455,6 +455,19 @@
                 .led_brightness_set = bcm8489x_led_brightness_set,
                 .led_hw_is_supported = bcm8489x_led_hw_is_supported,
                 .led_hw_control_set = bcm8489x_led_hw_control_set,
+       }, {
+               PHY_ID_MATCH_MODEL(0x00828235),
+               .name           = "Broadcom BCM84892 (OEM)",
+               .inband_caps    = bcm84881_inband_caps,
+               .config_init    = bcm8489x_config_init,
+               .probe          = bcm84881_probe,
+               .get_features   = bcm84881_get_features,
+               .config_aneg    = bcm84881_config_aneg,
+               .aneg_done      = bcm84881_aneg_done,
+               .read_status    = bcm84881_read_status,
+               .led_brightness_set = bcm8489x_led_brightness_set,
+               .led_hw_is_supported = bcm8489x_led_hw_is_supported,
+               .led_hw_control_set = bcm8489x_led_hw_control_set,
                 .led_hw_control_get = bcm8489x_led_hw_control_get,
         },
  };
@@ -466,6 +479,7 @@
         { 0xae025150, 0xfffffff0 },
         { PHY_ID_MATCH_MODEL(0x35905080) },
         { PHY_ID_MATCH_MODEL(0x359050a0) },
+       { PHY_ID_MATCH_MODEL(0x00828235) },
         { },
  };
  MODULE_AUTHOR("Russell King");
--- a/drivers/net/phy/sfp.c     2026-05-20 13:19:16.510637208 +0200
+++ b/drivers/net/phy/sfp.c     2026-05-20 13:26:56.405071724 +0200
@@ -494,6 +494,18 @@
         __set_bit(PHY_INTERFACE_MODE_1000BASEX, caps->interfaces);
  }

+static void sfp_fixup_asf_10g_t80(struct sfp *sfp)
+{
+       /* 1. Force MDIO-over-I2C protocol to investigate BCM84891 */
+       sfp->mdio_protocol = MDIO_I2C_C45;
+
+       /* 2. provide Broadcom PHY more than enough time to boot.
+               should prevent unneeded i2c scans due to buggy firmware. */
+       sfp->module_t_wait = msecs_to_jiffies(5000);
+       sfp->phy_t_retry = msecs_to_jiffies(1000);
+       sfp_fixup_10gbaset_30m(sfp);
+}
+
  #define SFP_QUIRK(_v, _p, _s, _f) \
         { .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
  #define SFP_QUIRK_S(_v, _p, _s) SFP_QUIRK(_v, _p, _s, NULL)
@@ -579,7 +591,7 @@
         // OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
         SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),

-       SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
+       SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_asf_10g_t80),
         SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
         SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
         SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
--- a/drivers/net/mdio/mdio-i2c.c       2026-05-21 14:01:06.447552712 +0200
+++ b/drivers/net/mdio/mdio-i2c.c       2026-05-21 14:09:43.128065460 +0200
@@ -429,10 +429,10 @@
         int ret;

         pw[0] = ROLLBALL_PASSWORD;
-       pw[1] = 0xff;
-       pw[2] = 0xff;
-       pw[3] = 0xff;
-       pw[4] = 0xff;
+       pw[1] = 0x63;
+       pw[2] = 0x73;
+       pw[3] = 0x77;
+       pw[4] = 0x77;

         msg.addr = ROLLBALL_PHY_I2C_ADDR;
         msg.flags = 0;

3)  Initial output with different values:
MDIO_I2C_NONE:
[61377.299004] mtk_soc_eth 15100000.ethernet sfp-wan: configuring for inband/usxgmii link mode
[61377.307395] mtk_soc_eth 15100000.ethernet sfp-wan: major config, requested inband/usxgmii
[61377.315576] mtk_soc_eth 15100000.ethernet sfp-wan: interface usxgmii inband modes: pcs=02 phy=00
[61377.324363] mtk_soc_eth 15100000.ethernet sfp-wan: major config, active 
inband/inband,an-enabled/usxgmii
[61377.333835] mtk_soc_eth 15100000.ethernet sfp-wan: phylink_mac_config: 
mode=inband/usxgmii/none adv=0000078,1c000018,0001fe00,001ef27f pause=04
[61382.360177] mtk_soc_eth 15100000.ethernet sfp-wan: optical SFP: 
interfaces=[mac=2-4,22-24,27,29, sfp=27]
[61382.369675] mtk_soc_eth 15100000.ethernet sfp-wan:  interface 27 (10gbase-r) rate match none 
supports 6-7,12-14,43
[61382.380025] mtk_soc_eth 15100000.ethernet sfp-wan: optical SFP: chosen 10gbase-r interface
[61382.388284] mtk_soc_eth 15100000.ethernet sfp-wan: requesting link mode inband/10gbase-r with 
support 0000000,00000000,00000800,00007080
[61382.400535] mtk_soc_eth 15100000.ethernet sfp-wan: switched to inband/10gbase-r link mode
[61382.408699] mtk_soc_eth 15100000.ethernet sfp-wan: major config, requested inband/10gbase-r
[61382.417041] mtk_soc_eth 15100000.ethernet sfp-wan: major config, active inband/none/10gbase-r
[61382.425558] mtk_soc_eth 15100000.ethernet sfp-wan: phylink_mac_config: 
mode=inband/10gbase-r/none adv=0000000,00000000,00000000,00000000 pause=00
[61385.006073] mtk_soc_eth 15100000.ethernet sfp-wan: Link is Up - 10Gbps/Full - flow control off

MDIO_I2C_MARVELL_C22:
[60861.611859] mtk_soc_eth 15100000.ethernet sfp-wan: configuring for inband/usxgmii link mode
[60861.620220] mtk_soc_eth 15100000.ethernet sfp-wan: major config, requested inband/usxgmii
[60861.628404] mtk_soc_eth 15100000.ethernet sfp-wan: interface usxgmii inband modes: pcs=02 phy=00
[60861.637185] mtk_soc_eth 15100000.ethernet sfp-wan: major config, active 
inband/inband,an-enabled/usxgmii
[60861.646661] mtk_soc_eth 15100000.ethernet sfp-wan: phylink_mac_config: 
mode=inband/usxgmii/none adv=0000078,1c000018,0001fe00,001ef27f pause=04
[60866.681310] mdio_bus i2c:sfp1: probed
[60866.727138] mtk_soc_eth 15100000.ethernet sfp-wan: PHY i2c:sfp1:16 (id 0x00828235) has no 
driver loaded
[60866.736557] mtk_soc_eth 15100000.ethernet sfp-wan: Drivers which handle known common cases: 
CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY
[60866.748445] sfp sfp1: sfp_add_phy failed: -EINVAL

MDIO_I2C_C45:
[61747.344015] mtk_soc_eth 15100000.ethernet sfp-wan: configuring for inband/10gbase-r link mode
[61747.352577] mtk_soc_eth 15100000.ethernet sfp-wan: major config, requested inband/10gbase-r
[61747.360928] mtk_soc_eth 15100000.ethernet sfp-wan: major config, active inband/none/10gbase-r
[61747.369495] mtk_soc_eth 15100000.ethernet sfp-wan: phylink_mac_config: 
mode=inband/10gbase-r/none adv=0000000,00000000,00000000,00000000 pause=00
[61752.439737] mdio_bus i2c:sfp1: probed
[61779.364636] sfp sfp1: no PHY detected
[61779.368312] mtk_soc_eth 15100000.ethernet sfp-wan: optical SFP: 
interfaces=[mac=2-4,22-24,27,29, sfp=27]
[61779.377800] mtk_soc_eth 15100000.ethernet sfp-wan:  interface 27 (10gbase-r) rate match none 
supports 6-7,12-14,43
[61779.388142] mtk_soc_eth 15100000.ethernet sfp-wan: optical SFP: chosen 10gbase-r interface
[61779.396399] mtk_soc_eth 15100000.ethernet sfp-wan: requesting link mode inband/10gbase-r with 
support 0000000,00000000,00000800,00007080
[61779.444416] mtk_soc_eth 15100000.ethernet sfp-wan: Link is Up - 10Gbps/Full - flow control off
[61779.444453] br-lan: port 5(sfp-wan) entered blocking state
[61779.458506] br-lan: port 5(sfp-wan) entered forwarding state

MDIO_I2C_ROLLBALL with default password in mdio-i2c:
[61998.770990] mtk_soc_eth 15100000.ethernet sfp-wan: configuring for inband/10gbase-r link mode
[61998.779569] mtk_soc_eth 15100000.ethernet sfp-wan: major config, requested inband/10gbase-r
[61998.787910] mtk_soc_eth 15100000.ethernet sfp-wan: major config, active inband/none/10gbase-r
[61998.796435] mtk_soc_eth 15100000.ethernet sfp-wan: phylink_mac_config: 
mode=inband/10gbase-r/none adv=0000000,00000000,00000000,00000000 pause=00
[62003.880143] mdio_bus i2c:sfp1: probed
[62009.113809] mtk_soc_eth 15100000.ethernet sfp-wan: PHY i2c:sfp1:11 (id 0x00000000) has no 
driver loaded
[62009.123230] mtk_soc_eth 15100000.ethernet sfp-wan: Drivers which handle known common cases: 
CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY
[62009.135219] sfp sfp1: sfp_add_phy failed: -EINVAL

MDIO_I2C_ROLLBALL with adjusted password in mdio-i2c:
[62171.845158] mtk_soc_eth 15100000.ethernet sfp-wan: configuring for inband/10gbase-r link mode
[62171.853720] mtk_soc_eth 15100000.ethernet sfp-wan: major config, requested inband/10gbase-r
[62171.862072] mtk_soc_eth 15100000.ethernet sfp-wan: major config, active inband/none/10gbase-r
[62171.870593] mtk_soc_eth 15100000.ethernet sfp-wan: phylink_mac_config: 
mode=inband/10gbase-r/none adv=0000000,00000000,00000000,00000000 pause=00
[62176.919842] mdio_bus i2c:sfp1: probed
[62249.380648] sfp sfp1: no PHY detected
[62249.384325] mtk_soc_eth 15100000.ethernet sfp-wan: optical SFP: 
interfaces=[mac=2-4,22-24,27,29, sfp=27]
[62249.393813] mtk_soc_eth 15100000.ethernet sfp-wan:  interface 27 (10gbase-r) rate match none 
supports 6-7,12-14,43
[62249.404157] mtk_soc_eth 15100000.ethernet sfp-wan: optical SFP: chosen 10gbase-r interface
[62249.412413] mtk_soc_eth 15100000.ethernet sfp-wan: requesting link mode inband/10gbase-r with 
support 0000000,00000000,00000800,00007080
[62249.460211] mtk_soc_eth 15100000.ethernet sfp-wan: Link is Up - 10Gbps/Full - flow control off

4) some i2c registers:
i2cdetect:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: 50 51 -- -- -- -- 56 -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: UU -- -- -- -- -- -- --
0x50:
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f 0123456789abcdef
00: 03 04 07 10 00 00 00 00 00 00 00 06 67 00 00 00 ????.......?g...
10: 08 02 00 1e 4f 45 4d 20 20 20 20 20 20 20 20 20    ??.?OEM
20: 20 20 20 20 00 00 90 65 53 46 50 2d 31 30 47 2d ..?eSFP-10G-
30: 54 20 20 20 20 20 20 20 30 32 20 20 03 52 00 3f    T       02 ?R.?
40: 00 1a 00 00 43 53 59 31 30 31 50 41 36 32 35 38 .?..CSY101PA6258
50: 20 20 20 20 32 35 30 39 33 30 20 20 68 80 03 df        250930 h???
60: 00 00 11 22 32 77 53 e1 44 82 4f c6 1f 97 46 75 ..?"2wS?D?O???Fu
70: 60 67 a7 00 00 00 00 00 00 00 00 00 24 fa 98 35 `g?.........$??5
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
0x51:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f 0123456789abcdef
00: 5f 00 7f 03 5a 00 d3 00 8c a0 75 30 88 b8 79 18 _.??Z.?.??u0??y?
10: 1d 4c 01 f4 19 64 03 e8 4d f0 06 30 3d e8 06 f2 ?L???d??M??0=???
20: 2b d4 00 c7 27 10 00 df 00 00 00 00 00 00 00 00 +?.?'?.?........
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
40: 00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00 ....??......?...
50: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 a5 ?...?...?......?
60: 36 d2 82 78 0b b8 13 88 00 00 00 00 00 00 02 00 6??x????......?.
70: 40 40 00 00 00 40 00 00 00 00 00 ff ff ff ff 00 @@...@..........
80: 43 4f 55 49 41 38 4e 43 41 41 31 30 2d 32 34 31 COUIA8NCAA10-241
90: 35 2d 30 33 56 30 33 20 01 00 46 00 00 00 00 c6    5-03V03 ?.F....?
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa 36 ..............?6
c0: 53 46 50 2d 31 30 47 2d 53 52 20 20 20 20 20 20    SFP-10G-SR
d0: 20 20 20 20 32 33 00 00 00 00 00 00 00 00 00 35 23.........5
e0: 15 1a 20 24 2a 30 20 30 00 00 00 00 00 00 00 00    ?? $*0 0........
f0: 00 00 00 00 00 1d 00 00 ff ff ff ff 00 00 00 00 .....?..........
0x56:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f 0123456789abcdef
00: 20 40 00 82 35 90 50 80 60 30 00 9b c0 00 00 09  @.?5?P?`0.??..?
10: 97 01 00 00 00 00 41 a4 41 a4 41 84 00 00 00 00 ??....A?A?A?....
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................


