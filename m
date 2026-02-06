Return-Path: <netdev+bounces-257494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C55IeuvhWkRFAQAu9opvQ
	(envelope-from <netdev+bounces-257494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:10:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EB3FBD9A
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76DF73008A72
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2B355021;
	Fri,  6 Feb 2026 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="ZL1hlCT1"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE30F352C4D
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368664; cv=none; b=bcMTia3P4JoIRzEsQuCGTjoVWlpSe+N5KrHqwzgM4rRosm0N5pInUkIPNERzhbV2FVBKtl50kX8fE5cLtLA7TC7SmmXkKEsEay0PSVzKkh2DRNzSPDjwGOLPHS1OyG+ZrqIle/uJo75J9DRV0JQoVqXU8ccuepsXBzoeU7vrruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368664; c=relaxed/simple;
	bh=AB6d9l1yIdG4NDk9kfKMD6kDBLagwQfDi0FTPUgZfCc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WmJalyczl1axr5X1n+Leh8YPEPZc+22w/fWreQxLR5AKovBNsaxL88XyvRPBnFKSeHU4HZUhQpngm2MtcEPI0jk2kh1Wmmc8K6qVf9Yu8b012b07AHYwWBg8e1fJBeQYb3wMALSEsSHQBWPMA7TWfdfp4XVKez3zcFO+UVAL2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=ZL1hlCT1; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Wo5rtwWA+fxTOlC1JLIKn6B1LO6yH0YPj5NB9h/LCHI=; b=ZL1hlCT1JEmEX2xB2lOsRtQzI3
	bY/Q1QJHpEiAX/TVR0cA8phCN0YsANgXVT/Nex8t7+wJfmwWX70Nm2HrvY0RIDB9UvfdOcCgbNodC
	j76NcGE2BiyLahLbmmxO5WjlzfEVgvndGenr3L7xqLokdMoIHeliaZVPemCYQ/jZINSk+tSL8RwwW
	uq/pMQiAE2XaW/PxPpxNOi6sOoa46Y0xefgssZAgYmPO/q8jHO460lVPjCi4LoqItD0Crgz4LY4ot
	/xQNRL22iT/hn44SQVV0bGETxXq6/oCljiCWMO6yFL7+ldlmfd0GGEAw5JoXVdXH1b14ba9OTL+MH
	uQzX1r3g==;
Date: Fri, 06 Feb 2026 10:05:14 +0100 (CET)
Message-Id: <20260206.100514.85172532893288505.rene@exactco.de>
To: seanga2@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [PATCH] net: sunhme: Fix sbus regression
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <cc269d9f-9a06-6623-e412-d04ecb7b4f74@gmail.com>
References: <20260205.170959.89574674688839340.rene@exactco.de>
	<cc269d9f-9a06-6623-e412-d04ecb7b4f74@gmail.com>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[exactco.de:s=x];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257494-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[exactco.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rene@exactco.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[exactco.de:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.2:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,t2linux.com:url,patreon.com:url,1f:email]
X-Rspamd-Queue-Id: 92EB3FBD9A
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 20:41:11 -0500, Sean Anderson <seanga2@gmail.com> wrote:

> On 2/5/26 11:09, René Rebe wrote:
> > Commit cc216e4b44ce ("net: sunhme: Switch SBUS to devres") changed
> > explicit sized of_ioremap with BMAC_REG_SIZEs to
> > devm_platform_ioremap_resource mapping all the resource. However,
> > this does not work on my Sun Ultra 2 with SBUS HMEs:
> > hme f0072f38: error -EBUSY: can't request region for resource [mem
> > 0x1ffe8c07000-0x1ffe8c0701f]
> > hme f0072f38: Cannot map TCVR registers.
> > hme f0072f38: probe with driver hme failed with error -16
> > hme f007ab44: error -EBUSY: can't request region for resource [mem
> > 0x1ff28c07000-0x1ff28c0701f]
> > hme f007ab44: Cannot map TCVR registers.
> > hme f007ab44: probe with driver hme failed with error -16
> > Turns out the open-firmware resources overlap, at least on this
> > machines and PROM version:
> > hexdump /proc/device-tree/sbus@1f,0/SUNW,hme@2,8c00000/reg:
> > 00 00 00 02 08 c0 00 00  00 00 01 08
> > 00 00 00 02 08 c0 20 00  00 00 20 00
> > 00 00 00 02 08 c0 40 00  00 00 20 00
> > 00 00 00 02 08 c0 60 00  00 00 20 00
> > 00 00 00 02 08 c0 70 00  00 00 00 20
> > And the driver previously explicitly mapped way smaller mmio regions:
> > /proc/iomem:
> > 1ff28c00000-1ff28c00107 : HME Global Regs
> > 1ff28c02000-1ff28c02033 : HME TX Regs
> > 1ff28c04000-1ff28c0401f : HME RX Regs
> > 1ff28c06000-1ff28c0635f : HME BIGMAC Regs
> > 1ff28c07000-1ff28c0701f : HME Tranceiver Regs
> > Quirk this specific issue by truncating the previous resource to not
> > overlap into the TCVR registers.
> > Fixes: cc216e4b44ce ("net: sunhme: Switch SBUS to devres")
> > Signed-off-by: René Rebe <rene@exactco.de>
> > ---
> > Tested on Sun Ultra 2 running T2/Linux.
> > Alternatively we could explicitly size all regions, or check overlap
> > in startup code (I also already have a patch for that, too).
> 
> What does this look like?

This only checks for "sorted" overlaps w/ the previous res, but given
they probably usually are and it catches this case, ...

The downside is, it may break other devices, I only test booted this
on an Ultra 2 and Ultra 30. On the U2 it fixes the hme ethernet,
too. On the U30 it causes an eprom region to be truncated. I probably
should investiage that and test boot on all my SPARC systems before we
consider this. That's why I sent the trivial hme driver hotfix first.
Alternatively we could also overwrite all sbus res in the hme driver
with the previously used known good sizes. I can send a patch for
that, too if you like:

diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index f53092b07b9e..8bd405cbc04f 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -412,6 +412,15 @@ static void __init build_device_resources(struct platform_device *op,
 			r->start = result;
 			r->end = result + size - 1;
 			r->flags = flags;
+
+			/* check for and correct simple bogusly overlapping resources */
+			if (index > 0 &&
+			    op->resource[index-1].start <= r->end &&
+			    op->resource[index-1].end > r->start) {
+				printk(KERN_WARNING "%pOF: prev regs overlap (%x), limiting %x.\n",
+				       op->dev.of_node, op->resource[index-1].end, r->start - 1);
+				op->resource[index-1].end = r->start - 1;
+			}
 		}
 		r->name = op->dev.of_node->full_name;
 	}


> > ---
> > --- linux-6.18/drivers/net/ethernet/sun/sunhme.c.vanilla 2026-02-05
> > --- 11:50:33.288906134 +0100
> > +++ linux-6.18/drivers/net/ethernet/sun/sunhme.c 2026-02-05
> > 11:55:22.541384377 +0100
> > @@ -2551,6 +2551,9 @@
> >   		goto err_out_clear_quattro;
> >   	}
> >   +	/* BIGMAC may have bogus sizes */
> > + if ((op->resource[3].end - op->resource[3].start) >= BMAC_REG_SIZE)
> > + op->resource[3].end = op->resource[3].start + BMAC_REG_SIZE - 1;
> >   	hp->bigmacregs = devm_platform_ioremap_resource(op, 3);
> >   	if (IS_ERR(hp->bigmacregs)) {
> >   		dev_err(&op->dev, "Cannot map BIGMAC registers.\n");
> > 
> 
> Reviewed-by: Sean Anderson <seanga2@gmail.com>

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

