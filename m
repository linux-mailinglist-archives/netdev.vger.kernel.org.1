Return-Path: <netdev+bounces-305323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dg2UOWS3TGpmogEAu9opvQ
	(envelope-from <netdev+bounces-305323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:23:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E42071906F
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:23:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=Us4Uf9yT;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305323-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305323-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5042F30162BA
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3BA3128CC;
	Tue,  7 Jul 2026 08:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE103126BF;
	Tue,  7 Jul 2026 08:21:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412500; cv=none; b=asdDlLeLmu9QPJqztSljPDa5AIRQfpKK/OzaV79Kbq5HQwX3tLx9i6lbibiJuJKagrXe/M4t5PNgkvFlXoccpzX5HkRxtTqLNKwRFUP5EwaqBoiDD3M77KtkBqqkspdxRamsz50WbHE3a/ogZtW6IEiyVrqUQosNXMDQNAp4XDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412500; c=relaxed/simple;
	bh=1dCg8pFc9XqfKgUTzqT+2O3mSfD/gWA0nsp+ocjIwUU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WPKlwFrfl4nFthJDRCnH28QYE46nsdubS4BL1DkIZce9HrTY3rtXP7LUJzRJGIj11XlV7bh2axkmlWoYBwIDspph2HW8zicn6ktHxsxa0OexEZMqq82mjdEljGNIq78U86jemf71h3zBldOFLYP1bfoKdVdPzoMGokqr3lkYIgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Us4Uf9yT; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783412494;
	bh=1dCg8pFc9XqfKgUTzqT+2O3mSfD/gWA0nsp+ocjIwUU=;
	h=From:Subject:Date:To:Cc:From;
	b=Us4Uf9yTiKcVl9JfEZkqFaSNyWi63G1uipwB5nA3fNX+oYiTM9JC5IowXgbkvmXAB
	 NG1bLgiEBUUQi/CZon5JujEsS+dwsR32GvH4G6KmXc/e9WwvJC6F4pkqfIuLdn1lKY
	 Asc5WU/uPTjddUkq+vTy/1QEhbnm4vpbskwB7cwR6hX7pnfsRLZGOB0jZb68NWsRlg
	 IxCT02c8T+WgadqZ9wwSghvWk7Ua/PcV5W6y5St5Xf/Uqdl7uG0padpVG+S/E8zY8j
	 wGgGROyP3+SxnzbqRBYhFS0DS0SPrRhPJPyzTADUNeKEBi6Wpu12Lq+4RIeDdtTp9Q
	 xad7J7XLd83Pw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A42917E05E8;
	Tue, 07 Jul 2026 10:21:33 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net-next 0/6] net/stmmac: Add Mediatek MT8189 support
Date: Tue, 07 Jul 2026 10:21:18 +0200
Message-Id: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ7CIBBFr9LM2klKiy30KqYLhEEnBqqA2qTp3
 SXq8uXlv79BpsSUYWo2SPTizEusIA4N2KuJF0J2laFru6Ed2x7dOxiLgRybQjcMRQmlUTvjqdd
 K6qOAur0n8rx+uyeIVDDSWmD+mUSPZz0qf302mdAuIXCZGjlK6/2gBiU6mPf9A80RGkahAAAA
X-Change-ID: 20260703-dwmac-mediatek-mt8189-9dafe3984951
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk, 
 kernel@collabora.com, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783412493; l=1609;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=1dCg8pFc9XqfKgUTzqT+2O3mSfD/gWA0nsp+ocjIwUU=;
 b=e+32C+4XJDUfsZQY8e2rwjSW7HdSP714dRnVts/EQlC0dhvkhtffDhKEGVIPwRCzuPu8Ve+DC
 lzuzHJT50qZAQRqt8QF2yvd4f/ZQ/ftgWzF4lmhl2XqGfqKuIhk/fiX
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305323-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:biao.huang@mediatek.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:kernel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:louisalexis.eyraud@collabora.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,foss.st.com];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E42071906F

This series adds the Ethernet support for Mediatek MT8189 SoC and its
variants (MT8371, MT8391). These SoC integrate a Gigabit Ethernet MAC
with RGMII/RMII/MII interface, with a similar design than previous SoCs
such MT8188 or MT8195.

This series is based on net-next tree (sha1: 474cff686812).
It has been tested on Mediatek Genio 520-EVK (MT8371) and 720-EVK
(MT8391) boards, integrating an Airoha AN8801R Ethernet PHY, with
hardware enablement series ([1]) and additional devicetrees patches
for enabling the Ethernet interface.

[1]: https://lore.kernel.org/linux-mediatek/20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com/

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
Louis-Alexis Eyraud (6):
      dt-bindings: net: mediatek-dwmac: add support for MT8189 SoC
      net: stmmac: mediatek: add PERI_ETH_CTRLx register offset in platform data
      net: stmmac: mediatek: rename MT2712 and MT8195 variant methods
      net: stmmac: mediatek: add support for TX clock output enable feature
      net: stmmac: mediatek: add support for TX deallocation adjustment feature
      net: stmmac: mediatek: add support for MT8189 SoC

 .../devicetree/bindings/net/mediatek-dwmac.yaml    |  77 ++++++++++-----
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 109 +++++++++++++++------
 2 files changed, 135 insertions(+), 51 deletions(-)
---
base-commit: 474cff6868129755cf889edf40d7f491729fc588
change-id: 20260703-dwmac-mediatek-mt8189-9dafe3984951

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


