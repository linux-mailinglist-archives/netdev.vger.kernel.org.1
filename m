Return-Path: <netdev+bounces-259745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HpQETiXmGlaJwMAu9opvQ
	(envelope-from <netdev+bounces-259745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:17:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D4169A96
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8AC9301B914
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8056B32A3FF;
	Fri, 20 Feb 2026 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2WSrP4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0F30FF33
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607849; cv=pass; b=LtbKSH2C6UBarmtbl3l9xq3Oimpr/YInc4Urhtpcr7mDelA+scWSRUKIb2HgnY+WsB9SBQqFr5MyyWRzfLEii5bQgrX7PSSf9U/vPEnS7KrlatfAC50MuRCSEGrp+ulMDEvNFZ9srKPwixFxrURPqss+wEZyFBzKdCiPqEuwbJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607849; c=relaxed/simple;
	bh=jfNiaFCXtlw02EoxtwpDjqDA1LYnwuI/dmZ8Gt2H/6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSLkpgRgvya0LkQ434k4F7vJr3Liz0+bFkEaXcE3q5d5vwAj5cFuV8c7SV+627V0XMgKdEgSQCTjOxfPo7TiN1A5NA5DOjkiCA6CKwL5y4U6a/QdrsvSlDnIbHVcCBNzO9foJqFnp8AB5OAkzST5xXAjjJMGiM5FggZ2F9OVzvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2WSrP4t; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5062fc5d86aso21227551cf.1
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:17:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771607847; cv=none;
        d=google.com; s=arc-20240605;
        b=Fp9reBmg8HE7/uXnY8iDcijfrxdvld2vWV7ScxAT7OIL4Qdjz5trkKX+neX3dXZNny
         ce/FUaaJc8bl1c5MCXIstJ9OhBIT6TgFCd95fcPDtFCn4DpmQEu5XweGDHaTjdjUEbRu
         j1Sy68XFnueOrDpV9BAmW/+z2BR/PwLOfkgMoHJhMmnPIFoSwz4qYgmWSgaZQiMWdh6Y
         6M/urqSXAKKtg4yEnD/Dc2Z35JG4n6thQbHs03AgPQl49hM7S3jxEk6Vb/LebUpRErCs
         1eFNAIlCVbewRYOSHyf+Z7GEQ+w6tpmEpVHHKpfhvKuEQto3zT2Muq6g+Oj07yV2lA8/
         ykEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QyYLFzkbx5oKoOJJX3p8w6asrZV8dohohHTDKHE+Pqo=;
        fh=YK+9bwgCu9aqvjrUXyx7Uhu1n/1xuu6e8d7fcGo/wHs=;
        b=b7dLS0Kc0zlp+PzS8TJkqs3GVL1Jf0/2eeMBV4GbLzuhZxnQqWLXpXVW7+kNo/rN3v
         lwN7jbS5H9/WDd1VAQTaIJVEYHA6CXqLqPdZsYCYUbfhxh4YGUdsqVjAfINtb0pSaAjU
         MSovVrM7jdWpizCrVVuZIpImgyLqZi0K5iGrTpr204Oe/7Xn65fRPxBM0dO9kaSwUYUE
         ldlIAXnged3NZWSqk8n8vZmK+wuaUGDlP/+cpB7q8zfF0rY5+5h0hZNU/J+Lb/ZXjA6U
         cFocDlKqx/Z4hd+5sE9wqv4HfbmBmLH9d/BQhTGd0g/+o5F+3iE2Lu0H65c4Bc4FsdA0
         OWzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771607847; x=1772212647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyYLFzkbx5oKoOJJX3p8w6asrZV8dohohHTDKHE+Pqo=;
        b=k2WSrP4tbhtCbeJIuq8DQ9Ei7HXJztX9ntk7DP7FUErqqxQsLM9GFq/541sm8HYkI6
         UebUhA9nk2t6jUXKt13PxDLKCIB9vQa9Jb3qrFEbN8vXeWQXjl5K1XZUWF80f3F6GEyD
         nlXaa+71UtvMOn6QBqQKoFlwaqhCGbRao72zvqfRe1wSyVHAWYExMVHYqmQ4uTl//zD+
         OCLBeEEJ1iDTEktP7jLSH9c3mVSMl59xY/q7f85MjWG+zZWZie+6kFXVwVzWVQE9WWYw
         deidHsSRTs4hyGr+yZyUHs5dZOU5no5HWCBNUqdXRyRbxh0a6GzZVprt940ZZ7b6f2Ae
         Jk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771607847; x=1772212647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QyYLFzkbx5oKoOJJX3p8w6asrZV8dohohHTDKHE+Pqo=;
        b=rB1Fga+8x1PAcQ7kTq7OnM7Z58UzdDyhKvA+rJAPiJ6dw3+2RV/uJ5kLRpLMnOSJFH
         ZWXp9bGRlDrLicG6d1ijZLDlcI4BtppoTOBN7Nt2bdZs79OAXoSEUCCW6nemU49ezHVL
         qNVmIcr/FUVYwmq3kboYsS0rUMfQAvpeqNz1pgAU1Ku89kIqjo1VVTZVQ8gMkX5fvxAB
         wuXDqSIGvseOoGU3qf38/SlJY5gKcDKxdkgoeVmVpDNDpHXV04Q2DmCqIJKTKF055Tzi
         kHBHceXreDk1iMkgLf68QD/TilIUjmiOejRZd6vJh/7Kc2BwFNNUpG3Xk2i6tBTVUzxC
         n5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWy3BQsgRJOH1x2gydEG3q5De8dXi6FPH4EEWs0zMv2ruVM84Sr0vfSIb+bifsVlYoa4HrOeZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJY8CV8hLDsDEZk6RimjSnN747ljh2PZ9bbT3hssb+Wk8nS7g9
	9iuNLR/pAjPkex/lRZSokRjVRtjyY5hcfQ8LvCYlawoAWVGQb9FFy3WJY8Y2Gkl0kD717X+cAlS
	QncjuwnuOkM5C90PQrdsyO+8x7VtRahp82GhTQu7eq76xPtuwf8ncuyEV1nA=
X-Gm-Gg: AZuq6aIItf0dpUw7gZqHjB0rUY8K16EY00uecrGvR4iKoW4eQLZO3Qk7YD0PeVgEIk7
	+/AfIURc0iNUuKam1nXcTPZ2RdFowtuIu1qbJTAwVxP+HKZoYljo2GRNgmBfp6/wm1NxcAW5Lqj
	llRWJ3kOsevqF1rtfd+sOD3xqcoGuEWCHOaEDW4npUdtatFzZXujYFL0m9huEScKYe7E0iqsnhQ
	hWomqiWaY/H2AeOc10roul5fJ3TG3kuK15I9yDYlCu1dxZPuKJxykwzdnp5mysAYYs9aRHM1D8t
	HKhBi0M=
X-Received: by 2002:ac8:5d0d:0:b0:502:e25c:91a8 with SMTP id
 d75a77b69052e-5070bc93af1mr7212971cf.61.1771607846059; Fri, 20 Feb 2026
 09:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220170032.2964535-1-kuba@kernel.org>
In-Reply-To: <20260220170032.2964535-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Feb 2026 18:17:14 +0100
X-Gm-Features: AaiRm53cEpRsf1rNYQ7OrKHwvTCZ8bLeWJJrukl_56_peew8KrH9XItDmvnajcw
Message-ID: <CANn89iKQUHeonhTJE2pOQ95TMj9s8JttHWCZr9Yy3sii6XXV0A@mail.gmail.com>
Subject: Re: [PATCH net] net: consume xmit errors of GSO frames
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
	TAGGED_FROM(0.00)[bounces-259745-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,fomichev.me:email,udpgro_bench.sh:url,udpgro_frglist.sh:url,spinics.net:url]
X-Rspamd-Queue-Id: 948D4169A96
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 6:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
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
>
>  4) this fix
>     Ignore the rc in the Qdisc-less+GSO case, since it's unreliable.
>     We already always return OK in the TCQ_F_CAN_BYPASS case.
>     In the Qdisc-less case let's be a bit more conservative and only
>     mask the GSO errors. This path is taken by non-IP-"networks"
>     like CAN, MCTP etc, so we could regress some ancient thing.
>     This is the simplest, but also maybe the hackiest fix?
>
> Fixes: 1f59533f9ca5 ("qdisc: validate frames going through the direct_xmi=
t path")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: sdf@fomichev.me
> CC: hawk@kernel.org
> CC: alexander.h.duyck@intel.com
> ---
>  net/core/dev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 096b3ff13f6b..fd700a00c4d9 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4832,11 +4832,19 @@ int __dev_queue_xmit(struct sk_buff *skb, struct =
net_device *sb_dev)
>                         HARD_TX_LOCK(dev, txq, cpu);
>
>                         if (!netif_xmit_stopped(txq)) {
> +                               bool is_list =3D skb->next !=3D NULL;
> +
>                                 dev_xmit_recursion_inc();
>                                 skb =3D dev_hard_start_xmit(skb, dev, txq=
, &rc);
>                                 dev_xmit_recursion_dec();
>                                 if (dev_xmit_complete(rc)) {
>                                         HARD_TX_UNLOCK(dev, txq);
> +                                       /* GSO segments a single SKB into
> +                                        * a list of frames. TCP expects =
error
> +                                        * to mean none of the data was s=
ent.
> +                                        */
> +                                       if (is_list && rc > 0)
> +                                               rc =3D NETDEV_TX_OK;
>                                         goto out;
>                                 }
>                         }
> --
> 2.53.0
>

This rings a bell.

I sent back in October something in the same vein.

https://www.spinics.net/lists/netdev/msg1131452.html

