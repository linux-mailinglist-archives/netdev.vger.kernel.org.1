Return-Path: <netdev+bounces-109564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC133928DB2
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 21:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA9CB21110
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 19:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5A916D31C;
	Fri,  5 Jul 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbhOOutI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFBA13AD28
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720206573; cv=none; b=Ac4xTooddK1gEgAOj6KszEcD727kev9UzVCrvlLOXkrzzHbprgebJOjPmImtZ6SPHS4aRZj7ggnllEcS+96l33rtNsE5oGTG3RrKLzQxKTgnI8gyllWulfdes3wJyQpf02fZJbXHjXLi80Q8rT+9iwaLvgMNaUGO4HNI4aRhCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720206573; c=relaxed/simple;
	bh=H0KAYyDgi50LKgHLXGj+6fjbNk6lVV+XDPJrntRGvyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCophsFNrX/mZ0n2/bZwHXtyfXaS3JnJUutRPPciMWCDKyCKs/BZFr718VzZorhOuEO0wg+bJfu+mqdxe0eAvXF1+Jx089hy8XFxaO89KndEtji8eixpqfg6ftdJOXOqQFXuOQRSrh3tOfY7u2rmLmS/95h5rfH3VUEht8wEuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbhOOutI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF5CC116B1;
	Fri,  5 Jul 2024 19:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720206573;
	bh=H0KAYyDgi50LKgHLXGj+6fjbNk6lVV+XDPJrntRGvyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbhOOutI6Q+QR1qWiI+zRpoZ2I2+6EjgNHNq9yX7YrDSWd6H/tATdehjS04DuALnw
	 AWHKEuORZ2pwWKuoVehVP0pVNjRMpgtCNfAdIFrkIB//uCUl0oWjRVb+k7Qt6h6a/U
	 bC/WjYhY8M9s814LAHfqnxA0Rb99rAR5H8VazYwoAKpCirFgFoVGKW9c/vgK/IhoKr
	 BJbDgTV8aYaUBCtVqCMeCw0RR3uAQSYF1YkkrqMeSFXDkU+V/cZQitlTaSIdM41BaX
	 elyEfrbMfVYRhUxqBTzB+64yaU7Kk5wwUhzhFn5H9rePgkmm0ZBHuUmPuecwlsfn7T
	 1Y9XOluEW7xng==
Date: Fri, 5 Jul 2024 20:09:29 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] bnxt_en: check for irq name truncation
Message-ID: <20240705190929.GC1480790@kernel.org>
References: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
 <20240705-bnxt-str-v1-2-bafc769ed89e@kernel.org>
 <CACKFLi=N6deF89AncWbuadMZrL9Z8_w5bLkL6WOJBgUWzDPpmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=N6deF89AncWbuadMZrL9Z8_w5bLkL6WOJBgUWzDPpmg@mail.gmail.com>

On Fri, Jul 05, 2024 at 11:27:47AM -0700, Michael Chan wrote:
> On Fri, Jul 5, 2024 at 4:27 AM Simon Horman <horms@kernel.org> wrote:
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index 220d05e2f6fa..15e68c8e599d 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -10538,7 +10538,7 @@ static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
> >         return __bnxt_trim_rings(bp, rx, tx, max, sh);
> >  }
> >
> > -static void bnxt_setup_msix(struct bnxt *bp)
> > +static int bnxt_setup_msix(struct bnxt *bp)
> >  {
> >         const int len = sizeof(bp->irq_tbl[0].name);
> >         struct net_device *dev = bp->dev;
> > @@ -10558,6 +10558,7 @@ static void bnxt_setup_msix(struct bnxt *bp)
> >         for (i = 0; i < bp->cp_nr_rings; i++) {
> >                 int map_idx = bnxt_cp_num_to_irq_num(bp, i);
> >                 char *attr;
> > +               int rc;
> >
> >                 if (bp->flags & BNXT_FLAG_SHARED_RINGS)
> >                         attr = "TxRx";
> > @@ -10566,24 +10567,35 @@ static void bnxt_setup_msix(struct bnxt *bp)
> >                 else
> >                         attr = "tx";
> >
> > -               snprintf(bp->irq_tbl[map_idx].name, len, "%s-%s-%d", dev->name,
> > -                        attr, i);
> > +               rc = snprintf(bp->irq_tbl[map_idx].name, len, "%s-%s-%d",
> > +                             dev->name, attr, i);
> > +               if (rc >= len)
> > +                       return -E2BIG;
> 
> I may be missing something obvious here.  snprintf() will truncate and
> not overwrite the buffer, right?  Why is it necessary to abort if
> there is truncation?  Thanks.

The (incorrect) assumption on my side was that truncated names
are undesirable and should be treated as an error case.
Sorry for not making that clearer.

