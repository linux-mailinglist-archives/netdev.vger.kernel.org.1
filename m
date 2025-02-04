Return-Path: <netdev+bounces-162440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5D9A26E9D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D83A3A3E83
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB525207DE7;
	Tue,  4 Feb 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSzGONQP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456319C54B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661863; cv=none; b=eLZg1pOliTwFDmvNZ78E/YY3ibZM03aghwq9PRKjO1OATinb0ZzsOGviwvf9RV+7n8879gH7PDLc80ifwECMlDWHGinmxpKAQ66r8leeR0Qt0wqSrZZy1Zc8RDDi7qcvZWGXMRIL9jo5muzQFMLUdZygc3RVLHhtn/p9b6ENU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661863; c=relaxed/simple;
	bh=8zNbwK1vwrzQD6jDobFuih98R5+ZquvpF5oBG92Z+24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FISRx/JOKu0LcLlaHja9aNKt/pmo82QHRKw+YWSGX9470diseB/sU0eUsE37xjMlvu85yNwTknsQ1fMO449QkTLPoarvp8F7ukYL/Gir4TJz2Cmi93K84s2wnZIz+pVbpGH84GPKd4DDk+ViwdFme6fYZ/iE3TCCR8rHXX0M0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSzGONQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF37C4CEE3;
	Tue,  4 Feb 2025 09:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738661863;
	bh=8zNbwK1vwrzQD6jDobFuih98R5+ZquvpF5oBG92Z+24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSzGONQPON9ujaWdcVR0Co2VjZ2lqp7b+YBMD0S/toitLDiZlZ/tGlnfBWPxDtbM+
	 n+uoe7PqRnDwJkIEoG1daWL/h/isRkaO3BbAWspcNtFDxE56KRKo5b0IC7vV7y5ZRB
	 ATGu02AWq32c9vG0Ls4Zmq17wL8R4UN05zGrhF4yV0PdY1r2HFXMTXYXY06fnBJ5yH
	 shOEk2SHYK95vHdw/FBQM8Z4bCe5LK/MWaNx24s/biRZqEi6gRbc9VPEteGpVoxDjE
	 s9fojtK/AQOqLPiIuscI6X7D5mAOBW2R7n/2vTh18q0wPUNxXRp9AQhAcC6N5PdNHA
	 OO3Y99tei+x6Q==
Date: Tue, 4 Feb 2025 09:37:37 +0000
From: Simon Horman <horms@kernel.org>
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name,
	sean.wang@mediatek.com, upstream@airoha.com
Subject: Re: Move airoha in a dedicated folder
Message-ID: <20250204093737.GL234677@kernel.org>
References: <Z54XRR9DE7MIc0Sk@lore-desk>
 <20250201155009.GA211663@kernel.org>
 <CA+_ehUwFTa2VvfqeTPyedFDWBHj3PeUem=ASMrrh1h3++yLc_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+_ehUwFTa2VvfqeTPyedFDWBHj3PeUem=ASMrrh1h3++yLc_A@mail.gmail.com>

On Sun, Feb 02, 2025 at 04:50:33PM +0100, Christian Marangi (Ansuel) wrote:
> Il giorno sab 1 feb 2025 alle ore 16:50 Simon Horman
> <horms@kernel.org> ha scritto:
> >
> > On Sat, Feb 01, 2025 at 01:44:53PM +0100, Lorenzo Bianconi wrote:
> > > Hi all,
> > >
> > > Since more features are on the way for airoha_eth driver (support for flowtable
> > > hw offloading, 10g phy support, ..), I was wondering if it is neater to move
> > > the driver in a dedicated folder (e.g. drivers/net/ethernet/airoha or
> > > drivers/net/ethernet/mediatek/airoha) or if you prefer to keep current
> > > approach. Thanks.
> >
> > <2c>
> >
> > Hi Lorenzo,
> >
> > There already seem drivers to be drivers under drivers/net/ethernet/mediatek/
> > which are built from more than once .c file. So I think it is fine
> > to leave Airoha's source there. But, OTOH, I do think it would
> > be neater to move it into it's own directory. Which is to say,
> > I for one am happy either way.
> >
> > If you do chose to go for a new directory, I would suggest
> > drivers/net/ethernet/mediatek/airoha assuming as it is a Mediatek device.
> >
> 
> Hi,
> may I push for a dedicated Airoha directory? (/net/ethernet/airoha ?)
> 
> With new SoC it seems Airoha is progressively detaching from Mediatek.
> 
> There are some similarities but for example for the PPE only the logical entry
> table is similar but rest of the stuff is handled by a coprocessor
> with dedicated
> firmware. My big concern is that we will start to bloat the mediatek directory
> with very different kind of code.
> 
> Putting stuff in ethernet/mediatek/airoha would imply starting to use
> format like
> #include "../stuff.h" and maybe we would start to import stuff from
> mediatek that
> should not be used by airoha.
> 
> Keeping the 2 thing split might make the similarities even more
> evident and easier
> to handle as we will have to rework the header to use the generic include/linux.
> 
> Hope all of this makes sense, it's really to prevent situation and keep things
> organized from the start.

Thanks Christian,

Given the above and the conversation thus far elsewhere in this thread
I now agree that drivers/net/ethernet/airoha is a good option.

