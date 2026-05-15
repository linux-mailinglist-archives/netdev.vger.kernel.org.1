Return-Path: <netdev+bounces-288510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGiaMoKpB2pSBQMAu9opvQ
	(envelope-from <netdev+bounces-288510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:17:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E025594AD
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C1033020FDD
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A7E3F39E5;
	Fri, 15 May 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3az1tUy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1273A9628;
	Fri, 15 May 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887006; cv=none; b=H5bBKctDVzxw4HQSVqS9sQvkwLOFq017+qeCCMXmNiPEJoSHRUuAkvjMTVXMGmOY1jPG5zr+DIVrgnutN255eqHwh+NbViPt1tA++BzvlwMfkJkG5Zy2WNcIJGXJxtHu5zha+W6cZqbG8AK1wpTxLQPR+KdkDVUFK6WYijJBjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887006; c=relaxed/simple;
	bh=ZI6fKrmGoJUsCZdVQMq652fJqiGkQ9QqBRTNwO6ylUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZEkRN7ESsxQvVpFK4nSA8QCtPBtlB987rpqOCXPdznkEtGy0pIR3M2or2uM3RDfaxC2zJpLsLV7I9LQLktV9tiUNsylSxzRwqHN5jhZHE9pqLPPIPQZzGcsr541JlQjPeaPEtiK8Y+ux5wKgkS/hiwHnZKuDUkFK3SWrFDhkh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3az1tUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0E6C2BCFA;
	Fri, 15 May 2026 23:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778887005;
	bh=ZI6fKrmGoJUsCZdVQMq652fJqiGkQ9QqBRTNwO6ylUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q3az1tUywu3OOK+vqGa9lOF+mXcaWtj52TA6ONOQrh0FIl+WoHalOqq5NjuhzMD0U
	 UpgZbcAocCI4ASHvp+g8oLQM3fcERxWRI8xyGZnwmjOFh2trvTKiqqSRRmcKxHg4Yv
	 f5uFvuAMAR4hpNrXSI9g8Ue1XTxvJ86SfE68Ehkvniz82c+v+izPVUzGA0vmKxJ/ZZ
	 SdiFx5z0CC7Nmg59UfIFCf0YL/VmuoNVC+sQA7UQmG6CHd+enNGpl+vutCEvkbk6SZ
	 +zo0ZKS80RqUsdVTfmA+/H1MM4AP6C3aBVwW6NUya9BatnsxFNwkK1a9zWwwZL0b4l
	 pBHiJBberFi9g==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 16 May 2026 01:16:14 +0200
Subject: [PATCH 2/5] dt-bindings: net: dsa: microchip: Add KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-ks8995-to-ksz8-v1-2-70d0ef4aa5f4@kernel.org>
References: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
In-Reply-To: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 57E025594AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The KSZ8995XA is just like the KSZ8795 and KSZ8864 a Micrel
product. It was renamed from KS8995XA to KSZ8995XA at some point,
but it has the same properties as the KS8995XA.

Be careful to use the full product name in this new compatible:
there is also KSZ8995MA and KSZ8995E which are not compatible
with the KS8995XA.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 8d4a3a9a33fc..4ed13870ed3a 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -23,6 +23,7 @@ properties:
       - microchip,ksz8864  # 4-port version of KSZ8895 family switch
       - microchip,ksz8873
       - microchip,ksz8895  # 5-port version of KSZ8895 family switch
+      - microchip,ksz8995xa
       - microchip,ksz9477
       - microchip,ksz9897
       - microchip,ksz9896

-- 
2.54.0


