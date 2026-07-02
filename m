Return-Path: <netdev+bounces-304294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tpSeH8fxRmoXfwsAu9opvQ
	(envelope-from <netdev+bounces-304294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:18:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B38AB6FD5DC
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:18:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=qoEIqfHf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304294-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304294-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7927A3014111
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950E43C5550;
	Thu,  2 Jul 2026 23:18:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D32345734
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 23:18:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783034282; cv=pass; b=ohLmfkeg5P4XqxgLlcl+w3STVnB95AqP4Vkz9xSn52BLin+8bPYhlFY+K8y/QB2tSZ35VIwEYi3biNjzjJqhd1CEKR/MPCUtEsz19Yn053+WiAOmI36XAelYCCrEhbGd+RYJjRnkxR/yl2CJgiPZJayZIPSjk6P83ppihSzh5vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783034282; c=relaxed/simple;
	bh=zVmYAg8SDDIcqm5cuuYXsyDIeaIF6rabThVZEIJN+FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYJsLMvU2BZvsEbdcOi/0gGRDOzk9ijIwbh21biKUb/fACq9DnxcqpZ5TIhlBYn9DGQ29OEWgyv8gs4+aXfKFmvx5Fs32IU76DlYCk8aQHRTYPxvvMeqhZMdAm22+mWfX63NamBH8NbLmiZQtE2AljuxDVyU42HbEte6EQKtpiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qoEIqfHf; arc=pass smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37fdee9276fso2678407a91.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 16:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783034280; cv=none;
        d=google.com; s=arc-20260327;
        b=NJr8B9qf0du413TQ7zfqvrlB26yjm+QgU/Lw1ihd1CVzQewyy0VSBS/S2R/TBQz+Gx
         NhWAFXwvz4snYQoufFEnGXl3tFHewI/6lmLdR382MEDiI4tYKCivnO2a05/yei0+ZAle
         X4ySxJAl1LlM3VNbe+K254pfw5wCbABg/12ez8AyzoCdP2FTMgQu304wj8+lYn788HOj
         bxDGhqf5Zc2IXxKWOncaHOgIZiCcYS8uTLccQqPntCJ+nWWstKPZfM/mz6juhUaspkNt
         HV08lk7I1Z78qoB0N6ZQ1XGXh33+/puT+1ZYALrVrtTFAyhCAd0onZiLRAsWujJhHeDV
         feDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8bRzUXpa3AzwKJlF7M63zNC7yrIHoTM5RKC2iba92s=;
        fh=tuPtflF42UUxaHfRBaVs+Jx6ZJI0MN47iXv6DlW11vw=;
        b=V8KzydViji4UDLVpDHh4xB5HH5UyhVfYBwucCOHTDmN+Sn8GcL8DgYul9Uoo7O3tga
         XKz654LfGymN3wM4KHG6rWsFLrtR4aLIJVU/83kYeh091sjJ17ASY9gwEZsFCXHmnIYS
         6CNkDUTZMRNij7z927XP59xWVj6noll79YLLR5ArZWnufI9n0ScQPDzbMElJeaz4Eygv
         9Gzc39mtMNCXPUqMGkoBGmGcN7tH+23aT9ZGTS6EFhOVBcTMriMr8odg1uEkZ1b5v99n
         hkQx547ypwez4Wchz48cSHCpx1badSpbdrzLvMRK3Dcc+XWIiPGYVGashJ/1NAS2GbZd
         plRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783034280; x=1783639080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a8bRzUXpa3AzwKJlF7M63zNC7yrIHoTM5RKC2iba92s=;
        b=qoEIqfHfQyiXreH+8rvQjX8ROfhibYoHN7JGvrpTxglYvZsQoGXleJ82zxHBSz2MMr
         mgHFaGN7vqon++o/DXFApImvKOifGG2nMd9DjfSs+jk4V0d+tOZTZuHv7E5NzRDndtog
         rvWTCgFihA/08NB8bUv/1wflI+LfmnP5f9Byoq4towt50jVEADuYX6yHyCCIvs3zuA7y
         RUlABDx5cDm7fGAy2QmvzVmGTfIEPkMjrye6e0GDOGCLRWYg+cPjQADqERNkrtgffJzK
         uYiRtMAq2iPZIrQAhoYvHSARpz7XBrYjtUW7+Sy4TTTsLkJygRDJpZHoBNCsq8dNhE8E
         7YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783034280; x=1783639080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8bRzUXpa3AzwKJlF7M63zNC7yrIHoTM5RKC2iba92s=;
        b=RpG1yewYqpsb9KDXNsb+NGPm1HakI2nSrkZ3laih0KBusy3Vs8SrZqir02Xu5pOQWk
         3KKhdgbW0lIAsuYFhWFx+iGnSuQ6DMEhXN5a1fzhlQEcr3MlhPwZqA2KCoKfspPTP7jn
         Csg8UDaZNPjNfBDXzyBZ34nwJikquq/OQUQ6hvGbSMTaO23M4Vc6FlFxspqVae3clTkU
         goTVMa7+Zo3sSkJcN8f6KsE8zXmYWCgMz9gTKTDjrwndvCl02OyGrk4KRjkgUI2NsYfn
         HhU3pi22qgEJvTPMp0pnlaQFEYDN/K+0Y/0XPWaqnfBm72zxklBtYuLKEPAXB8XhQPFq
         lRCw==
X-Forwarded-Encrypted: i=1; AHgh+Rq12pbA4aFA4qpQ6rMrzkxrFfp+tWqKReaMr6am1OumLZk6WugUWT/oLgsCbf/cfrxWuvWTeGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mW1REjEGeenwwn0hOU6mlisve2QlJVSre+rnTxFtaezR4hYn
	ggEV2nZBBZVvZu7/bYwHl+VULrll4VF3mYwVM0Z0rSrGhV0d+BvgXkIdS9P6qD1owckW61KsIe7
	ZeHU+FOLexdwmNnpznqLb0Q99klzbGuDKRqKj8wPx
X-Gm-Gg: AfdE7cmCInUdCRSZswrUb0uSdXEjuwq75OGH+ujy/9OIBXGMLdP0+fhQPFvsCVfJdRC
	ZWCKcK0+RqA+b2+tEEX5ssL6WxzLySDYpNunLq7YfiK9Y5+qEOK+ImCG3cMBJGwL8gA60y8ZEj+
	rUNN38xwA1CbrpNzLORoaQbrIVTR4o/ZFRS5w7J1jThJ/KSHVXYYuQqSs1xs9k4HADnndQEHfZ+
	MFLcMTgTBajHfmrzAhySYpgkXLOY2Qap/UMxAJVsu2emitOp7C2DHlcttuy0r/NADBgndHqXM65
	zQaKuYLAJdCTSAoXAoEIualg0W0r7TLI3sAFzMdq0NpOuNA+XhBLf3EQ5qEveFOVQmsElzuR5mb
	DxFSssJCNYNYpDroTWtH8jCQBJY4rw41wxgUUGzYm
X-Received: by 2002:a17:90b:4ccb:b0:37e:144d:7f6e with SMTP id
 98e67ed59e1d1-380ba84bde3mr7594643a91.3.1783034280045; Thu, 02 Jul 2026
 16:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702202018.2280336-1-John.Ericson@Obsidian.Systems>
In-Reply-To: <20260702202018.2280336-1-John.Ericson@Obsidian.Systems>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Jul 2026 16:17:47 -0700
X-Gm-Features: AVVi8Cc2hITAVBYUb5dUHqNl94Aq3YqpUqND5qO0KWJFPcDdxdXCcWkiI2yxVsE
Message-ID: <CAAVpQUDTHJ7pM4V9CiSL6mCtk3dvecgBgR-ngd4=dozp4myxRg@mail.gmail.com>
Subject: Re: [PATCH net] af_unix: fix listen() succeeding on sockets in the
 wrong state
To: John Ericson <John.Ericson@obsidian.systems>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Ericson <mail@johnericson.me>, 
	Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	David Rheinsberg <david@readahead.eu>, Cong Wang <cwang@multikernel.io>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:John.Ericson@obsidian.systems,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mail@johnericson.me,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:cwang@multikernel.io,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-304294-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,obsidian.systems:email,johnericson.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B38AB6FD5DC

On Thu, Jul 2, 2026 at 1:20=E2=80=AFPM John Ericson
<John.Ericson@obsidian.systems> wrote:
>
> From: John Ericson <mail@johnericson.me>
>
> Commit fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for
> reaped sk->sk_peer_pid") inserted a `prepare_peercred()` call between
> `err =3D -EINVAL` and the socket-state check in `unix_listen()`. Since
> `prepare_peercred()` leaves `err` at 0 on success, `listen()` on an
> AF_UNIX socket that is not in `TCP_CLOSE` or `TCP_LISTEN` state (e.g.
> one that is already connected) now silently returns success without
> doing anything, instead of failing with `EINVAL` as it did before.
>
> To fix this bug, and avoid such bugs in the future, switch to a style
> where `err =3D -E...;` instead happens right before the `goto`. (`err =3D
> other_function(...);` is not changed.) Then there is no spooky-action-
> at-a-distance between the `err` initialization and the `goto`, something
> which is easier to slip by code review.
>
> Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reap=
ed sk->sk_peer_pid")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: John Ericson <mail@johnericson.me>
> ---
>  net/unix/af_unix.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a..7878b27bbaf8 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -813,18 +813,22 @@ static int unix_listen(struct socket *sock, int bac=
klog)
>         struct unix_sock *u =3D unix_sk(sk);
>         struct unix_peercred peercred =3D {};
>
> -       err =3D -EOPNOTSUPP;
> -       if (sock->type !=3D SOCK_STREAM && sock->type !=3D SOCK_SEQPACKET=
)
> +       if (sock->type !=3D SOCK_STREAM && sock->type !=3D SOCK_SEQPACKET=
) {
> +               err =3D -EOPNOTSUPP;
>                 goto out;       /* Only stream/seqpacket sockets accept *=
/
> -       err =3D -EINVAL;
> -       if (!READ_ONCE(u->addr))
> +       }
> +       if (!READ_ONCE(u->addr)) {
> +               err =3D -EINVAL;
>                 goto out;       /* No listens on an unbound socket */
> +       }
>         err =3D prepare_peercred(&peercred);
>         if (err)
>                 goto out;
>         unix_state_lock(sk);
> -       if (sk->sk_state !=3D TCP_CLOSE && sk->sk_state !=3D TCP_LISTEN)
> +       if (sk->sk_state !=3D TCP_CLOSE && sk->sk_state !=3D TCP_LISTEN) =
{
> +               err =3D -EINVAL;

Could you keep this part only for net.git and follow up on the
cleanup part in net-next later ?

>                 goto out_unlock;
> +       }
>         if (backlog > sk->sk_max_ack_backlog)
>                 wake_up_interruptible_all(&u->peer_wait);
>         sk->sk_max_ack_backlog  =3D backlog;
> --
> 2.54.0
>

