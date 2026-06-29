Return-Path: <netdev+bounces-302784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fhkdEa24QmrDAAoAu9opvQ
	(envelope-from <netdev+bounces-302784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:25:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B93CF6DE05E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:25:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Gsfvklzv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302784-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302784-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11ECD30517FA
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0263935838F;
	Mon, 29 Jun 2026 18:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD012D0C7E
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:23:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757400; cv=pass; b=G7HDNqA61/tiNXOx3vlMe9JVYyxx2fYEep6HgMRl480x9wSMk5hqmpj2jq1XcH181bWENVBETvn3pVnHjSQU3MxUU4i5PK7bwN1Qz2AJjCGwGFsRgemHyeVLEfS2N0+UNTPXd2oUGWXQ/zqLu7pY4T6XogVnRZK5JvNHcanTm4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757400; c=relaxed/simple;
	bh=0kMhyv18E/s/SZ4DXmnkJytiPYdf902rVtsaGJRhjtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9k84ZxC7VwF7ICAv/knhdCwQ31DcuCPOnPNCSDNWEQAsY/DLYMM2WeTohOnxDsf3s92Qf6zJ2Bu6PmH10UYQ7ra6sIHvUbpg1i7DmUuqULOBMzeNHbKfmiz+fxPjV0HSqGbkbSBbaq32f58f65ky0kHGKErhw5m8DrEWgV0+cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gsfvklzv; arc=pass smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-139b914bab6so4961387c88.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782757399; cv=none;
        d=google.com; s=arc-20260327;
        b=VYyEGo9no68Mittx6LmqCInHNcfSJS6pKv5GLx5ynfxz9VIN0wktFmtfoXwv47r52y
         oAltz/J2HucjXJPhXeDkX90WUiaUZyAIrpkkjw5jAWagAYnPSF/iTo0xJEfP1M4TJLMz
         4dOwwjNe0fgGqJ1DunoF5zdKdyQpKurE+6gzlwwfsPryAekdtdyoPDImEaB4m22vvCAB
         +QhRk06LxUAMKvFDZlNPM8kJ5kyI2XS4gQIv1lHvzVE/Nul392eB4n8xHC+HfFsjN+SU
         zQEXMOqnG0hvH2MRjv95qV7okPxi/2HpCoBHOpal50VDz8wbtYabqxRBFcSLIAFxYtwe
         jVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vOw0rQqEXt5i55zXTGD6v7I1obmXvoCtQycP+cacIvM=;
        fh=mAUzy9Wpf4SYAEjvgxyF4HBbXCQ6od2ZKrNb3oNb0y4=;
        b=Z6Q2od8VI2XIroaPGSw07lqoAb5/hc8KJ/+X2PAn86O5ZNmx7X10XjybMRUbVd14hU
         a/v0soZ3X8Wy9HJBlHtSv8+EAKgu8fqZGbVP7kzcEh0Gro/3LwyAqXsa0RvN71W4Xopy
         Pxt7+z8UP6TUZzM3eiK6b0yowfyu1ljukDabwX/B2bxVFjqc5Gs/ele0ggUVQTXKJmN/
         K3xRx7EyLC4niPAMKdvu4OQJTLcB8QRpE/UWFK4YV9nmCDR4uoxQ3/fIAWMVgAuRF1cP
         d+TrcLF6UYqJpZENxQVqHmrBmb3aU6K+horcT/ZRYHiDHcWsbnZRt+kJBEgocNt1Gb4+
         6oYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782757399; x=1783362199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOw0rQqEXt5i55zXTGD6v7I1obmXvoCtQycP+cacIvM=;
        b=GsfvklzvEsdmASY7x9kfLoJg720y02mz1wQhRFuS34MltsiEOR3dp/Nf2+/0HeMzH4
         kcYU/G1CKSkncVkBiwhrwti6QeSKjilvj43Ml+Ng8omEGB2OlK0YdxqThv70hss4GZwJ
         8m+AmTUtM22sx/emG3OgfulrbeVdRuvPp1HhIuMG5NbEuG8KxuyExBnIV9yhryi8LdL1
         ax8/yzjOj0G5tF47aDBrfgvWeD+J7ulvsdX5wmOleK7dyQUBP93gzMi292JGig0hUtIH
         OaquK/1ait3yvKBV/S5hTPMDPzmi0srjy3YzeJdeIf4ZZOtn9TOFilR7vun+OnWbe3HI
         k31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757399; x=1783362199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vOw0rQqEXt5i55zXTGD6v7I1obmXvoCtQycP+cacIvM=;
        b=QcE5huzla91Br5Oa6msIbh5/55zu65njblzhufFsrCU5Dt1WorxqbJhEierXjz0R3y
         nhX7d6Qo7CqUInHuAgJasMtqMGsxFj2NQaPTlmyfgl/7tXmQddiOlmnFWsrS8+YM2Tgp
         NWHVCWr+OMW2EaUUZLRT2QFfrNI+vRcSjyQeYTs2cnzPlOzLVePrFCRIdXlbZ1/is1re
         ek2pv90KzOsLedSR3+gPCL0uG3H5CC9fgoFnVLLT4Kp3VeoTF0xMFrVa+8Kj4xjx6SOw
         X8GXsuFjYxryfpMOuGHp519GHvQsTBcAuECPBrNhmJLgHesnsu4IjhNREgMzkxjy18kY
         uqsA==
X-Gm-Message-State: AOJu0YxPxQx8Lf1TotyJAmHfSD/jn8Q8igA58EJLE3wsQhoZueDZZVAO
	CFPTPEL9KH4nK1e04AAyrYZ1x91i4HLaoK5H1FNJXxpt0G9SEd7tFv1c5qcqTPDZNMUI+uPS41q
	lr8hHrJA5QQZAxT9wua7B1sahBD+pqL2YTGNOdvYM
X-Gm-Gg: AfdE7ckqfTLpqIHcg4yKawR5xbA254lCkc+n36YMtMqrl5xLA5wR7l6qljar8hdsAsr
	E+MLfu5dDZDXqz9JcFmlYQ8zVkg/ITfKi2rDIROvzVZ6vvKsGSQ5P2FCAWs8+EXYQbDxAcPGKNT
	dG3qnHMcwtBI8xGG2Rt9yfQJDxdrusK+o1aLtXnsYpPo+DQvVeTUkZRJeY+DaCeJr7x7mIrbJQI
	7o3q6RIAAzDMOPBCEUWo4yM5N9TJu1lMgJTccqT1mvMj4cUx1BZyBQElyNRympTROBnB2h0htFk
	6i0DpvDttZfZ3jQr/DV1z9/+FS4quWOOb88XJoCEVDyJoYTd1uo2JEfthJifIqvup1MtXVZ9SZV
	TIxxaNWhyC58I4aNsReaukZ4vXT5oh1VWh2HWLJ2ewA==
X-Received: by 2002:a05:7022:625:b0:138:5049:cb7c with SMTP id
 a92af1059eb24-13b2a1bee3amr287057c88.36.1782757397786; Mon, 29 Jun 2026
 11:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629155748.715754-1-paritosh.potukuchi@amd.com>
In-Reply-To: <20260629155748.715754-1-paritosh.potukuchi@amd.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 29 Jun 2026 11:23:06 -0700
X-Gm-Features: AVVi8CdKWkhz_TIxG2JW_sG4Rd8F2WPYkm8JLftWpC2QolRYiehyUK9angcAF5M
Message-ID: <CAAVpQUADJeSx0njB96i90Upq8zw-pcfZX0HqWkqjcuKm17XZ3w@mail.gmail.com>
Subject: Re: [PATCH] net: neighbour: add neigh_parms_lookup_dev() helper
To: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:paritoshpotukuchi@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paritosh.potukuchi@amd.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:petrm@nvidia.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302784-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B93CF6DE05E

On Mon, Jun 29, 2026 at 8:58=E2=80=AFAM Paritosh Potukuchi
<paritoshpotukuchi@gmail.com> wrote:
>
> Provide a helper to lookup neigh_parms associated
> with a given (neigh_table, net_device) pair.
>
> The existing lookup_neigh_parms() helper is internal to the
> neighbour subsystem and cannot be used by other subsystems.
> Some stacked/virtual devices like bond require access to the
> underlying device's neigh_parms.
>
> neigh_parms_lookup_dev() is designed to be a wrapper around
> lookup_neigh_parms(). The function provides controlled access
> to per device neigh_parms.

Please post a series of patches with the neigh_parms_lookup_dev()
users.


>
> The caller is expected to hold rcu_read_lock().
>
> This does not break any existing functionality.
>
> Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
> ---
>  include/net/neighbour.h | 2 ++
>  net/core/neighbour.c    | 8 ++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 8860cc2175fc..1b3b06eda886 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -438,6 +438,8 @@ int neigh_sysctl_register(struct net_device *dev, str=
uct neigh_parms *p,
>                           proc_handler *proc_handler);
>  void neigh_sysctl_unregister(struct neigh_parms *p);
>
> +struct neigh_parms *neigh_parms_lookup_dev(struct neigh_table *tbl, stru=
ct net_device *dev);
> +
>  static inline void __neigh_parms_put(struct neigh_parms *parms)
>  {
>         refcount_dec(&parms->refcnt);
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 1349c0eedb64..6d32c2668af3 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1757,6 +1757,14 @@ static inline struct neigh_parms *lookup_neigh_par=
ms(struct neigh_table *tbl,
>         return NULL;
>  }
>
> +/* Caller must hold rcu_read_lock()*/
> +
> +struct neigh_parms *neigh_parms_lookup_dev(struct neigh_table *tbl, stru=
ct net_device *dev)
> +{
> +       return lookup_neigh_parms(tbl, dev_net(dev), dev->ifindex);
> +}
> +EXPORT_SYMBOL(neigh_parms_lookup_dev);
> +
>  struct neigh_parms *neigh_parms_alloc(struct net_device *dev,
>                                       struct neigh_table *tbl)
>  {
> --
> 2.43.0
>

