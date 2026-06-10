Return-Path: <netdev+bounces-297786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ve4rBa6gKWqkawMAu9opvQ
	(envelope-from <netdev+bounces-297786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:36:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE266BFDF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:36:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JTF1fjtu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297786-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297786-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85E34302BBD7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53380348C70;
	Wed, 10 Jun 2026 17:36:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27D145355
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 17:36:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113002; cv=pass; b=BSyTSxhY28oemMAtpzH5arVsSnGPf2pJGWLttYDmjicSAHU8YdfU49gBz/noO3dn/o0PwPkNrmI2BB5dZItCuMHGli7YcfRfdxEu64xFbhhTHV9D3+4R/qg+Go4yUUN8FyKO45uPGIxu3kS9ltQUZxs+xIX0Csrvb38zPjxEJNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113002; c=relaxed/simple;
	bh=W+HaHfdiaWTPO7khRxOsRTAaidjgTeCUmG42LojsTSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPNWQbq5F+48ZhXv14tfE+o5T93g4yIAZvprTXU6FnkptXEK+CsbusLdLQLw8G+v1Yr/rZs9E07tHPOb1cScxa9amdRFq/kqHSUX/NWwqn8dmkdmdN2iV/ISfobGdw5iazYUPd1ACgJvHVMFrXPLFSBAPq10qF1wiXEKee/NPig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JTF1fjtu; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517907feed0so1126511cf.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781113000; cv=none;
        d=google.com; s=arc-20240605;
        b=PB0zjXT4JUX6zD5JQlSYhJAFK6rARYA1giTC8ufg4XYusV0Wm+HcZ6h7ZNMNHOXttQ
         M/0l8ytzhAakKgv1B5IUUvxqg6yIqntA8D8efL+OUHiYlDeSjLpJXpA85XA+n7GR98nP
         OyW+l9Ng9KVHylAfJhsDrgBxVFgrs2qtTcGSvp8jLESEcF3oACGFkeCJ5I5rFPQONH2M
         usEYpyLt9Pr8fy8DSvdHp1fBcz6i9rxqHHn4Z2sSdsUOfmoYI5+5UnXiQ9cq/ZbozEfu
         96pwc7SUb68HXS3vX2xFBbooKVvWMzEAG5ap0YJh57DwxQpmMiUvB/rWaByTZBNxOTt2
         +7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TLLL71e1UzeeZSUeIydWGcAKooSQGq/jDLduosa2qhU=;
        fh=GBa6ZVMrQp8qdZUz5gcr2wgfwjlMENryNh++MsjRIb0=;
        b=PFwOAJd6r6pls8TkBqAWO0WO1/HX8d4x+mO8CnTTEO1blbdPvFj6jQwQoYpwVMZ26w
         qIxd010KQ3xC1zqqDro6N60b7K5hD3uSujdk2RnlTAring7FBWL3lQ8KLr6x5inTCJvm
         oeRRx3jUBySFPyE2DTWIcOD7He0Qw3daH8Xvh9F2OoKXwwHy4qodQxqTY9WU/yXkIMSt
         2pv2nh1/WexWjPCAB4mp8MF5gHjoB2j7IxZFN8/sOfEscQeWEUiL3J2jUGycG5ULFL8n
         yqOMqmR75tufHW0HIfxpPIZJFQrkIHlpZvbzaUzQft6jSdgXfmPKqNJQA1gUO7BkQeRo
         FEkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781113000; x=1781717800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLLL71e1UzeeZSUeIydWGcAKooSQGq/jDLduosa2qhU=;
        b=JTF1fjtuXq6mFFhbSeUgJlKrHn4DyMvMJjC4T/PuKNEdlMOPUi1xalQqS85Jt/LxTY
         tA3kE+fHdKyAIKtR0P3D3gOkPKEK8Qoc9wBkcNNe0NERq4d7dWMsDohuQNGRy+hedIMo
         RiTpjpEUasEuDyb4NkD4AqYk6zhsNpEw5lTB5Y6GI23guDhUUs3CSJL4VmJY3k0uwyOe
         ifmDI+0kxFlGrJbtOlwII5jyk02m8bfZDyhe0+ZqKITnbUC3cocrLmC/zJTnK2pKUrDM
         LSro0Zzgyt4/F1teXIl5T8q7L5WhKSeNgYQqjGNXgEj/8U8vVBqKvFOY0GfIhsc22Pt6
         Gm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781113000; x=1781717800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLLL71e1UzeeZSUeIydWGcAKooSQGq/jDLduosa2qhU=;
        b=Pri+S4OUNBv6+LeP6qgnH88SfAjwwQbqeT43S2j9wMqEbHTs5urUdO2VdTeHIpHnbr
         1d18VEgMY9k4tEehacrUUyRAq0DRcb4mTpBoD+QX4svX7MvPsCQoy3C9Z3vsrjP/LAwp
         A0eUqZSrWiVYbH+QuMmGUkpukmR2ol78r6bwKLo/pe6yXFxsqa/cjl+n6HbMLIeHs3Db
         l6KX7lIsGptdqB/C5mEZdbsq9b4Xc8QoZaG3RhzCl1DX+Tjvz6qrm1zXDF9cUNXNt+H0
         poTDOQ4hDPcg6FqxesZcToJAPDH3BAZuwIQ1redw9k9nq3mvxizMM4ltUL2ct1KnFH6n
         wsWg==
X-Forwarded-Encrypted: i=1; AFNElJ8IQVWtvAFwmrqDdVhSC7fhrD0y+idkTJI96Ajvj+j15jqAguRsMjKcTTr/qdRuvCt3lGRaKZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycd/DoJhQLAmqdjd/OwRfLfyod//xUXm+oIXheyaX9UbfumFAb
	Cey9HJyjd4cHO8swPt/NXxm8+7/KwCw7DNcHrHWtmzxaBhmSp8iDqZeE/5qU5ZW1z+Ue2Mnl2L9
	5PV2UHaVNu+ZM1Ims6iW69JasRDq/Lr28MyDSI4nm
X-Gm-Gg: Acq92OHp7gkPpbFjitIxiONwjBUI/yjAfIwqzUdPTm0al3i/aHDhXf8hddHenAPBIxY
	m1qYbqrGb9HLZvoGYkp1fOV3rTBy2rGU+m9jAgwoV8dQsXIlE6n09h7OYTiaVGS+A9SfuM+YO2j
	rBrgBS9vdErxUVNqO9qoBeayQgCiIogyvffwcoovsz82nph1BcaA0wUv5SPd04yjJxJuPV5TpAu
	XU7HbH1LBeYSoD9dMZJssLJ3OCLU1z3bLieC1LfdEeh5Z10yn6gKGL7ZHzXHr4U9q/Rd1/FLB3c
	a9sLgdk62HGup4sOsdK3UuuUfWNRj7WcGlPaIpIt6CgJNaBxcWbTtDIfvSvx3y9vyR4DVpu0DWl
	4kzSb8l58GtplWayZffPd2fWpN44ndg==
X-Received: by 2002:a05:622a:393:b0:50d:7ca3:379a with SMTP id
 d75a77b69052e-51798666efcmr285921961cf.3.1781112999298; Wed, 10 Jun 2026
 10:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610153349.2546041-2-bestswngs@gmail.com>
In-Reply-To: <20260610153349.2546041-2-bestswngs@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jun 2026 10:36:27 -0700
X-Gm-Features: AVVi8CefsZbgQRR1iD1EJtysRJSc1DMXDHrHSDuvGVOSoCZPfqM5b9mDtIHFJ5o
Message-ID: <CANn89i+Jte_kpkxpXY_0q-zb8xkKLVZYwK++Ea8EK2OQfgfS5Q@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix use-after-free of discoverer in tipc_disc_rcv()
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ying Xue <ying.xue@windriver.com>, netdev@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297786-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,asu.edu:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CEE266BFDF

On Wed, Jun 10, 2026 at 9:08=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> bearer_disable() frees b->disc with tipc_disc_delete()'s plain kfree(),
> but tipc_disc_rcv() still dereferences b->disc in RX softirq under
> rcu_read_lock() (tipc_udp_recv -> tipc_rcv -> tipc_disc_rcv).
>
> L2 bearers are safe thanks to the synchronize_net() in
> tipc_disable_l2_media(), but the UDP bearer defers that call to the
> cleanup_bearer() workqueue, so the discoverer is freed with no grace
> period:
>
>  BUG: KASAN: slab-use-after-free in tipc_disc_rcv (net/tipc/discover.c:14=
9)
>  Read of size 8 at addr ffff88802348b728 by task poc_tipc/184
>  <IRQ>
>   tipc_disc_rcv (net/tipc/discover.c:149)
>   tipc_rcv (net/tipc/node.c:2126)
>   tipc_udp_recv (net/tipc/udp_media.c:391)
>   udp_rcv (net/ipv4/udp.c:2643)
>   ip_local_deliver_finish (net/ipv4/ip_input.c:241)
>  </IRQ>
>  Freed by task 181:
>   kfree (mm/slub.c:6565)
>   bearer_disable (net/tipc/bearer.c:418)
>   tipc_nl_bearer_disable (net/tipc/bearer.c:1001)
>
> The bearer is freed with kfree_rcu(); free the discoverer the same way.
> Add an rcu_head to struct tipc_discoverer and free it and its skb from an
> RCU callback.
>
> Reachable from an unprivileged user namespace: the TIPCv2 genl family is
> netnsok and its bearer commands have no GENL_ADMIN_PERM. Needs CONFIG_TIP=
C
> and CONFIG_TIPC_MEDIA_UDP.
>
> Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash=
 values")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/tipc/discover.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/net/tipc/discover.c b/net/tipc/discover.c
> index 3e54d2df5683a..34dbe5ad10e09 100644
> --- a/net/tipc/discover.c
> +++ b/net/tipc/discover.c
> @@ -58,6 +58,7 @@
>   * @skb: request message to be (repeatedly) sent
>   * @timer: timer governing period between requests
>   * @timer_intv: current interval between requests (in ms)
> + * @rcu: RCU head for deferred freeing
>   */
>  struct tipc_discoverer {
>         u32 bearer_id;
> @@ -69,6 +70,7 @@ struct tipc_discoverer {
>         struct sk_buff *skb;
>         struct timer_list timer;
>         unsigned long timer_intv;
> +       struct rcu_head rcu;
>  };
>
>  /**
> @@ -382,6 +384,14 @@ int tipc_disc_create(struct net *net, struct tipc_be=
arer *b,
>         return 0;
>  }
>
> +static void tipc_disc_free_rcu(struct rcu_head *rp)
> +{
> +       struct tipc_discoverer *d =3D container_of(rp, struct tipc_discov=
erer, rcu);
> +
> +       kfree_skb(d->skb);
> +       kfree(d);
> +}
> +
>  /**
>   * tipc_disc_delete - destroy object sending periodic link setup request=
s
>   * @d: ptr to link dest structure
> @@ -389,8 +399,7 @@ int tipc_disc_create(struct net *net, struct tipc_bea=
rer *b,
>  void tipc_disc_delete(struct tipc_discoverer *d)
>  {
>         timer_shutdown_sync(&d->timer);
> -       kfree_skb(d->skb);
> -       kfree(d);
> +       call_rcu(&d->rcu, tipc_disc_free_rcu);
>  }


TIPC can be a module, what prevents this module being unloaded while
this call_rcu() is pending?

You probably need to add an rcu_barrier() in tipc_exit()

I see three pre-existing call_rcu() in net/tipc, so mayb tipc can't be
unloaded, I don't know.

