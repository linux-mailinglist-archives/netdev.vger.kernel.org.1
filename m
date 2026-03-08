Return-Path: <netdev+bounces-265331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3jHxFL/LrWkW7gEAu9opvQ
	(envelope-from <netdev+bounces-265331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 20:19:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B72231DDD
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 20:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA88D300E710
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 19:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F116229C325;
	Sun,  8 Mar 2026 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3u3rB3I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85D3D544
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772997563; cv=pass; b=mzDijg/RpUxUA4MRn/n1hPiyZNJKUr2ym5iqXgUnjBfxDte55+LceeWtyr9yn42UH8tRIuwOhQzlQ4r1yCnc3D3H0qyfgfbTI2oXkf4MmbhondA5rpkLclx72XOb5Hs6Xt8b59bTW0xxHnG2RqjtHvdAaif4Xk219Qz/Nlzcabc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772997563; c=relaxed/simple;
	bh=+6WVk/Beq1DFx4RcD5ZyLB9ZX+z293wARmDyXVjpMe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyw25qhSGDfQEnHKS/+d0iIoFWBsG2p+fUC2qmNojvZMw81fLPtG64tLy2FFk/vDbWHcYcuX0ZMABpkEZncPvvwg87KIctYfWk34fo8tQ3tvbh4QfOxkXDlUAj6gYeSHWjRh2qxMrpU+QKg9VpxxPOQglHD/8SlQKz+PO46bWcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3u3rB3I; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1279eced0b9so9860504c88.0
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 12:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772997562; cv=none;
        d=google.com; s=arc-20240605;
        b=Qcmxw6c+N/rJdHWvAMnE8c+s3RuvaSgRNSfEBKneULoK1iwyGUw73cZc6zB8BnEHje
         j4n3DjJZPnVsvKZRFMMGQgjwrBxDjDBbzeIXgrS8ysagTEe+ngudGwnoaA9L1sdAWu1s
         r461CLP4APLBgjPZ5fh2HuzCPg8MkCssaG3elGIGxH8brfq4vH5wC9lc8xZwI/COPVz9
         IXXhihTK9JftMM2HOZzp3NTUeuDiwsSR/3hFMtWmS2DBYAHag/p5/6YNDQWvvZgn7/oq
         +jw5XaHY2nIwyh81ycSCHlmb29IxX6V292p5E27lmKUzc7LBvWlTYNJSclwv4zAWca/6
         n5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qhuBIomX01y7uULtufEEeQzTmmLtXyqvEV3MhfPNl8o=;
        fh=iSSj5/xUrdQhiAwKZdCMdrmWJ+gCN1Wh+n6WYo2IYnw=;
        b=HIfiaaBOmT17FktDAq/CjBYmxc/dCE6a9mlsH9pQNYusWtFab2Vi6XRTH9qbTee4mV
         +NttnOW2F0EEWWutVnvFo+xLpxwAbMXZxLgChKfOc9b+1raNoqeTnQHzNJQfrTFHh383
         jmYhx80jw9KJAHDQ2Vh81u3dy8ldzhI5dE7XzOJ5ntoDiiaHj9Fqpsvk6/OHx+RZsotu
         2kUdPw9v9g2IhscdBRQkuT9BqLmeH0q1eOXNlfVtWE4zqLpi0cQRzmUI7luhEaiCdmKO
         Ei0d1H6uv0kqKK5gDLejubjlfSyLFD0c+TEp+r1ou1IwrevXcDha/kT+637DHmvWuTgu
         q7/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772997562; x=1773602362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhuBIomX01y7uULtufEEeQzTmmLtXyqvEV3MhfPNl8o=;
        b=U3u3rB3IqkPU7+nuZlsTPSkeSPURwJ7Zr71WZ92+IMZScxGgtYwi0vkH/yCtH2KtK+
         eLQKxiL1rLy8QVa8PrH8Ip47ZnFyF0axAfIqJkN4S5BP5Myr51kMmuozF0E1Zo8AnMn8
         ZcGjt2vcheubcJMfsaiBqSWlasqUNfGAt8gH9P29k5fRLkQddMwV/fqrKMf3V6nXCYko
         2C1rYkvVv4UoELOg8qrEp7QOSJBpSu+wX+0WlAKlMWFrqN2sbwA0465GceFC2lnFE940
         GkcgC2PT1WS1RdBcClVLJs+j2oeLeHmoFpNaC1H6zTQDVRUMWNFg4CXbcJjQpGACMvwI
         WAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772997562; x=1773602362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qhuBIomX01y7uULtufEEeQzTmmLtXyqvEV3MhfPNl8o=;
        b=YxoTeLnNTL5/UbeDewUL2zgiuwuJYZhA6GmrUGvwlRclqn2UJdaplWAmaiT6NhUx1u
         bJt887BzqNWXylL/EXhDsv895Rd8l+Q37+QbnxYVDvUDU2thIQWYBgSSpRKMOJIUhSc5
         NPD6XpEHhnwPm5Rp8ZQSknExy02Mdcuj/J5+YbmyKdE3M1qdQPhGvV6FLuKpWJ5UUvMD
         6+mdLutsuV5wq6aL8h8gGR4YzKCCq1pRKHRPlDofhKWTAs+u6vk02+ydTVJ/IBdpn2Aq
         56BOEZilEv1mjU7wHu38wgJlp9A0Vp/pxH0pYcNQD12esUw25EVEJHElFYTSAyZbdkwu
         eJpw==
X-Forwarded-Encrypted: i=1; AJvYcCVZntrrcBW5L3vJuAiIxkLafmojs1V/2nTHkDmsNnf0g0kWQcuS/zFBiRFmxCNmjPJs4RFoHwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdM74ok7GA2WvenxgheLV/e+zwwEjvkN0XXen8joJji4KmHVLq
	OnYhMTN5oeh/bHoxrNhPqhCF8PT4T2h8eNnBJa5Dhn0AZ+ifzMEDP3cy7RorYxTx7rkNKFkknMD
	iKQqJNGE6zKA5BVZabTgrE9zRK1UxXLiFMF3Jf4Af
X-Gm-Gg: ATEYQzxpJEVxWhX141cs1xsCwjTPJ2BFj1H/PwoN9OhsLnKb5/rQc/+WUOtW0IXQ/Ni
	2mAv/iPSvJbg8SfegsF+7pMotNUV9b6HSeh+XDEsXQOSPUr/PONv27RPJ6gKVWZ3aMxiRWVtXRH
	oNZ5NJlBZS372ANhPMJeKoyK+VkOqvikVNdUKXuBB/Hj1i00z1gJ9HinIofPo1Ohkad2GhhnL1j
	3CGTLLUX4Ieuo9y6RBc2ZcfgTcLS4CqG7mD9RDSNhU+id2VKeiEvCVcBwEsxPNvZzSUQ9SV2+Dq
	re+Duryv6JZkyWJJ8xMK38qF3MOBoVoiCxwEiYAkEVSBCiESXVBPVLjUEYxQ3vNu2x02JdF0
X-Received: by 2002:a05:7022:ea27:b0:123:330b:3a0 with SMTP id
 a92af1059eb24-128c2ddc31cmr3684762c88.14.1772997561015; Sun, 08 Mar 2026
 12:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308030406.1825938-1-kuniyu@google.com>
In-Reply-To: <20260308030406.1825938-1-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 8 Mar 2026 12:19:09 -0700
X-Gm-Features: AaiRm51H3spQ5wMUgvYPWYy7tK2wVDpubB4EVqPruhchU92pfqhvfB7vpkrx9JY
Message-ID: <CAAVpQUBf1ZBox8mixB=+7hcEBoeRurpo=fNwS=SzvWVfym5C-A@mail.gmail.com>
Subject: Re: [PATCH v1 net] af_unix: Give up GC if MSG_PEEK intervened.
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Igor Ushakov <sysroot314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 94B72231DDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265331-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 7:04=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> Igor Ushakov reported that GC purged the receive queue of
> an alive socket due to a race with MSG_PEEK with a nice repro.
>
> This is the exact same issue previously fixed by commit
> cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").
>
> After GC was replaced with the current algorithm, the cited
> commit removed the lock dance in unix_peek_fds() and
> reintroduced the same issue.
>
> The problem is that MSG_PEEK bumps a file refcount without
> interacting with GC.
>
> Consider an SCC containing sk-A and sk-B, where sk-A is
> close()d but can be recv()ed via sk-B.
>
> The bad thing happens if sk-A is recv()ed with MSG_PEEK from
> sk-B and sk-B is close()d while GC is checking unix_vertex_dead()
> for sk-A and sk-B.
>
>   GC thread                    User thread
>   ---------                    -----------
>   unix_vertex_dead(sk-A)
>   -> true   <------.
>                     \
>                      `------   recv(sk-B, MSG_PEEK)
>               invalidate !!    -> sk-A's file refcount : 1 -> 2
>
>                                close(sk-B)
>                                -> sk-B's file refcount : 2 -> 1
>   unix_vertex_dead(sk-B)
>   -> true
>
> Initially, sk-A's file refcount is 1 by the inflight fd in sk-B
> recvq.  GC thinks sk-A is dead because the file refcount is the
> same as the number of its inflight fds.
>
> However, sk-A's file refcount is bumped silently by MSG_PEEK,
> which invalidates the previous evaluation.
>
> At this moment, sk-B's file refcount is 2; one by the open fd,
> and one by the inflight fd in sk-A.  The subsequent close()
> releases one refcount by the former.
>
> Finally, GC incorrectly concludes that both sk-A and sk-B are dead.
>
> One option is to restore the lock dance in unix_peek_fds(), but
> we can resolve this more elegantly thanks to the new algorithm.
>
> We actually do not need to synchronise MSG_PEEK with the dead
> SCC detection.  Even if the sequence above occurs, we can just
> give up garbage-collecting the SCC if we can detect the race.
>
> Let's notify GC when MSG_PEEK occurs and let it defer the SCC
> to the next run.
>
> This way no locking is needed on the MSG_PEEK side, and we can
> avoid imposing a penalty on every MSG_PEEK unnecessarily.
>
> Note that we can retry within unix_scc_dead() if MSG_PEEK is
> detected, but we do not do so to avoid hung task splat from
> abusive MSG_PEEK calls.
>
> Fixes: 118f457da9ed ("af_unix: Remove lock dance in unix_peek_fds().")
> Reported-by: Igor Ushakov <sysroot314@gmail.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/unix/af_unix.c |  2 ++
>  net/unix/af_unix.h |  1 +
>  net/unix/garbage.c | 71 ++++++++++++++++++++++++++++------------------
>  3 files changed, 46 insertions(+), 28 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 7eaa5b187fef..b23c33df8b46 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1958,6 +1958,8 @@ static void unix_detach_fds(struct scm_cookie *scm,=
 struct sk_buff *skb)
>  static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
>  {
>         scm->fp =3D scm_fp_dup(UNIXCB(skb).fp);
> +
> +       unix_peek_fpl(scm->fp);
>  }
>
>  static void unix_destruct_scm(struct sk_buff *skb)
> diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
> index c4f1b2da363d..8119dbeef3a3 100644
> --- a/net/unix/af_unix.h
> +++ b/net/unix/af_unix.h
> @@ -29,6 +29,7 @@ void unix_del_edges(struct scm_fp_list *fpl);
>  void unix_update_edges(struct unix_sock *receiver);
>  int unix_prepare_fpl(struct scm_fp_list *fpl);
>  void unix_destroy_fpl(struct scm_fp_list *fpl);
> +void unix_peek_fpl(struct scm_fp_list *fpl);
>  void unix_schedule_gc(struct user_struct *user);
>
>  /* SOCK_DIAG */
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 816e8fa2b062..468fb0ee463f 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -318,6 +318,21 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
>         unix_free_vertices(fpl);
>  }
>
> +static bool gc_in_progress;
> +static bool unix_fd_peeked;
> +
> +void unix_peek_fpl(struct scm_fp_list *fpl)
> +{
> +       if (!fpl->count_unix)
> +               return;
> +
> +       if (!READ_ONCE(gc_in_progress))
> +               return;
> +
> +       /* Invalidate the final refcnt check in unix_vertex_dead(). */
> +       WRITE_ONCE(unix_fd_peeked, true);
> +}
> +
>  static bool unix_vertex_dead(struct unix_vertex *vertex)
>  {
>         struct unix_edge *edge;
> @@ -351,6 +366,32 @@ static bool unix_vertex_dead(struct unix_vertex *ver=
tex)
>         return true;
>  }
>
> +static LIST_HEAD(unix_visited_vertices);
> +static unsigned long unix_vertex_grouped_index =3D UNIX_VERTEX_INDEX_MAR=
K2;
> +
> +static bool unix_scc_dead(struct list_head *scc, bool fast)
> +{
> +       struct unix_vertex *vertex;
> +       bool scc_dead =3D true;
> +
> +       WRITE_ONCE(unix_fd_peeked, false);
> +
> +       list_for_each_entry_reverse(vertex, scc, scc_entry) {
> +               /* Don't restart DFS from this vertex. */
> +               list_move_tail(&vertex->entry, &unix_visited_vertices);
> +
> +               /* Mark vertex as off-stack for __unix_walk_scc(). */
> +               if (!fast)
> +                       vertex->index =3D unix_vertex_grouped_index;
> +
> +               if (scc_dead)
> +                       scc_dead =3D unix_vertex_dead(vertex);
> +       }
> +
> +       /* If MSG_PEEK intervened, defer this SCC to the next round. */
> +       return scc_dead && !READ_ONCE(unix_fd_peeked);

I'll add more bold comment here and the commit message
why memory barrier for WRITE_ONCE(unix_fd_peeked, true)
is not needed, as suggested by Linus.

pw-bot: cr

