Return-Path: <netdev+bounces-292405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE4dNXciF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:57:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 458005E812F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D5F43014419
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D874F40314E;
	Wed, 27 May 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbRMvVuT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6A401A18
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901042; cv=pass; b=Vjl4fNn1eBGS5ur+lx5l2ccAwQcl8kDzj3pD0LGrXPj/wjEAJYc7HQ1XHPTPhvIqv8aTVX4bzP6JaDjSwD8MgzvShAgAbbPYqy2CheNk0WPtkSgvofLRLZhJ74AcxtrXEDYvMnkfXTvi/Vt7KEYTHN9Tmgqt+qXEmmplFWynZmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901042; c=relaxed/simple;
	bh=Z05T0zzuGgs2Dk+zc9G9OUtO21E1+MX7cDPUhUA5R4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAZ7gtkGWcDXCQtQaIEmaTW8VmyLr9FZfVCLxIMR6r8/5vh4vmu6NcP3wxz1hcpHYcDvZRx5HOqiOB33T580yt0B9DHAWL7Fg9vvFtj3U4dkgTxB25w272F7JoLJNIyeuHha/YWULpy9CUlK3HYf/ojNuPZ5Jhk1ZaqzE//dFII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbRMvVuT; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1334825de43so10530391c88.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779901038; cv=none;
        d=google.com; s=arc-20240605;
        b=Ea/3LvkNcxXchcTzQZ2HA1VSRqSgg3yC8LGrCiZjkEAT3oCpAt8U+fqfAUEcXVlPiZ
         sMey3MFqNx4pvbXv7VoP//tXXgDRQwCl6Un9jUH/lYWfvXSJfgJ/aPmxbYCzROPp7/LG
         Se7Sq/d6cqa15JbUjmuGB0ShyNhIYM3hK5rn9UhTOjAV69BQSD9o9LDPkflvJ/WjERdC
         MRq2YWLWdXKj1kjshiLD+WfY9/KU+QwXEShAeYMRS7InWcMRAEDFkLVPa/XTSEQICiK+
         rGaX93ngM2yAZGwSrb50pw4gsvejD2cA2d2FZJyZyjGvfwzNC+hygckC9X9zLKN1rD+t
         MAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z05T0zzuGgs2Dk+zc9G9OUtO21E1+MX7cDPUhUA5R4E=;
        fh=Vr/BxRGs6jvJPyjzldHNomh5Uf4iX8lhStoYs8fhlPA=;
        b=VM0dZl1VZM7HHboaRkNeEcTSaNfM1Bf3pHXYRVWiR5XACr1W9o7AyK0SKD+IpbSp+I
         2F1spXsmsNCm1rvzm4YgsmbxgoKEsK59DcWFRhXJ5BqdNqENeWt1U6k7JCsdLepnCI+5
         Sh0g/E5o5FGLjDOEiyLzquaprHdvCbKy+gkSsSDgy9/FnJ9MwBuB3I7xL7FrF5dieWvg
         z1B4ArUpgvo+HTIoteeK9B+4+/iV08DA283vO4/cHD2yiOO9kFtWpWXr8eD4lmriInzG
         B7+wPI32SkkpnqeZPO34hm0siT47QCI4ogoTBEAkAZxWCfO/qGV1M2cy3DAOfdO5URpm
         oHQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779901038; x=1780505838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z05T0zzuGgs2Dk+zc9G9OUtO21E1+MX7cDPUhUA5R4E=;
        b=PbRMvVuTNN17QWEZFtIoOqYV8hOWpyzMDV2ktnr9RMrVdU4SegvugR5yZnbss3bP4a
         +y0jtC81Merk+3t1i3tucC3k8qgWe0EELjUtlkIpihiyu+rN1GMytwYeQ0Zfl1uCbRiH
         OjaoubTTDB8sUMCcGUnDgAUeOmuabPXUltllUxSSN4w5QmpizzFY2/qp/ezbqoy1TKKL
         VFYW9WBalaSB3ar50bztsslfjeNHYmmQOgi1Y+t/0ohXfNKARCGjLjFM7DXS9X3Rufd8
         NwZRZFkK6jX4E4wmGHgDt+Y7DNwYKVzz4K0HiyohMWC2BdfmpqLc2bufp0EnaLxCEtCy
         qgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901038; x=1780505838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z05T0zzuGgs2Dk+zc9G9OUtO21E1+MX7cDPUhUA5R4E=;
        b=XH8tuQVeQwZSF7oW/nAo53Kek45ZvCSE51BGyDTfVyfuPt2cZ2PRtxftiKPes17a/n
         kJCPGU4xE3O5SbkYKxOqD1vwKH4Xvkg2SqDI+pMufyQT66WE2L4Dq3o3XhWjhq4ivaVX
         oqm3Ax+O0RWNTWGn2S4gMtY5UrpTr78V51zcsaafL6l12rMg4q46uYBOv0Iplq0aNJpc
         CajGvRs+TbR1QXMLmq98DwMoFGHZlrqsBhhZn6RJzqVF6RkQ1k/2KgC/RcI8Sr5TMt8f
         m0bXKOHDz3PmS9UC55u9GSoHbfUTxD4+eR6oTxuTHbG/SHR83VvnNEWglNTgPjZNqCUW
         cfdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XbZFhvEzl2HjbWUfG+jzL7EEGI3EKySzGFm968Lq6yWk6zgga1XQIxcv/YxzEfLTgYBJxZdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4utzx7AJH+Bxzq5OniV7z4DeywRlk207wSFzQMG0FWF2HxBIQ
	UTw1gH9G2tRH0es3uNptk1NRueOZYO5hqH7UjJgzjQI915HqwEHzrh9fu3z08Xac/EUiVZpAWTM
	jPqmV4Y+9Ei4uy8RG+RF+nAo9j+8BA5Pe8ZyuKsyR
X-Gm-Gg: Acq92OG9OgNQh7WYHqBNm7JuqxuJx9WNZdUGLqUDN+NoSkdTyJqIOh05fHUbYdGUfYH
	Dp4d0kdnhIWjh/Cj/qRGVHymjsnuPqbnoSxsHm+JctVxIwlQhiF6O5f//YsSs6d/2pDcng+cq+N
	3WSt1gfz3+y2Irg+EOCbBsjE9Y9LwSSLwk99xRXDz6leiBenrbbpzWguX3cBsoFFvZee+h4Lud7
	1WTGjLnkFbA3WtOly6+0L5gDf5cnRnVztMrGrmqPAb7cYHi1mrEZFeBTCFt9IFA2rch0LCRCFHH
	vwu8EUbecA/LINwRZ6wLY3/onunpJcXc5q50TL7mESWwjCsLqd6cTMuw1l2drPABAfUOV6At+ac
	/HfO5+//wwamavBf9Mbhm1rlBX+wFux2CXPCFa+MWP08NhctKhHHnsdcYZOHJ
X-Received: by 2002:a05:7022:f313:b0:136:9ebf:3bef with SMTP id
 a92af1059eb24-1369ebf3d04mr3012302c88.26.1779901037600; Wed, 27 May 2026
 09:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527070824.2677331-1-maoyixie.tju@gmail.com>
 <CAAVpQUBKHhj6h5Rke=N9NyeUOPvVB0RKJSr2=HPkUKgAqQA0Bg@mail.gmail.com> <CAHPEe=H5SFJN-=EFggXdNreN_A_LE2r_KHrpWU4UxJmq+g-bhg@mail.gmail.com>
In-Reply-To: <CAHPEe=H5SFJN-=EFggXdNreN_A_LE2r_KHrpWU4UxJmq+g-bhg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 May 2026 09:57:06 -0700
X-Gm-Features: AVHnY4KXZJh3_daTaI1GRlZxzUtXao2DeA-jBJnu5zellb47mGZrRVVa7CWHdWc
Message-ID: <CAAVpQUAp8pvg=s0K3QmkN62Osat-kf+4XPosfgbBZ_avzZR04A@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: Require CAP_NET_ADMIN in link netns for changelink.
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292405-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 458005E812F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 2:43=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> Hi Kuniyuki,
>
> Thanks for looking.
>
> > Do all other callers of ->get_link_net(), dev_get_iflink_dev()
> > and batadv_getlink_net(), require the same capability check ?
>
> No. Those are read paths.

See how netif_change_proto_down() uses dev_get_iflink_dev().


> get_link_net feeds IFLA_LINK_NETNSID, the
> iflink lookup feeds IFLA_LINK, and batadv_getlink_net resolves a hard
> interface's parent netns. None of them mutates state, so none needs a
> capability check.
>
> But your question points at a real problem in my patch. get_link_net
> is the wrong gate. For the ip tunnels and xfrmi it returns t->net, the
> netns changelink mutates, so the check is right there. For peer types
> like netkit and veth it returns the peer netns instead. netkit has a
> changelink, and its peer usually lives in another netns. My patch
> would then require CAP_NET_ADMIN in the peer netns for a plain change
> to a netkit device, which netkit does not require today.
>
> So the check belongs in the changelink path of the types that mutate
> t->net, against t->net->user_ns. That mirrors the ioctl side in
> 8b484efd5cb4. I will send a v2 along those lines.
>
> Thanks,
> Maoyi

