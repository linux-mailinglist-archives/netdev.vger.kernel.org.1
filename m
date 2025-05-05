Return-Path: <netdev+bounces-187826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45432AA9C9F
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 21:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC623A3D7A
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624DF25D539;
	Mon,  5 May 2025 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QgMNsUXP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9817333F;
	Mon,  5 May 2025 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473252; cv=none; b=b4gyNJUhJduCbkF8lgeVTa+zZGVmLAOp+zoga3kibvxjBtZXVaI6f8GGqdRr2bIF5kTXbn3kbRAoRrE0rckiz7uSMBjQc6oNQO9JspK8D4M35lpCOOlwp5MKF2cKJ3pe1iyXgRffbp1LfBXNeP6X61smH4fzdY37xOBfcZuvti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473252; c=relaxed/simple;
	bh=yE4K00cim4sjv2RnRcLDj9EJ+VBCvkau+NXqtQGE4to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owc4533ZU0RKa77AH/5Pe0zgFaFix04P9Jb0qAUVXabTLBQboFEKa4apgVFh4AxWVc/ByjZB4H/At4oDFwjjzuOj6mgEBTVd338/7vLdYM7R/wWntk1W7I5Ym88ay7214a9dxrpy/pYFGMOQ4bYx1X997VRCiEdNhsvtqCkhSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QgMNsUXP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=hKochlIwHnCpW8MnNP8D8YL+YspnWH14oOiGbaOJ6Vg=; b=Qg
	MNsUXPFv2p51/f9Vsv8mA3try/6PvDu0rDiMnH0O8/DyN0x30z27QL+H3hhHpLQBgI30HMSNCThSz
	SEdyZAN6xe/lods7BJgawT4gsFpmsDOn/zM16pkzdKCGj0H7q4Zrv7zNFu0mDVbZ5VMEodKc8tjLB
	uEOim51zxWp9IbU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uC1TA-00BdB7-N5; Mon, 05 May 2025 21:27:16 +0200
Date: Mon, 5 May 2025 21:27:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: vertexcom: mse102x: Return code for
 mse102x_rx_pkt_spi
Message-ID: <51cdf94b-6f97-421d-916c-aca5e7c34879@lunn.ch>
References: <20250505142427.9601-1-wahrenst@gmx.net>
 <20250505142427.9601-5-wahrenst@gmx.net>
 <3b9d36a7-c2fd-4d37-ba33-fc13121d92e6@lunn.ch>
 <c1fc1341-4490-4e22-a2ee-64bb67529660@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1fc1341-4490-4e22-a2ee-64bb67529660@gmx.net>

On Mon, May 05, 2025 at 07:16:51PM +0200, Stefan Wahren wrote:
> Hi Andrew,
> 
> Am 05.05.25 um 18:43 schrieb Andrew Lunn:
> > On Mon, May 05, 2025 at 04:24:26PM +0200, Stefan Wahren wrote:
> > > The interrupt handler mse102x_irq always returns IRQ_HANDLED even
> > > in case the SPI interrupt is not handled. In order to solve this,
> > > let mse102x_rx_pkt_spi return the proper return code.
> > > 
> > > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > > ---
> > >   drivers/net/ethernet/vertexcom/mse102x.c | 15 +++++++++------
> > >   1 file changed, 9 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
> > > index 204ce8bdbaf8..aeef144d0051 100644
> > > --- a/drivers/net/ethernet/vertexcom/mse102x.c
> > > +++ b/drivers/net/ethernet/vertexcom/mse102x.c
> > > @@ -303,7 +303,7 @@ static void mse102x_dump_packet(const char *msg, int len, const char *data)
> > >   		       data, len, true);
> > >   }
> > > -static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
> > > +static irqreturn_t mse102x_rx_pkt_spi(struct mse102x_net *mse)
> > >   {
> > >   	struct sk_buff *skb;
> > >   	unsigned int rxalign;
> > > @@ -324,7 +324,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
> > >   		mse102x_tx_cmd_spi(mse, CMD_CTR);
> > >   		ret = mse102x_rx_cmd_spi(mse, (u8 *)&rx);
> > >   		if (ret)
> > > -			return;
> > > +			return IRQ_NONE;
> > >   		cmd_resp = be16_to_cpu(rx);
> > >   		if ((cmd_resp & CMD_MASK) != CMD_RTS) {
> > > @@ -357,7 +357,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
> > >   	rxalign = ALIGN(rxlen + DET_SOF_LEN + DET_DFT_LEN, 4);
> > >   	skb = netdev_alloc_skb_ip_align(mse->ndev, rxalign);
> > >   	if (!skb)
> > > -		return;
> > > +		return IRQ_NONE;
> > This is not my understanding of IRQ_NONE. To me, IRQ_NONE means the
> > driver has read the interrupt status register and determined that this
> > device did not generate the interrupt. It is probably some other
> > device which is sharing the interrupt.
> At first i wrote this patch for the not-shared interrupt use case in mind.
> Unfortunately this device doesn't have a interrupt status register and in
> the above cases the interrupt is not handled.
> 
> kernel-doc says:
> 
> @IRQ_NONE:        interrupt was not from this device or was not handled
> @IRQ_HANDLED:    interrupt was handled by this device

A memory allocation failure in netdev_alloc_skb_ip_align() does not
seem like a reason to return IRQ_NONE. I think the more normal case
is, there was an interrupt, there was an attempt to handle it, but the
handler failed. The driver should try to put the hardware into a state
the next interrupt will actually happen, and be serviced.

This is particularly important with level interrupts. If you fail to
clear the interrupt, it is going to fire again immediately after
exiting the interrupt handler and the interrupt is reenabled. You
don't want to die in an interrupt storm. Preventing such interrupt
storms is part of what the return value is used for. If the handler
continually returns IRQ_NONE, after a while the core declares there is
nobody actually interested in the interrupt, and it leaves it
disabled.

> So from my understanding IRQ_NONE fits better here (assuming a not-shared
> interrupt).
> 
> I think driver should only use not-shared interrupts, because there is no
> interrupt status register. Am I right?

I don't see why it cannot be shared. It is not very efficient, and
there will probable be a bias towards the first device which requests
the interrupt, but a shared interrupt should work.

	Andrew

