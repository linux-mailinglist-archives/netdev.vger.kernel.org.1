Return-Path: <netdev+bounces-259940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBrxIcURnGna/QMAu9opvQ
	(envelope-from <netdev+bounces-259940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:37:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBBE1731D9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 601783003328
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA7D34D4CA;
	Mon, 23 Feb 2026 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUWw064S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5434D3AD
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835811; cv=pass; b=ENeCA8xYp1YJaarvOxmPxsAEm6kCGHntKl4h0pqvisC0wby9FNpksL/15vSW6UiL9bjQpCi130NbS+8Uw4h9xKfN3kt7gjeRQFqeIq9LFer3Mm7AS/0ymFwe0gKzGomUdjPxBUpJjiro9A1ub7bGPa8umfXavaFk8InWIUZp5Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835811; c=relaxed/simple;
	bh=hrmgggKQvVe10yK6nfrEeI2XixGYRKAk61xhi7TNXM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBnlGJORjdhV6etvaibdwabjz/+IoaYwNAkeFucBZl2b9VcW+NbVa1bwvkkHoF2m6DmGDW/9mRW3aNsf/jMgFU1yapmkrqQGDJ/2MSWFeKHOhzEdIMiXy362GVKV6b0A904/VPfY0KIENkSM+RhpTh60fHfJkw9ZHvGLPpbzrrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUWw064S; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5069b3e0c66so66769781cf.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 00:36:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771835809; cv=none;
        d=google.com; s=arc-20240605;
        b=Vo1PT6q+GLcZBEkTe+s1XrMGKs5oYtVDlGVYmZdE/l15jcCz+Ib9h+T9P7B9Yqn4Ng
         T21o638VGpptz05NZ+ulNYAKsc/g7ffECd4m9FI39VBpTaadYgNs1G2fTLbqt1UXBkWq
         FQ1tZh0BHkHNqevGTtcGLkUz0eqQeM52JL+igabCZTIJhZLkOWQqKpdtOmK7o8rJaHj6
         Mzh+ZrH30YmXEdKVakAPuPSM2pjpOJIjoanjBFMke+iJ5swV/p5votKKKya4EfM8zDzv
         JNJi91oP97ZlXIsQ1WKwGHAArFr4oHZyH/4PnZ5zooXoly6YntZPapdwzI4sNOlL/NJG
         GHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vbp+UDntQVNzIlEDtZVze6X5jmwY5uUsgN9+rGm4rXU=;
        fh=89Se4WlPbPJCggUyLAtAeroLquvRKTVXG0e6WIkA8Dc=;
        b=W9Re5zZBOvyVWSf8xKI5nij8B+itos6tgAUpWNgmOrKqYncItZiszQpQY2OOTv8uNn
         NGO70/zyaRwQgbPSOeeJhDQKS1y1bqtbfswMjPidPO3J1qW42zv0uwsQKV6WxEOdD+Oj
         /gozsiFhkxoHzCLQvYMRelL+1/LbQsn54Pdxdj96z0YjuE+fOp9INR3nhMKP5CwO7S7H
         oQhM5sb4rgDvdPX5Rg2elQLEw2qPBFx7SkTi6tkCAFMVQ+PRN+lnmYdvlKds7neKT24K
         aqaiqsB6IzqfKFg7rYIlSmhnfAiYVFinWWdiilGWGLyUWDrLJDIu/1HJNlmoCOdvOtDo
         WwAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771835809; x=1772440609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbp+UDntQVNzIlEDtZVze6X5jmwY5uUsgN9+rGm4rXU=;
        b=bUWw064SHrG7nbChQShN+R6EomHLPmZyF3tQ+fV/EC1Tqs90cwoPCI5ZNSKL76mPz6
         qndetkho5GQCm0poMmXTHIvjyTjpm6Af7cysbqbcxDOOARdnwapEMP5ywrZh9BKLNuWc
         KZraTRVZ07JvyEMkLHm/pVFEwRqiRpcXkYwToZWIUN67bRuwLFo+OxYplVV6H1hYnH+k
         iHdAxm9Jp5j0GrKXVqXzkzQHLLJAo3vC9Nlq7xMGUwsvCwT+oxqBi+mzmL6TXLa4o3/g
         zbgkyeA1vhAjCtiWYrcg1pnVjOHOyTQWQFUtTKGrysdWD6M/K5SMK/YPHGUtAX+gwdeL
         55Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771835809; x=1772440609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vbp+UDntQVNzIlEDtZVze6X5jmwY5uUsgN9+rGm4rXU=;
        b=qpzHNuhfoeshcAlqWkC60IX3Ps3ewhqpG3C7bNZ5h1bFHSbprQPt7f7/IdTntiiWbs
         KHURfaT4YNfHK8Ikp+FoBV17p8tAWv5TbNGrWPWQYcpw2aaHyJdpHgmNaWL4WwwV1bxk
         UohEcWcUcGdLVAo9h17ksrH1+OuM2J6keUgk4jmAyEgtC+JQY5rJV1gYqVKZFzFO/R9V
         m6gRdHwcov1hJGchVVF8JJVDL/Qsj8njt03V+aG0mc2fKITmUAMGB2+UR8qhFcJDSKOv
         Kuhk1GKTnsVBKp0OuH3bUSdfOek3xPOH18CpIsaMQ9ldzpLE1f0jhZlusv203k1UbxIM
         wkvA==
X-Forwarded-Encrypted: i=1; AJvYcCXU0Jzhz7Uy/BLKVN1SvR2EAwaAfZN5RBlXJs+NqoBSGnyr5IMNJiTeevX8skMDR852pdlOo0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSaCffHkPlOesTEDNkM7JXPG6gyGbVSLzUK+311HROEqdNrS+
	NoaV7qbsr21/3xe6BU584rzdO1TU6Zs6VfmHcrMrE5YAHs+E26gEtmUdOQRiRrkBjFbph0psXQ4
	HdqNvMw0SSyXDZBOa1u/qHWe4TIR9VfCCtFqNdLdW
X-Gm-Gg: AZuq6aLYv0K/oN9OTwMjRsDjUwTXtk6JEEe1b/z6C/7a64M7jDi5S4nuWboKSp2aZN9
	OiKIY64Iw4UlCJVhfH8BAFg4n8DgtgeHAvk4+XOZ7kqeCO+FCRQ0pjr0aJ4WH+10c3/LVxJOcy+
	32hiCan/CGKZMAr3gXkWKnbXf9ZC/fM1fYq8qVhRjRU0tnZCYd9A2+J9rvdfec/b8d0NU9Unw3j
	f/9PIDZGDgmoURg4TdgfgH5N9554UcHe4GhA9wtc8xdc/GCcNLsYqWjms92XTvFRV7Ps4l7wR42
	fOKFez8=
X-Received: by 2002:ac8:7dd0:0:b0:4ee:13dc:1040 with SMTP id
 d75a77b69052e-5070bf3b959mr102637101cf.3.1771835809065; Mon, 23 Feb 2026
 00:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222-fix_zero_wnd_fin-v1-0-5f4034952f3c@gmail.com>
 <20260222-fix_zero_wnd_fin-v1-1-5f4034952f3c@gmail.com> <CANn89iK5Kk2D-zMiw_2syb9OdmkKdgAA7aGfi8QNZ9XR4=CfvA@mail.gmail.com>
In-Reply-To: <CANn89iK5Kk2D-zMiw_2syb9OdmkKdgAA7aGfi8QNZ9XR4=CfvA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Feb 2026 09:36:38 +0100
X-Gm-Features: AaiRm52Hy4mj7KY80-wpFNvA2-ANxwYSkjGXPviKg5SUI27iW8AraDDM3-yinIY
Message-ID: <CANn89iKBjfaoWaUh6Ar2Lj-MJODywLpHzbQif=aa8q387qutZA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: re-enable acceptance of FIN packets when
 RWIN is 0
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259940-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFBBE1731D9
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 9:01=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sun, Feb 22, 2026 at 1:35=E2=80=AFPM Simon Baatz via B4 Relay
> <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> >
> > From: Simon Baatz <gmbnomis@gmail.com>
> >
> > Commit 2bd99aef1b19 ("tcp: accept bare FIN packets under memory
> > pressure") allowed accepting FIN packets in tcp_data_queue() even when
> > the receive window was closed, to prevent ACK/FIN loops with broken
> > clients.
> >
> > Such a FIN packet is in sequence, but because the FIN consumes a
> > sequence number, it extends beyond the window. Before commit
> > 9ca48d616ed7 ("tcp: do not accept packets beyond window"),
> > tcp_sequence() only required the seq to be within the window. After
> > that change, the entire packet (including the FIN) must fit within the
> > window. As a result, such FIN packets are now dropped and the handling
> > path is no longer reached.
> >
> > Be more lenient by not counting the sequence number consumed by the
> > FIN when calling tcp_sequence(), restoring the previous behavior for
> > cases where only the FIN extends beyond the window.
> >
> > Fixes: 9ca48d616ed7 ("tcp: do not accept packets beyond window")
>
> OK, but this commit is fine ? It seems the issue is coming from buggy pee=
rs ?
>
> Eventually the receive queue would be drained by the application, the
> peer would retransmit
> this FIN, and it would be accepted.
>
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > ---
> >  net/ipv4/tcp_input.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index e7b41abb82aad33d8cab4fcfa989cc4771149b41..fde612f12d3625000081958=
d13cec8779684a642 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -6379,7 +6379,12 @@ static bool tcp_validate_incoming(struct sock *s=
k, struct sk_buff *skb,
> >
> >  step1:
> >         /* Step 1: check sequence number */
> > -       reason =3D tcp_sequence(sk, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(sk=
b)->end_seq);
> > +
> > +       /* Some stacks are known to handle FIN incorrectly; allow the F=
IN
> > +        * to extend beyond the window and check it in detail later.
> > +        */
> > +       reason =3D tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
> > +                             TCP_SKB_CB(skb)->end_seq - th->fin);
>
> I don't think this is the right fix. Basically it says that FIN do not
> count, but TCP RFC says otherwise.
>
> It also adds code in TCP fast path.

We can keep fast path unchanged with this variant.

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e7b41abb82aad33d8cab4fcfa989cc4771149b41..156c92450f3ed00357aff2ef3e5=
86b83f3cecb5e
100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4858,15 +4858,24 @@ static enum skb_drop_reason
tcp_disordered_ack_check(const struct sock *sk,
  */

 static enum skb_drop_reason tcp_sequence(const struct sock *sk,
-                                        u32 seq, u32 end_seq)
+                                        u32 seq, u32 end_seq,
+                                        const struct tcphdr *th)
 {
        const struct tcp_sock *tp =3D tcp_sk(sk);
+       u32 seq_limit;

        if (before(end_seq, tp->rcv_wup))
                return SKB_DROP_REASON_TCP_OLD_SEQUENCE;

-       if (after(end_seq, tp->rcv_nxt + tcp_receive_window(tp))) {
-               if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
+       seq_limit =3D tp->rcv_nxt + tcp_receive_window(tp);
+       if (unlikely(after(end_seq, seq_limit))) {
+               /* Some stacks are known to handle FIN incorrectly;
allow the FIN
+                * to extend beyond the window and check it in detail later=
.
+                */
+               if (!after(end_seq - th->fin, seq_limit))
+                       return SKB_NOT_DROPPED_YET;
+
+               if (after(seq, seq_limit))
                        return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;

                /* Only accept this packet if receive queue is empty. */
@@ -6379,7 +6388,8 @@ static bool tcp_validate_incoming(struct sock
*sk, struct sk_buff *skb,

 step1:
        /* Step 1: check sequence number */
-       reason =3D tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
TCP_SKB_CB(skb)->end_seq);
+       reason =3D tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
+                             TCP_SKB_CB(skb)->end_seq, th);
        if (reason) {
                /* RFC793, page 37: "In all states except SYN-SENT, all res=
et
                 * (RST) segments are validated by checking their SEQ-field=
s."

