Return-Path: <netdev+bounces-66122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B442E83D555
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D43D281234
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3119A60876;
	Fri, 26 Jan 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="fGDQIfac"
X-Original-To: netdev@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F912E6F
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255497; cv=none; b=ScG05yxYW/Gc6j0qXFWJEThOXNZbTZLkMUHCIN2gKy8LdbpkdrL8FlyXMJO279+VOIqtp+a/s7P0eWIp6iMUNqJ52tniimNfOfDclJKomgXqbPbWmGt9uF/rckoLfN+3OpkE3OW165cdiHXycmfNEFDRZW7ktVCu7IBTxNCU/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255497; c=relaxed/simple;
	bh=NlPJC69CvZCI6rU+2Z40ltj34AwzuC9fpSCO22pXkkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjooVv1tKAuurL13ctUMU+23VNw8+SiuzvAgEaqgMORN4QapeXx+Co3krVNdoBkWCD646cE/6WQjl3WwxeR2+P7QgoipPJtbQkwCSwTzR+BqlCYuaKS4qFpoT/bcbZD+Gjwtfk4vXIhxq0iIZ2Eo50rzsp4hPlFe75vOYi0pXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=fGDQIfac; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 69CAC18BE7D;
	Fri, 26 Jan 2024 08:51:23 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706255483; bh=NlPJC69CvZCI6rU+2Z40ltj34AwzuC9fpSCO22pXkkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fGDQIfacHYrl6gY7ZP+NQuNtoHp2q99ClPjRaXFdsZaVmxjk/pRjwPgvKLp6VqsQK
	 RIxXc2rsEslr4ZMKj3QCGhKJrZ9Jh3q9yygyJA6RLCAGq2DOYfhLFTf8UvvqkHxmTT
	 +GTpfz4GJHwKaq39+oxi/5mJtfK6Fx8ghu427XsgIPQCk2/zh8m8V3QTzqCY4xqA1z
	 i2XBb3QRxj2betSQD7sc6z15Sw9YtI3pI+sis+I8/asTxtzFy6ZDaz7L/3uaQXQlqR
	 QCxQ+2eA4IHMhxvEptKyZ5/fMTn8/LvUc1KblZccnVrgfS4QfPegTsAMEx+nWLUNMJ
	 0qY47CSikt4+A==
Date: Fri, 26 Jan 2024 08:51:22 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Marc Haber <mh+netdev@zugschlus.de>,
 alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Jisheng Zhang <jszhang@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <20240126085122.21e0a8a2@meshulam.tesarici.cz>
In-Reply-To: <99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
	<8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
	<ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
	<229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
	<99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 12:00:46 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 1/25/24 11:54, Andrew Lunn wrote:
> >> I have checked out 2eb85b750512cc5dc5a93d5ff00e1f83b99651db (which is
> >> the first bad commit that the bisect eventually identified) and tried
> >> running:
> >>
> >> [56/4504]mh@fan:~/linux/git/linux ((2eb85b750512...)) $ make BUILDARCH="amd64" ARCH="arm" KBUILD_DEBARCH="armhf" CROSS_COMPILE="arm-linux-gnueabihf-" drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst
> >>    SYNC    include/config/auto.conf.cmd
> >>    SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
> >>    SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
> >>    HOSTCC  scripts/kallsyms
> >>    UPD     include/config/kernel.release
> >>    UPD     include/generated/uapi/linux/version.h
> >>    UPD     include/generated/utsrelease.h
> >>    SYSNR   arch/arm/include/generated/asm/unistd-nr.h
> >>    SYSTBL  arch/arm/include/generated/calls-oabi.S
> >>    SYSTBL  arch/arm/include/generated/calls-eabi.S
> >>    CC      scripts/mod/empty.o
> >>    MKELF   scripts/mod/elfconfig.h
> >>    HOSTCC  scripts/mod/modpost.o
> >>    CC      scripts/mod/devicetable-offsets.s
> >>    UPD     scripts/mod/devicetable-offsets.h
> >>    HOSTCC  scripts/mod/file2alias.o
> >>    HOSTCC  scripts/mod/sumversion.o
> >>    HOSTLD  scripts/mod/modpost
> >>    CC      kernel/bounds.s
> >>    CC      arch/arm/kernel/asm-offsets.s
> >>    UPD     include/generated/asm-offsets.h
> >>    CALL    scripts/checksyscalls.sh
> >>    CHKSHA1 include/linux/atomic/atomic-arch-fallback.h
> >>    CHKSHA1 include/linux/atomic/atomic-instrumented.h
> >>    MKLST   drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst
> >> ./scripts/makelst: 1: arithmetic expression: expecting EOF: "0x - 0x00000000"
> >> [57/4505]mh@fan:~/linux/git/linux ((2eb85b750512...)) $
> >>
> >> That is not what it was suppsoed to yield, right?  
> > 
> > No. But did it actually generate
> > drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst Sometime errors
> > like this are not always fatal.
> >   
> >> My bisect eventually completed and identified
> >> 2eb85b750512cc5dc5a93d5ff00e1f83b99651db as the first bad commit.  
> > 
> > I can make a guess.
> > 
> > -       memset(&priv->xstats, 0, sizeof(struct stmmac_extra_stats));
> > 
> > Its removed, not moved later. Deep within this structure is the
> > stmmac_txq_stats and stmmac_rxq_stats which this function is supposed
> > to return, and the two syncp variables are in it as well.
> > 
> > My guess is, they have an invalid state, when this memset is missing.
> > 
> > Try putting the memset back.
> > 
> > I also guess that is not the real fix, there are missing calls to
> > u64_stats_init().  
> 
> Did not Petr try to address the same problem essentially:
> 
> https://lore.kernel.org/netdev/20240105091556.15516-1-petr@tesarici.cz/
> 
> this was not deemed the proper solution and I don't think one has been 
> posted since then, but it looks about your issue here Marc.

Yes, it looks like the same issue I ran into on my NanoPi. I'm sorry
I've been busy with other things lately, so I could not test and submit
my changes.

Essentially, the write side of the statistics seqlock is not protected
and will eventually miss an increment, causing the read side to spin
forever. The final plan is to split the statistics into three parts:

1. fields updated only under the tx queue lock,
2. fields updated only during NAPI poll,
3. fields updated only from interrupt context,

The first two groups can each have its own seqlock. The third group
(actually a single counter) can be converted to a per-CPU variable. The
read side will then aggregate the values as appropriate.

I hope I can find some time for this bug again during the coming weekend
(it's not for my day job). It's motivating to know that I'm not the
only affected person on the planet. ;-)

Petr T

