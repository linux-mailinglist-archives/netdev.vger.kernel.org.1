Return-Path: <netdev+bounces-32780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9EE79A6C6
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B52281308
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EA9BE74;
	Mon, 11 Sep 2023 09:35:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B59259B
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:35:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6424E102
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694424911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xw5LSPkJOO9N8t+kmNMjnnLKY0SIGv0FX+dHZAzYPM=;
	b=JMwpRBJUHDByH6z5qQAsKSOIjzCqo1nAYypF7kTSaenIanP+gRehFicsmuDYFL8IUTKmpc
	oZ78Bf++wD6snnayoAaYGCgmYkv6F1eh+S13tIQ599CFLXvf3a0jgw5w/0PpM8p4FXr5Hq
	PEzfeo6SmKTwgMmTi7HJxypWmXaYxwA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-iMOB7adoM_G_9KLbZWNTvA-1; Mon, 11 Sep 2023 05:35:08 -0400
X-MC-Unique: iMOB7adoM_G_9KLbZWNTvA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401d62c2de7so12612985e9.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424907; x=1695029707;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1xw5LSPkJOO9N8t+kmNMjnnLKY0SIGv0FX+dHZAzYPM=;
        b=UoJL729umRURMDDRvydiGlMhvBpn+CYR9UdkTYG47OTcD/ptZ6hLPMKj7I6dhKJCJu
         9UmN1Dr3/YVmLmzY00jIswFiwOp3pItT4NrbX8T5yCglWR7bTMPkFZQ8tijDsV3cV5//
         naYpXl5q5XGTcffFwB9YNC+J69etq7WJx3zzQ+696mNh0hzgjZVvqgvj5McLThOkqxV5
         vI5wepiqtXjg6Q3SmigETNoOL974I2UxhKAt07/vDlBwELPcBgjxa/7sgX4j1cK8vA1V
         uh+hWfQRbTkJ9rVTwuy1iJ3h/m9okXsJ82IyE+ho5hZqAbAyB2+9A80R0L8apmJfaYrL
         alfA==
X-Gm-Message-State: AOJu0YwjjeJbl/KVLsWAdebwchMrFLrH7hcVYeCY/Xm+qOD4zJeGir13
	g3jDhyu1de0s6M1P49JP3mfEkODzlO6R4o4NBf+OC2tK2tKilvX/koIpnu+gTzDiUaQAAuYlfeS
	IUPTEcqynMySMnnDt
X-Received: by 2002:a05:600c:3114:b0:401:b53e:6c3e with SMTP id g20-20020a05600c311400b00401b53e6c3emr8528627wmo.1.1694424907143;
        Mon, 11 Sep 2023 02:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBfZ0e+/xxhdhWKed6XyySLVIIUBSNY36wcx6Eqjr5UIpwhlqKgtY0Gpz+HuNyc+gJfBc2gw==
X-Received: by 2002:a05:600c:3114:b0:401:b53e:6c3e with SMTP id g20-20020a05600c311400b00401b53e6c3emr8528611wmo.1.1694424906803;
        Mon, 11 Sep 2023 02:35:06 -0700 (PDT)
Received: from [10.0.0.196] ([37.186.167.86])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c230900b003fe1a092925sm9399617wmo.19.2023.09.11.02.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:35:06 -0700 (PDT)
Message-ID: <8e539e610a7cb4d1cf31fa5e741eb111a3d2ca5b.camel@redhat.com>
Subject: Re: [PATCHv2 net-next 2/2] ipv4/fib: send notify when delete source
 address routes
From: Thomas Haller <thaller@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
 <idosch@nvidia.com>,  David Ahern <dsahern@kernel.org>, Benjamin Poirier
 <bpoirier@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, Eric
 Dumazet <edumazet@google.com>
Date: Mon, 11 Sep 2023 11:35:05 +0200
In-Reply-To: <ZOw7VIMulJLyU0QL@Laptop-X1>
References: <20230809140234.3879929-1-liuhangbin@gmail.com>
	 <20230809140234.3879929-3-liuhangbin@gmail.com> <ZNT9bPpuCLVY7nnP@shredder>
	 <ZNt1wOCjqj/k/zAW@Laptop-X1> <ZOw7VIMulJLyU0QL@Laptop-X1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-08-28 at 14:14 +0800, Hangbin Liu wrote:
> > >=20
> > > In the other thread Thomas mentioned that NM already requests a
> > > route
> > > dump following address deletion [1]. If so, can Thomas or you
> > > please
> > > explain how this patch is going to help NM? Is the intention to
> > > optimize
> > > things and avoid the dump request (which can only work on new
> > > kernels)?
> > >=20
> > > [1]
> > > https://lore.kernel.org/netdev/07fcfd504148b3c721fda716ad0a5496627084=
07.camel@redhat.com/
> >=20
> > In my understanding, After deleting an address, deal with the
> > delete notify is
> > more efficient to maintain the route cache than dump all the
> > routes.


Hi,


NetworkManager does so out of necessity, as there is no notification.
Overall, it seems a pretty bad thing to do, because it's expensive if
you have many routes/addresses.

Unfortunately, it's hard to ever drop a workaround, because we never
know when the workaround can be dropped.

Also, it's simply a notification missing, and not tied to
NetworkManager or to maintaining a cache. If you run `ip route
monitor`, you also don't see the notification that kernel drops a
route? The effort that NetworkManager takes to maintain correct
information is not something that most programs would do.


Thomas


