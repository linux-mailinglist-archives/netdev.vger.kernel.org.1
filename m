Return-Path: <netdev+bounces-121402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E495CFD0
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF282B26B4A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02495189501;
	Fri, 23 Aug 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="j16wgxcS"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041F16B391;
	Fri, 23 Aug 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422354; cv=pass; b=LO4oZdeQOez6mc8ebMF/5o5DFMn1GiwdQTbCASHvIUCtzhDKdWJDsvVcwP2xXRgDnNZWS4+0JPOP6fQSygZ+opj73bLAtvyemR1txqll01l1JWNLjxMnZO4dATVdWw5+PDsVNSXb+xfn4IJFGiIbndB1PeW/v7vL1htjCcmRwwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422354; c=relaxed/simple;
	bh=SeCRgX61JmozfhfSQUkYku6wrmQzGTNTLZ8b8QvcxX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6xE4UC4rnNvaIQHg6Mp7+WxkKnQtIWh5TPgG8AOJGd/4N9edKeRGo4bmW96ahqO9KBOcTDOPIhw6Xk3uAiJs7fauS2RCVkCwSCX7UC8z2JBH+eZ2aO+0KW7EvWzhAL1EG/W3I+Xws+mR2vTa1aPtwmP9qXoj1wLIbObQKweDKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=j16wgxcS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724422312; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CrToZ2LTI//Gtte2hJPQcZ5QDN3uDirJqmj6R94r4N99Rbo4pAcHJ6JNdarmMzkEBpZSaLOFNlq/oDGKAg5gN+qfHGE6GEM+YUFWn8xcca65Cf2glLacy4w6ntuR8tof5ZtEPftnF+E8nrsAQUdmGRdd+eP3plHpLgnxRUEk7I8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724422312; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lNp4RfIxi4nUXP7c0Aub3ROaeoojv7EDzsSfORBjjkE=; 
	b=kbuhsOTJ3xVK/tDGbTBlwkX0UY7Mpu8vkInysRClwom94FqXCu4HH10B1eLl66Zmfa5q3S3FD1evCvg+7Al53IfPtVT0FmikSPANKwRaMHDKdxBik8YMuPwYhwxEC66EgheFyBIeV7B7CcsIFEo/bEPGFCdQTf53XjmGnIxqDB8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724422312;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lNp4RfIxi4nUXP7c0Aub3ROaeoojv7EDzsSfORBjjkE=;
	b=j16wgxcSJxUO1zGqi/UroUioB6/Ww52ql5liESPdnZOVqwk/aSTsYxSFeoCFmyXz
	uN0O/2Ecu09IUH3arc/q0HKIHzbK3g3bVe7mXFdhPF9TH4cpaFsp0+UJprejLqRdEBH
	oMXB7agPk6YwuXuePWrRV2JFeGJQWCfBWWnMVAbo=
Received: by mx.zohomail.com with SMTPS id 1724422310105193.1328447504353;
	Fri, 23 Aug 2024 07:11:50 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	David Wu <david.wu@rock-chips.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 0/3] Add GMAC support for rk3576
Date: Fri, 23 Aug 2024 10:11:12 -0400
Message-ID: <20240823141318.51201-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add the necessary constants and functions to support the GMAC devices on
the rk3576.

Changes since v2:
- Fix typos in RK3576_GMAC_CLK_SELET_*
- Also fix typo for RK3588_GMAC_CLK_SELET_*

Changes since v1:
- Add binding in net/snps,dwmac.yaml too

Detlev.

David Wu (1):
  ethernet: stmmac: dwmac-rk: Add GMAC support for RK3576

Detlev Casanova (2):
  ethernet: stmmac: dwmac-rk: Fix typo for RK3588 code
  dt-bindings: net: Add support for rk3576 dwmac

 .../bindings/net/rockchip-dwmac.yaml          |   2 +
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 164 +++++++++++++++++-
 3 files changed, 163 insertions(+), 4 deletions(-)

-- 
2.46.0


