Return-Path: <netdev+bounces-149980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FD69E85FA
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB1F28100A
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD6214F9F9;
	Sun,  8 Dec 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbVxRtn/"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ADD14600D;
	Sun,  8 Dec 2024 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733672855; cv=none; b=PPrfCGDXSYOirf9+if4MarduifAOg0gPSennrk3jq2BCEp6vuhCaYVmq3ZI5MOfqHvkPTxg86zqnLYqLjiJdQ5Z7CiOtEQ7nfRHgKREkdvYxHNT27JQJqtwAV3pOrSuD1efdTLz0qLY/l2eFzpzsDJ+1U4WwEHsbnohwf9jHLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733672855; c=relaxed/simple;
	bh=wNUOxvL83TzsGifq3IVokVvTfxVKq3AXSvoF49vydRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc7XX7ksG0wLFGtJHzoBgZJ/x0Vb2MFhM6Cqbrr2+wQDpfe5/YBr9nd7k6LHogVNlfFBid86dZtz917ODV4aytxYGDjRL9sk9JeNecRBQaadaICRqgnnHPFdmKp3XaCM52WRIu8D7RcGDUCWlP9iPKljXwu/z4y9+aTY0r4C3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbVxRtn/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B6FD1140152;
	Sun,  8 Dec 2024 10:47:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 08 Dec 2024 10:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733672852; x=
	1733759252; bh=0JUvzhJNY3ZdO4SAnbwz1UN2DckRSUWEHcK7aapXk8I=; b=I
	bVxRtn/HaV9RKcTFVke0iVCvuOKTf7VjU9dMAZMx1V0dJJcZJNJeM7VVJa+6G8D6
	Bl7casc3F4G+D6ndWId6cRtX8DD/CJtY8WqVcnRimSzv7f8GbDOkXORo/EvsYTY7
	V6GbBjgLEftIdCTJ0AvglO4rlsHm1/WOs4DpLxi18Q/jUJOfbjDeeKAz8Ojf2nof
	Qv4y06Md8x4ChSIr3ue/zDzx8hf+ylXyyG6Ry5XmOAHoAZQ0H2Q/jLOgo+YL8Smu
	nNvg8b2pnT83QMxDbefbpGMvX8cLyRT39pRbSfw6cfq+R/Z3zutJYfEcM/cb0es4
	jo46W34SZgYDaqCPlGuvg==
X-ME-Sender: <xms:k79VZ6xMbzYQQPERLxP0eES253SM-_X-JWJA6XY-DMEj-lyjrin4mw>
    <xme:k79VZ2RJzEqMQVhewpHyG1__nOADq_ipTQX6PVkEZmpRHixAjFALij13iTKJomvoH
    zGulveFqmDMW58>
X-ME-Received: <xmr:k79VZ8Vve7rI6cIC4Xeka3bAPsjGz163rXzjjjTLdCbxPcOMmFlblHIhX7m9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeefgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhephfdvudeileeiteejkedtgffhgfdtvdevgedtheeh
    vedufeffkeevhfetvdeggfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpnhgvth
    hfihhlthgvrhdrohhrghdpnhgvthguvghvtghonhhfrdhinhhfohenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstg
    hhrdhorhhgpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepfigvihdrfhgrnhhgsehngihprdgtohhmpdhrtghpthhtohepthhomheshhgvrh
    gsvghrthhlrghnugdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtlhgruhguihhurdhmrghnohhilhesnhigphdrtghomhdprhgtph
    htthhopehvlhgrughimhhirhdrohhlthgvrghnsehngihprdgtohhmpdhrtghpthhtohep
    gihirghonhhinhhgrdifrghnghesnhigphdrtghomhdprhgtphhtthhopegrnhgurhgvfi
    donhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:k79VZwgBeXFgKJ4a_0jCt_hxhl6LmPLYrOrymJ4FTsVMXRpUkrdggA>
    <xmx:k79VZ8BkFicNaUmRtUF0TEMFO-wt8xpgA8_fijiVtOlFvMNHzEyP-g>
    <xmx:k79VZxIC9KSS-DYHjlSZ7-BjmBUftlXWvZNFGLfE8HFn7O2F2Vb_sA>
    <xmx:k79VZzCf9mwfPtTKYPYvZhTBZRw-KJBwOmyYcPBfGdUlF7kgJf_FWg>
    <xmx:lL9VZ0btcnBu4SMcSmVsMQIbbj0h8B6UFYjbkZOuylDpsNJvSa5GWQnS>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 10:47:30 -0500 (EST)
Date: Sun, 8 Dec 2024 17:47:29 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Wei Fang <wei.fang@nxp.com>, tom@herbertland.com
Cc: Simon Horman <horms@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
 offload for i.MX95 ENETC
Message-ID: <Z1W_kSMUp3lsLPr_@shredder>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-2-wei.fang@nxp.com>
 <20241206092329.GH2581@kernel.org>
 <PAXPR04MB85101D0EE82ED8EEF48A588988312@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241206123030.GM2581@kernel.org>
 <PAXPR04MB85107FD857F1AB33BBE4F70988312@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB85107FD857F1AB33BBE4F70988312@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Fri, Dec 06, 2024 at 12:45:02PM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: 2024年12月6日 20:31
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> > <vladimir.oltean@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; Frank Li <frank.li@nxp.com>;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
> > offload for i.MX95 ENETC
> > 
> > On Fri, Dec 06, 2024 at 10:33:15AM +0000, Wei Fang wrote:
> > > > -----Original Message-----
> > > > From: Simon Horman <horms@kernel.org>
> > > > Sent: 2024年12月6日 17:23
> > > > To: Wei Fang <wei.fang@nxp.com>
> > > > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> > > > <vladimir.oltean@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > > > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > > > kuba@kernel.org; pabeni@redhat.com; Frank Li <frank.li@nxp.com>;
> > > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > > > Subject: Re: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
> > > > offload for i.MX95 ENETC
> > > >
> > > > On Wed, Dec 04, 2024 at 01:29:28PM +0800, Wei Fang wrote:
> > > > > ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
> > > > > 108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
> > > > > this capability is not defined in register, the rx_csum bit is added to
> > > > > struct enetc_drvdata to indicate whether the device supports Rx
> > checksum
> > > > > offload.
> > > > >
> > > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > > Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> > > > > ---
> > > > > v2: no changes
> > > > > v3: no changes
> > > > > v4: no changes
> > > > > v5: no changes
> > > > > v6: no changes
> > > > > ---
> > > > >  drivers/net/ethernet/freescale/enetc/enetc.c       | 14
> > ++++++++++----
> > > > >  drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
> > > > >  drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
> > > > >  .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
> > > > >  4 files changed, 17 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > > > index 35634c516e26..3137b6ee62d3 100644
> > > > > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > > > @@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct
> > enetc_bdr
> > > > *rx_ring,
> > > > >
> > > > >  	/* TODO: hashing */
> > > > >  	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
> > > > > -		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
> > > > > -
> > > > > -		skb->csum = csum_unfold((__force
> > __sum16)~htons(inet_csum));
> > > > > -		skb->ip_summed = CHECKSUM_COMPLETE;
> > > > > +		if (priv->active_offloads & ENETC_F_RXCSUM &&
> > > > > +		    le16_to_cpu(rxbd->r.flags) &
> > ENETC_RXBD_FLAG_L4_CSUM_OK)
> > > > {
> > > > > +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> > > > > +		} else {
> > > > > +			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
> > > > > +
> > > > > +			skb->csum = csum_unfold((__force
> > __sum16)~htons(inet_csum));
> > > > > +			skb->ip_summed = CHECKSUM_COMPLETE;
> > > > > +		}
> > > > >  	}
> > > >
> > > > Hi Wei,
> > > >
> > > > I am wondering about the relationship between the above and
> > > > hardware support for CHECKSUM_COMPLETE.
> > > >
> > > > Prior to this patch CHECKSUM_COMPLETE was always used, which seems
> > > > desirable. But with this patch, CHECKSUM_UNNECESSARY is conditionally
> > used.
> > > >
> > > > If those cases don't work with CHECKSUM_COMPLETE then is this a
> > bug-fix?
> > > >
> > > > Or, alternatively, if those cases do work with CHECKSUM_COMPLETE, then
> > > > I'm unsure why this change is necessary or desirable. It's my understanding
> > > > that from the Kernel's perspective CHECKSUM_COMPLETE is preferable to
> > > > CHECKSUM_UNNECESSARY.
> > > >
> > > > ...
> > >
> > > Rx checksum offload is a new feature of ENETC v4. We would like to exploit
> > this
> > > capability of the hardware to save CPU cycles in calculating and verifying
> > checksum.
> > >
> > 
> > Understood, but CHECKSUM_UNNECESSARY is usually the preferred option as
> > it
> > is more flexible, e.g. allowing low-cost calculation of inner checksums
> > in the presence of encapsulation.
> 
> I think you mean 'CHECKSUM_COMPLETE' is the preferred option. But there is no
> strong reason against using CHECKSUM_UNNECESSARY. So I hope to keep this patch.

I was also under the impression that CHECKSUM_COMPLETE is more desirable
than CHECKSUM_UNNECESSARY. Maybe Tom can help.

Tom:

If a device can report both CHECKSUM_UNNECESSARY and CHECKSUM_COMPLETE,
is there any advantage in reporting CHECKSUM_UNNECESSARY? The only
advantage I can think of is that when the kernel pulls headers (IPv6 for
example) it wouldn't need to compute their checksum in order to adjust
skb->csum, but I am not sure how critical that is.

I am asking because I am interested in knowing what is the
recommendation for future devices: Implement both or only
CHECKSUM_COMPLETE?

Original patch is here [1] and I did read your paper [2] and David's
presentation [3].

Thanks

[1] https://lore.kernel.org/netdev/20241204052932.112446-1-wei.fang@nxp.com/T/#mf89bb4c6c72e8dd4a697551cbc9485217366d013
[2] https://people.netfilter.org/pablo/netdev0.1/papers/UDP-Encapsulation-in-Linux.pdf
[3] https://www.netdevconf.info/1.1/proceedings/slides/miller-hardware-checksumming.pdf

