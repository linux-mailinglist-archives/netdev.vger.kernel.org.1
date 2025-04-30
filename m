Return-Path: <netdev+bounces-187122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E9AA518A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD79985DB5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F40525F980;
	Wed, 30 Apr 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EYAqFnbe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFFC2110;
	Wed, 30 Apr 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746030130; cv=none; b=PWnMQxsWhqE+pfuTfA6f4wIh29wYp5ewPc0ilcxF4qERgIEgPypDInHiFyJNAuqLPl/fMsdMLEmEbpRoMfTpSmBYUebE4+61ZjDeOahSptAhR9ruPq3Nl209VtZtpWNCJ7rZIEzfFT+FQTbbuMFGzFhZar/FSiZRqCOBCz1tQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746030130; c=relaxed/simple;
	bh=UFeOnbIz3T1QSHiDq7P4ewiS30rbMB8EppuUEFRXqDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NacLAojjdfOMocNtb2VW9btpbhlPbXF94uCmR6Qwx8k9208AmuWS3yIfJyq6i8wC39CWlNM4zmsJ0CsvhQ06ba5Jij+RaFV+yyLfbSEGKLVLahYhOUyKv3lsSlAFdSaWC7XJMDv61ddH53wityz4l7/3RxuzcGIxa8cj2n4FJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EYAqFnbe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Sender:Reply-To:Subject:Date:Message-ID:
	To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0d7WLnl504sekXp0Nz/5l4ROh+QwmTFgFcPUq5zV4qI=; b=EYAqFnbeHkkGbH8FLCZGX7i3DX
	uzB8Ml2z5AYNI/gq9ruDXmaWq0k4PyDEsGasyE32JxeHq32PTtKWc85aWIbChIZL6KTmBw0Hkt9Ed
	+0apX4ByU3Y8Hn9NQ4aKPO5O45HCGll0IYepNB3S0UQ2fToI6GPGmZY/Z0g69gbyP6NU=;
Received: from c-68-46-73-62.hsd1.mn.comcast.net ([68.46.73.62] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uAAC9-00BFer-4j; Wed, 30 Apr 2025 18:22:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 30 Apr 2025 11:21:35 -0500
Subject: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
X-B4-Tracking: v=1; b=H4sIAA5OEmgC/42NvQ7CMBCDX6W6mUNJSPrDBGJhZGBDHaI0bU8qK
 UpKRFX13Ql9AibLlv15gWA92QDHbAFvIwUaXTJil4HptessUpM8CCYUk6LCmCNX6M0BnZ3Qd08
 ibOyg54ClZszIoixbXUACvLxt6bPBH3A73y/XX5pmUCftKUyjn7fnyLfOPyeRI8dWiTyXlVSF5
 Kfh7dze9FCv6/oFKaGEtdAAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7503; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=UFeOnbIz3T1QSHiDq7P4ewiS30rbMB8EppuUEFRXqDU=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBoEk4jEH4v8AS3x/0G2P7cfPq+DLiZBaDC9S7zh
 J85vksdGjCJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCaBJOIwAKCRDmvw3LpmlM
 hHs8EACZEZqCep17D4HcXyIzV61vB1KzwbkAaHdUHIzD9D4tt+CfHzRWW3BVLeakOPp2M+c9BIt
 IGIxEJiTH9AaZFlr2LwPQdJW7NrtMAKp5kJwGSQnzLMuamCuw+Pe0KEL4IIFP48FpYmnlSZkraQ
 dakSD0qMi3sycQlGzaVanC3dWOSmng3vU6OnovGEJpP9uD5XRGdFLgYD2yoFM9WYhUenGruntaE
 YhSDWSZHmKxnOzlSc0aKcPc/1zTIgxSfARn1I5u4J5BsVMP1+8VEfLGCmo7C2Z0WOb9m6iTPzEQ
 v0SmmV/rWPFHVZUEIXTIv9LIsKEcNoOEvxCRWivTsC2ogBulVzOarLQ3XFeUiNVXzC7vKSxjSp7
 U4RfSP0R+CP+YqD8asTHcS1zoYPUwGxAQN/4sE/PcRYmH4mun86SbPFnjDBiyymOiWjDpUZxIyP
 eO8jx/1Avz0p4ls2HS/TMQq3gv2aocmPCJOOmwOsP9iayJzcNIWq2pQ5PcCp3nBuuVADZUSpeP9
 9G0XhD+KQpD0NByWQrckRSdyOTsestY+hsNdaLWw18yMi+KY9a45u3JzGZXtLvDdfL6bO78qgWd
 W+lPf6CRM5csQmjG5ScWgM6rRv5h7L6JBYruGzVsb4kDh3M/TwxC19x4fwjhHoJhhu+TwJ6m1SE
 Wpm81FT6xMwXvVw==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Device Tree and Ethernet MAC driver writers often misunderstand RGMII
delays. Rewrite the Normative section in terms of the PCB, is the PCB
adding the 2ns delay. This meaning was previous implied by the
definition, but often wrongly interpreted due to the ambiguous wording
and looking at the definition from the wrong perspective. The new
definition concentrates clearly on the hardware, and should be less
ambiguous.

Add an Informative section to the end of the binding describing in
detail what the four RGMII delays mean. This expands on just the PCB
meaning, adding in the implications for the MAC and PHY.

Additionally, when the MAC or PHY needs to add a delay, which is
software configuration, describe how Linux does this, in the hope of
reducing errors. Make it clear other users of device tree binding may
implement the software configuration in other ways while still
conforming to the binding.

Fixes: 9d3de3c58347 ("dt-bindings: net: Add YAML schemas for the generic Ethernet options")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v2:
Reword Normative section
manor->manner
add when using phylib/phylink
request details in the commit message and .dts comments
clarify PHY -internal-delay-ps values being depending on rgmii-X mode.
Link to v1: https://lore.kernel.org/r/20250429-v6-15-rc3-net-rgmii-delays-v1-1-f52664945741@lunn.ch
---
 .../bindings/net/ethernet-controller.yaml          | 97 ++++++++++++++++++++--
 1 file changed, 90 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 45819b2358002bc75e876eddb4b2ca18017c04bd..a2d4c626f659a57fc7dcd39301f322c28afed69d 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -74,19 +74,17 @@ properties:
       - rev-rmii
       - moca
 
-      # RX and TX delays are added by the MAC when required
+      # RX and TX delays are provided by the PCB. See below
       - rgmii
 
-      # RGMII with internal RX and TX delays provided by the PHY,
-      # the MAC should not add the RX or TX delays in this case
+      # RX and TX delays are not provided by the PCB. This is the most
+      # frequent case. See below
       - rgmii-id
 
-      # RGMII with internal RX delay provided by the PHY, the MAC
-      # should not add an RX delay in this case
+      # TX delay is provided by the PCB. See below
       - rgmii-rxid
 
-      # RGMII with internal TX delay provided by the PHY, the MAC
-      # should not add an TX delay in this case
+      # RX delay is provided by the PCB. See below
       - rgmii-txid
       - rtbi
       - smii
@@ -286,4 +284,89 @@ allOf:
 
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
+# delay. If both the RX and TX delays are implemented in this manner,
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
+# unlikely to be accepted during review without details provided in
+# the commit description and comments in the .dts file.
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
+# By default in Linux, when using phylib/phylink, the MAC is expected
+# to read the 'phy-mode' from Device Tree, not implement any delays,
+# and pass the value to the PHY. The PHY will then implement delays as
+# specified by the 'phy-mode'. The PHY should always be reconfigured
+# to implement the needed delays, replacing any setting performed by
+# strapping or the bootloader, etc.
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
+# should be used. When the PHY is implementing delays, e.g. 'rgmii-id'
+# these properties should have a value near to 2000ps. If the PCB is
+# implementing delays, e.g. 'rgmii', a small value can be used to fine
+# tune the delay added by the PCB.
 ...

---
base-commit: d4cb1ecc22908ef46f2885ee2978a4f22e90f365
change-id: 20250429-v6-15-rc3-net-rgmii-delays-8a00c4788fa7

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


