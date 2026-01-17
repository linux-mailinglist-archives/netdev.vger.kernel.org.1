Return-Path: <netdev+bounces-250722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14535D3900E
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 18:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6C4A300F884
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326452874FF;
	Sat, 17 Jan 2026 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+3iD9c2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC1274B51;
	Sat, 17 Jan 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768670871; cv=none; b=IuEcEdzpfQoNkFMwWFBWK8LajUip/B/Talj66xeL/OxlRyEQDxSNr3/BU9/S5Ye3O4pa3iuHY9qUukj/oG6Ql6EKUT+34UFQ77XhZQIShfMGw7UZDZvoS+LvefIhMaYvOwyxp+4hpFq5OKypGiG5awHcYDc1o94ABWw2eCLU/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768670871; c=relaxed/simple;
	bh=++XfjfVbehtvX+zItNtLRdUZNU19QrZhA/cVj+pJQsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ma4IxlvDxgVbJQXnxcTylSVRD62llrD9iW88R0Iw7CV2Bwzowlynrje2XUCfoLdiYB2LrsnlhMMcIWVxzr405Bw0t29qSWV/umUlrg6htihKcUjOr2gkQ+3j1JRLLz/ioKt43jbK071XSEbrrqZfdg62BmogNdSTx1HnHAy+qwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+3iD9c2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A34AC4CEF7;
	Sat, 17 Jan 2026 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768670870;
	bh=++XfjfVbehtvX+zItNtLRdUZNU19QrZhA/cVj+pJQsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h+3iD9c2PGGLIXDkm1POypnGhpKpQcUChPeMaFmpAw8fxoT2RVVSdr0We+wefLP3F
	 ogcqdnQeA4DRfgxXj8J+4rD277A8gDTObFX+8hOlfGCFnZKVnmgdSchK7eKORbvne/
	 VUKo69xpbfYwP/IRbgUh5NfHpbnDbvaPq++zGKg0gIMx5bu0MiYrA8DEDkayIBTCdH
	 wJgPuzTYN9wPzJPXqvBtNg6T3Jv7JXNI/lQ47wsj5rNNKOTenT7WGeHWbMSMw+WNAi
	 5KxWlqcXeL0P6rIm+N9UNMQe7QCSxWMUY6CkbkQChmIDWbculQaa+eAinSj60+SgmM
	 Xpew9Hb6NKi2Q==
Date: Sat, 17 Jan 2026 09:27:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chester Lin <chester62515@gmail.com>, Frank Li <Frank.li@nxp.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Ghennadi
 Procopciuc <ghennadi.procopciuc@oss.nxp.com>, imx@lists.linux.dev, Jan
 Petrous <jan.petrous@oss.nxp.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Matthias Brugger <mbrugger@suse.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, NXP S32 Linux Team
 <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 linaro-s32@linaro.org
Subject: Re: [PATCH v3 0/3] s32g: Use a syscon for GPR
Message-ID: <20260117092748.672bc961@kernel.org>
In-Reply-To: <cover.1768311583.git.dan.carpenter@linaro.org>
References: <cover.1768311583.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 17:13:23 +0300 Dan Carpenter wrote:
> Dan Carpenter (3):
>   net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
>   dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
>   dts: s32g: Add GPR syscon region

For v4 could you CC netdev on all 3? Even tho we won't apply patch 3 
if patchwork sees just a subset of the series it won't kick off our CI.

