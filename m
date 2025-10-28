Return-Path: <netdev+bounces-233685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB0C1763E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D833A9C72
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB91D3563CC;
	Tue, 28 Oct 2025 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDdCQXRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D86286891
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694979; cv=none; b=rZTiT9cWmh5ezd4+lIoqkAUwehnR3yUCH3IsYDOHM4O2/0YfT/qA9n2Ec7wb4+SHaavwRt42ph3TDNAL/6NkOS7K6WFXNaKEZbH3y1FehN7ViaY62SB3WZ3j+2s+54kava8o4mQ+yHU0hOBLF2zJo/OdRPqLQlDNEGmQ2+noQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694979; c=relaxed/simple;
	bh=yf6La/yW+fAW9vXD7xqyZT4cnQekTq6yWJ+U87ek5aU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BowQi2DdBiMkDtS9BU+V+EurZQje3IfHDdEYAUbgm2TAF+c9CtrFyJyjr9PdOmhbJCR38zvQEGu9y6eQxO/M1rjxti8fCl0Kr6+FsBNYF4BtB0NYHMlce9FxBkApSnNtncRWCoMDvhTASiCsOr5//BycX/2ke/fO9aL0oLk4mV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDdCQXRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87C0C4CEE7;
	Tue, 28 Oct 2025 23:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761694979;
	bh=yf6La/yW+fAW9vXD7xqyZT4cnQekTq6yWJ+U87ek5aU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kDdCQXRqa1q+juk8aW57ol8x2a/4OlhvmYypN4PEefUdMp65mfzmqMwchQ20wagfq
	 5S2HWPiYLc7BMPhFBkuKpoTIGAp4bdpRtncHyUQb+ABiu4zav6/WxgEXrzVAuAVloW
	 Fc0nc4+EjLEr3eyZ1hv3yF1KfPoIQ24vo8LVKkJQwlrD5NVUTB6+NDnfwNYgPstmpE
	 F24HwJqZFjbLZUkXx40fVmaauBUnFhK2HGjSlJAMKhofod9Q4XH6CgJtxs87pofUDt
	 /177iltAlTicNcWjkgdPOjMWy7uaRUDpruZhwk1boJm8ndFh3/Y64gIMYyaSqZcIQb
	 FTeNdikC6e4ow==
Date: Tue, 28 Oct 2025 16:42:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 0/8] net: stmmac: hwif.c cleanups
Message-ID: <20251028164257.067bdbcd@kernel.org>
In-Reply-To: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
References: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 13:48:23 +0100 Russell King (Oracle) wrote:
> This series cleans up hwif.c:
> 
> - move the reading of the version information out of stmmac_hwif_init()
>   into its own function, stmmac_get_version(), storing the result in a
>   new struct.
> 
> - simplify stmmac_get_version().
> 
> - read the version register once, passing it to stmmac_get_id() and
>   stmmac_get_dev_id().
> 
> - move stmmac_get_id() and stmmac_get_dev_id() into
>   stmmac_get_version()
> 
> - define version register fields and use FIELD_GET() to decode
> 
> - start tackling the big loop in stmmac_hwif_init() - provide a
>   function, stmmac_hwif_find(), which looks up the hwif entry, thus
>   making a much smaller loop, which improves readability of this code.
> 
> - change the use of '^' to '!=' when comparing the dev_id, which is
>   what is really meant here.
> 
> - reorganise the test after calling stmmac_hwif_init() so that we
>   handle the error case in the indented code, and the success case
>   with no indent, which is the classical arrangement.

This one needs a respin (patch 6 vs your IRQ masking changes?).

