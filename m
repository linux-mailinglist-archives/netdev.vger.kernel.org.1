Return-Path: <netdev+bounces-282225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEKyFXx48WkxhAEAu9opvQ
	(envelope-from <netdev+bounces-282225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:18:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B716E48EA7C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7010E30180A5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AE7388E42;
	Wed, 29 Apr 2026 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWW19ZAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F730E0E9
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777432684; cv=pass; b=buCrqWFC45LHMh8sb1Bfx14KrlTK6Ztu6nTzYV0dz1OB+b7yMspOKxuGau7FAyeqAsvrxahqX66DP9dBBdOBJXKVcMDuZONumaFGEFJlg/8ZQ3Fii/2maU02NYVfplydOP1+aKa+Oh93IuqZSCCv7QftWM/ygCMCQGbn8o1V2Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777432684; c=relaxed/simple;
	bh=+9I6BZpYH4ZA17HgMEUnD97sbyGC7ok3QfK96UOaQy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVM7iYjjelLVuq3tAlUfCRRjLJaJjS6gctA6ZftQXMJDqG6MRmLzF2XGKQFWRomjbldZJeFBPgPw6m3gLk1ewu6AglymVTfGcvttU5sQ5hBo6VapojL3NLN7xcUOdSxraRzCD9A0HpnLvWEfZWItT2Z3TOVPtPgNmZfjPbYVN84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWW19ZAy; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ba8472c1613so1756725166b.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777432680; cv=none;
        d=google.com; s=arc-20240605;
        b=Ilh5JSjTTYwYkxjF8AOR3W6nr6bwFrxWhNLeEqsK2z5QkSJmjQ9e0RxQB0hC7DasE7
         wapCZ44lUTbaa++bOc6rQVZ7LQqyAEci5+dZL91Z8+IxUpCSCQ8WSRYL7KSPoSiiHHCe
         7wf4qHp3iDBhCZmkCzBFDCQmSthjc0gYIC8XI9kwjJWGinEEHrrUVdYv5gn8SnBBA4bC
         0yW3Fpdkcs0mIG4EKzbWmmB6F+y2Fx5CZkdr5IdB7kRCODpsyp4d0ccM9FkrNcbz+nDj
         umTazXy7lqfWbWwmf+MLzNCNg0nK3CV+8zqnb45lk8r1V5PhviX0EsmJlY/x811b9RMM
         sUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QxUgM2+HSvGtmsANZ7nKaXzcaQ2hVwBZw7XEi+CfGNA=;
        fh=xYqZzbZo7gkXGIXbZUWrdlEbdtmvlA4A3HGwRevES9Q=;
        b=ZZ66p96AxpLAFhYrPwdvpSrO6I5t++HQoKQgjIWiMeQwMcWCCw6I3uO0GCG+4TdZ50
         Es/LCzUWAycPYAvVZJnCqaTzWMlGvD4EqveRx/VmcZnVfW1YwP8nDWx5nOer+s7TcTEo
         RX+IC03VEmbVUjTHoU73sw+5LkAZ9qMP4SJssUVEF7L+pX9LOL7shkQEHyJVHhgrvpal
         lITmE305Hoh4z1aGDdwS1WsLEFl3441YhhXImO1/769yqqGM4jGD3MXL0f7QC4e2avS8
         qTyeBQchq4ZcSRbgFyPoRjPk+rmIgSgt2BMytow3ycqoGHQpzc4Qz1cbYiKMEV1/oZJw
         6vIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777432680; x=1778037480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxUgM2+HSvGtmsANZ7nKaXzcaQ2hVwBZw7XEi+CfGNA=;
        b=RWW19ZAywl7ed+B6NQbrb6jMh3Hf5Hfzl2FxRUCqD7VomOof1PmUnTRypx7iF7J28z
         qHi4f2xFyfv0lxSn5cEa6DCBqDKxSipCUPnQbndZ6SkEO5Qf4VaOhVTThTc31ZXZ4Gz0
         gKQlT6L6KUBru9HU8J6iJAawvaipZVfJOYYQ2TWLzEMJs8tYAU6teTx20skz8fM1C47P
         x7Ec6YoBAJ2zsOSCS/OcdxJwFDnFU97kSDMpL3ygjs6de/W0tVn8reu8bxRFiUdZMl8g
         3BMpYN/pubBhgWoFJiyi5/kNaeZ9SvI6U8F/oyHRS/xfYiHKcHK76uAgQP+FByoR3JwQ
         bi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777432680; x=1778037480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QxUgM2+HSvGtmsANZ7nKaXzcaQ2hVwBZw7XEi+CfGNA=;
        b=abQKDjYfRMIgkXxwRNl730Dfi4WXISApE1yvdTvevxBOzVS9wd83ogv5bjMsQZpijB
         huXzC18fOVvmnXorUNFzRAs3mPYNdSvstRvaWuLcehm5rvyJAQy5W8KM65zl9tNnUXMg
         x/SVIsDSul+NqykMNWHCTHz1ze7OcjbS4JlnsKigj01Tlgtz7fYeUn7Jrg3cHKV/okJM
         kewPQihCP9gqbWsr5xt6+ur3CkSjmul5vvwN7Z5VG6xFSk/XzxEUK8d237H1kOzfz3Bm
         ImlF9bIe0yGoNlIwzF8nRniTXzA4Ls+B9mbnNBX3PxkW2ci1q8p7nV54hRzZUWlu3Jux
         QPVw==
X-Gm-Message-State: AOJu0Yye39+Bdmpea/hPBeIIx6rrNS+nDxDzCA9cF2nGnmk3i8NDQ8R7
	T0go3cdAwMZs5E5J2VeeNBs5wzCIVCI4+zKthj2uhV0HL2LKUGnSiCBuTTpuIxF/Ww8351uThC7
	c5eJdk34OjTjOgYjndtpz4fTW93mDDGs=
X-Gm-Gg: AeBDiev/OjpHhvfzcSGyBsnAM9/1/JaTA3fk87nTv9uQEmisRgmbG05tjc4CQhsnY7i
	amdljxinBFJxXy5Cnbh5rcgxFjNEcxRI1OdnnjTglEIObtgzMCDB8FILLrndu6aSdwwny8KmHrP
	I5njrRjPrne66/J6nvATx0buKWU7zbVwxL476XLsypwbb53f9/0WxaFk9/38fuho/DFEj1ScfJb
	WKgX8byAJ26AU0rxmqQIw0Jj2NCNQFgisI1Fudar+Gaipk0UnT2vyGaC1mJwCCiUES5iPRrjVrs
	xlkNtD7rJ9OZCXOr5K5x4wYYwAVT3iiKvOoa3lCNkERcX6V3DirTOXX+F4Dp/05j1TxpB058hph
	h8vRDcdgTopI2l5094brA2mdA0VnH9jLVBCFenZD9s5iue7UH
X-Received: by 2002:a17:906:5189:20b0:ba5:8976:552a with SMTP id
 a640c23a62f3a-bb801bcdb32mr259607366b.15.1777432680066; Tue, 28 Apr 2026
 20:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428223058.113013-1-rosenp@gmail.com> <0f704ce2-e936-4bc1-8ab2-144de9e74af8@lunn.ch>
 <CAKxU2N8yb9-M9zELSxdEjLz02GKFZ2mOmgHhc7NbW+oJsvtGXg@mail.gmail.com> <d807e204-0052-4a33-b711-e372c7695023@lunn.ch>
In-Reply-To: <d807e204-0052-4a33-b711-e372c7695023@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 28 Apr 2026 20:17:46 -0700
X-Gm-Features: AVHnY4LvjhRn4RiVI-oALQDpmkPGHnzTYaHvuRa7haCpJwBNgJ0mrIKK1m71FWk
Message-ID: <CAKxU2N_uQaGvsT5zri53Bcr9veCFWzV=_VnddJRdOXBYgoqWQw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: gianfar: use alloc_ethdev_mqs
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B716E48EA7C
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
	TAGGED_FROM(0.00)[bounces-282225-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 5:41=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > +     *pdev =3D alloc_etherdev_mqs(sizeof(*priv), num_tx_qs, num_rx=
_qs);
> > > >       dev =3D *pdev;
> > > >       if (NULL =3D=3D dev)
> > > >               return -ENOMEM;
> > > > @@ -679,10 +679,6 @@ static int gfar_of_init(struct platform_device=
 *ofdev, struct net_device **pdev)
> > > >
> > > >       priv->mode =3D mode;
> > > >
> > > > -     priv->num_tx_queues =3D num_tx_qs;
> > > > -     netif_set_real_num_rx_queues(dev, num_rx_qs);
> > > > -     priv->num_rx_queues =3D num_rx_qs;
> > >
> > > Please add to the commit message an explanation of why these two
> > > assignments can be removed, because it is not obvious.
> > I didn't explain that _mqs sets them?
>
> How can alloc_etherdev_mqs() set them? priv is opaque to the core. All
> the core knows is the size of struct gfar_private, but nothing about
> its layout, where num_tx_queues and num_rx_queues are within priv.
I see what you mean. Will respin this.
>
>         Andrew

