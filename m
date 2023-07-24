Return-Path: <netdev+bounces-20501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C775FBE2
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997B01C20BE5
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC69E549;
	Mon, 24 Jul 2023 16:23:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF2DDD1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:23:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AD11BC
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690215789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V9tQtfSvEmx9rZt6dVyXl7b7+b1sZKBkzP06e5uiOKE=;
	b=g1wYAkyrwTur3C2ywe8rWVmXJCnYypUkC212B+vkArvrEBhK4ZDMrJGOgx1GZwZSEx7e7L
	SZWhd+Yf/6XSdHUxaQ8SfWIGHXZ/Sd+wLaWVKr9A286pkdKXQOT0KjuDCAXXa5Je0cEL18
	p3zlU0uw7p48d89nbk1eOvDqMmyD1iI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-e-I5eSyBP8uK3YyTcrAfXQ-1; Mon, 24 Jul 2023 12:23:08 -0400
X-MC-Unique: e-I5eSyBP8uK3YyTcrAfXQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-405512b12f5so6777731cf.0
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690215787; x=1690820587;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9tQtfSvEmx9rZt6dVyXl7b7+b1sZKBkzP06e5uiOKE=;
        b=kNzoiwb/HOOCW9yZrT5KfML7aye5wAk1KSOW/9xOLIgDJrpHU3uncu+p74rydvo/zt
         j1j9bQTc/K3EejQ/UYoQqm99JBz75nXiv+dAndLtu3LtTvy+ZcNQFdB+yXLjuTizvuYk
         EPaljuayh1AslBqygWMbOsH9msV66/6RjmAJLvKNXpRNRXFQrgWpyMJnrp0yKHw1vPfz
         PGV/vrZRH29w93K4LDW9/SdpB4sX/S1fTUsJg0uBHFkx+Uu6SFBtDMLgN9mAWbDYkVlz
         n2TF0reR0e756PhmiagGbxJovHYMt7igCBs/CLRWBqR8HtwLxo7Jb+Oqk9cFhl2tfqKK
         PLxQ==
X-Gm-Message-State: ABy/qLa1bfdKp/OyBFiaBuuuTo+K+eAYUwgenrqcF1BbonktCnd174qt
	8b67Wax8maYxsUYR7Z7jDHpiT4JkdHgeiFz4HChP8VFDjDPVZzAzMG+ItNxZdvb0v5fXShGlv5O
	IYZInivWLh8SDbuRC
X-Received: by 2002:a05:622a:647:b0:400:990c:8f7c with SMTP id a7-20020a05622a064700b00400990c8f7cmr12565323qtb.0.1690215787290;
        Mon, 24 Jul 2023 09:23:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlED7MCeHx4GHsmmMweOmUKVLdRy+TVlDGmhVxs+jtIh0YM3nq5B+ebV7etA6y8noBl7FEGjXA==
X-Received: by 2002:a05:622a:647:b0:400:990c:8f7c with SMTP id a7-20020a05622a064700b00400990c8f7cmr12565306qtb.0.1690215787052;
        Mon, 24 Jul 2023 09:23:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id z10-20020ac87caa000000b003e3918f350dsm3379012qtv.25.2023.07.24.09.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:23:06 -0700 (PDT)
Message-ID: <2a531e60a0ea8187f1781d4075f127b01970321a.camel@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: store netdevs in an xarray
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
 mkubecek@suse.cz, lorenzo@kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>,  Neil Brown <neilb@suse.de>
Date: Mon, 24 Jul 2023 18:23:03 +0200
In-Reply-To: <20230724084126.38d55715@kernel.org>
References: <20230722014237.4078962-1-kuba@kernel.org>
	 <20230722014237.4078962-2-kuba@kernel.org>
	 <20788d4df9bbcdce9453be3fd047fdf8e0465714.camel@redhat.com>
	 <20230724084126.38d55715@kernel.org>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-24 at 08:41 -0700, Jakub Kicinski wrote:
> On Mon, 24 Jul 2023 10:18:04 +0200 Paolo Abeni wrote:
> > A possibly dumb question: why using an xarray over a plain list?
>=20
> We need to drop the lock during the walk.=C2=A0

I should have looked more closely to patch 2/2.

> So for a list we'd need=20
> to either=20
>  - add explicit iteration "cursor" or=20

Would a cursor require acquiring a netdev reference? If so it looks
problematic (an evil/buggy userspace could keep such reference held for
an unbounded amount of time).

I agree xarray looks a better solution.

I still have some minor doubts WRT the 'missed device' scenario you
described in the commit message. What if the user-space is doing
'create the new one before deleting the old one' with the assumption
that at least one of old/new is always reported in dumps? Is that a too
bold assumption?

> I was measuring it to find out if we can delete the hash table without
> anyone noticing, but it's not really the motivation.

Understood. I though about rhashtable with the opposite assumption :)
So no need to discuss such option further, I guess.

Cheers,

Paolo


