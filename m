Return-Path: <netdev+bounces-257030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDJ4O0pNhGm82QMAu9opvQ
	(envelope-from <netdev+bounces-257030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:56:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DBEFA4D
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6366D3002539
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5896B35FF6B;
	Thu,  5 Feb 2026 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5XXDQd1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C8334C14
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278214; cv=pass; b=T1jPuRxFR8/KEKk0mtVXTuuwrqeBXrKMSMToI+dEDX3BM8Q2e5RqofXZW2nH/aEaWe+yjx7sO4OwCd9pHyO6K2Xk9q7ATWce8ecGxce2/l/6sG2SjVvrnPcq5LxUtgAnAABcHYHFQmLxa/oWw8g1TZBxHNwkuVAJviTANesk4mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278214; c=relaxed/simple;
	bh=3axIOJP3cA6W/bgLcYT/tOluzJyeAKi8O7IHrZk7QbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOTUgQSqoAl9cCEvzn973BsoSACM1X0etYM7VN9vqx0K9vKrVYEgs7J1pB/mDjTxkFWkA6D3+XPfUWhuNNPls6fWS/yPdsEljEmQbQvG8E2B1UD0PBYWMucFI8yMWwzma9wB8gKp0RAtKdgYabXP8wMjAHrmVyzEplT0U+G97EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5XXDQd1; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4b77adso730693c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:56:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770278213; cv=none;
        d=google.com; s=arc-20240605;
        b=a0vShR4sX1ZU6JxvZaVZZ+bq+KjfjyKZL88swlPR8OeDhi6OumU+vMclyuv7X87IBO
         ypjnDL/lHLKZtSaV9hv08bsfLfmh7FMR4WmKDchVHZ+ov4FQFxfEnUp6nk4YDYwH6QDo
         rOanGhjvFPuDi7ZEzDkGLJa7Fwyp2sXCIENhCJS5dht/qvzmfWhg5vHY/257x+cpieqy
         ZfqvUIX6BVGsX0ZQziJli6MlIjZcYFuYK62ZqE5ZNff5oU/PpHaqp8qYJdxqEKmNwzbq
         OLOovOj0jVhQQPwbWioCMQ83t0WuRx/tatLMay7BNpKC1egKu0SrXsS/2m51jES6o903
         GKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hX8+ASaHY+dtMLrTvu6CdgPKXZVrjgvfnrh6PI7a3uA=;
        fh=7gvD13qojv3btEmh4GSkUBJ4c0FS5tLyy/7S39mBnnw=;
        b=hHMSFNzxbKOoR52ix0vNUdWSJXOpVlV29FB/cIPQF8tT6xLFJX6x4vYM6cFtHF//hQ
         01s6VgpY4P2k19+FozZsL2jVUCoejNxfJxQszzFfnWLU77mU6n4caWNPyEqTVbF+QzoW
         hpQ889CzlyUn9hLMFFobvoGQ/kvo6r92XN4tZPxznnYHYX98/G/Ux8vKKf/RMeCNM6yH
         SMkxOCGzipY7GAtUopJL19JDaPQwbbhT8nJ3byikaJ95Y6F4MQ6xtXD6ZX23SeX9OTMJ
         YWKPBv1jjElzaZLCAlUHiheNisIutlMkkiKWsVLv2yAwyyOX4uedlu2NDjMLkUMkLvVs
         5/PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770278213; x=1770883013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX8+ASaHY+dtMLrTvu6CdgPKXZVrjgvfnrh6PI7a3uA=;
        b=r5XXDQd1BT1xpgGM/hCD5lDgkOqRCCCkdHs/fk5nDU8LxqQiuMp0mMys6ndipTL2N7
         3EflQIeVdRdVihGKelXgRWW4EAPJL210xmeAqBcJFXSpPbv5OGk6JD58jx5k+tqhBwQ4
         o6s5nB6boVg3Yh6HrFcbEMTNF+KBZ4OXfycGuPJk5CE9dilANwTObeejCnE1iM9hcuqs
         Og7aEJKyrg7WlKIc5SyVZXi7pc35orWG2OMAgcgwaNiBseuxpXvrJh1VytTadaiuT1ce
         StXhRWPiNHl6hRl3TicGkyCanYO2Z/VQgXYS1w+d0xOXBRUmtVqyQ4OjNH7XZiDZgfgq
         295Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278213; x=1770883013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hX8+ASaHY+dtMLrTvu6CdgPKXZVrjgvfnrh6PI7a3uA=;
        b=Cmg5k6CqWnI3Mf4GU1JwiQ9L+tQsfGBCwEAs8VX+3c7KecC8t+SNBbMMLYxxG7lniD
         4iUcJgOxOSLyqd9vKneO2RfzdkxYhJzhBMIf3tBYAwN8vZoxJyzFzbIMNxs09kytA/IE
         /dS/3ibBApd/Ugt2HrY6PK3/+HVGmMaH0vknTDrolXhkNmMpHqLkvsbECNtwoZ6xT0Tx
         xCA9U7AYCxz1x7KzckIE4dCd/N1cHsw3oTimc+pir5vIMILdxyo0kygntwHvgGDq9k5u
         t0AoIZa7NGVlm6zPIIEhRLJdkXao9PZ6iDFRtKtKB3SRzT3rBvEW8orozUj8n/+zZ818
         m2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUKXnnaLzXtZjxP5rZlWdOkngg8V9sFOkTvpVxa+so5Nf7aptxes645/HHpKRoAqBDVPTJZKJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIn9xtxTrlOxidlvaCzIQDw2CjPAXqgjK3/zqx3RSxbDkTcR/
	ova4fo60mMyOXsC/Odft2hN2z2Jaj1S5OAWvzipydV3J9/XTyjA8Snns2DAkRQoNCVnMUOEL/Mw
	UEvgVSxbqTYgm+//Wrv2U9DA34tzOC/Cg0wNXkMO7
X-Gm-Gg: AZuq6aK+snesGRwKwenRGAy7fGu5iJOSVM0uPqdS+bZ9ZXOyH3NY314GdvzniIPoBMy
	HuXv0gOtVNVd/vcMGh5rBg1b7wUyscWqRzCoRCnZnzyAPErMhJTYFo+Fd9uzrvFf7bOQaHzq+QU
	VazozalHv383osxuoNm60+ai5Py3EWrwFtCj7r8y6/9nm++3IYTtE5GOGO+QJ2kAggYv4PF/Z9t
	15snUP7MAWXkx2Pow4Teo9aq4IN3IzkM28rtR+W0RXL8yhO61HKU/1Yb2GHtuBXM0vn2gwOYAGD
	BU7guTBKgZZYJjS18Pq5I9Ak86hcyv+MTLWX84+erIka0LO7RDkWgEtn9KY=
X-Received: by 2002:a05:7022:e98c:b0:126:fddf:3d86 with SMTP id
 a92af1059eb24-126fddf422cmr468424c88.39.1770278212822; Wed, 04 Feb 2026
 23:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204074854.3506916-1-realwujing@gmail.com>
In-Reply-To: <20260204074854.3506916-1-realwujing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Feb 2026 23:56:41 -0800
X-Gm-Features: AZwV_QjRPyxxWp88yHur3pWexc_GfN9BwDe8I9cKMvGJLkZJrRihYP2TQ6uiu6M
Message-ID: <CAAVpQUD=_UX0ZqwQQ6hdACC43AKX0xt__4fR_+XQO=fWgymWyw@mail.gmail.com>
Subject: Re: [PATCH v6] netns: optimize netns cleaning by batching unhash_nsid calls
To: Qiliang Yuan <realwujing@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Qiliang Yuan <yuanql9@chinatelecom.cn>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257030-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 004DBEFA4D
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 11:49=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com>=
 wrote:
>
> Currently, unhash_nsid() scans the entire system for each netns being
> killed, leading to O(M_dying_net * N_alive_net * N_id) complexity, as

Sorry I should've used L_dying_net, M_alive_net .. as N is not
the same here.


> __peernet2id() also performs a linear search in the IDR.
>
> Optimize this to O(N_alive_net * N_id) by batching unhash operations. Mov=
e
> unhash_nsid() out of the per-netns loop in cleanup_net() to perform a
> single-pass traversal over survivor namespaces.
>
> Identify dying peers by an 'is_dying' flag, which is set under net_rwsem
> write lock after the netns is removed from the global list. This batches
> the unhashing work and eliminates the O(M_dying_net) multiplier.
>
> To minimize the impact on struct net size, 'is_dying' is placed in an
> existing hole after 'hash_mix' in struct net.
>
> Use a restartable idr_get_next() loop for iteration. This avoids the
> unsafe modification issue inherent to idr_for_each() callbacks and allows
> dropping the nsid_lock to safely call sleepy rtnl_net_notifyid().
>
> Clean up redundant nsid_lock and simplify the destruction loop now that
> unhashing is centralized.
>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>

Code-wise, looks good to me:

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

> ---
> v6:
>  - Use M_dying_net and N_alive_net terminology for clarity.
>  - Correct complexity analysis: __peernet2id() performs a linear search.
>  - Move 'is_dying' to a structural hole after 'hash_mix' to save memory.
>  - Scope 'id' variable locally within the traversal loop.
>  - Simplify IDR traversal logic with unconditional increment.
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
>  net/core/net_namespace.c    | 34 +++++++++++++++++++++-------------
>  2 files changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index cb664f6e3558..db291cc7afe3 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -120,6 +120,7 @@ struct net {
>          * it is critical that it is on a read_mostly cache line.
>          */
>         u32                     hash_mix;
> +       bool                    is_dying;
>
>         struct net_device       *loopback_dev;          /* The loopback *=
/
>
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index a6e6a964a287..aef44e617361 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -624,9 +624,10 @@ void net_ns_get_ownership(const struct net *net, kui=
d_t *uid, kgid_t *gid)
>  }
>  EXPORT_SYMBOL_GPL(net_ns_get_ownership);
>
> -static void unhash_nsid(struct net *net, struct net *last)
> +static void unhash_nsid(struct net *last)
>  {
> -       struct net *tmp;
> +       struct net *tmp, *peer;
> +
>         /* This function is only called from cleanup_net() work,
>          * and this work is the only process, that may delete
>          * a net from net_namespace_list. So, when the below
> @@ -634,22 +635,26 @@ static void unhash_nsid(struct net *net, struct net=
 *last)
>          * use for_each_net_rcu() or net_rwsem.
>          */
>         for_each_net(tmp) {
> -               int id;
> +               int id =3D 0;
>
>                 spin_lock(&tmp->nsid_lock);
> -               id =3D __peernet2id(tmp, net);
> -               if (id >=3D 0)
> -                       idr_remove(&tmp->netns_ids, id);
> -               spin_unlock(&tmp->nsid_lock);
> -               if (id >=3D 0)
> -                       rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
> +               while ((peer =3D idr_get_next(&tmp->netns_ids, &id))) {
> +                       int curr_id =3D id;
> +
> +                       id++;
> +                       if (!peer->is_dying)
> +                               continue;
> +
> +                       idr_remove(&tmp->netns_ids, curr_id);
> +                       spin_unlock(&tmp->nsid_lock);
> +                       rtnl_net_notifyid(tmp, RTM_DELNSID, curr_id, 0, N=
ULL,
>                                           GFP_KERNEL);
> +                       spin_lock(&tmp->nsid_lock);
> +               }
> +               spin_unlock(&tmp->nsid_lock);
>                 if (tmp =3D=3D last)
>                         break;
>         }
> -       spin_lock(&net->nsid_lock);
> -       idr_destroy(&net->netns_ids);
> -       spin_unlock(&net->nsid_lock);
>  }
>
>  static LLIST_HEAD(cleanup_list);
> @@ -674,6 +679,7 @@ static void cleanup_net(struct work_struct *work)
>         llist_for_each_entry(net, net_kill_list, cleanup_list) {
>                 ns_tree_remove(net);
>                 list_del_rcu(&net->list);
> +               net->is_dying =3D true;
>         }
>         /* Cache last net. After we unlock rtnl, no one new net
>          * added to net_namespace_list can assign nsid pointer
> @@ -688,8 +694,10 @@ static void cleanup_net(struct work_struct *work)
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

