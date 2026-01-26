Return-Path: <netdev+bounces-253424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKMlMBxHd2lbdwEAu9opvQ
	(envelope-from <netdev+bounces-253424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:51:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0987495
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1972302E790
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D52F331A71;
	Mon, 26 Jan 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8bwAuk1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5DE3321DE
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424382; cv=pass; b=qpVqH6HjOhfbK4pHfN7V5ue02HV6r4pDFHy0FGyTS7H2if5v3lWR4HIjEdNma0+1aILMuy103l5lqRLFG8pUWV/miYHTkKEpjAayH2AY+jsOVWvlyWeK+96kCyBtJhAy1sc58fXEagvNwUY2x44qOQx5VpkxCzETDN8RXUiTiUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424382; c=relaxed/simple;
	bh=94GmzbRktVK1GlPBz5Sz7m7iOIEia5jWBvlAE13dppc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZrif7w2V6NsLER2lvGwLQjSwgUFpeUnXxnUcg1zu1Z/p8PbsFGmC0ZXlm3nJlExlLQfj1c1yHG89S4ygmWQE/xrGKRVRUyp9OYCS3BmoRBlw79/ye2CvqP0bpaclESkwi5aJEweZ1AZmc6dPFtfqBAh/Q8gNlWt8oYHe10HF/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w8bwAuk1; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50146fcf927so59814161cf.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 02:46:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769424379; cv=none;
        d=google.com; s=arc-20240605;
        b=Gb0f0h/JFp3AbPO0BDxfvAO7THF4hpAsvpHhqbj8MYMIGtsEj/xZQqiqcgSaVpgoTg
         fs9NIa4cFV+NC7yiMoKYvILfOWy0/xrEG0GsbLNiToT0flPEu4DhKQQaWPdGpK3UDbnV
         tM+PjPLNsWLysQACMUAGPi9fCs0rwH4A+YtWiAQcgVUd+7EpWWUirGstgUwg+RTDZQ79
         gbz65sXDyBaDE1DqbHEQBXQhDNLKLrvL0XIdwtxnHSf58lued6KSi8ENiG9BHpWQOjTg
         6UZF9oSydFG54eLPTU06im7lztl/1QPUlIuqMnkcgns7yU2vUwM4JDYt1FLUbrqXEZ8N
         CuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Od1EKCwd9dTKL6f28R/c7jV4EqRADZNnYvDknVlC7Y=;
        fh=lK+C8pB1og3nAhELHFG5l1zMCOgKxmzcnYaHIfxZJVc=;
        b=c3ECpTDZz8POfFybapU4ek3Kdv7naUK7mWPq+bYwqhqM3GUePGizaVyzqwhZ30umdd
         DRVXicWWQ83zjVVOGKKYdZQkSaJD5dte395CDFkRTPsLnnFekx5VSTgT6BWWZYD2y6wt
         5F43TLrO6+Pfbk/5zPJ06iAn9QIxlCrqDgTPrIatEtxd8rKBV1A8Vi5RsksEInHEoRmo
         8gahvf3GH2pOaPTtyHtG23m/VOKvU3zTfMsWDZPI0hQviJh+C/VzDaaCveXsvs823SgQ
         96GDGfdko4m/aAQ+QvgPnSBwR08bgSpv99nMIcz8BT8/JiYPGi6FxVAy9vy+fOyXmCbM
         35PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424379; x=1770029179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Od1EKCwd9dTKL6f28R/c7jV4EqRADZNnYvDknVlC7Y=;
        b=w8bwAuk1bpd4gYsowpKo/4b3Cq/IXjDkcnbpPBbUNSeysHjF8tyV4TB1Da637LFq9k
         X/5etSwAJxBTa3lxbxPF8e50SRLR5lYJxosMemvennxyCxA0phswxCwdZqBmBTleCVMS
         sP//wV2KHQlRQYGJJHS4PXMg07iZA2xek6XGAUyoZxt5Q+Ag/Ij+pwBBakemeIhvYctP
         GM/70OncZpywVYPzNrrnbvZNsnDINXYXv8KrTaEqvbW3PtRwbi5F7ykfh42C8qNgpaxi
         KsywR5o8kVH5uwY4ayuvlJwSljW4ba1YYCs0UMQNQMD/jHBSQFACPzNYpVeSGqGEr9Wm
         om9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424379; x=1770029179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Od1EKCwd9dTKL6f28R/c7jV4EqRADZNnYvDknVlC7Y=;
        b=BQCBUt9za5adkWkrwKeqmbbCFV+AJ4l8aMivV7vMzpQEFMW1OD7DNmI8yLZ4pQSzHo
         oG3LTUJUm7IoHBUsqjsW8j9ori4VCA0q+IQnfro0mpXo8o5/z7GL+zGlVmTeeNMfjz6t
         yjuuYO4VOHBMH2eYyMVFkYThJL0/52IhpeIfnJRxJxQnghj400wnytEtb2Rnl6AcXDYv
         C3lCAaL71qH90D6nShpKjmrwe4CAyb7fnThs3vMCuJC7qonAbBybVRqjySEL1ELuYIlO
         9n1DnLosf77KKLsYpete5BcnFSvw7tfYWNG8YpETGXwlSZsXaWvA62v5VUl+jqy5JiIg
         s0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU1Ihjl6aSwBQOD8Irqy68Xb3urPucnfDmO8qH6ZqzpzOPT7BUEyT1KTIrskMOHHLDVSAXgRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHKgI4QjGXlPdYb+tz1EeX14oDtu7JbwuUHlzQoEeXnP0tLUw
	US+px254Hiv9VjMe0vK8MPfvK7BagG5wU+b21Z5edmUIfhvWinictJiIsde2CPX4r1TMleb/5sQ
	SJjAWBNtzXQ2k7NiG3+hzW47mN7KjVuV3CQ5Mda1V
X-Gm-Gg: AZuq6aJkwDJEcWewuftrDV8o4gCl8u3zkjHCkEk/6lTC7Jg2Ti9QHIClSzoH5GQV3rW
	j0qBDe4peNnJY2C51RMmtHLoqfjgOG1iT69eoMPzpq7MTAxzVRsFjJmhuniYtH0OC5LOg+Bi2MD
	uRibcOftLsqdcsJZYBCLi8ALMy+oZBwk5q2G2tygjJ0zp61vBBPmGZk5OWFoIGwsVxP+8tKj3jf
	TLvXpJQMoRcx03IUhGKLpL8P+PVFns2/vwcS/HRpR657V9QY/J/BmPszx1hPSBsMv9KVXpe
X-Received: by 2002:ac8:5a0e:0:b0:4e7:4a3:ae88 with SMTP id
 d75a77b69052e-50314b91caamr38279801cf.7.1769424378935; Mon, 26 Jan 2026
 02:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126094718.1031407-1-realwujing@gmail.com>
In-Reply-To: <20260126094718.1031407-1-realwujing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 11:46:07 +0100
X-Gm-Features: AZwV_Qi1KY1G0mjBZLtwiSOjkFV3kRtQlR1FBt43IF9zwWOkk-bunVH4i9lbafs
Message-ID: <CANn89i+pyHq-jfqoaXpk_07LVCn+REmW1wPTbKmxV7ykZCEHfg@mail.gmail.com>
Subject: Re: [PATCH] netns: optimize netns cleaning by batching unhash_nsid calls
To: Qiliang Yuan <realwujing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	brauner@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253424-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 4FE0987495
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:47=E2=80=AFAM Qiliang Yuan <realwujing@gmail.com=
> wrote:
>
> Currently, unhash_nsid() scans the entire net_namespace_list for each
> netns in a destruction batch during cleanup_net(). This leads to
> an O(M * N) complexity, where M is the batch size and N is the total
> number of namespaces in the system.
>
> Reduce the complexity to O(N) by introducing an 'is_dying' flag to mark
> the entire batch of namespaces being destroyed. This allows unhash_nsid()
> to perform a single-pass traversal over the system's namespaces. In
> this pass, for each survivor namespace, iterate through its netns_ids
> and remove any mappings that point to a marked namespace.
>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
>  include/net/net_namespace.h |  1 +
>  net/core/net_namespace.c    | 50 +++++++++++++++++++++++++++----------
>  2 files changed, 38 insertions(+), 13 deletions(-)
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
> index a6e6a964a287..d24e46c034f2 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -413,6 +413,8 @@ static __net_init int preinit_net(struct net *net, st=
ruct user_namespace *user_n
>
>         get_random_bytes(&net->hash_mix, sizeof(u32));
>         net->dev_base_seq =3D 1;
> +       net->ifindex =3D 0;
Unrelated change (and not needed)

> +       net->is_dying =3D false;
No need to clear fields, whole net is cleared at alloc time (zalloc)

>         net->user_ns =3D user_ns;
>
>         idr_init(&net->netns_ids);
> @@ -624,9 +626,10 @@ void net_ns_get_ownership(const struct net *net, kui=
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
> @@ -636,20 +639,34 @@ static void unhash_nsid(struct net *net, struct net=
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
> +                       struct net *peer;
> +                       bool dying;
> +
> +                       rcu_read_lock();
> +                       peer =3D idr_get_next(&tmp->netns_ids, &id);
> +                       dying =3D peer && peer->is_dying;
> +                       rcu_read_unlock();

Hopefully the number of entries in netns_ids is small, otherwise this
could have O(N*M) complexity.

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
> @@ -688,8 +705,15 @@ static void cleanup_net(struct work_struct *work)
>         last =3D list_last_entry(&net_namespace_list, struct net, list);
>         up_write(&net_rwsem);
>
> +       llist_for_each_entry(net, net_kill_list, cleanup_list)
> +               net->is_dying =3D true;
Move this to __put_net(), no need for yet another loop.

> +
> +       unhash_nsid(last);
> +
>         llist_for_each_entry(net, net_kill_list, cleanup_list) {
> -               unhash_nsid(net, last);
> +               spin_lock(&net->nsid_lock);
> +               idr_destroy(&net->netns_ids);
> +               spin_unlock(&net->nsid_lock);
>                 list_add_tail(&net->exit_list, &net_exit_list);
>         }
>
> --
> 2.51.0
>

