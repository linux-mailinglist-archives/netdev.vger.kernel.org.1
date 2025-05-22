Return-Path: <netdev+bounces-192675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0277FAC0CE5
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3252F1BC4A1B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F15228BA82;
	Thu, 22 May 2025 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTo4tTt5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667EA221D9E;
	Thu, 22 May 2025 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920939; cv=none; b=iGYmjifZJzPJzhsiC7AvmJvQty1hw2Zx4MVDVgU5IkJpDTvPrTV9LYyEUW9Nc1/TBQbIREsmnflu70C/Xl6DD9cjD3MYDB4o0NVSltUxMT0mY4JALG+rnFsy3eXgzUVn5fIMpuWdEAhy8GFBnqEHHN3Rvs0iSqHnpCN14fwyYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920939; c=relaxed/simple;
	bh=cDpLf9w9kJIkCs7eLyikioOmbhYa051mNL6Ae5uvGT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8pKJFT9vcwnfrs5PFuvUwFxrYXexOLCzfxpla7M9bCxcDl/2AS7VfQyXkpaB+xBBbwWc9YmcWg+tkdfKnsCDUJqw9a0bFDWaadr6OEhXdOoPSeyROn7b9rn0yYKzxBb9WyV6mNjyr9+srFjpcZ2mbFFLKmZmCfkFUIute+pHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTo4tTt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6461DC4CEE4;
	Thu, 22 May 2025 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747920938;
	bh=cDpLf9w9kJIkCs7eLyikioOmbhYa051mNL6Ae5uvGT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTo4tTt5Sd5/HslZvfepJvdmrkL0amvLuM7Cr25q4Nb4m24BDqjsyBEVAJHqix5pk
	 PZ+Z2d2U+m8dVsH6xvDSl0jirf6wODJ/zF4UBnS5taL/uN4KIPI9vGXFNk7PnPue7o
	 s3frdn8b0RJ//T0GyNvrkZ8FQeSg0iprQRqkPijUdy5Oz93BnPLOvvojUc9aZEtcNU
	 UGkSKJoMjWnPvDlKc4fJcL+JmJLvqRvpl+sG0DvbMWa3db7gW1pZCwrMr2hnR3j14r
	 5tsvv+BhV70rIW79J9mf8J5gXBeeIQIPkbsykoFIx8IvCn2LnAK5Xb71rN7FiRQgjv
	 8vk+v2j/EiGnA==
Date: Thu, 22 May 2025 14:35:34 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/4] net: airoha: Add the capability to
 allocate hfwd descriptors in SRAM
Message-ID: <20250522133534.GB365796@horms.kernel.org>
References: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
 <20250521-airopha-desc-sram-v3-4-a6e9b085b4f0@kernel.org>
 <20250522123913.GY365796@horms.kernel.org>
 <aC8fkFUEmBgyT3-W@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC8fkFUEmBgyT3-W@lore-desk>

On Thu, May 22, 2025 at 02:58:56PM +0200, Lorenzo Bianconi wrote:
> > On Wed, May 21, 2025 at 09:16:39AM +0200, Lorenzo Bianconi wrote:
> > > In order to improve packet processing and packet forwarding
> > > performances, EN7581 SoC supports consuming SRAM instead of DRAM for
> > > hw forwarding descriptors queue.
> > > For downlink hw accelerated traffic request to consume SRAM memory
> > > for hw forwarding descriptors queue.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/net/ethernet/airoha/airoha_eth.c | 11 +----------
> > >  drivers/net/ethernet/airoha/airoha_eth.h |  9 +++++++++
> > >  drivers/net/ethernet/airoha/airoha_ppe.c |  6 ++++++
> > >  3 files changed, 16 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > > index 20e590d76735e72a1a538a42d2a1f49b882deccc..3cd56de716a5269b1530cff6d0ca3414d92ecb69 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > > @@ -71,15 +71,6 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
> > >  	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
> > >  }
> > >  
> > > -static bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
> > > -{
> > > -	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
> > > -	 * GDM{2,3,4} can be used as wan port connected to an external
> > > -	 * phy module.
> > > -	 */
> > > -	return port->id == 1;
> > > -}
> > > -
> > >  static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
> > >  {
> > >  	struct airoha_eth *eth = port->qdma->eth;
> > > @@ -1128,7 +1119,7 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
> > >  			LMGR_INIT_START | LMGR_SRAM_MODE_MASK |
> > >  			HW_FWD_DESC_NUM_MASK,
> > >  			FIELD_PREP(HW_FWD_DESC_NUM_MASK, HW_DSCP_NUM) |
> > > -			LMGR_INIT_START);
> > > +			LMGR_INIT_START | LMGR_SRAM_MODE_MASK);
> > 
> > Hi Lorenzo,
> 
> Hi Simon,
> 
> > 
> > I'm wondering if setting the LMGR_SRAM_MODE_MASK bit (maybe a different
> > name for the #define would be nice) is dependent on the SRAM region
> 
> I did this way because LMGR_SRAM_MODE_MASK is just a bit. Do you prefer
> to do something like:
> 
> FIELD_PREP(LMGR_SRAM_MODE_MASK, 1)?

Let's leave it as you have it in this patch :)

> 
> > being described in DT, as per code added above this line to this
> > function by the previous patch in this series.
> 
> Are you referring to qdma0_buf/qdma1_buf memory regions?
> https://patchwork.kernel.org/project/netdevbpf/patch/20250521-airopha-desc-sram-v3-1-a6e9b085b4f0@kernel.org/
> 
> If so, they are DRAM memory-regions and not SRAM ones. They are used for
> hw forwarding buffers queue. SRAM is used for hw forwarding descriptor queue.

Yes, my mistake.

With that cleared up I think this patch looks good.

Reviewed-by: Simon Horman <horms@kernel.org>

