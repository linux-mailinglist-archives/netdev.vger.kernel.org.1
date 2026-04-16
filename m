Return-Path: <netdev+bounces-279111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEdxIVIv4WkdqQAAu9opvQ
	(envelope-from <netdev+bounces-279111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87811413DDD
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F1E1300B448
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E733FE15;
	Thu, 16 Apr 2026 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDbiHQuj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E03368BB
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365337; cv=pass; b=K36uifQS3cwVg8FHN7OrqJ2GLhfwKvxB23Ehc9ogbYwnBGF0DLx3bIrSgHCcTleGcLK9+SAjctVqmOTbzXrTR74y7iccilDdgH+TES+JQRhyt1Xlk9n4H1ip3ijxyz5U+K2LuMsuXpEI+rMRNm1Q3JeXKicDNSMRm+19LzgMiGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365337; c=relaxed/simple;
	bh=slMhkCQrt5HzGz0EHc6P3oJL3SVc9/71839jqDGNEq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDeBDfv1XjhSCiK1rQy9avuVV6N1bIcoZAVU1H6VxbF2KmChSGksSc0zKWPEDvhlC5gXKz4JR+UM+eDcZdNRO6P3nb3EVGQSoGUxipG1lEPidECQW6I2YKC+qUBJrMEjUnFIHSDjSl3DtRnRKGSMVRMdwpRLu4D+Xx4h+I5owyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDbiHQuj; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso2019611a12.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776365334; cv=none;
        d=google.com; s=arc-20240605;
        b=KKNf4DlrPh3uQcPgiBgjdzztwKQ+gHELaawQrB9dhLrFIreBIO3g30pUJrQeuT/A7a
         Cr/9FuZf7zSsj/eTbIFPCgyXCJ6wF5px+mKtVnaR6iKi2MK/UNLfY1G99vHjZhCpHBk2
         LDzkzS1PCsUBTs+cqWPN1ZwSgsLZU4DFOt7wysZS6lHgDh75t70p06RsHwjPZBKAfm0Q
         l0bHna5xEEAB8uEmRyqGzz60iNHvwztC0YaM0SherJZ/qdg3D2Dz3kg0DIObzxQshZKK
         urVrYUjfVe5wGQIIBB1dpCsUkukYYty20P19XQVbuC5SP544JOwV66/u7lBCjI2P/lL2
         8ahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ujvIjY3OXX0Ws7ESTLX2O+qxZerdHAD6BRWOwGQM5IM=;
        fh=CXH1VGB1+XfhwR00QcQK9OQR+c+9qScT+34tdRFPBjE=;
        b=T4In2xJS7DMLquu0Z7dNtQ2/zs1EWKxq6PAtp79d8lpKnJaGv//OO9uDGdEYZ7w11/
         Wko9lNTxOSa9cWuf2o+o93MltEZhBsaAE12xcRRs73ATT2i1NbaSYiNofq5mz9k8+fOv
         iDBznvyRVUd861bHZDRag/lXR7+wHvoRF2EdEYpb6lzzmYZYMXfoEZpt1EtVyuaJFFyq
         0hS9Oc+qX86AVf5bBesywWSotP8AmDb/DRB00cqQ0fsTBB9rxqYCJ7VxoeyNzoWbKcwB
         LXyuRbEEfkLm9PAUsaYdSnaelwix8ngNN+XBySBzFhu/gliD3Bu5UiG7yWAauiFfuVMU
         Dh3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776365334; x=1776970134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujvIjY3OXX0Ws7ESTLX2O+qxZerdHAD6BRWOwGQM5IM=;
        b=cDbiHQujrnv+jiyBRCGCfwUWqtpl7hJQP+cN6OC5Jcwy2p3+rY6zYBRB3/AJrzklmn
         jIeiWu9Kadt8eEEaW9TMspmYDfwJylQGiCosEjNvLz7F2i+Z2TVW3ZjVsmaISg+LXzne
         uos4R/MqcXSUxLdZjiaNvyeLLK941ISCew3ZCbD53CyPeIB3znlFMXh8oZMKhYCN1QXV
         SV73lZ9CmwOOwV4VCTvSQk8rLUxR/tc4cLJd53Sfsydt2VOPxBtKhMOX0PDlL/pW2UDt
         AByH9JZWiJA2wGZz2VFcgpCOmUJCpFb+iATLrYdWrEJ/2CwefORguvjifqHGVnF8t5Pf
         rOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365334; x=1776970134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ujvIjY3OXX0Ws7ESTLX2O+qxZerdHAD6BRWOwGQM5IM=;
        b=mqqT9V2zkFTi1LBGGadSExYrjoEPpbWJxoB7hB17Lhs57oVOQXtGSrWzNP6A2gmGic
         xmVHNJE7N+FcqdfP083g7FZD4jflkMrJ0bRHvL+lQC07DcugogB17eUxbAPkLxj40WAQ
         fnV2f1Sk7Y8eUGjN2bcVQ6Y0F0t2EJ/fpvqZEMF7ElxZukQ1b6e3IJSw8dqehfhZ588x
         SpZEM8ZvdjHFxrcf6J8o/IKETQ2acxKnTwhTa8QxEc5M/yqKa492q80qgEoSAB1cDgpG
         ZqEYOOkXq4hnq3PuG5T7WXAX0LPathIxjS7A5o0mG9D2XCjM5DWjj+2Wf9o7tpF37DUX
         E/7A==
X-Forwarded-Encrypted: i=1; AFNElJ88h7i5J0Mx6FFfAxawudKDNWFyWiU+yluT6sE8br+hJYywylEfaNMqXLzA/fsAT+ReY+CmWyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3y4EIqUMa5i/+Gb4dft4fL9ENDClE91Ibka15cLRavoE2gzjo
	zx/RujFU/nXqgNP6HKBpyquDIalnfqXA0ANTNaEQmNNKnk9b5YIi+j+j5FCK3Ru79trs4pojwfD
	V+Ub7tMUxwbbeDW0JWq5kMDa+LR3LFY0CLStW16GL
X-Gm-Gg: AeBDiev7tRuSfruslwpa1UCHJbJyAcVQwrRxnKs1fYfiHBMnLrWQQWoiRHn/Pco7Cl2
	lTgyi0KZdSzxT7/nZ8+dEqLkrbNJQQ+f2kaEl153sIl7TZTfYAsDB7Kjtlt1xqQe7iW/HDspXbt
	3oD2nxfHTZUp408WRClNnaDvlLnTn0yg/Q24ZiDb9O1UaUXfFJCV+X9MFZhHXduCSwMGMC5AOU2
	1ybhzEZtxUXh86SjLwzGNUseCu6f9fLb3SA/78RBoZFwPtqxAKnso8guhMFCCyz4ZjN4+Smim6q
	NthcP70u755J7LY9j2luH0unFIQdqjKxsl6fNYp0zIIMaW8/W4dXrtzt9qlDFQL7h/pKrAG2bz2
	O8tuXfINTria09qduuKoRp84gEdKO5J0Gds3lo0APWBIQOiF2bLAeojoFpDndy+W3HToFRkE4
X-Received: by 2002:a05:6402:5418:b0:670:b68f:bf28 with SMTP id
 4fb4d7f45d1cf-672bd71082bmr158046a12.16.1776365333161; Thu, 16 Apr 2026
 11:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776149210.git.caoruide123@gmail.com> <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
 <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org>
In-Reply-To: <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 16 Apr 2026 11:48:39 -0700
X-Gm-Features: AQROBzBUGmEnoNBMsrCHFiceUIWDnxmZZMexJRFYr3C0RNOXre_AKHla49_AvxA
Message-ID: <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when cloning reqsk
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ncardwell@google.com, dsahern@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, daniel@iogearbox.net, kafai@fb.com, 
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn, caoruide123@gmail.com, enjou1224z@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fb.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sashiko.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87811413DDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 10:45=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Ren,
>
> On 15/04/2026 11:31, Ren Wei wrote:
> > From: Ruide Cao <caoruide123@gmail.com>
> >
> > TCP request migration clones pending request sockets with
> > inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
> > subflow_req->msk, but the cloned request does not take a new reference.
> >
> > Both the original and the cloned request can later drop the same msk in
> > subflow_req_destructor(), and a migrated request may keep a dangling ms=
k
> > pointer after the original owner has already been released.
> >
> > Add a request_sock clone callback and let MPTCP grab a reference for cl=
oned
> > subflow requests that carry an msk. This keeps ownership balanced acros=
s
> > both successful migrations and failed clone/insert paths without changi=
ng
> > other protocols.
>
> Thank you for this patch!
>
> Indeed, it looks like this path has not been covered by the MPTCP test
> suite so far.
>
> By chance, do you have any simpler reproducer using packetdrill? (the
> MPTCP fork)
>
>   https://github.com/multipath-tcp/packetdrill
>
> Also, I see Sashiko is pointing to a potential issue with MP_CAPABLE and
> the token, also only visible with net.ipv4.tcp_migrate_req=3D1:
>
> https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1=
776149210.git.caoruide123%40gmail.com
>
> Are you also looking at that?
>
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retrans=
mitting SYN+ACKs.")
> > Cc: stable@kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> > Tested-by: Ren Wei <enjou1224z@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >  include/net/request_sock.h      |  2 ++
> >  net/ipv4/inet_connection_sock.c |  3 +++
> >  net/mptcp/subflow.c             | 13 +++++++++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> > index 5a9c826a7092..560e464c400f 100644
> > --- a/include/net/request_sock.h
> > +++ b/include/net/request_sock.h
> > @@ -36,6 +36,8 @@ struct request_sock_ops {
> >                                     struct sk_buff *skb,
> >                                     enum sk_rst_reason reason);
> >       void            (*destructor)(struct request_sock *req);
> > +     void            (*init_clone)(const struct request_sock *req,
> > +                                   struct request_sock *new_req);
>
> @TCP/INET maintainers: are you OK with this new function pointer?
>
> Currently, MPTCP is the only user, and "req" is not used, see below.
>
> >  };
> >
> >  struct saved_syn {
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index e961936b6be7..140a9e96ad58 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(struct=
 request_sock *req,
> >       if (sk->sk_protocol =3D=3D IPPROTO_TCP && tcp_rsk(nreq)->tfo_list=
ener)
> >               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
>
> (Maybe TCP with fastopen could be this other user to call
> rcu_assign_pointer()? (net-next material))
>
> > +     if (req->rsk_ops->init_clone)
> > +             req->rsk_ops->init_clone(req, nreq);

I think a simple direct call is better.

#ifdef CONFIG_MPTCP
    if (tcp_rsk(req)->is_mptcp)
        mptcp_reqsk_clone(nreq);
#endif


> > +
> >       return nreq;
> >  }
> >
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 4ff5863aa9fd..5f4069647822 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -47,6 +47,17 @@ static void subflow_req_destructor(struct request_so=
ck *req)
> >       mptcp_token_destroy_request(req);
> >  }
> >
> > +static void subflow_req_clone(const struct request_sock *req,
> > +                           struct request_sock *new_req)
> > +{
> > +     struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_=
rsk(new_req);
> > +
> > +     (void)req;
>
>
> Note: if 'req' is not used, and MPTCP is currently the only user of this
> new init_clone() callback, perhaps enough to pass only 'new_req' for the
> moment? 'req' can be added later if other users need it, no?
>
> With only init_close(nreq) in a v2, or if TCP maintainers prefer to keep
> it, feel free to add:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

