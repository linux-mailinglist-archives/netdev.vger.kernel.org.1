Return-Path: <netdev+bounces-14754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334FC7439CA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 12:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087771C208DE
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB72E125A3;
	Fri, 30 Jun 2023 10:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF06101E9
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 10:43:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D9C3ABD
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688121795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSmMChIzFsnctBY/ntNdQM0sRE6MR8Uu4qXuBm6oUrY=;
	b=SUzVbRKlcR76Je5aGnbk3+A9ALRyOBrCH8M8ziBFZjXyyQHv+HyzMpob75ClOcMhmlD4uP
	qAsjxX0HJptCVn/6woW5tcVtbt9vuyWmmspJaHfoFFlsIpgB9UT7UQDXcSNyoN5jdCLwgY
	HJ4+0tUWaT3BaBZIYVa7yLmSXk6WJ1s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-VVzg68PUN8apafeikQ1vDg-1; Fri, 30 Jun 2023 06:37:04 -0400
X-MC-Unique: VVzg68PUN8apafeikQ1vDg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4009ad15222so3937441cf.1
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 03:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688121424; x=1690713424;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSmMChIzFsnctBY/ntNdQM0sRE6MR8Uu4qXuBm6oUrY=;
        b=UNT6h+aXFTxYDC485Vr/jFk0sJaNlAUubAEYHFsRgGypdkQe+as6jnj4N9V0awUpo5
         5U28EC2Kw6P19PyWjBS2zOyDP26X7+Sy0FtMRYdohxO0bBavKdOv7yX+DXO5qT7hbbuH
         etFH3PiG8kNiWKKBieT2un/7yJ8c63+GhQwlqc3UeG3hUlrbIDekwrFOPpc4HZ88ZTUp
         fEqxki3g/MLD8zOaZhWoHd5yYsONqEDrLdq9Ggi/Rtt8P/di5fDgcgWVLwcZ0Nf2gNFu
         aY+b99bjXmrksT9JDchlSyQ/B/hQItKsMrn5jIJ30zF8jA023QwyENGTa/D5KWEZVAJz
         ThwQ==
X-Gm-Message-State: AC+VfDzJT6G7I+26haoj3YJXajYlUckxGUx5ivQ9ohOlVy8IGaXMqtOB
	3MR/Y/NPFNLb+9T4R4zNUuTLzXhMgL88H26e7hGWEfrXSD4srYthzhsMS4K5l7II1wwtdpLO7/j
	/tybQHlQD5gF7GotY
X-Received: by 2002:a05:622a:1819:b0:400:a9a4:8517 with SMTP id t25-20020a05622a181900b00400a9a48517mr2536803qtc.4.1688121423751;
        Fri, 30 Jun 2023 03:37:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dr4NVZJGnbWpLNO5IGOyHWOg9Nxt/DgSxcc/RdlVezoQPlU7ziI3vkR1ZVcAPcj0V3cyAZg==
X-Received: by 2002:a05:622a:1819:b0:400:a9a4:8517 with SMTP id t25-20020a05622a181900b00400a9a48517mr2536779qtc.4.1688121423483;
        Fri, 30 Jun 2023 03:37:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id cc23-20020a05622a411700b003f7fd3ce69fsm5015184qtb.59.2023.06.30.03.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 03:37:03 -0700 (PDT)
Message-ID: <e5c3e5e5033290c2228bbad0307334a964eb065e.camel@redhat.com>
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
From: Paolo Abeni <pabeni@redhat.com>
To: Long Li <longli@microsoft.com>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, Ajay Sharma <sharmaajay@microsoft.com>, Dexuan Cui
 <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org"
	 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>
Date: Fri, 30 Jun 2023 12:36:58 +0200
In-Reply-To: <PH7PR21MB3263B266E381BA15DCE45820CE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
	 <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
	 <PH7PR21MB3263B266E381BA15DCE45820CE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-06-29 at 18:18 +0000, Long Li wrote:
> > Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell
> > on receiving
> > packets
> >=20
> > On Mon, 2023-06-26 at 16:57 -0700, longli@linuxonhyperv.com wrote:
> > > From: Long Li <longli@microsoft.com>
> > >=20
> > > It's inefficient to ring the doorbell page every time a WQE is
> > > posted
> > > to the received queue. Excessive MMIO writes result in CPU
> > > spending
> > > more time waiting on LOCK instructions (atomic operations),
> > > resulting
> > > in poor scaling performance.
> > >=20
> > > Move the code for ringing doorbell page to where after we have
> > > posted
> > > all WQEs to the receive queue during a callback from napi_poll().
> > >=20
> > > With this change, tests showed an improvement from 120G/s to
> > > 160G/s on
> > > a 200G physical link, with 16 or 32 hardware queues.
> > >=20
> > > Tests showed no regression in network latency benchmarks on
> > > single
> > > connection.
> > >=20
> > > While we are making changes in this code path, change the code
> > > for
> > > ringing doorbell to set the WQE_COUNT to 0 for Receive Queue. The
> > > hardware specification specifies that it should set to 0.
> > > Although
> > > currently the hardware doesn't enforce the check, in the future
> > > releases it may do.
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure
> > > Network Adapter (MANA)")
> >=20
> > Uhmmm... this looks like a performance improvement to me, more
> > suitable for
> > the net-next tree ?!? (Note that net-next is closed now).
>=20
> This issue is a blocker for usage on 200G physical link. I think it
> can be categorized as a fix.

Let me ask the question the other way around: is there any specific
reason to have this fix into 6.5 and all the way back to 5.13?
Especially the latest bit (CC-ing stable) looks at least debatable.

Thanks,

Paolo


