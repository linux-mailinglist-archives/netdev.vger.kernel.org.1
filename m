Return-Path: <netdev+bounces-282444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEagDzM68mlypAEAu9opvQ
	(envelope-from <netdev+bounces-282444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:04:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B11E6497F44
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89DCE3086653
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EC3413253;
	Wed, 29 Apr 2026 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0Eu+Kh1i";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0lhVgG8h"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61A40FDB7;
	Wed, 29 Apr 2026 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482107; cv=none; b=en5mgvETe3NwJ6qtsoqcUdGfOJNtmhoJOogQ5c62zgA705GLTR+bcU8/nYmtVfBHd3Cv/VRtYyo6mB+jbS6e4Nl4Lok8i9Wl7xBbvHJKZ/ltCob6PRwa/TwwSA3mGjkikTyGQwBBfh1Flq2pU9imxUVlVkxy3+ctRAPj5C2E2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482107; c=relaxed/simple;
	bh=Dd2wYPSGtYN1H3N/e+YnaklDoZEAoKSnAWn49QqglS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/vvYgN/2UXqwuKVRICiWaqkNe2MHZ2Fbk4ZKpvIdugLEAICp8CJBYItgDwvgyWNEdgBSDajCaAkOgJfOHSjT3CHOhohW96G1VtkhbcjQfB1d+vZoBKkTtKJl6xjNhw5+2WC18IpLBNa3fHUsskOXHTPTBw/tqWgULbX6pQMY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0Eu+Kh1i; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0lhVgG8h; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777482103;
	bh=Dd2wYPSGtYN1H3N/e+YnaklDoZEAoKSnAWn49QqglS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0Eu+Kh1ij7mCUGRw9o0D1MHB/BPeqgm7xIEH8b1eOMnGVjuZhtmOcr5lDhKKvUPyd
	 /nMXygfSQhTd5vB67YKPtDJtmzJSfVY6d+OSGXqF3CV7erhCqXtUF+FMrl1t9Gkx2A
	 d+HZ1TkNuEuQ/DfUhUSxsML1lPI1to/sMmBYCwX95LEEc/Wj0bzVBcCn9vftO0Qabi
	 PjmB/s/xXuNprG9cgVdP/gp4QeWY3cRtJ9ISdTG2Hne9/Bv1kRLkqYSbZ9ZkQf7bll
	 aC42dVaSvRyiKlEKSKB+LLyF3eE92EJIcwCXiWPujeh0JoVMa44ni4SWdHSNHme49M
	 E6z+/p3tegsog==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 94EC8481BF; Wed, 29 Apr 2026 17:01:43 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777482099;
	bh=Dd2wYPSGtYN1H3N/e+YnaklDoZEAoKSnAWn49QqglS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0lhVgG8hgxfWqkgUP9i/hJvVgbAcl9Rs+VeRWEO9VmOLQVulFL81F+5L3Em2S9Fli
	 LqyP+hT8RQBiL4LkremahItUC67gdUxZQQnNX+9uf8J2zj9BWJadtZ9DYlJFAb1S69
	 mSx8ShLxj+2qR8p9NZhz4t7xVF0As/HPU/7Yw6BeupPGOMIrAAJ4uOwTL4EGgbAEPO
	 Q6qNAiC5hZAeIslTAXElwh2QSk/3feLBHcvaLzkyLt/N6X3+Qg0iPYNsZ24S1BbKeN
	 yetoirMc7R13m4gZlENAeZ/aDsv0kaT+GEVY06lAAkl23syTiatuBaWe/ZwVhQa1P7
	 s6jw4CClXs3kQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0C9F647E49;
	Wed, 29 Apr 2026 17:01:39 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 29 Apr 2026 19:01:10 +0200
Subject: [PATCH net-next v2 2/4] r8152: Add support for the RTL8159 chip
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-rtl8159_net_next-v2-2-bab3cd4e4c66@birger-koblitz.de>
References: <20260429-rtl8159_net_next-v2-0-bab3cd4e4c66@birger-koblitz.de>
In-Reply-To: <20260429-rtl8159_net_next-v2-0-bab3cd4e4c66@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: B11E6497F44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-282444-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid]

The RTL8157 re-uses the packet descriptor format introduced with the
RTL8157 and other hardware features of the RTL8157 (RTL_VER_16) such
as the SRAM access. The support therefore consists in expanding the
existing RTL8157 code for initialization and USB power management
to also be used for the RTL8159 (RTL_VER_17).

Most of the addiitonal code is added in r8157_hw_phy_cfg() to configure
the RTL8159 PHY.

Add support for the USB device ID of Realtek RTL8157-based adapters. Detect
the RTL8159 as RTL_VER_17 and set it up.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 257 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 249 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 01e65d845f8732f23427305423e4e270dae775dc..2a07dde289e2240b221664ae5c5bceec35b5a1ef 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1247,6 +1247,7 @@ enum rtl_version {
 	RTL_VER_14,
 	RTL_VER_15,
 	RTL_VER_16,
+	RTL_VER_17,
 
 	RTL_VER_MAX
 };
@@ -3432,6 +3433,7 @@ static void rtl8152_nic_reset(struct r8152 *tp)
 		break;
 
 	case RTL_VER_16:
+	case RTL_VER_17:
 		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CR, CR_RE | CR_TE);
 		break;
 
@@ -3471,6 +3473,9 @@ static void rtl_eee_plus_en(struct r8152 *tp, bool enable)
 
 static void rtl_set_eee_plus(struct r8152 *tp)
 {
+	if (tp->version == RTL_VER_17)
+		return rtl_eee_plus_en(tp, false);
+
 	if (rtl8152_get_speed(tp) & _10bps)
 		rtl_eee_plus_en(tp, true);
 	else
@@ -3656,6 +3661,7 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
+	case RTL_VER_17:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_TIMEOUT,
 			       640 / 8);
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
@@ -3700,6 +3706,7 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 			       ocp_data / 8);
 		break;
 	case RTL_VER_16:
+	case RTL_VER_17:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 16);
 		break;
@@ -4548,6 +4555,7 @@ static void rtl_clear_bp(struct r8152 *tp, u16 type)
 		break;
 	case RTL_VER_14:
 	case RTL_VER_16:
+	case RTL_VER_17:
 	default:
 		ocp_write_word(tp, type, USB_BP2_EN, 0);
 		bp_num = 16;
@@ -5823,6 +5831,7 @@ static void rtl_eee_enable(struct r8152 *tp, bool enable)
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
+	case RTL_VER_17:
 		if (enable) {
 			r8156_eee_en(tp, true);
 			ocp_reg_write(tp, OCP_EEE_ADV, tp->eee_adv);
@@ -6894,7 +6903,7 @@ static void rtl8156_down(struct r8152 *tp)
 			  PLA_MCU_SPDWN_EN);
 
 	r8153b_u1u2en(tp, false);
-	if (tp->version != RTL_VER_16) {
+	if (tp->version < RTL_VER_16) {
 		r8153_u2p3en(tp, false);
 		r8153b_power_cut_en(tp, false);
 	}
@@ -8016,7 +8025,7 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 	/* Advanced Power Saving parameter */
 	ocp_reg_set_bits(tp, 0xa430, BIT(0) | BIT(1));
 
-	/* aldpsce force mode */
+	/* Disable ALDPS force mode */
 	ocp_reg_clr_bits(tp, 0xa44a, BIT(2));
 
 	switch (tp->version) {
@@ -8140,6 +8149,190 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write_w0w1(tp, 0x807c, 0xff00, 0x5000);
 		sram2_write_w0w1(tp, 0x809d, 0xff00, 0x5000);
 		break;
+
+	case RTL_VER_17:
+		/* Disable bypass turn off clk in ALDPS */
+		 ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
+
+		/* Power level tuning
+		 * test mode power level
+		 */
+		sram_write_w0w1(tp, 0x8415, 0xff00, 0x9300);
+		/* normal link power level 10G, 5G, 2.5G */
+		sram_write_w0w1(tp, 0x81a3, 0xff00, 0x0f00);
+		sram_write_w0w1(tp, 0x81ae, 0xff00, 0x0f00);
+		sram_write_w0w1(tp, 0x81b9, 0xff00, 0xb900);
+		/* nomal link TX filter */
+		sram2_write_w0w1(tp, 0x83b0, 0x0e00, 0);
+		sram2_write_w0w1(tp, 0x83c5, 0x0e00, 0);
+		sram2_write_w0w1(tp, 0x83da, 0x0e00, 0);
+		sram2_write_w0w1(tp, 0x83ef, 0x0e00, 0);
+
+		/* AFE power saving for 2.5G & 5G */
+		sram_write(tp, 0x8173, 0x8620);
+		sram_write(tp, 0x8175, 0x8671);
+
+		sram_write_w0w1(tp, 0x817c, 0, BIT(13));
+		sram_write_w0w1(tp, 0x8187, 0, BIT(13));
+		sram_write_w0w1(tp, 0x8192, 0, BIT(13));
+		sram_write_w0w1(tp, 0x819d, 0, BIT(13));
+		sram_write_w0w1(tp, 0x81a8, BIT(13), 0);
+		sram_write_w0w1(tp, 0x81b3, BIT(13), 0);
+		sram_write_w0w1(tp, 0x81be, 0, BIT(13));
+
+		sram_write_w0w1(tp, 0x817d, 0xff00, 0xa600);
+		sram_write_w0w1(tp, 0x8188, 0xff00, 0xa600);
+		sram_write_w0w1(tp, 0x8193, 0xff00, 0xa600);
+		sram_write_w0w1(tp, 0x819e, 0xff00, 0xa600);
+		sram_write_w0w1(tp, 0x81a9, 0xff00, 0x1400);
+		sram_write_w0w1(tp, 0x81b4, 0xff00, 0x1400);
+		sram_write_w0w1(tp, 0x81bf, 0xff00, 0xa600);
+
+		/* RFI parameter
+		 * disable preset FBE
+		 */
+		ocp_reg_clr_bits(tp, 0xaeaa, BIT(5) | BIT(3));
+		/* modify PGA for 5G&10G */
+		sram2_write(tp, 0x84f0, 0x201c);
+		sram2_write(tp, 0x84f2, 0x3117);
+		/* RFI parameter */
+		ocp_reg_write(tp, 0xaec6, 0x0000);
+		ocp_reg_write(tp, 0xae20, 0xffff);
+		ocp_reg_write(tp, 0xaece, 0xffff);
+		ocp_reg_write(tp, 0xaed2, 0xffff);
+		ocp_reg_write(tp, 0xaec8, 0x0000);
+		ocp_reg_clr_bits(tp, 0xaed0, BIT(0));
+		ocp_reg_write(tp, 0xadb8, 0x0150);
+		sram2_write_w0w1(tp, 0x8197, 0xff00, 0x5000);
+		sram2_write_w0w1(tp, 0x8231, 0xff00, 0x5000);
+		sram2_write_w0w1(tp, 0x82cb, 0xff00, 0x5000);
+		sram2_write_w0w1(tp, 0x82cd, 0xff00, 0x5700);
+		sram2_write_w0w1(tp, 0x8233, 0xff00, 0x5700);
+		sram2_write_w0w1(tp, 0x8199, 0xff00, 0x5700);
+
+		sram2_write(tp, 0x815a, 0x0150);
+		sram2_write(tp, 0x81f4, 0x0150);
+		sram2_write(tp, 0x828e, 0x0150);
+		sram2_write(tp, 0x81b1, 0x0000);
+		sram2_write(tp, 0x824b, 0x0000);
+		sram2_write(tp, 0x82e5, 0x0000);
+
+		sram2_write_w0w1(tp, 0x84f7, 0xff00, 0x2800);
+		ocp_reg_set_bits(tp, 0xaec2, BIT(12));
+		sram2_write_w0w1(tp, 0x81b3, 0xff00, 0xad00);
+		sram2_write_w0w1(tp, 0x824d, 0xff00, 0xad00);
+		sram2_write_w0w1(tp, 0x82e7, 0xff00, 0xad00);
+		ocp_reg_w0w1(tp, 0xae4e, 0x000f, 0x0001);
+		sram2_write_w0w1(tp, 0x82ce, 0xf000, 0x4000);
+
+		/* 5G shift sel, default = '04'
+		 * 10G shift sel, default = '03'
+		 */
+		sram2_write_w0w1(tp, 0x83a5, 0xff00, 0x0400);
+		sram2_write_w0w1(tp, 0x83a6, 0xff00, 0x0400);
+		sram2_write_w0w1(tp, 0x83a7, 0xff00, 0x0400);
+		sram2_write_w0w1(tp, 0x83a8, 0xff00, 0x0400);
+
+		/* XG INRX parameters
+		 * RC coefficients
+		 */
+		sram2_write(tp, 0x84ac, 0x0000);
+		sram2_write(tp, 0x84ae, 0x0000);
+		sram2_write(tp, 0x84b0, 0xf818);
+		sram2_write_w0w1(tp, 0x84b2, 0xff00, 0x6000);
+		/* Training AAGC PAR (with uc2 patch) */
+		sram2_write(tp, 0x8ffc, 0x6008);
+		sram2_write(tp, 0x8ffe, 0xf450);
+		/* DAC BGK */
+		sram2_write_w0w1(tp, 0x8015, 0, BIT(9));
+		sram2_write_w0w1(tp, 0x8016, 0, BIT(11));
+		sram2_write_w0w1(tp, 0x8fe6, 0xff00, 0x0800);
+		sram2_write(tp, 0x8fe4, 0x2114);
+		/* 10G PBO table */
+		sram2_write(tp, 0x8647, 0xa7b1);
+		sram2_write(tp, 0x8649, 0xbbca);
+		sram2_write_w0w1(tp, 0x864b, 0xff00, 0xdc00);
+		/* 2.5G ado power window size */
+		sram2_write_w0w1(tp, 0x8154, 0xc000, 0x4000);
+		sram2_write_w0w1(tp, 0x8158, 0xc000, 0);
+		/* 10G lock far */
+		sram2_write(tp, 0x826c, 0xffff);
+		sram2_write(tp, 0x826e, 0xffff);
+		/* XG INRX parameter */
+		sram2_write_w0w1(tp, 0x8872, 0xff00, 0x0e00);
+		sram_write_w0w1(tp, 0x8012, 0, BIT(11));
+		sram_write_w0w1(tp, 0x8012, 0, BIT(14));
+		ocp_reg_set_bits(tp, 0xb576, BIT(0));
+		sram_write_w0w1(tp, 0x834a, 0xff00, 0x0700);
+		sram2_write_w0w1(tp, 0x8217, 0x3f00, 0x2a00);
+		sram_write_w0w1(tp, 0x81b1, 0xff00, 0x0b00);
+		sram2_write_w0w1(tp, 0x8fed, 0xff00, 0x4e00);
+		/* Slave about EC mu of datamode AAGC  and DAC BG */
+		sram2_write_w0w1(tp, 0x88ac, 0xff00, 0x2300);
+		/* improve UBE */
+		ocp_reg_set_bits(tp, 0xbf0c, 0x7 << 11);
+		/* close Sparse NEC, improve connect 5EUU calble performace */
+		sram2_write_w0w1(tp, 0x88de, 0xff00, 0);
+		/* 5G slave compatibility issue (will include in v10) */
+		sram2_write(tp, 0x80b4, 0x5195);
+
+		/* XG Test Mode
+		 * xgtstm_map_tbl for mdi_cap_sel
+		 */
+		sram_write(tp, 0x8370, 0x8671);
+		sram_write(tp, 0x8372, 0x86c8);
+		/* xgtstm_amp_map_tbl for  REG_IBX_UP_SHIFT_L */
+		sram_write(tp, 0x8401, 0x86c8);
+		sram_write(tp, 0x8403, 0x86da);
+		sram_write_w0w1(tp, 0x8406, 0x1800, 0x1000);
+		sram_write_w0w1(tp, 0x8408, 0x1800, 0x1000);
+		sram_write_w0w1(tp, 0x840a, 0x1800, 0x1000);
+		sram_write_w0w1(tp, 0x840c, 0x1800, 0x1000);
+		sram_write_w0w1(tp, 0x840e, 0x1800, 0x1000);
+		sram_write_w0w1(tp, 0x8410, 0x1800, 0x1000);
+		sram_write_w0w1(tp, 0x8412, 0x1800, 0x1000);
+		sram_write_w0w1(tp, 0x8414, 0x1800, 0x1000);
+		sram_write_w0w1(tp, 0x8416, 0x1800, 0x1000);
+
+		/* Cable Test Patch */
+		sram_write(tp, 0x82bd, 0x1f40);
+
+		/* Thermal sensor parameters */
+		ocp_reg_w0w1(tp, 0xbfb4, 0x07ff, 0x0328);
+		ocp_reg_write(tp, 0xbfb6, 0x3e14);
+
+		/* spdchg_gtx_shape_100M */
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0x81c4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x003b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0086);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00b7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00db);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00fe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00fe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00fe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00fe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00c3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0078);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0047);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0023);
+
+		/* lsbmsk_parameters
+		 * RL6961_lsbmsk_parameter_250207
+		 */
+		sram2_write(tp, 0x88d7, 0x01a0);
+		sram2_write(tp, 0x88d9, 0x01a0);
+		sram2_write(tp, 0x8ffa, 0x002a);
+
+		sram2_write(tp, 0x8fee, 0xffdf);
+		sram2_write(tp, 0x8ff0, 0xffff);
+		sram2_write(tp, 0x8ff2, 0x0a4a);
+		sram2_write(tp, 0x8ff4, 0xaa5a);
+		sram2_write(tp, 0x8ff6, 0x0a4a);
+		sram2_write(tp, 0x8ff8, 0xaa5a);
+
+		sram2_write_w0w1(tp, 0x88d5, 0xff00, 0x0200);
+		break;
+
 	default:
 		break;
 	}
@@ -8175,6 +8368,18 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 	set_bit(PHY_RESET, &tp->flags);
 }
 
+static int r8159_wait_backup_restore(struct r8152 *tp)
+{
+	u32 ocp_data;
+
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
+	if (!(ocp_data & PCUT_STATUS))
+		return 0;
+
+	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
+			       ocp_data & BACKUP_RESTRORE, 200, 2000, false);
+}
+
 static void r8156_init(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -8184,14 +8389,14 @@ static void r8156_init(struct r8152 *tp)
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
-	if (tp->version == RTL_VER_16) {
+	if (tp->version == RTL_VER_16 || tp->version == RTL_VER_17) {
 		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xcffe, BIT(3));
 		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));
 	}
 
 	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
 
-	if (tp->version != RTL_VER_16)
+	if (tp->version < RTL_VER_16)
 		ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
 
 	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
@@ -8205,6 +8410,7 @@ static void r8156_init(struct r8152 *tp)
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
+	case RTL_VER_17:
 		r8156b_wait_loading_flash(tp);
 		break;
 	default:
@@ -8221,6 +8427,11 @@ static void r8156_init(struct r8152 *tp)
 			return;
 	}
 
+	if (tp->version == RTL_VER_17 && r8159_wait_backup_restore(tp)) {
+		dev_err(&tp->intf->dev, "init failed, backup-restore timed out\n");
+		return;
+	}
+
 	data = r8153_phy_status(tp, 0);
 	if (data == PHY_STAT_EXT_INIT) {
 		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
@@ -8236,7 +8447,7 @@ static void r8156_init(struct r8152 *tp)
 
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
 
-	if (tp->version == RTL_VER_16)
+	if (tp->version >= RTL_VER_16)
 		r8157_u2p3en(tp, false);
 	else
 		r8153_u2p3en(tp, false);
@@ -8247,7 +8458,7 @@ static void r8156_init(struct r8152 *tp)
 	/* U1/U2/L1 idle timer. 500 us */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
-	if (tp->version == RTL_VER_16)
+	if (tp->version >= RTL_VER_16)
 		r8157_power_cut_en(tp, false);
 	else
 		r8153b_power_cut_en(tp, false);
@@ -8294,7 +8505,10 @@ static void r8156_init(struct r8152 *tp)
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
 	/* rx aggregation / 16 bytes Rx descriptor */
-	if (tp->version == RTL_VER_16)
+	if (tp->version == RTL_VER_17)
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
+	else if (tp->version == RTL_VER_16)
 		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);
 	else
 		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_ZERO_EN);
@@ -8302,7 +8516,7 @@ static void r8156_init(struct r8152 *tp)
 	if (tp->version < RTL_VER_12)
 		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ACT_ODMA);
 
-	if (tp->version == RTL_VER_16) {
+	if (tp->version >= RTL_VER_16) {
 		/* Disable Rx Zero Len */
 		rtl_bmu_clr_bits(tp, 0x2300, BIT(3));
 		/* TX descriptor Signature */
@@ -9690,6 +9904,29 @@ static int rtl_ops_init(struct r8152 *tp)
 		r8157_desc_init(tp);
 		break;
 
+	case RTL_VER_17:
+		tp->eee_en		= true;
+		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
+		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
+		ops->init		= r8156_init;
+		ops->enable		= rtl8156_enable;
+		ops->disable		= rtl8153_disable;
+		ops->up			= rtl8156_up;
+		ops->down		= rtl8156_down;
+		ops->unload		= rtl8153_unload;
+		ops->eee_get		= r8153_get_eee;
+		ops->eee_set		= r8152_set_eee;
+		ops->in_nway		= rtl8153_in_nway;
+		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
+		ops->autosuspend_en	= rtl8157_runtime_enable;
+		ops->change_mtu		= rtl8156_change_mtu;
+		tp->rx_buf_sz		= 48 * 1024;
+		tp->support_2500full	= 1;
+		tp->support_5000full	= 1;
+		tp->support_10000full	= 1;
+		r8157_desc_init(tp);
+		break;
+
 	default:
 		ret = -ENODEV;
 		dev_err(&tp->intf->dev, "Unknown Device\n");
@@ -9843,6 +10080,9 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 	case 0x1030:
 		version = RTL_VER_16;
 		break;
+	case 0x2020:
+		version = RTL_VER_17;
+		break;
 	default:
 		version = RTL_VER_UNKNOWN;
 		dev_info(&udev->dev, "Unknown version 0x%04x\n", ocp_data);
@@ -10160,6 +10400,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8155) },
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8156) },
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8157) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x815a) },
 
 	/* Microsoft */
 	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07ab) },

-- 
2.47.3


