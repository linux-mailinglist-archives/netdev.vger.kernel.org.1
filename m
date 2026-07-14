Return-Path: <netdev+bounces-307564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AIa1A+KKVmrC8gAAu9opvQ
	(envelope-from <netdev+bounces-307564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:15:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FB175826D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:15:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=O8INetyq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307564-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307564-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A07A130F1236
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40993418A5F;
	Tue, 14 Jul 2026 19:14:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB82418A5A
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:14:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056460; cv=none; b=RhxtzOWlKmv7zJKDPLozu/pueAmHAQS6959yp/oAXUkKEG9I2AVsXYdfrsWE0XF/KhpU15b2HajAVxyVSf9y40pBOPyyYTjErnEF+7P4JT5qgjN1kBHvcWO2mhMiIc67ZSud0kVAqITlJCV5cvFx6DnwMYqDdJ4BHTAcomPF2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056460; c=relaxed/simple;
	bh=Nav+HS5OErlPDLcxR8yNX0SxWNzthXaAf99JkiSiWoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoBQ+t0xyhp/2SQQglXaNk0Ez7rzOLx3kQAhTLHK2DhLUXoaKKngsKsWHPiVnM+WCW5ncMQ1Y1pNwMVpbU7SlNUfpf+VYhARd7ovvGvXJchkBlx1EZl09L7F3LVcdDtqfYyFTcDe3kyudKLYbe/VygFB91FMc5Bcsdk84ATQCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8INetyq; arc=none smtp.client-ip=74.125.227.139
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2ceb5a39c48so4975065ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056458; x=1784661258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D31Jk59RNQrVzT/A24ayRfZRG2gdPQCEGTF2WIN9kY8=;
        b=O8INetyqO96tgwDW7pYmZJHu33Kz4eNFz+O2Q64IFCTvmh3Ipb9gGsVhkbybwGtQpx
         tOtSRKBbT2bZHN4oGHBOkJ7CWzaZO4ibLP5UwQTKm+pF0Ni0uLDVp4eRVfqJa4f4s9bv
         0pjRjQvedIdoQnZ6TsRnkP87u01tzikmjRxlWv5BalCIXm1oYCkoR9OZi95ALVb0As0V
         uok7cJmXkenQkxJ6Kq0LhTeBt0eJx4wD1gVPiSRAdJ5Aw1k5Lb9yivP0Kt99yUvWP1nU
         yL4VQY8/PMa+o9ybIvdNKI9Ra3TNrOnD0YQBtqe2O9hbnR2HIxjQ1tB2yBJ7G5+efS4o
         bTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056458; x=1784661258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D31Jk59RNQrVzT/A24ayRfZRG2gdPQCEGTF2WIN9kY8=;
        b=WJc8Zsr/ePeJbN3FE3/14cus7klHQfibDl8U+bzTvN39hDEpdwnziZozqLRxWsWZQ6
         VqR25wjQ1jQBnmva2yoNV9KFdGjkgOTEua3ChalXaS5F2x/5Y8yjrnBaVhYmDqsCoUQd
         4Rz4fZxKtf9gPHT/O6MejlZY0a27Liv9IotnZ2Snsiql6LrOkK4Geafuih9jubuwqzfw
         ovNNkuGAjxYf5OlTLOjxGaOu8exfhChAGE9I7tJQxbGLywzDRpTA8i9T1kWqEvW82vSy
         lXZZvaBsrmY1StpjDMqdAoJX8doEMQ9GffVxiBs8YGJZKY3CUbj1E7LMpqAdFvByuc/M
         v5Hg==
X-Gm-Message-State: AOJu0YzQ1bvD7rw/ug09vZubab+KtYbSG4WytUCu8LvSXI1R0JZ7uplA
	xjwdTzNAkby9WaDCWtTzvlpkzKJcUB/FoOlqgECzqnFMsYQldFduRQYN
X-Gm-Gg: AfdE7clpTE3arlyq01JdWxaHhrGgLfBPuvLJlh6YlXNAvatgYIteRjFKFYOVCI66e65
	YZexdBbb5wMMyENYFISOHzzp9RV1nAOYA0td2NGaamM6+iq30wKnDbsVgjtlcS34ctIMqwj8M34
	5EF6w4XI86suDFcvrQ+Xbt9CpzMnTUyjdenDmgFXujr1PD7MHnKEywvQ3gd+ZLvWbsTY4RXB99X
	yHsnpr7XCcmQ78GFbRosCvHV6E+OlQ3Ju3+B/KScLnMdofoabJ0DwsNAJttyb8zKRg8Fvu1xvsD
	Ffzb6ToxoiBYa0wdVHBimuPhw4DQRp3V8JWzBKZytpmn8dlA8XG0VzFJ8yEiI+2INUNiX92HXHU
	a0D9W13NWPRY6F9nDcW6wfxPTdL8lD+rKtD3lmONHhVfIyT67L32iTw2SEnY0y4bCZK1+3i+x/9
	fDppZ6D9FJE00=
X-Received: by 2002:a17:903:1b08:b0:2ca:17a8:cfce with SMTP id d9443c01a7336-2ce9f2852b2mr148789445ad.29.1784056458374;
        Tue, 14 Jul 2026 12:14:18 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm120763245ad.65.2026.07.14.12.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:14:17 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [RFC PATCH 05/10] arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
Date: Wed, 15 Jul 2026 03:08:33 +0800
Message-ID: <20260714191341.690906-6-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714191341.690906-1-coiaprant@gmail.com>
References: <20260714191341.690906-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307564-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:coiaprant@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55FB175826D

The RK3568 SoC integrates a Synopsys DesignWare XPCS that provides
the Physical Coding Sublayer for 1000BASE-X, SGMII, and QSGMII
interfaces via its four MII ports.  Add the XPCS device node and
its pcs-mii sub-nodes to the SoC device tree.

The XPCS device is accessed via the APB3 bus at 0xfda00000 and
requires the CSR clock (PCLK_XPCS) for register access and the EEE
clock (CLK_XPCS_EEE) for Energy Efficient Ethernet operation.  The
PD_PIPE power domain must be enabled before any register access.

Also add two fixed-clock nodes (xpcs_gmac0_clk and xpcs_gmac1_clk)
providing the 125 MHz reference clock for the GMACs when operating
with XPCS.  These clocks are used as the assigned-clock-parents
for the respective GMAC nodes.

All nodes are left disabled by default and must be enabled at the
board level when 1000BASE-X/SGMII/QSGMII is in use.  The XPCS node
also requires a reference to the appropriate Naneng Combo PHY via
the phys property at the board level.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 3bc653f027f1f..989e164c0eb39 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -110,6 +110,51 @@ sata0: sata@fc000000 {
 		status = "disabled";
 	};
 
+	xpcs: pcs@fda00000 {
+		compatible = "rockchip,rk3568-xpcs";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0xfda00000 0x0 0x200000>;
+		clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
+		clock-names = "csr", "eee";
+		power-domains = <&power RK3568_PD_PIPE>;
+		status = "disabled";
+
+		xpcs_mii0: pcs-mii@0 {
+			reg = <0>;
+			status = "disabled";
+		};
+
+		xpcs_mii1: pcs-mii@1 {
+			reg = <1>;
+			status = "disabled";
+		};
+
+		xpcs_mii2: pcs-mii@2 {
+			reg = <2>;
+			status = "disabled";
+		};
+
+		xpcs_mii3: pcs-mii@3 {
+			reg = <3>;
+			status = "disabled";
+		};
+	};
+
+	xpcs_gmac0_clk: xpcs-gmac0-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_gmac0_xpcs_mii";
+		#clock-cells = <0>;
+	};
+
+	xpcs_gmac1_clk: xpcs-gmac1-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_gmac1_xpcs_mii";
+		#clock-cells = <0>;
+	};
+
 	pipe_phy_grf0: syscon@fdc70000 {
 		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
 		reg = <0x0 0xfdc70000 0x0 0x1000>;
-- 
2.47.3


