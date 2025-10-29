Return-Path: <netdev+bounces-233708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8242C177B2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C5E1C8090B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3AF1BCA1C;
	Wed, 29 Oct 2025 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn4kwfwO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488332AD20
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696635; cv=none; b=odvsiks9+RBJLR57BgadtL5J2D3gSA30iS7wpSUKcCHACpBOnijm0emuDIaNV+kWymNh2L3zROfxTIyhqSCgmLCV7ra7CDEydvNu8YzxDB5VOISB8XbRbmQycjg8FE5UMU4mNSY9uxK4IrnKMD1QFiwxwQbH1GM9rMXNJIbBXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696635; c=relaxed/simple;
	bh=fWgybk4zJ8v4uHqTzhcQSKCfyRk/m+NFcuLw6/SBDzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkXFMmVZ0meHufGCgdh/gNGg/skiOQbprVi8mDBWnxmfnREuKzu3TjVk2vusxRw8Lz9CONT5uZZxBe4475nZIPKQbq4hODedajqfyhXIe8oo5EvPxGgJqztByq02IS69XXfCk+NXIxj8Hi/gxNRYbDu4BFJ0b2x/8Y1ER0jUrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn4kwfwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4AFC4CEE7;
	Wed, 29 Oct 2025 00:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761696634;
	bh=fWgybk4zJ8v4uHqTzhcQSKCfyRk/m+NFcuLw6/SBDzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zn4kwfwOegS/wt629E7r632Ghchk7SkSaKzoVi1YnCYk5rAH7oe/FBdM6821dOQNb
	 LxlB0YKKva0KpERflFyEiCVobvKbcUoS9FLzTzFFHVt/rKuhWuVdCTpyKWCMtPOu/K
	 SuABN8f5i/32fGANHjargfgjvpLSLLFZP2+f6Zki5YZ8Ks/JqsYRFBBPkwUMUSBpUF
	 uD396HYImedHwG3FC7MjQjs+DvWPk9KLbnn9BChud1S8EXO5icOTSfdZlWbwiTU1EU
	 Q5GG7HQPCNuYcJvJJlNyTORq25lJU7Dao3ne591kyt68s7dACakMq53gyk9kUlcC+E
	 LeRdbWgc4Ebzg==
Date: Tue, 28 Oct 2025 17:10:33 -0700
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
Message-ID: <20251028171033.0a9a5a63@kernel.org>
In-Reply-To: <aQFYdRZV9CQVuqFu@shell.armlinux.org.uk>
References: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
	<20251028164257.067bdbcd@kernel.org>
	<aQFYdRZV9CQVuqFu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 23:57:41 +0000 Russell King (Oracle) wrote:
> > This one needs a respin (patch 6 vs your IRQ masking changes?).  
> 
> Ah, I see it, rebase can cope with that, but not application. Bah.
> Another week of waiting for it to be applied. :(
> 
> I'm going to start sending larger patch series...

I could have told you earlier, too. I assumed it's conflicting with
Maxime's patches and I didn't get to those yesterday :(

