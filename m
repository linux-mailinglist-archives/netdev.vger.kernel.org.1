Return-Path: <netdev+bounces-255144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANYXElmwfGmbOQIAu9opvQ
	(envelope-from <netdev+bounces-255144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:21:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE650BAF08
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321F2304AAC7
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5CD2BE047;
	Fri, 30 Jan 2026 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+02qoNh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E529BDAB
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779194; cv=none; b=Y9glEQMA0Qh6EMABHZxuV0/HYcbNJ1+z8bXtFziN9ZQXAQgWXWDPU0RgZ+8oqXL3egyscOBoxh5eZkWwnKbeF3Y/+OHKfyQ3bJIjeSGlFmKA/RQorfrY0Z/d6117SOxaJfjlCtIoi8Hfr5TdnVCW3+Lm57YGvmoy2uoZWOUNs3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779194; c=relaxed/simple;
	bh=Or5gzlK0oOcwy1+ave3d9/8tpz5OWkqv6GdelcKgrIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpMHWcqslGAr0y0Kb6azO06VYARoyAewaVUiiw9Xrg7qjyPEjLparjkMBoYRkn2N91EmBB7g1x3GhuTp6q9vC60jx96mCm/UFyShkJrn16s0NWUqJM3cnyJXJpl7FT2OK9D0/vBLIqP9nTObjNTrQ1BkcHMu7Olzjy8QniwbDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+02qoNh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so18037615e9.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 05:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769779191; x=1770383991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj8w1B+8x/las144X+RSjad0uTQtR49s9DyI1HP6ogk=;
        b=K+02qoNhN0+1i0+tP6UEgm5Z7BCScFhH9R+IT86e3trA+ip86QHrcf9djliHdvsm6+
         1qoQuGxOQxFfCZGOcCI0qr138pEcfJGcjwMsiobn1Shp7pmCOvgIiNbls02ZAU2fYhYl
         0sbyBsOrm2ZdEPdO1yYe1PDMhpR3xMhL7XgLiQ+eeLR+wCe5SCGsrCwEucdvFC6M51aV
         B4ifvp5jbiWZirSr72vkLkAsynrKxFxEjHDET8z5GQ1Pf1IwYeoAF3OflADjClp4MPLk
         SlHxtsh4nUotO+dHt35EP4dN8yP4Rs0xLphySOXwynCmgVXNd8CRK1YFL0kM+KElYU9W
         YTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769779191; x=1770383991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dj8w1B+8x/las144X+RSjad0uTQtR49s9DyI1HP6ogk=;
        b=pZtcm9yW7+7rLSexbhvZwRhy7HKB3KOgYcUkztrNZ6zcu4Ise9HaFRQMBN/Kobqzuu
         lwDSe0AU2XwCHCCdKyp31FObkk8Ls0Rk02O+HrwEFBYTD7bZgsFxjeQLEUJCj4rybpUC
         n4A4E8ZDdxXJAWRnZdBtmGy0aTnPxU3QVxW+PimFZgxPNnwVuIIWe5guP0otr5egNVB/
         XP0VdF/FAQV7DRGidaZOeppzkTNGmd7+oXJ8SzR+cA6I2wQhJgeH3DgAOjSAcZG9xySJ
         Z+fDRxSODS4Y0lJW+aLWr06MOoen7w9Ex79VVYKnsvy5RR/CgKtrV8Ci6Bjqrkj98fVn
         hRsw==
X-Forwarded-Encrypted: i=1; AJvYcCUT5yY//RJbe6yANM+A5klpBjo/AxjKUvU917VChZ5tEMjcng2Wa8ZTOcX+T55BU7FaNTuzbQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKBYMwvtHDZNSqp7db0Ya8jxmYDjAotQJ+55Mez02ZrJku0KX
	9Xe+KDmt/LqigpiGr1wJwXNjWUVd1AUgvGiXx0gVcvx5OXZhGplLf6QA+n8KB48jyHA=
X-Gm-Gg: AZuq6aJKU1FJs9DgKcSCqtDu7RtXgqI/7TGiGUYxy2NEaxxI7yicwgOXN9IDKcpqfWt
	mlIfIul1EoY6DH67L3viQG3V/+QxWv7vHlJc0AmjSOBlTI8Vob6W19V7aWJxecIhsw0F4a3MV1F
	lHggYSycUHxsyI7BFKg4xNlHH7l9W054JS55FiwS8tvp01yF/6HrsABhzK2QqLevpDK1MhZqkzy
	M3YcJ9ohFB9s2nh+mVEbL3NWpEQkWI9clLJeAc/p6ISM/lRaKSbzVVoJbtx9UTBamR1+bSTFwC3
	6tWI8ZoM8eKflXchNtFdyumEkQf/B1VAD7GWyjHoXU4hxryZvpOyxU0+SfywyLIiITiDBDz9grX
	HVxNhU+rjT6+JnC6A3JtrfN7RqSkPmeCil+2HOAlve4eFT/des93dxrDRBMYMafLFoztp2SrtjA
	8We/7vp2VbjNtMFLR8
X-Received: by 2002:a05:600c:64cd:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-482db476c24mr37269605e9.10.1769779190983;
        Fri, 30 Jan 2026 05:19:50 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37420sm281408035e9.9.2026.01.30.05.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 05:19:50 -0800 (PST)
Date: Fri, 30 Jan 2026 16:19:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: s32@nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, imx@lists.linux.dev
Subject: [PATCH v6 2/3] dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
Message-ID: <3b75e950b2f8faecd1a9fa757e7eb7b42ace838f.1769764941.git.dan.carpenter@linaro.org>
References: <cover.1769764941.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769764941.git.dan.carpenter@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: BE650BAF08
X-Rspamd-Action: no action

The S32 chipsets have a GPR region which has a miscellaneous registers
including the GMAC_0_CTRL_STS register.  Originally, this code accessed
that register in a sort of ad-hoc way, but it's cleaner to use a
syscon interface to access these registers.

We still need to maintain the old method of accessing the GMAC register
but using a syscon will let us access other registers more cleanly.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v6: Fix O vs 0 typo in GMAC_0
v5: Add Rob's R-b tag
v4: Fix the formatting issue Rob pointed out
v3: Better documentation about what GMAC_0_CTRL_STS register does.
v2: Add the vendor prefix to the phandle
    Fix the documentation

 .../devicetree/bindings/net/nxp,s32-dwmac.yaml      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
index 2b8b74c5feec..1b2934f3c87c 100644
--- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
@@ -32,6 +32,18 @@ properties:
       - description: Main GMAC registers
       - description: GMAC PHY mode control register
 
+  nxp,phy-sel:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the GPR syscon node
+          - description: offset of PHY selection register
+    description:
+      This phandle points to the GMAC_0_CTRL_STS register which controls the
+      GMAC_0 configuration options.  The register lets you select the PHY
+      interface and the PHY mode.  It also controls if the FTM_0 or FTM_1
+      FlexTimer Modules connect to GMAC_0.
+
   interrupts:
     maxItems: 1
 
@@ -74,6 +86,7 @@ examples:
         compatible = "nxp,s32g2-dwmac";
         reg = <0x0 0x4033c000 0x0 0x2000>, /* gmac IP */
               <0x0 0x4007c004 0x0 0x4>;    /* GMAC_0_CTRL_STS */
+        nxp,phy-sel = <&gpr 0x4>;
         interrupt-parent = <&gic>;
         interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-names = "macirq";
-- 
2.51.0


