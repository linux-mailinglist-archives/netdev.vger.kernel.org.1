Return-Path: <netdev+bounces-264677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMMREsNpqmlORAEAu9opvQ
	(envelope-from <netdev+bounces-264677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:44:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4333921BC88
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9303C3011D49
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 05:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477D136C58C;
	Fri,  6 Mar 2026 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJ64QPdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF02C33F59D
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 05:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775861; cv=pass; b=ef/6kVCaM2a93i+61wlyUsaeUQg59wrRaKn8ujcNnb9eQ53tPxdmCJknCJzI1uLuxfok7UJkU2/QgvV0GJvkcjgdf3Gplt4KO4OY0nai45xNx7M/0XnY126XEW3RSWQp0t365etNGn77NvY5mxmNjjiTsUq4ESVp990uabpq2rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775861; c=relaxed/simple;
	bh=PSltAUW3Pbszw31Un6mmbj8jIMad2C1Y1xk6vP+XBsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8H//qNoFjB8lX8LCmoblkFddguy8nRJlnmUlNYFxYu/vcfxOq+DniFaVEnQRMh1w4R1fe6rnH9rQ9XvLYLfoffofcCay0ygP7Z8h49dOQoE8k//unhigPQpbAeEV1eC2TbqoVhYvrC/rBLBq5zSlNH4o3XNdrdtvF6cegcbsxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJ64QPdN; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1271195d2a7so1674960c88.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 21:44:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772775859; cv=none;
        d=google.com; s=arc-20240605;
        b=E/yNMlH46DUgr+R7dgRF/OpfBGYVFbjxbrexob91fPnJUbTcntvJj1X6YMGYprdb6B
         0fPWkYExuJyangC4e3phDiVc8Av8w6wX9WYag4315yfOJcBDGh3hghQjzjDyA5X/y/UA
         w9TDDLSWyrZzYMeI6LsO1prSV62IiJ7ka1aGQVnturb0rZfyocsA8sH3Lbcx8wAevL9x
         CMh3e+P1eLlvNXTkRN0WGRo30vWtaDMyBLX1bgpQaGl3bHKycJjBs8/QonTYn6+NBqSL
         fpR2znTZCveWHASs6POR5d32B0J1Ko72hfHsv399UOiVitXececQ/oeM186OfY70KF0c
         tClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tyBv9EeX3mFY/3tVDfQWJsxTKxsHkm5c9r8R+TELfok=;
        fh=yRMDAQ+C0GAjpIAQw0MZx8pExxtV30CkkkfTB7AJYGw=;
        b=k70c9QdPsWSBHLOlJvB8kG5hOZz3l9nyjY9LJYT2b80CUduhCTml0qgzUIu6BLK0fZ
         nTKRqczH3kJCFvi3+S76K0oWI9+AW9STmQCU4fzl6dYzZpiLNrzKcSIwpBP+ckF+7Y2k
         5sY77H+denMaFfS07/8Gv8Us3KA1mGpCt8fhB2CCK2VIZ8G9y5AXPCiQkg+TJsprCWqh
         TlXuw5Cerb3ezNqWmiqX7PNHXDEWdyfrnWbGUOaRaVbS/unt/Xvll6jKGaTIev1uhcfb
         j184oGmPfLlOvZXW4jN1LktPSCotytgaxUCqWHtnaD0d0wsAWv6IYp50OlZXcALHeiyl
         fAdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772775859; x=1773380659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyBv9EeX3mFY/3tVDfQWJsxTKxsHkm5c9r8R+TELfok=;
        b=tJ64QPdNkYMrwF6kswOu29tm1VHNA77QBY/+JXz5SaKEWEitVwvvAVp5cvWhcawhIH
         O6NoTmEBJb+sck6Azjo33BI8JpNA8Ml7zmwUXrxb2PCS0quICCPmN2ZMgkjCSiGRg9j6
         9FJLF7iR59luWOqtdYK5cWG65V6P9/EpWFGEhBiJjQx5aBq3PvyXHNzrRcYbYxA1QsK8
         6wF1Y37Bi6dTpqpUZgrbSTj8O3ghTdhoIPvNMd5YIRWk79ildQK83VaNaNE6iU3vgxY9
         KtOM8FsaN08/FY+HkariIl6RVMHBH2MjBQFJdTmkVO2CXSEG4kcFPhS6CwKRMfQQJwL7
         gBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772775859; x=1773380659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tyBv9EeX3mFY/3tVDfQWJsxTKxsHkm5c9r8R+TELfok=;
        b=tnHes8OmaxAFrm/xmHxyjm++g/jygGlutmWIgQNVKkzaF+zE005v6lpX9rhZySs8SD
         Dw/O/A3+uXfiAliwoFACzDsfLgcQWXPCP0+mdfV3NC1vul5YtYO1sXcM9DFAOrT25aIp
         xs0eQWrvrPRCCf0Hr+0R6oe3+8ETtBmffoV6LOKtSkhQlzl2w0C5jT7zXbUYpqxxcJjp
         X8VjOp1ag4iuQZVhxNC0Ldv5QWHAVo1p9KOx5DybhZNvoZwo1GqubLiggJuf4pzZjjAq
         WglrhCFqaE9vfb0YMKhNPHiBbXn1BFqJYqaKqVs+E3dXpHNQrWEbqt9mUdEFBLtqBc+e
         Yviw==
X-Forwarded-Encrypted: i=1; AJvYcCWoEX8K3vlMQdO4T3hAoT8Lzinn1OhfWw7A2CmGWzNG4Y6LeAl8UbPB0PfOrta6VTGTcjzLkDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36J9V5BXMbVyyJLh/5fRsYjcuI2FEF1BOCzVRGd96GwPCL+7Z
	bU8OoFOSJ00kQyx8eP8TzHrwX19pV+ny6OAOrVNTsuvnGXTsHyx4n5eiJYhUefZMqOLC4BiC9jW
	OzU3v8hspcxmf5FT6EvURAIFxkJK3EWu/i1gy30vl
X-Gm-Gg: ATEYQzxNj7+4lFcGGInevYTDoudAWXridGC6ItB9Yaq+IZuyS/CRt3V0ELX50OqiFgy
	JMMJahS3Up+5wsHA+Kv31tcMNqUXCYPuzfSsjSQj7eHL4exH74W6oC5UpDhmr7IslHnPg1MSRVw
	E4FCcIT5c5MC52e10R10xIkDegGvuVEIfuQRzF8hHKHQY2X1SRDFf5ujcuEclC6JVyV4UCN0z3+
	4Wo1yBx+zFffY8NbbNOCTVl/yW4QfnZ0X3o/mwVyEmSHtAxiCHykSocLyCkkWkFsoPh8bsevrg4
	S2YoWhtJx/u+awpnI5wVY53h19ptjr/Vnxd2sGo8tvRQu8sB/tm6vAaOG8sVpLGOjuZMoAvrWCs
	zWLHli7Q=
X-Received: by 2002:a05:7022:105:b0:123:2c98:f65d with SMTP id
 a92af1059eb24-128c2dc0787mr413515c88.13.1772775858405; Thu, 05 Mar 2026
 21:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-2-2f0c7410c523@rbox.co>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-2-2f0c7410c523@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 21:44:07 -0800
X-Gm-Features: AaiRm51r32W8zss6RR5Iwx5AUfeklGwhcZVJvjzKbkwk8LxQ9Tbtfu8f2GRTyJQ
Message-ID: <CAAVpQUCdzpwbu=fOrwCnaCFuD3U5SL73PB2nroqgUB4QdJ69og@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/5] bpf, sockmap: Use sock_map_sk_{acquire,release}()
 where open-coded
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4333921BC88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264677-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 3:32=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> Instead of repeating the same (un)locking pattern, reuse
> sock_map_sk_{acquire,release}(). This centralizes the code and makes it
> easier to adapt sockmap to af_unix-specific locking.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/core/sock_map.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 02a68be3002a..7ba6a7f24ccd 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -353,11 +353,9 @@ static void sock_map_free(struct bpf_map *map)
>                 sk =3D xchg(psk, NULL);
>                 if (sk) {
>                         sock_hold(sk);
> -                       lock_sock(sk);
> -                       rcu_read_lock();
> +                       sock_map_sk_acquire(sk);
>                         sock_map_unref(sk, psk);
> -                       rcu_read_unlock();
> -                       release_sock(sk);
> +                       sock_map_sk_release(sk);
>                         sock_put(sk);
>                 }
>         }
> @@ -1176,11 +1174,9 @@ static void sock_hash_free(struct bpf_map *map)
>                  */
>                 hlist_for_each_entry_safe(elem, node, &unlink_list, node)=
 {
>                         hlist_del(&elem->node);
> -                       lock_sock(elem->sk);
> -                       rcu_read_lock();
> +                       sock_map_sk_acquire(elem->sk);
>                         sock_map_unref(elem->sk, elem);
> -                       rcu_read_unlock();
> -                       release_sock(elem->sk);
> +                       sock_map_sk_release(elem->sk);
>                         sock_put(elem->sk);
>                         sock_hash_free_elem(htab, elem);
>                 }
> @@ -1676,8 +1672,7 @@ void sock_map_close(struct sock *sk, long timeout)
>         void (*saved_close)(struct sock *sk, long timeout);
>         struct sk_psock *psock;
>
> -       lock_sock(sk);
> -       rcu_read_lock();
> +       sock_map_sk_acquire(sk);
>         psock =3D sk_psock(sk);
>         if (likely(psock)) {
>                 saved_close =3D psock->saved_close;
> @@ -1685,16 +1680,14 @@ void sock_map_close(struct sock *sk, long timeout=
)
>                 psock =3D sk_psock_get(sk);
>                 if (unlikely(!psock))
>                         goto no_psock;
> -               rcu_read_unlock();
>                 sk_psock_stop(psock);
> -               release_sock(sk);
> +               sock_map_sk_release(sk);

I think sk_psock_stop() was intentionally put outside
of rcu_read_lock() to not extend the grace period
unnecessarily. e.g. while + __sk_msg_free().

Maybe add __sock_map_sk_release() without
rcu_read_unlock() ?



>                 cancel_delayed_work_sync(&psock->work);
>                 sk_psock_put(sk, psock);
>         } else {
>                 saved_close =3D READ_ONCE(sk->sk_prot)->close;
>  no_psock:
> -               rcu_read_unlock();
> -               release_sock(sk);
> +               sock_map_sk_release(sk);
>         }
>
>         /* Make sure we do not recurse. This is a bug.
>
> --
> 2.52.0
>

