Return-Path: <netdev+bounces-65342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68F83A1BA
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 07:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88671F2BD33
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 06:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA4E579;
	Wed, 24 Jan 2024 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b="kwt0zNIS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pWtcAuPL"
X-Original-To: netdev@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E738134CA
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076210; cv=none; b=hC1ZKUuaZvXLtD41knweUMIEdX6ya/WmrKYz+XSFX4Iyo2bMDXgosF51sGbMbkQ5zarvLLZ3RekvYZrsqQ1W5MP/gpK6LdUuOEEuYxM2eFDsgjGi4JKGmsojH4dlPUth9fy/HvCanMu7h2MvxLSaK5UBtHxkIjfbQvNKiECCMoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076210; c=relaxed/simple;
	bh=yO7NULQPNditoqIllgjh+F3suBJeQSwyTiCkhWtCq9U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QQ2CrF2Te3b3QIOF1Qdf3qZ51NY5Sw4lKz8IoYw6r9hNr4eLHkZCeW5c0JHHxFXpu8XEUe0ymO1Y1Wg0TReipABUrV/+ysj5moRO6Wo9eXPj8i2VxNaW3vdx8G1Z26Yc0lBYkhHn0ts+wggFy1nKPnmGZGNzciocldaLSobOhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au; spf=pass smtp.mailfrom=traverse.com.au; dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b=kwt0zNIS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pWtcAuPL; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=traverse.com.au
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 7099C5C0185;
	Wed, 24 Jan 2024 01:03:26 -0500 (EST)
Received: from imap41 ([10.202.2.91])
  by compute3.internal (MEProxy); Wed, 24 Jan 2024 01:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1706076206; x=
	1706162606; bh=xvGP4upj9rs1Ae3bkvo1IjgomayISWKyCvVmXmg1Ikw=; b=k
	wt0zNISP3LRW0v/LnT+7yxXYjVcZ6etApL1BfBhCZX5DwZ/xK7RNKkNps+l8EowH
	wSY1Lv5vjYQTqc2huMSDfXvtt4gtOtFGL+EXQm/O19Ab84fqWhvkl8/k91pCy2/T
	09b+8c23LLBBMCmoqox0hkacB4v6Ku7r6aIdWxvjYpobX6FObceOoZaYAU1nEze2
	A0LoxI8xdLcGvtbGBdLsP6bBOTwjXynWv58wNL/s2q3bxtum/J5CqXIAsdnHvwU5
	Md+GSLgJPwCk2JeLqom5XKWmoZ+N183Jz5zZtwF62F/7LhusZdv1r8rBUqY3c9G2
	HLQluH6GcwoqgMmxMnSNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706076206; x=1706162606; bh=xvGP4upj9rs1Ae3bkvo1IjgomayI
	SWKyCvVmXmg1Ikw=; b=pWtcAuPL//x9azikomcI9KQQFmYiVUsDiYEl/pPxVylj
	9+XC+MYnzsnSnF6d3cbYfWvxHE1ge1pNYz8hbE20guUurqMdmgoyhzw8IBDdywwZ
	yCl6/iuJSIS+txcLlhoBXvF27vpuPhHePQNS7uwT3AWvQN5Q2gzKG4FbEb2SnCDI
	8AsHJsaGbLEleiSE4/w2nbIsog1w5Ari+4guiBWi0R4O23vaZ1dSs7U2MmWKz1US
	Ghh8nNDUyYir1LNx4BlJayg2O6pUXYBwyNa5vyuIBcmsYwQ2+qiLiLxp0UwIi9zE
	2K8ywQJPEavS/rRWDx67mg2Hb2hS7UFUIWHw3NKleA==
X-ME-Sender: <xms:LqiwZRgq-0lMncN44RUf9iXgOGe9JcQ-lkw9QHkuMu1lUscR3TS6gA>
    <xme:LqiwZWCY2A3XFTcGuEIMq8kSq1V0ErMfoiDzd01ELFgS0I_XTh_TxTwIqvETdOQ2e
    TwCJcvWB-rim73-0YY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    thhhvgifucfotgeurhhiuggvfdcuoehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
    eqnecuggftrfgrthhtvghrnhepueeukefffeetfeeggfeftdevieekfeeffeeuvdevtdeu
    udevieeileekieehleejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmpdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
X-ME-Proxy: <xmx:LqiwZRF5_y38rnq4bpx-iTpQbdgyZQlElG7rmwwFM4tnJUOUCCwaAg>
    <xmx:LqiwZWQ-G7ugHCdu8azi9yFoB9Le05Mf-i33q-yIR0SPGL0VSbkVYA>
    <xmx:LqiwZewsG52B6DqIf0cE8PoDWfprSjZ_vGxzOgJwtpX0lSiVDcTHhw>
    <xmx:LqiwZUZH4tA2373fM51uh90CPG3-NFW1lG2ug77NgWsQOCio0ki7Zw>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 158622340080; Wed, 24 Jan 2024 01:03:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <70f0dcd9-1906-4d13-82df-7bbbbe7194c6@app.fastmail.com>
In-Reply-To: <20231124102805.587303-2-ioana.ciornei@nxp.com>
References: <20231124102805.587303-1-ioana.ciornei@nxp.com>
 <20231124102805.587303-2-ioana.ciornei@nxp.com>
Date: Wed, 24 Jan 2024 17:02:48 +1100
From: "Mathew McBride" <matt@traverse.com.au>
To: "Ioana Ciornei" <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] dpaa2-eth: increase the needed headroom to account for
 alignment
Content-Type: text/plain

Hi Ioana,

On Fri, Nov 24, 2023, at 9:28 PM, Ioana Ciornei wrote:
> Increase the needed headroom to account for a 64 byte alignment
> restriction which, with this patch, we make mandatory on the Tx path.
> The case in which the amount of headroom needed is not available is
> already handled by the driver which instead sends a S/G frame with the
> first buffer only holding the SW and HW annotation areas.

This change appears to have broken data flow from virtual machines, via vhost-net that egress (across a bridge) via a dpaa2 Ethernet port

For example:

brctl addbr br-vm
brctl addif br-vm eth0
ip link set br-vm up
ip link set eth0 up
echo 'allow br-vm' > /etc/qemu/bridge.conf

qemu-system-aarch64 -nographic -M virt -cpu host --enable-kvm \
        -drive file=openwrt-armsr-armv8-generic-ext4-combined.img,format=raw,index=0,media=disk \
        -device "virtio-net,netdev=landev,disable-legacy=off,disable-modern=off" \
        -netdev "tap,id=landev,helper=/usr/lib/qemu/qemu-bridge-helper --br=br-vm,vhost=on"

I have reproduced the issue across different series of kernels (e.g the issue appears in 6.1.66 when this change was backported) and different host and guest userspaces (Debian and OpenWrt). The platform is our LS1088A board (Ten64).

The VM is able to receive frames from the bridged interface, but no Ethernet frames that originate from the VM will be transmitted by the dpaa2_eth interface.

If vhost-net acceleration is disabled (vhost=off on the QEMU command line), the VM is able to communicate with the network, but with reduced performance.

The frames in question fail the TX alignment check in dpaa2_eth_build_single_fd [if (aligned_start >= skb->head)] ( https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c#L1084 )

fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd alignment issue, aligned_start=ffff008002e09140 skb->head=ffff008002e09180
fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd data=ffff008002e09200
fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd is cloned=0
dpaa2_eth_build_single_fdskb len=150 headroom=128 headlen=150 tailroom=42
mac=(128,14) net=(142,48) trans=190
shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
csum(0xd19f ip_summed=0 complete_sw=1 valid=1 level=0)
hash(0x0 sw=0 l4=0) proto=0x86dd pkttype=2 iif=15
dpaa2_eth_build_single_fddev name=eth0 feat=0x0002010000015833
dpaa2_eth_build_single_fdskb headroom: 00000000: 80 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dpaa2_eth_build_single_fdskb headroom: 00000010: 00 00 00 00 00 00 00 02 41 a4 01 00 00 00 00 00
dpaa2_eth_build_single_fdskb headroom: 00000020: 01 00 00 0d 14 00 00 00 00 00 00 00 38 a3 01 00
dpaa2_eth_build_single_fdskb headroom: 00000030: 00 00 00 00 00 00 00 02 43 a4 01 00 00 00 00 00
dpaa2_eth_build_single_fdskb headroom: 00000040: 02 00 00 0d 14 00 00 00 00 00 00 00 38 a3 01 00
dpaa2_eth_build_single_fdskb headroom: 00000050: 00 00 00 00 8c a2 01 00 00 00 00 00 00 00 00 02
dpaa2_eth_build_single_fdskb headroom: 00000060: 45 a4 01 00 00 00 00 00 02 00 00 0d 00 00 00 00
dpaa2_eth_build_single_fdskb headroom: 00000070: 00 00 00 00 38 a3 01 00 00 00 00 00 8c a2 01 00
dpaa2_eth_build_single_fdskb linear:   00000000: 33 33 00 00 00 16 52 54 00 12 34 56 86 dd 60 00
dpaa2_eth_build_single_fdskb linear:   00000010: 00 00 00 60 00 01 00 00 00 00 00 00 00 00 00 00
dpaa2_eth_build_single_fdskb linear:   00000020: 00 00 00 00 00 00 ff 02 00 00 00 00 00 00 00 00
dpaa2_eth_build_single_fdskb linear:   00000030: 00 00 00 00 00 16 3a 00 05 02 00 00 01 00 8f 00
dpaa2_eth_build_single_fdskb linear:   00000040: 33 d1 00 00 00 04 03 00 00 00 ff 02 00 00 00 00
dpaa2_eth_build_single_fdskb linear:   00000050: 00 00 00 00 00 01 ff 00 00 00 04 00 00 00 ff 02
dpaa2_eth_build_single_fdskb linear:   00000060: 00 00 00 00 00 00 00 00 00 01 ff 12 34 56 04 00
dpaa2_eth_build_single_fdskb linear:   00000070: 00 00 ff 05 00 00 00 00 00 00 00 00 00 00 00 00
dpaa2_eth_build_single_fdskb linear:   00000080: 00 02 04 00 00 00 ff 02 00 00 00 00 00 00 00 00
dpaa2_eth_build_single_fdskb linear:   00000090: 00 00 00 00 00 02
dpaa2_eth_build_single_fdskb tailroom: 00000000: 08 00 45 10 00 68 cf fa 40 00 40 06 fd 66 ac 10
dpaa2_eth_build_single_fdskb tailroom: 00000010: 0a 80 ac 10 0a 7e 00 16 48 2a 6a 6d 3f 42 26 8c
dpaa2_eth_build_single_fdskb tailroom: 00000020: ae 31 50 18 07 7a 6d 79 00 00

From the patch description, it sounds like this situation should be handled by converting to a S/G frame in __dpaa2_eth_tx ? Or is the problem elsewhere?

Best Regards,
Matt

> Without this patch, we can empirically see data corruption happening
> between Tx and Tx confirmation which sometimes leads to the SW
> annotation area being overwritten.
> 
> Since this is an old IP where the hardware team cannot help to
> understand the underlying behavior, we make the Tx alignment mandatory
> for all frames to avoid the crash on Tx conf. Also, remove the comment
> that suggested that this is just an optimization.
> 
> This patch also sets the needed_headroom net device field to the usual
> value that the driver would need on the Tx path:
> - 64 bytes for the software annotation area
> - 64 bytes to account for a 64 byte aligned buffer address
> 
> Fixes: 6e2387e8f19e ("staging: fsl-dpaa2/eth: Add Freescale DPAA2 Ethernet driver")
> Closes: https://lore.kernel.org/netdev/aa784d0c-85eb-4e5d-968b-c8f74fa86be6@gin.de/
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
> - squashed patches #1 and #2
> 
> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 8 ++++----
> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h | 2 +-
> 2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> index 15bab41cee48..774377db0b4b 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> @@ -1073,14 +1073,12 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
> dma_addr_t addr;
>  
> buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
> -
> - /* If there's enough room to align the FD address, do it.
> - * It will help hardware optimize accesses.
> - */
> aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
>   DPAA2_ETH_TX_BUF_ALIGN);
> if (aligned_start >= skb->head)
> buffer_start = aligned_start;
> + else
> + return -ENOMEM;
>  
> /* Store a backpointer to the skb at the beginning of the buffer
> * (in the private data area) such that we can release it
> @@ -4967,6 +4965,8 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
> if (err)
> goto err_dl_port_add;
>  
> + net_dev->needed_headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
> +
> err = register_netdev(net_dev);
> if (err < 0) {
> dev_err(dev, "register_netdev() failed\n");
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
> index bfb6c96c3b2f..834cba8c3a41 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
> @@ -740,7 +740,7 @@ static inline bool dpaa2_eth_rx_pause_enabled(u64 link_options)
>  
> static inline unsigned int dpaa2_eth_needed_headroom(struct sk_buff *skb)
> {
> - unsigned int headroom = DPAA2_ETH_SWA_SIZE;
> + unsigned int headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
>  
> /* If we don't have an skb (e.g. XDP buffer), we only need space for
> * the software annotation area
> 

