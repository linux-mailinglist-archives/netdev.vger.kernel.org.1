Return-Path: <netdev+bounces-282062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLi4HS0Q8WmXcQEAu9opvQ
	(envelope-from <netdev+bounces-282062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:53:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E9148B5E5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A90301C8BE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3203AF67A;
	Tue, 28 Apr 2026 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3PHSgoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705A26B75B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405803; cv=pass; b=DGfjA20lYqJLEaNMIzb1/kgU37w4FQ6ItI6MK3SsOeWBW+fr5v7pSqK1UrsU1luL4A67y0X/MxUw4m1Ptqh2f+7RwTJopZ+qlmv0kLzxaxtJXKc1hlOUmR/KpHehoCwVTw6VzOe5ZSjq+7ovYekrrqztf9El5a1gdFtJmhBGN/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405803; c=relaxed/simple;
	bh=lkkR2eve38SCI1I2mEgfjrlEnH6RFlw7GnLvYAL9Lb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqtGhnQXynonDXaAjbc2LfDW4GImnQuxNYlDz+LXrvVv4E5SRY1t3XgheMPSYj+s0ptnPEve/gQegYFuL7qseSf1GJriWUsLBvxFuRldnmEPlPhaBbO6NfgF1ptTyHM0/xYhbaeCmZeYxJ6YQDAAqAXIvDQP4HjE0uKLRKyZ3gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3PHSgoY; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c19d23b19so15492177c88.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 12:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777405802; cv=none;
        d=google.com; s=arc-20240605;
        b=U16ipuIikDygk7OyGU4iENXx8XJwsBwXpjK+3PGSZO6nQv4IPPQ4lZ4fwC6gdpRIjN
         qMuCfDxJ1lBUl9y1LyxEULSk/mJOFD5AIE33vIJb9kkzxQbctZvHL+HM+c5sF2ZoNAm5
         Yb70BlhMc8qCThw55xKHU5nVXl2I4CvN3tgtL1OIrZQfKq2u+B97oer+F2dmYcXcn9G2
         NtfSx+MEwOVVxZlCjZwKZAsfmHE6F7VDl/JGS4xFWP84HLZSPF3uSv6ZSxWOlYZ/qmgg
         3qQ7IYpDPf2SuLRHvbEymazfgCKzZUtDLGfy2eQSU1DDanh91fQUCC1Fkh2NzQ0c/r6l
         kOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zDNF5CMCpZc0VoA04wRmTutNfv47K/RJM/UWNjIMLYg=;
        fh=tcKc4NDw9EgKSLYtxfV4DB7JKTG/Ux0NdG0gwK35ffg=;
        b=A6xbDofuzKuPQMKdYkUUInv3/UQfUPwSTLsQY0eWFx/celVSbpNuzRugvcI6DQIsse
         RO5frs/lFGGFABqnuECqVPpcRfBPax0mNuqfMq32UaJxtaHCjOgJdzgLxsmmYH63Kp7H
         /wku6RmDbFq9Mf4A+fno5D7+Acp/fPZwMj7blsVAz9+N/y+dQvuCM1QPobSQExZJyfwf
         ZWEXmzSEwStqlLjI1KzcvtkRvVdEAACRLlU/PH/MCVKnRVlbZx0OXEFLhNaIeFsJ3cDQ
         sEKsDr9byuQV+oi1WcHsOLSiHhD1GqAjGsTkCbLk6WfOwFWNsXlxBGvyYmq0cuuWnTMz
         fBnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777405802; x=1778010602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDNF5CMCpZc0VoA04wRmTutNfv47K/RJM/UWNjIMLYg=;
        b=h3PHSgoYVv4bndJf/woVAzAWE/honSCfvBbpU49MNWTM0LzRxT1qAMuyWzI1f8Sr+o
         IydRzLGb9NS3CyithdM1rTZNSfV/HjbHgoJs0woXI+2dvA0UPB+Jb8jrGUsLmqD2hRMg
         bRFOiYXgzD1afFm3A/+2LAOdDntxAD0NLxUhX/hkLlqjxRn8hJjdTO3zp+qdp3sVopbw
         8wcZSU/fMI5GW+ZC693C5XGU78Kwps/ONBkgGCdEGvMMVpeln1wMPByjf9pN5Cobdjpp
         DzEbgKwPAzRMRVwyZHdbZQjF4Pk39xNY24bHJd8nJkDnQsvXjOeET9Pwlwv/sTr4FlSP
         eAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405802; x=1778010602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zDNF5CMCpZc0VoA04wRmTutNfv47K/RJM/UWNjIMLYg=;
        b=R+SOWNB7CgvoMJFX9h5cFZXzVPq4IfND6dBYbB9kNwTbWEjeCyFm5wWNdFK0k7PVC1
         2o+E+IMJjEpVdwcylKueKi9hnBrQmWl9cRh8eOasYeSNm8jvV9Y6ICSSB0ZILBq8EpNt
         Dm/4Z58LJidGDfzEe3BMSmGm3TqEq42kPGbwkEW5Rfw1EYf3rD7nRDsnkTaifgBEUFlJ
         92M0rVxeg3RNBK+QezHTTz/VzPXV/Wz1Eyrx57jAl9kSoZ9kp7UigDtN9G2UJ2Ev2Auh
         SSgmPOX6GfKDmuStY/sZOg7IBqeVANsBRa/vrAwWUUibCX92xCcAj6xYedX4T4hjt/U9
         gi6w==
X-Gm-Message-State: AOJu0YzDwcoUYFnSCOj4v3952XWuXXBUqzckD38bQsq3JgD0Om7aqI1I
	AK6yzgt90fn7zwDHvLEPxCqswBagScO65uc9ejjcz83nvkZiYeeGTS+r9fpu4AgLygdpksBOAsO
	ez38EdSyN7O0WYbQ62u2TYtChOuk4ny0FRVMjrAS0
X-Gm-Gg: AeBDiesh3yKG9QGsSm1lnZ8g055vuZAgAnHLslWocw/0Fygpooh3SS/n8tS9xbzrgGC
	LEjsaPsX17rPH/JI8puaWgZ1lNrj/To5apWehbb6iH87n54RE7V5fbEs1Dkc2yJU+ZRWBrEtIhU
	YxyCSg7zc8pqGJsR8bwp0HfXZ1/pRoTfBKkOv7Rs0ZxUw1wsZFfjeWZoqKV3HXXI4K+zQGMM4ve
	CCHHZ4ki5vp77uiu8dgb+RK/nUZ6cmJRIzAJCag7JJQfU3Ug9eBn3r5PxGW3bTSjtlhVAZF5JKF
	6zgUi4xDyxt+Wf8j2vJTKuAlY7NS2h43CmNxygCaXvFSIzpEpdf+tJlpts3SksCKxRVFvttwyzS
	5vCkRX3DymJ+wY88qgARNSYh6PZC+rMJA9pUg16cire8jkP3a10cplQ2wEKXbuO1AV+jW1sfKs/
	NlU/jg
X-Received: by 2002:a05:7022:689a:b0:12b:f616:1a4e with SMTP id
 a92af1059eb24-12de2a59b5emr255422c88.23.1777405800910; Tue, 28 Apr 2026
 12:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com> <20260428110713.2550315-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Apr 2026 12:49:48 -0700
X-Gm-Features: AVHnY4IO0ImWe6cwsS4UMoARRrHG4T4KNeiTq62PUuCzHuYBOHLHnzpJhWhU9cQ
Message-ID: <CAAVpQUAVF4T9G22CBwCTHdsNoK=3ARPKkmS5fAA+su+qDiY4tw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: netdev@vger.kernel.org, shaw.leon@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 02E9148B5E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282062-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,google.com,redhat.com,ms2.inr.ac.ru];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 4:07=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
>
> After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
> ip6gre hash via link_net. ip6erspan_changelink() was not converted in
> that series and still uses dev_net(dev), which diverges from the
> device's creation netns after IFLA_NET_NS_FD migration.
>
> This re-inserts the tunnel into the wrong per-netns hash, leaving a
> stale entry in the original creation netns. When that netns is later
> destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
> slab-use-after-free reported by KASAN, followed by a kernel BUG at
> net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().
>
> Reachable from an unprivileged user namespace ("unshare --user
> --map-root-user --net"); cross-tenant scope on container hosts.
>
> Note: ip6gre_changelink() (the non-erspan sibling earlier in the same
> file) already uses the cached t->net correctly. The bug is specific
> to ip6erspan_changelink() copying the wrong shape.
>
> Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link=
_ops")
> Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>

nit: Reported-by is not needed if it's same with SOB.

> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> ---
>  net/ipv6/ip6_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index dafcc0dcd..38ac14cc0 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -2261,7 +2261,8 @@ static int ip6erspan_changelink(struct net_device *=
dev, struct nlattr *tb[],
>                                 struct nlattr *data[],
>                                 struct netlink_ext_ack *extack)
>  {
> -       struct ip6gre_net *ign =3D net_generic(dev_net(dev), ip6gre_net_i=
d);
> +       struct ip6_tnl *nt =3D netdev_priv(dev);
> +       struct ip6gre_net *ign =3D net_generic(nt->net, ip6gre_net_id);

nit: Please keep reverse xmas tree order, and you can
reuse *t below.
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-order=
ing-reverse-xmas-tree-rcs

  struct ip6_tnl *t =3D netdev_priv(dev);
  struct ip6_tnl *nt;
  ...

  ign =3D net_generic(nt->net, ip6gre_net_id);


Otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks

>         struct __ip6_tnl_parm p;
>         struct ip6_tnl *t;
>
> --
> 2.34.1
>

