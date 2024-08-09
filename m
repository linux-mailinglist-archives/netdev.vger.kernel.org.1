Return-Path: <netdev+bounces-117144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D73E94CDDB
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802241C22046
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762719E7F5;
	Fri,  9 Aug 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="R7NN4EqN"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64FA19DFAB;
	Fri,  9 Aug 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196892; cv=none; b=WlPYG01xw1uxtuZXCfE3jnSiILMy/uNA4qP7JjwC0KDf1H77nTixPyFojRBv60ZVOZJoVzk1rEfP4g7obxHFEqWnYJqNLb5QQ3YHCF5l08WNnca1y/HidKvE2QraJSM+sDlYK9ANCD570td+7+94UuNX128Z1LX0OnwqZ/hD0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196892; c=relaxed/simple;
	bh=uh6uFWyNmasNfPLGK8ArmG30O++3FMJ+4nCjlFuMvEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pju7q5ZN5b6voVkfCjskiqYhiI/oBthirQT2w/F6zGY7pkzxMpPGgky50kKqQGvrbH6TRK6opQ6bYX7KHMDztAqqR1f2WS91rVgD0POONX/mryIAShJu39OrvoZDvrNvZhiIvnTbUvyMibMeJZ/7lBqLE7jY5Cyk7by8ORs/QuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=R7NN4EqN; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 35CE42222A;
	Fri,  9 Aug 2024 11:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723196889;
	bh=0RTNAZMPTQo7Iajey5tnC1QQ83FapbsZWYcXMRrN5ig=; h=From:To:Subject;
	b=R7NN4EqN60qttA5Fb1af4LxuV8tX6nx1SPCojMRpqMtgB6nbK4KCi7nf2BdqySD5b
	 MqjbXAzu6FvToQu5I3lBAMJw+BvkDn7QpF8oMVuLe6B5Pe2A9MrRWu394KLyeYrZ0j
	 1qNpNM/BeqPCfSWS4P4roVWmue6PHTTeIn4FXyMbcNGTuYpdg97//60kSmsGuK9Wyk
	 lwqTE9b8lqN4LWZcJ4lqmnCikWZRn0lZG1bmLmR5Z4r6PFdZILzqK8dH1NnjF5E2R9
	 cfx+4GDQcTT3/9YIM5jeDonOZmCllusl6o9u5V2jxeh/BF02P6Tcype+pwNbMKx8Cg
	 GibhG1DoQzw/w==
From: Francesco Dolcini <francesco@dolcini.it>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Linux Team <linux-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 0/3] net: fec: add PPS channel configuration
Date: Fri,  9 Aug 2024 11:48:01 +0200
Message-Id: <20240809094804.391441-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Make the FEC Ethernet PPS channel configurable from device tree.

v3 to just add the missing "net-next" subject prefix, sorry about the spam, it
seems like friday morning plus the mid of august heat wave is badly affecting
myself ...

v2: https://lore.kernel.org/all/20240809091844.387824-1-francesco@dolcini.it/
v1: https://lore.kernel.org/all/20240807144349.297342-1-francesco@dolcini.it/

Francesco Dolcini (3):
  dt-bindings: net: fec: add pps channel property
  net: fec: refactor PPS channel configuration
  net: fec: make PPS channel configurable

 Documentation/devicetree/bindings/net/fsl,fec.yaml |  7 +++++++
 drivers/net/ethernet/freescale/fec_ptp.c           | 11 ++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.39.2


