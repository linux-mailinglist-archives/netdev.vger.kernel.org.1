Return-Path: <netdev+bounces-90311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F118ADAE0
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 02:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2428D1C20894
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 00:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE181C68BD;
	Mon, 22 Apr 2024 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e8DmAxcU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAEC158DC4
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830356; cv=none; b=LUzfBMgQ1ucvFzLGLWtF/ROAFmX4lsDv/dQiMLdxjyOhyZ1r7iXF8RgeEmzrD0aeVJh68DJtFuT4jriN506da/LJO86W/3OcEyMiyUG6z4vOdW1M4MD4wvFIsWoH/2pOf7hYtUHvSeLppsQRjhY7IV0wL9kyHMo+ek1OJmoyheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830356; c=relaxed/simple;
	bh=8L63JIwnwmZAI3e/0tCpZQevcNqEGvJ07Yin96lY8fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kgc+eDeeQtxYpdaLuhEzByue6076XPXvR1EtGfva/0dMT1r7LC8oPBOqvyeLF13kL2XlKxSrR89M5kMqbYX8jQzE/pxkSjzc+L2xqSZv9u2/De4sGmQYZgkIFZxOdtMIStcPn3F0jnDYG1cw9nP1sbziMVqNcaJDLsSJsxeZgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e8DmAxcU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/LeTDTS8PHN0NBsm0pmbbubUmVgU6AGm/CDT9Mc/8h8=; b=e8
	DmAxcUZRD/xA31Z+Pzh755Jj5qZBfbjMtnSLHGtQP92xRlPaiTPnlxWGrHb9jsZDDSl/KxtAkbxdp
	5QI0gceOK57x18arRkbFwmYUoyx0OAdloIrpQroIVbvIt/WhhUMw6gdt+vG3SoXL/N2hgpmNmnz/R
	h384GupefPquSjU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rz3Z2-00Df1l-Kn; Tue, 23 Apr 2024 01:59:12 +0200
Date: Tue, 23 Apr 2024 01:59:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Ping failing with DSA enumerated ports with macb driver
Message-ID: <3041e5a8-b3c9-450e-8b4a-b541cd9ffe64@lunn.ch>
References: <CAEFUPH0hr9jX0NCTu1vCGQvkCJ87DjLrcg8iCVO7A2vRhmfVgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEFUPH0hr9jX0NCTu1vCGQvkCJ87DjLrcg8iCVO7A2vRhmfVgQ@mail.gmail.com>

> oot@sama7g5ek-sd:~# tcpdump -i eth0
> 
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> 
> listening on eth0, link-type DSA_TAG_DSA (Marvell DSA), snapshot length 262144
> bytes
> 
> 19:09:06.730472 DSA port 8.0 > CPU, VLAN 1472u, 04:91:62:f2:fd:1c (oui Unknown)

This does not make any sense. This is the wrong direction. And VLAN
1472 ???

> > Broadcast Null Information, send seq 0, rcv seq 0, Flags [Command], length
> 307
> 
>         0x0000:  0000 0000 4011 78f7 0000 0000 ffff ffff  ....@.x.........
> 
>         0x0010:  0044 0043 0123 8af2 0101 0600 d429 7f9b  .D.C.#.......)..
> 
>         0x0020:  00bc 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x0030:  0000 0000 0491 62f2 fd1c 0000 0000 0000  ......b.........
> 
>         0x0040:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x0050:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x0060:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x0070:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x0080:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x0090:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x00a0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x00b0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x00c0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x00d0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x00e0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x00f0:  0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
>         0x0100:  0000 0000 6382 5363 3501 013d 0701 0491  ....c.Sc5..=....
> 
>         0x0110:  62f2 fd1c 370a 0103 060c 0f1a 212a 7879  b...7.......!*xy
> 
>         0x0120:  3902 0240 0c0c 7361 6d61 3767 3565 6b2d  9..@..sama7g5ek-
> 
>         0x0130:  7364 ff                                  sd.

This is too long for an ARP, which is typically 42 bytes.

Try running tcpdump with e and v options. And then think about what
you see.

    Andrew

