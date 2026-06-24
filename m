Return-Path: <netdev+bounces-301573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3bDZGpOZO2rIaAgAu9opvQ
	(envelope-from <netdev+bounces-301573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:47:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6846BCA98
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:47:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Zn8kb4oq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301573-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301573-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BF5B3028474
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 08:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FDF395DAA;
	Wed, 24 Jun 2026 08:47:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB672EEE71
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:46:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290822; cv=none; b=fzKxhOqhi2DM4gVmAoizhC9QV4sYSQEq5YJ2YIf3UJbCDbkpb0FuzWPKX11A2PNQUV8Y9LWAjctFuZjYugXeNw376zbDoTVxC6hzS2ZSC7cy6DwbV6BbxMb5ZaAGN1+qQtNzS438WVHR+2CkYATmt7prKIEcVennlYxESJFwjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290822; c=relaxed/simple;
	bh=7ocGNYRnYoq9maF2qAH3laNWa/8XOoI4f7GpRXsmMt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9V90euZapI4LWzxGWjWPF20ebOXTt3uFPQHoGocr1N35HKRV+kBkC/LR7PT5ptvqIm7VPEbJL/6pWwL9bWU2n0YopWFplrVpiz/Sn45MfRCkIPADFggbEP01poeDuWrX+Uur64AdtuWUMxh1oJn62BVF9evCxSchp8kctLDmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn8kb4oq; arc=none smtp.client-ip=209.85.216.65
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-37de961d1bfso166929a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290818; x=1782895618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skj2iu380j1PKL/xdlE3SsAEeiyHxzabmaPPRXEHU2s=;
        b=Zn8kb4oqgNzkxNdTqN+PwganhWev7Oo61h32tOWP77PMTXkxWm7bTDrfku+UzgYcUA
         4eTWI3KjL8F1theqaGlX+HN0jPff3UG/2DMjJuheqh87XyI3TY06TrrRKD0iY+sEJY9b
         UczvjFUug5Hlwqsn4uqeLiJgvnQuE27ZBvPV/A6FM+JhZFvrIz9vLSl47z6Vc0livduE
         oIjlEA+J0VI7EPRdz8kmPSAKZp8LC6CKGZ97/IEPXVSrTcTk+lieLIFrB+cBmVh9eZ3i
         zqt4slGA7LkHyaMT+TnP8WIo0Ot0zCcq8Fyg+kUx0cQHj3kAY23QnnUvKU3P+PGFgDM3
         aK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290818; x=1782895618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=skj2iu380j1PKL/xdlE3SsAEeiyHxzabmaPPRXEHU2s=;
        b=lTybfBT5hxV0ZGeeAbzdhIZGHkuUC6UOAuCJHBrScc8K7wMS9IswLM37WW4RlBBQcZ
         JcMi1xP40sXzYgi3pLBSrHJdT+53Mf6ziB+u31/s0MiTf89ThDGBOPOmZN5I2Azpzc0F
         jyJmFnwB4VexmZwu0HpkisdSyXjislAWqgd5zO2AX6G0bu5Soj0baL8RiJSorNcGmvpP
         RoN2LsNJbx14M5KwofDNOBXkWMFly5Y8oTFQdeZ2YMIrlD5ZiSJTYpWxCMw2K1cfKVIb
         HVQn8PJzr11PffqyXAXNZR0kzeQOw/dP0O7nnQ+XfxRcHkcG9DfXGAThzvugMMuI7qo1
         ++kA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2aAwlrURU6Qp5PfGC+qoA+ECp00hV4a/NDhnk8RYCbH8I+HGa8iIdOU2xErUcpMgX6/DS+t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZWpmLkznQEDgUw1LK9TWNy27S6VpqzdRuVU900S906BdWVqm
	322/cEFEaV5p86Pn+tYzjyA0VptsX7AsQya+Tck0nfwfVta2l2JoueYF
X-Gm-Gg: AfdE7cm7nwWMeIe7t2L+l8QJHxBuS4BmcXPwE7LML/KXITzMMma1fpXg9ckUbOKLs+q
	MZ63b9ecKHTeQNwDf9lV6o3EwmRwHMSLP72g/su79xAN9IqKT9mss/wALpPm/FvDRxdtF4XLAqx
	K/T1KC/YKPPn5wXh9WPg3wbwUzoXcWeiFeh76Fc8u7nF4ojiHclqI8pHKPhKszmpgiIq293BKJx
	Io/A9/QBW1sLcDYcr/IIfSQfFpC9Hmg2P4tC+ye1S2KnSXMdmlU9Nyn0fpx4iuChjXXutvPmMK+
	yXb1+CLKk5XpsvWQI0cv3piH38Yy0xnzC+gl2gClJMBAxgLnNoCnqwRJgJCLPsUYPKfcVk3kISo
	7Zq+6Tn413qXmp5xy8+8z9Z02LemmDaSfmshKWFSADAQWrHI7SBhPiLnIYsx/LDqUHTLj/8Yh/m
	PWeB3ZQgL7eEXi4MuIhamtUtG6
X-Received: by 2002:a17:90b:48d1:b0:36d:8e6f:8d9e with SMTP id 98e67ed59e1d1-37de428c345mr2433079a91.20.1782290817925;
        Wed, 24 Jun 2026 01:46:57 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3d152f4sm2138146a91.14.2026.06.24.01.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:46:57 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Date: Wed, 24 Jun 2026 16:44:40 +0800
Subject: [PATCH 3/7] dt-bindings: net: rockchip-dwmac: Allow 9 clocks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-rv1126-alientek-dlrv1126-v1-3-5aef608a3f64@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782290789; l=790;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=7ocGNYRnYoq9maF2qAH3laNWa/8XOoI4f7GpRXsmMt4=;
 b=uzOAy6qn4x5/EXYbBgpWhNj60Kg44wCLTm0qHhvgeTMI+w1MXiBW2yw05av0FmzEnKcNPFl/2
 lhmTEwFcLUWDNbN0W8PzbS2ebsv35H1x8pduzk0iFDXlOiBZFmhJT3E
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301573-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD6846BCA98

RV1126 has a separate GMAC Ethernet output clock used as the external
PHY reference clock. This clock is described in addition to the existing
GMAC clocks.

Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 80c252845349..86a7e83675ae 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -71,7 +71,7 @@ properties:
 
   clocks:
     minItems: 4
-    maxItems: 8
+    maxItems: 9
 
   clock-names:
     contains:

-- 
2.54.0


