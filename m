Return-Path: <netdev+bounces-283233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPmbOPbR9GkYFQIAu9opvQ
	(envelope-from <netdev+bounces-283233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:16:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFBD4AE084
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DE87304233F
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4D3E3155;
	Fri,  1 May 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="DzA+Q4su"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933843E3140
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650911; cv=none; b=mT7SM6Dx3mNw7vrUOGM9Eo6all74ewL3vKLoHFXCIJ/k11gqjfhP7WALJy/c4z/WwCERQX6j9rkHzNA1OP7Vaig+P8tAEnCcCLO9otFdwZS3gRcCcqbhrbFE2vCMdLX1fGezLiu/xNyc/5pIyrPCUVYaS5w/cnQAYr2fhsEMQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650911; c=relaxed/simple;
	bh=Z3xqXDkBWFDdyrtPSGEDjKxF9Td/NrtBzEpnN319gkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjA9RebMQ0kyNB0SuIX6tE2ZMfgYsgpiDn7638uFCRqTNuv2Dlgsv53K823njOXfqKw1bBbKftk5LAu0zhatnNCkSl1FXyQOCqgNZ3vniDfEqd1D6qNG6YJOdbbjwVTWQWreNiX5bKFFt2ldM2z5MoQEpAP6OVkvip75EJjOlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=DzA+Q4su; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d4f78fc9f6so214155185a.3
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650908; x=1778255708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK9EvvjSLddFpBQK0gJ5r1hHzJCQAPB+JE9l90vZOLA=;
        b=DzA+Q4su2yvvRRfMmG+pvSbNjFjSOXqlTNDv2P1wKy3VqX3Giec9uHfh6wKNN3xBMT
         s0nTgTX8lQduq6gsuReitPP84qqxFS87Bn9ISaQn145+5vwCWvKfZEMTNkXLFuWk82Qt
         Ut+pbrkg+w2cEFS464mPqZ1oZLowayqXHYJiSYrlJEjhRjXzkdKX9J4eo4V77MHXYKb8
         6HJM05xWbO0itdNawm2D6cpUtXHhR99PT3HW9h1EG7dRH7ceqRgiL/bvOy67WOKZqGIo
         wvfBNR2JzFzWucDFOm+Arni3unStcelYJP/vUdY3m3TEBf8ji3ag5NbqOr4nwHy8XJ1F
         40Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650908; x=1778255708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sK9EvvjSLddFpBQK0gJ5r1hHzJCQAPB+JE9l90vZOLA=;
        b=V8MhMxiYdskaRWAVCNuGv4yH3CIzLkUau6oU1zSj7cpa7eQop18cKrDylfK598HDiR
         0t8j1SRINgM+wYaIO0zTS/easLpqGG2UHI1ZPhacppwrTZpmRQh+x0JbXX08gcWNpKEL
         oEFfmARSrZAlpfk3dFwqwsbhaCx+5O/z3ZCd0i2BxKA5YLmeYZ9N122gJp9F1RdZ76Kr
         UxMHjBekZAYXxYSES8784rP9Hd83O9QrSLUJd9LK6E7DxI7fUs9UO4RBjNe+9/79hSPC
         uHqZ1mQZJ3unXyNYGbfOweJLB06lqbrtjAqMZiYZuC9VfmiqHyyMBMXqjkVsR6bbu1Jt
         k27w==
X-Forwarded-Encrypted: i=1; AFNElJ8phezkFb3h3bquD4yIzhEEB2G4xInrl/itqvcQr/+57ezLaHQtuDlJDXClmbZQW5V1D63PPn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkpvp4k+mfjis/lbZVB84ZsjJwMrMsFj1Gm7jyCkuOJx0Jyctv
	rUNazM/lsevxwEnlKl252xzQeT/uHZfdkVheSrpqKbgfVTchO7teMkPA85w84gwAMUA=
X-Gm-Gg: AeBDietrBfqdsoKqrvb1Dlbi/xHzAadORDRBcEaBuapJbYjwXXNxZlkVb+dtzKtpzw1
	U+IvbNwkpCB2hR18d6Tqs2pSxVca/d+DA7aE2aFydpWazbld3cERzY79tyJjeTZQpspBKf9uzBu
	qMWtzSVfmzENv85kSD0hNnJcmfCCfxzCVngeXxNvFNtOfMZEMAd9YLhNJceiSwJrDk+w9BJ7tM9
	VsAdFQVSHtJ/uLxD1o+DzoOlgVEVT0GV3t/CPugURbss5+58mzaZBI+cSLd+F+iUnFJOLxmhSnV
	a74uiro75JWjdBT9OUWOf0XW8JXz5RwtKFY8FmJYnN1zVKg+LiyjGIFYXmpV5t3HbC0KxAKE51J
	hq172hB2e/xQlGjHEQ0ytw8EjE3oh8kohSx+hZzNcotsfm5UUFbrtnuBzPNYFN7dDgjpUC54X9w
	xD2MIF2EhORNt5oU+GDOjd1nbXUbnVhQOntaTFh45gNUUwKs+xP49IzltZmRCaV5zPqEXGixLd6
	aoo9g==
X-Received: by 2002:a05:620a:171e:b0:8cf:f215:24c6 with SMTP id af79cd13be357-8fa86db71dcmr1150937585a.21.1777650908306;
        Fri, 01 May 2026 08:55:08 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:55:07 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	matthew.gerlach@altera.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 12/12] arm64: dts: qcom: qcs6490-rb3gen2: enable TC9564 with a single QCS8081 phy
Date: Fri,  1 May 2026 10:54:20 -0500
Message-ID: <20260501155421.3329862-13-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260501155421.3329862-1-elder@riscstar.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBFBD4AE084
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.44 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283233-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	RCVD_COUNT_FIVE(0.00)[5];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,kernel.org,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	NEURAL_HAM(-0.00)[-0.361];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,1c:email,riscstar.com:mid,riscstar.com:email,riscstar-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.0:email,0.0.0.3:email]
X-Spam: Yes

From: Daniel Thompson <daniel@riscstar.com>

The QCS6490 RB3Gen2 includes a Toshiba TC9564 (a.k.a. Qualcomm QPS615).
TC9564 is an twin Ethernet-AVB/TSN bridge with an integrated PCIe switch.

There are multiple builds of RB3Gen2 with components included/excluded.
That means whether or not there is a phy attached to eMAC0 depends on
the exact board. However all versions include a TC9564 combined with a
single QCS8081 attached to eMAC1.

Add properties to the existing PCI nodes to describe how the TC9564 and
QCS8081 are connected to each other (and to the host SoC).

(Note: "pci1179,0220" is documented in the "net/toshiba,tc956x-dwmac.yaml"
binding, but checkpatch.pl doesn't recognize that.)

Co-developed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 45 +++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index e393ccf1884af..72c89aa7a2e43 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -308,6 +308,16 @@ vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
 		regulator-enable-ramp-delay = <10000>;
 	};
 
+	qep_1p8: regulator-qep-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "qep_1p8";
+		gpio = <&pm7325_gpios 8 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	wcn6750-pmu {
 		compatible = "qcom,wcn6750-pmu";
 		pinctrl-0 = <&bt_en>;
@@ -937,20 +947,46 @@ pcie@3,0 {
 			ranges;
 			bus-range = <0x5 0xff>;
 
-			pci@0,0 {
+			tc956x_emac0: pci@0,0 {
+				compatible = "pci1179,0220";
 				reg = <0x50000 0x0 0x0 0x0 0x0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
 				ranges;
+
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pci@0,1 {
+				compatible = "pci1179,0220";
 				reg = <0x50100 0x0 0x0 0x0 0x0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
 				ranges;
+
+				phy-mode = "sgmii";
+				phy-handle = <&tc956x_emac1_phy>;
+
+				mdio {
+					compatible = "snps,dwmac-mdio";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tc956x_emac1_phy: ethernet-phy@1c {
+						compatible = "ethernet-phy-id004d.d101";
+						reg = <0x1c>;
+						reset-gpios = <&tc956x_emac0 1 GPIO_ACTIVE_LOW>;
+						reset-assert-us = <20>;
+						reset-deassert-us = <20>;
+
+						pinctrl-names = "default";
+						pinctrl-0 = <&qep_irq_pin>;
+						interrupts-extended = <&tlmm 101 IRQ_TYPE_EDGE_FALLING>;
+					};
+				};
 			};
 		};
 	};
@@ -1524,6 +1560,13 @@ usb_hub_reset_state: usb-hub-reset-state {
 		drive-strength = <2>;
 		bias-disable;
 	};
+
+	qep_irq_pin: qep-irq-state {
+		pins = "gpio101";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
 };
 
 &lpass_audiocc {
-- 
2.51.0


