Return-Path: <netdev+bounces-222186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C382B5360B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A11881EAE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296B731AF25;
	Thu, 11 Sep 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sQpF3d/z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130122BAF4;
	Thu, 11 Sep 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601872; cv=none; b=QrG47DPk7TlHuGfX11MAm6UzyeELMRC9xV1ux6Icu1IY0WFxBv6uTpV8Enx62g0+njAI+QUMHwLOg2lkJyUz4sqVJ7fHLDtWDiNc0sDUZciAhXsAqY5tVUxNbouumoP6xAmExcspTKvxylfR6f476/ak4hCaMXVymxzeM6HeyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601872; c=relaxed/simple;
	bh=m3ajYNmfet3CdR3EZgfsuom2tyz84b+auKpeWzRrHTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4CSQi1zTW0AjIL27IhaGkXVksRkzUeH1KfNZc8y1I8qMjrgQCjERJuOxfQaI3ASJ4J5QrZrnrVc5vnJ5UmXo82muafQCotEOXbG88lErlFUcZya+nWLeu8xb6jCeRkCGK7X/dMHDTJ9LZHXk/ZpTg37la5v4opfGJVNa+u8X6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sQpF3d/z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X471W6C5BJj+29v84eIqNLNrrNpVlRO4QaYvcFi48zE=; b=sQpF3d/z1GhHDsLdbG/bw/wEgu
	3mVTMTS+Ablfa3ymbUs2jnkxJvB3GfJFmDtxD8gobIGumsD4ZSBhlxsHZU6AxQeQW9wMbi1SWEESH
	vs7N0PKwIHO84viHz6oQ9OixJpRRgWYZKDcY3g0trVR1Nd59Foi0Sgs2Q+eFDUTLFUik=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwiX2-00862T-QQ; Thu, 11 Sep 2025 16:44:16 +0200
Date: Thu, 11 Sep 2025 16:44:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, harini.katakam@amd.com
Subject: Re: [PATCH net-next 2/2] net: xilinx: axienet: Add inline comment
 for stats_lock mutex definition
Message-ID: <633175ac-97c8-42d0-8f3b-767e89aa4132@lunn.ch>
References: <20250911072815.3119843-1-suraj.gupta2@amd.com>
 <20250911072815.3119843-3-suraj.gupta2@amd.com>
 <0dc424bf-c19b-4eeb-82db-88bff4f85d46@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc424bf-c19b-4eeb-82db-88bff4f85d46@linux.dev>

On Thu, Sep 11, 2025 at 10:35:22AM -0400, Sean Anderson wrote:
> On 9/11/25 03:28, Suraj Gupta wrote:
> > Add inline comment to document the purpose of the stats_lock mutex in
> > the axienet_local structure. This mutex protects the hw_stats_seqcount
> > sequence counter used for hardware statistics synchronization.
> > 
> > Fixes checkpatch warning:
> > CHECK: struct mutex definition without comment
> > 
> > Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> > ---
> >  drivers/net/ethernet/xilinx/xilinx_axienet.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> > index 5ff742103beb..99b9c27bbd60 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> > @@ -598,7 +598,7 @@ struct axienet_local {
> >  
> >  	u64 hw_stat_base[STAT_COUNT];
> >  	u32 hw_last_counter[STAT_COUNT];
> > -	seqcount_mutex_t hw_stats_seqcount;
> > +	seqcount_mutex_t hw_stats_seqcount; /* Lock for hardware statistics */
> >  	struct mutex stats_lock;
> >  	struct delayed_work stats_work;
> >  	bool reset_in_progress;
> 
> NAK. This is already documented in the kernel-doc comment.

Agreed. checkpatch is just a guide, it does get things wrong, and we
don't insist it is 100% clean.

And the existing comment is much more specific:

   Sequence counter for @hw_stat_base, @hw_last_counter,
   and @reset_in_progress.

This makes it clear exactly what it should protect, and what it does
not protect.

    Andrew

---
pw-bot: cr

