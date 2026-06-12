Return-Path: <netdev+bounces-298461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FXWUKASYK2pwAAQAu9opvQ
	(envelope-from <netdev+bounces-298461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:24:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18D676BB3
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:24:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b=DxOs6hXL;
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=bRKbSB6s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298461-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298461-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 419143057D66
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E783A2572;
	Fri, 12 Jun 2026 05:23:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-17.smtp-out.amazonses.com (a9-17.smtp-out.amazonses.com [54.240.9.17])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EAD3A5422;
	Fri, 12 Jun 2026 05:23:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781241806; cv=none; b=lRnU2ixXNF7YAG3HdAQV86IfAz3Xhi7bXkRmV8O4vlwEdHKHd1efYX4CKZnpxwE1QZ2EVxqH0bQCtY3usaUyxmoTuPXWYdyIjd7v5ibAcHD6Qa1ZkA8AzdcQxlJ7zfokfwnLVPjH5T4CNPrtpukSjiRAMHl63Hk2oyfJeeWebnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781241806; c=relaxed/simple;
	bh=KzBx4wrcZ9SM6utbGxEvn9CH5rMlJG9zYDQO6DRDtek=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=F33WS7MO6axdTg+lXzOiokGJmkXnqHMITK3NJdYyuyP0Cr+UZwS8a9vfsp2mGlSpLK9DWpJe0b+r9AqsBhwG5EtW3s1LoN8k08XvNAA4exeP1zOGIfuNRPlXb+JCHq2cGg6c3Mqm1mkqs9pGXuaR4kJh+SsP1lb+dKtPbVy46C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=DxOs6hXL; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=bRKbSB6s; arc=none smtp.client-ip=54.240.9.17
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1781241803;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=KzBx4wrcZ9SM6utbGxEvn9CH5rMlJG9zYDQO6DRDtek=;
	b=DxOs6hXLGP3YBW3Z7oJDGdp8DtnE/yBVGxwxOzQVhlE7tL+tTw0y1O6i5KLDFyP2
	cwqE8rnZOO8nRt+ftfKCIMxi3+/YI5+HNtvH82MDUe1Q+EDjXv9wyhsp9ZRnJQJM2Dh
	jvNh1H0zLu/39GoJ3O49g9CPKj64LQYLluo3BvgU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1781241803;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=KzBx4wrcZ9SM6utbGxEvn9CH5rMlJG9zYDQO6DRDtek=;
	b=bRKbSB6skJeQ915CpLQeOcP0YGVOLH3mu+ZzSMvoNUK4oCV5W837Vrxwy5zfVu+M
	XJeI7J4MrXQ5RRzhol14TYaRYG9sW82GPE212TmpLaXFuXapr3K2CPfhe2wtMXdYEU7
	ZCzenN/RrHRa5i0Qzhg3fmH55iMMrSUreSquAChg=
In-Reply-To:
 <CAJq09z4B_P7D0khof-e0hxu=A+UQYAH_anJYt8ppaFcjHCdBCw@mail.gmail.com>
From: Johan Alvarado <contact@c127.dev>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linusw@kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: dsa: realtek: rtl8365mb: add
 SGMII support for RTL8367S
Message-ID: <0100019eba48f14d-299bc369-1ba5-4262-a913-caefd96166de-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 05:23:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.12-54.240.9.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[c127.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:luizluca@gmail.com,m:netdev@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298461-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[email.amazonses.com:mid,c127.dev:dkim,c127.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazonses.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB18D676BB3

> I think we don't need the firmware at all. Requesting a proprietary
> binary that we don't control to do things phylink already does is
> unnecessary and adds a burden to linux-firmware.
> I strongly suggest =
dropping rtl8365mb_dw8051_load_firmware() entirely,
> porting the BMCR reset sequence above directly into the driver, and
> keeping the 8051 disabled.

I tested exactly this on the MR80X v2: =
dropped the firmware loading,
ported the 0x1401/0x1403 BMCR sequence right =
after the SerDes reset
deassert, and kept the DW8051 permanently disabled =
(also removing the
re-enable at the end of the SGMII config path).

Results in both SGMII and HSGMII modes:

 - Link bring-up: 10/10 cold boots=
 (power drained), 10/10 warm
   reboots, 10/10 module reload cycles =
(rmmod/insmod), and repeated
   ip link down/up =E2=80=94 link came up =
cleanly every time.

 - Sustained traffic, CPU-generated (iperf3 on the =
router, 30 min
   each direction): ~750 Mbit/s in both modes, CPU-bound. =
Zero
   CRC/symbol errors in the port MIB counters.

 - NAT forwarding LAN->WAN (iperf3 between external hosts, 10-30 min
   runs): ~800-820 Mbit/s sustained, PHY-bound (1G user ports), again
   with zero CRC/symbol errors. A small number of buffer discards
   under sustained load (~0.07%), consistent with congestion rather
   than link-level corruption.

So I can confirm your analysis. v3 will =
drop the firmware entirely
and carry this with your Suggested-by.

> If we intend to support non-fixed links in the future (where in-band
> AN is required), we would need to implement phylink_pcs and
> pcs_get_state instead of just forcing the MAC. For fixed-link it is
> fine, but we should plan accordingly.

Agreed. I'd prefer to keep v3 =
scoped to fixed-link (matching what
RGMII supports today) and leave the =
phylink_pcs conversion for a
follow-up series.

Best regards,
Johan

