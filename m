Return-Path: <netdev+bounces-90240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A988AD419
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89340B22059
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6828154430;
	Mon, 22 Apr 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TJZle9Sn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342B153837
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811140; cv=none; b=W911LQAobp81llA48NvXF3aEkBCnoqqL8xtHEg+rmz8/MaMn2lnDkeWZuJVvImeHQnnbyR0KHBpPlMQcDeVYC/wZkV8yOoLJX2HwnUDJ2N9j4OFOMw010VITH7pyrnvDSVTracqZH3eZi8VEhPz/LVLQM5/mQy7ypSnHdPAw/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811140; c=relaxed/simple;
	bh=/dU+m9OUgMv9b2M2ZcpQmNifUyGbO0PNephm/4kzwrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Msl764JSx7Xa4dI8HEaJlXwx2yk1mSEnDi4YPWAS82wcFA1LWfDRaX9tBvCeGoGWIi+5cUBRoxLn4o050M7QmjiwFfepAQydvc1b9jSbpcfeW9yFWIIfZRD7gpAiwK+dHpv/v7TD/b/nY0HpBP7n5dE3JeqehPyHaMLURyqJOfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TJZle9Sn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5uqdpnJiXq+EBeS7OvWBkXZZfFtF0sfMGhaOFr5Ja0k=; b=TJ
	Zle9SnUb8rENEYbmq7wsWTTLFYpDQ6uetogafgtYcGWprU0vnwnr29/qzDuvxdsiM1WbZgxmMBBzF
	NJ3NSvDw356B4oBCt9BPLsRAjKgjzts+SGn3363KTA4XV1ZiY9uFvMSfNSCfBvIP1k0qNbbdMm/M+
	FIiaSkaPXJVDOGU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryyYy-00Ddli-UV; Mon, 22 Apr 2024 20:38:48 +0200
Date: Mon, 22 Apr 2024 20:38:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Support needed for integrating Marvel 88e6390 with microchip
 SAMA7 processor (DSA)
Message-ID: <7c5d2370-ae4f-4812-beef-d15d5a48075b@lunn.ch>
References: <CAEFUPH0SoiOef1t8GS+Ch2a2sk+95PfF9Fnz_tPoveRJy2eAuw@mail.gmail.com>
 <f3739191-1c13-481a-af70-f517f2dd75de@lunn.ch>
 <CAEFUPH0BFxnjxT-sX=pwgJnaLhEZajELJzsc227am3AOWye51g@mail.gmail.com>
 <CAEFUPH20drisR7W8-Hb4XpFs1O0zaGN72yiNgRWXmQFSS2vSyw@mail.gmail.com>
 <CAEFUPH2POB-3jn_vjVS5CraJvOyhNSGLtA0hFvnNZsA+OL6eWg@mail.gmail.com>
 <c8134442-0080-4a63-9812-8d1d23339f3c@lunn.ch>
 <CAEFUPH3-E+rc8TB2FjNu1RDxVV8GSxqrOtHiK19a53kBBhovNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEFUPH3-E+rc8TB2FjNu1RDxVV8GSxqrOtHiK19a53kBBhovNw@mail.gmail.com>

On Mon, Apr 22, 2024 at 10:29:32AM -0700, SIMON BABY wrote:
> Within my Linux itself, I could not ping the own address I configured for lan2.
> I configured same network address for my master port (eth0) and slave port
> (lane2). Please see below. 
> 
> eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1504
>         inet 192.162.0.111  netmask 255.255.255.0  broadcast 192.162.0.255
>         inet6 fe80::691:62ff:fef2:fd1c  prefixlen 64  scopeid 0x20<link>
>         ether 04:91:62:f2:fd:1c  txqueuelen 1000  (Ethernet)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 54  dropped 0  overruns 0  frame 54
>         TX packets 179  bytes 27309 (26.6 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>         device interrupt 172

There is no need to have an IP address on the conduit interface.

> lan2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet 192.168.0.120  netmask 255.255.255.0  broadcast 192.168.0.255
>         inet6 fe80::691:62ff:fef2:fd1c  prefixlen 64  scopeid 0x20<link>
>         ether   04:91:62:f2:fd:1c  txqueuelen 1000  (Ethernet)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 50  bytes 4082 (3.9 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

> root@sama7g5ek-sd:~# ping 192.162.0.120             (ping slave port did not
> worked)                  
> PING 192.162.0.120 (192.162.0.120) 56(84) bytes of data.
> From 192.162.0.111 icmp_seq=1 Destination Host Unreachable
> From 192.162.0.111 icmp_seq=2 Destination Host Unreachable
> From 192.162.0.111 icmp_seq=3 Destination Host Unreachable

$ whois 192.162.0.0
% This is the RIPE Database query service.
% The objects are in RPSL format.
%
% The RIPE Database is subject to Terms and Conditions.
% See https://apps.db.ripe.net/docs/HTML-Terms-And-Conditions

% Note: this output has been filtered.
%       To receive output for a database update, use the "-B" flag.

% Information related to '192.162.0.0 - 192.162.3.255'

% Abuse contact for '192.162.0.0 - 192.162.3.255' is 'abuse@mtu.ru'

inetnum:        192.162.0.0 - 192.162.3.255
netname:        NEW-RUSSIA-CTV-NETWORK
country:        RU
org:            ORG-ZM1-RIPE
admin-c:        OIC2-RIPE
tech-c:         OIC2-RIPE
status:         ASSIGNED PI
mnt-by:         RIPE-NCC-END-MNT
mnt-by:         MTU-NOC
mnt-by:         KUBANGSM-MNT
mnt-routes:     KUBANGSM-MNT
mnt-domains:    KUBANGSM-MNT
created:        2011-03-14T12:58:19Z
last-modified:  2017-08-18T06:58:00Z
source:         RIPE # Filtered

Could be your firewall does not like talking to Russia?

      Andrew

