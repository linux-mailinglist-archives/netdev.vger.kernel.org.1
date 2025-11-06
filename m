Return-Path: <netdev+bounces-236122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6480C38AE5
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E041890170
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A5A19EED3;
	Thu,  6 Nov 2025 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK+J64KV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B06BA45
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391930; cv=none; b=UvMdOcNnAPPS+G55Z9A0WkqypAlS5vaccbhGRhcRE5/ouyDx0Fd7eZjaA06eGtotMuninlHKSTGSifXb22PPBJdtknV6TxCqDatX3h5DuiNIaX7uDOXOUQJUBAYDsulKpN66XneOuhyE9106c9Il+7UMTv4tStCUum/yVz9wG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391930; c=relaxed/simple;
	bh=7t9OsvQMT3GaIT7WtbZ9AfqGl0859XgGoz1qrHm8cIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jspGY1+tfG0U6f9BCWfw+Fy7rEM4YzngRivySeW+OaL087oJScPtkvV0O82fB47hK4Y1JP8AIVcMjQPGcnyVci2p7rihmqecHR6kRj3fHrJxSmpur91VF+zG7KCoBXrxuL4vmw/hT0JEKuYOLCLcJN8xS2VWgGBqE7y3du6xZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK+J64KV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBBAC4CEF5;
	Thu,  6 Nov 2025 01:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762391929;
	bh=7t9OsvQMT3GaIT7WtbZ9AfqGl0859XgGoz1qrHm8cIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fK+J64KVtoqMUiia8DqYAj3mLb2EbeTVQJDLNET7uSXx6xkJNbVlqhgBSgS/+esmH
	 osqooD18fN/tusq3rzwdigzwNxx3K/MReAVBadPmPAXV0bUEviLLFat45a2GTiwG2u
	 47nNca+FpVQG/RslwUlJneevwJGkiMhH1F8z2PXBQGw5nwGulQtJZ9dkhn9TIaapIj
	 9QNVgkYqAivr2ymBGor2DjZFofAAG3LG0HtCQ5SfxGfNBd2glLNFnng/E/e4n6owDc
	 mlmRLGn58XHMcAxX93bSc+rYeIM9oJd7IJxN0LLrwmraEYlnE2Gxh3AxwfnAI8qsZ2
	 7QA5lyNghsK4g==
Date: Wed, 5 Nov 2025 17:18:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 09/11] net: stmmac: ingenic: simplify x2000
 mac_set_mode()
Message-ID: <20251105171848.550f625a@kernel.org>
In-Reply-To: <E1vGdXJ-0000000CloA-3yVc@rmk-PC.armlinux.org.uk>
References: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
	<E1vGdXJ-0000000CloA-3yVc@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Nov 2025 13:26:53 +0000 Russell King (Oracle) wrote:
> As per the previous commit, we have validated that the phy_intf_sel
> value is one that is permissible for this SoC, so there is no need to
> handle invalid PHY interface modes. We can also apply the other
> configuration based upon the phy_intf_sel value rather than the
> PHY interface mode.

clang sayeth:

drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c:128:13: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
  128 |         } else if (phy_intf_sel == PHY_INTF_SEL_RGMII) {
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c:142:2: note: uninitialized use occurs here
  142 |         val |= FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
      |         ^~~
drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c:128:9: note: remove the 'if' if its condition is always true
  128 |         } else if (phy_intf_sel == PHY_INTF_SEL_RGMII) {
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c:123:18: note: initialize the variable 'val' to silence this warning
  123 |         unsigned int val;
      |                         ^
      |                          = 0
-- 
pw-bot: cr

