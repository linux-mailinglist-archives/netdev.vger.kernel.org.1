Return-Path: <netdev+bounces-260128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIZ7NpSLnGl8JQQAu9opvQ
	(envelope-from <netdev+bounces-260128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:17:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A1D17A904
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E25BF3047BDB
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501A2330D5E;
	Mon, 23 Feb 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2RRAXOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2271330D26
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867002; cv=none; b=drxxNBEYDn7DZL5E+ABF2/Luku1L3shzflW1PiD2m/go/+RrX4RH2SZECAUk527MWfbRZiQ2RHwUsZMLEqB2dfYtrcaO1yOeDoY0T9b399ZGwpGA179xSjZdp7bZbmauYxsJ3DuuXTNLlr0RP/UQfzKgti4zqIaFidoKLByhcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867002; c=relaxed/simple;
	bh=BzKwdlyoAEssFRnM96qoS8PG4Ad9xyev/bf3EqhCekU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBOYa3nbT49A6RyhBgGGK0QtK94Td/FqCiz7VYVg2VF0WvDulMfu3VlOC5V755iVTzgnvzT+A8ki0yFEr7KRktyF1pAm9ft/I4gR0VJ8zUXdJlwmIQKiVBRWoXx0FlwHHZ4cHf9SQbAAUZVriv8/DoatvVvGHF7eJwLDs8pUVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2RRAXOP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4834826e555so44717645e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771866999; x=1772471799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jblqPpeSoB/tKv9xpHVL5Qn7LqWC4JDIrbkAXoIweZ4=;
        b=L2RRAXOPg0Z6gKj6fpDDFKPt7Pguj0GyLAHd1t8SOGIzaQIdJqebPfRqrwjL9M42iu
         psliNGDQdS9R1IQFlB8hdr6b66I5hWSVkH8zNak7ojXt84mHFv0FPqABVQn6TaIlpfVK
         vbWmRyv86u2GTkU80YDNylVAU+AQlwSJg/NaocSLzmDD4eUIDcODOvPW/F4dvQdrbXUo
         Ho+3w/jIg+97Oc3+AgblNg9me0HShQoHzHNbDPRlZgoy4eohMjKE1KK9RsLnN/r51GBa
         ZfwKCi49jgQAD5mv+cKdIsWInjjUxl6cNxVZihXw8rsuvdcHvNDD0xLHaYv4ytOYRfHB
         F+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771866999; x=1772471799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jblqPpeSoB/tKv9xpHVL5Qn7LqWC4JDIrbkAXoIweZ4=;
        b=fJyq6YpSm3A9TjWYzmO2Sourv1n5ZKJq1yMkRjN27Gx9HAm7V4/c6qOV6//hSFMd4j
         3YRcAt73LoRZj5QvEVjAKMalgmTHo5JYnfffyw5ZXT3ZHEhYgdPPXvWBD1FltUjEKG10
         N0P3RI0C9mI3KUCK9NI7UDlFVPaqumoSmptOgjgZAKD/ZgZ5H/Yg0Vvp3BPBBjWWGKo3
         HrRQz8zgsuYnkmSgV5f1fgGbsGOHsyzK1Oxe84OuEcZf/ERjpaJKeKV02IW/L9b2VIJu
         FrX3IkUjkOobmMGfKCugw1G+I/2nUpdwvuk7m8EWlnw/kwHUmWLi4ohIi6VyMSdQ+OHv
         2org==
X-Forwarded-Encrypted: i=1; AJvYcCXyaJLB2Q/Y5GAoN7iBbb8Si/GvgnD8NHn9raMXyoYeZzf47FyMRy+gVu6GIXJHtlWDjU90jNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzA139wLAE8fZDwiDDNLyMPcuoQl4rq6+teuCC8LD++ZOzo5F
	WebJ/ZhmhQIbcoC/oNt/IP8cXv0C2uIM0Kmrlw0L2Qd0Zueu6+jfM/kZ
X-Gm-Gg: AZuq6aIVMzYo3zd6JO5WTjSjN4E6zI/oSHJzkP5KuO5dFt47zQD2c8JDUPUEh95p7hi
	BCWHbnprqJQeLYW1P4MgLvt+ezhS+w0jnj15oC1NejFZPKbCEBbxjv3S81w29EFcvdl/Dz8tgYi
	C/1uWq8JxDRjvw46OV+QMnErr3/QaZrMvXRjpVqed8beL3Qllz1ssmxEFMRmXvHQ97wxeVbi5O1
	6ucm6Vp8bnCwL2rF679JiB3U39MmclR0W7gNY4DMzzKSSo4hnuz4bxnvdoQVE21wHDAVyESdDb0
	0Ay0lFCWQQhnatoR5/v4bs65Pqj842KUd5I39HyoB8ESq4busk5OUVZXr85esWl0bmlbBqHBfZC
	qjUw/a0HbQz6WzTN9sYNDqe6EMHBpD/4Qc7ZllATt36KY2DUFfk9mKjo3S6IG1+dnWnAM1h/2AT
	siijTfaFV8g8pW8GyvIUqjGvttEap3iO6dvWPMQB2zT3oEsg66WwAA1R61dAgLUQ==
X-Received: by 2002:a05:600c:848e:b0:483:71f7:2797 with SMTP id 5b1f17b1804b1-483a9608834mr171406645e9.14.1771866998812;
        Mon, 23 Feb 2026 09:16:38 -0800 (PST)
Received: from gandalf.schnuecks.de (p5b2e2ef5.dip0.t-ipconnect.de. [91.46.46.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a4e8d392sm248277725e9.2.2026.02.23.09.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:16:38 -0800 (PST)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 844232FD9CF7; Mon, 23 Feb 2026 18:16:37 +0100 (CET)
Date: Mon, 23 Feb 2026 18:16:37 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/2] tcp: re-enable acceptance of FIN packets when
 RWIN is 0
Message-ID: <aZyLdQCaib1d4qDU@gandalf.schnuecks.de>
References: <20260222-fix_zero_wnd_fin-v1-0-5f4034952f3c@gmail.com>
 <20260222-fix_zero_wnd_fin-v1-1-5f4034952f3c@gmail.com>
 <CANn89iK5Kk2D-zMiw_2syb9OdmkKdgAA7aGfi8QNZ9XR4=CfvA@mail.gmail.com>
 <CANn89iKBjfaoWaUh6Ar2Lj-MJODywLpHzbQif=aa8q387qutZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKBjfaoWaUh6Ar2Lj-MJODywLpHzbQif=aa8q387qutZA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260128-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gandalf.schnuecks.de:mid]
X-Rspamd-Queue-Id: 93A1D17A904
X-Rspamd-Action: no action

Hi Eric,

On Mon, Feb 23, 2026 at 09:36:38AM +0100, Eric Dumazet wrote:
> On Mon, Feb 23, 2026 at 9:01???AM Eric Dumazet <edumazet@google.com> wrote:
> ...
> > >
> > > Fixes: 9ca48d616ed7 ("tcp: do not accept packets beyond window")
> >
> > OK, but this commit is fine ? It seems the issue is coming from buggy peers ?

That "Fixes" tag is a technicality, I did not want to imply that the
commit is broken: 9ca48d616ed7 (which is RFC compliant) turns the
workaround (which isn't RFC compliant) 2bd99aef1b19 ("tcp:
accept bare FIN packets under memory pressure") into dead code.

If we still need that workaround, technically, this is a regression
caused by 9ca48d616ed7.  If not, I am perfectly happy to propose a
commit that removes the dead code.

> > Eventually the receive queue would be drained by the application, the
> > peer would retransmit
> > this FIN, and it would be accepted.

If I understand the problem correctly, the workaround was introduced
to break a FIN/ACK loop because the broken peer (macOS) did not use
exponential backoff in that scenario.  So yes, it would be accepted,
but until then we and the peer would ping-pong FIN/ACKs.

But as said, if we don't need the workaround I can submit a patch to
remove it.

> ...
> > > +       reason = tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
> > > +                             TCP_SKB_CB(skb)->end_seq - th->fin);
> >
> > I don't think this is the right fix. Basically it says that FIN do not
> > count, but TCP RFC says otherwise.

We can be more specific and only allow that if we have a zero window. 
(I thought I would not hurt much to accept that FIN which does not
take up real space)

> > It also adds code in TCP fast path.

Hmm, the call site for tcp_validate_incoming() in
tcp_rcv_established() is:

	/*
	 *	Standard slow path.
	 */
validate:
	if (!tcp_validate_incoming(sk, skb, th, 1))
		return;


Am I missing something?

 
> We can keep fast path unchanged with this variant.
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e7b41abb82aad33d8cab4fcfa989cc4771149b41..156c92450f3ed00357aff2ef3e586b83f3cecb5e
> 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4858,15 +4858,24 @@ static enum skb_drop_reason
> tcp_disordered_ack_check(const struct sock *sk,
>   */
> 
>  static enum skb_drop_reason tcp_sequence(const struct sock *sk,
> -                                        u32 seq, u32 end_seq)
> +                                        u32 seq, u32 end_seq,
> +                                        const struct tcphdr *th)
>  {
>         const struct tcp_sock *tp = tcp_sk(sk);
> +       u32 seq_limit;
> 
>         if (before(end_seq, tp->rcv_wup))
>                 return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
> 
> -       if (after(end_seq, tp->rcv_nxt + tcp_receive_window(tp))) {
> -               if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
> +       seq_limit = tp->rcv_nxt + tcp_receive_window(tp);
> +       if (unlikely(after(end_seq, seq_limit))) {
> +               /* Some stacks are known to handle FIN incorrectly;
> allow the FIN
> +                * to extend beyond the window and check it in detail later.
> +                */
> +               if (!after(end_seq - th->fin, seq_limit))
> +                       return SKB_NOT_DROPPED_YET;
> +
> +               if (after(seq, seq_limit))
>                         return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
> 
>                 /* Only accept this packet if receive queue is empty. */
> @@ -6379,7 +6388,8 @@ static bool tcp_validate_incoming(struct sock
> *sk, struct sk_buff *skb,
> 
>  step1:
>         /* Step 1: check sequence number */
> -       reason = tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
> TCP_SKB_CB(skb)->end_seq);
> +       reason = tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
> +                             TCP_SKB_CB(skb)->end_seq, th);
>         if (reason) {
>                 /* RFC793, page 37: "In all states except SYN-SENT, all reset
>                  * (RST) segments are validated by checking their SEQ-fields."

Sure, I can do that.  Do you want me to add the
tcp_receive_window(tp) == 0 check to narrow it down further?

(And a dumb question: As you are the author of that code, how do I
attribute that commit when submitting a v2?)

