Return-Path: <netdev+bounces-117138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98FB94CD35
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E081C213C8
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B9A1922DA;
	Fri,  9 Aug 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="JpIqDZqX"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE016C87C;
	Fri,  9 Aug 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195136; cv=none; b=qQ2ytS42htH0+5nhB1NZLflCQOnguXaIVT07ZwDu/Lj12di2b81IAGsixp9T026zxJsjjO8bFmy0MfkRgNqkOKR6ELyaopfRZlz2CAlEiAwHIE2CZubVYN1ggtp7qSyVY0ml5+akOeUxFg7t/f7GC1axbeg/w5lMAAPp6NJ90yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195136; c=relaxed/simple;
	bh=Iurit3RB6U6Jt5tLhwlj0CKfYP8cL3XtA4dsOC4jPMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9RTRrh8Qbd82yyJzC40DSyiOXpPskrevtrN2QlS/TU1VNz2pMHAimb2OH9xIxZ0LNpxZqIn7vcDGt4RacsWKhJ4StZyp4HqL8ex51wzWFPtFZKWdeH+RIi4JvVg0SutMPDkCYKSyU4H39o1iGm56AtcL418DZCoP0korp/VvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=JpIqDZqX; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C11C42123B;
	Fri,  9 Aug 2024 11:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723195129;
	bh=jeOAWrYg7aFi7Y/vZPKPruXm2NagQZFHxCWeBakzMtg=; h=From:To:Subject;
	b=JpIqDZqXrWOcHOgh6BuI53Q+BGDc3UZqBrKxKch3lhtYKTOtZbIdYEs2SoZ+donrZ
	 4zAJ+Lavcf/+02/HsEVRvztX9xqJC+VfFAAOUkl7vNM5rvHUc1sxJojRvPyi6LldwO
	 EOVipa2wJrADLDmtcy3/V7Kuyywtt4sGR1zQVYyWuwCzwFHSuKA7dbpl7jB3DwXi4Y
	 69DYE+FOJbUeQdFlAFIPmD570g8gh+b4OVi3S5ajhDSQQkf1pWyLdKngpQ3M3o/6my
	 /+I+X7fg+MFbJnJZxHFTMD+/spAMi5vza1rFmBQyVV3VQU+FJoyGiap9YDSjhXXsmS
	 yYVDpobHUYeQw==
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
Subject: [PATCH v2 0/3] net: fec: add PPS channel configuration
Date: Fri,  9 Aug 2024 11:18:41 +0200
Message-Id: <20240809091844.387824-1-francesco@dolcini.it>
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


