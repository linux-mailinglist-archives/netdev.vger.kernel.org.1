Return-Path: <netdev+bounces-199463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A699AE063A
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47521BC42B7
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAAF226CE8;
	Thu, 19 Jun 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4MybcCJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A435963;
	Thu, 19 Jun 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337503; cv=none; b=KnKzuWC07KbvybMXHRwd9yAKuWIJs/L3Eo6XS0NH8A5q73xG47XSAZ4qBDWzCpXas3h2ttJ2OwShjcpsNGy8c0ttPd5G+2NsVx5s4LlnVXxtyueT1Ap9usc1tRy9pNZU7c4HiCEUxrn74+gj2ZoppT9Tf0BvWb2z2wAgvBeZgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337503; c=relaxed/simple;
	bh=jf4r8tgAjTvpdpKxRLoaxzrCAVbjkq3ldG/x5W5pyvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+oHal5KBe0PW+jsRE21WSI16C5pR8kXKjWhTadtshDEQ5jY6RFmuWd2iUII+NZpoqo/gGJkJy5MN91+q2eonskJQyItRo8M5sENeGm+6vG4fY6bAK+P4NY7m+tpPF72pCJMDRof0ybxyDOwPscKiNnmQ/KHJaCr2LsYUaqBLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4MybcCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FE2C4CEEA;
	Thu, 19 Jun 2025 12:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750337503;
	bh=jf4r8tgAjTvpdpKxRLoaxzrCAVbjkq3ldG/x5W5pyvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4MybcCJF1lABKI9a7riHG+6PTE0QcucL0hZ4M34wv7OTCvCZfZGuOo+kVnWC3cEO
	 U3FQisF755IPTJNMM7bMV4veMXVWtTvgRAH3xPcx5Rl9PAc7nFvKdUyS3L0//XKDK7
	 gwMj65vrO35mz3TYPzEQGtoYEdepRF/sHTm6eWTSBYDfh9zG99REXBoAc276RlFNPY
	 nyPZge73icoghlUhijZoJNNYxD3kQb1nyPjTImO8g3cmMD52koGLUiOI8EqZAeBg3k
	 DmHTzxu7+Wy7p0zbcPY36hQyfxL7swAY3+CARw3aGsRq8suXvvYGirKJKIJjshyKFD
	 D790cK1tdSZ5g==
Date: Thu, 19 Jun 2025 13:51:37 +0100
From: Simon Horman <horms@kernel.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: linux@fw-web.de, nbd@nbd.name, sean.wang@mediatek.com,
	lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org,
	arinc.unal@arinc9.com
Subject: Re: Re: [net-next v5 3/3] net: ethernet: mtk_eth_soc: skip first IRQ
 if not used
Message-ID: <20250619125137.GN1699@horms.kernel.org>
References: <20250618130717.75839-1-linux@fw-web.de>
 <20250618130717.75839-4-linux@fw-web.de>
 <20250619100309.GC1699@horms.kernel.org>
 <trinity-98eee496-129f-43c7-8d3f-4a77f4a183b9-1750329125336@trinity-msg-rest-gmx-gmx-live-b647dc579-9795v>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-98eee496-129f-43c7-8d3f-4a77f4a183b9-1750329125336@trinity-msg-rest-gmx-gmx-live-b647dc579-9795v>

On Thu, Jun 19, 2025 at 10:32:05AM +0000, Frank Wunderlich wrote:
> Hi Simon
> 
> > Gesendet: Donnerstag, 19. Juni 2025 um 12:03
> > Von: "Simon Horman" <horms@kernel.org>
> > Betreff: Re: [net-next v5 3/3] net: ethernet: mtk_eth_soc: skip first IRQ if not used
> >
> > On Wed, Jun 18, 2025 at 03:07:14PM +0200, Frank Wunderlich wrote:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > > 
> > > On SoCs without MTK_SHARED_INT capability (all except mt7621 and
> > > mt7628) platform_get_irq() is called for the first IRQ (eth->irq[0])
> > > but it is never used.
> > > Skip the first IRQ and reduce the IRQ-count to 2.
> > > 
> > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > > ---
> > > v5:
> > > - change commit title and description
> > > v4:
> > > - drop >2 condition as max is already 2 and drop the else continue
> > > - update comment to explain which IRQs are taken in legacy way
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> thank you very much
> 
> i guess RB is still valid with changes requested by Daniel?

Yes, thanks for asking.

