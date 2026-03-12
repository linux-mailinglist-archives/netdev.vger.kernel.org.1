Return-Path: <netdev+bounces-267157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEnjHr3nsmljQwAAu9opvQ
	(envelope-from <netdev+bounces-267157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:20:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E740275771
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1CC7322B967
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E313F20E8;
	Thu, 12 Mar 2026 16:13:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B003876A2
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332027; cv=none; b=LiRjsl8AWgm+EZnMUBud3ALVNQbrzZfWi8npu8G0Io3YL6CluRWR3/+fOM/tDnzTM8VrwpYjtI2fwr8Eej4PjLSHDjMLfmVSZBL3w4O4F2AgnVNBLBL3il4VIvtFP9jb/FbyHgr8j3x5nhfMtHtd9EQYX57JHgkcH7/nvDFBPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332027; c=relaxed/simple;
	bh=J0G6eyWjCZe2EavnpoZMaa3QDnbvlnCWthcPft0y1xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDBK3EXe2RYcPkil5EgTKeBtkODIYzhEaXNfA3uJXRkL9Tij8QaMdVdHFFoN+s0OUjnB9OitSxilI+MHEDMgiyni9u5jyZlQoHMEIAfZU4fAm9Un9nQI/RrPuz4gg+UssBhuXYXuu/oqyGt1DeYMz1o9w9OP2d/dUpSN8w9DUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d74c1157a4so1288968a34.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773332026; x=1773936826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8DuBIlRqwUybKw9BKko7+xZruw6jP0mIyTYZl7vHWM=;
        b=vYSmHJNYFGESiKN244UsVmKciV72h9ccLqemDACiN8zIqkVRPXXbI8hputHvJC5HHo
         dpv6UTOIM+mJdoSl8MnxDx7yw//lM14nGFQn+0ldWTgrilE4HarHGzQd8irftjSTzRcQ
         ctBQWmErn8WAxOza3OkjuNAzZXOghYAI1tL8WQVJXCuA2lM78/euvQb+S8MY7CjELgKU
         XZrNpCeNHfQp3Zr7eKRKE3C6H4tP+8tczOQ2cqVW0CBfZE3wysqKjaDcwa5vFQBlu0I2
         t/KCF3rOFxOt+A47yIl/5XNjXYRmb8DT5XgAKA3TMJBcsrYZrZzNO5kSYCvdTKx7ErLy
         8Uvw==
X-Forwarded-Encrypted: i=1; AJvYcCWHFjr7YbNjjk/dkbuJ9pnxgSHQF8ywXu7Q+JDghxZiL/9g80Hi9mbUIu7scBHvYAOiBHOkscA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxesqow5Hl7fclW4PT4J9EDGEZ+1DOWse3jXUvo+2qATPJEZ+2D
	d56vvgmHt+9i3xeshpZhbLoXXY3C1dxAnvhEk7OS+KDDIt73qxIREhlOJlLl8utAwWA=
X-Gm-Gg: ATEYQzySciqJFMpjc3tOlg2ta8NM537Gux1jHZzqvLLWQANUn93wRDzdwoLMqvXRQr0
	PzRvLcPh5LmArAfHWShPuJVkLavkaBPcfnKAfsw/kEZTaOZjRqqyD715Mqkhb2Pg9Oi0EzybLtO
	Cfc4487GUX5I4PCLqFB6bHJK/38tARWm16qrS/warZLcgww4isOqemZhhTiRHUs0g2v5dXddbBY
	VPG12IwFIrYOFEUeo88fHhYcnAAhknl3UjTe8FHhJgU7Ja9BUdSW3+1vqNSvwaOHW1N8EDitur3
	g2W46iqqJSOmQlnOyw7uBU0qmg8Q4QgDPgvUAopOcPFM3IpXhkVs0ET7Rs2GlNRftkkak//M3kq
	uSSkViB/9Gsd8pr/YcnHG/RCFki/COlMRXHAWms/XgmpOtF8oBUg5hVYUzTT39g6ZKEI2U4fnOq
	hnOU6b4cWBPAI+CAV0wt9DinIkoEHnyi5sb0x6PDnm870GC58zN2PvCzgqScTT
X-Received: by 2002:a05:6830:3914:b0:7d7:45b7:ed93 with SMTP id 46e09a7af769-7d76a6b86cdmr4848024a34.15.1773332025674;
        Thu, 12 Mar 2026 09:13:45 -0700 (PDT)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae81773sm4514287a34.21.2026.03.12.09.13.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 09:13:45 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-67bb04151dcso674241eaf.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:13:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUS+bv7Sn83Ngco3RAb7ocl2hOAVckU6AcKfSEQtamvm2jfEPq2WiKofEJsb+5LurKgIG0I1c=@vger.kernel.org
X-Received: by 2002:a05:6102:512b:b0:5ff:22f5:e37e with SMTP id
 ada2fe7eead31-601deb4d089mr2630417137.10.1773331557630; Thu, 12 Mar 2026
 09:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310153506.5181-1-fmancera@suse.de> <20260310153506.5181-2-fmancera@suse.de>
 <20260311200219.45796ec4@kernel.org> <aebac89f-f3b9-4983-8139-353a3ff19c98@suse.de>
In-Reply-To: <aebac89f-f3b9-4983-8139-353a3ff19c98@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Mar 2026 17:05:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWK0P+EEQXOQ8FMb7DYt-95dAmmbOjMhxCKHnvHRntojA@mail.gmail.com>
X-Gm-Features: AaiRm51vTFby3MbWyu4EKyWe_lBoIWwNWM0L5hUj3OB8Sdn3mba4moA7Rj12Mh4
Message-ID: <CAMuHMdWK0P+EEQXOQ8FMb7DYt-95dAmmbOjMhxCKHnvHRntojA@mail.gmail.com>
Subject: Re: [PATCH 01/10 net-next v2] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, rbm@suse.com, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Selvin Xavier <selvin.xavier@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Saurav Kashyap <skashyap@marvell.com>, 
	Javed Hasan <jhasan@marvell.com>, 
	"maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <GR-QLogic-Storage-Upstream@marvell.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Varun Prakash <varun@chelsio.com>, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Luca Weiss <luca.weiss@fairphone.com>, Sven Peter <sven@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Gow <david@davidgow.net>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, Ryota Sakamoto <sakamo.ryota@gmail.com>, 
	Kir Chou <note351@hotmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>, 
	Heiner Kallweit <hkallweit1@gmail.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, 
	"open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>, 
	"open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>, 
	"open list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <linux-scsi@vger.kernel.org>, 
	"open list:DISTRIBUTED LOCK MANAGER (DLM)" <gfs2@lists.linux.dev>, "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>, 
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>, 
	"open list:NETFILTER" <coreteam@netfilter.org>, 
	"open list:RXRPC SOCKETS (AF_RXRPC)" <linux-afs@lists.infradead.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>, 
	"open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,suse.com,ziepe.ca,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,hansenpartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,hotmail.com,gondor.apana.org.au,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267157-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_GT_50(0.00)[68];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0E740275771
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fernando,

On Thu, 12 Mar 2026 at 16:12, Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
> On 3/12/26 4:02 AM, Jakub Kicinski wrote:
> > On Tue, 10 Mar 2026 16:34:24 +0100 Fernando Fernandez Mancera wrote:
> >> Maintaining a modular IPv6 stack offers image size and memory savings
> >> for specific setups, this benefit is outweighed by the architectural
> >> burden it imposes on the subsystems on implementation and maintenance.
> >> Therefore, drop it.
> >>
> >> Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
> >> dependencies across the tree that explicitly checked for IPV6=m. In
> >> addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
> >> and MODULE_LICENSE().
> >>
> >> This is also replacing module_init() by device_initcall(). It is not
> >> possible to use fs_initcall() as IPv4 does because that creates a race
> >> condition on IPv6 addrconf.
> >>
> >> Finally, modify the default configs from CONFIG_IPV6=m to CONFIG_IPV6=y
> >> except for m68k as according to the bloat-o-meter the image is
> >> increasing by 330KB~ and that isn't acceptable. Instead, disable IPv6 on
> >> this architecture by default. This is aligned with m68k RAM requirements
> >> and recommendations [1].
> >
> > AI has spotted:
> >
> >> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> >> index 31d16cba9879..de088071dde4 100644
> >> --- a/arch/m68k/configs/amiga_defconfig
> >> +++ b/arch/m68k/configs/amiga_defconfig
> >> @@ -64,7 +64,6 @@ CONFIG_NET_IPIP=m
> >>   CONFIG_NET_IPGRE_DEMUX=m
> >>   CONFIG_NET_IPGRE=m
> >>   CONFIG_NET_IPVTI=m
> >> -CONFIG_NET_FOU_IP_TUNNELS=y
> >>   CONFIG_INET_AH=m
> >
> > Is CONFIG_NET_FOU_IP_TUNNELS=y removed intentionally? This option
> > provides FOU/GUE encapsulation for IP tunnels and has 'depends on
> > NET_IPIP || NET_IPGRE || IPV6_SIT' as its Kconfig dependency. With IPv6
> > disabled, IPV6_SIT becomes unavailable, but CONFIG_NET_IPIP=m and
> > CONFIG_NET_IPGRE=m are both still present in the defconfig, so the
> > dependency remains satisfiable.
> >
> > Since CONFIG_NET_FOU_IP_TUNNELS has no 'default y', removing it from the
> > defconfig means FOU/GUE encapsulation for IP tunnels will be silently
> > disabled by default on m68k. The commit message describes only disabling
> > IPv6 on m68k, not removing IPv4 FOU tunnel support.
> >
>
> I noticed that when running
>
> ./scripts/config --disable CONFIG_IPV6
>
> for the m68k, the script was adding CONFIG_LWTUNNEL=y and CONFIG_NET_FOU=y.
>
> CONFIG_LWTUNNEL was selected by multiple IPV6 features. I do not think
> it makes sense to keep it for m68k given the information there is on
> http://www.linux-m68k.org/faq/platinfo.html.

Dunno about lwtunnel...

> CONFIG_NET_FOU was something IPV6_FOU required, probably it should be
> just dropped from the config instead of explicitly turn it off as it
> turns off FOU_IP_TUNNELS too. It will be selected by FOU_IP_TUNNELS too
> anyway.

... but CONFIG_NET_FOU seems to be just a gatekeeping symbol
for the tristate symbol IPV6_FOU, so FOU is still a module., which is good.



Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

