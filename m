Return-Path: <netdev+bounces-14254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB9973FC44
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CBD1C209FD
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B8A17FE8;
	Tue, 27 Jun 2023 12:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA534171C5
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 12:55:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B9F2D60
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687870525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRl7aKap1SeKgVZS63rqtI75g0CI3hogPpCfcoBBCMs=;
	b=RpREXICvHLQwsrzFd8s14IssnGMNrOags+Q4gp9fKMKZu55y5MEqB16sZT359KsGHUdNLZ
	cZgfBaEeNlxJ0nmuKCLJ+NoJPBlyRE1pFgBrRW8x+viWUl+AvfrFjCRu7+FZPc4BXnt0b2
	1FYRocBk0nS21htfisXnuD7AI+Qp3Q4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-s3SKjBBrN6-NdRELn2juUA-1; Tue, 27 Jun 2023 08:55:24 -0400
X-MC-Unique: s3SKjBBrN6-NdRELn2juUA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765ad67e600so35760685a.0
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870524; x=1690462524;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRl7aKap1SeKgVZS63rqtI75g0CI3hogPpCfcoBBCMs=;
        b=anBVmsfS4pNXnUYbtT4B+vpBChU8sEqG8+FExqJrzUWL2lPynFVjQtNdUWHF9sMqkJ
         uLXA90pjZAJoNG27jieFvajQfrIldbcNpgKXRZ1WfR2VrxkN1vSYaN0RPzVzhs9sCJy3
         sACq/WiWK0m7v1g+Rr96n545TEhmjQaWKSVrxRLCJss01UrG0MNhND8t0b+7pKme+CDz
         npPxJF6BrvnEe8jQLvq1rSNMN5ip84o4pLdybTlNoC5R7/A3L81EaMltZq8lO26IW1Y+
         OwHytRHjGUObb7nZwYlrxTnF/uKD5IsMxYKdZ8F0Vwc0j20saY2g7nA4hCAVR7whSB0A
         wV9Q==
X-Gm-Message-State: AC+VfDxieDZzTh0qtc9EJej6li4GFTLikneKiGBAYhHUjL7UZrlbYrWq
	tzyeBWEnN5x5U0knS/qXC0/Z9L3cLNUb45+7gFKUVZcdWD+afPybQezjcRoEVO+lzjpphRpP42L
	MrtpyZ6o1GYcbTrSU
X-Received: by 2002:a05:620a:190e:b0:765:3b58:99ab with SMTP id bj14-20020a05620a190e00b007653b5899abmr2670206qkb.4.1687870523898;
        Tue, 27 Jun 2023 05:55:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MVSVOTOJGm6y6OkidtOFcnyLv70o/VU/KFN2yDxpJyfTZKFyUUry0ejHmhywBuZIZSQ+qRw==
X-Received: by 2002:a05:620a:190e:b0:765:3b58:99ab with SMTP id bj14-20020a05620a190e00b007653b5899abmr2670184qkb.4.1687870523654;
        Tue, 27 Jun 2023 05:55:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-6.dyn.eolo.it. [146.241.239.6])
        by smtp.gmail.com with ESMTPSA id j7-20020a05620a146700b00765516bd9f2sm3912923qkl.33.2023.06.27.05.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:54:07 -0700 (PDT)
Message-ID: <1f4271105ac5be66e5130d487464680fc65bacc8.camel@redhat.com>
Subject: Re: Is ->sendmsg() allowed to change the msghdr struct it is given?
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
 ceph-devel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2023 14:54:02 +0200
In-Reply-To: <b0a0cb0fac4ebdc23f01d183a9de10731dc90093.camel@redhat.com>
References: <3112097.1687814081@warthog.procyon.org.uk>
	 <20230626142257.6e14a801@kernel.org>
	 <b0a0cb0fac4ebdc23f01d183a9de10731dc90093.camel@redhat.com>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-27 at 14:51 +0200, Paolo Abeni wrote:
> On Mon, 2023-06-26 at 14:22 -0700, Jakub Kicinski wrote:
> > On Mon, 26 Jun 2023 22:14:41 +0100 David Howells wrote:
> > > Do you know if ->sendmsg() might alter the msghdr struct it is passed=
 as an
> > > argument? Certainly it can alter msg_iter, but can it also modify,
> > > say, msg_flags?
> >=20
> > I'm not aware of a precedent either way.
> > Eric or Paolo would know better than me, tho.
>=20
> udp_sendmsg() can set the MSG_TRUNC bit in msg->msg_flags, so I guess
> that kind of actions are sort of allowed.

Sorry, ENOCOFFEE here. It's actually udp_recvmsg() updating msg-
>msg_flags.

>  Still, AFAICS, the kernel
> based msghdr is not copied back to the user-space, so such change
> should be almost a no-op in practice.

This part should be correct.

> @David: which would be the end goal for such action?

Sorry for the noisy reply,

Paolo


