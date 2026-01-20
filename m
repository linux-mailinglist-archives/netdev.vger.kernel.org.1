Return-Path: <netdev+bounces-251343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF15D3BD9E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 03:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4152130076A1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 02:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316793594A;
	Tue, 20 Jan 2026 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="kdjjMOe3"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC43282EB;
	Tue, 20 Jan 2026 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768877222; cv=pass; b=IGNSZ/mqkXHEcB3nmfnjLuJpv08bRbqemYr7Aa8CmCqJnRxgG52j6Yt2EE39FlCxucq5Fpdk7o4H2Z52Vs1t2ZwRSd92Vpjw7MveZn56NIAqlLM+/m9YVMT9p7ncU+kxeRmtke72GgL3BAq69sWlgjzY+8of4jZvN/mNyxxxEQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768877222; c=relaxed/simple;
	bh=nhXN26JoolIL1Xdbhpbg2sS+g8m8nFWQLCaLh4k2mWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqtT81AXxotWMm7ypa1Q4Bn5Znuvlsgv/lE9CdYQI8RKT9NtzsSjdqg+/l3mgxJmWNaS4BOjaow4dCm6EHjee9H50/eStFqOnBerOTPiDSvYa3bI/bDh6wEbky8FQLu1TJ3+ukgUgoOPsG+z0xk386klbxwhYJIEygevxN4y78s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=kdjjMOe3; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1768877167; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NnWRPGbaN0dmLD60QyM9bYRNLcfe3vwzP5oAbDViH0nj8hHSd09li1mpl46+pH+8e69Z5aNklwZ+sJ25/B7AKflQnjtIabRwEXbytyyu67a24bhv1Ewcy+1NPw9+R9RQjtuKoFOg2iCq/3hLhcg9aBjsMNQ531LtCfqXineeNhM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768877167; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rhwkVzwjdK5+6aY3khIq+NuvaXHHwgKguTzRHkWnsLc=; 
	b=EGudDtRpFRKowYoR5L51Dpn+9CvHunPsBdTdIgOgHUk48QpCSH4fURp6rsnLIZIQSPbRCz4UaRk1cPpo4loz0L1eRrHbhBUpwMKfiMs+uXK+UgEx0P/4IApchSYJzUrBfgL867oA3wRMzSt3hOjPZfFvoAjRj4qWbQ4CplQVZYI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768877167;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=rhwkVzwjdK5+6aY3khIq+NuvaXHHwgKguTzRHkWnsLc=;
	b=kdjjMOe3jq86dEtQu6s4ye06+AMocUwVULxywfMyO4Tmxp6V47R6zm8T/dpISUfF
	EWgzII/+m2DvgtnjZo7gB9Ywxr5H390uvORT1yyWA5GaKcHGlh1F72bchm1zdnFlgs4
	Np9cd5PKA/MM1+EXpsqLWRc7koC7CddkVDcLL5wo=
Received: by mx.zohomail.com with SMTPS id 17688771633341009.492207247847;
	Mon, 19 Jan 2026 18:46:03 -0800 (PST)
Date: Tue, 20 Jan 2026 02:45:47 +0000
From: Yao Zi <me@ziyao.cc>
To: Georg Gottleuber <ggo@tuxedocomputers.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Frank.Sae@motor-comm.com,
	hkallweit1@gmail.com, vladimir.oltean@nxp.com, wens@csie.org,
	jszhang@kernel.org, 0x1207@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, jeffbai@aosc.io, kexybiscuit@aosc.io,
	Christoffer Sandberg <cs@tuxedocomputers.com>
Subject: Re: [PATCH RESEND net-next v6 0/3] Add DWMAC glue driver for
 Motorcomm YT6801
Message-ID: <aW7sW91DrgZ6FMrv@pie>
References: <20260109093445.46791-2-me@ziyao.cc>
 <176827502141.1659151.5259885987231026081.git-patchwork-notify@kernel.org>
 <147b700c-cae2-4286-b532-ec408e00b004@tuxedocomputers.com>
 <aW5RMKqwpYTZ9uFH@shell.armlinux.org.uk>
 <be9b5704-ac9c-4cd5-aead-37433c4305a8@tuxedocomputers.com>
 <24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com>
X-ZohoMailClient: External

On Mon, Jan 19, 2026 at 06:57:48PM +0100, Georg Gottleuber wrote:
> Am 19.01.26 um 18:45 schrieb Georg Gottleuber:
> > Hi,
> > 
> > thanks for the quick reply.
> > 
> > Am 19.01.26 um 16:43 schrieb Russell King (Oracle):
> >> On Mon, Jan 19, 2026 at 04:33:17PM +0100, Georg Gottleuber wrote:
> >>> Hi,
> >>>
> >>> I tested this driver with our TUXEDO InfinityBook Pro AMD Gen9. Iperf
> >>> revealed that tx is only 100Mbit/s:
> >>>
> > ...
> >>>
> >>> With our normally used DKMS module, Ethernet works with full-duplex and
> >>> gigabit. Attached are some logs from lspci and dmesg. Do you have any
> >>> idea how I can debug this further?
> >>
> >> My suggestion would be:
> >>
> >> - Look at the statistics, e.g.
> >>
> >>    ip -s li sh dev enp2s0
> > 
> > That looks good (after iperf):
> > 
> > 2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
> > mode DEFAULT group default qlen 1000
> >     link/ether ba:90:88:24:49:4f brd ff:ff:ff:ff:ff:ff
> >     RX:  bytes packets errors dropped  missed   mcast
> >        2091654   31556      0       0       0       0
> >     TX:  bytes packets errors dropped carrier collsns
> >       88532451    1518      0       0       0       0
> > 
> > 
> >> - apply
> >>   https://lore.kernel.org/r/E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk
> >>   to enable more statistics to work, and check the network driver
> >>   statistics:
> >>
> >>    ethtool --statistics enp2s0
> >>
> >> to see if there's any clues for what is going on.
> > 
> > That looks also good, I think. I saved it before and after the test with
> > iperf. See attachments.
> 
> Oh, there was something else interesting in dmesg. See attachment.
> 
> > Regards,
> > Georg

> [    0.933480] dwmac-motorcomm 0000:02:00.0: error -ENOENT: failed to read maca0lr from eFuse
> [    0.933483] dwmac-motorcomm 0000:02:00.0: eFuse contains no valid MAC address
> [    0.933485] dwmac-motorcomm 0000:02:00.0: fallback to random MAC address

Some vendors didn't write a MAC address to the eFuse. With these YT6801
chips, the failure is expected.

Which DKMS driver do you use? Could you read out a permanent address
with your DKMS driver? If not, this piece of log should have nothing to
do with the rate problem.

Note some out-of-tree driver derived from the vendor one fallback to a
static MAC address[1], so it doesn't mean your eFuse has MAC address
written if you only observe the MAC address doesn't change between
reboots.

Best regards,
Yao Zi

[1]: https://github.com/ziyao233/yt6801-vendor-driver/blob/0efb3e86702ad2b19e7f9d19172a8e1df143e8c7/fuxi-gmac-common.c#L17-L32

