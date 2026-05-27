Return-Path: <netdev+bounces-292218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJJzBP+8FmqHqQcAu9opvQ
	(envelope-from <netdev+bounces-292218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:44:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA585E1FB5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A00330160EB
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB423DEAE3;
	Wed, 27 May 2026 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbRBo3sk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE83DC4CB
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875016; cv=pass; b=T8RxeSa2cyGXl5DuWkCXDUiYJNqIvfgwEatqJ0GwjP5xdUraEWdnE6ivpNww1cpBT/yK7foLd0k+HvbKZ62qRrREgKUBIv6pTQoOKpH7fu3FlZj54RhWelgRGAg63qGRkMu8pcqL+wDn8wWFFWYvvi9rDF5HXbKqybOMB0SdcP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875016; c=relaxed/simple;
	bh=Co6EHUesoW6BWBk60jtMfwAVc9623LbALcIYwj02eos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWV1VZpDtrHu9zBtIggfMuUoTWhWKc3ZC48Dk5sjxAAVVlEP6RfEBIUE1TZsBkFX2vnnE6wLPAflwe0Yt0oWfYUlmZxuV0eswSKiZb+eJHruQft/YU97jjgEkNZFUgmdzJvnmJAgCaz5SMabroujTMUB6+yD6FRfU05YhqzrX94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbRBo3sk; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so7025731f8f.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779875009; cv=none;
        d=google.com; s=arc-20240605;
        b=jWZi+dklRqduSG9oDbwGCkpaGDQL0QVvtC9IvaaUTHi4puL+Mm5AYJ2MYdufbyJFHi
         /NXQvwEU2OjXu9OlJv9pMIPTywFheU5X6X+GZyDOmxEQ3jojbiQ1m8gZIK0JgINNP6zM
         Iz7f0sBvxOLeSc5Fx0jir6HH0vOxKNbUvCkVUph+P19VSBYT/Ug+a8yCZuSvbh5gqN0d
         WPIM0SlASJTfQpORpb3VS5a2IC/uEo9ijyCdm4R1a9HvAaTvrV6tQsOZkho/X8+KQ7Ek
         gOo5OWjB81QEI1lN38iCgtGcGjubywT35P2f8L/PxvuG8pkLCd3ziC0MoFj58oQvkhnP
         Rakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Co6EHUesoW6BWBk60jtMfwAVc9623LbALcIYwj02eos=;
        fh=6cGqeU1U9fwCjL1OPqz4w7fmd/1EKVxM54XZdF8UBLs=;
        b=CjS5o1Gd7s7x1S1zDIIdX7/bFPdyUZZysInwII9urJ5zvCpIiAyCLCkqgFox/4bySa
         0LQYz2Zqt6fZOGZlXR7QDOHo2VLy+TGO6MnL8DpcTE3ersoabmdo5J6eLAePQn/M1RDo
         hySOACCoJ4KEPcRyPon74Q8XcrV0PCtjT8mTCoLLwdHai88qhsul34bpU/NHJOdkLnzy
         f7mLcgsccM/6VAQ/hkZgd4gNt95eloUgSVCr32zKSBy50Ks1RLcnsQEoeaKnfsHO+tir
         d9Mmb9AqM32qF45ABefTTaPpvOsJ+Q9VNVTqsz745dX45mSUOhyCDMWnwi95QHWeuikH
         sSyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779875009; x=1780479809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Co6EHUesoW6BWBk60jtMfwAVc9623LbALcIYwj02eos=;
        b=pbRBo3skRjG30PmujBmapUFdwcbta8xusdv7/j0x3HLrPYqwvR195Bo5cUaKHaWqyu
         m4vd9uJ3sUI4IJoydPZaCDQDPFagFpXmodO3g2S+iAS2y12Ao2vyplMPKUTDA5WdxScF
         V/pH7LzmjA5QoJCTeKDJIxeTSgCDjL2xeCXCVqE3dRAeEcMBerR7kGLNHcqcC2NnX4nD
         H/UGTi8JS7zmM2mEYRFINcG/VV5hxdJ1ACW/u1ayF5N6xtPU/7BtZsQJTbt3NShfwm2r
         nNe50cVPBoKhSJMzjLs8P8Kg4JS88XxM6tVlG54VeogqRWmTVQ92vvPSqn92hginPWCm
         dJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875009; x=1780479809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co6EHUesoW6BWBk60jtMfwAVc9623LbALcIYwj02eos=;
        b=l4iHnp8WcUuphSFCfcJ9u19cW/Abmui+xMPev89Je5Qfls8ZBVqC3zgWdKTsTp1NjG
         ejls/OOl1WDfK1Feziqy7SScsxhEUCQ6BO/12d16Q3nMibPBTUyC3wzm69Wv7gl1t/RB
         fkq3xn5UZ+MJ4/MmYkbb0BuWQnoeHh+vXWudyd4FyhYNDzSZMebAAV8e5J8FmXGXMuWN
         fRi5IApDQixl1jetm9hbMqDAhER6w476adfSrf8jsg9+0PCALNn/lARmr/lFF7ltcAFV
         BETXr8qspKmjGWMk4JBH/aAHhDXPC/zXHvLp2y/juFzJPJ7So3WHu1vGVND4Ar4ukObB
         1P9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9C3qt1VGCev5uv63XQOOhsfaCmqfUt83tJRuhhYdyaruL4/aX31n41ZKeM3oCYM2v879LDhp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUiwhI69Tr0zybqzzb2deszDaJGKM8waP0RJwDqi91SDB7nFm
	U0FIBUCAW+sveSNSmZ1bkg8RdHlW1Dvteo1mQuGqFYM0Ctt6mAWJfIaeUhgm4MI65Cd+Lx/RCHp
	7QeFWyxMsvEp8wm6ZNuEH0Ov4gAp5hao=
X-Gm-Gg: Acq92OEROYVwrTZ/dLxlFP/1d/P4t49X0eFy4imS4inKElTfN4mJdQc2CBrQMLMWPSp
	Bx2W1jXxba3ibM27EesV3WAe6VU4RKoDcAqQlwXTmONX9XVzMxqtcMnYNd0s6cQrL951F+S5uT2
	RHby5GH6KmlAzmJI/QIg25G7imto1pcnUzF36nYzo72yrQ+tu5QcA9HTvKkeZBg9N7drsPCraD9
	uC8nizKSwN/YwB2rHVfnrtcNiKxPea2FRR9jN5kFmfe01SYKoXeQ7Tzb7XPRvHyBh7+1l0rBXuQ
	x7ATPn0WjG7uWpyc5BM=
X-Received: by 2002:a05:6000:4a09:b0:43d:762e:76c6 with SMTP id
 ffacd0b85a97d-45eb38a7f6fmr39074764f8f.7.1779875008738; Wed, 27 May 2026
 02:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527070824.2677331-1-maoyixie.tju@gmail.com> <CAAVpQUBKHhj6h5Rke=N9NyeUOPvVB0RKJSr2=HPkUKgAqQA0Bg@mail.gmail.com>
In-Reply-To: <CAAVpQUBKHhj6h5Rke=N9NyeUOPvVB0RKJSr2=HPkUKgAqQA0Bg@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Wed, 27 May 2026 17:43:16 +0800
X-Gm-Features: AVHnY4LnyhgAhekb1Oe672L5X-bWeTtJyQT5uTBldYwiDLPpoTVojrMYJ7auvMg
Message-ID: <CAHPEe=H5SFJN-=EFggXdNreN_A_LE2r_KHrpWU4UxJmq+g-bhg@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: Require CAP_NET_ADMIN in link netns for changelink.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292218-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7FA585E1FB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuniyuki,

Thanks for looking.

> Do all other callers of ->get_link_net(), dev_get_iflink_dev()
> and batadv_getlink_net(), require the same capability check ?

No. Those are read paths. get_link_net feeds IFLA_LINK_NETNSID, the
iflink lookup feeds IFLA_LINK, and batadv_getlink_net resolves a hard
interface's parent netns. None of them mutates state, so none needs a
capability check.

But your question points at a real problem in my patch. get_link_net
is the wrong gate. For the ip tunnels and xfrmi it returns t->net, the
netns changelink mutates, so the check is right there. For peer types
like netkit and veth it returns the peer netns instead. netkit has a
changelink, and its peer usually lives in another netns. My patch
would then require CAP_NET_ADMIN in the peer netns for a plain change
to a netkit device, which netkit does not require today.

So the check belongs in the changelink path of the types that mutate
t->net, against t->net->user_ns. That mirrors the ioctl side in
8b484efd5cb4. I will send a v2 along those lines.

Thanks,
Maoyi

