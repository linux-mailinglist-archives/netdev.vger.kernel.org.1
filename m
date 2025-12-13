Return-Path: <netdev+bounces-244579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44431CBA2C2
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 03:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DE95309A7CA
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 02:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96B67E792;
	Sat, 13 Dec 2025 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=christoph.anton.mitterer.name header.i=@christoph.anton.mitterer.name header.b="KIqDwU7s"
X-Original-To: netdev@vger.kernel.org
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF94A23
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765591476; cv=pass; b=fC7w19H2qW/bC0W5Ke30joSQoLdmrlzRHrSRVgsd0NNXVUybH/8pn5hu2FjQbICT3UyISkKcfifOJc9aYdmcatPEe7ZQSUrOyaO08r4vM0nGhCOwApfIoHQzkxH6lCB5ce24IYXbAinHX47oX1cd6a3/6ahmu7jT1HjXI1OZKag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765591476; c=relaxed/simple;
	bh=+pShyUkS9YRU5JXC005BCQx0Sp4Skvm57UUJCj+Au9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ff1WB7p6O5Zn/EF55STOoLlx7vUbNx95oVoGWQFI/2bKepGqc0StZonV87s1a80v+1MEBUJ7JwTBdRI3NFzpuEblwbo2o+mHEt3KBQBCB8fkcF/iojphIBLY7gzSmnRBGMwMg5jOPhhLohXdvveafAePUSQyKGLjrewQdErKaBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christoph.anton.mitterer.name; spf=pass smtp.mailfrom=christoph.anton.mitterer.name; dkim=fail (0-bit key) header.d=christoph.anton.mitterer.name header.i=@christoph.anton.mitterer.name header.b=KIqDwU7s reason="key not found in DNS"; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christoph.anton.mitterer.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=christoph.anton.mitterer.name
X-Sender-Id: instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6FA1A441705;
	Sat, 13 Dec 2025 01:48:32 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-108-114-232.trex-nlb.outbound.svc.cluster.local [100.108.114.232])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6AAE24416CE;
	Sat, 13 Dec 2025 01:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1765590511;
	b=2C5s9ySZ+4pHpBsXmhSj0/iawZIInOxHM+uKokOFxPiCq/cjxDm5dLrXwU6oOidRBCU7Ld
	qv8b1aZsUL+mYUya9e6Ml2Trcc97WR9pyLqKHWhoyEDQeFW7BW+Tq1KhD7BLZudYMsQnr9
	tSwM4QUIFjnqDCSwcnB075nKmPgUNS5oRxByxWiIQUdk0DVGhwHu0/4FEhen6iiO0xXhsa
	9XYf3l+4gAQwMbFDSWgriWTIKBztwoqDe7Rqt3wT2t1GLxhtJqqrse4FNK1ZwfWOaoQuMf
	/4oeqP15D+uN+ftAtWrFIRX57hFqVY9KnwBUdtjsQzx+bsmmQjd875Gwx2doJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1765590511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Vd68ccMK+6c56WWyFPmH0lYNkUnbpVMaliuPkJFNhTU=;
	b=c0Ey2i1oXC1CgsP+Hw47ExAhh+NHLWnnhlrTywuNoWSizzwuZkHM/EvGbcGIlkPr8SpGnG
	PV4fpDnMkv6PSNOsXPCMtEqTYSg/qbvMpQmD8QNjhvMeItlcVQElMgWr30uYMa6JvByGvA
	y3rrpPCsYQ8DUd9SWhdSe2Y0VlbdfQy+6z0wUetz6JcDCouO1RB11bmyJY9xhUzulClRjP
	TEahMmED4zH209nd4ffj3jVCkv73fk0C9Mpjjkb2cZ+pfLB0pWdBIdNSG0omj+I6THM1y5
	ZqXUyal8sFPvhAwheW9KoplOi5O7BYrG0O0c9Zal1ZVnitxfsVpV9rIby9WKag==
ARC-Authentication-Results: i=1;
	rspamd-6ccd5b4cc5-ffppt;
	auth=pass smtp.auth=instrampxe0y3a
 smtp.mailfrom=mail@christoph.anton.mitterer.name
X-Sender-Id: instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
X-MailChannels-Auth-Id: instrampxe0y3a
X-Bitter-Descriptive: 2043a61f6b3c0f03_1765590512150_2659109605
X-MC-Loop-Signature: 1765590512150:446909117
X-MC-Ingress-Time: 1765590512150
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.114.232 (trex/7.1.3);
	Sat, 13 Dec 2025 01:48:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=christoph.anton.mitterer.name; s=default; h=MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=Vd68ccMK+6c56WWyFPmH0lYNkUnbpVMaliuPkJFNhTU=; b=KIqDwU7sYBI5
	aNUGbPULk/LlFY3KJWZ42JAvO058x9EBVuStpY0Yn74dDQYdzSVV5PWgDvFhPbhM6/N5XQbjFc1pU
	p4fCks05N18wXGlfCIRUs5RkTx6jz/VJI/RxHSnzKHbYI+r0TrXJxqTIlN+N5LgpM58Xn8wxWBoNR
	XYno8l+5nLNTPuczjkUaWfZc7ZifNyoXHOr6GgIoRgJvRvzQRYr0sOgrz0vz0D3RV8JWpfYIGgkkf
	lgshN6VNU8ypYAqCYJQ8qU7i/smJ1NyybHGFieVvnlZnPJzfkOo7/I9ZWKGcz47teWtmKAkb7v27E
	xN2s+8WiP4Ih/jV/snCBKg==;
Received: from p5090f480.dip0.t-ipconnect.de ([80.144.244.128]:59728 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mail@christoph.anton.mitterer.name>)
	id 1vUEkJ-0000000DcHY-3PJ3;
	Sat, 13 Dec 2025 01:48:29 +0000
Message-ID: <0538367890210f8bbaf70ed6bd1cea3491463b35.camel@christoph.anton.mitterer.name>
Subject: Re: [PATCH 0/1] lib: Align naming rules with the kernel
From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Date: Sat, 13 Dec 2025 02:48:28 +0100
In-Reply-To: <20251213092004.079f9cbe@stephen-xps.local>
References: <20251212042611.786603-1-mail@christoph.anton.mitterer.name>
		<20251212140309.75c84ace@stephen-xps.local>
		<28a0486bd08d59f8f2e758f73a39bd442547197f.camel@christoph.anton.mitterer.name>
	 <20251213092004.079f9cbe@stephen-xps.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: mail@christoph.anton.mitterer.name

On Sat, 2025-12-13 at 09:20 +0900, Stephen Hemminger wrote:
> I don't there would be a problem altnames are intended to be more
> flexible.
> And it would make sense since Cisco standard is something like
> Gigabit/0/0
> for names.=C2=A0 Why not remove check and see what breaks?

Which exactly? The one for altnames altogether?

That seems a bit risky, TBH, given that tools might output these names
and use the currently forbidden chars as separators, assuming they=E2=80=99=
d be
safe to use so.
Especially since `__check_ifname()` via `check_altifname()` also
forbids spaces and newlines.

OTOH, the kernel, AFAIU, allows it already so merely forbidding it in
iproute2 is anyway only a weak protection.

I=E2=80=99ve looked at few tools whom I know output the altnames:
# networkctl status virbr1=20
=E2=97=8F 14: virbr1
                   Link File: /usr/lib/systemd/network/99-default.link
                Network File: n/a
                       State: no-carrier (unmanaged)
                Online state: unknown
                        Type: bridge
                        Kind: bridge
                      Driver: bridge
           Alternative Names: foo
                              bar
                              foo bar
                              foo.bar
                              foo:bar
                              foobar
            Hardware Address: 52:54:00:3a:2d:43
                         MTU: 1500 (min: 68, max: 65535)
                       QDisc: noqueue
IPv6 Address Generation Mode: none
               Forward Delay: 2s
                  Hello Time: 2s
                     Max Age: 20s
                 Ageing Time: 5min
                    Priority: 32768
                         STP: yes
      Multicast IGMP Version: 2
                        Cost: 2000
                 FDB Learned: 0
             FDB Max Learned: 0
                  Port State: disabled
    Number of Queues (Tx/Rx): 1/1
            Auto negotiation: no

(here `foo\nbar` was one altname with newline... which I set via a
patched `ip`.

# ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DE=
FAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
14: virbr1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue stat=
e DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:3a:2d:43 brd ff:ff:ff:ff:ff:ff
    altname foo:bar
    altname foo.bar
    altname foo bar
    altname foobar
    altname foo
bar

networkctl has its --json mode, so parsing its regular output is anyway
obviously unsafe.

ip=E2=80=99s output however might be parsed by people... and in particular
allowing \n might break that (but allowing other whitespace might, too.

What do you think?

And any clue where these checks would be used for the ifalias thingy
you=E2=80=99ve mentioned?


Cheers,
Chris.

