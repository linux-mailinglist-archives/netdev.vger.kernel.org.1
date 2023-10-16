Return-Path: <netdev+bounces-41579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466027CB593
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A03B20ECE
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3AC381B5;
	Mon, 16 Oct 2023 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L0jvdt5Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73927732
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 21:47:23 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2AAB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8g/XZ3TURhlEBYPyo/O9iO7CRWIq2OYQzaPSxnmD8Ow=; b=L0jvdt5QJ4MSX7dCnrd4SYstxq
	E/K5upaoh6/X2HmSXsjgDY//eeGDXr43wmV1XbNhHp+Mudilg7KWpo05GZjlwL3AlRRuiC/bI6hd4
	V44RSAT2sy+J/qbUUMgjeITJHcfFUZdanItF9ZwGjbN4vvwmiH4VPQTX6nB9an/Tx3DluN43HMNpx
	FjiGRkNzl+ii0IsFXsVEEEsXXhi0oCCPiJSoL04m/0LmezSq38v3MXB2AdE/G676YJKtCYBypx7Vi
	Cm6tk+LNGRT8GnMSMe5myz/lt1PV8wTVEAWD6+CkTlPpcY1rr+w37HEHm2iXQq4mbO2gIBBn7KZWI
	LQYhuvww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54658)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qsVQe-00029s-02;
	Mon, 16 Oct 2023 22:47:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qsVQd-00061G-Ks; Mon, 16 Oct 2023 22:47:11 +0100
Date: Mon, 16 Oct 2023 22:47:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Dumazet <edumazet@google.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, linux-imx@nxp.com,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: Ethernet issue on imx6
Message-ID: <ZS2vX9cUAbpx9X3t@shell.armlinux.org.uk>
References: <20231012193410.3d1812cf@xps-13>
 <ZShLX/ghL/b1Gbyz@shell.armlinux.org.uk>
 <20231013104003.260cc2f1@xps-13>
 <CANn89iKC9apkRG80eBPqsdKEkdawKzGt9EsBRLm61H=4Nn4jQQ@mail.gmail.com>
 <20231016155858.7af3490b@xps-13>
 <20231016173652.364997ae@xps-13>
 <CANn89iLxKQOY5ZA5o3d1y=v4MEAsAQnzmVDjmLY0_bJPG93tKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLxKQOY5ZA5o3d1y=v4MEAsAQnzmVDjmLY0_bJPG93tKQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 09:37:58PM +0200, Eric Dumazet wrote:
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 77c8e9cfb44562e73bfa89d06c5d4b179d755502..520436d579d66cc3263527373d754a206cb5bcd6
> 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -753,7 +753,6 @@ fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q *txq,
>         struct fec_enet_private *fep = netdev_priv(ndev);
>         int hdr_len = skb_tcp_all_headers(skb);
>         struct bufdesc_ex *ebdp = container_of(bdp, struct bufdesc_ex, desc);
> -       void *bufaddr;
>         unsigned long dmabuf;
>         unsigned short status;
>         unsigned int estatus = 0;
> @@ -762,11 +761,11 @@ fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q *txq,
>         status &= ~BD_ENET_TX_STATS;
>         status |= (BD_ENET_TX_TC | BD_ENET_TX_READY);
> 
> -       bufaddr = txq->tso_hdrs + index * TSO_HEADER_SIZE;
>         dmabuf = txq->tso_hdrs_dma + index * TSO_HEADER_SIZE;
> -       if (((unsigned long)bufaddr) & fep->tx_align ||
> -               fep->quirks & FEC_QUIRK_SWAP_FRAME) {
> -               memcpy(txq->tx_bounce[index], skb->data, hdr_len);
> +       if (fep->quirks & FEC_QUIRK_SWAP_FRAME) {
> +               void *bufaddr = txq->tso_hdrs + index * TSO_HEADER_SIZE;
> +
> +               memcpy(txq->tx_bounce[index], bufaddr, hdr_len);
>                 bufaddr = txq->tx_bounce[index];
> 
>                 if (fep->quirks & FEC_QUIRK_SWAP_FRAME)

I'm not sure this has any effect on the reported issue.

1. For imx6 based devices, FEC_QUIRK_SWAP_FRAME is not set.
2. fep->tx_align is 15, TSO_HEADER_SIZE is 256, and ->tso_hdrs is
   derived from dma_alloc_coherent() which will be page aligned.
   So this condition will also always be false.

So, while the patch looks correct to me, I think it will only have an
effect on imx28 based systems that set FEC_QUIRK_SWAP_FRAME, and for
that it looks correct to me, since the header is always located in
txq->tso_hdrs and we need to copy it from there into the "bounce"
buffer.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

