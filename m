Return-Path: <netdev+bounces-297637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fsC4B/pIKWp7TgMAu9opvQ
	(envelope-from <netdev+bounces-297637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:22:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9565A668B5A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:22:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=o1rvaSwc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297637-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297637-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3561A304169D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648D3DEAF6;
	Wed, 10 Jun 2026 11:14:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C473EFD36;
	Wed, 10 Jun 2026 11:14:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090096; cv=none; b=sume4bNi/UUGg26YRBep9VjnT6xXjS7OZYpgiZzm3FzUI3up47zPm5VLJ0FW9GkYqJBhBrZA/IF3ipYAFKkPs/nXNKK9ZE70s7K4P0lEZxLm+9P8vdT1FVVlTVSRE/JbB2dGcD8zAXSo1d/uVTWbXiFC2/sCylnKtNPA3V+RCC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090096; c=relaxed/simple;
	bh=RnItkcluNHkerbNA6Le9ayXA+FCDdp2dU59oiZ/Vwqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nrop6Jn+DFfObRrO+uq7i9u1tdUYyKhWxvs56I0MG6Os1TVYerz2ApQn2Fx4Rv5km+Kda4vbwDWkSWlT4XIwqGxOzRwTnHXW69/X9vxZPx92+rw713Znb+eds3xrNcQTQH+JTSHF2x5pHrDsLQqONJTypFBpqSgi5Jntcli12uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1rvaSwc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105671F00893;
	Wed, 10 Jun 2026 11:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781090090;
	bh=GdDQBORjCeKVpVgxjVQODYXuZSoOpyrpqsCoADTD0Ic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=o1rvaSwczX0v28pCNdu3MB5oZu3Kr9dGv8HJr4TQgUYOKwaDiAbysGQRXQw+m1xrP
	 PdtVyiCcfThhEB0PHe1nQZjpo4sujdGral2fz6UOq6cTqGmjPAB4Ij/4cTnWCbhgr7
	 yzRc8m2TKyF5IFlfWelfMeE0H2c7oAUftl5fnnER51TfjzEVCkBE0ec2pFhj+W2K4B
	 1zsgnOjmnbyc9FGdAszrGq67w3umeSBNLk6zJwD6yzj1bphpQrpFFBB8iqI7Gfa9j+
	 kcR/eg8QMiniXVgcbCPdE5Ijx+ZvSZXyGl/ut+Kecp8wtChQqbITz/4KppbqP3v21S
	 cL+2w9jTU/l/A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1033A7BC7F1; Wed, 10 Jun 2026 13:14:47 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, Daniel =?utf-8?Q?Gr=C3=B6ber?=
 <dxld@darkboxed.org>, Antonio
 Quartulli <antonio@mandelbit.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and
 dispatch core
In-Reply-To: <20260605123220.414113-1-ralf@mandelbit.com>
References: <87a4tab1vs.fsf@toke.dk>
 <20260605123220.414113-1-ralf@mandelbit.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 10 Jun 2026 13:14:47 +0200
Message-ID: <87y0gm8x5k.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.07 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297637-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[toke@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ralf@mandelbit.com,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mandelbit.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9565A668B5A

Ralf Lici <ralf@mandelbit.com> writes:

> Hi Toke,
>
> On Thu, 04 Jun 2026 20:23:51 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@kernel.org> wrote:
>> Ralf Lici <ralf@mandelbit.com> writes:
>>
>> > This commit introduces the core start_xmit processing flow: validate,
>> > select action, translate, and forward. It centralizes action resolution
>> > in the dispatch layer and keeps per-direction translation logic separa=
te
>> > from device glue. The result is a single data-path entry point with
>> > explicit control over drop/forward/emit behavior.
>> >
>> > Signed-off-by: Ralf Lici <ralf@mandelbit.com>
>>
>> This is very cool! Going quickly through the series, this seems like
>> thorough work that will be cool to have available in the kernel, so
>> thanks for doing this! I'll be quite happy to retire my barebones
>> BPF-based implementation once this lands :)
>>
>
> Thanks, glad to hear this looks useful. I have not had much time to work
> on ipxlat lately, but I hope to respin the RFC soon.
>
>> One comment on the device model below (which is also why I chose this
>> patch to reply to):
>>
>> > +static void ipxlat_forward_pkt(struct ipxlat_priv *ipxlat, struct sk_=
buff *skb)
>> > +{
>> > +	const unsigned int len =3D skb->len;
>> > +	int err;
>> > +
>> > +	/* reinject as a fresh packet with scrubbed metadata */
>> > +	skb_set_queue_mapping(skb, 0);
>> > +	skb_scrub_packet(skb, false);
>> > +
>> > +	err =3D gro_cells_receive(&ipxlat->gro_cells, skb);
>>
>> So given that you're not resetting skb->dev here, IIUC, this means that
>> the translated packet will magically re-appear as if it arrived on the
>> interface it first came in on, right?
>>
>> That seems... a bit too magical? Sending a packet to one device making
>> it suddenly reappear on a different, unrelated, device seems like it
>> will just create confusion. It's like the ipxlat device can't really
>> device if it's a device or a tunnel? :)
>>
>
> That's not quite what happens in the routed xmit path. There the stack
> sets skb->dev to the selected output device before handing the skb to
> the device. For IPv4 and IPv6 this happens in ip_output/ip6_output,
> where the output device is taken from the skb dst. So when the route
> selects the ipxlat device, the skb reaches ndo_start_xmit with skb->dev
> already pointing at the ipxlat device, not at the original ingress
> device.
>
> The internal 4-to-6 pre-fragmentation path should preserve the same
> property as well: ip_do_fragment copies the skb metadata to the
> generated fragments, including skb->dev, and the temporary dst used for
> that path also points at the ipxlat device. The fragment callback then
> feeds those fragments back into the same ipxlat processing path.
>
> That said, I agree that relying on this implicitly is not great.
> gro_cells_receive uses skb->dev directly, and the intended receive-side
> re-injection model should be obvious at the call site. I will set
> skb->dev =3D ipxlat->dev explicitly before gro_cells_receive in the next
> version.

Right, sounds good. I'm also wondering if you actually need the gro_cells
infrastructure at all? IIUC, the purpose of that is to allow tunnels to
create GRO superframes of packets after they are decapsulated (and thus
their l4 commonality becomes apparent). But you're not decapsulating
anything, you're just translating between protocols the kernel already
understands. So presumably any opportunity to coalesce GRO packets would
already have happened pre-translation? So any reason why you can't just
do what loopback.c does, and do a straight __netif_rx() call in the
transmit function?

>> I think a better model is to treat the device as basically a loopback
>> device that translates packets before looping them back (so when they
>> come back they appear to be coming from that device).
>>
>> Any reason why that wouldn't work?
>>
>
> That's indeed the intended model for the ipxlat netdevice: route packets
> to it, translate them, then loop them back into the stack as packets
> received from that same device. That seemed like the simplest model and
> the one that exposes the translation point most clearly.

Right. I think this could be made a bit more explicit in the
documentation as well, since it's a bit of an unusual model.

And, well, taking a step back: is it really the right model? Regular NAT
lives in netfilter, why can't this be a netfilter module as well? Seems
to me you could have something like:

table ip xlat4 {
	chain postrouting {
		type nat hook postrouting priority srcnat; policy accept;
		ip daddr 0.0.0.0/0 oifname "eth0" xlat to 64:ff9b::/96
	}
}
table ip6 xlat6 {
	chain prerouting {
		type nat hook prerouting priority dstnat; policy accept;
		ip6 saddr 64::ff0b::/96 iifname "eth0" xlat from 64::ff9b::/96
	}
}

and that would provide the functionality without having to implement a
new interface type and the associated multiple traversals through the
stack? Did you consider this as an alternative to the new device type?

-Toke

