Return-Path: <netdev+bounces-186739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AC2AA0C62
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6773B4E51
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55602C3768;
	Tue, 29 Apr 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3yTxivvD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45129DB61;
	Tue, 29 Apr 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931366; cv=none; b=ZIvGrGl6bPnW5osc9ELiVgPjLm5wYwdVPRcOBQw93UkbWbY/7GI+4u38SWQPCRjsIkf92Zr4bog/ZBQI23l6VW7ivq+V1/COi+0vmWn1YZvySyUXQ/D4JDfI2s7AluIr7yLV7xY3z1XdnZsqgmEvdZDIZEZUM9TUQahnLOcChMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931366; c=relaxed/simple;
	bh=95nSqHXxfSV43EZ23S1a/ydglRGvVqHZdlEbORmYdRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DrmFOCBbIncBEP7HxIS8Fb2pcOH/UGD6B458ISLUrBCgG+647XtMoD7HayOScWCMY6sde+iHZyxwjrbwBWWzr5M7jztddWseU5y/D5gwOBZ2ySWWJSq7JToEAqLf1LM+UzkiyCU1kKjgGWojkJniw0TaeyHB6XAbdKcx/gO8+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3yTxivvD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Sender:Reply-To:Subject:Date:Message-ID:
	To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YKQJHOsTK+gJkvmr2GdsF5P4iTyZjhwewd895DhBYOY=; b=3yTxivvDjrCoXtQppLCetJhH4P
	kib3CDU4SM3JOaZB9vOWlwxlDD4h9p2t3dHHR6Rzl+hNQI2yCSRUglm/D7/ofOj74KFlC4N0NHZky
	pGzk+w4JxleLlPO0txlzcb1XXTYpvPBx0/Kl9hJMt+R3HEa4Xge8E0w26TCaWTGkXEUE=;
Received: from c-68-46-73-62.hsd1.mn.comcast.net ([68.46.73.62] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9kV9-00AwCN-V1; Tue, 29 Apr 2025 14:55:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 29 Apr 2025 07:55:14 -0500
Subject: [PATCH net] dt-bindings: net: ethernet-controller: Add informative
 text about RGMII delays
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v6-15-rc3-net-rgmii-delays-v1-1-f52664945741@lunn.ch>
X-B4-Tracking: v=1; b=H4sIADHMEGgC/x3M3QpAQBBA4VfRXJta6295FbnY1mCKpVmJ5N1tL
 r86nQcCCVOANnlA6OTAm4/I0gTcbP1EyEM0aKVLVegGzwqzEsXl6OlAmVZmHGixd0BjlXJFbcx
 oa4iDXWjk6593EGvo3/cDo4vLhnEAAAA=
X-Change-ID: 20250429-v6-15-rc3-net-rgmii-delays-8a00c4788fa7
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6597; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=95nSqHXxfSV43EZ23S1a/ydglRGvVqHZdlEbORmYdRI=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBoEMxWXrFVKoBYfZGKzbYCIYu7Q/q6LlCXwBfe9
 muqUx0XQWKJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCaBDMVgAKCRDmvw3LpmlM
 hNT6EADJJ7ViHkKweou86QSf9UIpQnpsZ0cZm5YGFRBZyLzs9X3YJw41F4HLfx1G0Md5ONZnc5h
 lWfYgckEeyPhZdMrRACwCW5ofDtVA11/+LkI0jrLd/CnweNy5MKRft0BN3fVgAczgQgTehteSmi
 PmYRlqZ24TtmqW5k5UyYOkrdPDfNDiH6U3wTL1f1Mn8QrLKWakvRsLlI3m90gopgg6DtYRuChty
 pJ6j5BKXWwN/jdjhvN1HDGE4N283PM14mOXSC16VAD8WRzYeFPIyKw2zW3yxN834b+qnPB+z03u
 vfa6Ca+DAbpd+DH5u8vt2tHv6zj5ZPNt4d4jIl/Th1WLQvK1vwt2yIP8/mAaWWWAIk/OdnJZ3rw
 Vo03/iKoqsK1BOPiM2eFsZuWwX1vGCpnKOIr12pbh3VYor8e1DgJfvmIrqTn025cNrx1wHOkFMM
 IGaJnw8NgbIICJpO7zFdNLj8jHrRMRTnKapZbu/20npuAv/ucs0Dsr2yG2BCA4Wt0IB4VycWPkE
 C08WSCi3feYVHpt/Q51ZhXQ+cdotctbFfP3qKbIDWT1RmfyM1OlCyxzdKxOx6FC0Zln4xByVEoh
 BVqlMKhnqEXqgJ2WXdsoKOqKAuu5cYoXNm1bvosjbeqQZN3UKwp6LnuGpPT0a/t0axbRTK3jwWU
 lWCIGiZL/1YqTIA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Device Tree and Ethernet MAC driver writers often misunderstand RGMII
delays. Add an Informative section to the end of the binding
describing in detail what the four RGMII delays mean.

Additionally, when the MAC or PHY needs to add a delay, which is
software configuration, describe how Linux does this, in the hope of
reducing errors. Make it clear other users of device tree binding may
implement the software configuration in other ways while still
conforming to the binding.

Fixes: 9d3de3c58347 ("dt-bindings: net: Add YAML schemas for the generic Ethernet options")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../bindings/net/ethernet-controller.yaml          | 92 +++++++++++++++++++++-
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 45819b2358002bc75e876eddb4b2ca18017c04bd..4abaeeb1b4099525170fdac21d5540aa841b18ff 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -74,19 +74,19 @@ properties:
       - rev-rmii
       - moca
 
-      # RX and TX delays are added by the MAC when required
+      # RX and TX delays are added by the MAC when required. See below
       - rgmii
 
       # RGMII with internal RX and TX delays provided by the PHY,
-      # the MAC should not add the RX or TX delays in this case
+      # the MAC should not add the RX or TX delays in this case. See below
       - rgmii-id
 
       # RGMII with internal RX delay provided by the PHY, the MAC
-      # should not add an RX delay in this case
+      # should not add an RX delay in this case. See below
       - rgmii-rxid
 
       # RGMII with internal TX delay provided by the PHY, the MAC
-      # should not add an TX delay in this case
+      # should not add an TX delay in this case. See below
       - rgmii-txid
       - rtbi
       - smii
@@ -286,4 +286,88 @@ allOf:
 
 additionalProperties: true
 
+# Informative
+# ===========
+#
+# 'phy-modes' & 'phy-connection-type' properties 'rgmii', 'rgmii-id',
+# 'rgmii-rxid', and 'rgmii-txid' are frequently used wrongly by
+# developers. This informative section clarifies their usage.
+#
+# The RGMII specification requires a 2ns delay between the data and
+# clock signals on the RGMII bus. How this delay is implemented is not
+# specified.
+#
+# One option is to make the clock traces on the PCB longer than the
+# data traces. A sufficiently difference in length can provide the 2ns
+# delay. If both the RX and TX delays are implemented in this manor,
+# 'rgmii' should be used, so indicating the PCB adds the delays.
+#
+# If the PCB does not add these delays via extra long traces,
+# 'rgmii-id' should be used. Here, 'id' refers to 'internal delay',
+# where either the MAC or PHY adds the delay.
+#
+# If only one of the two delays are implemented via extra long clock
+# lines, either 'rgmii-rxid' or 'rgmii-txid' should be used,
+# indicating the MAC or PHY should implement one of the delays
+# internally, while the PCB implements the other delay.
+#
+# Device Tree describes hardware, and in this case, it describes the
+# PCB between the MAC and the PHY, if the PCB implements delays or
+# not.
+#
+# In practice, very few PCBs make use of extra long clock lines. Hence
+# any RGMII phy mode other than 'rgmii-id' is probably wrong, and is
+# unlikely to be accepted during review.
+#
+# When the PCB does not implement the delays, the MAC or PHY must.  As
+# such, this is software configuration, and so not described in Device
+# Tree.
+#
+# The following describes how Linux implements the configuration of
+# the MAC and PHY to add these delays when the PCB does not. As stated
+# above, developers often get this wrong, and the aim of this section
+# is reduce the frequency of these errors by Linux developers. Other
+# users of the Device Tree may implement it differently, and still be
+# consistent with both the normative and informative description
+# above.
+#
+# By default in Linux, the MAC is expected to read the 'phy-mode' from
+# Device Tree, not implement any delays, and pass the value to the
+# PHY. The PHY will then implement delays as specified by the
+# 'phy-mode'. The PHY should always be reconfigured to implement the
+# needed delays, replacing any setting performed by strapping or the
+# bootloader, etc.
+#
+# Experience to date is that all PHYs which implement RGMII also
+# implement the ability to add or not add the needed delays. Hence
+# this default is expected to work in all cases. Ignoring this default
+# is likely to be questioned by Reviews, and require a strong argument
+# to be accepted.
+#
+# There are a small number of cases where the MAC has hard coded
+# delays which cannot be disabled. The 'phy-mode' only describes the
+# PCB.  The inability to disable the delays in the MAC does not change
+# the meaning of 'phy-mode'. It does however mean that a 'phy-mode' of
+# 'rgmii' is now invalid, it cannot be supported, since both the PCB
+# and the MAC and PHY adding delays cannot result in a functional
+# link. Thus the MAC should report a fatal error for any modes which
+# cannot be supported. When the MAC implements the delay, it must
+# ensure that the PHY does not also implement the same delay. So it
+# must modify the phy-mode it passes to the PHY, removing the delay it
+# has added. Failure to remove the delay will result in a
+# non-functioning link.
+#
+# Sometimes there is a need to fine tune the delays. Often the MAC or
+# PHY can perform this fine tuning. In the MAC node, the Device Tree
+# properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps' should
+# be used to indicate fine tuning performed by the MAC. The values
+# expected here are small. A value of 2000ps, i.e 2ns, and a phy-mode
+# of 'rgmii' will not be accepted by Reviewers.
+#
+# If the PHY is to perform fine tuning, the properties
+# 'rx-internal-delay-ps' and 'tx-internal-delay-ps' in the PHY node
+# should be used. When the PHY is implementing delays, these
+# properties should have a value near to 2000ps. If the PCB is
+# implementing delays, a small value can be used to fine tune the
+# delay added by the PCB.
 ...

---
base-commit: d4cb1ecc22908ef46f2885ee2978a4f22e90f365
change-id: 20250429-v6-15-rc3-net-rgmii-delays-8a00c4788fa7

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


