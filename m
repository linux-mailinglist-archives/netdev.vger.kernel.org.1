Return-Path: <netdev+bounces-283346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n026GIZl9WloKwIAu9opvQ
	(envelope-from <netdev+bounces-283346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 04:46:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A313A4B0B4D
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 04:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B173016ED9
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 02:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7246E29AB02;
	Sat,  2 May 2026 02:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq9RcWVO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2225782D
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777689984; cv=pass; b=XgiJMEmK4X95XEesE3KyPS3vg43ZkQz/1yfVv2aJBnH16jwewkbGypMQ8P5ljA9smWaORbVdfQwYiO8ZTCk4epeyICGXPY49ZzzpeWSl10vm9E6YWeMqNnRkvYZpGwLLfzIekd4NadyK/JPtuOkh1qg/bSyK1N+Nu0rpy4hoUlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777689984; c=relaxed/simple;
	bh=i+C37bxxrNimeep7XvQQh0iDQSN83EKB0y/hGNRcYew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0w4Hd26qD3hJESgpsoeHQLL0eWkpq23TRCNAAUnoop1R5Kfr/5sAg2YiAtATSyGypZXdDAsw4piukQMc89cheXmjhoalz81jGKQzxdV65w6yPNoEL7CtPg6gh3Mut+/UofVraji470DGuo3s1K66nR7ayUux0YjvyUh+BnhpEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fq9RcWVO; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9382e59c0eso397925966b.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 19:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777689981; cv=none;
        d=google.com; s=arc-20240605;
        b=LBMf+L819bYsZslBhbsSLnmgBzts27ETYmbMMdu4qJmOwBBlTTQhRKIF3ya13K6RJc
         1oG9ZUKR/tBdcuYcJbbMNlPzURni2TiomK7XpoRN3OQUf0NJLvMQgN9hvC1MJDXoQph6
         r6J8dq2xO1GvOSFSAPscoAhZqtJrCX8gZoRYWNEMLiaCC20x8iDHAE26XXN82hQ4zhQ1
         u+aoKuznDlP/kAKg/Bn/Cj73aBp717g1ox8OcvetShihF7dUaY8RF9DgvEGp3jcvBDYx
         D0XAv8qAhrGFuxaM/Nu6RYbYHtZIrTCB/kheEjJr2QDSOeAcmP0S44xlSc+NQMiWHU83
         r5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3VEfmWrLeAkTkQvRGVoi23Kr7JBgAFO+uPGbKsxaFUk=;
        fh=gJDLmRRmwrzBCxS9hRM/3VIm6R2poZtv1v2/j8Std68=;
        b=E4M1fBbZ9iKD4M1N2EHNYpLFJEPtqVgra14G7TWd7ZeYN7iC1t5WJp31PvaAQsMaGG
         1/4zKboHqZMpVrUaFp8+f2YfoNdfz9gKJ3w7XJDYXH6NQ+PMqIUeaZiUCr9USnH2IuqS
         YxYLZAZtKzoV3q2dS1f5H3NtlevydbHTTSSNNnQWCZtmRlpVRHfZ5ICdgfBDupultvu1
         q/7HkvJ2QHdYH/u2s8w2qm02Zv1CC1o++JzP1mmHqhwFw9+C+D8Tx7we9jmGCs10Xx0v
         kUA/Buf6Z9fUNK36MRde5jec49gueWROr5o8ihxy0jv1sZE7XKcbNhkTNwju8h0XornI
         157g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777689981; x=1778294781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3VEfmWrLeAkTkQvRGVoi23Kr7JBgAFO+uPGbKsxaFUk=;
        b=Fq9RcWVOibeYgTBTCueK+An3Ar473YEftpm0cL57GwHZk2fCAWXFOjEWvvrzIUC3l8
         9w1jMe8gNXz5nnfBcLU2WC2xJmsBpKjiVRZOGGUjySfku4lsdljCkbejsHmq8Haw7RuO
         jaoXSLcibyR9wmtV4+0eIMQ7MVAxRLAdYckXuQ7k4CUpGY7WeREzBbqfGw5ZTF9YPAXM
         obWYBVjZBYJMXHv6rzluymjl876GKDp2sAt0hW/3mrYXNwcU0JBXOX2XBGF1dqnpUXaV
         Pdos2nQZps+MfjDl1DIszZ4+BoBcBg2f3VZzalmRyaNVTQQ7bXb/K2NFn1O6JmrKK+P0
         gxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777689981; x=1778294781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VEfmWrLeAkTkQvRGVoi23Kr7JBgAFO+uPGbKsxaFUk=;
        b=MQ556FBlf/70XzoZhlN6nKvVJJWXaVP0pAl/UNRO9DE3Ht892FanpNq9DfKCc6Ma4H
         0XTUeyfn70JaWSV4cRnOsO3SmDg4rC87r9l/mrUH2b/6bf7AX/W4tQzh67z82xpry1Wj
         2lKGQDzjPKc2xyOGuRRAIF3aoV4mmmNQOHxzn5f1/TBp3FEjf31aNx5z+IehEIhW8Wxm
         yRqDVcBj1FeO54/TQvA/k5DXAi+pNh9g8OAdM7zuRahbLNkvjhy6QafsUQ5kotvQ7Wyt
         UbzMrqDUD3Y1pP6gfsNoyaAYZOXTcYsMXiaujfb0uAT0RGTeocjJtsBzxO7K1unIxoot
         In2A==
X-Forwarded-Encrypted: i=1; AFNElJ83wsG21wjyLssgv5WFRYQkI6/gQZZumqSdL/3otuxtvCu7OHO4IIySHxnzaQFLE7ho6RryAco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGr77kt4uBlSYl6tNwZiGBNi4iGZF20JTgEfnVPAwVlHOac78w
	2Yk7bhQbvadKWBelZ/J7f09opaqVHSpxciI0RwCOkJIgqAuzghT3YBfI4b7LgilShRift2nB0Z1
	nXTJc1KsQNqVKaVvFxynA5cL0LAYyHEw=
X-Gm-Gg: AeBDiesMNqlOFCCcWoPhVevaPPsrO3uBqgP/KznzkyhTK8FnFayGKqR8bmDFrRqMkEX
	VOTvcWg8XX0p2qj9fuUoN5hFZliZ0yno1nB5nCW1XZbx62wnoIi/cPi6kg0u/3G/XTtLSLmzUTb
	x8L899Bb1A6IT0MobuDuOBpsbgg0bxVqozqj/S3B+lI3Te42ySh/TCblbqiOmx5WUyexq1BnWua
	5gKpcIukYAuReZxh68bczQfJcvrZ2Q98RKn5LI35uFqpkg3yQ5pbm8WTyinqaf3crRLn9bSI9IU
	wZbX4UU02m7z1y0Y
X-Received: by 2002:a17:907:9611:b0:ba7:d65f:3b59 with SMTP id
 a640c23a62f3a-bbffaa2bed1mr71833966b.6.1777689980926; Fri, 01 May 2026
 19:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427092923.93901-1-faicker.mo@gmail.com> <20260429011954.1519021-1-kuba@kernel.org>
In-Reply-To: <20260429011954.1519021-1-kuba@kernel.org>
From: faicker mo <faicker.mo@gmail.com>
Date: Sat, 2 May 2026 10:46:09 +0800
X-Gm-Features: AVHnY4Jlu8ujAJMpT3aDlRtG7wjRrCsxS6x-J47EQAKCZ-8lhGIcKjZ2DIIVfoM
Message-ID: <CAG9krM_1baiAHt_0FCxhams3FQYG8HY=C_PhXmLR1YHZWONu8g@mail.gmail.com>
Subject: Re: [PATCH v2] net: net_failover: Fix the deadlock in slave register
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, sridhar.samudrala@intel.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A313A4B0B4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283346-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faickermo@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

>
> > @@ -512,11 +512,11 @@ static int net_failover_slave_register(struct net_device *slave_dev,
> >       dev_hold(slave_dev);
> >
> >       if (netif_running(failover_dev)) {
> > -             err = dev_open(slave_dev, NULL);
> > +             err = netif_open(slave_dev, NULL);
>
> Same question for this call.  netif_open() -> __dev_open() also does
> netdev_ops_assert_locked(dev), and on the failover_existing_slave_register()
> path the slave's ops lock is not held.
Yes.

>
> Before this change, dev_set_mtu()/dev_open()/dev_close() acquired the ops
> lock internally via netdev_lock_ops(), so the pre-existing-slave path was
> covered.  Does switching unconditionally to the non-locking variants
> regress that path for slaves whose drivers use the per-device ops lock,
> both as a lockdep splat when CONFIG_PROVE_LOCKING is set and as a loss of
> ops-lock serialization against concurrent ethtool, queue and netdev-genl
> operations on the slave?
>
> > @@ -562,10 +562,10 @@ static int net_failover_slave_register(struct net_device *slave_dev,
> >  err_vlan_add:
> >       dev_uc_unsync(slave_dev, failover_dev);
> >       dev_mc_unsync(slave_dev, failover_dev);
> > -     dev_close(slave_dev);
> > -err_dev_open:
> > +     netif_close(slave_dev);
> > +err_netif_open:
> >       dev_put(slave_dev);
> > -     dev_set_mtu(slave_dev, orig_mtu);
> > +     netif_set_mtu(slave_dev, orig_mtu);
>
> Would it be more appropriate to acquire netdev_lock_ops(slave_dev) in
> net_failover_slave_register() when the caller is not the NETDEV_REGISTER
> notifier (where the ops lock is already held), instead of dropping the
> locking unconditionally?
Yes, we should add netdev_lock_ops in failover_existing_slave_register
before calling failover_slave_register.

