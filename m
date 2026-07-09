Return-Path: <netdev+bounces-306082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lmmsFpNST2rReQIAu9opvQ
	(envelope-from <netdev+bounces-306082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 09:49:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4354372DF17
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 09:49:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b=q7oCQ2iT;
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b="QWb/dRSt";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306082-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306082-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CCC830A2C30
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B03E5589;
	Thu,  9 Jul 2026 07:34:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-24.smtp-out.amazonses.com (a9-24.smtp-out.amazonses.com [54.240.9.24])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA33E3148;
	Thu,  9 Jul 2026 07:34:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582448; cv=none; b=On4SZ5qwvFzb87rgXrWeEAreodA+ECppIp8L+RE42pgOqB++JKBuLhP6Bo5XeFc7DFWYpLvlInTZNkDRisRVqUQ5n+KK4Qp6TAiwvE1UeCcLXCXlVJt4AGxNmnwBCPUhmQKCdPXYqeNzs3bYR8IK9ol52ze0e6KMHD0X/hf6tsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582448; c=relaxed/simple;
	bh=ffmcoX5dLpTuQVb52phMivqfVFjJTx5n/J7UOF6+aOM=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=kigehcMiUjbpCwUVVPssbeBkw50OIWGF+p1N6j4kYOsXPl0gkMZ0dIlvSAVW5oGgZtM3auy5n4WKNIFbO0mVSwwhpETdvtPjLKQAob6Pn8AAHKT8GzPix+yFBluifDmrrl6ke5Nhssq5vR32gmQ3tEQmEdYgSuodX2Pbvi6QHEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=q7oCQ2iT; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=QWb/dRSt; arc=none smtp.client-ip=54.240.9.24
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1783582445;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=ffmcoX5dLpTuQVb52phMivqfVFjJTx5n/J7UOF6+aOM=;
	b=q7oCQ2iTrPQ78m6m80FkQ0XmJ3It6ryCJuXAstYeKOiSg0yx+a5/sjT3diOmdhVh
	cDowV6ttsn1h1sEIJRPqTybFFQ7OXN5h7eP2WdQ9FZupG5Oyhucv50IQVOIQ8gQesGl
	pZYLig6rrLOukfgVEfM+YY6yuSBbTl4rQXgu08fQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1783582445;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=ffmcoX5dLpTuQVb52phMivqfVFjJTx5n/J7UOF6+aOM=;
	b=QWb/dRStyBFXRo5yoBFMulxP84SBuiLywvJR2vRQdZVFz3LOyzEqNhNK0rWn73Iu
	idW/Pwagx7GyZIFhmrmcISt7l1HaT0FXdbeyqq/jVXtQpXn64c32/LOt/RIrzhzzyb+
	EMwqNIRW0Oo03fC5qGiKbyVwEGUXRanpsexogh+o=
In-Reply-To: <577055ac-9378-4d43-9ff2-1a1dd17ae9dc@yahoo.com>
From: Johan Alvarado <contact@c127.dev>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: dsa: realtek: rtl8365mb: add
 HSGMII support for RTL8367S
Message-ID: <0100019f45cc4fe2-2464b68a-dfcf-4e93-9bfc-8445370d8e3e-000000@email.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Thu, 9 Jul 2026 07:34:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.07.09-54.240.9.24
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[c127.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:namiltd@yahoo.com,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:luizluca@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[yahoo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306082-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazonses.com:dkim,vger.kernel.org:from_smtp,c127.dev:from_mime,c127.dev:dkim,email.amazonses.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4354372DF17

Hi Mieczyslaw,

On 7/3/2026 5:12 PM, Mieczyslaw Nalewaj wrote:
> Johan, looks like you forgot to include the scheduler bandwidth bits
> for the CPU port. Without this, HSGMII will still be capped at the
> old SGMII rate limits. Something like:

Good catch. I had dropped these on the assumption that the vendor
driver never touches them, but your mail made me look again: the
"Max rate" block in dal_rtl8367c_switch_init() programs exactly these
registers for EXT_PORT0 - the port 6 ingress and egress rate limiters
are raised to 0x7FFFF via rtl8367c_setAsicPortIngressBandwidth() and
rtl8367c_setAsicPortEgressRate(), followed by a raw write of 0x0007
to 0x03fa (LINE_RATE_HSG_H). I had missed it because those writes go
through the indexed register macros and a raw address rather than the
PORT6_* register names.

On my board this was masked by the bootloader: U-Boot runs the vendor
switch init (rtk_switch_init() from the ipq5018 gmac driver) and
leaves the limits raised, but the kernel driver then issues a full
chip reset in rtl8365mb_setup(), which puts these registers back to
their reset defaults. With the ingress/egress limiters back at their
defaults that would indeed cap HSGMII at roughly 1 Gbps, and I could
not have seen it in testing because my downstream ports are 1G only
(as noted in the cover letter, 2.5G line rate is unverified on my
hardware).

One caveat I want to be transparent about: for the same reason I
cannot verify the cap itself, and the vendor documentation leaves
some room for doubt. The rtl8367c_setAsicPortIngressBandwidth()
comment describes the bandwidth value 0x1FFFF as "disable", and
that is exactly the reset default - I read back both limiters as
0x1FFFF (LSBs at 0xFFFF, MSBs at 1) on my RTL8367S after the
driver's chip reset - so the limiter may in fact be disabled out
of reset (though that note looks like stale text from earlier
17-bit-granularity chips, given this family's maximum is 0x7FFFF).

Raising the limiters is safe under either reading: if the default
really is a ~1 Gbps limit, the write removes it, and if it means
"disabled", the new value (0x7FFFF * 8 Kbps, about 4.19 Gbps, well
above the 2.5G line rate) never engages.

While I cannot push more than 1 Gbps, I did verify that these
registers really are the live rate limiters for the SerDes CPU
port, by going the other way: on a build with the setup-time
writes described below already in place, I lowered the limiters at
runtime (via regmap debugfs) to 12500 * 8 Kbps = 100 Mbps
and ran iperf3 across the CPU port. Throughput clamps from ~460 to
~95 Mbps with the ingress limiter lowered (CPU-originated traffic)
and from ~600 to ~96 Mbps with the egress limiter lowered
(CPU-bound traffic); restoring the maximum returns both directions
to baseline. The ~95/100 ratio is the expected TCP goodput for a
100 Mbps wire-rate limit, so both limiters demonstrably meter this
port at the documented 8 Kbps granularity. The only thing this
cannot settle is the meaning of the 0x1FFFF default itself
(~1.048 Gbps cap vs. disabled), since any value at or above the
traffic I can generate behaves identically. If you have an
RTL8367S setup that can push more than 1 Gbps across the HSGMII
CPU port, a before/after measurement would be a very welcome
confirmation of the cap.

So I'll add the writes in v5, following the vendor init: raise the
port 6 ingress/egress limiters to their maximum once at setup time,
rather than per interface mode. Two differences from your snippet:
the vendor init writes the full 19-bit rate value, i.e. the LSB
halves too (0x00cf and 0x0398 set to 0xFFFF), so I'll program both
halves rather than only the *_CTRL1 registers, to avoid depending on
the reset defaults of the LSB registers. And LINE_RATE_HSG_H needs no
new write at all: the driver's common init jam table has always
written 0x03fa = 0x0007 in rtl8365mb_switch_init(), so that one is
already at its maximum on every probe (which also matches the 7 you
read back for it). I have this running on my board already: with the
setup-time writes in place both limiters read back 0x7FFFF after
probe, and the HSGMII link comes up and forwards as before.

As an aside, a per-interface-mode variant of these writes does exist
in the vendor code, but only for other chip families: in
rtl8367c_setAsicPortExtMode(), the chip id 0x0652/0x6368 branch
programs its rate registers (0x0130/0x039f/0x03fa) on every mode
change, with 7s for EXT_HSGMII and lower values otherwise, and the
0x0801/0x6511 branch writes 0x00d0/0x0399/0x03fa = 7 only for
EXT_HSGMII (which is where the pattern in your snippet comes from).
For the 0x6367 family the ext-mode path never touches them, and the
vendor only programs them once, unconditionally, in switch_init -
which is another reason I prefer the one-time setup write over doing
it from the PCS path.

For completeness, the same vendor block also touches three related
bits: rtl8367c_setAsicPortIngressBandwidth() additionally clears the
port 6 ingress metering pre-IFG bit and sets the "flow control when
ingress rate exceeded" bit (PORT6_MISC_CFG, 0x00ce bits 10/11), and
switch_init follows the egress rate write with
rtl8367c_setAsicPortEgressRateIfg(ENABLED), which sets the global
"egress rate accounting includes IFG" bit (SCHEDULE_WFQ_CTRL 0x0300
bit 0). With the limiters raised to maximum the meter never engages,
so neither the exceed action nor the IFG accounting has any
observable effect. I plan to leave those three bits at their reset
defaults and program only the rate values and LINE_RATE_HSG_H, to
keep the driver's footprint on the QoS block minimal - but I'm happy
to mirror the vendor init exactly if you'd rather not deviate from
it.

> One more thing while we're on this: I checked the equivalent
> registers for RGMII on the RTL8367S, and they come out to 1, 1, 7
> respectively (INGRESSBW_PORT6_RATE_CTRL1, PORT6_EGRESSBW_CTRL1,
> LINE_RATE_HSG_H). For correctness these should be set to those
> values in the RGMII path as well, rather than left at whatever
> reset/default state they're currently in.

The 1/1 you read back for the rate limiter MSBs match the reset
defaults I see on my RTL8367S as well, and the 7 for LINE_RATE_HSG_H
is the value the common init jam table writes on every probe, as
above. Since the driver hard-resets the chip and then replays the
init jam on every probe, those values are already guaranteed in
the RGMII case, so writing them again from the RGMII path would be
a no-op. These fields are also the MSBs of the per-port QoS rate
limiters rather than link-mode configuration, so I would prefer to
touch them as little as possible from the link paths. My plan for
v5 is therefore the single write at setup time described above,
which covers both SGMII and HSGMII and has no functional effect on
RGMII either way: both the default value (~1.048 Gbps, if it acts
as a limit at all) and the raised maximum sit above the 1G RGMII
line rate, so the meter never engages there. Let me know if you
see a problem with that.

Best regards,
Johan

