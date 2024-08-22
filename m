Return-Path: <netdev+bounces-120977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C2A95B575
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0571F23A3D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4181C9DDC;
	Thu, 22 Aug 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrGogDpB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE01C9DD5;
	Thu, 22 Aug 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331239; cv=none; b=Hla/wULghjp1kttZHS361hoTVX2BdD1T2kgoTsVZwdzGuOOW47ZdndcmL8lXfSSFpXHBoYQaZY4XfsshlwPfFkrUpvAx77SpeccZydcazmduE+Ar1dUHRFID8NLj4D5tN5QFf153pK2ecJiSUnN/cauzNISh6nSV5PoYslD7rLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331239; c=relaxed/simple;
	bh=lXfQj2ixlufIrGTlDs+DNtXFGog9eo66LzDYym0DNL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVi0D00in6do73NLMJi7YiMUqDEJI7phPd8n1xZOeuzfsUYMbo0V5tKWvprTcJA/TLYwt6ZtLaa00nhVG9Ksmr8GiM3m8KULSVN8inwps8ASrgVHWUNr48trn8XHzkZDewtQb9iXX5Ky0zP34NYY+erKIik0rO7bVj2fJVnJzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrGogDpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A23C32782;
	Thu, 22 Aug 2024 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331239;
	bh=lXfQj2ixlufIrGTlDs+DNtXFGog9eo66LzDYym0DNL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TrGogDpBLxwTxdeFy+UZreiAuTkPm/RlTtlzzb+QWPzc1COWQvGQ2/LkiPJ7Ion9g
	 GfydYguMqxzpZ1elCzdYmUBu2aeGZalzSLxlRZVTTJ2FGBulWhiRiihfh2rnZ7n2B6
	 mEAE66dvZ5ufi+6Vg3z5WYTRQ8OptjypkYCTCrSaBYZqrHIDBNaqzVYRRm4/QCNgtY
	 H4KaXt7gNcExCJueXDRajBNDHhcJePoQsHFtRpziaX+pSeKux5A8sJ/hKK08qJo8D+
	 Y1pGqhFnMbi8TFBiy/v/kO5icUEKbM0BnzPScrzaz/gQ5WNEarJ+bTM/srXr9JXrjt
	 jmxNcC8iEAGPg==
Date: Thu, 22 Aug 2024 13:53:55 +0100
From: Simon Horman <horms@kernel.org>
To: Yang Ruibin <11162571@vivo.com>
Cc: Chris Snook <chris.snook@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers:atlx:Use max macro
Message-ID: <20240822125355.GP2164@kernel.org>
References: <20240822075004.1367899-1-11162571@vivo.com>
 <3f994754-2005-420d-9be4-33d7288bc811@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f994754-2005-420d-9be4-33d7288bc811@vivo.com>

On Thu, Aug 22, 2024 at 05:40:28PM +0800, Yang Ruibin wrote:
> Sorry, please ignore this patch.
> Because the corresponding header file is not included, there may be
> compilation errors.

Hi Yang Ruibin,

Thanks for your patch.

Some feedback from a process point of view, for future reference.

1. Please do not top-post in emails to Kernel mailing lists.

2. As a Networking patch, that is not a bug fix, it should
   be explicitly targeted at net-next.

   Subject: [PATCH net-next] ...

3. Looking at git history, it looks like 'net: atheros: ' would be an
   appropriate prefix for this patch.

   Subject: [PATCH net-next] net: atheros: ...

Please consider reading
https://docs.kernel.org/process/maintainer-netdev.html

And please, if you do post a new version, allow 24h to pass since the you
posted this version (as described in the link above).

> 
> 在 2024/8/22 15:50, Yang Ruibin 写道:
> > Instead of using the max() implementation of
> > the ternary operator, use real macros.
> > 
> > Signed-off-by: Yang Ruibin <11162571@vivo.com>
> > ---
> >   drivers/net/ethernet/atheros/atlx/atl2.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
> > index fa9a4919f..3ff669e72 100644
> > --- a/drivers/net/ethernet/atheros/atlx/atl2.c
> > +++ b/drivers/net/ethernet/atheros/atlx/atl2.c
> > @@ -2971,10 +2971,7 @@ static void atl2_check_options(struct atl2_adapter *adapter)
> >   #endif
> >   	/* init RXD Flow control value */
> >   	adapter->hw.fc_rxd_hi = (adapter->rxd_ring_size / 8) * 7;
> > -	adapter->hw.fc_rxd_lo = (ATL2_MIN_RXD_COUNT / 8) >
> > -		(adapter->rxd_ring_size / 12) ? (ATL2_MIN_RXD_COUNT / 8) :
> > -		(adapter->rxd_ring_size / 12);
> > -
> > +	adapter->hw.fc_rxd_lo = max(ATL2_MIN_RXD_COUNT / 8, adapter->rxd_ring_size / 12);

Networking code still prefers lines to be 80 colimns wide or less.
In this case, I would suggest:

	adapter->hw.fc_rxd_lo = max(ATL2_MIN_RXD_COUNT / 8,
				    adapter->rxd_ring_size / 12);

> >   	/* Interrupt Moderate Timer */
> >   	opt.type = range_option;
> >   	opt.name = "Interrupt Moderate Timer";
> 

