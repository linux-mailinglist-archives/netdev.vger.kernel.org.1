Return-Path: <netdev+bounces-278095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMeWOrH73Gk3YwkAu9opvQ
	(envelope-from <netdev+bounces-278095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:20:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBAF3ED3E2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D75C73045009
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F373D75C3;
	Mon, 13 Apr 2026 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBiaJQi/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA323D9024
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089494; cv=pass; b=UJ3hvAHGR7RMMMg1lXCphnaZdbE50TLQlE42ODW1zLV8oEv084zlXkdoFMwMHI9OhI9QFLUMhFJNE8jLD7jwlB7yQxfjh/DfLfe1pcgl48qKozCipm8iU3S5I01dZxXWBBPhgIESTWB6qZvi0mACgzjWGXRNv/BrAEx5+gpkLOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089494; c=relaxed/simple;
	bh=bT9M9n4XOV8yqBZqbYEWXJ4ln1b1YhEtptjZ4KTGE8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Adn9saBEUNMoaIV+YRrH3uyIFosQALhyv9YO41b6USeA00RhkfDcs+cP6rd5Gx7MYEv+SiOlrfgEwMX6F1sAlBzHl0grPXXsU15kJcTTXNkuukWnUvOuwZgzvK9O6VFjBcMMnd4EwOxXlK6k3Sa8GBA45cJwq0nrlSg8fg4yJ1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBiaJQi/; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651b4d09141so2184422d50.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776089492; cv=none;
        d=google.com; s=arc-20240605;
        b=aFiXgjb1Q7G1VpB9L6T90x6hNLU3xA3+uah4PkuaG1z8wydfcrQFc6QVgcBSAtCzHL
         lfmPoaHSQMEug81NbKSeLsH6RkfxD8DkUuCzvOtO7yWHX1qtULFsAE5tRj9XxfyGiS1t
         nQ14LrBzanwr8Fz8O2ohxR1v4Wl3K0zW9JCb7h4chUhrtRIxwoPCqiFpsr+jh6XTAEmm
         BtGh+x9xQzfy8e9xRpGt/G07146/AGc/Id9SkDk3M5U2WQcfAsfIEmG1VFrGjx5zC9SP
         avYoWv+R637XScI25+qVTnLF3GrLb5wrlLEPxbkAwJHR59F8BDQwlC0RLyAQTb6FgVRd
         2cjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FpnyTQSu4pDMNNPRZu+lnNkKWw5DBBz1SoIVT6Ykkgc=;
        fh=hLkgRsa9OUp7tgdlh2u/yCick2o7boSBcQ/frKpiKL8=;
        b=XhfOu+pQGBkaOfSYuTtwIdQws/N4SCWV0bQWvsNM6sGNu30Imw2Kb17m+JOfj1ToCK
         Y6K8DPmbfqijwaVRaz03mckyFkjqFjgCoVxYwy4K/hxG6O+ZI/pEOWduoCG2uIziyZtA
         pS6KNhB8epDB2bC6daYF2xUp1vGNWN2WewoCNW6+M1lpdZ8sssDOkwIIekgd7NInbKDc
         loMidRQqtrESo7nj3A8ocUUkStTKcf2lNOSClsuJe4XBA6ji/bzkS7DWklzoLerOpkLp
         Q2JDEeZe+dvkGIOdGfp2l7T2vK3UVgLd2iAFATiRLHsc8Mcjg3jxOC7J6igFfEIpYjSi
         6HXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776089492; x=1776694292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpnyTQSu4pDMNNPRZu+lnNkKWw5DBBz1SoIVT6Ykkgc=;
        b=HBiaJQi/htoNJsWAb137bTgqJaIX52RX3s8NFK1+vGL8Y7ypOqAI5+22m3DJilOKgd
         bqWAom8abgETb0pySF7GW/GuI9kiY6Yjuo1T0FwRvvxa0OntVke8xzzUlfEeeHrVReuC
         NC8qsThKsXFdVNkHe+GNbjA4dAc39kLRw1DaaZcCASFPXNPeYORVsBggRcxkxLXvqUh1
         KetDHhD92vht1Lk3VfG8+gHoa137ozLTCPXee1/AaMMa3h1joyJmeB3jj1aOYrT+x7j7
         ffLdoQYoqi07ZVemOTJ3qXKQecUTwQl8ba1/uMC8bNSWiGABzVYP9dKwnN8Jq4Ua0zCK
         pxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089492; x=1776694292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FpnyTQSu4pDMNNPRZu+lnNkKWw5DBBz1SoIVT6Ykkgc=;
        b=P3AQCkJmEcjeRfF7w1ooDpK0nNcgnKZpYlQjh0HVCc18F6jEB1kv5HW/7qe9EESs0Q
         8tWBkQsZnAde86G60AkzUczSrlJ5WCVaiz9ll8ueUjWp6OyeaIvVjhgFo6WXzy98vrX0
         iF59gE0JfXUPofexSR2HMtmc9HFTfvmjHbRAFpBxz9EQWb//Dj58UUQKFdlO4T34lFpn
         cXAfCNt3cVIZ7y+I7ms71zgN5G/1aathYLX/hnNgHgYZ7+CoUsl5YgnDlEehp+ctwIgr
         Fb7fhrb8t2dMfU6PSnREEN8knAdrVnMocn4wQ3Bc+SNBtV6WmT2TtC2xZJKc6Ts1ll/0
         hklw==
X-Forwarded-Encrypted: i=1; AFNElJ8HU3JtDk1L8P0HWYyDeT+9LrQ7n+OaIDZ0yqSYavQDT7E+rrtyIrYcd+WTRBotEIbn1ZBA4L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9nPlxpAVz70H11Ufca50oMll4KGAa2NyewxWPhsc765ud8H1p
	N8dFYZ2sV2zKMGcZ7uf4v6XOM72z6aNjPm40h9bwQuaGZfVdv3nNTxtf7QY6xPHmaaVLCVEbzGG
	cXlhnyFaJ3szV/8bv1VLTMz8p98ickQ0=
X-Gm-Gg: AeBDiev18AX4Y64PwKmdFD7Ll54/9GW/Ki37l6jmj+ySdp6o69HwlPVQ1eylAStBxoA
	LzWNOgumfTG1/WTuwB7QjnIYJydZY2H36PMSxuXapWoxieKIb75PFaKKKjJ5nkQSlR7J51xj4OF
	cs2li+rWDv+EeRzMrM8q3h/t9Dt0fUorwNS2FUItVaSrONCBOyxJYnbEBwmemFnCRgQVewisswR
	c+V10ZN0UrSi7STZUN4QSDDUSNUK/0o+Y3DC33caFpQJ+SoosZ3WZwY11tpQmwsjKUr5LMzSGpD
	DpmOOvOxH9jJoiC36LED/gHMWD+X6/J0h7gR391lcIYqm1vqeX1svszJEvIrxcfNyVWRIA==
X-Received: by 2002:a05:690e:4185:b0:651:d4ee:8e4 with SMTP id
 956f58d0204a3-651d4ee0a12mr1180322d50.8.1776089492134; Mon, 13 Apr 2026
 07:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413132247.320961-1-luiz.dentz@gmail.com> <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
In-Reply-To: <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 10:11:21 -0400
X-Gm-Features: AQROBzC0eEI8SZRnxEM5vEglLMfdTCm_9b7YfdWWRuzp_gnamR7LXYwG1b7IomA
Message-ID: <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278095-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EBAF3ED3E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo,

On Mon, Apr 13, 2026 at 9:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/13/26 3:22 PM, Luiz Augusto von Dentz wrote:
> > The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe43=
4ad7:
> >
> >   tools: ynl: tests: fix leading space on Makefile target (2026-04-09 2=
0:41:40 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git tags/for-net-next-2026-04-13
> >
> > for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd6f=
:
> >
> >   Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2=
026-04-13 09:19:42 -0400)
> >
> > ----------------------------------------------------------------
> > bluetooth-next pull request for net-next:
>
> Net-next is closed for the merge window. I guess Jakub could still
> consider merging this, but unless you want it very, very badly, I hope
> it can just be postponed, as the PW queue is already long.

This update includes quite a few new hardware supports. This is a
resend because the last one was dropped due to an invalid 'Fixes' tag.

 Btw, I don't know why the entire PR needs to be dropped if only a few
items have invalid tags? Can't we just dropped those?

> Thanks,
>
> /P
>


--=20
Luiz Augusto von Dentz

