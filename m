Return-Path: <netdev+bounces-251468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA0mL7wucGkEXAAAu9opvQ
	(envelope-from <netdev+bounces-251468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:41:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E34F3C0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEE9C644F16
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ECE3D6488;
	Tue, 20 Jan 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="H93G9koU"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-e104.zoho.com (sender4-pp-e104.zoho.com [136.143.188.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2A3A4F49;
	Tue, 20 Jan 2026 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909985; cv=pass; b=SOdFAW7fZgL7G5s1a8UzW11OIGS5dWkEkD0/vaDjDYanUla0ur9o/u82UvFQFK8d3ZGos90Ghjw/H4CZfVZUmatU0l2a9C9H5HC4OMnVh540A/xer5UKftromNyRCsfWceRxbJ6TXZsP/X2NJ3GxF3+gYFDrmRrCrqEQqg+Io/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909985; c=relaxed/simple;
	bh=typ9DRDW/UZrdqUbxJVjVT/pFbErm7WXkgSfUwUwKnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdaA6R0AGPUIatRWw6RAoPFPyCgQt6T2reAGjlcMzGhfn5/l1R3EQa7+J7pMM8R3XHE6IDxIu3byyFgqeoYvICpSCTe2nZ9oYIe36G8PLdXmcKVGl/eSoohO/DJDnkFQpjsTQm7uwfa9PRjTjWeCj8Fjs68CdxIVZjNhJvXpxmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=H93G9koU; arc=pass smtp.client-ip=136.143.188.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1768909942; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fZYlA20MpnCAAE6j+0DCq9moaidbQBsSNz5CKTGqNeqR486iQZxOODnoLjJmmCcAKtFU4W6MhgP1rdW+YmmhVaUYB37ZP2JKFav7PgD0bTpabVStulZiL1DGF7yAA0Uu3WYdjVi0JkEEb8P+ddy8qUFX8uwWUjdd89dPruoTRkY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768909942; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b4kQK07yZhhPFzrCdW/yDpOPtjD5rDSvxImSrZvPL50=; 
	b=fwaptDbABs0YsovqUkkBNhijXIminCEIZdLE2z/DmZXBID5iB/K4PebM7q7xkEBVWjJct5c9Q8IFkEgp4nJwv2FzYBScttXldEtASA6Mm1e4cE2q7pT9T6WoziRVsOPHmryXSn3uHHyxB1P0V6lEDMFMjnNEXiXnjsYrLnP+SnU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768909942;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=b4kQK07yZhhPFzrCdW/yDpOPtjD5rDSvxImSrZvPL50=;
	b=H93G9koU74SssZBM7MI/sPL3jbgL7588I0azFtI1XjrzS9pnzVWfZqOLeWfl2/Ku
	dk96/lIzXVEiVHAYP3hLc+pjdpctGAoamdLjYmZ2q4o7/B9kia3OTERTZqV0l27u7tl
	zKOclfitWLSCD1yNLad6+UhJOIHNkODGqfXkE/UQ=
Received: by mx.zohomail.com with SMTPS id 1768909940542709.5656112173529;
	Tue, 20 Jan 2026 03:52:20 -0800 (PST)
Date: Tue, 20 Jan 2026 11:52:07 +0000
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
Message-ID: <aW9sZwDpQu88BRPG@pie>
References: <20260109093445.46791-2-me@ziyao.cc>
 <176827502141.1659151.5259885987231026081.git-patchwork-notify@kernel.org>
 <147b700c-cae2-4286-b532-ec408e00b004@tuxedocomputers.com>
 <aW5RMKqwpYTZ9uFH@shell.armlinux.org.uk>
 <be9b5704-ac9c-4cd5-aead-37433c4305a8@tuxedocomputers.com>
 <24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com>
 <aW7sW91DrgZ6FMrv@pie>
 <1be6caa4-abbd-4f3b-8c63-b637f0f9ed15@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be6caa4-abbd-4f3b-8c63-b637f0f9ed15@tuxedocomputers.com>
X-ZohoMailClient: External
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251468-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,gmail.com,nxp.com,csie.org,vger.kernel.org,aosc.io,tuxedocomputers.com];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziyao.cc:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 650E34F3C0
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Tue, Jan 20, 2026 at 10:42:28AM +0100, Georg Gottleuber wrote:
> 
> 
> Am 20.01.26 um 03:45 schrieb Yao Zi:
> > On Mon, Jan 19, 2026 at 06:57:48PM +0100, Georg Gottleuber wrote:
> >> Am 19.01.26 um 18:45 schrieb Georg Gottleuber:
> >>> Hi,
> >>>
> >>> thanks for the quick reply.
> >>>
> >>> Am 19.01.26 um 16:43 schrieb Russell King (Oracle):
> >>>> On Mon, Jan 19, 2026 at 04:33:17PM +0100, Georg Gottleuber wrote:
> >>>>> Hi,
> >>>>>
> >>>>> I tested this driver with our TUXEDO InfinityBook Pro AMD Gen9. Iperf
> >>>>> revealed that tx is only 100Mbit/s:
> >>>>>
> >>> ...
> >>>>>
> >>>>> With our normally used DKMS module, Ethernet works with full-duplex and
> >>>>> gigabit. Attached are some logs from lspci and dmesg. Do you have any
> >>>>> idea how I can debug this further?
> >>>>
> >>>> My suggestion would be:
> >>>>
> >>>> - Look at the statistics, e.g.
> >>>>
> >>>>    ip -s li sh dev enp2s0
> >>>
> >>> That looks good (after iperf):
> >>>
> >>> 2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
> >>> mode DEFAULT group default qlen 1000
> >>>     link/ether ba:90:88:24:49:4f brd ff:ff:ff:ff:ff:ff
> >>>     RX:  bytes packets errors dropped  missed   mcast
> >>>        2091654   31556      0       0       0       0
> >>>     TX:  bytes packets errors dropped carrier collsns
> >>>       88532451    1518      0       0       0       0
> >>>
> >>>
> >>>> - apply
> >>>>   https://lore.kernel.org/r/E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk
> >>>>   to enable more statistics to work, and check the network driver
> >>>>   statistics:
> >>>>
> >>>>    ethtool --statistics enp2s0
> >>>>
> >>>> to see if there's any clues for what is going on.
> >>>
> >>> That looks also good, I think. I saved it before and after the test with
> >>> iperf. See attachments.
> >>
> >> Oh, there was something else interesting in dmesg. See attachment.
> >>
> >>> Regards,
> >>> Georg
> > 
> >> [    0.933480] dwmac-motorcomm 0000:02:00.0: error -ENOENT: failed to read maca0lr from eFuse
> >> [    0.933483] dwmac-motorcomm 0000:02:00.0: eFuse contains no valid MAC address
> >> [    0.933485] dwmac-motorcomm 0000:02:00.0: fallback to random MAC address
> > 
> > Some vendors didn't write a MAC address to the eFuse. With these YT6801
> > chips, the failure is expected.
> 
> I believe we have a fixed address, as our DKMS driver always uses it (it
> is also displayed in the BIOS).
> 
> > Which DKMS driver do you use? Could you read out a permanent address
> > with your DKMS driver? If not, this piece of log should have nothing to
> > do with the rate problem.
> 
> DKMS module we use:
> https://gitlab.com/tuxedocomputers/development/packages/tuxedo-yt6801
> 
> Apparently, your driver can also read the permanent address. I rebooted
> nine times to test it, and it worked nine times. So it was probably a
> glitch that doesn't occur very often.

Thanks for the hint. I'm sure I've encountered similar cases once or
twice during development, but it stopped happening later, so I
considered it's somehow fixed. I'll test more and see what's going wrong
here.

> 
> Do you have any ideas on how I can further debug the rate problem?

Sadly I don't have any good suggestions. The Motorcomm glue is
mysterious and totally undocumented, so it's hard to find out what's
missing or wrong. I had to debug the driver by modifying this and vendor
driver and then comparing behavior differences.

Do you build the driver into the kernel, or as a module? I'll try to
reproduce your case locally and investigate it, but as a hobbyist I
cannot make any promises, really sorry about it.

Best regards,
Yao Zi

