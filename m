Return-Path: <netdev+bounces-90228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7C98AD335
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85361F21FCF
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268B9153BCF;
	Mon, 22 Apr 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HCw3zqTp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0752EB11
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806158; cv=none; b=EABYj2goaH69+c7U+6VKo7X77WpUzd2kyYJ6XOegqoANCelMoZqTfkiYqVELtCrJxaP941zxdsyn4QmvQgb596sD9ZC3xM5Cv+Seyq17442BGMRwKm1c70lt6deYBTSvQoLOI/44PgH6cgbbfWvt/Xp88Je2ymx6cNPpkBj3RXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806158; c=relaxed/simple;
	bh=LHwzPMPACKrOm/Zer9UyhwdPK/j7FZiobBiBTWSq7UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVyXICXVoidIAMAHsP0I3ahw2LPYo6N1jRMhtsMu25A7SxTmJMNX8eMgSrl14nqIpCAUjR57lEtSG9pc3TgH1KeZ17Pw+DNQRdPKY2KOqKXgHhvQuY9wUSwi+rAQhWVCX5aSVQaDTGjEbw95yu8a3OSHAm8B+A3xiHxcH5RwXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HCw3zqTp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=R+nP1AF96X8HBCWz9txu13aAuPaYvcjiIkqi79byxFM=; b=HC
	w3zqTp6VSeit5buP6KAImqN86FTLj6UxCs1nXPKu3obYXkprMdnPB455ULX8ioEPzaxJBxEW9WUnG
	ypNngHvpH/yneZvs03qB4t/im5vH+jFRNITNkuLTQe6wAQvUb1MNQsn5L7ueXkCaoldhS01d0zUQI
	bEkwUe7lJ+6pK3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryxGj-00DdXa-8t; Mon, 22 Apr 2024 19:15:53 +0200
Date: Mon, 22 Apr 2024 19:15:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Support needed for integrating Marvel 88e6390 with microchip
 SAMA7 processor (DSA)
Message-ID: <c8134442-0080-4a63-9812-8d1d23339f3c@lunn.ch>
References: <CAEFUPH0SoiOef1t8GS+Ch2a2sk+95PfF9Fnz_tPoveRJy2eAuw@mail.gmail.com>
 <f3739191-1c13-481a-af70-f517f2dd75de@lunn.ch>
 <CAEFUPH0BFxnjxT-sX=pwgJnaLhEZajELJzsc227am3AOWye51g@mail.gmail.com>
 <CAEFUPH20drisR7W8-Hb4XpFs1O0zaGN72yiNgRWXmQFSS2vSyw@mail.gmail.com>
 <CAEFUPH2POB-3jn_vjVS5CraJvOyhNSGLtA0hFvnNZsA+OL6eWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEFUPH2POB-3jn_vjVS5CraJvOyhNSGLtA0hFvnNZsA+OL6eWg@mail.gmail.com>

On Mon, Apr 22, 2024 at 09:43:11AM -0700, SIMON BABY wrote:
> Hello Andrew,
> 
> I was doing some traffic related tests with dsa slave ports. I have connected
> the lan2 port to my laptop and configured an IP address (same network). However
> I could not ping the addresses. Do I have to change the MAC address of the lan2
> interface as well? I can see lan2 is transmitting packets but nothing Rx. The
> MAC addresses of both the CPU port and lan2 are the same. 

The MAC address should be fine.

What does tcpdump/wireshark on your laptop show? Does it receive the packets?
Does it reply?
 
> eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1504
>         inet 192.162.0.111  netmask 255.255.255.0  broadcast 192.162.0.255
>         inet6 fe80::691:62ff:fef2:fd1c  prefixlen 64  scopeid 0x20<link>
>         ether 04:91:62:f2:fd:1c  txqueuelen 1000  (Ethernet)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 24  dropped 0  overruns 0  frame 24

RX errors and frame errors does not look good. You should investigate
that. Maybe wireshark will give you a clue.

>         TX packets 74  bytes 8301 (8.1 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>         device interrupt 172
> 
> lan2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet 192.168.0.120  netmask 255.255.255.0  broadcast 192.168.0.255
>         inet6 fe80::691:62ff:fef2:fd1c  prefixlen 64  scopeid 0x20<link>
>         ether 04:91:62:f2:fd:1c  txqueuelen 1000  (Ethernet)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 25  bytes 2092 (2.0 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Developers stopped using ifconfig many years ago.

	Andrew


