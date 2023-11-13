Return-Path: <netdev+bounces-47388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2594B7E9FC5
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 16:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9594280DAF
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BCA20B2E;
	Mon, 13 Nov 2023 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1cADOQy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91321355
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:21:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6B01724
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699888886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZKlq8Gi9nBiA9xBUAflROoriqD14FLDnaSA4APLNGs=;
	b=c1cADOQygmRn+76V5q+fK9sWp3LsB8GgWK7ytYyaF5shq82e4Ywgtlwzznsh3SmToLxETX
	PzOySJaWqQ9W5dwAwS18yDGueerCkfWgD77DOBdSdC89sojA4a0piIyjUpG7x1iEw4S3DP
	8531TZKK6+Pd9pztq64WiqS627yBqnI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-5KHn2MtSMXqjwknFlZ2tuA-1; Mon, 13 Nov 2023 10:21:24 -0500
X-MC-Unique: 5KHn2MtSMXqjwknFlZ2tuA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c39f53775fso27021666b.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 07:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699888883; x=1700493683;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZKlq8Gi9nBiA9xBUAflROoriqD14FLDnaSA4APLNGs=;
        b=PutlrH37QKulKSHT6SG9ErjGLt8vPms3vuO32MGsBklwqKnhQlp4Zex0llIke3qdT2
         CnbDyV/n+C+L1VoyKkDWzsdmlGnxoCuRb6ShLiDpwu1pE54mDG4nAKCu3dxgzsqM0IVS
         V9hNbZ+UapVF4LCfimmKheGEmfiDEN1MzEwrKDLbhP0QjKJUqiZwrS4MG2Wo8MV+S94P
         +mzxrEB/rG+AUVfnEO6cKMb8xbRQhIpQrQ8cTwuoiw+qJwwZO14ERAuOTfqxhX4lQ1lp
         4JsVFNs7YnbPbsmMuuqUIvZ9ji+9xR7gUQsDCXJxY+gaHRYBetGbqkg7nloJfrwlzfIa
         DhZg==
X-Gm-Message-State: AOJu0YzVz5CuW2UgkyNGhU8BTqhnnlyVrFyB2kSZa17BGHHXeWPaqZlo
	vkCGIBkwqCLmrsdmJWvdbGTgXz2ai86n+QnPpnfl7xeovbnkWPFQJh6CC02D5ExV63SYhFw6TCO
	kzVbJQDZF4fzSrxr/
X-Received: by 2002:a17:906:5197:b0:9e3:a1c8:36d6 with SMTP id y23-20020a170906519700b009e3a1c836d6mr4992424ejk.0.1699888883579;
        Mon, 13 Nov 2023 07:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyAPjzkAtDADBBHEXsaZM065ukd6peROtxOx07FgOAc2m/b9ZpzVmTKwhyWllaYH+pEPmsaQ==
X-Received: by 2002:a17:906:5197:b0:9e3:a1c8:36d6 with SMTP id y23-20020a170906519700b009e3a1c836d6mr4992408ejk.0.1699888883136;
        Mon, 13 Nov 2023 07:21:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-117.dyn.eolo.it. [146.241.227.117])
        by smtp.gmail.com with ESMTPSA id ti10-20020a170907c20a00b009c6a4a5ac80sm4137189ejc.169.2023.11.13.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:21:22 -0800 (PST)
Message-ID: <3fe99c1a283d564346742c3e3d820afcfd1f2634.camel@redhat.com>
Subject: Re: [PATCH net] net: sched: fix warn on htb offloaded class creation
From: Paolo Abeni <pabeni@redhat.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: "Chittim, Madhu" <madhu.chittim@intel.com>, netdev@vger.kernel.org, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,  Saeed Mahameed
 <saeedm@nvidia.com>, xuejun.zhang@intel.com, sridhar.samudrala@intel.com
Date: Mon, 13 Nov 2023 16:21:20 +0100
In-Reply-To: <ZVI3-w5dsLIhqHav@mail.gmail.com>
References: 
	<ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
	 <ZTvBoQHfu23ynWf-@mail.gmail.com>
	 <131da9645be5ef6ea584da27ecde795c52dfbb00.camel@redhat.com>
	 <ZUEQzsKiIlgtbN-S@mail.gmail.com>
	 <5d873c14-9d17-4c48-8e11-951b99270b75@intel.com>
	 <ZU4PBY1g_-N7cd8A@mail.gmail.com>
	 <63b9b3f40d0476ada2972ea8f6058b3613520ba8.camel@redhat.com>
	 <ZVI3-w5dsLIhqHav@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-13 at 16:51 +0200, Maxim Mikityanskiy wrote:
> On Sun, 12 Nov 2023 at 09:48:19 +0100, Paolo Abeni wrote:
> > On Fri, 2023-11-10 at 13:07 +0200, Maxim Mikityanskiy wrote:
> > > On Thu, 09 Nov 2023 at 13:54:17 -0800, Chittim, Madhu wrote:
> > > > We would like to enable Tx rate limiting using htb offload on all t=
he
> > > > existing queues.
> > >=20
> > > I don't seem to understand how you see it possible with HTB.
> >=20
> > I must admit I feel sorry for not being able to join any of the
> > upcoming conferences, but to me it looks like there is some
> > communication gap that could be filled by in-person discussion.
> >=20
> > Specifically the above to me sounds contradictory to what you stated
> > here:
> >=20
> > https://lore.kernel.org/netdev/ZUEQzsKiIlgtbN-S@mail.gmail.com/
> >=20
> > """
> > > Can HTB actually configure H/W shaping on
> > > real_num_tx_queues?
> >=20
> > It will be on real_num_tx_queues, but after it's increased to add new
> > HTB queues. The original queues [0, N) are used for direct traffic,
> > same as the non-offloaded HTB's direct_queue (it's not shaped).
> > """
>=20
> Sorry if that was confusing, there is actually no contradition, let me
> rephrase. Queues number [0, orig_real_num_tx_queues) are direct, they
> are not shaped, they correspond to HTB's unclassified traffic. Queues
> number [orig_real_num_tx_queues, real_num_tx_queues) correspond to HTB
> classes and are shaped. Here orig_real_num_tx_queues is how many queues
> the netdev had before HTB offload was attached. It's basically the
> standard set of queues, and HTB creates a new queue per class. Let me
> know if that helps.
>=20
> > > What is your goal?=C2=A0
> >=20
> > We are looking for clean interface to configure individually min/max
> > shaping on each TX queue for a given netdev (actually virtual
> > function).
>=20
> Have you tried tc mqprio? If you set `mode channel` and create queue
> groups with only one queue each, you can set min_rate and max_rate for
> each group (=3D=3Dqueue), and it works with the existing set of queues.

mqprio does not fit well here as:

* enforce an hard limit of 16 queues imposed by uAPI
* traffic class/queue selection depends on skb priority. That does not
fit well if e.g. the user would rely on a 1to1 CPU to queue mapping.

It looks like any existing scheduler would need some extension to fit
this use case.

@Jiri: when you suggested TC do you have anything specific in your
mind?

Otherwise it looks like extending /sys/class/net/eth0/queues/tx-
*/tx_maxrate would be more straight-forward to me.

Thanks!

Paolo


