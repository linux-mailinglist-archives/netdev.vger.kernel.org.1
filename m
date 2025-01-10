Return-Path: <netdev+bounces-157152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA76A09115
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176CB3A497A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB7A20E00A;
	Fri, 10 Jan 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIRXkIsX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480020DD56
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513145; cv=none; b=Ix0ZcAWu3EvYX3lt5vbKtMzcRUEoYVN31y+lrUE0J+pItgqp+gfC84ss/vzfQ+TqxTsv8OmeLScWDlCYlLZZi0j31V4SBPIr9WnjMt+7fQWahfdGRc/vxSWflxSFNxwmI1kX43bX1HGxfKH7uT7+ZXI1/4T+szFzjd75AHQais0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513145; c=relaxed/simple;
	bh=bca8BxMfdc975okjycip8BdofCPaqbTOhIcMezZca7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHQN8eyoRb1Ujugff2gS/5jCDJLI6ttGzq+MLvUud7p+tIecGe4U1gnx7FcJgkE9CsP65hzqMMwgAphUq/FS9bGrQcfHXLUFwpMa4h9E66kXqiViEp5GyX8OFw548bWVNtM5NTqwwmDE5KOIj1iAbXTkxU8dh+KLG6R6cUkw8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIRXkIsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D81EC4CED6;
	Fri, 10 Jan 2025 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736513145;
	bh=bca8BxMfdc975okjycip8BdofCPaqbTOhIcMezZca7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIRXkIsXVAAuDPCblcDhjrAUDCdKcVwhQFs1+lUoeE/gUeTmJkWUSoksS3xLU0Uf6
	 vkk/qiXLG83GkO0i/vEt3uH5FPzeZmNEJHVeOmP2+VQWzCw5RuKf9IxyCvZMxWB90O
	 xHBZn0J5EqYkzYdorXObKEQuuEtG09skfWQViCxUAyl/cFzjcqlluDYFP61hqJxxtT
	 SoqK8ME4Fu0QKGnmVezpH+a6AhqA1fpAlovK1BGlHJkXDvmn7YPTcVGQmNRwS5SmGn
	 mPhTI9Q5QhVkx+Huya363BjXwZwfU18TJXxlVjM2Fsu61Qtu15NgXs6lHjZOyYM7i6
	 xNdhG2p8RPI7g==
Date: Fri, 10 Jan 2025 12:45:41 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] freescale: ucc_geth: Remove set but unused
 variables
Message-ID: <20250110124541.GE7706@kernel.org>
References: <20250110-ucc-unused-var-v1-1-4cf02475b21d@kernel.org>
 <8b080760-c1c7-4d9d-a17b-3c0115392b36@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b080760-c1c7-4d9d-a17b-3c0115392b36@csgroup.eu>

On Fri, Jan 10, 2025 at 12:07:25PM +0100, Christophe Leroy wrote:
> 
> 
> Le 10/01/2025 à 11:18, Simon Horman a écrit :
> > Remove set but unused variables. These seem to provide no value.
> > So in the spirit of less being more, remove them.
> 
> Would be good to identify when those variables became unused.
> 
> There is for instance commit 64a99fe596f9 ("ethernet: ucc_geth: remove
> bd_mem_part and all associated code")

Sure, I can work on an updated commit message for v2 along those lines.

> 
> ...
> 
> > 
> > Compile tested only.
> > No runtime effect intended.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> 
> As you are playing with that driver, there are also sparse warnings to be
> fixed, getting plenty when building with C=2

Yes, I noticed.
That is on my todo list :)

> 
> > ---
> >   drivers/net/ethernet/freescale/ucc_geth.c | 39 +++++++------------------------
> >   1 file changed, 8 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
> > index 88510f822759..1e3a1cb997c3 100644
> > --- a/drivers/net/ethernet/freescale/ucc_geth.c
> > +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> > @@ -1704,14 +1704,8 @@ static int ugeth_82xx_filtering_clear_addr_in_paddr(struct ucc_geth_private *uge
> >   static void ucc_geth_free_rx(struct ucc_geth_private *ugeth)
> >   {
> > -	struct ucc_geth_info *ug_info;
> > -	struct ucc_fast_info *uf_info;
> > -	u16 i, j;
> >   	u8 __iomem *bd;
> > -
> > -
> > -	ug_info = ugeth->ug_info;
> > -	uf_info = &ug_info->uf_info;
> > +	u16 i, j;
> 
> Why do you need to move this declaration ? Looks like cosmetics. That goes
> beyond the purpose of this patch which is already big enough and should be
> avoided. The same applies several times in this patch.

It seemed convenient to move this around at the same time,
as the lines are adjacent. But will drop them as you wish.

> 
> >   	for (i = 0; i < ucc_geth_rx_queues(ugeth->ug_info); i++) {
> >   		if (ugeth->p_rx_bd_ring[i]) {

...

> > @@ -2904,7 +2883,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
> >   	/* while there are received buffers and BD is full (~R_E) */
> >   	while (!((bd_status & (R_E)) || (--rx_work_limit < 0))) {
> > -		bdBuffer = (u8 *) in_be32(&((struct qe_bd __iomem *)bd)->buf);
> > +		in_be32(&((struct qe_bd __iomem *)bd)->buf);
> 
> This line should go completely.

Thanks,

I was slightly concerned that it may have some side effect - that
I have no way to test. But I will remove it on your advice.

> 
> >   		length = (u16) ((bd_status & BD_LENGTH_MASK) - 4);
> >   		skb = ugeth->rx_skbuff[rxQ][ugeth->skb_currx[rxQ]];

...

-- 
pw-bot: changes-requested

