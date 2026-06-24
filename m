Return-Path: <netdev+bounces-301571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wq/OBAOaO2rfaAgAu9opvQ
	(envelope-from <netdev+bounces-301571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:49:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD66BCAD1
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:49:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="k4P/jWP6";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301571-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301571-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DDA930DE291
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B739099B;
	Wed, 24 Jun 2026 08:46:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE972ED870
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:46:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290813; cv=none; b=PqhqyUYlSNNUGpl2XOZHLz3SCG/OBGMHWLw2N0eVtUyBq4N3h9ZCuIpDTCXoW0UJLb6Nx8ZbzjSBVfD0Y6Dt5Uqb6KygL1vDtL5w1tBXOw8okmwY7eav30SsowwSRXXf18X8/9W/gcvGXMYWlS7woEubfUOtxHPYDgbPbis5zN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290813; c=relaxed/simple;
	bh=hEAydHqntdYMnlyAwKWZtU7FCzzrJfeB5kFdTHg3eh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUEfG7lvALBSRJZUMkgDiWDIy5Vvp1/xWgU+HZiF2AR4Qb4TcAX0cyVJMi9l/sWl044PL6RptcPQnJtmTKuJ0n0Nx7WazPimPCQrBTXFzS/4MMYWPxznKGnUWB/xi9TXLFFPQQEpPb12OMeBodUQ+p3WKrRfXKuFYQ/TaCnlbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4P/jWP6; arc=none smtp.client-ip=209.85.216.67
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-37deb2d3a28so130982a91.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290810; x=1782895610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nE3XF9TJ3rEGOneChwFEqNNIrveo5+lTJId+Q3nPPQA=;
        b=k4P/jWP69O57jPwZ7XzWiGa4PEuv70+fbsPbCyWSv7n7L5APxvB2FKuxtpiESMU0W/
         XLdpz8K+xc0sdcrrCtAcgIbCZREPLxb9mBr57rFnAfPbFy5l/cNa9pkitcQNyPcliFjh
         s3bEmWGawioieBBDLVyyIm6nTyGye3U/Yr7reuqEzyq8XDLzY2yREFz+DGFMfIFtG1QD
         rR1aA0fPMZSlTK3G0/k/GlZytSZviLC4jjRe5UaHkPae3PPsSlVN54djCATEVB54zX9Y
         2q2wH1QwriLD4ed0H8DQiwL8tljvqZtgLuST76C0JVWnk67VoCJvftdSf98WwcMgr8W+
         snUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290810; x=1782895610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nE3XF9TJ3rEGOneChwFEqNNIrveo5+lTJId+Q3nPPQA=;
        b=IWwnXFciI8UKCUeTOG7CWnmaJkB/hZr6wYj8Yqgjj9SOxndIyQgB6uJ7AJ721LFFKE
         aV6yYa5gc6qd/XR/aI1BRj/a5DGsLI1wsYQnDDL6AjqN/I6/wCMzSqWUAdFlHumAuch+
         RJFvwHVIHIegra6Zi9VaXkYr+srSNVQoULAobCR4VgwI0AtwZfK5GZoa8js1ccEkSJqc
         Fea1p2DSc3rYTbSjGf/AjZsjFnFg20H1pvKl/9v0waXos/tivn0dqqPiqLYvtoKGsRhx
         DLnQZh++Col7ZO+/43w3M5E2QTwEbIWlzHZn2oJyZvotjZOW2APYQ1McjG70chxQK2PO
         ByoQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7FTmvzb1r5CqvhwUu3fiHfi8t8m1Wz1lcaK+nYupFyDPSr2UqbHRC3+oeqsXY08tRtaLuIkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhbDJxu/ctjDoiPYuNgsSUCKsdc6Z3ghbXzkx/uicRJyZ/X9c
	anMsXEWGogDi16vAojD5KQIv8+A2HXpOtWkKIHUK3AmAi9dAUsAKBbFS
X-Gm-Gg: AfdE7cnBgo+jOpRWBBlhgY/OS1KoTfeZ99SzYd3aCgD4R9GPdncT5Q/bkZ9RbyTYJek
	/t57lKXXUzAqPU0iBo9RGHsQGo+jFDy9E61/KU992K4vvrlgF1xnHc8fcmzyfW9kASKw3B8VjP+
	e9NshouDMBgPiK5qst5T0x0RQaHUB7RpTcqSZASJTFFAtVk62F+QfMi2ZtbBEZIiz1JS1swNuEX
	Npzv0wQou/oRGiPZuq71E+aLiLJlmIJsaDLKrcxIVlJet/PmYp9kgTfRi3KiWfqPHhZLhear2ws
	XmX8hKk/S6Z1qSV4Jvzk1sGqsgoNmHTX3iy96BFdvV1NaURwT6WSLq3Ni6T+Tg+ZvzRPhK6iQQI
	s2dJQmtC2S+qgMDspUE+CY/fCFm32OBgIQ/QeuEC5T+XLNPviC5CrTZc6RQxuGoD95v5wH7Q5Ym
	yRvwmUvRF4EkFTH16u9sA+evOX
X-Received: by 2002:a17:90b:278b:b0:37c:6975:2e3d with SMTP id 98e67ed59e1d1-37dd0d3de38mr6759149a91.8.1782290810525;
        Wed, 24 Jun 2026 01:46:50 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3d152f4sm2138146a91.14.2026.06.24.01.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:46:50 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Date: Wed, 24 Jun 2026 16:44:39 +0800
Subject: [PATCH 2/7] dt-bindings: arm: rockchip: Add Alientek DLRV1126
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-rv1126-alientek-dlrv1126-v1-2-5aef608a3f64@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782290789; l=1084;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=hEAydHqntdYMnlyAwKWZtU7FCzzrJfeB5kFdTHg3eh8=;
 b=LQo6M34edM3nvXNVY+lWG19FP/SsEWFUfLZegDFVnSHuVJWMtsEo9BN8H+BQsQz7HVsHAPF9k
 ntrv/WOTO4JAdqu8mcEVaIdImKoX5QNJcMKn9i+mijaj9U60D4syALM
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
	TAGGED_FROM(0.00)[bounces-301571-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AAD66BCAD1

The board consists of a DLRV1126 carrier board and a CLRV1126F core
module based on the Rockchip RV1126 SoC.

Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1a9dde18626d..9058f2a461d5 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -162,6 +162,13 @@ properties:
           - const: coolpi,pi-4b
           - const: rockchip,rk3588s
 
+      - description: Alientek CLRV1126F SoM based boards
+        items:
+          - enum:
+              - alientek,dlrv1126
+          - const: alientek,clrv1126f
+          - const: rockchip,rv1126
+
       - description: Edgeble Neural Compute Module 2(Neu2) SoM based boards
         items:
           - const: edgeble,neural-compute-module-2-io   # Edgeble Neural Compute Module 2 IO Board

-- 
2.54.0


