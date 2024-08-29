Return-Path: <netdev+bounces-123489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C45A9650D8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535731C20D74
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD51B8E9D;
	Thu, 29 Aug 2024 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="Ps17Oqv2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tcHp4T7C"
X-Original-To: netdev@vger.kernel.org
Received: from flow5-smtp.messagingengine.com (flow5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40754EAD5
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964280; cv=none; b=EsDB+jQB3xGn8tMOJHj0yqJlCrk6KCgrTHTnX3iF7T0nY4LeBuQy0YAwWNFJ5KRzi8HgBb8hCMM8/eYcu18IN5noJzWV60GnrsaatlhT3EewUpFc6Prcdeu1BaAq7lkALDeA5PyexhZxym6zyNmW7mXQP4DFVPIN7g1gxC9ShIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964280; c=relaxed/simple;
	bh=3c+LxsPSerQXVA35hjXHOGW3vBqqo1V8JbKGSzdJkAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtJyx887Jh3RKE646nRY5tXjHj2QfP16dTD2wSBh1wxAWay3tye/ciuI4+hZgkFwtreCdk8zq05qRoPsmrtKhNJCbq6xESLWXIUdsrBuAEbeA9Ac/PTA/JHhPlZE1A6xf1TNyaUBAQhrQ4iC8nKR7qicafuHdY4e02+sk1CDb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=Ps17Oqv2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tcHp4T7C; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailflow.nyi.internal (Postfix) with ESMTP id A77BC200EC0;
	Thu, 29 Aug 2024 16:44:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 29 Aug 2024 16:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724964274;
	 x=1724971474; bh=oGtWUSV+gMrRLDX6LoVsoBOQBNaadyxH7aU0cLUuoJg=; b=
	Ps17Oqv2Jg7sEtygs5+50rMDTeIh0NoS5R41M+lofmWN3O1kgY16P0qc1HRuji9O
	UQQQ2bokkROnVoYHm65cuH7ruLDcQMjU5ZGMRq7lDNozfJVioIeIMEY8z8bGAuOd
	NLGCn1NMOXX84MA2gcmkgMYEg2mBQy83CZQulJ06vInzah6KnjmWD9H9NkkmbUEX
	2w6uO71PKA4S5zAy2jnwGirEcEXo4vveBB/ujdZycc/tDFOB3YIpWc23vXOa+0hT
	fRvX52M+grcQHHZywwsiBY3urthfbSuCrq8zIWu4AnjiOY+/QbwlmTPIs4XIpaBo
	JKypgGFJXTgl1+M5JTSQDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724964274; x=
	1724971474; bh=oGtWUSV+gMrRLDX6LoVsoBOQBNaadyxH7aU0cLUuoJg=; b=t
	cHp4T7CvyhpJz1IndkD6sm3uIUv+n7lv/Ta+3b+f3c7IxFOBRq7Q3b87f0wxej0/
	W3t2hOMU0jpt05Eq1LvH6GjLAha2DSAf+79cKerWNCHMtU5LSVrkIeY0v+IqhmFp
	QXjHynfimrrKWmtQyN8yU3reb3fltr+av3jlkaDdXFvHATqxucZfUqjmdNhakS12
	tsq2r26tNNORC3j1dbgy2wSvxbZskGYJJQycjVKpHyvN0wMDlmI3Hvqkw3AcA5vj
	FIfFkl7pLb12mGwDS0xNwtGgxCdPWaHkJ/r1SEZJCOIZSiMlJQNjJm2pKoy03Vy8
	tTI8ELyDkAJH4nefqNNdg==
X-ME-Sender: <xms:sN3QZvydOqI04yOSu24hFG5-IcnbiHHL51EqEDYfST6Aq9jrMUbh-A>
    <xme:sN3QZnTIKzGWApWE2MAyXQ1MjwSaYCMHH0XVpf5sRVv-A_jBS4XI0b-dWmjiDvrnv
    -rxHEQrLSML4qzBEM4>
X-ME-Received: <xmr:sN3QZpXpDKA0V7U2pJtcX4t1JOvpX4YoV651HuXtAhcbcuVCbxsEmyX3qyF8iv1V6oFba4t4GoLF13JJ8OTAMbgUuxNXaA1OpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsoh
    guvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepveet
    gedtvddvhfdtkeeghfeffeehteehkeekgeefjeduieduueelgedtheekkeetnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhs
    ohguvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpthhtohepiedvpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghlsehnvhhiughirgdrtghomhdp
    rhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkh
    husggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjvhesjhhvohhssghurhhghhdrnhgvthdprh
    gtphhtthhopegrnhguhiesghhrvgihhhhouhhsvgdrnhgvthdprhgtphhtthhopehmkhhl
    sehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehmrghilhhhohhlrdhvihhntg
    gvnhhtseifrghnrgguohhordhfrhdprhgtphhtthhopehshhihrghmqdhsuhhnuggrrhdr
    shdqkhesrghmugdrtghomh
X-ME-Proxy: <xmx:sN3QZpi-mo82L3-TaehbRAK630S054uNUBe67OoYz9e_vwoc3Cl3xQ>
    <xmx:sN3QZhB7g-ySgsa3JzL4o5zdcLWB-JxOmVMvxy_g2LwDRBGZ6uDV3A>
    <xmx:sN3QZiJiMqh4UbyM9Y9Gxz8it-RATlKXrrmfSlcPxwLt-WUucFp0Sg>
    <xmx:sN3QZgDmk0d2GVPzNtzgr8FbKtveQBlqlgSPcxGxi6DdyhsXxnmUUQ>
    <xmx:st3QZp68RepUdrTxAb7BduliGhZsyOdumk4qvDe3ButuSY9pxUPD4Rq0>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 16:44:31 -0400 (EDT)
Date: Thu, 29 Aug 2024 22:44:29 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,	Andy Gospodarek <andy@greyhouse.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sunil Goutham <sgoutham@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,	Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>,	Clark Wang <xiaoning.wang@nxp.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,	Jijie Shao <shaojijie@huawei.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,	hariprasad <hkelam@marvell.com>,
 Ido Schimmel <idosch@nvidia.com>,	Petr Machata <petrm@nvidia.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,	MD Danish Anwar <danishanwar@ti.com>,
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software
 timestamp from drivers
Message-ID: <20240829204429.GA3708622@ragnatech.se>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>

Hi Gal,

Thanks for your work.

On 2024-08-29 17:42:53 +0300, Gal Pressman wrote:

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c 
> b/drivers/net/ethernet/renesas/ravb_main.c
> index c02fb296bf7d..c7ec23688d56 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1744,8 +1744,6 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  
>  	info->so_timestamping =
>  		SOF_TIMESTAMPING_TX_SOFTWARE |
> -		SOF_TIMESTAMPING_RX_SOFTWARE |
> -		SOF_TIMESTAMPING_SOFTWARE |
>  		SOF_TIMESTAMPING_TX_HARDWARE |
>  		SOF_TIMESTAMPING_RX_HARDWARE |
>  		SOF_TIMESTAMPING_RAW_HARDWARE;
> @@ -1756,6 +1754,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  		(1 << HWTSTAMP_FILTER_ALL);
>  	if (hw_info->gptp || hw_info->ccc_gac)
>  		info->phc_index = ptp_clock_index(priv->ptp.clock);
> +	else
> +		info->phc_index = 0;

I understand this work keeps things the same as they where before and 
that this change do not alter the existing behavior. But should not 
phc_index be left untouched here (kept at -1) as there are no ptp clock?

I think this might have been introduced in commit 7e09a052dc4e ("ravb: 
Exclude gPTP feature support for RZ/G2L") when the driver excluded ptp 
support for some devices. I suspect the so_timestamping mask should also 
depend on this check and only advertise hardware clocks if it indeed 
exists?

If my assumption is correct I can fix this on top. For this change the 
existing behavior is kept, so for drivers/net/ethernet/renesas,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  
>  	return 0;
>  }

-- 
Kind Regards,
Niklas Söderlund

