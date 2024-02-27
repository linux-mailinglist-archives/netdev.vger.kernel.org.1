Return-Path: <netdev+bounces-75420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B8869DBF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C742825CD
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159B95B1E2;
	Tue, 27 Feb 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY/hn0NF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ED14F5ED
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055102; cv=none; b=XFNc23kNCCG80zeyuNPJizgx83oMb0IpABc3hqD6+MZyO+9nLZ/VOH21lGb/syPDtsGtMaPw2mb16Sc6LjWRXraU9CEbzR/Am/B+DtZiRax+Telvxn6ehndlsVdSplQwxtyMc3j1YfAYZIIklUJl7HlLHITx7wRzSqsHySnlg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055102; c=relaxed/simple;
	bh=Vh0Ez1JrBKiIyidqjd4EXVU+cnkiUF48ZPkt4g2S6n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaKrT9aXyDoJ3PMgxyxosbUBkrCD+9+wqe5xeWgwMmL9voBgw7xZDLRcriLqZvkxRdsGt/1I6L34SGjIt6dZhLzic7NyXkoZ07Bfqly4Zt4OSfMniiaPOqB09jKz/CdUad6+pZT+PjvL+/g53nzo8MFhBuN1CUrIurp7GxwDeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY/hn0NF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41B4C433F1;
	Tue, 27 Feb 2024 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709055101;
	bh=Vh0Ez1JrBKiIyidqjd4EXVU+cnkiUF48ZPkt4g2S6n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HY/hn0NF8tK8v5Wb0dzqt4bBlvBm1w1rbAy0uddtaJFqd+g36xlMIpccd2TvM6+TW
	 dVtUaUXLptA5SvNmnTiN+MSUvthRwb0Sq6YT85w4nI0cjXr57MBizrjH+3AKQsZMQU
	 STjOtvi3PfJs553kCYKDZOE+g5+WWBXz2xGGM9CHttjtwk32TjtByihUQS7JvoBihr
	 gLD1mZDpE5gty3tGO98lINFTtimiWSVxDBOH5H6YVwdQ534kdU0y00uJbV7aedGfEL
	 HgXmCV110uqjQGF5WFCsKa8y0xlpeL9jti71v83eM3ai+44j1JVQ/0RkZb1w0nULye
	 IY+4Pmfby/I0A==
Date: Tue, 27 Feb 2024 17:31:36 +0000
From: Simon Horman <horms@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
	vigneshr@ti.com, arnd@arndb.de, wsa+renesas@sang-engineering.com,
	vladimir.oltean@nxp.com, andrew@lunn.ch, dan.carpenter@linaro.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	jan.kiszka@siemens.com
Subject: Re: [PATCH net-next v3 10/10] net: ti: icssg-prueth: Add ICSSG
 Ethernet driver for AM65x SR1.0 platforms
Message-ID: <20240227173136.GH277116@kernel.org>
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-11-diogo.ivo@siemens.com>
 <20240222133103.GB960874@kernel.org>
 <39ca8e5f-7fba-4f8c-a0f7-59153382bcf3@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ca8e5f-7fba-4f8c-a0f7-59153382bcf3@siemens.com>

On Tue, Feb 27, 2024 at 12:05:14PM +0000, Diogo Ivo wrote:
> On 2/22/24 13:31, Simon Horman wrote:
> > On Wed, Feb 21, 2024 at 03:24:16PM +0000, Diogo Ivo wrote:
> > > Add the PRUeth driver for the ICSSG subsystem found in AM65x SR1.0 devices.
> > > The main differences that set SR1.0 and SR2.0 apart are the missing TXPRU
> > > core in SR1.0, two extra DMA channels for management purposes and different
> > > firmware that needs to be configured accordingly.
> > > 
> > > Based on the work of Roger Quadros, Vignesh Raghavendra and
> > > Grygorii Strashko in TI's 5.10 SDK [1].
> > > 
> > > [1]: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ti.com%2Fcgit%2Fti-linux-kernel%2Fti-linux-kernel%2Ftree%2F%3Fh%3Dti-linux-5.10.y&data=05%7C02%7Cdiogo.ivo%40siemens.com%7Cfebc5e0f6a1b476c366d08dc33aa89ee%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638442054773860177%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=YxcCwUMV7Zzyycb1Ss6xoCq9BK1vYsvuoF30XXA2tRI%3D&reserved=0
> > > 
> > > Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> > 
> > ...
> > 
> 
> ...
> 
> > > +	config.rx_flow_id = emac->rx_flow_id_base; /* flow id for host port */
> > > +	config.rx_mgr_flow_id = emac->rx_mgm_flow_id_base; /* for mgm ch */
> > > +	config.rand_seed = get_random_u32();
> > 
> > Hi Diogo and Jan,
> > 
> > The fields of config above are all __le32.
> > However the last three lines above assign host byte-order values to these
> > fields. This does not seem correct.
> > 
> > This is flagged by Sparse along with some problems.
> > Please ensure that new Sparse warnings are not introduced.
> > 
> 
> You are correct, thank you for catching the inconsistency, this will be
> fixed in v4.
> 
> ...
> 
> > > +static int emac_send_command_sr1(struct prueth_emac *emac, u32 cmd)
> > > +{
> > > +	dma_addr_t desc_dma, buf_dma;
> > > +	struct prueth_tx_chn *tx_chn;
> > > +	struct cppi5_host_desc_t *first_desc;
> > > +	u32 *data = emac->cmd_data;
> > > +	u32 pkt_len = sizeof(emac->cmd_data);
> > > +	void **swdata;
> > > +	int ret = 0;
> > > +	u32 *epib;
> > 
> > In new Networking code please express local variables in reverse xmas tree
> > order - longest line to shortest.
> 
> Noted, will fix for v4.
> 
> ...
> 
> > There is also one such problem in Patch 06/10.
> Here xmastree reported the same problem in patch 08/10 rather than 06/10, I
> assumed you meant that one.

Yes, probably.

Thanks.

