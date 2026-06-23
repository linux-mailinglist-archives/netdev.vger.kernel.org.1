Return-Path: <netdev+bounces-301241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0ZS6DCznOWqUywcAu9opvQ
	(envelope-from <netdev+bounces-301241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:53:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 805316B36B9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:53:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=N4sqpEjH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301241-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301241-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F6F1300614A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212C355F22;
	Tue, 23 Jun 2026 01:48:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260112B94
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:48:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179284; cv=pass; b=UiL69d2SWz4eof0/FP5hPbDQLZc3iDdEqOoqIABsnBcjIIQgqlwK5zMAyrNDp2Bc+Yc7GZTW8QXg6Sf314dW89kS3PwS7Dh4bEPHd/WAs3iXEhZUb7XrQcrop5Il7z/Ihnqh9P4KJkr4PqkA+M9H3KSfWCUafGVY6nWoSKGCU7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179284; c=relaxed/simple;
	bh=5L5622+PlQcyS7Jn4DJE2Jg9X7ZQRPSC6RFfcfDoN6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuClnX8VKtrtQHQA1VyyOiJOyvUHkQtfgDJPrus/u+f7fffCZf1zUrvmzoPnPVMJ0297+xg9dU008HHbWe4GRqoGSjSnhzTklEBeNPt4Hw/kGTxlj7AW3G4QzjuZp7QFSd0smK4PWKfe/LJnuqPdFrFn5zrGj2RSPUkNrDpYM+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4sqpEjH; arc=pass smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423610ec93so4697852b3a.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 18:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782179282; cv=none;
        d=google.com; s=arc-20240605;
        b=NRhg9KrRnkC5MoSMQ/g05jiwT0slTmuKb1tFVUkQm5seic95fJ1x9E06sbWxe5ff2o
         ZxEx9PcBdTGEdD8AZF8iM3lQexkjxP5UWy2emZNSQWhmxP8a/yp1B8BGySAJqoWSLJaV
         MgN5PPQhyKv7sMBd+QH0b1DTK3HNtBm1XfROwh9mIe6g69ymxwy1kimIYwTYQabsP9pp
         TfV3XLUZ6mQAyCQylxjw0s6oBsNUJttV29EZaVjsGU/v0pQ6QSnVU6RKjdwcEbd5ERNt
         oN8OPhvFkicWFtySiuX2YOdRRhL0GLBwkPxAh7LlDPiHU0DTYT5HvrfC6lNxH/u6Yd7g
         75Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cDnxyYH4sYtX0BdSDsVd5/mdRZ3nkxchuZKFq9+uuKI=;
        fh=P7B9iKCM3bWOcdBUC6P4Lnmu6gH4nTZSTPJwCZq3BVE=;
        b=hhA//ugK1rAtcR4c5EvyyMfDv9lTpmKmk7cWZ2Fo7Ezler9BIs5/CVj4jxsGwWYMLC
         1xeqlFD/GwyXEGa4dkDsPwXQoBMEf9qfwdPIJoLD9PAJMR60WJClmL20YwNXGQceAyPs
         eJ0cIrTOZqr3neQtHORNHWotLFZarfFM4yJo5tVAEKxVf/gIoPgPHpOcySUhUrsrPUxI
         QZC0oWx2aGFv4WnSpzveqGnP2fZkk9ZhQOePepfx5jRi98Tw+yLO6mx64n4q/cuvMoRc
         TLeuzHYFYo5eq+5ZWCIafGW6C4p9PaF3dxIIXhRyXuW5Jyz9M4HO+ZXRBCIqsVZh+dkq
         MFEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782179282; x=1782784082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDnxyYH4sYtX0BdSDsVd5/mdRZ3nkxchuZKFq9+uuKI=;
        b=N4sqpEjH9Opr63R3rXWqxuq1GYM33miwV2PHOE6aYvJpkvSjg+45idvVLVuUQlDL4z
         1OBtbHTvrPtc2ADIwAlVDY2nCZG57/9qve95hUzlbNlvIN/d9d9YwLrIrMKUiICM6PPt
         HVim88fPvSbsI6lqTpu6aF+lp12/UhyfM3+unQ0QByb0wp2Crg1qmi14oe1vJEq+0d7w
         vA+XyQIvSgg1H2Qdm1KoA3i++2hplyGBIoMsGj4cYZ5kH7S6eSXz2Ggh/h+85P3Xwh3s
         zUpTC9qcBMp7ui0777+ypJjFBrnnJk4fpqefnl/V4mmjNKygihaB3AD4L257dTunzYN1
         q+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782179282; x=1782784082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cDnxyYH4sYtX0BdSDsVd5/mdRZ3nkxchuZKFq9+uuKI=;
        b=cNpHj21jGmhUFvfvAovjPl5nwRnXr1mc4ur1CfrU6/pcnpCeYTdeJnPfiiVw49sMkD
         bVNrG0wrURBKH/C89HmYauLfcchbW+k/APtSMBSGpemtPqXmM7Yoiwm999R9YwqT+o4R
         frC01NYUMH2PFzwiWbe1rPhphY5vAXJE2oeIUaTcUWXbNyE5t2K+5eljMFLcYQIGvsTI
         oLB/HMbul3UbLInd2QASYtgo5RACTaKa5sCaZn/xXkN93Cvra+U01ixpbWL1W33vNR+I
         9m7udYkGv3vfZGHtkVWmh9NABYFzknJlMgbUGoUhK09Yxbck9HJnzN08MjzWYiv06xLm
         uvDw==
X-Forwarded-Encrypted: i=1; AFNElJ8tPQqZicaisUV5EheWecJ8lJoDepPrNv/Q2f7csbog2hV8ReeVJ+C2p4v7GG9tBTSFbsR9xz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUV/7TRT0bLlM6BoZNBvelnmg9LFMQJ7zHYnxKSQtJ8/2iNldj
	Oe09Lz/tn5qrV3bv12YvoauhHaI9c0v2gOQIt5Gtc2QPqtt6JJG+PwIJ2SG3p6nRHYqMMgP/47p
	odIKcvjWPvgAFQOkdFpCgHxodTjqa4oA=
X-Gm-Gg: AfdE7cl8i4dKFgBEjnEdAupVTnvdgwMTlEbR4vIewKhPyNQ2SDalZ93dH3vt8idkWnG
	+MY0u/9Z8/I7hJ+booX4qNkDdkQElVIxYAJcwRBiHhBtvP0c2SpCBvw1+J/7iDbZoVWGHk8eRR2
	wTCS744G8GRhfhRmWMLrebLLAeakNSmYmi1wOAnZH6kt5btZPafU1xoyUPAuOitbU5jRKG+V5iM
	gDs5JVZ87lmPjhkNIuuGiDWzk4rzY5QSMYTzMU8j3W/e1TMMQb2Us3Af/pqQloMNDbTVo9PvWfN
	eBRtguObZcgUPhIPWNXb6phtVXwbLrN7iRajfjdRuTotGp/n8mZA9xYlk9666jTGfBlPhSPG
X-Received: by 2002:a05:6a00:882:b0:842:3801:47b with SMTP id
 d2e1a72fcca58-845507e137dmr18541248b3a.18.1782179281926; Mon, 22 Jun 2026
 18:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622171048.1626022-1-edumazet@google.com>
In-Reply-To: <20260622171048.1626022-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 22 Jun 2026 21:47:49 -0400
X-Gm-Features: AVVi8CcuCKbrtiCdlFfVPYSlkn7tDYThM7Cg9k_CVWwmhNiMZpAJZBsCz75JM7s
Message-ID: <CADvbK_e_7184a_jm5ASjKafXrJqaOKFUKJF6V1wp7AnFxK596g@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com, 
	Jon Maloy <jon.maloy@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301241-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com,m:jon.maloy@ericsson.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,ericsson.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev,e14bc5d4942756023b77];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 805316B36B9

On Mon, Jun 22, 2026 at 1:10=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> TIPC UDP media bearer teardown calls dst_cache_destroy() on its
> replicast caches before calling synchronize_net() to wait for
> concurrent RCU readers (transmitters) to finish:
>
> static void cleanup_bearer(struct work_struct *work)
> {
> ...
>         list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
>                 dst_cache_destroy(&rcast->dst_cache);
>                 list_del_rcu(&rcast->list);
>                 kfree_rcu(rcast, rcu);
>         }
> ...
>         dst_cache_destroy(&ub->rcast.dst_cache);
>         udp_tunnel_sock_release(ub->sk);
>         synchronize_net();
> ...
> }
>
> This is highly buggy because dst_cache_destroy() immediately frees the
> per-CPU cache memory (free_percpu()) and releases the cached dst
> entries without any synchronization.
>
> If a concurrent transmitter (e.g., tipc_udp_xmit()) is running on another
> CPU under RCU protection, it can call dst_cache_get() concurrently,
> leading to:
> 1. Use-After-Free on the per-CPU cache pointer itself (crash).
> 2. "rcuref - imbalanced put()" warning if it attempts to release a
>    dst that was concurrently released by dst_cache_destroy().
>
> Furthermore, calling kfree(ub) immediately after synchronize_net() withou=
t
> closing the socket first (or waiting after closing it) leaves a window
> where a concurrent receiver (tipc_udp_recv()) could start after
> synchronize_net(), access ub, and suffer a UAF when kfree(ub) runs.
>
> To fix this, we must defer dst_cache_destroy() and kfree(ub) until after
> we have ensured that no more readers can see the bearer/socket and all
> existing readers have finished:
>
> 1. Move the rcast entries from the public list to a private list
>    and delete them using list_del_rcu() (stops new transmit readers).
> 2. Release the bearer socket using udp_tunnel_sock_release() (stops
>    new receive readers).
> 3. Call synchronize_net() to wait for all outstanding RCU readers
>    (both transmit and receive) to finish.
> 4. Now that it is safe, call dst_cache_destroy() on all isolated
>    rcast entries and the main bearer cache, and free the memory.
>
> Fixes: e9c1a793210f ("tipc: add dst_cache support for udp media")
> Reported-by: syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a396a66.52ae72c2.136ac7.0003.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> Cc: Jon Maloy <jon.maloy@ericsson.com>
> ---
>  net/tipc/udp_media.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> index 988b8a7f953ad6da860e6190f1f244650f121dce..befaf7137caf642462b7203a2=
429a60386e64db8 100644
> --- a/net/tipc/udp_media.c
> +++ b/net/tipc/udp_media.c
> @@ -808,21 +808,26 @@ static void cleanup_bearer(struct work_struct *work=
)
>  {
>         struct udp_bearer *ub =3D container_of(work, struct udp_bearer, w=
ork);
>         struct udp_replicast *rcast, *tmp;
> +       LIST_HEAD(private_list);
>         struct tipc_net *tn;
>
>         list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
> -               dst_cache_destroy(&rcast->dst_cache);
>                 list_del_rcu(&rcast->list);
> -               kfree_rcu(rcast, rcu);
> +               list_add(&rcast->list, &private_list);
>         }

Could this corrupt the list for concurrent RCU readers?
When list_del_rcu() is called, it intentionally leaves the next pointer
intact so concurrent readers can continue their traversal. However, the
immediate call to list_add() overwrites both the next and prev pointers
to link the entry into private_list.
If a concurrent reader is currently positioned at rcast, won't it follow
the newly clobbered next pointer and jump from the original RCU list
directly into private_list?
Because private_list is allocated on the local stack, the reader might
interpret stack memory as a struct udp_replicast. Furthermore, the reader
would miss its loop termination condition because it expects to reach the
original list head, potentially resulting in an infinite loop or a crash.
[ ... ]

This looks legit.

Thanks.

