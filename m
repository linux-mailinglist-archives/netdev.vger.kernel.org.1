Return-Path: <netdev+bounces-47220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 909267E8F31
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 09:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25D9B20927
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A252100;
	Sun, 12 Nov 2023 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPs+lAjZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1933DA
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 08:48:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3669930C2
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 00:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699778908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIPVggcCbq7LcYX+Jf5+S89tifEldcvYLyAZFYsDVZY=;
	b=jPs+lAjZEvjsebwI2DKWWyk8jEOkKvFkpqT2N3u+SbY4iqdBuydql7ffzHIRzB78icEBCj
	m+SQss1Ea5zBBhO9/JRJ0mhZklMxXM2m3u/SvLEEnnCUwhi8WZk8oVQ67OViHsCPVsOg41
	oUDJq3HGtPVZ0pRkBXqPLNrXPk3HHJ8=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-AC8-XUoFOWyAcT0hVlCdMA-1; Sun, 12 Nov 2023 03:48:24 -0500
X-MC-Unique: AC8-XUoFOWyAcT0hVlCdMA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1f00b6ba9d6so519164fac.0
        for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 00:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699778904; x=1700383704;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIPVggcCbq7LcYX+Jf5+S89tifEldcvYLyAZFYsDVZY=;
        b=ZylakCpypqfO8DWyKn5EnCZJeFcCCWAou7GflCi31jjGyzryWrPPkoxhiu8m9Hs2wC
         ZIkU+wTW91sBZbK74YTxSV5ZBFSAe8xHEwIXR1TGtoh5Z2+51pQjzdBOZ1Nd+EdGOIA9
         oc7QrDsmxX8gEudgwzUDxwob90bXOznTJLRThO1VgRcANKeYrXc0KfY8gCnhfZNWHDRt
         sf0GYPyztm5M87Im7kfelBft9IbeLz9kGnKyYmAg2rRaTnt6MYQpNLE4p3YJ9FHIppYF
         LHCen1FBJlJ3tgU8huOQs3ZVNWh4uPH+/49iF1yvSiQ7Y+HEtNvWx0jGqLCOKf7McQ0m
         rUtA==
X-Gm-Message-State: AOJu0YwMZuQa/iXn3VgBF/MjDY2uS9Q/wW366sPdfv5NnDBnXdhRbNaB
	NR2t6S7yXF+KaYKn1NofyJhMtc8NM/0355yGCfoM+WqBLD/ssSHAI0pOaIlJSVyD1aO9qe53pfb
	1uBTFSqqZD9jWE0wI9cGfs1Bp
X-Received: by 2002:a05:6808:10c9:b0:3ae:5650:c6ae with SMTP id s9-20020a05680810c900b003ae5650c6aemr4609613ois.0.1699778904105;
        Sun, 12 Nov 2023 00:48:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsPmX2n53ePJLKsj3bFbjYk6N74rn0FClVhQRaeAMWSJu4SMph//BmwaQ4k+C8v1TOSsvQcQ==
X-Received: by 2002:a05:6808:10c9:b0:3ae:5650:c6ae with SMTP id s9-20020a05680810c900b003ae5650c6aemr4609602ois.0.1699778903871;
        Sun, 12 Nov 2023 00:48:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-229-114.dyn.eolo.it. [146.241.229.114])
        by smtp.gmail.com with ESMTPSA id v17-20020ac873d1000000b0041950c7f6d8sm1048343qtp.60.2023.11.12.00.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 00:48:23 -0800 (PST)
Message-ID: <63b9b3f40d0476ada2972ea8f6058b3613520ba8.camel@redhat.com>
Subject: Re: [PATCH net] net: sched: fix warn on htb offloaded class creation
From: Paolo Abeni <pabeni@redhat.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>, "Chittim, Madhu"
	 <madhu.chittim@intel.com>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>,  Gal Pressman <gal@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, xuejun.zhang@intel.com,  sridhar.samudrala@intel.com
Date: Sun, 12 Nov 2023 09:48:19 +0100
In-Reply-To: <ZU4PBY1g_-N7cd8A@mail.gmail.com>
References: 
	<ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
	 <ZTvBoQHfu23ynWf-@mail.gmail.com>
	 <131da9645be5ef6ea584da27ecde795c52dfbb00.camel@redhat.com>
	 <ZUEQzsKiIlgtbN-S@mail.gmail.com>
	 <5d873c14-9d17-4c48-8e11-951b99270b75@intel.com>
	 <ZU4PBY1g_-N7cd8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-10 at 13:07 +0200, Maxim Mikityanskiy wrote:
> On Thu, 09 Nov 2023 at 13:54:17 -0800, Chittim, Madhu wrote:
> > We would like to enable Tx rate limiting using htb offload on all the
> > existing queues.
>=20
> I don't seem to understand how you see it possible with HTB.

I must admit I feel sorry for not being able to join any of the
upcoming conferences, but to me it looks like there is some
communication gap that could be filled by in-person discussion.

Specifically the above to me sounds contradictory to what you stated
here:

https://lore.kernel.org/netdev/ZUEQzsKiIlgtbN-S@mail.gmail.com/

"""
> Can HTB actually configure H/W shaping on
> real_num_tx_queues?

It will be on real_num_tx_queues, but after it's increased to add new
HTB queues. The original queues [0, N) are used for direct traffic,
same as the non-offloaded HTB's direct_queue (it's not shaped).
"""

> What is your goal?=C2=A0

We are looking for clean interface to configure individually min/max
shaping on each TX queue for a given netdev (actually virtual
function).

Jiri's suggested to use TC:

https://lore.kernel.org/netdev/ZOTVkXWCLY88YfjV@nanopsycho/

which IMHO makes sense as far as there is an existing interface (qdisc)
providing the required features (almost) out-of-the-box.=C2=A0It looks like
it's not the case.

If a non trivial configuration and/or significant implementation are
required, IMHO other options could be better...

> If you need shaping for the whole netdev, maybe HTB
> is not needed, and it's enough to attach a catchall filter with the
> police action? Or use /sys/class/net/eth0/queues/tx-*/tx_maxrate
> per-queue?

... specifically this latter one (it will require implementing in-
kernel support for 'max_rate', but should quite straight-forward).

It would be great to converge on some agreement on the way forward,
thanks!

Paolo


