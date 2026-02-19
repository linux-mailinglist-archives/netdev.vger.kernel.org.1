Return-Path: <netdev+bounces-259563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDi2AKNWl2lPxAIAu9opvQ
	(envelope-from <netdev+bounces-259563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:29:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14700161AF4
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B5330086F0
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D4E2D876F;
	Thu, 19 Feb 2026 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYHfI8Xc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6E1CEADB
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525792; cv=pass; b=mQmkTwW63XGNmatA2rVZkPYAFpJ/RnKGx3xD9g6kaQAEYB6M9q3xHNHQOehdUbXRv5UcgpMGjfz1EWolwESHd+ZCBuAdxcfa3mD7J5T5S2CIHp//4mPydYsqCgoMRkLrSsyfpj+nuCyZPxR6DjvmQAVACvMlTr+fssAU8yTmgLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525792; c=relaxed/simple;
	bh=sK3dATEtRYJyU9O0GvBO2UZs/ma4Y5ooKNy6Ml5uPSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt/MZTO48q7ygyYTr5iCHXs21CLToWTyn5MCgWhJ+3lr/0vmt7fTKc7h8HERTGkWBiqxcE2HY9K52YbaqnmIvrg5nZ5v4wpG9zEUO8euW42KHvoUypPRJCDpCwJi313mIziUYtIXUWmpWkWfgHufaE3ZDzxXiHo7LriHGnOIz9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYHfI8Xc; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9694so371988c88.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:29:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771525790; cv=none;
        d=google.com; s=arc-20240605;
        b=AZ1PlV7yhn25ZCq6T79dNg+P8EeEmQtLWJMg/h4TuP259qtB7vXQrd53O1Qhl/mKyg
         JEdQ3sVm8LhjtCzoDgR7LQyOAuR0NuY5HOvnGB+pYPwJVLrJrS01yKm7EBrLYYXEf7fF
         PPlP59/E50mwp6ezVvDBAnCLhXBVvcaq4jsMg/hnDFBFOCAnXzKRuOf9/+86zH7aadVY
         TPVAGLfa4CK4PLEcQXoBNjWCB+Yf2X7g5aE9p56l94nvlCnIni8vP9jiaTdyCd95VswL
         LFBsq8BrNnuJhh6zcw307ZBPObS4IHKI8Ohmfzf4/4JALIEeLiydDxIuR6f3IbJs5MmG
         AVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmQQqYT/CltjIjkNPl9I+pPorzYiaHn8DkgthxVsmOo=;
        fh=npN6tw7jTThGaSKLQ5MMbaJlIy2ypxjGiNGJqfzn814=;
        b=CcoUAbz9Z5yT6JxYgyceTZCtmmsddYMemeDbmktdHgF78K9RSIIYSRuaD+Bf+bdjyQ
         IqsuEDXsVS/rY3BIgrHNUFA7Bjzz7dUGA7Yb4LZ9jKQi01GntCYdLQHTFBDOYfPzDj9s
         Tsimr0vorD2E82l8W+ulh9h0jvSiHeevQcZkCs/NftqpU+tcHzrzCyKod/yB6InsWnIP
         2GVFGoUkv1/tGN1crehviMoPdXEONSV7SAbbrgadNyyaaggaXJD9OFpnTm6rxbdTzROu
         gfdzMBMmgwJAn6PCfbfgY7cngc/Y8y0cwVWreutGGMtwks/zwvhDSQSfTAxxgG1W4JRV
         xVtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771525790; x=1772130590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmQQqYT/CltjIjkNPl9I+pPorzYiaHn8DkgthxVsmOo=;
        b=hYHfI8XcG57vIo0gB3FT5Q216wtoEM/WO3NeMF1AjawvfOGCq+aUl0/WwdYSw3+U/M
         iR6U1MEPJ3B9X3k70MGyMyQit8BLQPtj8rTPCOrkqfk/7VYhULfNoLfjdoxxKxSkGluk
         6Nhakm5U4LCht+R69eV///fAayuN8gGZoVNlNsgzHlJjANV1YK7t3DPtfXsMoMiBqVtB
         +UH514VWE2ELygMz6nk3xNzESjYumRhb/Q2L+vVSMTJ2nlvJqtY5nOEbAVqodI2rdzXy
         10dtKWTrBQTkW6VQnYkG490Faq4MK9/P7bNti/IHzI/LKyhPEnNBMCDelsJUyTKVU88w
         MIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771525790; x=1772130590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmQQqYT/CltjIjkNPl9I+pPorzYiaHn8DkgthxVsmOo=;
        b=ZaN7NYrbbLiuSEm/iWCPD1AURJrAUvFVW8iXUP5zYnNsZpxbtY/yvQ6RiL/LJjt7oE
         uWuK0npIW4FGIvJjgstumgNfVfBMleVIV9SkJP5w6LsypK1f9mvpVkGlJu0EWl2CI2l8
         H9dtVgYpAa7KYzXUCdvNC65gyhXCqVlzP3K0D7FGpXWqCGB2uuBtdMbqVsvySxd+WDl6
         fBvbQmsVG5KeHHsg6zwasoq3ucfWNKMiF48AooIyovZwBYswOSr1JDuIGSqdjxntEhUa
         bdlOCWSX/87eUwL7Kv8P3n0GFLiH7GoPafz0FrGE/ufdLET7EEVjX4SE+V/cuqMYvBoB
         kX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXO7jIyValH/zkWT+Y/ZwDbxw63NLWrF4GVmf7v3SMdC+WxOwOXxiVf+nK0yiSwQmB02+3RiIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7sUPTI11mQePbbCMs6yYisnaUwDFwa3jlxgOfj5BIFOMEf+T7
	qEQ0eavVZ5+D957F1qVgt+ESDorUt3X+solc/HNXiiubpDkD7zLXbxIs16lxNZxyYTsDLE9+Q3y
	UqFFb2qvAznjdwSge27aop0x40ymlbWRP5uoMSodv
X-Gm-Gg: AZuq6aIKhCip3B3WE/JJWFnCF+rKmn483Ye7zUkzplDesYL0//v3cUeTa5+BF+JMbUi
	qoZe12pGoxQfhTpgARNof4nLbz7qYh7LX6BqdJAmw1oPBf90lGAzIDPdUqJs4Ob5ixAzLOcgxG5
	m1+lB5T7Z/lxIE30pWlprh+uf3gtkqg3A1sUHhUGzIr/VT45IpSehZCI1gCN9uZLTBcS4MxcDpg
	rmMf9YfSAVLmsAveSDFVCaCEjr40HD5g0aMJAzqJqFnZfB0dc9gXLVsuw6zK2hmLAGZemmxLFhO
	ENKeebENpFuOUqYl4jBuk9veG1HH4kzfNDLbH3slyRqHlstlmG3OpHIPaRaisWeLYwBIzONm
X-Received: by 2002:a05:7022:4584:b0:11b:9386:8262 with SMTP id
 a92af1059eb24-1273ae8d7dbmr8589275c88.47.1771525789334; Thu, 19 Feb 2026
 10:29:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219173756.315077-7-kuniyu@google.com> <b8d59a7285647804e2c8484dc8cb118abf0ecd69657edab42393389088e349c5@mail.kernel.org>
In-Reply-To: <b8d59a7285647804e2c8484dc8cb118abf0ecd69657edab42393389088e349c5@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 19 Feb 2026 10:29:37 -0800
X-Gm-Features: AaiRm51l5uXrAtzog4Z0HbOXUmQRvcMtG17AuUmBL8-1sZuW6YVF6_oOduK8z6E
Message-ID: <CAAVpQUDHx1PYUvDeO+AdUWBBfQ8LBNqF9VpX2_Y2_2qpa+-cXw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: bot+bpf-ci@kernel.org
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, 
	willemdebruijn.kernel@gmail.com, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259563-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,vger.kernel.org,syzkaller.appspotmail.com,kernel.org,iogearbox.net,linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci,5b3b7e51dda1be027b7a];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 14700161AF4
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:11=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
>
> [ ... ]
>
> > @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *ps=
ock, struct sk_buff *skb,
> >                               u32 off, u32 len, gfp_t gfp_flags, bool t=
ake_ref)
> >  {
> >       struct sock *sk =3D psock->sk;
> > +     bool is_udp =3D sk_is_udp(sk);
> >       struct sk_msg *msg;
> >       int err =3D -EAGAIN;
> >
> > @@ -583,12 +585,15 @@ static int sk_psock_skb_ingress(struct sk_psock *=
psock, struct sk_buff *skb,
> >       if (!msg)
> >               goto out;
> >
> > -     if (skb->sk !=3D sk) {
> > +     if (is_udp)
> > +             spin_lock_bh(&sk->sk_receive_queue.lock);
> > +
> > +     if (skb->sk !=3D sk || is_udp) {
> >               if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > -                     goto free;
> > +                     goto unlock;
> >
> >               if (!sk_rmem_schedule(sk, skb, skb->truesize))
> > -                     goto free;
> > +                     goto unlock;
> >       }
>
> [ ... ]
>
> >       skb_set_owner_r(skb, sk);
>                         ^^^
>
> If sk_psock_skb_ingress_enqueue() fails after this point (for
> example, skb_to_sgvec() fails and skb_linearize() also fails under
> GFP_ATOMIC memory pressure), the error path frees msg and returns
> -EAGAIN, but the skb is kept with skb->destructor set to
> udp_sock_rfree.
>
> The caller sk_psock_verdict_apply() then queues this skb onto
> psock->ingress_skb for retry via sk_psock_backlog().
>
> On retry, sk_psock_handle_skb() calls sk_psock_skb_ingress()
> again. The function acquires sk->sk_receive_queue.lock, then calls
> skb_set_owner_r() which calls skb_orphan(). skb_orphan() invokes
> the current skb->destructor, which is now udp_sock_rfree():
>
>   sk_psock_skb_ingress()
>     spin_lock_bh(&sk->sk_receive_queue.lock)   <-- held
>     skb_set_owner_r(skb, sk)
>       skb_orphan(skb)
>         skb->destructor(skb)           [=3D udp_sock_rfree]
>           spin_lock_bh(&sk->sk_receive_queue.lock)  <-- deadlock
>
> Could this self-deadlock on the receive queue lock?

Oh exactly...
Will short-circuit to sk_psock_skb_ingress_enqueue()
in that case.


>
> > +     if (is_udp) {
> > +             skb->destructor =3D udp_sock_rfree;
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +     }
> > +
> >       err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, take_ref);
> >       if (err < 0)
> >               goto free;
> >  out:
> >       return err;
> > +
> > +unlock:
> > +     if (is_udp)
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> >  free:
> >       kfree(msg);
> >       goto out;
>
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
>
> [ ... ]
>
> > +void udp_sock_rfree(struct sk_buff *skb)
> > +{
> > +     struct sock *sk =3D skb->sk;
> > +
> > +     spin_lock_bh(&sk->sk_receive_queue.lock);
> > +     sock_rfree(skb);
> > +     spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +}
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/221933=
27667
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit demonstrates deep understanding of =
UDP memory accounting internals and references a specific syzbot report, co=
nsistent with an experienced kernel networking developer.
> issues-found: 1
> issue-severity-score: high
> issue-severity-explanation: Self-deadlock on sk->sk_receive_queue.lock wh=
en sk_psock_skb_ingress is retried after enqueue failure for UDP, causing a=
 system hang.

