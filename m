Return-Path: <netdev+bounces-255035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OwoIDhHfGn8LgIAu9opvQ
	(envelope-from <netdev+bounces-255035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 06:52:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE214B77F5
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 06:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D33F3300B9A5
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55A378800;
	Fri, 30 Jan 2026 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TY8iiiUX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6662874E9
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769752372; cv=pass; b=KN8Ndzaa4tWb1NIuv3ZVNTR9pGHrWMN2s/vRsITFZ0ML4hMFao/r2TSFNprqc3jtWvxh7J4XTST9ZXVK+L05Xtm4XenY+nvAF7RLLVqXzxihQ43FGnaM+ZLlYY14q8VXUnOe2vvq0Lwq8G1lWh5VD8986hisA8C9Owsd/SlPTeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769752372; c=relaxed/simple;
	bh=cImNh7AmhiGij1+ZhirVCLP6mOlNdsNdkU3maKdeREs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guMfrVOQeJwinJ4QyG2XxoDNJfqCgbCsytZgNQAjIg+1xAv9Uueaxdyjk/9SF/jLsY3kH0Z7fPz0j4XhKWWp9zqNTbZRXqj7Bc6xArPTxbkIVUTvJ9ab0hUdWWEcq/sqkbG/crqRFxhr9r90tCk7oKihQ23cFn0TCe3cnhZE+8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TY8iiiUX; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3598506eec.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 21:52:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769752371; cv=none;
        d=google.com; s=arc-20240605;
        b=ATTd5DHCJyNqcmwKjdTNPY/pP05FGw+HIabP4ml23zZSSgCZPFaD7y4o9+P7aDGXXH
         KZIvv3I3H6uTi4xFD49EotDVPrB4IjWp0fSUA+YhsOO5PgLfh3k2W2vAWwQBSF4KsxWP
         hfrFzQ68Qwly3xKmJkyrPA1Q8ho3qB8cMxo2b1G4bMA2IIHStRRBywCib5hTY/8k5vGO
         1yargR8Md9Zu964jm13iQgg/VWz/Y31aW0qkQiHnbyrzx7BPQZZBS0EW8UyoShVRVxXS
         pYkhvxBvD6OJnKzTZgjUfcpoMmFfZAJ/HpfJD5gNxaFDKn35EH8y+QuRzMSd5YTPEsin
         cIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LK2IkLpd/Wbh+zexSYrqMfHibZjGlnJWNUHv2HZ4Dtc=;
        fh=KE3iTbuyjwI2xqVf3EaQolHM0xidMVTSTJMsvxBHRns=;
        b=DrYmZcqrFRWxfvFew/YT4/HogWtw2fXAG+GXrvMuGkRxwNqEkvlNPp9JZNaHNKKR01
         JHUs+9HLFPCApLokE7AcZt+TOrXdhp/Cy+t8RSbI2cjopsglGX++neI0n8HhZGad1D+N
         Z+Mgjp9pzF2MpAjhB9DXatNMaaGnlBI3m5c16d02E/f4xi8LVlK9brNNkm/dZ88GPKBV
         0HSdNldigdUGcHqSi/IUogRvmVdjvkdbaTr8hpm1ARZSrVNWbOvYBjTyyc9hXQPlBELr
         AHa7gXs22Q9z1FGGmNk6TcPU4QEkNVB6sC2x7Tlrr0gQbdpAjLZVfUgbslnHjA0WXnik
         k4aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769752371; x=1770357171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK2IkLpd/Wbh+zexSYrqMfHibZjGlnJWNUHv2HZ4Dtc=;
        b=TY8iiiUXhYx7pzktm2+ph1CqQZp88S/t3J0DbM0zObe+FWmMlBQsAEcbEp/Pd9rDPz
         NfsEs/Zl8KTK0p1Vzth13kPByHZobOPB7SGSyGGjiV0yhdMDryl2QSUWv2k2vchYRC0v
         gNgnPpy65WCvl8TJosmSH63w49BA6DzUj+PglRS1Q1BU7ibHyXSuGjozTJ7v6Y8pmAtv
         CcsH9zmTdUGMctTv0O7uTDX6Jfqbgh56EsoeUCckoqcjbHwNYxcHje4S59QEsZKwdBuU
         FGXd3KrXhqvWMYLl264Je2x+sWudM4GwfJxKZJ8HYUrllMSLE64h9AIw/gD0gyidu3v+
         wk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769752371; x=1770357171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LK2IkLpd/Wbh+zexSYrqMfHibZjGlnJWNUHv2HZ4Dtc=;
        b=tAqPJyj/iMkTygFpeEdm1MCBBki3H2kdvCJCj6VOmS8U3N1dGGQ77JvUh5/kfdNJq1
         G2mRqvaaYBrNaAiqGFo6BavE+l5dUKmaWV4VJI/HOxdEhrdTuDN+D+hVEQ/rJPw8tzlv
         I447abwqthIbShwH4HVKOIKt17/CaskT3Q/55iaj6C5ZRyydAMlUs7cOkjlyBa/aeYQK
         y4fQpw40nu7ytlMPIVLImY74qZlbOO99gVgiTqqJK529OVogm01OgaQ19g3jg4W++hOo
         p4HnJ6PNF3zjcy01cBvumd65SKLEEFMHo0lsteHyVQQ83uyo3yWOLYobpgrjEuMzYWi4
         1OTg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJTeZHjmR7E5jYTMoxH4IbxUYvmOvmelrgkRXjfPWXtG5M7gzOEtbeE571ENTye9RroS3X4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNoBcICoY7+Nxhjlh+GJtpkYZBKGefTQJAL5FoSpXQofaMDxl
	JVsjFunxguShlH1cmPjP9PPu0hKWYIcWtd33TqjIJ2LDd5Ic8CElH3Lw0t6iPV7wx6AjrdRWSlM
	LnK+bctP8AAVALgw2MWOXOIhjB6s2h6dcIaqeh9cv
X-Gm-Gg: AZuq6aKCObNaRLxmyNg3LQZfb971nN6wDTuKVkLXIMxOM3BvdRqO9XEfN0o+AXuM608
	rjqESa6TYfUIjQjtyYo28xdqfCAHeuzXzh0UKb4xMMnRqO9PyaEOp16DRwUdm5d4/PW32Cn4vXn
	bmT2bX3kvxv+ExmKittK0re9OL2cyrVgPm0wTAuGEnWXEqNJBnBYC7gj9S/t8o2eeCUaxXVna1E
	p07frsD3kOxxCviPfMQGWbdlkexAiMcIFGhJADi/anRmBlFgpBkFpnrohX6YOIQdnhAgebOomqx
	iQB+qIT44AOrZZaFq7Ds6H6HLK0mlUzSIz70Vl12/lhbqRiOoaZFc94WvRc4
X-Received: by 2002:a05:7022:660b:b0:119:e55a:9be4 with SMTP id
 a92af1059eb24-125c0f11b1fmr917664c88.0.1769752369932; Thu, 29 Jan 2026
 21:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130022951.2489133-1-realwujing@gmail.com>
In-Reply-To: <20260130022951.2489133-1-realwujing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 29 Jan 2026 21:52:38 -0800
X-Gm-Features: AZwV_Qit5baUTntB5XVo6dAP8yeD2I3uUuzuZ1pgpVF_gKNdlQtkp71tMpLKJWU
Message-ID: <CAAVpQUCb9nuY6eDvqePYQa1V9WCfQsynt1UswC3vqBTUOi779Q@mail.gmail.com>
Subject: Re: [PATCH v4] netns: optimize netns cleaning by batching unhash_nsid calls
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255035-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EE214B77F5
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 6:29=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com>=
 wrote:
>
> Currently, unhash_nsid() scans the entire system for each netns being
> killed, leading to O(M_batch * N_system * log(N_ids)) complexity.
>
> Optimize this to O(N_system * N_ids) by batching unhash operations. Move
> unhash_nsid() out of the per-netns loop in cleanup_net() to perform a
> single-pass traversal over survivor namespaces using idr_for_each().
>
> Identify dying peers by an 'is_dying' flag, which is set under net_rwsem
> write lock after the netns is removed from the global list. This batches
> the unhashing work and eliminates the O(M_batch) multiplier.
>
> Clean up redundant nsid_lock and simplify the destruction loop now that
> unhashing is centralized.
>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
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
>  net/core/net_namespace.c    | 41 +++++++++++++++++++++++--------------
>  2 files changed, 27 insertions(+), 15 deletions(-)
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
> index a6e6a964a287..9ea05fb9df5b 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -624,9 +624,29 @@ void net_ns_get_ownership(const struct net *net, kui=
d_t *uid, kgid_t *gid)
>  }
>  EXPORT_SYMBOL_GPL(net_ns_get_ownership);
>
> -static void unhash_nsid(struct net *net, struct net *last)
> +static int unhash_nsid_callback(int id, void *p, void *data)

This is called without holding tmp->nsid_lock nor RCU.


> +{
> +       struct net *tmp =3D data;
> +       struct net *peer =3D p;
> +
> +       if (peer->is_dying) {
> +               spin_lock(&tmp->nsid_lock);
> +               if (idr_find(&tmp->netns_ids, id) =3D=3D peer)
> +                       idr_remove(&tmp->netns_ids, id);

Also, is it safe to modify idr during iteration ?


> +               else
> +                       peer =3D NULL;
> +               spin_unlock(&tmp->nsid_lock);
> +
> +               if (peer)
> +                       rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL, =
GFP_KERNEL);

This may sleep, so we can't call this here.

If we want to do batching, we must remember for which
net and id we call rtnl_net_notifyid() later, but I'm not sure
if batching is worth the change.



> +       }
> +       return 0;
> +}
> +
> +static void unhash_nsid(struct net *last)
>  {
>         struct net *tmp;
> +
>         /* This function is only called from cleanup_net() work,
>          * and this work is the only process, that may delete
>          * a net from net_namespace_list. So, when the below
> @@ -634,22 +654,10 @@ static void unhash_nsid(struct net *net, struct net=
 *last)
>          * use for_each_net_rcu() or net_rwsem.
>          */
>         for_each_net(tmp) {
> -               int id;
> -
> -               spin_lock(&tmp->nsid_lock);
> -               id =3D __peernet2id(tmp, net);
> -               if (id >=3D 0)
> -                       idr_remove(&tmp->netns_ids, id);
> -               spin_unlock(&tmp->nsid_lock);
> -               if (id >=3D 0)
> -                       rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
> -                                         GFP_KERNEL);
> +               idr_for_each(&tmp->netns_ids, unhash_nsid_callback, tmp);
>                 if (tmp =3D=3D last)
>                         break;
>         }
> -       spin_lock(&net->nsid_lock);
> -       idr_destroy(&net->netns_ids);
> -       spin_unlock(&net->nsid_lock);
>  }
>
>  static LLIST_HEAD(cleanup_list);
> @@ -674,6 +682,7 @@ static void cleanup_net(struct work_struct *work)
>         llist_for_each_entry(net, net_kill_list, cleanup_list) {
>                 ns_tree_remove(net);
>                 list_del_rcu(&net->list);
> +               net->is_dying =3D true;
>         }
>         /* Cache last net. After we unlock rtnl, no one new net
>          * added to net_namespace_list can assign nsid pointer
> @@ -688,8 +697,10 @@ static void cleanup_net(struct work_struct *work)
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

