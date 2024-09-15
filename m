Return-Path: <netdev+bounces-128422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553F59797D4
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB79DB20F80
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1991C8FAA;
	Sun, 15 Sep 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oOk7OuHW"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBEB38DD1;
	Sun, 15 Sep 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726417515; cv=none; b=oVwTWJZC5yPHDqgyv5XRogiG2OaUm2HSYP/g8tOgloILwQT9JOzW/c71WYbI6aDuA2U/aAgvo60FVYlnw6dqmvmaZbVpKWqjSV8VpbVDDD/rFWT7ZyCdqz/0VhPJUEHfXT2wFcEzEb/EXAzCg295F73jgDAyf8r6NWNBkeWflsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726417515; c=relaxed/simple;
	bh=VHFRphAhdMvcqZFfp/DQo2k/onRbN3noRBK3dtVZjU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm7sHz+UWQEvSiI+ksj5ogrMCvgdFB5/jKOjDvBydukXlxFmcyeWLQ3iDrURtYiqC7LUJcVU8YUok59UEw+g0O0bLTREJgn99vA9GvjcEvfaXbQs3cR4JK5qTn5FbX1vHGT4HHsbgUgUHZaVK8cylkTyJdOOau68nJNZjSQzqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oOk7OuHW; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=jG0LHkK9+s47i4vFCqHPgQ+PxeWrvcfGdTU2q+UJdfs=; b=oOk7OuHW61OWYX1R
	Mokg30kCwgCjO0n0+s9oHDvheIpfYWXrRwp4c/vdeFWFHvKBm8xVoobEFwcWO4aNKQxYUcoGYpf8k
	xo0EKF8/RMBe+ArCQ1T7ke43iFOBqb6cneuTGzvp56wGZ2O/AmhULhlhGsiQzeJt7UFma/VtFS0tq
	OR0Ebwph0ueIy1419IIJTcBmiq/DVZecCGWecZJMTsyurFknYF4TV2DTdMrFiQRRc2K3BvtNRm8lk
	ar0KO5NWzo2qfrpbWeMRKIWsFyFNl0AFc0Y68iaOn+40gtFgWXNxqCD/p1zyhuAv4lpuWtQN/ByEh
	bB+RzrFDVsvk9DGm+g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sps3h-005qek-2W;
	Sun, 15 Sep 2024 16:25:09 +0000
Date: Sun, 15 Sep 2024 16:25:09 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Alexander Zubkov <green@qrator.net>, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Fix misspelling of "accept*"
Message-ID: <ZucKZcwmd28S_t24@gallifrey>
References: <20240622164013.24488-2-green@qrator.net>
 <Zncwl4DAwTQL0YDl@gallifrey>
 <CABr+u0b-RAV9hz25O5a3Axz6s9vYLVc5shr8xAgPsykP_XRFgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABr+u0b-RAV9hz25O5a3Axz6s9vYLVc5shr8xAgPsykP_XRFgw@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:24:25 up 130 days,  3:38,  1 user,  load average: 0.02, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Alexander Zubkov (green@qrator.net) wrote:
> Hi,
> 
> I just wanted to kindly check in on the status of my patch. Please let
> me know if any further action is needed from my side.
> 
> Thanks for your time!

I was only a reviewer on this; it'll need some of the netdev people
to notice it for it to get further.

Dave

> Best regards,
> Alexander Zubkov
> 
> On Sat, Jun 22, 2024 at 10:14 PM Dr. David Alan Gilbert
> <linux@treblig.org> wrote:
> >
> > * Alexander Zubkov (green@qrator.net) wrote:
> > > Several files have "accept*" misspelled as "accpet*" in the comments.
> > > Fix all such occurrences.
> > >
> > > Signed-off-by: Alexander Zubkov <green@qrator.net>
> >
> > Reviewed-by: Dr. David Alan Gilbert <linux@treblig.org>
> >
> > hmm, should probably cc in some maintainers, I guess networking.
> > (added netdev and Paolo)
> >
> > Dave
> >
> > > ---
> > >  drivers/infiniband/hw/irdma/cm.c                              | 2 +-
> > >  drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c | 4 ++--
> > >  drivers/net/ethernet/natsemi/ns83820.c                        | 2 +-
> > >  include/uapi/linux/udp.h                                      | 2 +-
> > >  4 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
> > > index 36bb7e5ce..ce8d821bd 100644
> > > --- a/drivers/infiniband/hw/irdma/cm.c
> > > +++ b/drivers/infiniband/hw/irdma/cm.c
> > > @@ -3631,7 +3631,7 @@ void irdma_free_lsmm_rsrc(struct irdma_qp *iwqp)
> > >  /**
> > >   * irdma_accept - registered call for connection to be accepted
> > >   * @cm_id: cm information for passive connection
> > > - * @conn_param: accpet parameters
> > > + * @conn_param: accept parameters
> > >   */
> > >  int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
> > >  {
> > > diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> > > index 455a54708..96fd31d75 100644
> > > --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> > > +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> > > @@ -342,8 +342,8 @@ static struct sk_buff *copy_gl_to_skb_pkt(const struct pkt_gl *gl,
> > >  {
> > >       struct sk_buff *skb;
> > >
> > > -     /* Allocate space for cpl_pass_accpet_req which will be synthesized by
> > > -      * driver. Once driver synthesizes cpl_pass_accpet_req the skb will go
> > > +     /* Allocate space for cpl_pass_accept_req which will be synthesized by
> > > +      * driver. Once driver synthesizes cpl_pass_accept_req the skb will go
> > >        * through the regular cpl_pass_accept_req processing in TOM.
> > >        */
> > >       skb = alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req)
> > > diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
> > > index 998586872..bea969dfa 100644
> > > --- a/drivers/net/ethernet/natsemi/ns83820.c
> > > +++ b/drivers/net/ethernet/natsemi/ns83820.c
> > > @@ -2090,7 +2090,7 @@ static int ns83820_init_one(struct pci_dev *pci_dev,
> > >        */
> > >       /* Ramit : 1024 DMA is not a good idea, it ends up banging
> > >        * some DELL and COMPAQ SMP systems
> > > -      * Turn on ALP, only we are accpeting Jumbo Packets */
> > > +      * Turn on ALP, only we are accepting Jumbo Packets */
> > >       writel(RXCFG_AEP | RXCFG_ARP | RXCFG_AIRL | RXCFG_RX_FD
> > >               | RXCFG_STRIPCRC
> > >               //| RXCFG_ALP
> > > diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> > > index 1a0fe8b15..d85d671de 100644
> > > --- a/include/uapi/linux/udp.h
> > > +++ b/include/uapi/linux/udp.h
> > > @@ -31,7 +31,7 @@ struct udphdr {
> > >  #define UDP_CORK     1       /* Never send partially complete segments */
> > >  #define UDP_ENCAP    100     /* Set the socket to accept encapsulated packets */
> > >  #define UDP_NO_CHECK6_TX 101 /* Disable sending checksum for UDP6X */
> > > -#define UDP_NO_CHECK6_RX 102 /* Disable accpeting checksum for UDP6 */
> > > +#define UDP_NO_CHECK6_RX 102 /* Disable accepting checksum for UDP6 */
> > >  #define UDP_SEGMENT  103     /* Set GSO segmentation size */
> > >  #define UDP_GRO              104     /* This socket can receive UDP GRO packets */
> > >
> > > --
> > > 2.45.2
> > >
> > >
> > --
> >  -----Open up your eyes, open up your mind, open up your code -------
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

