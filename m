Return-Path: <netdev+bounces-256491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id POCGMdOQgmmCWQMAu9opvQ
	(envelope-from <netdev+bounces-256491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:20:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 227BADFFAA
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D15E30CBED0
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 00:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E2A156F20;
	Wed,  4 Feb 2026 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duCYwQ6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973F128816
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164432; cv=pass; b=GjtqFjYT8v+JGT/7v8j5bPkhUDUsiW1CO1BcFeaaa2OKI68ecPBm/zTrw5LZ9aGO0mmgGH+zE3S5XfbKlADRc1podUKe791pEA3TfwGsjIDC2h4nAmebLrSdIBZR7Fvi+q8KS/6rTNMw5WMhURjO861Pdr2eGoAm24zPNkoV+5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164432; c=relaxed/simple;
	bh=y4lgRh13qtAfuAO4tYZhb3+xjFhnpQQtzFJwMDlt3O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYva5E+9MQjzdLP1JnsXOnsfctlzaz6Ma/3mtEHzcdB4GMBJKKjHEmYl+ROHeTptnkGu1fWYXCefsKYj1sFBf+QjNQAuriK6lkiYKqLH6KPlUrQi9CAZeniKfIITMLEVRN17VFt7efPxTgHz7sfhyVFPSQRQqLY1347pqRcQXiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=duCYwQ6p; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-126ea4b77adso2418566c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 16:20:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164430; cv=none;
        d=google.com; s=arc-20240605;
        b=G95ijvai63kNlLmjjD7i6zFg3iVBITMETyII0HvngsWHuAxgJqHHwm5+fSAJHA1LYT
         LiJLtLPSfOC5WpVZoi6l3p09Fk8gcqaUAPl7hEVvSBm1XuEa2vyjvWY1KIJHljaixyip
         Hjv5l+ZFDaNPi+0iUIvT2tZ2PEgreOP7hs4rnkwYD9UL/3CFTbq3RBW4/Eiz12tvbDxF
         GYwMnZLMxQPuv9ySKnQCwNOHZsRWYWCK5Pb+bIgzLXG3EuId4ddxU6YVS0JpXs+Z00JZ
         +vaUndu59lrAeXokQYwkPT6hj4KqvrwTBWMB4P7EnGrAnE9Je1YmXFzEkwlY9GgUvSLS
         WnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qTymf8/taE30pcJ9wC3D8Pl4iGbdSyLv0rBK+BHC5yA=;
        fh=khvB5zhrggwZXuuQATTgyx9nHhxJhEe16RtoryIsZQE=;
        b=ZS3u3r4YMq3zWlwzVje7pqxW8S0jjmh0qJAiQYUsjTMCZdxemh7tSv2053zTJF1wkI
         TG7srwSaX9C6jUXhxsnZxNw0o0R6Ou8WS/qiNnQVTuV5X+AYnqv/QjzffwTqBMOb6Z8c
         NwydFsvyHi0vRxkR64y0P7h98bQNiCdFE02xtoT3inWzpssuGX20n+esq+ubOv4uw3rd
         eLczK0VZNPIRnnAzyQ7MkaEGBpgpAyALTyYPJF/RMZ7fBEECVzbB9b2pKtmfl47pJMqV
         g8V66AEhOXZlSzU5eL1VvqJaZDks/BzuLjGNbWVcha33AhFPt+lgZhw3ZnV/QKpztLtl
         8LGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770164430; x=1770769230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTymf8/taE30pcJ9wC3D8Pl4iGbdSyLv0rBK+BHC5yA=;
        b=duCYwQ6paROKEaMdgpx74IYmO4YQ9JoPN/Wt/I+3uvkx0P4O+INZw+f0kA2toBNWLf
         ifzvaavBiU16aSK7w4hTUFlxX9VNCCKrAJPVkKSt8E3EA3CEoNUJAqhG55KQo3sieAyI
         cv34TgPywUb28xY6ZdesUbWMlzY/vXE+rKR/SGL96AYZBdVQm7LAec8AGyz5uCbRyZCJ
         tOZLmPOtI0DdXwC+SqXnZCzKx2n3EQZhjLMqvPZSZLgPS2X0bwy49eEdGnEcNDYdtH3i
         xWMz4ZgdDjT5irdlruIz9nBkj+8UPe/bad6EChJhVwHpepYXNhW530kg+m3I/gNi7w+z
         VMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770164430; x=1770769230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qTymf8/taE30pcJ9wC3D8Pl4iGbdSyLv0rBK+BHC5yA=;
        b=cOUSdQpOo42CqdexrRH2Z6lsCPFbLskLQUxvKbJ5kkmnTtLymlxiBRUMAXFrcj5tga
         ViY9nskhI2P0yqh2E6EmyvsHKSF8Y6X2otJpPOoEG7Xi6AJxZ81eBZrdtVK/ntz5V59+
         2blSTdEJNhxdfzhQvThGiQkmSSuT/FZpT97e20nEx5GN9g7f0MvJd9dNQumt5htRScLi
         KAaaPbaHPlY+52082QzWHwCzh9uW249Rhg+nV0Pt37shWVUiED7cS2cq/2S4Wf6B7iR6
         2CcxmMGQhR7NSOsN+WB31Gf3Hqmhh3xeKHiOhDt+wxX31JlfVcC7e/zh34k2dKsUOffP
         9XCA==
X-Forwarded-Encrypted: i=1; AJvYcCU9ihZSCACHjQ7a0PBG8iat6ioMbHnzgmSN7Ji1JxYgF90S8pmUqLX5EdzE20N8XnNV2tQOuUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2923zG5+OZjNrpamvWPx9gggrGN4HjmneEnsMbC77k0bbonwr
	czFObCPojrZxsRbnbLsvJVP74b9t9SqREZgJjJfsNdo6my6p3FLJuIFzxTLjaGUhSmA6TAcp1su
	/3ES5z68lgwS5gz5QdJ4hjvOrS+dPNZoqv4FYyjCg
X-Gm-Gg: AZuq6aJxsDirG8UTy9Qo3EyrIxWvHGndU7SBsLZLrxZucovrW96prB6ySyINdc2wfVf
	pHWkpz+P6kG37wS9d34XZpwiAcMlk+aPIAprq59VK4Oh3Fg946GH9MpNrRb2REyxiRQMGZI+HRx
	4igWDSOZfwkrdfwlZa6oL3o+EXAvbV7Ek7QvO0ZmtllMd5z+NnlfL5I0fLpriHRyVUlHmjvn/eV
	HaehotgM2PMtjF+FLuTrqhSP4mVrcWweH22Wv5nwIsUWgVJ54bE6GHwnTO5pbFmsSaRAmv3ZpFa
	u59e1DKBGhhF/PVB2AOEIwNWrYLBWd32qa1jRvoplqwpXyXGUQwjSFqiWA==
X-Received: by 2002:a05:7022:49e:b0:11a:126f:ee78 with SMTP id
 a92af1059eb24-126f47d19c0mr577997c88.34.1770164429842; Tue, 03 Feb 2026
 16:20:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202023931.2788955-1-realwujing@gmail.com>
In-Reply-To: <20260202023931.2788955-1-realwujing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 16:20:18 -0800
X-Gm-Features: AZwV_Qi_9FuPb2TlwgJCQR40PRlDs5Z8sfTsrbzlzJETq1WurnuHaN7IfdxzAvs
Message-ID: <CAAVpQUAcn5kAHE+FniMt-wn1iM3hP9L7L0VhQUzzk130i4X0zw@mail.gmail.com>
Subject: Re: [PATCH v5] netns: optimize netns cleaning by batching unhash_nsid calls
To: Qiliang Yuan <realwujing@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Qiliang Yuan <yuanql9@chinatelecom.cn>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256491-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 227BADFFAA
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 6:39=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com> =
wrote:
>
> Currently, unhash_nsid() scans the entire system for each netns being
> killed, leading to O(M_batch * N_system * log(N_ids)) complexity.

batch and system is a bit unclear, maybe M_dying_net,
N_alive_net or something ?

Also, isn't __peernet2id() also O(N_ids) ?

>
> Optimize this to O(N_system * N_ids) by batching unhash operations. Move
> unhash_nsid() out of the per-netns loop in cleanup_net() to perform a
> single-pass traversal over survivor namespaces.
>
> Identify dying peers by an 'is_dying' flag, which is set under net_rwsem
> write lock after the netns is removed from the global list. This batches
> the unhashing work and eliminates the O(M_batch) multiplier.
>
> Use a restartable idr_get_next() loop for iteration. This avoids the
> unsafe modification issue inherent to idr_for_each() callbacks and allows
> dropping the nsid_lock to safely call sleepy rtnl_net_notifyid().
>
> Clean up redundant nsid_lock and simplify the destruction loop now that
> unhashing is centralized.
>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
> v5:
>  - Use idr_get_next() for restartable iteration safely handling removals.
>  - Drop unhash_nsid_callback() to avoid context safety issues.
> v4:
>  - Move unhash_nsid() out of the batch loop to reduce complexity from O(M=
*N) to O(N).
>  - Use idr_for_each() for efficient, single-pass IDR traversal.
>  - Mark 'is_dying' under net_rwsem to safely identify and batch unhashing=
.
>  - Simplify destruction loop by removing redundant locking and per-netns =
unhash logic.
> v3:
>  - Update target tree to net-next.
>  - Post as a new thread instead of a reply.
> v2:
>  - Move 'is_dying' setting to __put_net() to eliminate the O(M_batch) loo=
p.
>  - Remove redundant initializations in preinit_net().
> v1:
>  - Initial implementation of batch unhash_nsid().
>
>  include/net/net_namespace.h |  1 +
>  net/core/net_namespace.c    | 34 ++++++++++++++++++++--------------
>  2 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index cb664f6e3558..bd1acc6056ac 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -69,6 +69,7 @@ struct net {
>
>         unsigned int            dev_base_seq;   /* protected by rtnl_mute=
x */
>         u32                     ifindex;
> +       bool                    is_dying;

Please put this in a hole, maybe after after hash_mix :

$ pahole -C net vmlinux


>
>         spinlock_t              nsid_lock;
>         atomic_t                fnhe_genid;
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index a6e6a964a287..3061c83786ac 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -624,9 +624,11 @@ void net_ns_get_ownership(const struct net *net, kui=
d_t *uid, kgid_t *gid)
>  }
>  EXPORT_SYMBOL_GPL(net_ns_get_ownership);
>
> -static void unhash_nsid(struct net *net, struct net *last)
> +static void unhash_nsid(struct net *last)
>  {
> -       struct net *tmp;
> +       struct net *tmp, *peer;
> +       int id;

No need to move id up.

> +
>         /* This function is only called from cleanup_net() work,
>          * and this work is the only process, that may delete
>          * a net from net_namespace_list. So, when the below
> @@ -634,22 +636,23 @@ static void unhash_nsid(struct net *net, struct net=
 *last)
>          * use for_each_net_rcu() or net_rwsem.
>          */
>         for_each_net(tmp) {
> -               int id;
> -
> +               id =3D 0;
>                 spin_lock(&tmp->nsid_lock);
> -               id =3D __peernet2id(tmp, net);
> -               if (id >=3D 0)
> -                       idr_remove(&tmp->netns_ids, id);
> +               while ((peer =3D idr_get_next(&tmp->netns_ids, &id))) {
> +                       if (peer->is_dying) {
> +                               idr_remove(&tmp->netns_ids, id);
> +                               spin_unlock(&tmp->nsid_lock);
> +                               rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0=
, NULL,
> +                                                 GFP_KERNEL);
> +                               spin_lock(&tmp->nsid_lock);
> +                       } else {
> +                               id++;

This can be done unconditionally as the id will never
be assigned to dying nets.

while (...) {
    id++;

    if (!net->dying)
        continue;

    /* do cleanup */
}


> +                       }
> +               }
>                 spin_unlock(&tmp->nsid_lock);
> -               if (id >=3D 0)
> -                       rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
> -                                         GFP_KERNEL);
>                 if (tmp =3D=3D last)
>                         break;
>         }
> -       spin_lock(&net->nsid_lock);
> -       idr_destroy(&net->netns_ids);
> -       spin_unlock(&net->nsid_lock);
>  }
>
>  static LLIST_HEAD(cleanup_list);
> @@ -674,6 +677,7 @@ static void cleanup_net(struct work_struct *work)
>         llist_for_each_entry(net, net_kill_list, cleanup_list) {
>                 ns_tree_remove(net);
>                 list_del_rcu(&net->list);
> +               net->is_dying =3D true;
>         }
>         /* Cache last net. After we unlock rtnl, no one new net
>          * added to net_namespace_list can assign nsid pointer
> @@ -688,8 +692,10 @@ static void cleanup_net(struct work_struct *work)
>         last =3D list_last_entry(&net_namespace_list, struct net, list);
>         up_write(&net_rwsem);
>
> +       unhash_nsid(last);
> +
>         llist_for_each_entry(net, net_kill_list, cleanup_list) {
> -               unhash_nsid(net, last);
> +               idr_destroy(&net->netns_ids);
>                 list_add_tail(&net->exit_list, &net_exit_list);
>         }
>
> --
> 2.51.0
>

