Return-Path: <netdev+bounces-260136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKp7OqiQnGnRJQQAu9opvQ
	(envelope-from <netdev+bounces-260136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:38:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9317AED3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7F053006686
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4AA33291B;
	Mon, 23 Feb 2026 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnvvzwdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC993321D8
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868327; cv=pass; b=UqGQmUf32+7x/RJoP8l8K5ittajl2mlq5oNqxxAukCESf9SrJgCHfJa4J8AjCzzHUlCo1fyQL3jvRB+rrsUPzvlBhMnOvaNaasUME5h0QEa5cAHl7dSi1g8U6/Rzq3wZIzy909cs8u8DQXyh51DdhcS5z0ZH1A/QkoQk/ZYDI4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868327; c=relaxed/simple;
	bh=FXB8L6N1RShhllJFsmyh8MvpwbOyuUzjP20hAMAjN/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0P5rmpgY33Dm3GY0c+2bRnqij7lPEFfl9YJA2ZGZB0wQTdyjocQ1x3h3CzW0qBfvSsd81d56zU6Mt/wm6aplWVvFfkdZDW45McumrejMJTfxeD7gHQkJ6sYp3PmOWzoxAzIirdtt3hsjr0DKH8lchYZGQel0IdVCpQGhDskPZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnvvzwdN; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50335b926c2so42354091cf.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:38:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771868323; cv=none;
        d=google.com; s=arc-20240605;
        b=Jl3Xuy175f+d/gOiF2MBUDbO1Vq9TAx7ez/Dp6m8XeFe2ZNPBOOXHTqzX/9/esqoHd
         QYRXOnAyv6EiVUKyCEdRQJSxBrihNDs6PKV3opyXJOq9l8TtvFZn6eLRnUjIBtmH+fTA
         SsL7AsVvA1YBKxb+Jq0otfrQairMgw5pM3YelALSM+s9EkrwvXfcVxccNghLlX73EnKD
         4G+b45x1pR+5orrq/b5WkIa1gmN7gKS4WkCl44ip+L0j7fT6aJqYdq9LU5E7UlHw+tPJ
         fQByc8i0uagidWQW+wzygMYqqmlF89IElih9w5caE1343ZHvdauzJPHsX2+MIVzwl/Am
         9njA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxV8mPIjjwPE+1KEA8wKGyGIPdfmeyRv/k8v0nQQx+U=;
        fh=AZJBgsHX2CtbIH3AKfPmSaqXwYNKYGe2Y37bzoVq7rk=;
        b=eQtjkuYhi0KzlFk94zadKPLUKr8OXBAwE5VtOUbCCsKeiCqiQDiVxVu/u0NCY0i2rE
         f7Ty4FgblU01Je6s1ytiWW4pn3dIgk6+iwO2UGGrkOmnNW8mXW3lAgvn+CWaZeAVqdb9
         KGAWSRyDM5eu9SMKZkoWMOvJkHaJpCqNHyCesA1Ntjo2gHvpj4dIcdFZGavihYK/MAP3
         N2JqYWiMqvE4TWUrBA30Y5axCWg+0VcMU11h0b/QaWrLnzDW238yN1xOlEu5QPbW3Jdq
         vWf9O6e63FVm83bFesQQ/LMqb56Awcik8QrHL7aK8EV6RtiwZIxBCgNxev4zfmA/8iMg
         bfSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771868323; x=1772473123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxV8mPIjjwPE+1KEA8wKGyGIPdfmeyRv/k8v0nQQx+U=;
        b=gnvvzwdNkmSa6r7WiSAhCB9VwNjeztRKEITPu7QClwmCbjGm0YEsIMLVOikE5xHU5p
         X7fZA3TsI2BCtzKYoZtGD9CxdbpXsd/PN6rLhkYDYae0FWz0fKc72O+7syaIF/LWejcK
         4cgY8Kn2kRAfwSf2gevOnH//DdIj+2z3t1pSv2h/uwTP0tJGTbGw0FI+0bIEapYV5VX4
         TP/F69pcEQHADHXua2grLRQXj3191+kov99rejObWDfb9V3e7uriTn/mHfv9XpHRYGRx
         +92niAWfii03coDneSw4iEs0zFZRnKPdTk3Ed+2mLRHgCxWPttYS1anB8hQJoswRDH3L
         Frvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868323; x=1772473123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lxV8mPIjjwPE+1KEA8wKGyGIPdfmeyRv/k8v0nQQx+U=;
        b=lEFKQC1srXy+5LSSdtCEP9QSVugXwLte4Yk8U8bwg/ZuvQBLR3E/40Sq4/6qKm+JQw
         3piOqLtYxpO4d73sePrc1gaY/HFnT5OEEUK8z1+0KpEdwgtn/i2y7hh4vAufafRtKa8L
         x8FjWGRmAO26F+4QKWnI/JfJdnfoQpzVuSk2onPeI0H8dRgnI1ibRGx3iKKCM8KBalDO
         RtVwB+F9LDzmM4iXPlex6/D+sIGkaQOMILy5MXxEyopIMQ5qgJKwn6XpKu9wjWslu0rx
         rXa1Ljc6WPPWukxhcNKVCsoUqIP3AJkTY/OvOgbGFmmYtHkfr1qGQCHTlx0FitkWTu1z
         sWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGGSdcMVWG8jxe26r/Inng3Z2l+OK5mjJSMhb5Xb9lXOsO+SsKl9A9aEWms6h2IcPj9i3BkC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5j9iCxh679S1q0HTnzI5wFyUag9PERIhLG1uJ5kSTlCRYcqEi
	RP3IWYTxAU8DPCHPzEFyh9RlEMBnv2vm81+KayKyfvtPF1Vp22Zwd92BHuuHKiNKLoIBndfQjCC
	U8v2qcvClDwtzjA1v4pk0qDxZfDB/xr6QXIgT9JTU
X-Gm-Gg: AZuq6aKItWxItm/N1sdKbjawEYQGGHbaDQ9GemLdgwys3CZqfA1FMOrNhXTOf6SJm3R
	n7mennqN/XWlhP0Z/ktfV6GHHjdA0OZHBoTp+gZRn2so+xrn4wER9griZ9pG2aSzE+vvMhXiuqL
	OOb+50HM/rfzvNV5NmqZ3WUgOcpdkYLpgEtHWQXEw9olU6N+Q0lzpMf5lbsA2HdOjxKiwls1FCf
	WXLXdflDcnvjy+Dtso1/XiqW9eGtL7EHLvAU//QB2u55eXI/350doqJeDw31BKiptGHr0B3+or6
	45HetS0=
X-Received: by 2002:ac8:7d8e:0:b0:506:a320:e45b with SMTP id
 d75a77b69052e-5070bc6c30fmr130357461cf.39.1771868322989; Mon, 23 Feb 2026
 09:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222-fix_zero_wnd_fin-v1-0-5f4034952f3c@gmail.com>
 <20260222-fix_zero_wnd_fin-v1-1-5f4034952f3c@gmail.com> <CANn89iK5Kk2D-zMiw_2syb9OdmkKdgAA7aGfi8QNZ9XR4=CfvA@mail.gmail.com>
 <CANn89iKBjfaoWaUh6Ar2Lj-MJODywLpHzbQif=aa8q387qutZA@mail.gmail.com> <aZyLdQCaib1d4qDU@gandalf.schnuecks.de>
In-Reply-To: <aZyLdQCaib1d4qDU@gandalf.schnuecks.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Feb 2026 18:38:31 +0100
X-Gm-Features: AaiRm52lmkQo_VYru9RAU9egFIOLOWNaqq_JEsXTUaSy5ElTYgirkWmuRPCRpgc
Message-ID: <CANn89i+Em+e8Fb_QHwoRdOc6bYGNOsJqVby3jG+bO+672hDfxg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: re-enable acceptance of FIN packets when
 RWIN is 0
To: Simon Baatz <gmbnomis@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260136-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 93F9317AED3
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 6:16=E2=80=AFPM Simon Baatz <gmbnomis@gmail.com> wr=
ote:
>
> Hi Eric,
>
> On Mon, Feb 23, 2026 at 09:36:38AM +0100, Eric Dumazet wrote:
> > On Mon, Feb 23, 2026 at 9:01???AM Eric Dumazet <edumazet@google.com> wr=
ote:
> > ...
> > > >
> > > > Fixes: 9ca48d616ed7 ("tcp: do not accept packets beyond window")
> > >
> > > OK, but this commit is fine ? It seems the issue is coming from buggy=
 peers ?
>
> That "Fixes" tag is a technicality, I did not want to imply that the
> commit is broken: 9ca48d616ed7 (which is RFC compliant) turns the
> workaround (which isn't RFC compliant) 2bd99aef1b19 ("tcp:
> accept bare FIN packets under memory pressure") into dead code.
>
> If we still need that workaround, technically, this is a regression
> caused by 9ca48d616ed7.  If not, I am perfectly happy to propose a
> commit that removes the dead code.
>
> > > Eventually the receive queue would be drained by the application, the
> > > peer would retransmit
> > > this FIN, and it would be accepted.
>
> If I understand the problem correctly, the workaround was introduced
> to break a FIN/ACK loop because the broken peer (macOS) did not use
> exponential backoff in that scenario.  So yes, it would be accepted,
> but until then we and the peer would ping-pong FIN/ACKs.
>
> But as said, if we don't need the workaround I can submit a patch to
> remove it.
>
> > ...
> > > > +       reason =3D tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
> > > > +                             TCP_SKB_CB(skb)->end_seq - th->fin);
> > >
> > > I don't think this is the right fix. Basically it says that FIN do no=
t
> > > count, but TCP RFC says otherwise.
>
> We can be more specific and only allow that if we have a zero window.
> (I thought I would not hurt much to accept that FIN which does not
> take up real space)
>
> > > It also adds code in TCP fast path.
>
> Hmm, the call site for tcp_validate_incoming() in
> tcp_rcv_established() is:
>
>         /*
>          *      Standard slow path.
>          */
> validate:
>         if (!tcp_validate_incoming(sk, skb, th, 1))
>                 return;
>
>
> Am I missing something?

The 'slow path' comment does not mean everything from this can be really sl=
ow.
'slow path' is quite often used, header prediction is less and less a thing=
.

>
>
> > We can keep fast path unchanged with this variant.
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index e7b41abb82aad33d8cab4fcfa989cc4771149b41..156c92450f3ed00357aff2e=
f3e586b83f3cecb5e
> > 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -4858,15 +4858,24 @@ static enum skb_drop_reason
> > tcp_disordered_ack_check(const struct sock *sk,
> >   */
> >
> >  static enum skb_drop_reason tcp_sequence(const struct sock *sk,
> > -                                        u32 seq, u32 end_seq)
> > +                                        u32 seq, u32 end_seq,
> > +                                        const struct tcphdr *th)
> >  {
> >         const struct tcp_sock *tp =3D tcp_sk(sk);
> > +       u32 seq_limit;
> >
> >         if (before(end_seq, tp->rcv_wup))
> >                 return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
> >
> > -       if (after(end_seq, tp->rcv_nxt + tcp_receive_window(tp))) {
> > -               if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
> > +       seq_limit =3D tp->rcv_nxt + tcp_receive_window(tp);
> > +       if (unlikely(after(end_seq, seq_limit))) {
> > +               /* Some stacks are known to handle FIN incorrectly;
> > allow the FIN
> > +                * to extend beyond the window and check it in detail l=
ater.
> > +                */
> > +               if (!after(end_seq - th->fin, seq_limit))
> > +                       return SKB_NOT_DROPPED_YET;
> > +
> > +               if (after(seq, seq_limit))
> >                         return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
> >
> >                 /* Only accept this packet if receive queue is empty. *=
/
> > @@ -6379,7 +6388,8 @@ static bool tcp_validate_incoming(struct sock
> > *sk, struct sk_buff *skb,
> >
> >  step1:
> >         /* Step 1: check sequence number */
> > -       reason =3D tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
> > TCP_SKB_CB(skb)->end_seq);
> > +       reason =3D tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
> > +                             TCP_SKB_CB(skb)->end_seq, th);
> >         if (reason) {
> >                 /* RFC793, page 37: "In all states except SYN-SENT, all=
 reset
> >                  * (RST) segments are validated by checking their SEQ-f=
ields."
>
> Sure, I can do that.  Do you want me to add the
> tcp_receive_window(tp) =3D=3D 0 check to narrow it down further?

Not sure what you mean.

>
> (And a dumb question: As you are the author of that code, how do I
> attribute that commit when submitting a v2?)

No worries, this is part of the review process, I give you permission to
be the author, even if this happens to be something I wrote.

