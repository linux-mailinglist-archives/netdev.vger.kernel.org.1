Return-Path: <netdev+bounces-143253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667E59C1AAB
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD133B23660
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BBA1E25EA;
	Fri,  8 Nov 2024 10:30:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FB1F706D;
	Fri,  8 Nov 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061806; cv=none; b=Kzd5rDtzK7/ux8z8u+nmMKOrf5NL5P1IzxiRysyRiIKXowfxrQ4ni+R/KmJXa+XGQa3jcXlSmD4dX+KNiWvyPfxaI2qHUYOw5KwD3sQAumsTxp03eL5O1bAVK/H7pKhqxs+ClVwIlo9G0Mq/hAu+U5e9fSZIFBEJaghO28ukyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061806; c=relaxed/simple;
	bh=0KEauaZdc7iNy8LfrhzAhwMnl4u2pDYZpJto3PxhWNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+Nm+TV3/co2k3UuqkqaJSomwo79a2hbmLQTdS5cjav5Z6XIt4+v6YlmpZvXqGEmsdHKcgRdiBY9XppLNvnv6q8iME+QZbFXjTfDvUTkm+veDzAc3KpMg1+dgJgE7qsg/PYdL5aTHJzvPUQZMppYAHkWZ1jPbTyumDM0QINzubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XlFZ20sT5z9sSR;
	Fri,  8 Nov 2024 11:30:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v0IgesT6yvwB; Fri,  8 Nov 2024 11:30:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XlFZ14LVSz9rvV;
	Fri,  8 Nov 2024 11:30:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B07E8B781;
	Fri,  8 Nov 2024 11:30:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ff_n68pslpCE; Fri,  8 Nov 2024 11:30:01 +0100 (CET)
Received: from [192.168.232.253] (unknown [192.168.232.253])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D7FE48B77A;
	Fri,  8 Nov 2024 11:30:00 +0100 (CET)
Message-ID: <2010cc7a-7f49-4c5b-b684-8e08ff8d17ed@csgroup.eu>
Date: Fri, 8 Nov 2024 11:30:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
To: Linus Walleij <linus.walleij@linaro.org>,
 kernel test robot <lkp@intel.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 netdev <netdev@vger.kernel.org>
Cc: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <202410301531.7Vr9UkCn-lkp@intel.com>
 <CACRpkdbW5kheaWPzKip9ucEwK2uv+Cmf5SwT1necfa3Ynct6Ag@mail.gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <CACRpkdbW5kheaWPzKip9ucEwK2uv+Cmf5SwT1necfa3Ynct6Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/11/2024 à 09:18, Linus Walleij a écrit :
> On Wed, Oct 30, 2024 at 8:05 AM kernel test robot <lkp@intel.com> wrote:
> 
>> tree:   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C5a1ff6cef1f642fba00a08dcffce0903%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638666507603442752%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=2dgpku3%2BPjovwZxpedYowAAB%2BR%2FeyxOc0Ys3kE0KK6E%3D&reserved=0 master
>> head:   c1e939a21eb111a6d6067b38e8e04b8809b64c4e
>> commit: b28d1ccf921a4333be14017d82066386d419e638 powerpc/io: Expect immutable pointer in virt_to_phys() prototype
> 
> Ugh Stanislav do you have ideas around this one?
> 
>>     drivers/net/ethernet/freescale/ucc_geth.c:244:21: sparse:     got restricted __be32 [noderef] __iomem *
>>     drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem * @@
> 
> They all look the same, it's from this:
> 
> static void set_mac_addr(__be16 __iomem *reg, u8 *mac)
> {
>      out_be16(&reg[0], ((u16)mac[5] << 8) | mac[4]);
>      out_be16(&reg[1], ((u16)mac[3] << 8) | mac[2]);
>      out_be16(&reg[2], ((u16)mac[1] << 8) | mac[0]);
> }
> 
> Is it simply that we need a paranthesis extra around the thing casted
> to (u16) else it becomes u32?

Not at all. The one you point here are:

drivers/net/ethernet/freescale/ucc_geth.c:405:22: warning: incorrect 
type in argument 1 (different base types)
drivers/net/ethernet/freescale/ucc_geth.c:405:22:    expected unsigned 
short volatile [noderef] [usertype] __iomem *addr
drivers/net/ethernet/freescale/ucc_geth.c:405:22:    got restricted 
__be16 [noderef] [usertype] __iomem *
drivers/net/ethernet/freescale/ucc_geth.c:406:22: warning: incorrect 
type in argument 1 (different base types)
drivers/net/ethernet/freescale/ucc_geth.c:406:22:    expected unsigned 
short volatile [noderef] [usertype] __iomem *addr
drivers/net/ethernet/freescale/ucc_geth.c:406:22:    got restricted 
__be16 [noderef] [usertype] __iomem *
drivers/net/ethernet/freescale/ucc_geth.c:407:22: warning: incorrect 
type in argument 1 (different base types)
drivers/net/ethernet/freescale/ucc_geth.c:407:22:    expected unsigned 
short volatile [noderef] [usertype] __iomem *addr
drivers/net/ethernet/freescale/ucc_geth.c:407:22:    got restricted 
__be16 [noderef] [usertype] __iomem *
drivers/net/ethernet/freescale/ucc_geth.c:449:23: warning: incorrect 
type in argument 1 (different base types)
drivers/net/ethernet/freescale/ucc_geth.c:449:23:    expected restricted 
__be16 [noderef] [usertype] __iomem *reg
drivers/net/ethernet/freescale/ucc_geth.c:449:23:    got unsigned short 
[noderef] __iomem *

The problem is the __be16 in the function prototype.

	set_mac_addr(&p_82xx_addr_filt->taddr.h, p_enet_addr);

p_82xx_addr_filt->taddr.h is a u16
and out_be16() expects a u16*

So the following fixes the above warnings:

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c 
b/drivers/net/ethernet/freescale/ucc_geth.c
index ab421243a419..bbfc289dd73c 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -400,7 +400,7 @@ static void put_enet_addr_container(struct 
enet_addr_container *enet_addr_cont)
  	kfree(enet_addr_cont);
  }

-static void set_mac_addr(__be16 __iomem *reg, u8 *mac)
+static void set_mac_addr(u16 __iomem *reg, u8 *mac)
  {
  	out_be16(&reg[0], ((u16)mac[5] << 8) | mac[4]);
  	out_be16(&reg[1], ((u16)mac[3] << 8) | mac[2]);



For the other ones, most of them are because out_beXX() expects uXX* not 
__beXX *.

It looks like the warnings go away if you replace out_be32() by 
iowrite32be(), which has been possible since commit 894fa235eb4c 
("powerpc: inline iomap accessors") (out_beXX/in_beXX should anyway not 
be used outside arch/powerpc/):

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c 
b/drivers/net/ethernet/freescale/ucc_geth.c
index ab421243a419..625b58b3efc8 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -241,12 +241,12 @@ static struct sk_buff *get_new_skb(struct 
ucc_geth_private *ugeth,
  		    (((unsigned)skb->data) & (UCC_GETH_RX_DATA_BUF_ALIGNMENT -
  					      1)));

-	out_be32(&((struct qe_bd __iomem *)bd)->buf,
+	iowrite32be(
  		      dma_map_single(ugeth->dev,
  				     skb->data,
  				     ugeth->ug_info->uf_info.max_rx_buf_length +
  				     UCC_GETH_RX_DATA_BUF_ALIGNMENT,
-				     DMA_FROM_DEVICE));
+				     DMA_FROM_DEVICE), &((struct qe_bd __iomem *)bd)->buf);

  	out_be32((u32 __iomem *)bd,
  			(R_E | R_I | (in_be32((u32 __iomem*)bd) & R_W)));


Christophe

