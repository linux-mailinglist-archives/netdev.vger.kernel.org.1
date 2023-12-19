Return-Path: <netdev+bounces-58887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6D6818799
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC621F21171
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CD9179AB;
	Tue, 19 Dec 2023 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfAVOdUm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90618E15
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702989449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/S5Wyg/d2+ETYQbWuIm2yAwXlqytm0NKhDqNizGgHY=;
	b=FfAVOdUmNR5VlcU80987/vMInIJUoZeEM3eLoZc7zMGlb7xNQ7234teNhqVSwSbVrsB6lS
	0QuxTUMTc6+Md91oOVhFd4KSVef5/xvD30N0mglpI3QCJE25jFPVFgjnx60Ys2RmZJFZG8
	B2Gpy9ZMOBw+NCCw+w9EnPqbDbvB/aA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-bVF-T4gkMcS1VYXprZevxQ-1; Tue, 19 Dec 2023 07:37:26 -0500
X-MC-Unique: bVF-T4gkMcS1VYXprZevxQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-553360a958eso321937a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 04:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702989445; x=1703594245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/S5Wyg/d2+ETYQbWuIm2yAwXlqytm0NKhDqNizGgHY=;
        b=u1yQREZLBk2kMZdv/XZlUfoFH7YB8ucZ/rAWmQ9vdJXPnNCTjiv+RrTS+kRYsgOTwy
         OSY4vGgsJmxwh5gVlaHx0b2CenLmXU7sZ34bRAa0NgDQFu/YZYB+1LNKPtr2nG+UWt9y
         sOLTN+6x6hDLbiJ+yXhsndvs3RHJeGm204oqJfVFBdus1W1WbRN1Rc8AhPkxifcTTtuy
         utHP1I1ZoWupRtbR7ATDkxUZpGxOB5pH2eU/dFRbyubsEm7rrB7Pr1PkNIZbXZuq3RCV
         jz5OP5n45UjWzqJpkUHgyDW7Ew+1hHnZuD3k9TYcixvqzKaoE6nAXj/hpNLVB6e2qM3i
         KopA==
X-Gm-Message-State: AOJu0YyqOZVW9Gn2tQ2G57wNjpFQ4c/p6kvj6MGe1EKgUzKS+8+2zTUy
	bNL18TzOvlSGXpzeV1xYDrQOhMG9pK5m3eqBZ81We/tlwfJGpP2qTHypZ5lCODALqj05aZFjgF2
	J1+BShxKM2/GpPePy
X-Received: by 2002:a17:906:12cc:b0:a24:71aa:5da6 with SMTP id l12-20020a17090612cc00b00a2471aa5da6mr1058013ejb.5.1702989445128;
        Tue, 19 Dec 2023 04:37:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZB6SNq+WpmOvsg+Tx19853VnfovG9sdUw3oSjC46FmzEMnamyx6F0xDGDCoCX3TteL741Bg==
X-Received: by 2002:a17:906:12cc:b0:a24:71aa:5da6 with SMTP id l12-20020a17090612cc00b00a2471aa5da6mr1058001ejb.5.1702989444824;
        Tue, 19 Dec 2023 04:37:24 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id i14-20020a170906a28e00b00a2332116b3esm3699466ejz.152.2023.12.19.04.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:37:24 -0800 (PST)
Message-ID: <38f6b7856f8060f9770ec0ea2a163c5960d9eed9.camel@redhat.com>
Subject: Re: [PATCH net-next] net: pktgen: Use
 wait_event_freezable_timeout() for freezable kthread
From: Paolo Abeni <pabeni@redhat.com>
To: Kevin Hao <haokexin@gmail.com>, "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel
	Machek <pavel@ucw.cz>
Date: Tue, 19 Dec 2023 13:37:23 +0100
In-Reply-To: <20231216112632.2255398-1-haokexin@gmail.com>
References: <20231216112632.2255398-1-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-16 at 19:26 +0800, Kevin Hao wrote:
> A freezable kernel thread can enter frozen state during freezing by
> either calling try_to_freeze() or using wait_event_freezable() and its
> variants. So for the following snippet of code in a kernel thread loop:
>   wait_event_interruptible_timeout();
>   try_to_freeze();
>=20
> We can change it to a simple wait_event_freezable_timeout() and then
> eliminate a function call.
>=20
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  net/core/pktgen.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 57cea67b7562..2b59fc66fe26 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -3669,10 +3669,8 @@ static int pktgen_thread_worker(void *arg)
>  		if (unlikely(!pkt_dev && t->control =3D=3D 0)) {
>  			if (t->net->pktgen_exiting)
>  				break;
> -			wait_event_interruptible_timeout(t->queue,
> -							 t->control !=3D 0,
> -							 HZ/10);
> -			try_to_freeze();
> +			wait_event_freezable_timeout(t->queue,
> +						     t->control !=3D 0, HZ/10);

The patch looks functionally correct to me, so I'm sorry to nit-pick.=C2=A0

Since you touch the last line just for a 'cosmetic' change, please make
checkpatch happy, too:  please replace 'HZ/10' with 'HZ / 10'.

Thanks!

Paolo


