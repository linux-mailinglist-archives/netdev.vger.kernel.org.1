Return-Path: <netdev+bounces-232732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DDDC085F1
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D303ADFA1
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 00:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419B13FEE;
	Sat, 25 Oct 2025 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn65njhf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445E4A00;
	Sat, 25 Oct 2025 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761350858; cv=none; b=Q5ikcT9YtiD9nIcTRvpmwGzGQi+UaHFGiszdDhRouFYy1MuH17f6yIFr6yY6HDIuzaLSR0iGCY5Lzbo2dlopWoc4AYPqfg6bO+9W68C9St7+Usij05r6089cRzSitAkqTGPoL9jfF7VFrt9du23lt0w58M0D9OanBw0l6qlvHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761350858; c=relaxed/simple;
	bh=YywZU5wTB4nYHlRvn5ywrvSbODiPXFC1hF9SDgRtOvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoECeCQDusF4Uc8pkhSFdB1BsasttF1/mt8Jp+ZpDG4FXcdAvS42PIIkN2YdT+pXf3902EQ3DeIuX/GhTH0StE63zmZy/0p9R/koPLxOSXMb0PWspdrXZPi+Wy0xz2pbAXg6SQeb2ft7aLpCuoSQABXJ2QrA/qVsKYuxhFsxJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn65njhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0AAC4CEF1;
	Sat, 25 Oct 2025 00:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761350857;
	bh=YywZU5wTB4nYHlRvn5ywrvSbODiPXFC1hF9SDgRtOvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dn65njhfKU//nSpM/HdwU4tKL08l32hcuHzuixi+aBjD0gC0PTsaeWd89QTMAxRuk
	 cYp4Z2YrWrf6mPug22Pw8wBWAtFlLxcLTc5PHjUcAbZrgzYRFdAE4B5kBuLgdRaJ09
	 7V6O9idDND4QHFCif7dq/1igfsRQUwHEHRrzgJkkc1yml8VmhneBL/3j4U/ed2rxP+
	 z9yZau0MEnF3O8sico76jw2wQ7y1O54w8wvJ0AZmjB+HUtvaMqOS3Tc0MctblnfsL0
	 ObUnghY5cwYOW9jj4YRRlw7KmRIPHY+43lXpwvc+S7qRmpJIN6lu/pgmp1eDvdD303
	 4RrDLb4fd9xjw==
Date: Fri, 24 Oct 2025 17:07:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen
 <dinguyen@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Matthew Gerlach
 <matthew.gerlach@altera.com>, kernel@pengutronix.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Teoh Ji Sheng
 <ji.sheng.teoh@intel.com>, Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>,
 Austin Zhang <austin.zhang@intel.com>, "Tham, Mun Yew"
 <mun.yew.tham@intel.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 00/10] arm64: dts: socfpga: agilex5: enable network
 and add new board
Message-ID: <20251024170736.1098eccd@kernel.org>
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 13:49:52 +0200 Steffen Trumtrar wrote:
> Add an initial devicetree for a new board (Arrow AXE5-Eagle) and all
> needed patches to support the network on current mainline.
> 
> Currently only QSPI and network are functional as all other hardware
> currently lacks mainline support.

Please split out the drivers/net and bindings/net patches to a separate
series. As is this is unmergable to any single tree.

