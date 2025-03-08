Return-Path: <netdev+bounces-173211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC2AA57E9B
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 22:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF333ACC62
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 21:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1381420B81E;
	Sat,  8 Mar 2025 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="LjPxU/J/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E00F1EFF86
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741469863; cv=none; b=OOaS1R9LHkTQFcVVpdO8N8NLfJcsEVBCrEtHE/GX5YpiA5hirB0hSxf9Rd1KI6H3OzjAhgPSFroRBq7886YXssNd6icIYEoRP3c20NW69RQZ3kL6sPDzk2L/GM/+deR/noO8riau5kCy8pDB0BRJ61m2zC/lkUBPD+cuiVdHiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741469863; c=relaxed/simple;
	bh=XtbwcuzqaHupMISwOBUvh4jYiBi/sk9Od6ym46D4uX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFKak+l8AzCLQYIt/IjsuksapR/RnRyfDe3dJIOqiOwFr6H8Cd3NoXAs0rc8+Iq4+qKVMnQELCZNf8gczsyNSSOSpVK8qaBxSHgzYRKBkA7AfLT2o2b2UoYrRFRYuLkoXAwn4oH9g+mU4kDsvTzNcrZuKsvJDadmA2peZ51k2rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=LjPxU/J/; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1741469860;
 bh=Og8w880XlSA9NZ+b1EwPhuTpUeEE3P898ptqmOlNFR8=;
 b=LjPxU/J/RzrKv9DbcBk+EGiNltDXE3Sq2JkOB7SMLeKiAD5iwZ5WSrJOK65YDWRzUtn4D0EXq
 kK8kM0t+dGhXTI1V5PssCozSU6qn6mnzD2mvU+q07amUW1v3MOEePqUUtk+M500kUVOqoK3ib0E
 Xesiv6+8i0jF3e/Hsyyx8PDVsCfoG28G3rdtmyDXfVy0usC2aY20qUoBQhIBgr1OXww5i6DH0RA
 cgx3hQ6pKaeb82aea+7Z2e2uxDCEHDSPZt9+CczkqKPDA2+DOxt+WYdoyCmfX8V1j1Qp1XuQXL1
 mt9jlYohDCJBmET8NGhwTIDIdRBpNGGTlnc8t3NKZmDg==
X-Forward-Email-ID: 67ccb897bfe70eb1bfc13af4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] net: stmmac: dwmac-rk: Validate GRF and peripheral GRF during probe
Date: Sat,  8 Mar 2025 21:37:12 +0000
Message-ID: <20250308213720.2517944-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Rockchip GMAC variants typically write to GRF regs to control e.g.
interface mode, speed and MAC rx/tx delay. Newer SoCs such as RK3576 and
RK3588 use a mix of GRF and peripheral GRF regs. These syscon regmaps is
located with help of a rockchip,grf and rockchip,php-grf phandle.

However, validating the rockchip,grf and rockchip,php-grf syscon regmap
is deferred until e.g. interface mode or speed is configured.

This series change to validate the GRF and peripheral GRF syscon regmap
at probe time to help simplify the SoC specific operations.

This should not introduce any backward compatibility issues as all
GMAC nodes have been added together with a rockchip,grf phandle (and
rockchip,php-grf where required) in their initial commit.

Changes in v2:
- Split removal of the IS_ERR() check in each SoC specific operation to
  a separate patch
- Disable rockchip,php-grf in schema for GMAC not requiring it
- Add a php_grf_required flag to indicate when peripheral GRF is
  required
- Only lookup rockchip,php-grf phandle when php_grf_required is true
- Use ERR_CAST() instead of ERR_PTR()

Jonas Karlman (3):
  dt-bindings: net: rockchip-dwmac: Require rockchip,grf and
    rockchip,php-grf
  net: stmmac: dwmac-rk: Validate GRF and peripheral GRF during probe
  net: stmmac: dwmac-rk: Remove unneeded GRF and peripheral GRF checks

 .../bindings/net/rockchip-dwmac.yaml          |  21 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 270 ++----------------
 2 files changed, 37 insertions(+), 254 deletions(-)

-- 
2.48.1


