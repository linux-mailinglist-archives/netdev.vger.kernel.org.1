Return-Path: <netdev+bounces-35213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EB67A7A05
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19591C2098D
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12D21642F;
	Wed, 20 Sep 2023 11:06:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9415AE7
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 11:06:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5040C2
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695208013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfDCNnVKo1svwadEk9oIfDB+2esqrYhApxIidnLEY88=;
	b=d/XVQK+/Mz5f7d0BbLwjFz8WYneuefNs3Ftl2GQRwX6h3S7kcpGOHJBt5O5Vj9PSJ6ocSd
	44Yi52Kyx/6WfatnjNMY4icO9lySeAYVKCoKHYm0C5eUmeE0rcBaxiUHd4qOnCGNG7VslC
	ndNoyYThRkZoRjnEoyxFfVRGwY1CXLk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-UeG4j4fXN2qFYvza_xvmcQ-1; Wed, 20 Sep 2023 07:06:52 -0400
X-MC-Unique: UeG4j4fXN2qFYvza_xvmcQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-404df8f48ccso14150325e9.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 04:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695208011; x=1695812811;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfDCNnVKo1svwadEk9oIfDB+2esqrYhApxIidnLEY88=;
        b=SsnTkQ/cvcGLtB9vIZYZJzT+cdG+30bcjp/azdZ+KSFdctmBlis6QeG5Rh3rbln9v3
         90qiLIWI1tWrEhaLfUQ0taoX1zZQm9XzzTh6vkZiHplT38Tk/y+u4yPu/WfpmzhgO1Un
         ZM/TctY2e9tzPVLEeMUWnkyixIuO8v5GfvXt+iDqtLiO64iKm9g9etIuazbHohUBbglk
         48ohBvDYCYqOLaEiJ0Jnl2Xpy0DCjOBasybdqLRzkgkpcGfKkMLZOlT2BDqVb6rJ3W7P
         c1LbrnUtrkBw67jYg90M7CAZTA4l8redIf1exC6c0WntqvVc2BRnMl/Cn3pkGFf8vt+z
         LeLg==
X-Gm-Message-State: AOJu0YzhFDP0HVcPTxWLI4QFg3AKESAQo2nM0kyAQKYAQSn3j3IfAYAs
	JAXNOwqV4CxLq90ml2OhZqzJRLsc3KTVYx0lxWgyJljPU6QRMsdJgcHQ+grRa7I6dQwuUClEsRS
	SSO2zzpenM355BELX
X-Received: by 2002:a05:600c:358d:b0:401:b53e:6c3e with SMTP id p13-20020a05600c358d00b00401b53e6c3emr2246228wmq.1.1695208011297;
        Wed, 20 Sep 2023 04:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQai1hDlcW1xi3A9mCJ3IVLesx5xOiB+d9PQpepYxX8c8mzd0ejadrsxaFt3WWy0dIOq2VYg==
X-Received: by 2002:a05:600c:358d:b0:401:b53e:6c3e with SMTP id p13-20020a05600c358d00b00401b53e6c3emr2246193wmq.1.1695208010924;
        Wed, 20 Sep 2023 04:06:50 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-56.dyn.eolo.it. [146.241.242.56])
        by smtp.gmail.com with ESMTPSA id g33-20020a05600c4ca100b004051d5b2cf1sm1645878wmp.12.2023.09.20.04.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 04:06:50 -0700 (PDT)
Message-ID: <f1198daa6d068c76b8ce692ad313698c34d0d1a3.camel@redhat.com>
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
From: Paolo Abeni <pabeni@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
	 <sgarzare@redhat.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang
 <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@sberdevices.ru,  oxffffaa@gmail.com
Date: Wed, 20 Sep 2023 13:06:48 +0200
In-Reply-To: <20230919223700-mutt-send-email-mst@kernel.org>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
	 <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
	 <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
	 <a5b25ee07245125fac4bbdc3b3604758251907d2.camel@redhat.com>
	 <hq67e2b3ljfjikvbaneczdve3fzg3dl5ziyc7xtujyqesp6dzm@fh5nqkptpb4n>
	 <20230919223700-mutt-send-email-mst@kernel.org>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-19 at 22:38 -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 19, 2023 at 03:35:51PM +0200, Stefano Garzarella wrote:
> > On Tue, Sep 19, 2023 at 03:19:54PM +0200, Paolo Abeni wrote:
> >=20
> > > DaveM suggests this should go via the virtio tree, too. Any different
> > > opinion?
> >=20
> > For this series should be fine, I'm not sure about the next series.
> > Merging this with the virtio tree, then it forces us to do it for
> > followup as well right?
> >=20
> > In theory followup is more on the core, so better with net-next, but
> > it's also true that for now only virtio transports support it, so it
> > might be okay to continue with virtio.
> >=20
> > @Michael WDYT?
> >=20
> > Thanks,
> > Stefano
>=20
> I didn't get DaveM's mail - was this off-list?

Yes, that was off-list co-ordination.

> I think net-next is easier because the follow up belongs in net-next.
> But if not I can take it, sure. Let me know.

Since there is agreement on that route, we will take it (likely
tomorrow).

Cheers,

Paolo


