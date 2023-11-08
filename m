Return-Path: <netdev+bounces-46580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFCE7E5145
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 08:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45C22813CE
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 07:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83FDD2EF;
	Wed,  8 Nov 2023 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rro5imfK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AzsxTUEV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA7D2E9
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 07:41:38 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5F1706
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 23:41:38 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1699429295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JvV0BBV98ILtpySlH9Oy5VCvWdR00btlLeloaBlnNPk=;
	b=Rro5imfKbpyGNO2QI7p1EbzRmMa1jAcE/6ktJe3prM5zfB8FbtlXRmrZwEdKCnlnEgGtMb
	955LX4+LLPr48YVy7tV7guSEDx3JvD/9bw0LHBmWoIpYKxYw6nQSsfWVG7ilvJ2iHGFU5x
	72zL16thJCeCY93depqNLSLBBa1wp4tX3pgaDIRlKUfjL48Ry3+TN+KaM72DnCqVkTDiNo
	DsvxwR16+RDJYfD+nt0dSQHe2DE9ji9/+sv3URuSbtS1chE2dz0tOGSq+mvQLxFKvm+zRc
	SXMa1Dskfs9J7M475Ts7XjGnoq9Br+sZHw1YpqJ+yvuyrlPGUNrOaCpagrPrGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1699429295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JvV0BBV98ILtpySlH9Oy5VCvWdR00btlLeloaBlnNPk=;
	b=AzsxTUEVui+m87B8FzDkQqF6IEZUg7h7BzaNt2WZGkNGD+bquyueuCwsHIWncpA9s+A/Pk
	/E4vQ4yd87pHYYAQ==
To: Florian Bezdeka <florian.bezdeka@siemens.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, jan.kiszka@siemens.com, vivek.behera@siemens.com
Subject: Re: [PATCH net-next] net/core: Enable socket busy polling on -RT
In-Reply-To: <fc7fb885df3a52d076bb71191afa786d19d79cd5.camel@siemens.com>
References: <20230523111518.21512-1-kurt@linutronix.de>
 <d085757ed5607e82b1cd09d10d4c9f73bbdf3154.camel@siemens.com>
 <87zg033vox.fsf@kurt>
 <fc7fb885df3a52d076bb71191afa786d19d79cd5.camel@siemens.com>
Date: Wed, 08 Nov 2023 08:41:34 +0100
Message-ID: <87bkc44rpt.fsf@kurt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hi Florian,

On Mon Oct 30 2023, Florian Bezdeka wrote:
>> > > Allow RX_BUSY_POLL on PREEMPT_RT if NETPOLL is disabled. Don't disable
>> > > preemption on PREEMPT_RT within the busy poll loop.
>
> Sorry, I need one more information here: We try to re-use the kernel
> and its configuration from Debian whenever possible. NETPOLL/NETCONSOLE
> is build as module there.
>
> Will this limitation be addressed in the future? Is someone already
> working on that? Is that maybe on the radar for the ongoing printk()
> work? (Assuming printk() with NETCONSOLE enabled is the underlying
> problem)
>
> We don't use NETPOLL/NETCONSOLE during runtime but it is enabled at
> build time. Sadly we can not use busy polling mode in combination with
> XDP now. (Ignoring the fact that we could adjust the kernel
> configuration, build on our own, ...)
>
> Would love to hear your thoughts about that. Thanks a lot!

Yes, the busy polling conflicts with netpoll due to the locking. At the
moment you have to disable it in the kernel configuration and
re-compile. I don't think anyone is working on solving this limitation
yet.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmVLO64THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpe9EACsA1Ztrm3UbfQhG+IvHsd0kuvKTQ1y
rKlGmGl4XYhtDCISkvEqbVSYfhlpZgTDKXgbUccGZXWsQ81CJHVchEk5YAtkM1Qx
xGWOWqqBbIYJWedznJ2kl7Zj3xsr4djI+K20vYt9nuDPOvjk1/HbZgsSwhZEiLoC
9s3bCkdPnMD0kpdYv0wqsi7d4zhhigDT7U7zWbNPLSet2WdPyiT1sThHp9h44YCH
OFhTXapzo0tHO8o7TF7ZJluJ1qUZe2ZW+M/WRKy5Q8QYjZiuWZiH6BF5vU2Fs5zr
ameT+FJW1tc+kTHqBGayE4NNDXFK6Dq+xwYVsSaPZw3SyWqelzaJfccQsEdUNIng
T1MadFGpRJik9imaMfzJIIONPpo5cGb0ywl18r9yL4t7D9j/anWXtlWoYXYL+W/Z
q2jnpfmSM9WYo8c0EpXlFq0ZvAEOaNuXjU+EJbYe1qfEnsu1iBzFMCZ71C3hg+1a
4KvzmhooUeCJWLbX1K9ufB/CFx7XoEF5TsoqSLkb8xx2DpJHrXyWTIaRyy8tL3H1
SkpP+Hy5tppow/tF56X/yMSaweh9CkT8IpWpYDnwzxLHY4pzuoRlo622cP7VNvTl
nM/ElLCzBLDUSHi6OMZYLg3IqcWhJelT7nnkH7SKlGiDwldgzHmnQn61KQF/BVnM
EQINhP4razNCqQ==
=Xj6p
-----END PGP SIGNATURE-----
--=-=-=--

