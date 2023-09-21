Return-Path: <netdev+bounces-35422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F557A9735
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB152281E66
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CC1168AA;
	Thu, 21 Sep 2023 17:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E6168A3
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:05:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEA15B88
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695315825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8EMyNUFfNfNe78ZGe1xzNCvjh6qpWodfMx5WvJ2gfk=;
	b=NancqprWGFcjHXXT4amkLVPEmv/rrK36+C1Udt6Ah9CnvEGYHYRYF+e68xxmj8TquFecZo
	to9sU6taq9VcnW6arlyR5nfrVx1B/Kn+5kBcozXjmqY2vfOctXA4EpCh7WvpSzzzzfs+lG
	691iA0y158pJW7zo3cPShjMQi4sgqbY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-GBDvuXajPQaqnge8vix9eg-1; Thu, 21 Sep 2023 04:35:30 -0400
X-MC-Unique: GBDvuXajPQaqnge8vix9eg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53347126bf0so51618a12.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 01:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695285329; x=1695890129;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S8EMyNUFfNfNe78ZGe1xzNCvjh6qpWodfMx5WvJ2gfk=;
        b=AtJjkZl5YkDROjaMRsVJXzTyJ2PwnhY9VSb5yNsMfijxBwcapLRUTtb+ECMuldyYa1
         JYSygbB+iZoTclKkdIkSRozl5m1DgAc/jWQCHb8HXGo1lOGAtwvFep35LB29XplpNwZf
         b7wNzr9ID0MQCttQtlkxyhsfQ/nV1TfMPDWM7uGqUewOW2OBZKadFlfv4tlb2AqO0+m3
         qkML9tBev3BDr3VRW5OFjfar7rqW49NEIzaXy0EUYul3ULCoAzl/AQgyHRHdIWcwuZJo
         IT1fyA/YHk1X3wnRpSCFO9JBvxmuaxNEidSMe32CRE03lcfBjU3GZ/y01mNELwwCZ29W
         xqfQ==
X-Gm-Message-State: AOJu0YwYIztmBB6YEKOa0Z9M+ecHh3K3qyh2OvqROdRqXIeyhwcyADFD
	4oek7/tl+rygo9sygTMVNZ7b0yGtkTtWtOs0L+8NuT0CNfPj6nX/bI8v6uxnNu5eku3Dbow6A7i
	tk0BkNq9nFhtwEYUD
X-Received: by 2002:a05:6402:5113:b0:52f:bedf:8f00 with SMTP id m19-20020a056402511300b0052fbedf8f00mr4413026edd.1.1695285329470;
        Thu, 21 Sep 2023 01:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAW/UvKuvnLugNpN1Z3inmDdgS9n+W9mAOBmbW1+7FkQFU5ebaF6MaR5bLnb/khZRARbaRIg==
X-Received: by 2002:a05:6402:5113:b0:52f:bedf:8f00 with SMTP id m19-20020a056402511300b0052fbedf8f00mr4412998edd.1.1695285329164;
        Thu, 21 Sep 2023 01:35:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7d443000000b0052576969ef8sm502682edr.14.2023.09.21.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:35:28 -0700 (PDT)
Message-ID: <550df73160cd600f797823b86fde2c2b3526b133.camel@redhat.com>
Subject: Re: [PATCH net v4 3/3] net: prevent address rewrite in kernel_bind()
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jordan Rife
 <jrife@google.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  netdev@vger.kernel.org
Cc: dborkman@kernel.org, philipp.reisner@linbit.com,
 lars.ellenberg@linbit.com,  christoph.boehmwalder@linbit.com,
 axboe@kernel.dk, airlied@redhat.com,  chengyou@linux.alibaba.com,
 kaishen@linux.alibaba.com, jgg@ziepe.ca,  leon@kernel.org,
 bmt@zurich.ibm.com, isdn@linux-pingi.de, ccaulfie@redhat.com, 
 teigland@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
 joseph.qi@linux.alibaba.com, sfrench@samba.org, pc@manguebit.com, 
 lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com,
 horms@verge.net.au,  ja@ssi.bg, pablo@netfilter.org, kadlec@netfilter.org,
 fw@strlen.de,  santosh.shilimkar@oracle.com, stable@vger.kernel.org
Date: Thu, 21 Sep 2023 10:35:25 +0200
In-Reply-To: <650af4001eb7c_37ac7329443@willemb.c.googlers.com.notmuch>
References: <20230919175323.144902-1-jrife@google.com>
	 <650af4001eb7c_37ac7329443@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-09-20 at 09:30 -0400, Willem de Bruijn wrote:
> Jordan Rife wrote:
> > Similar to the change in commit 0bdf399342c5("net: Avoid address
> > overwrite in kernel_connect"), BPF hooks run on bind may rewrite the
> > address passed to kernel_bind(). This change
> >=20
> > 1) Makes a copy of the bind address in kernel_bind() to insulate
> >    callers.
> > 2) Replaces direct calls to sock->ops->bind() with kernel_bind()
> >=20
> > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@goo=
gle.com/
> > Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jordan Rife <jrife@google.com>
>=20
> Reviewed-by: Willem de Bruijn <willemb@google.com>

I fear this is going to cause a few conflicts with other trees. We can
still take it, but at very least we will need some acks from the
relevant maintainers.

I *think* it would be easier split this and patch 1/3 in individual
patches targeting the different trees, hopefully not many additional
patches will be required. What do you think?

Cheers,

Paolo


