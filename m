Return-Path: <netdev+bounces-219498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F2B419A3
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7101888EC4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DABC2E7BBC;
	Wed,  3 Sep 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="tIOFxGBE"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DB2750F2
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890702; cv=none; b=UedGFz7QYgmKrP6TvVj4Zw8L4N2a6OcL2kezhuGI0MGFDy5I8J2BBHI2T/ZwW+nuxhiDpvy5HqtiGiO7RDjA7iClWaY/m01wK5pC77WL8ZsSMENDTqCjNWme09Ka7GNgAizz7BMADtUFmDRdaiAykmR0wKSN0DlsTHHICoIgonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890702; c=relaxed/simple;
	bh=h7HaQrYowixfllC9fgcb9aNp8qv16i28nxzg5O5XMCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeQnM93kN0qJGx348UTIYQrcRn0oAUEHjp9Zz3mjXzVCCDKhesWtKLZaXWkGu83+gP6wKUx3mrkTyFLE1zcI0m3pC1W+GzcCdNZsqOcibFvRlJH195DG2/nxlm1KJ3AzBdgim4YjWhZq9xGC7whJMfjV7MAK3xbVmVBYI7Kzavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=tIOFxGBE; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cGxgQ1CGXz9tgY;
	Wed,  3 Sep 2025 11:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1756890690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSpwFETYc1LsmkYCDIJ6WtqhZ/SKBwnx6a6qoeAYkd0=;
	b=tIOFxGBEsx/Ysut7ESJ/S2maB5P1TD/vz4VTBf1sEsm7W5oTE29ecWZo+CkS3sG5/VBVQQ
	RvoJ/CxZKvEyaSK4QLIkFq8fzgoxkyONbY5IkQq1EuKoRTuov+tUtItinUGjiOMOzUxv3m
	TC45BwXorLe50DwT1kQTUZ2si/Hnb1wfJ3648qohGeEluH2lwRgybx/aDutFiO5NHkXb82
	04aWjd4ZAFWIS9ygBW6p8Q8ZeRjUg2uq3VJOkmvCP/++n6B6uoa+P6uZRf5L4H5pD4qvB6
	p9r2YNZP1U2aBC1CNV79Is+qC8XzEJs9QrjQkE+sLewhDbKaaKz81Happt8Edg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=listout@listout.xyz
Date: Wed, 3 Sep 2025 14:41:21 +0530
From: Brahmajit Das <listout@listout.xyz>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] net: intel: fm10k: Fix parameter
 idx set but not used
Message-ID: <dyfxrfwy3qulor3sgfuuzxpx7jc4mbot4b7ci5marqlyxdusp4@uvf5fknefnfb>
References: <e13abc99-fb35-4bc4-b110-9ddfa8cdb442@linux.dev>
 <20250902072422.603237-1-listout@listout.xyz>
 <IA3PR11MB8986925DD6DBF282C160AADBE501A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986925DD6DBF282C160AADBE501A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Rspamd-Queue-Id: 4cGxgQ1CGXz9tgY

On 03.09.2025 06:08, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Brahmajit Das
> > Sent: Tuesday, September 2, 2025 9:24 AM
> > To: vadim.fedorenko@linux.dev
> > Cc: andrew+netdev@lunn.ch; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; davem@davemloft.net; intel-wired-
> > lan@lists.osuosl.org; kuba@kernel.org; listout@listout.xyz;
> > netdev@vger.kernel.org; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>
> > Subject: [Intel-wired-lan] [PATCH v2] net: intel: fm10k: Fix parameter
> > idx set but not used
> > 
> > Variable idx is set in the loop, but is never used resulting in dead
> > code. Building with GCC 16, which enables
> > -Werror=unused-but-set-parameter= by default results in build error.
> > This patch removes the idx parameter, since all the callers of the
> > fm10k_unbind_hw_stats_q as 0 as idx anyways.
> > 
> > Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Signed-off-by: Brahmajit Das <listout@listout.xyz>
> > ---
> > changes in v2:
> > 	- Removed the idx parameter, since all callers of
> > 	fm10k_unbind_hw_stats_q passes idx as 0 anyways.
> > ---
> >  drivers/net/ethernet/intel/fm10k/fm10k_common.c | 5 ++---
> >  drivers/net/ethernet/intel/fm10k/fm10k_common.h | 2 +-
> >  drivers/net/ethernet/intel/fm10k/fm10k_pf.c     | 2 +-
> >  drivers/net/ethernet/intel/fm10k/fm10k_vf.c     | 2 +-
> >  4 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> > b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> > index f51a63fca513..1f919a50c765 100644
> > --- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> > +++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> > @@ -447,17 +447,16 @@ void fm10k_update_hw_stats_q(struct fm10k_hw
> > *hw, struct fm10k_hw_stats_q *q,
> >  /**
> >   *  fm10k_unbind_hw_stats_q - Unbind the queue counters from their
> > queues
> >   *  @q: pointer to the ring of hardware statistics queue
> > - *  @idx: index pointing to the start of the ring iteration
> >   *  @count: number of queues to iterate over
> >   *
> >   *  Function invalidates the index values for the queues so any
> > updates that
> >   *  may have happened are ignored and the base for the queue stats is
> > reset.
> >   **/
> The kernel-doc comment still mentions @idx.
> Everything else if fine.
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> 
Hi Aleksandr, can you please point out how I can remove the kernel-doc
comment. I thought removing the line
	@idx: index pointing to the start of the ring iteration
from fm10k_common.c would do that.

I'm open to sending in a v3 with any changes required.
> > -void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32
> > count)
> > +void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 count)
> >  {
> >  	u32 i;
> > 
> > -	for (i = 0; i < count; i++, idx++, q++) {
> > +	for (i = 0; i < count; i++, q++) {
> >  		q->rx_stats_idx = 0;
> >  		q->tx_stats_idx = 0;
> >  	}
> 
> ...

-- 
Regards,
listout

