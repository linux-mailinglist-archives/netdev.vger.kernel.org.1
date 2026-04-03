Return-Path: <netdev+bounces-275147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kANPOynwz2mt1wYAu9opvQ
	(envelope-from <netdev+bounces-275147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:51:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0123969F7
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD7CC30BB4DA
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37FA3CF671;
	Fri,  3 Apr 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="KhYjomze"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D93A8721
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234647; cv=none; b=iGsUEHy+a18o0gJLLph7/xwWErxyOxPAb9Tcd9FbXy0+McEX33lXl6Xq4WTEdWi3Vs3cNbW3woS17TgM3ueQb4FR/83uOT6QGxK8i8Yidr7SXFuU5DuHbE13R2MxtwER9oF359iAvx+cIXX82JAHsM/ieNtVy9KkmOI98ulsJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234647; c=relaxed/simple;
	bh=vDbmeaqL6j039OEqNItmPJ9fxW8hfiNnCv9Ev3C9C08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFfL6Qq8aZXUduWLC9/sZEnlwxYAUofW/kZNJOGb3lTtWQzkQjgFuat5/vLYggnh+YhZTT7w4SmEUs4Da5LxGBVxrQPEdsEhR2HgkZkNekhvVB4Ii+xDP/1KKMvcRuvXiwD4p94mQQLSGbgsLL9m9REu63eF0HKJOoD5XsC66JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=KhYjomze; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c745e18a0so166547066b.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775234644; x=1775839444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CKDzUVCGIYSeYc4ZNCps7II5Y1x+X+SqlRkbx3cDqc=;
        b=KhYjomzem+V7R0EavqlwkPcYjpOag4mY5muiXu/ykKnnWBmH9iwZFhAI+hgEccWVS3
         65jYrBj+GQ0kS4rwxQtNavczRNoXqwR2selZv66jS4VAlE2gtfc5CTSCQ2tLp9lupyrg
         ewZigJ3/noibsB3Qy8VmoDoe/9tihmzhAJfC4NCn2OQns23pSYQgNQ3K1PwobndPcWW0
         guG9lrogxQ7zc7bWff4l4jsyGmCaYMgKOYbRlWNl56Q4QX6vyug7Ttrk5tm2YzkIZDnV
         V5JuIlvYoB2rCkrFLuar5Knuv4QNf+2bnfvh+P3B8o4IQUI+sIj9kgQppisu4pECed45
         EdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775234644; x=1775839444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7CKDzUVCGIYSeYc4ZNCps7II5Y1x+X+SqlRkbx3cDqc=;
        b=oLwSKyJRAL2/NtPnZCtVqYK0A8H9gT1MI9wnQAeavZF/n4dmJxegHlz3mGQsbJp3Wh
         G7a4dY8DQGQg2vXsDj5oK37Qg5Po09VtPCxT7nOHnaNKr0peTvPKP4vnnjk6d3B1kmvU
         KOOIcuYqi6Sl5MoDzBf3voseM5c4bX1QXCn79h8d5zK4H2eaITENl9BC6ODex0miV8Ur
         2bRG5fmH8waJSfIa3KOCrOg/6WifITM8uo8vE4IHT8te2Q/OMkNM/jsQrVd7Pnr4O0yx
         HIA+2DtDE4y74TDQetwMSdgpHP9jKKYPrwRPWMNVjRBvGwD2ZeZ4ZX4ktPwD9cGnZjXP
         axAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj65BHF5nmEicb19jq/LEQXwuzieU+MK2OFn5kSye9/ObJ0jeOt1ySOyt6LQfwlzvxaG/8n9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSwe/jY0EO4x44GvHIXqw0Fpz3oe1juvcC/CwGZmt9gbf3BdX8
	GQXguu/1JlnGKejLhZU+KKpaWlBL8NOLYoO3c+Gjgb8IYpF5/ajL7rUeXUypkADecF0=
X-Gm-Gg: AeBDievU2vlG9t5DeQkGYKtphN0cjobZds9wzOhmo4MWctgzwnQxm1oBmad1opcVsBA
	vD6i+/9VGdRYUiu9nxwT8UmToiGLMYO8X8gGdVuDBo0TThgIH6ziiemW16NIVPZasHN7OJGcUkO
	NheOymFXX6STf/3x240l52h1cux1AANf0dv8pYDZtYifvWRMgcJFf/+TBISJXxYIWBsDHEjyY99
	3jlTdQRvgg4nFJy7MBJP66FvRnQVnnXouB1heQc6kD4fcwY9FH6JB20hE1C/YOHzFRvkBpX2Sn2
	+Gy41q/r9ZD9F347wUkopP5lqm5M2o6ThVksvqYcDP5vs7S4rvFm4ilLbFlNKFkjzNROXk2So+w
	3KP8pCNJvxPDapNSV84s4dPJx7gf3H/vOldpIXRtRrD7/drV/o9udVZyxQZOChVsGlNzE8WVJ9H
	rBR/k/UIyXtMTxW1y8IpRxGt2pkvu4KjOF8lf+Txdh6z6MhFHuYuDXrgO2r09GlJss0jy3P6VNM
	5ytvNV7Y8kxgGpurBFZDq0aC78PR8KfGcFwxQ==
X-Received: by 2002:a17:907:3d0c:b0:b9c:7b62:7bc9 with SMTP id a640c23a62f3a-b9c7b628bf4mr89943966b.11.1775234644481;
        Fri, 03 Apr 2026 09:44:04 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3ca9a145sm213492566b.25.2026.04.03.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 09:44:04 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 18:43:49 +0200
Subject: [PATCH 3/6] dt-bindings: net: qcom,ipa: add Milos compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-ipa-v1-3-01e9e4e03d3e@fairphone.com>
References: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
In-Reply-To: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775234639; l=699;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=vDbmeaqL6j039OEqNItmPJ9fxW8hfiNnCv9Ev3C9C08=;
 b=mXWJEgU3e2IoxjKyItffyoAa4WLNpmWiImybdREDj076J1O8EJOtjTJ/7E60j+8rTZskknyqm
 86UuGN77F5JBZbIiCMC4s+p6WmmcYX3+n9viols85CSHwizdDPeijAs
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275147-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fairphone.com:dkim,fairphone.com:email,fairphone.com:mid]
X-Rspamd-Queue-Id: 4B0123969F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the Milos SoC, which uses IPA v5.2.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index e4bb627e1757..fdeaa81b9645 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -44,6 +44,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,milos-ipa
           - qcom,msm8998-ipa
           - qcom,sc7180-ipa
           - qcom,sc7280-ipa

-- 
2.53.0


