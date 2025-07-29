Return-Path: <netdev+bounces-210697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E527AB14594
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376063B9C8F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 01:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936F19EED3;
	Tue, 29 Jul 2025 01:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE4C19DF8B;
	Tue, 29 Jul 2025 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751434; cv=none; b=j0NJdCGJMr7I6IqeRfYNza4hb4HAXHJRBkWox0jr94NmJl/vHOT0kb5GCg74EGs69oZTmnEnLRRzehX3Ko9jVMelfWBgRTq42gzqipxwAsV27O2/Zn4Un6MdtfPHrcYPRrnJaNCM4HsLkXFAGFEBsgFCHDCjP+8VdtRYVpA/n/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751434; c=relaxed/simple;
	bh=rFQHPKdHs7l63lkOcvXWDFEenJTQG4Ry3291fBhwk90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjleSFWtvUjIXuRpOcs1S29761f2MNDqEczBRBzjuVTpCnPYPYupP1l2doF71Jc4wRWTsIFoP2Au7pQwLiH5ewG0fcU00I8Xc/1w0cITQCTIbmFnFOMCI0D5o4353jGAesJo1umUwajch1PbS58udeibVM2G0uOabgQ4/8lsEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-47-68881f858d7e
Date: Tue, 29 Jul 2025 10:10:24 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
	toke@redhat.com, asml.silence@gmail.com, kernel_team@skhynix.com
Subject: Re: [RFC net-next] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
Message-ID: <20250729011024.GD56089@system.software.com>
References: <20250728042050.24228-1-byungchul@sk.com>
 <CAHS8izPv8zmPaxzCSPAnybiCc0KrqjEZA+x5wpFOE8u=_nM1WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPv8zmPaxzCSPAnybiCc0KrqjEZA+x5wpFOE8u=_nM1WA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LhesuzSLdVviPD4PwpG4vVPyos5qzaxmgx
	53wLi8XTY4/YLfa0b2e2eNR/gs3iwrY+VovLu+awWRxbIGbx7fQbRotLhx+xOHB7bFl5k8lj
	56y77B4LNpV6bFrVyebxft9VNo/Pm+QC2KK4bFJSczLLUov07RK4Mp7s3shSME++4ui8I0wN
	jJsluhg5OSQETCT2PP/LBmNf7WxjB7FZBFQlOrZ3M4PYbALqEjdu/ASzRQQ0JZbsm8gKYjML
	fGSUePQntouRg0NYIEpiyxEmkDCvgIXE3j0nGEHCQgI1EpOmp0OEBSVOznzCAtGpLvFn3iVm
	kBJmAWmJ5f84IMLyEs1bZ4Mt4hQIlDgydRlYuaiAssSBbceBpnMBHXmbTeLppKfMEBdLShxc
	cYNlAqPgLCQrZiFZMQthxSwkKxYwsqxiFMrMK8tNzMwx0cuozMus0EvOz93ECIyZZbV/oncw
	froQfIhRgINRiYc3o7M9Q4g1say4MvcQowQHs5IIb8HStgwh3pTEyqrUovz4otKc1OJDjNIc
	LErivEbfylOEBNITS1KzU1MLUotgskwcnFINjOJXU8u3mbk2SLLlRdWpsy5UKFK7wbNx4etT
	yZpnCvV1jkh7KT6d+4WLqSMw6eiJFT1LrOK+Bs2ZssR2QUTo3+h5dVY+95J5WucHWp3+pvLm
	dECXrFj2q6czkuVcF8Wy7Q1kEF59dc635A6Lk44xL0VmN614cSvN9PO8Y0tnLZOdWfbM7ZuG
	oxJLcUaioRZzUXEiAB6sZxeVAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC5WfdrNsq35FhcOCigcXqHxUWc1ZtY7SY
	c76FxeLpsUfsFnvatzNbPOo/wWZxeO5JVosL2/pYLS7vmsNmcWyBmMW3028YLS4dfsTiwOOx
	ZeVNJo+ds+6yeyzYVOqxaVUnm8f7fVfZPBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfGk90b
	WQrmyVccnXeEqYFxs0QXIyeHhICJxNXONnYQm0VAVaJjezcziM0moC5x48ZPMFtEQFNiyb6J
	rCA2s8BHRolHf2K7GDk4hAWiJLYcYQIJ8wpYSOzdc4IRJCwkUCMxaXo6RFhQ4uTMJywQneoS
	f+ZdYgYpYRaQllj+jwMiLC/RvHU22CJOgUCJI1OXgZWLCihLHNh2nGkCI98sJJNmIZk0C2HS
	LCSTFjCyrGIUycwry03MzDHVK87OqMzLrNBLzs/dxAiMgGW1fybuYPxy2f0QowAHoxIPb0Zn
	e4YQa2JZcWXuIUYJDmYlEd6CpW0ZQrwpiZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tS
	s1NTC1KLYLJMHJxSDYwX5uYYbPm06viWxNrH910cjQSu9yRsrmZjslu6xdB8xsozPQ56blp/
	ZCJkpjwTCRDNnfMs2cXCotq0uEbrf6FAs9WPmBn7AqYY6sQ9N4u+tljsCvv82EkiE7RsVjku
	jNllPEVv+Q4+s6qLRs9kXpx4stqjuazIq/TrsaigwtNqdgqvdm67X6XEUpyRaKjFXFScCACK
	rDNefAIAAA==
X-CFilter-Loop: Reflected

On Mon, Jul 28, 2025 at 10:44:31AM -0700, Mina Almasry wrote:
> On Sun, Jul 27, 2025 at 9:21 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > Now that we have struct netmem_desc, it'd better access the pp fields
> > via struct netmem_desc rather than struct net_iov.
> >
> > Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> > netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
> >
> > While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> > used instead.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> Thank you for working on paying this tech debt!

I thought it was appropriate to organize the code I modified to some
extent.

> > ---
> >  include/net/netmem.h   | 33 ++++++++++++++++-----------------
> >  net/core/netmem_priv.h | 16 ++++++++--------
> >  2 files changed, 24 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index f7dacc9e75fd..33ae444a9745 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -265,24 +265,23 @@ static inline struct netmem_desc *__netmem_to_nmdesc(netmem_ref netmem)
> >         return (__force struct netmem_desc *)netmem;
> >  }
> >
> > -/* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for access to
> > - * common fields.
> > - * @netmem: netmem reference to extract as net_iov.
> > +/* netmem_to_nmdesc - convert netmem_ref to struct netmem_desc * for
> > + * access to common fields.
> > + * @netmem: netmem reference to get netmem_desc.
> >   *
> > - * All the sub types of netmem_ref (page, net_iov) have the same pp, pp_magic,
> > - * dma_addr, and pp_ref_count fields at the same offsets. Thus, we can access
> > - * these fields without a type check to make sure that the underlying mem is
> > - * net_iov or page.
> > + * All the sub types of netmem_ref (netmem_desc, net_iov) have the same
> > + * pp, pp_magic, dma_addr, and pp_ref_count fields via netmem_desc.
> >   *
> > - * The resulting value of this function can only be used to access the fields
> > - * that are NET_IOV_ASSERT_OFFSET'd. Accessing any other fields will result in
> > - * undefined behavior.
> > - *
> 
> I think instead of removing this warning, we want to add an
> NET_IOV_ASSERT_OFFSET that asserts that net_iov->netmem_desc and
> page->netmem_desc are in the same offset, and then add a note here
> that this works because we assert that the netmem_desc offset in both
> net_iov and page are the same.

It doesn't have to have the same offset.  Why do you want it?  Is it for
some optimizaiton?  Or I think it's unnecessary constraint.

> > - * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
> > + * Return: the pointer to struct netmem_desc * regardless of its
> > + * underlying type.
> >   */
> > -static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
> >  {
> > -       return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
> > +       if (netmem_is_net_iov(netmem))
> > +               return &((struct net_iov *)((__force unsigned long)netmem &
> > +                                           ~NET_IOV))->desc;
> > +
> > +       return __netmem_to_nmdesc(netmem);
> 
> The if statement generates overhead. I'd rather avoid it. We can
> implement netmem_to_nmdesc like this, no?
> 
> netmem_to_nmdesc(netmem_ref netmem)
> {
>   return (struct netmem_desc)((__force unsigned long)netmem & ~NET_IOV);
> }

I see.  You want this kind of optimization.  I will do this way if you
want.

> Because netmem_desc is the first element in both net_iov and page for
> the moment. (yes I know that will change eventually, but we don't have
> to incur overhead of an extra if statement until netmem_desc is
> removed from page, right?)

Okay.

	Byungchul
> 
> 
> --
> Thanks,
> Mina

