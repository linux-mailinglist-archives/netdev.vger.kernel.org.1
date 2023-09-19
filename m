Return-Path: <netdev+bounces-34917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517877A5E82
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80196281E8D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4273FB32;
	Tue, 19 Sep 2023 09:47:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13618538C
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 09:47:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D7EED
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695116854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkAmog8kPURPdwC6/7i2WeWfLhkTcmYXq3osNRaDjMc=;
	b=ZsSB11gmx5I8OFO92EODAuAUKvvaZuTWrQX0V46pgw+2fEa0NfBTbUGQOcpGc8s6iGOn+D
	zsn2YOG0INZICqGLhSiPLwzT2K4ckmXCRmyvNrXZdtnfmlPiOeRIYVxNZc5VrALb7IcAyG
	JuFkcPyO21nsocMZhxV2GHL+08txtXI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-eNEkDDt9MZ-6vscUoo2oGA-1; Tue, 19 Sep 2023 05:47:33 -0400
X-MC-Unique: eNEkDDt9MZ-6vscUoo2oGA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-525691cfd75so960829a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 02:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116852; x=1695721652;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkAmog8kPURPdwC6/7i2WeWfLhkTcmYXq3osNRaDjMc=;
        b=TMpQNBZu0SA4A50zcj6m9mxEDAJ/vGjh9hsMsXUdFWty/rAgBx6eXMtue6eA0JYdiQ
         LSA+7CFR61Qgoi3y2e3CtoUO3ZDWLPb8XTYeyX4rxAbloXOqancSYsHzRjI0tt4m+NhS
         27aOQj33HZgKd6sLL0ugozZn5gKAPRtg/SPiHE3D0yqnpwFcOv2zL4MBuX+jW7XJ1ZMW
         iR1hkqu6Ju/lMXYNpsfGL/vgU/MttOJbJni8QnnB1yBuP9mysVohB6OA8X+niz38LbvW
         w6BPvAkMOM60w8lBp0lrwPc22Ej1xaXmvKcaFPvALKIpJFCo9UyheAVGC7nZbP7EdTAb
         VXfg==
X-Gm-Message-State: AOJu0YxnHW34Z8u+XK6wzKyGopWh0dvPOfawS9fkSTzScwLLH0v8ZE++
	OY0LQUbdtGMvkfbZOU7pNYzBSufZrMF3gthH9aRgqGMlBpOlV+JUbRzu55ZeEUQgtqqWkmZCko+
	dlQjK1URimO5VIhj1
X-Received: by 2002:a05:6402:1909:b0:52f:bedf:8ef1 with SMTP id e9-20020a056402190900b0052fbedf8ef1mr10972059edz.3.1695116852155;
        Tue, 19 Sep 2023 02:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdyvAkbPqoRHbFUkr3X4vyY71M+jXmRtg9LjpdFeCk47m2ui+Zr9bOc1plBfUmhqktSYoOhA==
X-Received: by 2002:a05:6402:1909:b0:52f:bedf:8ef1 with SMTP id e9-20020a056402190900b0052fbedf8ef1mr10972040edz.3.1695116851880;
        Tue, 19 Sep 2023 02:47:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id t13-20020aa7d70d000000b0052328d4268asm7013685edq.81.2023.09.19.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:47:31 -0700 (PDT)
Message-ID: <3f79b0d4b9409a223f03c0b36b3544ce1389a500.camel@redhat.com>
Subject: Re: [PATCH 4/4] net/onsemi: Add NCN26010 driver
From: Paolo Abeni <pabeni@redhat.com>
To: Jay Monkman <jtm@lopingdog.com>, Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>,  Arndt Schuebel
 <Arndt.Schuebel@onsemi.com>, Parthiban.Veerasooran@microchip.com
Date: Tue, 19 Sep 2023 11:47:30 +0200
In-Reply-To: <ZQkNfAOYgsBIhBRW@lopingdog.com>
References: <ZQf1QwNzK5jjOWk9@lopingdog.com>
	 <6e19020f-10ff-429b-8df3-cad5e5624e01@lunn.ch>
	 <ZQkNfAOYgsBIhBRW@lopingdog.com>
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

On Mon, 2023-09-18 at 21:54 -0500, Jay Monkman wrote:
> On Mon, Sep 18, 2023 at 06:00:37PM +0200, Andrew Lunn wrote:
> > Is this an OA TC6 device?  At a quick look it does appear to
> > be. Please make use of the framework Microchip is developing:
> >=20
> > https://lore.kernel.org/netdev/20230908142919.14849-4-Parthiban.Veeraso=
oran@microchip.com/T/
>=20
> Yes it is. I wasn't aware of Microchip's work. Thanks for pointing it out=
.

I guess this patch is going to change a lot in future revisions...

Please double check the code with checkpatch before the next
submission, there are a few things that could be improved.

Specifically, avoid c++ style comments, and avoid using multiple label
names to jump into the same location - selecting the label name as the
target action will make the code more clear.

Thanks,

Paolo


