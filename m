Return-Path: <netdev+bounces-258822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BPlL4ptkmmstwEAu9opvQ
	(envelope-from <netdev+bounces-258822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:06:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7E41408BC
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDAA63017C13
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756D283FCD;
	Mon, 16 Feb 2026 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17GawgO/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD82522A7
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203970; cv=pass; b=JW3GTS+N5TUxSDE6kjl+htv15AUD0jZ0q2oBlN9PvRSzwah6pOqRWrWpjAJSZAUL1A6xQ4ca1AkuYZDNQWdP+VlZd3gX10r1J7FGuxOmndDYYOATqUUXdGZvGWYJuRcDePqoThscvQodPdhscbMyPv9cSr7VRTg9eDZsqCaLB9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203970; c=relaxed/simple;
	bh=8o+OxVo5dswvJmFHM5vqM2X67yKJoqyjQ3xOcqIc+s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJxKGlC2qKQx1pYEz5BgOFRdBD+R/xAEI6qUvNPNO08hwaCO4e6sGSU0ik0iF8ChMU9AbASrJfTM9yR+oInDwHICr5bCvoF8B1ymsLWdZBkn+2m7rpo31G2tBW1OT0l4jas2MHs0HQ1tcUcR1kv66GpkFH/SNrkGqIFFym6ZejQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17GawgO/; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-126ea4b77adso3206101c88.1
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 17:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771203967; cv=none;
        d=google.com; s=arc-20240605;
        b=fWFmZNp6KDzEJTz992tzmuJNHPNzhGXT/nbHjHsc32BXAH4EiBD4DCu0YXJMesBPox
         YmCEiSh0IvijMOXTPm6V6on9F5Y18b81sdmwzo+RmKXS4CDPwBShFJ1jTNORohNwEnPo
         5ldYOrXRg31M5JUmeAiDALvy1Jiypqfii9PDgrysYACgjQk/iuA6PBVhoR8c+jBsRfGL
         PnyqP+/pvagoaLNXHYQFHjLL91qtPxgpVtgC29mltRhyjtEesDsJdz/3ezOl1n6OzMBY
         BZPONGPwQR2oMdjwas47PteSda0GBCJ/FeCcF2S1ed6s5z13XSqD8glthQkuXfkLfdoS
         aIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PF+PQBCSpqpBKQv+Qv1WvGtt0yqefm8/Z5K8hlHVTIA=;
        fh=/PjC4YEEPBbl2ZlWwdZNZOA2PyuP0Uo4C2rtM0x3pgM=;
        b=Yb5KRYkJXeaWfHKC12S20izjD4xDarEUb+iIbeSIgP8LM1IF9xAW1SZuOeacR/EHE+
         BfF4HVwTRO3lX2mTkclQvJEbXIfmbsD9f0xdH3n6XaW41/qcSI2scdgnEUgPmANV+Kyv
         VwwrmO2bBywgadVpLKtifCS9w20PYie4slMUIqo53GNJhVpMa4ydV/Q20U5QM19hJW6D
         wqKcwbWpAfrWVqAIDPMGNWafDhlH30xp33ckF28WqOld14E9S52L14lnWjRJGDtk/PEM
         qZGzl6neWcmzfPEnwURwGPlkgS0oKaHr706xlZz5JVPvVIdO76YDiODInC5K7IBz91k9
         3iHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771203967; x=1771808767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF+PQBCSpqpBKQv+Qv1WvGtt0yqefm8/Z5K8hlHVTIA=;
        b=17GawgO/C+Ma1AjjfYOiAuNKxfHydCl8cligxwoyRE5ThsskHch0muyvmOwJf7UtLi
         u/JPCaEFFT6nLqt1oK4+K4af36M0Wm/jLXzwYQxaqjvxolRii/RR2LIcyXqsxUKK+Rgw
         MjcUvOzaNYDbcxEj3eMA8tl1eah6vhnzYkK9uMEmRA+kDaY1gQALFcfNZTH2oY2aIprf
         7atBJDrEuGu2iy9OTCmUbq/QfzsylbPG7wz+PJ2xb8o38yDzGQ8OV+//UeeFu21U8wbD
         Vy+I5PKYOfLcFqHMsk7N7bqYtcwYupJB/RjUmSb+UG+7UgOC8EPfII2ookdgy5Wcp8Fw
         aZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203967; x=1771808767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PF+PQBCSpqpBKQv+Qv1WvGtt0yqefm8/Z5K8hlHVTIA=;
        b=nPFb9C/Z56uOqi0sq8+Z7+LTZ//rOCZia5aojdUz0LY9LMKwzsQeiTXDxrWcACQNYA
         tntKS3/PE+jcGd3seXiHkbYv5DhksBfwMek5ohvLQ12HnViwxMtOj/EdcEY/gMbluq/b
         AEBVZ+pHD2ePfOFIukYz7Fun6XIIM/9tvnJPbutsvBbRMqhkRCoZhJNbaixfv58TXrBQ
         ctcAq5q3KYULYNOpoUiVN1MlpocHP03AXZvYQJ/CtwjgPxzkO0pDtVLGY/P5brfDaoJx
         zyQR3HkSTlLO7ndAsJaonTZohgdJA/qiEpZXs4N18/OgxRApXq3lNNjYm8cWElvDWoeW
         DZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoQwj+9N+75h3qF+6MAd81YbB1MqjFG3GMPQSE/VMNesfvibs2mwuB0pQwWuw/B4MdfcvIako=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6Cajt6JvmFz8K7gB5alcpwurWiE4SGPOM5qYTLPRYqZFvxLf
	TlG3e/DNo4n3LNM/BLEZt4HIRrYNhGuw8kdsSirMiXdlVoPzj2AhOY81YlSsUOwBr1pnZLynObj
	GE7euAjbsiC4pvwGuEijj0ienkUq1qEyco+NKackR
X-Gm-Gg: AZuq6aKLbi2PTL/2G5vHTBqon1Vykf8tLNbv4VUyK0gX4Qa9cUcIj/2DqraEtT10nwC
	U+Y5gdeKaU/QKqy+uJPpG61DNXMNf3S8oiM5c/sB9tqKKS6uof/3Dwkjft51VSSv2T7KfnHMyWP
	k1sZwwpV2IwwPwafnIwd3AUo9XJ7s7D+SoKg0q/v08cA3Z9VwEw3eo++oFLB83nJ+y0yLFV1QDm
	Phdd18twz6kyLXseUUVI/bq2oBzrfuXZuWBWQIDbUOIONnpGsGfFptWQ+JH0QrR7bxpUOZkTj/N
	/cgOH1wVGQHMMJ0iT27lHohta9B7PqZZ3ZDKXSdaEaeqZUSsDLffde2sVnkj+9guhfqw/Q==
X-Received: by 2002:a05:7022:608d:b0:122:1d4:28ff with SMTP id
 a92af1059eb24-127398196bcmr4548255c88.26.1771203966870; Sun, 15 Feb 2026
 17:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215204353.3645744-6-kuniyu@google.com> <0e28e4c337ddd569844020f2a999c7becc918fa9cfe2a0e0fa21ca363d3bb1f7@mail.kernel.org>
In-Reply-To: <0e28e4c337ddd569844020f2a999c7becc918fa9cfe2a0e0fa21ca363d3bb1f7@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 17:05:55 -0800
X-Gm-Features: AaiRm51D4W0-N7UOB1gIhuJx8dW0FG-7VHlWZksdnWF-OKNUYwEjIo_LcTMBs7w
Message-ID: <CAAVpQUCvSh8=297-3Qxo-TvsOrMh9vQ9o8eO_Q4OQHKpxqxNTA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf/net 5/6] sockmap: Consolidate sk_psock_skb_ingress_self().
To: bot+bpf-ci@kernel.org
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, 
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com, kuni1840@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258822-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,bytedance.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C7E41408BC
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 1:50=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
>
> [ ... ]
>
> > static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff =
*skb,
> >-                              u32 off, u32 len, gfp_t gfp_flags)
> >+                              u32 off, u32 len, gfp_t gfp_flags, bool t=
ake_ref)
> > {
> >       struct sock *sk =3D psock->sk;
> >       struct sk_msg *msg;
> >       int err =3D -EAGAIN;
> >
> >       msg =3D alloc_sk_msg(gfp_flags);
> >       if (!msg)
> >               goto out;
>
> [ ... ]
>
> >       skb_set_owner_r(skb, sk);
> >-      err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, true);
> >+      err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, take_ref);
>
> [ ... ]
>
> >-/* Puts an skb on the ingress queue of the socket already assigned to t=
he
> >- * skb. In this case we do not need to check memory limits or skb_set_o=
wner_r
> >- * because the skb is already accounted for here.
> >- */
> >-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_=
buff *skb,
> >-                                   u32 off, u32 len, bool take_ref)
> >-{
> >-      struct sk_msg *msg =3D alloc_sk_msg(GFP_ATOMIC);
> >-      struct sock *sk =3D psock->sk;
> >-      int err;
> >-
> >-      if (unlikely(!msg))
> >-              return -EAGAIN;
> >-      skb_set_owner_r(skb, sk);
> >-
> >-      /* This is used in tcp_bpf_recvmsg_parser() to determine whether =
the
> >-       * data originates from the socket's own protocol stack. No need =
to
> >-       * refcount sk because msg's lifetime is bound to sk via the ingr=
ess_msg.
> >-       */
> >-      msg->sk =3D sk;
>
> The consolidated sk_psock_skb_ingress() does not carry forward this
> msg->sk =3D sk assignment.

Oh right, I accidentally removed it while rebasing patches
from net to bpf.

I'll restore the part in sk_psock_skb_ingress().


> alloc_sk_msg() uses kzalloc, so msg->sk
> will be NULL for self-ingress messages.
>
> In __sk_msg_recvmsg(), the from_self flag is set based on msg->sk:
>
>     from_self =3D msg_rx->sk =3D=3D sk;
>
> This controls copied_from_self accumulation, which
> tcp_bpf_recvmsg_parser() uses to advance tcp->copied_seq:
>
>     seq +=3D copied_from_self;
>     ...
>     WRITE_ONCE(tcp->copied_seq, seq);
>
> With msg->sk now always NULL, copied_from_self will always be zero
> for TCP sockets using a BPF verdict program that returns SK_PASS.
> tcp->copied_seq won't advance, which would affect TCP receive window
> advertisement.
>
> Should this assignment be preserved in the consolidated function
> when skb->sk =3D=3D sk?
>
> >-      err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, take_ref);
> >-      if (err < 0)
> >-              kfree(msg);
> >-      return err;
> >-}
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/220428=
99757
>
> AI-authorship-score: low
> AI-authorship-explanation: Commit is part of a coherent series from a kno=
wn kernel maintainer addressing specific syzbot bugs, with typical kernel c=
ommit style and mechanical refactoring consistent with human development wo=
rkflow.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: Dropped msg->sk assignment breaks TCP copied_=
seq tracking for sockmap verdict SK_PASS path, affecting TCP receive window=
 advertisement and potentially stalling connections under sustained traffic=
.

