Return-Path: <netdev+bounces-260408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEHON9RpnWnYPwQAu9opvQ
	(envelope-from <netdev+bounces-260408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:05:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F76184392
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DC15301CFB8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F3A34D915;
	Tue, 24 Feb 2026 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wp00/+Xh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877B22A4EE
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923649; cv=pass; b=MASIbzF8cxwoeKTLeb3N9ojXt9kDYy4eTqqt/aPNQhv3e2gLawHY70UA+2pmEgfNTlqfsB86fP7ug6K1fQhRHN903SlhgXx6bweib7Ive0X5wtKu+vhbeu4FqVSjJQseWAuIGcXmmIhrycH7YgMYm853hexShk48J+C5/ptmo6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923649; c=relaxed/simple;
	bh=wLFHqaQhbZe7jfZw2fS6oleAtKd+i/S6lViXqAN32vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tvp+zeztGjArSjEIbzu/5YgIVLPLWmbWXAvuUzAxOq0qPDTSFvf1Hv7hAYGGe7CTcTDhzSXV8YiJpvlkI5BXULpNpJ6Sv637hr5MHJGbZQFqxHyb9biudwaZ01rYp88YQlDm61Kp7I9fcvwaJtvNmH8Rybh00VB4SUKwy+qDjAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wp00/+Xh; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506bcb23a78so47023791cf.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:00:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771923647; cv=none;
        d=google.com; s=arc-20240605;
        b=Iy2BusQyap4Htllp/zs3qfREnOhl6OrRWyYtdRDYzWSx50v0A3wyw4iVPahKMnZcGB
         ypBHnLHjsILRTQXfnRgInHgGLsWQwNP2XH8EO4EQPqHAc1fzfJFnn6ecRIjSIS/7Kd8H
         XeFrVpiRZCbHyCmIwpcRVvuL7OvalMe1jgcKHudiMCzOgeMyibjKf819rgWek8uJFb2X
         G2MH0wdhYA2Wi6/4ht9SkJnEAwfarWeEN2gvNJEfeH9ZCNUsSRyCthsM/TRgdGjxbAcz
         CBqixANrYJKp7WYzi9S4pKt/CgKSfz8lTnMDJFwXHORy1+5pNGDzWY9UCLkziGQlt1Ib
         bEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m514faiLkKFU7i0FQox2dA9QSjmC05YdIT0oKjgYHw8=;
        fh=zwn+vWRIxgmMEjxQquHIuVgDlGgOq4KefnJzCe3oEtg=;
        b=fYuah4oMpnNHeUMNiL+GLIeOQR4/u0D0TaH8xlWipKPLbcbpPCsfoxZZ2rTyGxD7OR
         ngsjUctpnu0JqNtE6y1juLW8t8mu8AaIzmZdk2i5yR8ZYkj/HkGK3WmTls1BQ2ZENqiz
         H2AOWXNQ9Wa7b7xPlMfUOAkhT1jmHXXBYw0nNXupzAzpmFa+Nvj5Yb5TvRlJ71JLxJhj
         W+IpZWEwMt9YhJlBG6rsLTy7DUuMoh1SsIRVob9j0DWcILIz32VamX+j/m/m+kbRxIXI
         E4+cXvfDI7wl8kHs7iUHYWVhHQ0VbQcq0vi2Qy/tJThsjtz4wDT9FeM48sn4YGFlKkcS
         iJRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771923647; x=1772528447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m514faiLkKFU7i0FQox2dA9QSjmC05YdIT0oKjgYHw8=;
        b=wp00/+XhTMQC3uZyS8I2IjWevVyPh3SvrCbIjbmzLgVWNofrsUBtCNvee7gZ9zoZNr
         ae0ShHoUt9wOjI8ANqeEqSSst0kBHR0eJGAG/19KcvtXPPFAoTo4M3zEmplmyKgEB/Oa
         QqZChRmpnMMYJTJ72GJV1jsUHhf/wUwXE5xuBod6NlfCIAdTBo2QRv4MG1MiyqUcLOPW
         6xKkOMgz67QefocKPWQmGFO7O0ltiuXWyA5hxsYoa9ADRt0YUppmL9T4WalERSrH1zo2
         aG0dQpqZO/zeGv81/M9bXUBaLZOPIEs1InCyPvFv4TBEKMSWA3Os1EQnUOS2s79gSC5x
         opew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771923647; x=1772528447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m514faiLkKFU7i0FQox2dA9QSjmC05YdIT0oKjgYHw8=;
        b=S2aGRp25Lf/0n8UR8azsLM+VKdgjANnTcBIhdjQETJAm6kFhEVk6Lvl/adM6oollGc
         FCmUXMQ6t59LsdWNmDWsleljkF0+Qirni9qvUI4VaIp0Y8QzVmwj8vDdpEtA4lNAWERI
         Nc+mD7aStf22cIg2i9GIzHcZpsg0AyoZSB2uGBhllZTR8pQmHhwVaXqBspzUrTwpOgjq
         oXd8wCfUPIp4ovNEvm2dsCScnOdYQMqrLlWJvqGh5jWCJ8JkVsPHGjRjUMKwvwk7uMvt
         EoVLMvLIPd4XuA5l6L4wAFvKQzpynt02Lk42D2eE31KwGy9oJlLnztH+AHvP/oaZBUMs
         zkIw==
X-Forwarded-Encrypted: i=1; AJvYcCVVFEwqCFkLsNSQHKPcfz/wp/ETDSpv3lpx+zh7HNqPpZExgHfEL7Qc8ItjfkEbbsHA1aHU/is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU6D9PFJtFrw3iiTWC+KUs6uq6gdfJauKCAJItgixQ7WkTiUoq
	Z5kMwuHIC/ph98mujkSHcaWryK5MDr1zaAKLLvEbfIbZYl/9Zfxbc3oMqVKxyWGWaIZKA/Dl4zt
	rFZzI5xdZLanHpD5XKwbj4Mg5YCtra+Z/M02vtcnr
X-Gm-Gg: AZuq6aIiz3CLZkspIaRGPyfkTDAOWVysjO5/FAS3NAxc4vZeQ1jK4fTR4RS5m9W/DVK
	nztvMbdwaWEdJKl0FuCeKyOEllQpoEKNNHZ64rlBtLJN9fTNp9yBeciFL2zyH1lnICGP6INF+Fm
	hSP1tfyARplRhguGgetulUhhaKb+glY1zB9b6iCwffpyr6xEcDJZhz7gHuPuDyNRl4OhiHqDKIu
	R0o9RcRVnAvueAAaetPEyU9aYknxaecdn3rYjCs5Pf+l/f/ebpFVqOy2uIIA5jR4th4IKyC2v+F
	37j8kGpOWXK4PilgEwnUzjf3teiceIN6Dlx5GC/DIw==
X-Received: by 2002:a05:622a:1483:b0:4ff:c088:2f23 with SMTP id
 d75a77b69052e-5070bc4c201mr167488521cf.46.1771923645399; Tue, 24 Feb 2026
 01:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223235100.108939-1-kuba@kernel.org>
In-Reply-To: <20260223235100.108939-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Feb 2026 10:00:34 +0100
X-Gm-Features: AaiRm51a4-OhiCYEpsPIwJXhceHWwNJXi4jc2R13-GzMvNaA27oR4bg5JKXBTgY
Message-ID: <CANn89iLfWyUtfZLtRWWkuSQh2VCHN2=TFuJcBoTnOFLDdQyJ5w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: consume xmit errors of GSO frames
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, hawk@kernel.org, 
	alexander.h.duyck@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260408-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,udpgro_bench.sh:url,udpgro_frglist.sh:url]
X-Rspamd-Queue-Id: E4F76184392
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> udpgro_frglist.sh and udpgro_bench.sh are the flakiest tests
> currently in NIPA. They fail in the same exact way, TCP GRO
> test stalls occasionally and the test gets killed after 10min.
>
> These tests use veth to simulate GRO. They attach a trivial
> ("return XDP_PASS;") XDP program to the veth to force TSO off
> and NAPI on.
>
> Digging into the failure mode we can see that the connection
> is completely stuck after a burst of drops. The sender's snd_nxt
> is at sequence number N [1], but the receiver claims to have
> received (rcv_nxt) up to N + 3 * MSS [2]. Last piece of the puzzle
> is that senders rtx queue is not empty (let's say the block in
> the rtx queue is at sequence number N - 4 * MSS [3]).
>
> In this state, sender sends a retransmission from the rtx queue
> with a single segment, and sequence numbers N-4*MSS:N-3*MSS [3].
> Receiver sees it and responds with an ACK all the way up to
> N + 3 * MSS [2]. But sender will reject this ack as TCP_ACK_UNSENT_DATA
> because it has no recollection of ever sending data that far out [1].
> And we are stuck.
>
> The root cause is the mess of the xmit return codes. veth returns
> an error when it can't xmit a frame. We end up with a loss event
> like this:
>
>   -------------------------------------------------
>   |   GSO super frame 1   |   GSO super frame 2   |
>   |-----------------------------------------------|
>   | seg | seg | seg | seg | seg | seg | seg | seg |
>   |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |
>   -------------------------------------------------
>      x    ok    ok    <ok>|  ok    ok    ok   <x>
>                           \\
>                            snd_nxt
>
> "x" means packet lost by veth, and "ok" means it went thru.
> Since veth has TSO disabled in this test it sees individual segments.
> Segment 1 is on the retransmit queue and will be resent.
>
> So why did the sender not advance snd_nxt even tho it clearly did
> send up to seg 8? tcp_write_xmit() interprets the return code
> from the core to mean that data has not been sent at all. Since
> TCP deals with GSO super frames, not individual segment the crux
> of the problem is that loss of a single segment can be interpreted
> as loss of all. TCP only sees the last return code for the last
> segment of the GSO frame (in <> brackets in the diagram above).
>
> Of course for the problem to occur we need a setup or a device
> without a Qdisc. Otherwise Qdisc layer disconnects the protocol
> layer from the device errors completely.
>
> We have multiple ways to fix this.
>
>  1) make veth not return an error when it lost a packet.
>     While this is what I think we did in the past, the issue keeps
>     reappearing and it's annoying to debug. The game of whack
>     a mole is not great.
>
>  2) fix the damn return codes
>     We only talk about NETDEV_TX_OK and NETDEV_TX_BUSY in the
>     documentation, so maybe we should make the return code from
>     ndo_start_xmit() a boolean. I like that the most, but perhaps
>     some ancient, not-really-networking protocol would suffer.
>
>  3) make TCP ignore the errors
>     It is not entirely clear to me what benefit TCP gets from
>     interpreting the result of ip_queue_xmit()? Specifically once
>     the connection is established and we're pushing data - packet
>     loss is just packet loss?

TCP updates some state immediately, instead of relying on RTO.

local congestion (especially with pfifo_fast) has been a thing, I
agree that with FQ of FQ_CODEL we do not care much.

>
>  4) this fix
>     Ignore the rc in the Qdisc-less+GSO case, since it's unreliable.
>     We already always return OK in the TCQ_F_CAN_BYPASS case.
>     In the Qdisc-less case let's be a bit more conservative and only
>     mask the GSO errors. This path is taken by non-IP-"networks"
>     like CAN, MCTP etc, so we could regress some ancient thing.
>     This is the simplest, but also maybe the hackiest fix?
>
> Similar fix has been proposed by Eric in the past but never committed
> because original reporter was working with an OOT driver and wasn't
> providing feedback (see Link).
>
> Link: https://lore.kernel.org/CANn89iJcLepEin7EtBETrZ36bjoD9LrR=3Dk4cfwWh=
046GB+4f9A@mail.gmail.com
> Fixes: 1f59533f9ca5 ("qdisc: validate frames going through the direct_xmi=
t path")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - rewrite to also cover the BUSY case
> v1: https://lore.kernel.org/20260220170032.2964535-1-kuba@kernel.org
>
> CC: sdf@fomichev.me
> CC: hawk@kernel.org
> CC: alexander.h.duyck@intel.com
> ---
>  net/core/dev.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 096b3ff13f6b..52e5dd6c2e20 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4822,6 +4822,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct ne=
t_device *sb_dev)
>                  * to -1 or to their cpu id, but not to our id.
>                  */
>                 if (READ_ONCE(txq->xmit_lock_owner) !=3D cpu) {
> +                       bool is_list =3D false;
> +
>                         if (dev_xmit_recursion())
>                                 goto recursion_alert;
>
> @@ -4832,17 +4834,28 @@ int __dev_queue_xmit(struct sk_buff *skb, struct =
net_device *sb_dev)
>                         HARD_TX_LOCK(dev, txq, cpu);
>
>                         if (!netif_xmit_stopped(txq)) {
> +                               is_list =3D !!skb->next;
> +
>                                 dev_xmit_recursion_inc();
>                                 skb =3D dev_hard_start_xmit(skb, dev, txq=
, &rc);
>                                 dev_xmit_recursion_dec();
> -                               if (dev_xmit_complete(rc)) {
> -                                       HARD_TX_UNLOCK(dev, txq);
> -                                       goto out;
> -                               }
> +
> +                               /* GSO segments a single SKB into
> +                                * a list of frames. TCP expects error
> +                                * to mean none of the data was sent.
> +                                */
> +                               if (is_list)

Note this will return  NETDEV_TX_OK even if no segment was sent.

 This is probably fine.

Reviewed-by: Eric Dumazet <edumazet@google.com>

