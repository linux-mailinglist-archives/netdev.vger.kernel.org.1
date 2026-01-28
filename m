Return-Path: <netdev+bounces-254061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHgGEgFveWkHxAEAu9opvQ
	(envelope-from <netdev+bounces-254061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:05:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06C89C219
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58192301726D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893FD2836B1;
	Wed, 28 Jan 2026 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SqTl5CJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFEA280331
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769565950; cv=pass; b=Of3JYESH+owJHKqgRWPg3e2/PBy8gcuU93Ya7yy70EBwgw3WV0N6i80UePA9u34yeIBTdRfVmbBikPvQ8Zi84cHVeh4Tv+fIAb5drUnyKxMVWMNCGe3JEnRtTRZSY3Lh0GM3NcY1GlpFo8DD6s1/qITjxIKB3rG155WeGIQCEL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769565950; c=relaxed/simple;
	bh=R4vkDTXkQDGFcTOZ4IN1ZgXIn9856hI9ieQ4JN28Tss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbWdKAEPQOOX0R2RfEk2hgXN2f7LlMhzn9A1gkSMkc+FZ/Omy+738ToZhNZtNsMFN8k8GnWannlc/N0OXD1/PPk0o+TVZLGXMOHkrPJzR1COyZWnU5LQbDpFZnofE2DFn6mrswdFg1PvMTG9ZzFTlWapHrc+5Zna5TkiHYBpyac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SqTl5CJ; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1248d27f2b9so4820811c88.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 18:05:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769565948; cv=none;
        d=google.com; s=arc-20240605;
        b=PvYfKNLexbTLm8idxRC+LQe4+Gxw/sY0k/JuDQ0hB57MBPZTYoZvqkuvJfxTpNk1TG
         mHIVxRqTq0pr0sNM93stBuVpUpdV8kuDPBKZOit4/i8FmzUzUDPp38Ox0AlZ6mQoY7P8
         zz+k4fXAKw0Jh6wKgYgyCwPdFxqE+dWNI7Yu8ohKrYpiVc8azbG/gIAp4D9WMPI6tCTr
         B65xwc+6KIy2V5R7A9XHETVCsac0X/8bqvZEttuDRKvUQvfcBVggq79LAhEH3yVKAG23
         EZyQzuztYJurw4XEuZ/WrE7CmIt6bImlq5zb52dVvxIjMWRluoZcMLQp4aZLtJuSqQwK
         oNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YnGK8vw0Ema4IFPlOEFz1B+wFR9+g04ZjmbSGFmnwFg=;
        fh=rjya+eq9rlppVqPlLo00U+4gV87g9ARjn5b4B81P6II=;
        b=elJE/TKZHR/fv9iYt4RyphK9S/Cu9+BjVo5v5McQ1dXPOCXOPvb9MoYHUG9xEfnNiE
         wK1MIt8p9pV/MQEv6insDnrfcYy724hK9+tvHMi1NDj9W0w6nvkwFVkns627caIXKYZm
         jN7ikAptNwjruYx8kyoUmAakevghwqLy21OYabPVlK36fyefofRnrZ2cNgvddwDvnKgr
         7a/iAbioTc2GRWIROzf5TTwVpy0tcCdVqKPxL40sTEM6vwiBjgT0f98EzhBjFzwkbbv0
         8nnESh4y3GVPmjUSsA3w+Np7Yw8AJXHb3UyFZB4ZieGi1IXDkwPX9aXoJzBasLLgHPtw
         2pBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769565948; x=1770170748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnGK8vw0Ema4IFPlOEFz1B+wFR9+g04ZjmbSGFmnwFg=;
        b=0SqTl5CJ3yeHa0WXz55oOCy723g6tfMoKnWiMdspq9gODvFYaJtxjQ2uCCZEppMD+8
         KxRPRM7pW92m3KTNKbTdN3yZYBRovPVBDjUVet9YiZRmrozdb2VpPtHVxbLVg8cwUKYB
         wqrooME79fY9/5n/Va3aaV1AF/nzqbrnpiuxg7+Qg8bPKkbzAQKHttzZ2MgisMpVK1UX
         FaOlwJYN76gvn3AmfKnE7Zf3Y+M+DkaTUtTKCc4gCVN4FlzOqCWwqPNcHw8F791gVhze
         ZYYprhm6eb1SrdinZT6LHdF4qt7Qu3eLMlAwVj3DLtFR1bBWnWBCxooNYn8+TeNINt/G
         JiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769565948; x=1770170748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnGK8vw0Ema4IFPlOEFz1B+wFR9+g04ZjmbSGFmnwFg=;
        b=IuyFMQIwlj6BnmaND0oaxLuZ4V1fDOBbKNOGISxMSPkYK+vXvJeM1qk/W31xPzVv/w
         AL586vWqVHbOW85a/ddooOvoPfq9LUUqX0ie7adrjk18gkP7k+2M9BvKvps7XWs07JDr
         2gaBf4CGgLxeYgWw/yzHsN74irORCPgZRgDV+p7TXDZPCNCiW4begnIynetMDza5/ooc
         Olbl6hgIU2hCqBWCtWuyV4NY7DDlg+IMCTEbqwVugHJo2aqbUgot3bVEKXWqGe2I/fvC
         wTZS05a+PjFE1Y8H9GZxKi9LJCETE8ZE/95RyJJkGHRZEuT5gxtVNnVnw7HE5Hi8caQH
         09cA==
X-Forwarded-Encrypted: i=1; AJvYcCX6Y8U0UNxK/PACVtqhrIeXGMrCOJUaT1j+vWndl/ZfeKVQvOLBKvcFWF/3O2+flxQoaokYG3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Rh526PDGwqFcbNCInytGciEFiNUJWxxcZYukk+i0OedkwWrA
	VotZcX+Rd9wcDQCTPu2Gt5LDveSLaam+Xb2YLe0nfN/gPQByFDpVM7mTzKfHiBNmPycjtXs10bL
	H45hbDRCh+xUlxLngWm4KKiml3cBy3JSFP3OeeUuS
X-Gm-Gg: AZuq6aKjnOMspT/68vinLoocOv0UROCv7rO4GYZskYmunqxsnGio78QrZd2PJYKGg4X
	HudMl9ox7SPvVLmn3olQM2bqafmwaOEL/XB9HbfJ3FZRXHexamazC/AkLKdMvyxE3fIyFsRd3+W
	UDw2GMTr5Mk/hlyd0t7ZC8rNA9wzw+CaL6JvES28ovLh292Zdw5Nz7ISX0K3m6ZGXrMAlItyRhM
	EB57Txx2qwWhFuQKTXKjJ+9ds2l1hbBv2VW2a3fFL/tRN+YzvLjKEKEXwp+vJgg0DMxkCeOGzpX
	DlXaS9QeafVTaW05Ki9ftfaFe2yR+EYtDejl0KMH8ckHu/OeiJPG4P+g
X-Received: by 2002:a05:7022:1e0f:b0:11e:65b5:75ce with SMTP id
 a92af1059eb24-124a00638dcmr2004839c88.10.1769565947786; Tue, 27 Jan 2026
 18:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128012145.1682016-1-realwujing@gmail.com>
In-Reply-To: <20260128012145.1682016-1-realwujing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 27 Jan 2026 18:05:36 -0800
X-Gm-Features: AZwV_QhKoAIApJhNrzvV4gEahpDR5Akoc0L2si86ece5kbN_w7pn0hUxbxetVbE
Message-ID: <CAAVpQUBbdsNPkvL7JHrgqen7DM70S2VYTtgHx-kjWq3ZqB6uqA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] netns: optimize netns cleaning by batching
 unhash_nsid calls
To: Qiliang Yuan <realwujing@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
	Jeff Layton <jlayton@kernel.org>, Qiliang Yuan <yuanql9@chinatelecom.cn>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254061-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: B06C89C219
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 5:22=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com>=
 wrote:
>
> Currently, unhash_nsid() scans the entire net_namespace_list for each
> netns in a destruction batch during cleanup_net(). This leads to
> O(M_batch * N_system * M_nsids) complexity, where M_batch is the
> destruction batch size, N_system is the total number of namespaces,
> and M_nsids is the number of IDs in each IDR.
>
> Reduce the complexity to O(N_system * M_nsids) by introducing an
> 'is_dying' flag to mark namespaces being destroyed. This allows
> unhash_nsid() to perform a single-pass traversal over the system's
> namespaces. In this pass, for each survivor namespace, iterate
> through its netns_ids and remove any mappings that point to a marked
> namespace, effectively eliminating the M_batch multiplier.
>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>

Why two SOBs with the same person ?


> ---
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
>  net/core/net_namespace.c    | 46 ++++++++++++++++++++++++++-----------
>  2 files changed, 34 insertions(+), 13 deletions(-)
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
>
>         spinlock_t              nsid_lock;
>         atomic_t                fnhe_genid;
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index a6e6a964a287..50fdd4f9bb3b 100644
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
>         struct net *tmp;
> +
>         /* This function is only called from cleanup_net() work,
>          * and this work is the only process, that may delete
>          * a net from net_namespace_list. So, when the below
> @@ -636,20 +637,34 @@ static void unhash_nsid(struct net *net, struct net=
 *last)
>         for_each_net(tmp) {
>                 int id;
>
> -               spin_lock(&tmp->nsid_lock);
> -               id =3D __peernet2id(tmp, net);
> -               if (id >=3D 0)
> -                       idr_remove(&tmp->netns_ids, id);
> -               spin_unlock(&tmp->nsid_lock);
> -               if (id >=3D 0)
> -                       rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
> -                                         GFP_KERNEL);
> +               for (id =3D 0; ; id++) {

Doesn't this rather slow down in a common case where
init_net has ids for other netns since it is never dismantled ?


> +                       struct net *peer;
> +                       bool dying;
> +
> +                       rcu_read_lock();
> +                       peer =3D idr_get_next(&tmp->netns_ids, &id);
> +                       dying =3D peer && peer->is_dying;
> +                       rcu_read_unlock();
> +
> +                       if (!peer)
> +                               break;
> +                       if (!dying)
> +                               continue;
> +
> +                       spin_lock(&tmp->nsid_lock);
> +                       if (idr_find(&tmp->netns_ids, id) =3D=3D peer)
> +                               idr_remove(&tmp->netns_ids, id);
> +                       else
> +                               peer =3D NULL;
> +                       spin_unlock(&tmp->nsid_lock);
> +
> +                       if (peer)
> +                               rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0=
,
> +                                                 NULL, GFP_KERNEL);
> +               }
>                 if (tmp =3D=3D last)
>                         break;
>         }
> -       spin_lock(&net->nsid_lock);
> -       idr_destroy(&net->netns_ids);
> -       spin_unlock(&net->nsid_lock);
>  }
>
>  static LLIST_HEAD(cleanup_list);
> @@ -688,8 +703,12 @@ static void cleanup_net(struct work_struct *work)
>         last =3D list_last_entry(&net_namespace_list, struct net, list);
>         up_write(&net_rwsem);
>
> +       unhash_nsid(last);
> +
>         llist_for_each_entry(net, net_kill_list, cleanup_list) {
> -               unhash_nsid(net, last);
> +               spin_lock(&net->nsid_lock);

This lock can be removed.


> +               idr_destroy(&net->netns_ids);
> +               spin_unlock(&net->nsid_lock);
>                 list_add_tail(&net->exit_list, &net_exit_list);
>         }
>
> @@ -739,6 +758,7 @@ static DECLARE_WORK(net_cleanup_work, cleanup_net);
>  void __put_net(struct net *net)
>  {
>         ref_tracker_dir_exit(&net->refcnt_tracker);
> +       net->is_dying =3D true;
>         /* Cleanup the network namespace in process context */
>         if (llist_add(&net->cleanup_list, &cleanup_list))
>                 queue_work(netns_wq, &net_cleanup_work);
> --
> 2.51.0
>

