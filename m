Return-Path: <netdev+bounces-254179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIpeEyDdeWnI0QEAu9opvQ
	(envelope-from <netdev+bounces-254179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:55:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E09F0DF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B031A3025915
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86D34D4FD;
	Wed, 28 Jan 2026 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJ5flX3t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93034CFBB
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594055; cv=none; b=KcMJAqkZCtLxUberduG6EQVygqo6hlNIGfdcd8QR7NTOtx1kVrqjrHWCiXP2vzZcHU+mFeS6BfSNEyGD4IZInB3HgmIPfWaT5J+t7V7cWiKOHqip0O1W/vKAabrYhpB2Qk9apnV/V/+PBrzJgwPx4OpVyGtFbfF27Ocbsi0RDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594055; c=relaxed/simple;
	bh=sDkMjLbL7aCDVYJJrKBs5NYrhqwGriqYfTTJkhobZGc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lSeJvVGpWqyATvAmGey5m9ga5t0iHcAESMkTs/GDhangEk5zWhO2FSMZU7mlDdw+JFogHbKK7HVGQFTk/8nXJYN095EkSLSjhkxwB8JTBxdWrONMvcT9fy5UaJLAbawqOfKYRsvfhGWjs1tly+TnQTUzrPNzaHUXZhqmKwR3D/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJ5flX3t; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so63867505e9.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 01:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769594052; x=1770198852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3m7FAnijbp9arjCJzyAV5hHlJTCfqdJrtfHXLh9EXis=;
        b=VJ5flX3t0W7Ptf0bVo5dH5+0u78jwXgWDmEcB/tc44Xuf6vZ5wo3J6rmDB0cGw0I54
         HLHvwn4DriG7TCApr/DSpJyr0rRVxIubeRPd53XA6LD9K7WYjh5H/KdOdiRb1mh12K0o
         Ql75C48N/5vCPQDMTS2lo5xhyFxUx6GX5Lfu3qGBW1Ttjo0LRPy8GYQLmWPjIfykauBz
         ZmttWkCjB28zM4k0EcoJSVOGtZbadX6r1LUtCIy67AOYJKxi6tB3kMm1k/vEnQzrcZl3
         SvjfgaJgPELWPosK6QKIyJ5cKT5vTrL/XpTn533nNJ8XHwCtB4UoOmIX3qdS8UERXrqa
         6IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594052; x=1770198852;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m7FAnijbp9arjCJzyAV5hHlJTCfqdJrtfHXLh9EXis=;
        b=emqkxQ8ttOypg3hmvzqTEhIQzQPynuhW5jBey8JsIsDdGMkool2YndqMsneMZZ6lhQ
         msEIdtT2hXNhTVnPcLkunPz1MCer1Ug5VBGb5X6ccoZ5x40WU5gA0Bv2vE3/U1tLimPG
         HkSXwc+4I5Wf7XlTdxTAN1NvRLCHdf5/RFm4ONjhtD5+3IJ7nBJDA4K9f6vBNq1QwoDr
         q1N67oR4VI9a4zQDDChQl5gWjcboIz8aVxFZsFo8Z0ZL4der10GxTinqI9ZANc7P2wrs
         DS6Zj4R4w5WwJQmyMkgCW2+gXAkrBV8Ky2mVFZl8qB/VW/942mZkMAQf90cOqfqlnPY6
         jXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDhLXceUJW9ise562FjlAgX1sYUrQIwQ7Kt5molvFeXl5Qa80TsYGe4JB0VCrkht+GL9AiT0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywipwg84jguSzeYTjiqSyXFXRcoF0lJI9sMEDTVq1DN/4ZdexZO
	qOSKaOL5vfKDUbsZUNojX5ATjILJSHq4KPaBMQmP6VvyxnjFvHBDVSJY//gPCzFxzTg=
X-Gm-Gg: AZuq6aKo70CAy+DpsR5/tJoOnPJ51U0etJKzfzIjzmXxgKadMpsdnk9aibEK9ajAa9O
	YFeIN/4bZW4BboxteNT97F/Dl2PBLBeL9eQ3kQqwyR97pwLkSxHGf3DLOBGW05eF8hwpOA/uZEj
	I9TpK0yuyg0DsUhI9BCvCKn4MgiP2b2h+m8qRv0GqOjf6y8UbKT1yxTCnRFk1Qo02IjNjL+sXmi
	WoCpeueNgwFp6S19JDYiDBHuYmmsgJWj7IzkcOiAfRLtbzmiTPAaYnT/OgrXfIm7Nb/5+ClNKT6
	8e6SP2q9H/x7CILLuXy0j330l9pOvaqNhDLfcnvGTp39voEsZDDNpIQ6G9TzXXmVU5qhDVoP0SS
	CPYs8dTm81mnRurclPr2mavTmX2mfgThxOTBwo4YgOkMWwkvmEhzP7JkmjNpYsubNAUwAJhc0cV
	v28eGfOcnZWS+3QQ0H
X-Received: by 2002:a05:600c:83ca:b0:480:4b59:932e with SMTP id 5b1f17b1804b1-48069c1c2e2mr57580235e9.11.1769594052081;
        Wed, 28 Jan 2026 01:54:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd77b8sm53423355e9.3.2026.01.28.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:54:11 -0800 (PST)
Date: Wed, 28 Jan 2026 12:54:08 +0300
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
Subject: [PATCH v5 2/3] dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
Message-ID: <939fdaf94038613486bdbba510a92a1e57e18c71.1769592679.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769592679.git.dan.carpenter@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254179-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A28E09F0DF
X-Rspamd-Action: no action

The S32 chipsets have a GPR region which has a miscellaneous registers
including the GMAC_0_CTRL_STS register.  Originally, this code accessed
that register in a sort of ad-hoc way, but it's cleaner to use a
syscon interface to access these registers.

We still need to maintain the old method of accessing the GMAC register
but using a syscon will let us access other registers more cleanly.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v5: Add Rob's R-b tag
v4: Fix the formatting issue Rob pointed out
v3: Better documentation about what GMAC_0_CTRL_STS register does.
v2: Add the vendor prefix to the phandle
    Fix the documentation

 .../devicetree/bindings/net/nxp,s32-dwmac.yaml      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
index 2b8b74c5feec..65633b10e49e 100644
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
+      FlexTimer Modules connect to GMAC_O.
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


