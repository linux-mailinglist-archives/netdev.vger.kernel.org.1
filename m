Return-Path: <netdev+bounces-15291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF5746A2F
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 08:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D7C280E58
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 06:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027DC10FD;
	Tue,  4 Jul 2023 06:59:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A10647
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:59:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE411F
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688453951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IleIxpNn+PMHgV028qieppTFJnd95N2jqDTi5xYgrM=;
	b=A1Ov6fXZa9DLfzmf8fWJFQmvD6lrPcZE/1dqsgoknYtp8W7s4/lVcprRkVBDxxbojzzv9g
	tECaT4bjAhkRJEoI4ruoRPiarQQB8GQj3S8hAXXoOA/dhGUPT4x6NUzn+/mSH5biPEjTh6
	/MUVUtII7JcBzG1INZUmwEESdM9pgmI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-Nj7bkUlGPL-QqEagOZAREg-1; Tue, 04 Jul 2023 02:59:09 -0400
X-MC-Unique: Nj7bkUlGPL-QqEagOZAREg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7672918d8a4so154903385a.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 23:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688453949; x=1691045949;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IleIxpNn+PMHgV028qieppTFJnd95N2jqDTi5xYgrM=;
        b=C2JsDwdfoehVqij1SGw/PrKyDssrvZmh6SgArn3u7qBNUqQXs6TZAWXELCCYHX8hjM
         5LHEmPo2PTHrGUTJyNyFcvgzkjf3vymoC9LB8Ng0S/4U+IFFo2dbGKHiJrL6dFSe7Cex
         pWnUzcXOMtp3tG3WHkBXhcCE8CKWlEz6mBKqEqK3umkGhjVyKQRGx7+PNjwCaOSgSdeD
         H9oeS5EdsV/qE5ft4OcwoZ7xW83xx4IpCzuDiAhGw0/TU0DBfrmUZI4ZgD82Cx8N+Ill
         DJhLvYep4slbzsgd9oxCac70jgM2duqaUqjuRXcQvjvtqyj0MHmlFjvCWUFGuDrX+xav
         0Ing==
X-Gm-Message-State: ABy/qLbusKcRB1mM/h51BL+CVe+kNO4NLqE2wH1zU/bFnEHkwwf5MKGV
	6MAMUk4BtQXqNTOaq5VRN3Kbo7nRbNoPG4Kbf6KRvFttabE65eVnp4aZbsSC35Q52mERf1p9ZFx
	EtDk6pdc9LUuRz9Ui
X-Received: by 2002:a05:620a:1aa4:b0:765:58ac:9458 with SMTP id bl36-20020a05620a1aa400b0076558ac9458mr14719908qkb.7.1688453949232;
        Mon, 03 Jul 2023 23:59:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEzlcNLkagvW9k+kp5MGjOwZWN9zlneIyGcDYmRHiEtbwaDGwG+DfHs99YP8WgUKWv70lEQoQ==
X-Received: by 2002:a05:620a:1aa4:b0:765:58ac:9458 with SMTP id bl36-20020a05620a1aa400b0076558ac9458mr14719893qkb.7.1688453948908;
        Mon, 03 Jul 2023 23:59:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id pe34-20020a05620a852200b007623c96430csm9632974qkn.111.2023.07.03.23.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:59:08 -0700 (PDT)
Message-ID: <8b0696a63d3f9cdcd4d9a8d933826e9ea1cb126b.camel@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload
 when host is unresponsive
From: Paolo Abeni <pabeni@redhat.com>
To: Souradeep Chakrabarti <schakrabarti@microsoft.com>, Alexander Lobakin
	 <aleksander.lobakin@intel.com>, souradeep chakrabarti
	 <schakrabarti@linux.microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>,  "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, Long Li <longli@microsoft.com>, Ajay
 Sharma <sharmaajay@microsoft.com>, "leon@kernel.org" <leon@kernel.org>, 
 "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,  "tglx@linutronix.de"
 <tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Date: Tue, 04 Jul 2023 08:59:03 +0200
In-Reply-To: <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: 
	<1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
	 <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
	 <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
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

On Mon, 2023-07-03 at 19:55 +0000, Souradeep Chakrabarti wrote:
> > -----Original Message-----
> > From: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Sent: Monday, July 3, 2023 10:18 PM
> > To: souradeep chakrabarti <schakrabarti@linux.microsoft.com>
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Aja=
y
> > Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> > cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com=
;
> > tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.or=
g;
> > linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
> > stable@vger.kernel.org; Souradeep Chakrabarti <schakrabarti@microsoft.c=
om>
> > Subject: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload wh=
en
> > host is unresponsive
> >=20
> > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > Date: Mon,  3 Jul 2023 01:49:31 -0700
> >=20
> > > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> >=20
> > Please sync your Git name and Git mail account settings, so that your o=
wn
> > patches won't have "From:" when sending. From what I see, you need to
> > correct first letters of name and surname to capital in the Git email s=
ettings
> > block.
> Thank you for pointing, I will fix it.
> >=20
> > >=20
> > > When unloading the MANA driver, mana_dealloc_queues() waits for the
> > > MANA hardware to complete any inflight packets and set the pending
> > > send count to zero. But if the hardware has failed,
> > > mana_dealloc_queues() could wait forever.
> > >=20
> > > Fix this by adding a timeout to the wait. Set the timeout to 120
> > > seconds, which is a somewhat arbitrary value that is more than long
> > > enough for functional hardware to complete any sends.
> > >=20
> > > Signed-off-by: Souradeep Chakrabarti
> > > <schakrabarti@linux.microsoft.com>
> >=20
> > Where's "Fixes:" tagging the blamed commit?
> This is present from the day zero of the mana driver code.
> It has not been introduced in the code by any commit.
>=20

Then the fixes tag should be:

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network A=
dapter (MANA)")

Cheers,

Paolo


