Return-Path: <netdev+bounces-301404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EncSC3yvOmoiDwgAu9opvQ
	(envelope-from <netdev+bounces-301404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:08:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 190946B891C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=S6uZlRhC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301404-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301404-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D510D301022F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAEE30CDBC;
	Tue, 23 Jun 2026 16:08:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0D3043B2
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 16:08:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230900; cv=pass; b=AeFTnvqpXgosvpSh+gW6aI7QYEBkWKSJbnTPSINrdxYPaF6OUG0wEd1O8x0osWIAlfSCsJign1frnj1nlf3HX2KClc1+FdtLy0oPzUBzgI0k4ILJaMxPcS4X8KuGgK5ZJwR8WXUb2dqEQFHydCzHXvCio7b+Vd2eI1NFuePdOyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230900; c=relaxed/simple;
	bh=efDqvwMKjO5LEpENsH6RsfoLlos+OcUFj5FOVKihLxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzeNpdsCE2cWrrdb64aGPGg6eXDPJKzlBJfxzTKrDvziE/gtJvHQhINxvvK+t7rRXgZbVMiEBYVkyh97FUGsdUGID4Jxc/x0cvgcGuVD7IG2Cip+poUQL6sZDm2e9EfYtkpMMRyZOTp/z5f20IcykSvFW//Zo4VnZYk9mA1r2iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6uZlRhC; arc=pass smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-139986373b8so22906c88.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782230898; cv=none;
        d=google.com; s=arc-20240605;
        b=N3O9JwfDTCuLnfuwLrkvC6OeZIuW8ljd/mEkQXo386XdISdVFGI5QYXgKSkzVEHHtr
         7LAxOypVFOVda6Ard/jo85k9yFtVQoa0YagopzRolUwQBwf2XlMGmMEI8lxU4HAoUdfh
         ImwWeu3g/Tzs9vhz62z6Ax8ydhCsp2Ph35vQlYoM4NvOWz5SXUwyAWpjQYlu96odPjVX
         7e705LtcFAeetgK7Kz9CvcxpoF5SFwO4C5OQkgQ5zexhg2Hr9dVOzjeG2bsGW/2kNp+d
         OClMDBbxPA5an5jc7MFaCmJo/Wu3JckYxxanKEFWuTdjK6Vg4xVkEBUwg36qzcr1vI/i
         Jl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QDEmqsxEFgmNDu79H8L8WmTiCEfrH+mtXrKKg7q/FzY=;
        fh=mYhhOPeqoiLijrY9ACbrO0Jh0wa2G21PHYarH15EJ2U=;
        b=iLmEua2VRP9U0NrX1aygQNxY/UU74UPfcMhw5KK/5OmnAJ2Cq5bl5wLMx2d+Q0X4Q2
         FACG2jO8T74UP41gxW3urYz5hVfUHqZQp9iFZjwPOM4thZp6gR9grXmM+ViaDxlwnReb
         2Q2y+IUGNvH3T7PS4w/Yq4NSfCrap1h6UQgwUQdxBolkwwRRF25dvbV6vvuEjF9TXpEX
         mDiaHXKJZB/A4gqvoSDV5KOHHJrpVF90ZzrbPR/z+OfrHLbAlyrjOcEY2fxLuK5XdNtl
         HkG/vThEf7ml95NlWuI+h//wyfBGvtYwaSdKh43qiDHh+Yfji8bhIo0BfiuhwMqXaAe/
         akdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782230898; x=1782835698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDEmqsxEFgmNDu79H8L8WmTiCEfrH+mtXrKKg7q/FzY=;
        b=S6uZlRhC91gyDu5/r6RLRvDFOdU0lWsEckTBDa2Q2gtCsxUolI8yMXdRUttF5kTHdC
         SLJmoNhBuhGVxoPM0bNmzACH0r7gcE4MynEExyaxGTVViaoXr3MIZ6yDgcpArTZyIpOm
         rD/JfRYz4l+0c53G2fKTliv4dotDajyqavEPm6OidvI7+jtBBdKMPQZU9zqWtcsklBhH
         Dik0wNX7/BaXR7ZDvSbs+Lv9VnutEWzXP5KlNt2bKbrA4MAkwPeASNOc+Uxt4RIULLTh
         c6qDjwR9YgxEM7JK3nxu5H78FKRYwcX6k0TFA6CDfEv9Mbap/Kl52coiQT/A7kt7PqKd
         f/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230898; x=1782835698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDEmqsxEFgmNDu79H8L8WmTiCEfrH+mtXrKKg7q/FzY=;
        b=fWB3VD9sTzdv0E3BBMGW7IPV6L5XAX8eiUoJaDGiiEJvaIulDeRuMg5WSx6IkRq2FO
         uKYGg/PcsPll54uWoSPVT4B/6276d31vr+/5YHPVCdGdQSAM+e2gUMCb68EyyxqVXRxx
         3ADQmLHlt75AAo0gyWA5/AfjzcxlhvF+On9ni/oYW1PAUO/YTHuNE+OSnF98qatfzPjA
         D8NQ7g7BwjStIC5JfUG0q/aTmmRbLW+6UWKaHLsZIK25umOsw9Ol+LInqEvPk8qMbBFz
         7yXFn/6m+gUgRFr6id5wuJzuk4z9R6nzEFv2itJVh/ktOnoq4yk3zHLE06ENuMFMfdWs
         ZVzA==
X-Forwarded-Encrypted: i=1; AFNElJ8trICZg7S0Vgr5Annbx7rt0qZuno8Tz2B+6/qZekMnoOeXLLrvgcMeqovlVLVepJNak1x9M2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Pi4cpDEUkQ+iRIZPDw5CllK6DHAxXLKTDO+csXruiMjU29cI
	GXA4nR60zp+/MY4CcY8DBfSn7UPN/QfU1PqMXjUTEorCCh8784gQn04WLqmJ0e+4btigHLGf3E9
	pY0BJfERYjwI1o4rzT/X+JUDfYBYeWyxDGVSNy2wQ653hPSCZlIZY3AMknWk=
X-Gm-Gg: AfdE7clBgD1nuhcnH8KWbS7uylouLxrhuaJzoKAFPPbSHEUG8dxG/z+/wAI+NB17vDA
	Jce+oSzvbZdzigKgyfZ1tDlYEBtHnFdEfFi4z2SzzhB/di8I9vPNoO9y8yyYKidTYBGOJ1X5FO0
	mL0sTK4urCh0ouzxjAUH1JT4MlYrsRQOBtM6i5IV+cFKZK1ttz2DoPZyY6QzctOdlhRJlbOsoSj
	bSl9+/mJzh5kYbl/seEMBGeqCSIfXWj8T4Dg/Sgv9J1hbF4Pa12MfN6iu0a3dd+XTQXi8uKrbLV
	0U2qQwUZZPKx140/NNuC7MV8PNXKaTcqo1fihEx2NdkmVdLPlZ//V8Bxn2LUqkmRHCwxMOz6ck+
	g0Bb8L7zzcRptyZ8uDx1nUazT356lLrwU5aqfB3s=
X-Received: by 2002:a05:7022:101:b0:137:64ad:a636 with SMTP id
 a92af1059eb24-139c6f4f350mr2671104c88.27.1782230897470; Tue, 23 Jun 2026
 09:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
In-Reply-To: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 23 Jun 2026 09:08:04 -0700
X-Gm-Features: AVVi8Ce9xskQNam5h2s9SZz03OnfDUSiMjXUPhtZCQHvy-a98A3NZ4_p7YLSNqA
Message-ID: <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301404-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 190946B891C

On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. When
> completed all code paths related to sockmap-based redirects should be
> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
> disabling NET_SOCK_MSG. The implementation of sockmap as a container for
> socket references would remain under BPF_SYSCALL.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Changes in v2:
> - Handle prot->recvmsg being NULL (Sashiko)
> - Elaborate on the end goal in description
> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-unix-v1-=
1-d7e0cb7bb03b@cloudflare.com
> ---
>  net/unix/af_unix.c  | 4 ++--
>  net/unix/unix_bpf.c | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a..84c11c60c75f 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *sock, =
struct msghdr *msg, size_t si
>  #ifdef CONFIG_BPF_SYSCALL
>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
>
> -       if (prot !=3D &unix_dgram_proto)
> +       if (prot->recvmsg)

There is no reason to have this dead branch when
CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.

Let's compile out all sockmap code when both configs
are not enabled.

Since AF_UNIX differs from TCP/UDP, it can take the
simpler approach.


>                 return prot->recvmsg(sk, msg, size, flags);
>  #endif
>         return __unix_dgram_recvmsg(sk, msg, size, flags);
> @@ -3152,7 +3152,7 @@ static int unix_stream_recvmsg(struct socket *sock,=
 struct msghdr *msg,
>         struct sock *sk =3D sock->sk;
>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
>
> -       if (prot !=3D &unix_stream_proto)
> +       if (prot->recvmsg)
>                 return prot->recvmsg(sk, msg, size, flags);
>  #endif
>         return unix_stream_read_generic(&state, true);
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index f86ff19e9764..5289a04b4993 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -7,6 +7,7 @@
>
>  #include "af_unix.h"
>
> +#ifdef CONFIG_NET_SOCK_MSG
>  #define unix_sk_has_data(__sk, __psock)                                 =
       \
>                 ({      !skb_queue_empty(&__sk->sk_receive_queue) ||    \
>                         !skb_queue_empty(&__psock->ingress_skb) ||      \
> @@ -94,6 +95,7 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msg=
hdr *msg,
>         sk_psock_put(sk, psock);
>         return copied;
>  }
> +#endif /* CONFIG_NET_SOCK_MSG */
>
>  static struct proto *unix_dgram_prot_saved __read_mostly;
>  static DEFINE_SPINLOCK(unix_dgram_prot_lock);
> @@ -107,8 +109,10 @@ static void unix_dgram_bpf_rebuild_protos(struct pro=
to *prot, const struct proto
>  {
>         *prot        =3D *base;
>         prot->close  =3D sock_map_close;
> +#ifdef CONFIG_NET_SOCK_MSG
>         prot->recvmsg =3D unix_bpf_recvmsg;
>         prot->sock_is_readable =3D sk_msg_is_readable;
> +#endif
>  }
>
>  static void unix_stream_bpf_rebuild_protos(struct proto *prot,
> @@ -116,8 +120,10 @@ static void unix_stream_bpf_rebuild_protos(struct pr=
oto *prot,
>  {
>         *prot        =3D *base;
>         prot->close  =3D sock_map_close;
> +#ifdef CONFIG_NET_SOCK_MSG
>         prot->recvmsg =3D unix_bpf_recvmsg;
>         prot->sock_is_readable =3D sk_msg_is_readable;
> +#endif
>         prot->unhash  =3D sock_map_unhash;
>  }
>
>
>
>

