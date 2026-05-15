Return-Path: <netdev+bounces-288158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EGpIzmGBmr0kQIAu9opvQ
	(envelope-from <netdev+bounces-288158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:34:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9A548BFA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E83302FA89
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F25E3BD646;
	Fri, 15 May 2026 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBfcVcQp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FD78F26
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812471; cv=none; b=BmJyFTElW9wgzHB+PR+vriVdDBJxflcCbqggBeNijpdJlIFLo61PU3YRVznCMX9dHmJ5+wxt84tg6MWTZYn2OG4VhGk78HHUac+Fu/g528RrkaBBvdUZSHa7V5PPcDtbhF7z/g4E64/ElXeA7nWASa7qWty2YfxpJjQzS2MP1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812471; c=relaxed/simple;
	bh=kMYZOxEs5UEJno+m4KDusv2vSvrhW+tJcs1SclzzftU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDqAE4BODDA/a98pDLNOb4QUh1GQT9jzpdUk001xCpJeI+a58ilVFTKNw7OGRLStFFRN7q/sZZtIWKSf/rL1xQ1NQJKDYl3fW9JCWh5ukusqp+U6/k3l74keNyLXgsxs750UFhM9WRQmC7MyrZD0u5eRa01lYNKFhhZvca5kMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBfcVcQp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3664df30f53so4651592a91.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 19:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778812469; x=1779417269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6aioJ/VruACcjnO0ZQq/BSwgMBliRL2boTCfWV1KhVA=;
        b=HBfcVcQpEbcGImRT99w1jXmmgM6/XjjcGqS0jFKT4ozVYVWAy9joU9wkaTaQB4dRjf
         7ozvD/+o6Kt5Rwc1C6TXikPrupawNrcB1Y7M7m7qEoHIVQFfYLOqsdzVxU+OdeHkup4q
         56hj/e/tZ5Gfm3sgxNvRoXzRBZ7DPeVTG6S9q6oCm2cNObK+cghxE+3muuLCtqMr4mdv
         EvhPPaP172AlP2qEU/xKXQRgqILSls99Q8EKzHGGVJpGhsUty+kEQp52hIU4r+wESwlj
         qqJ3qMoXxXtxrifjcGpDBlksH7uCXK78xk4SPXTNAJdKIwS13ghOX2JP/DQBapM2D1C7
         +nBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812469; x=1779417269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aioJ/VruACcjnO0ZQq/BSwgMBliRL2boTCfWV1KhVA=;
        b=qdJYl9CG1b6Y41OWH1ze2hnRxRHOsA/PBow/YV8heUFNnKney4Akhuk8snq+mf+nHd
         uoI2DhfMbgS7yY11dFAFrQ0mFQ3xigb0tlzvwwFETqx0X3M6u0YNak7+swPcSYmocCHj
         v8E0rWu/emUFogkgPHDeU6PErhzaEyTfPiJ03pAOR+wQpCFKAJcQwigvF879a4ZbSqj5
         IlPCh0qtFf2st2/AHdxsucMEtScRgVfWoUyKNJLBwcnUm0mS+DPS6pjrASKO703Dmk+O
         6XU9S0n+oszDtOAKjTt7jm7RZc3wLHJrNx9+X4IAIdx7DP/Bac0/3GKHYyS6Q4LG7rqf
         aF6A==
X-Forwarded-Encrypted: i=1; AFNElJ8QiJdFTABNolNiRxcFHKOqYuM/Uc3xPZZhC/+vrm//vqBQZo2QoPPA98vBk5kFGoIOn7ECX4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2XUDLvqhPONzOBh3X2ggUeRno3go+W81+3CJQLdX3PyyVss9
	2Oem/4dakantJnEreTOF6XNqir3CxXgX9kdZjl5fJrJ7WPEhAzbyuHe8
X-Gm-Gg: Acq92OGekZImDMnZL4inKiome211i0ggntjR2oFMKWJ0aMTenVfBgT8y+wz/lwuSCf9
	O/CdMZ7vI48LIefP5NrzyLbDgqwTopvUhD4AejfXMhIKXmJ7gt5MdAqBIkzD0ir9xxOanAND4Dy
	zQJuztGsmoijuy/PR6yytoA6kwLBWynnMJsXN4RUNVrwASCVJKQ5OrLpxOpAzSY92DvZJkXJQZk
	/7uFk4NzJXI+L7UF+MgMIby7vJLMps+KpiJdPQBnrYaZls8z73LXxvkLAbT7Rpyl/SPiO17vj42
	nrr5g/ex1kUqnd8pjqVQwqw04UxXCJH4uhQFRgRosBb8R/eH6f/ZgJr9aNnQHRquQph4uDAynsY
	RBUCQesyp9ubKjeKnI5Sf4WiREixCpD3ogSEIKS2e7KIquZiP48nvF5EUihoYRA7lPhlhAEZusB
	Ap4lAa51kGCII8hpmXxq4dp9Au9UDP36NQzLot9xGULEg=
X-Received: by 2002:a17:90b:33c4:b0:367:f9f1:af78 with SMTP id 98e67ed59e1d1-369519decbcmr1813546a91.7.1778812469198;
        Thu, 14 May 2026 19:34:29 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0f9155sm41812535ad.59.2026.05.14.19.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 19:34:28 -0700 (PDT)
Date: Fri, 15 May 2026 11:34:23 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kerneljasonxing@gmail.com, kuniyu@google.com,
	mhal@rbox.co, steffen.klassert@secunet.com, vakzz@zellic.io,
	ben@decadent.org.uk, herbert@gondor.apana.org.au,
	dsahern@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agaGL7AARVk2OdAT@v4bel>
References: <agToIEDI4TaTNLRb@v4bel>
 <agVpIsaSherjHTYg@sultan-box>
 <agWUdie1xBvBu22I@v4bel>
 <f747602d-8208-4b3a-9e16-78632ec7b919@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f747602d-8208-4b3a-9e16-78632ec7b919@linux.dev>
X-Rspamd-Queue-Id: E0C9A548BFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288158-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kerneltoast.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,secunet.com,zellic.io,decadent.org.uk,gondor.apana.org.au,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 10:01:50AM +0800, Jiayuan Chen wrote:
> 
> On 5/14/26 5:23 PM, Hyunwoo Kim wrote:
> > On Wed, May 13, 2026 at 11:18:10PM -0700, Sultan Alsawaf wrote:
> > > On Thu, May 14, 2026 at 06:07:44AM +0900, Hyunwoo Kim wrote:
> > > > Changes in v2:
> > > > - Also propagate SHARED_FRAG in skb_shift()
> > > > - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
> > > Hi Hyunwoo,
> > > 
> > > I've been working on mitigating this vulnerability as a member of the kernel
> > > team at CIQ, a distro vendor. In particular, we wanted to make sure that there
> > > weren't any lingering places missing SHARED_FRAG propagation.
> > > 
> > > To that end, I used Claude to discover that skb_gro_receive() remained unpatched
> > > (as you pointed out in the v1 thread). And then I generated a PoC exploiting the
> > > vulnerable skb_gro_receive() path.
> > > 
> > > The PoC is a modified version of the original fragnesia PoC. It works 100% of
> > > the time, just like the original fragnesia PoC.
> > > 
> > > I have attached the PoC and a patch that fixes skb_gro_receive(). Please take a
> > > look at them.
> > > 
> > > Thanks,
> > > Sultan
> > Nice catch. Thank you.
> > 
> > After testing, I plan to merge your patch with v2 into a single patch (not a
> > series) and submit it as v3. I would appreciate it if you could then add an
> > appropriate credit tag of your own.
> 
> When sending v3, remember to rebase net tree first then generate the patch.
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=f84eca5817390257cef78013d0112481c503b4a3

Thanks for the heads-up. I'll send v4 shortly. See also:
https://lore.kernel.org/all/agZEC3YDCAhkrcvr@v4bel/

Will rebase onto netdev before sending.


Best regards,
Hyunwoo Kim

> 
> 
> Thanks
> 
> > Also, I would appreciate it if you could use AI to explore additional
> > propagation variant paths. From my own analysis, no further ones have been
> > identified.
> > 
> > 
> > Best regards,
> > Hyunwoo Kim
> > 
> > 
> 
> 

