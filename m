Return-Path: <netdev+bounces-301575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r95qNJ6aO2r8aAgAu9opvQ
	(envelope-from <netdev+bounces-301575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:51:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33D6BCB11
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:51:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=S6J5a7bb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301575-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301575-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05BD7312CBB3
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C8393DC0;
	Wed, 24 Jun 2026 08:47:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DBA31E84E
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:47:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290833; cv=none; b=OA1Ie/SdiC10GB5+5IIHgoq9CUZyPBhr3ON8iiq1KxtgbrlvS8ZUNPN1E0AWF9xHT3aqiCnsGsN+spoeA3CuXEE5C9t2RZ1VsYRoq6x72fO0XtYwJKCUTr+JXghLAzkOOyiah1IhyjTFhgNXEMR9V6wSQcX4g6RNTj6hhSfEPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290833; c=relaxed/simple;
	bh=8EosIzzR7UzOFP/v55N37uL3TxX8W4lq/3WtMuwfnjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBGO3obfBN3hE3v06QBRL01qFd+M1+VDIZrsivA5j3DEYQ1lh9XmjaNgL/pJPViSbu/jsAEWQw7bNN/t5GrsH5j9hYniZs+++UjLFQ9B0E2m5tFfu37M4eXyq5oEMzXYqJIdHjT0/83rqycN7Z1C3tLTKkQxMgOBPTn5BX0YSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6J5a7bb; arc=none smtp.client-ip=209.85.216.66
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-37d7c265ca5so660250a91.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290831; x=1782895631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLcfgRgcRG6+Y1GgVHrol+2NxklkD2AbD5mhAFMMnog=;
        b=S6J5a7bbSNi6mc5Tn6dtd3h+h4hty8pbJMFLfdOfWym+74JG005tWWKfWy25QjRW2i
         qGM114J8A0iDX42tlPhYyVBsEsALQ9aZz1WBGhNXm/sx5GNfTQkYVm9ZGDXHEcFRuABc
         ehDj7c91vyZ7pdzm2E/cD3hII7ISeJzG39sLXmuUmiHnw8O8U6ipz6hLa0Rbzj2QA3F+
         mIMgL/wFS5Q0YQ6zwRJV/00Sj3oaoxiObafT+zue96oS6OxjH7Buf2pwgT6llbaERcZ5
         u97ohKvJVBr+GgWxUZyte0qhD1yrJu2F9BaWIH2XHxYLcB1WD9GEAVTtTbIEQPL9q+Cv
         3s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290831; x=1782895631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LLcfgRgcRG6+Y1GgVHrol+2NxklkD2AbD5mhAFMMnog=;
        b=dOIh7HLHM+RJMBgTuNA3GSO1Pm1GOVz7UEdU95sW07HkSo1oeBg7qY0g0dsgUz03Ut
         AV+Bu1NslpkAfUDHVnIr8p0f+huaTzKlZbqtUDi31dJW5e2nefcPYveov9EODXDbL60Q
         3weZNAQCI4gN+jFvBNwV23YXon9lOndzg3S3/9olHmTYm+7uUM3tGdBJ7aI3yAwqBAuy
         dsdhOdp7KHo4yZk48D5CdRbgg8E9ptyzmi60cq0Ytmvs7NUX7KEBCU/3VD/yL2JcKDXi
         74ElaBvG76x9WEcv5ODcLpzV8KPBY0NtIu0873MlhDjK0PsdtJ6xf05EIKeazJo1X7Oo
         ZFEg==
X-Forwarded-Encrypted: i=1; AHgh+RoqnaIhW3eRBJNhIRrxh95LyAsfMSeGr1B2qmoULH+1KUUYYFcUWERTuRQO0v8V41BjaFRmAHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+S3ypTmenICG6d7JrdjpBaayzi4XisCKCGPkKKhLjdosrJ9F
	90S07oVoFfZTP/reP31Jv3XyiWsJrZCT2HbB+0OUUAFvaTKMY8H/39UC
X-Gm-Gg: AfdE7ckmHzCS4Fn1WcZzM0Z8eWHuo1ZTXng2yMg9QaPDIdQCt4I9z13YcPRqYx9aThX
	m2XEb3CnK2fewlz5sKuBWwRU+ZSfgWlg/iPJ3InWJGX7fTGE3DqkW6NxF39AShhHgh5obV26jWD
	hUmqXqIlGOdWlA06oH3AWbAW9bbAYaJFIAVK2G56autKg1QwmGzfXBvWbZVN8lBgB3e0nXaBEfb
	EYsuEdIU0OFqbmUZJ1N+FzF8xZYyepFMCRVkBMzRneP1RUiTRYv3kfjh+DJbGsf0xKi3wUbU/78
	3jW+fAuQ9+geLuAbjKdgICqDmOpmEAHSOEl4A8k+cMbIpNSzuFHoc9FozrKwPC1SZyeJHjnsSM4
	GCZ4p8BBC0PDVQUuguQ11NhwZLATMU3pOQj/6nucJXGJbzko3Vl6HVRjPv0+F3XA0sGccppdYnh
	QVa/za2UM+79uWc3rXAQm9d2qr
X-Received: by 2002:a17:90b:48d1:b0:36d:8e6f:8d9e with SMTP id 98e67ed59e1d1-37de428c345mr2433707a91.20.1782290831423;
        Wed, 24 Jun 2026 01:47:11 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3d152f4sm2138146a91.14.2026.06.24.01.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:47:10 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Date: Wed, 24 Jun 2026 16:44:42 +0800
Subject: [PATCH 5/7] ARM: dts: rockchip: Add RV1126 GMAC refout clock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-rv1126-alientek-dlrv1126-v1-5-5aef608a3f64@gmail.com>
References: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yanan He <grumpycat921013@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782290789; l=1157;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=8EosIzzR7UzOFP/v55N37uL3TxX8W4lq/3WtMuwfnjU=;
 b=r1c6yrCwcpidwG3sbm7w7O+CAbkpEjmxfvytGLFSVdZDGbuxcpNNDG74XoG4SVu6zMjqBnqL6
 vaYbrNImRDfBTvTqOkFFkTzjjQ6aTtP18tsj4zv/DrAte13JPeV4nRW
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301575-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:grumpycat921013@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,sntech.de,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C33D6BCB11

This clock can be routed to an external Ethernet PHY as its reference
clock. Boards using this clock need the clock to be described so the
dwmac-rk driver can acquire and keep it enabled.

Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
 arch/arm/boot/dts/rockchip/rv1126.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rockchip/rv1126.dtsi b/arch/arm/boot/dts/rockchip/rv1126.dtsi
index d6e8b63daa42..5b1ee06dc035 100644
--- a/arch/arm/boot/dts/rockchip/rv1126.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126.dtsi
@@ -624,10 +624,11 @@ gmac: ethernet@ffc40000 {
 		rockchip,grf = <&grf>;
 		clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
 			 <&cru CLK_GMAC_TX_RX>, <&cru CLK_GMAC_REF>,
+			 <&cru CLK_GMAC_ETHERNET_OUT>,
 			 <&cru ACLK_GMAC>, <&cru PCLK_GMAC>,
 			 <&cru CLK_GMAC_TX_RX>, <&cru CLK_GMAC_PTPREF>;
 		clock-names = "stmmaceth", "mac_clk_rx",
-			      "mac_clk_tx", "clk_mac_ref",
+			      "mac_clk_tx", "clk_mac_ref", "clk_mac_refout",
 			      "aclk_mac", "pclk_mac",
 			      "clk_mac_speed", "ptp_ref";
 		resets = <&cru SRST_GMAC_A>;

-- 
2.54.0


