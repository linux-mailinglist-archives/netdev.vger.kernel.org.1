Return-Path: <netdev+bounces-174548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312DCA5F20B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976953A6CD5
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB0265CD5;
	Thu, 13 Mar 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFpakx8q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E971E8325;
	Thu, 13 Mar 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864197; cv=none; b=Fup8I/DzyoszZH7U8rN5qTp4orubCwV3I5h2a4nj8gWLC+hH4LoQC+pICBGq/63cVgDQdXVmAF3x3n6DXO24y+vHSHC9g2i7CEXZjAEuJGlX/QGgC6uaJfv0TezMXS0haF9emUoxsviZBd00isblx3i3LN5byVH5rPLzNK6HZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864197; c=relaxed/simple;
	bh=y5Rt/A3I0puk2tWJqwdD+VS9AYs8xTcIZQZ75uLi/aQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ak3AvlsujpbijMrwkx+O0KoHYJufdLd7x4RCTmpJlurlFyLclg3H3KzjFOil0vputju417HmDXnO9Vdh8OLKbNj2SZhDFgi9CBp+ivLKJUhEC3XArFPwB1kNbEJS5xes7IuRZa7TFxKpNDBJ0mMUviPrTYST2yo/nGPRwRustrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFpakx8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B53C4CEDD;
	Thu, 13 Mar 2025 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741864196;
	bh=y5Rt/A3I0puk2tWJqwdD+VS9AYs8xTcIZQZ75uLi/aQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OFpakx8qWuEP5hs9WCekvz25n4fnw63dd3zf1Hsha7Gk7+1cmshaz6E6oE8d6Ieh+
	 tBzkhdDKSaYH1OgAoNK+7jfD0fdJN4xQ1W2eZZQZ9HelvNaxoDzMiG4MttBJXWwp8t
	 OYQ48FdLg1Aw9IqOqJEj0BBUa8qX6V/9YjFqw9jvVKWW22JNwRMHhG8JnhrlhbaW6S
	 29uLDOm+zyzCye6P/FtsnHmuM8tJKNGUgYdVxO1sAeEi7yoQhyS/YRufPMcwDeeXtg
	 ax/RpzUJ7Toj8NLazkxeVIel3BUqwjK+RCDn16ltaxBF+hnLwAAfRjkh+iPS9k7Pz+
	 SWDFtToOpr/aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6693806651;
	Thu, 13 Mar 2025 11:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: Define interrupt constraints for
 DWMAC vendor bindings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174186423076.1466791.15724461347771862891.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 11:10:30 +0000
References: <20250309003301.1152228-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250309003301.1152228-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, heiko@sntech.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, nobuhiro1.iwamatsu@toshiba.co.jp,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 vineetha.g.jaya.kumaran@intel.com, biao.huang@mediatek.com,
 xiaoning.wang@nxp.com, linux-imx@nxp.com, david.wu@rock-chips.com,
 christophe.roullier@foss.st.com, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-mediatek@lists.infradead.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  9 Mar 2025 00:33:01 +0000 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The `snps,dwmac.yaml` binding currently sets `maxItems: 3` for the
> `interrupts` and `interrupt-names` properties, but vendor bindings
> selecting `snps,dwmac.yaml` do not impose these limits.
> 
> Define constraints for `interrupts` and `interrupt-names` properties in
> various DWMAC vendor bindings to ensure proper validation and consistency.
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: Define interrupt constraints for DWMAC vendor bindings
    https://git.kernel.org/netdev/net-next/c/5a1dddd29444

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



