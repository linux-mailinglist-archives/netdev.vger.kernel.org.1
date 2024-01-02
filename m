Return-Path: <netdev+bounces-60850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE58821AD0
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FB01F21F2C
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3D9DF58;
	Tue,  2 Jan 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLRDXcrB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B0DF46
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so94700a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 03:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704194460; x=1704799260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi6BMc54YIIslZNdIZM70wAXFmR2UViyvD/iVOGtUtY=;
        b=BLRDXcrB6oM2aTuTfYy2xHHBPbiUq0lD+q3gZ8/JVaCflrAHIKMWB5JzcdcnKaHL0h
         AiW7m0oaAFJ4fyRhqSYOCArrvgYLU0jLvT/pyGhvmd2bJsgQcv33vZ3sCH2YmhVnhlI4
         Y8AFmdwyTDQGUVkAhlH+YXxy3A4Ryvj1poBEiQMUZzw9ynzKZKWVWNzHRqr9id5lCnk1
         ANfQZ3XMGzAzEtJSu7ZF2SC2fbhPHYpK0a4p0LtaSLHD1606vIWwP3Bf8GqOrdiKxr+B
         FaFzZPLVVI5fzAjOsW8qEo7TB+dUFaD5pInyhL8/vgrGx7E+jJ/P8JuzjOhRFcMGt/2X
         ndLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704194460; x=1704799260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gi6BMc54YIIslZNdIZM70wAXFmR2UViyvD/iVOGtUtY=;
        b=dULG9dYFXumS7gDfHCdkf4aHOa9kuTFUc3GJljq1hTjR4JTv0J9dqBDI2KQGfxtWK2
         DvTSSifuNlETXfHRuBlnBOMZpnoV1/mmLjJ9EHopCHNbkcKOlF6artjxg5+J40gTJrue
         Ys74hQ7fI5CMuJqgWn9T2szjGhnkimzbAG3lsgld+3UDM3aF82KvnhCep3lkZ4jnv1V/
         /8Vg8bdl8UmRMmCjjWIGwfJQFXz7eHJWipg2Tps5ivElVmv9VuBqTlVscK4oUsQ/z0Rh
         oLsLfrKCfD13n2zs0F4Nwwn1LMXsJJD4rozqW8mRHI7M8tDaJp7VX321mHMHCFuFtddL
         i/qQ==
X-Gm-Message-State: AOJu0YwkwctcK6tSXgmxABCikaZDfE+g3uJMOs82da+4yjTuMPDf4Tuv
	5Jm/0guUsS9Fh9xueAKTXwjQoOe9g22RIK7I3/ep3XIvv5bK
X-Google-Smtp-Source: AGHT+IEd0fV62W0G/uaqSAj5Ru8kUDF23LUCIgPep6D3xJt2H0NhkYcYKuXH6ypcKbis/gdhRjy7mMeiOYaYg5aWH3g=
X-Received: by 2002:a50:cd8a:0:b0:553:ee95:2b4f with SMTP id
 p10-20020a50cd8a000000b00553ee952b4fmr1078054edi.3.1704194459646; Tue, 02 Jan
 2024 03:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228014633.3256862-1-dw@davidwei.uk> <20231228014633.3256862-4-dw@davidwei.uk>
In-Reply-To: <20231228014633.3256862-4-dw@davidwei.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jan 2024 12:20:46 +0100
Message-ID: <CANn89iKB4odj7Taw_C-m48BGYmir-fjR-fFbmQj6DbkD+RacXg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/5] netdevsim: forward skbs from one
 connected port to another
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 2:46=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> Forward skbs sent from one netdevsim port to its connected netdevsim
> port using dev_forward_skb, in a spirit similar to veth.
>
> Add a tx_dropped variable to struct netdevsim, tracking the number of
> skbs that could not be forwarded using dev_forward_skb().
>
> The xmit() function accessing the peer ptr is protected by an RCU read
> critical section. The rcu_read_lock() is functionally redundant as since
> v5.0 all softirqs are implicitly RCU read critical sections; but it is
> useful for human readers.
>
> If another CPU is concurrently in nsim_destroy(), then it will first set
> the peer ptr to NULL. This does not affect any existing readers that
> dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
> a synchronize_rcu() before the netdev is actually unregistered and
> freed. This ensures that any readers i.e. xmit() that got a non-NULL
> peer will complete before the netdev is freed.
>
> Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
> will dereference NULL, making it safe.
>
> The codepath to nsim_destroy() and nsim_create() takes both the newly
> added nsim_dev_list_lock and rtnl_lock. This makes it safe with
> concurrent calls to linking two netdevsims together.
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/netdevsim/netdev.c    | 21 ++++++++++++++++++---
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  2 files changed, 19 insertions(+), 3 deletions(-)
>


> @@ -302,7 +318,6 @@ static void nsim_setup(struct net_device *dev)
>         eth_hw_addr_random(dev);
>
>         dev->tx_queue_len =3D 0;
> -       dev->flags |=3D IFF_NOARP;

This part seems to be unrelated to this patch ?

>         dev->flags &=3D ~IFF_MULTICAST;
>         dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE |
>                            IFF_NO_QUEUE;

