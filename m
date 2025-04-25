Return-Path: <netdev+bounces-186100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1A3A9D2DA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AAE9A7BB9
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 20:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330922068E;
	Fri, 25 Apr 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNlKRJt9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972535963;
	Fri, 25 Apr 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745612538; cv=none; b=IL0sNXwzLtGzx6+TYH/GGKP/FSJh5Fsuar25nhZUnafPdcWHOswkFgf0whM1RA9TrHeaar7nVx2/VG31SfvXKritKkm1XaG4dKvZyPU/dLlC01d8b8C3/MS1Sb1MobvDwKaPegp4jzLWgdRBUpSyTnra4ebC/TubFmbwprvmTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745612538; c=relaxed/simple;
	bh=wXqKgQLXu0pmPXFCcvDgT2+FyDTeHkeFZOaIw/uzcDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft8VZIHCmSbxUl6bwb4p8KCMCObqjwJQHcHXAhx8Hv8940zoX1qwo1qb5VbfRXxeYBYq2uQkBsQelErPGljM8kVkX2Lz6p82FWAbTmpP4teaYM4SBvMKBtK5ya3Sql85VSsjNuHTozECvdUVDCIGUbQpIgURoNK9PWWYv9YluSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNlKRJt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AAAC4CEE4;
	Fri, 25 Apr 2025 20:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745612538;
	bh=wXqKgQLXu0pmPXFCcvDgT2+FyDTeHkeFZOaIw/uzcDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNlKRJt9QDMv5Q7m2gOZrfWEgrlazWvRVs+TAkaxn5FoezSrGLFptoB7bBmtERprB
	 DGc6OzbOGH6IYtAnaqHOes5+v70QfIJUtdDJeO2esl6ZCB0bcUqeVLaTgMCmY8WOig
	 WeMD3yeRlrObFnfeP+bd1ViPelHcFf6slDAoNWptn2Y8XqN6jU7lmbjj3RGcaqu+PC
	 zRZWDVq/t6rST2Hs2ukbi1fpmbBhnz1mbiGWbliYOriMvdkC5VhVGaiTLlzUZH5yZO
	 KbCYrZfG3d0TzU5+UucmGwN/3wr0t5GREN1eVOd9dMheF92DgVWHHMLhaAcxCSAzRE
	 ZUwFh4XHrYpnQ==
Date: Fri, 25 Apr 2025 21:22:13 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: sync
 mtk_clks_source_name array
Message-ID: <20250425202213.GU3042781@horms.kernel.org>
References: <d075e706ff1cebc07f9ec666736d0b32782fd487.1745555321.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d075e706ff1cebc07f9ec666736d0b32782fd487.1745555321.git.daniel@makrotopia.org>

On Fri, Apr 25, 2025 at 05:29:53AM +0100, Daniel Golle wrote:
> When removing the clock bits for clocks which aren't used by the
> Ethernet driver their names should also have been removed from the
> mtk_clks_source_name array.
> 
> Remove them now as enum mtk_clks_map needs to match the
> mtk_clks_source_name array so the driver can make sure that all required
> clocks are present and correctly name missing clocks.
> 
> Fixes: 887b1d1adb2e ("net: ethernet: mtk_eth_soc: drop clocks unused by Ethernet driver")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Simon Horman <horms@kernel.org>


