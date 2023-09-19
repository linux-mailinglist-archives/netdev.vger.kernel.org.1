Return-Path: <netdev+bounces-34976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5C7A64AF
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A988B28144A
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818EF30F8C;
	Tue, 19 Sep 2023 13:20:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28D1863B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 13:20:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269AFF0
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695129599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htK7pnwIzqRDFi5FwPMaJzCXKtfTe2X9wFdfV0qhhDg=;
	b=dTbZx3yPdrjyksWEVcMmG9mQvP6WFbfKPi1PXwWmBmSuoNINoF228/lEGwmclizgDPlhay
	+fLBB8yPUCn16wHvKZ68o4o6bTt03xWAnZhwrTl0o2pTABfngezzmR9QPvk75QMSpaiJXN
	jsQ3b9KgRoMykULEvIx8uHuZ251fask=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-uaFrIYf2NNS2o-0saLiztw-1; Tue, 19 Sep 2023 09:19:57 -0400
X-MC-Unique: uaFrIYf2NNS2o-0saLiztw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-320089dad3cso109970f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129596; x=1695734396;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htK7pnwIzqRDFi5FwPMaJzCXKtfTe2X9wFdfV0qhhDg=;
        b=vW031FRqB+VjQ4hV3RS1U34wQ2xRPhV/3Qu7Q4mer4PYEQ46T0+3AaGz2957YIFlCo
         SyS9TwQ0678i1F5TFBexmeqa0B28RoSSFctfl0HXcw+U+Jk0g7Gm1rHaqeyyUkopw4wF
         ZSTkbj4bZU0X9eZ0yAEOGwtffBg7bInKBEJXD0DITJ+3Do+U8DAs2eBYsv+8cD3nmhzo
         lvljtpQbRyoD9P7G0Ne4UZ0kYMM5mMNRj00lNM6h5JbEWCFG5hTzU0fTX1YXeGayRKA8
         /9DC1UasTtRRZyFtY4fguWUPI7/Yhi52tO9EeA/gdw9YPQrOK0FmMfo2DQCDFdea/mkD
         UZYA==
X-Gm-Message-State: AOJu0Yw9hBjWC8sF36YtMWImcAr6I972zHU6YVi/2Ez+73p1FYyzwCsP
	39MGA0Qk4bjoAshJDPUcxTkVHvsHniUwWSn37yTrWTSjY/RI3PN7St5BZbGuc/XNDKiCbSZLOkP
	WsNLICfHAXVRP9hNG
X-Received: by 2002:adf:ecc7:0:b0:31f:899b:a47 with SMTP id s7-20020adfecc7000000b0031f899b0a47mr10072504wro.4.1695129596646;
        Tue, 19 Sep 2023 06:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvl5GMANKuJZvPgoz3bArRsym+FAKYbCuhPA1oJy7XAET85TTZwn7Qk9G/FVTxfAXX1wyEcg==
X-Received: by 2002:adf:ecc7:0:b0:31f:899b:a47 with SMTP id s7-20020adfecc7000000b0031f899b0a47mr10072490wro.4.1695129596314;
        Tue, 19 Sep 2023 06:19:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b0099bd453357esm7754752ejb.41.2023.09.19.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:19:55 -0700 (PDT)
Message-ID: <a5b25ee07245125fac4bbdc3b3604758251907d2.camel@redhat.com>
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
From: Paolo Abeni <pabeni@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Arseniy Krasnov
	 <avkrasnov@salutedevices.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, Bobby Eshleman
	 <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru, oxffffaa@gmail.com
Date: Tue, 19 Sep 2023 15:19:54 +0200
In-Reply-To: <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
	 <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
	 <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-19 at 09:54 +0200, Stefano Garzarella wrote:
> On Mon, Sep 18, 2023 at 07:56:00PM +0300, Arseniy Krasnov wrote:
> > Hi Stefano,
> >=20
> > thanks for review! So when this patchset will be merged to net-next,
> > I'll start sending next part of MSG_ZEROCOPY patchset, e.g. AF_VSOCK +
> > Documentation/ patches.
>=20
> Ack, if it is not a very big series, maybe better to include also the
> tests so we can run them before merge the feature.

I understand that at least 2 follow-up series are waiting for this, one
of them targeting net-next and the bigger one targeting the virtio
tree. Am I correct?

DaveM suggests this should go via the virtio tree, too. Any different
opinion?

Thanks!

Paolo


