Return-Path: <netdev+bounces-36052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFBC7ACBD7
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 22:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4F5AF1C203DB
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF65DF55;
	Sun, 24 Sep 2023 20:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D6B17DB
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 20:42:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F510E8
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695588165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CMK6+D/DgFWvrNdQUdUJNb6VjX8q7HdCwOuehSf+ek=;
	b=gbEDMBMUCXN6mVv9W0QeY/+KHkYueiY/jVlwRXid5kZe2KrFOLle0z72QWOYinAeWmzQIB
	3oRdDkY0avzpmaz3vTM8wQFdieoklLw0i16VXviXWXkn0J6XdgWINbUAz+3u8Wt49tB4fz
	Rh/r1MS8C7YunyOlBaxfgr3gmHJzPc8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-bDcZnQ_zOtS9p3yMgfAviA-1; Sun, 24 Sep 2023 16:42:44 -0400
X-MC-Unique: bDcZnQ_zOtS9p3yMgfAviA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-53342507b32so9921395a12.0
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 13:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695588162; x=1696192962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CMK6+D/DgFWvrNdQUdUJNb6VjX8q7HdCwOuehSf+ek=;
        b=fDivvAqspyBI66UjSAgFBhtUqacoc4vdn1r6JtAtNB6F554AFe7lXHRXxtKFGNI+bP
         fC1Gf+BM9Rwj3xlyjjRcx239DPxF57VofQPSIu2c/lWmOHOsqUD7h1vl/uTiPCtu7mKI
         VacihoM0upJZBxnbkmeJUJRZMc45QY8TOlJjbBspVxUH5dVkWyZiymBWsiFNpazyIo4x
         RQIs5gkh+2Q5skIdBpeHts1rClFOYcIFnwU/Ivcsrd/3lhj4SaMg/40MzP/GtsUuxBGU
         /ZFmkKJ3p5wfA78byxx6vHvCbXcct3oxwSkOcqTLgI47Y07z9sFs5mWlei9LY3BIfdPm
         csGA==
X-Gm-Message-State: AOJu0YzqGmpISZBK0J9fqcge8pQUCbLfeSHh7xJXz7exB6SdUURcmhic
	8rgLL4QGSz6Q0uEcBY7yeICs0S3Z1FFuFmLg/LV8DTOEVIyCJf+8rOYzaggXaG6rLIVO0s0XbI5
	ObQADEyoKNSmoyiBak74RhzgBLKTMdDlQ67Phj1ZaJwA=
X-Received: by 2002:a05:6402:160b:b0:523:37f0:2d12 with SMTP id f11-20020a056402160b00b0052337f02d12mr7496631edv.17.1695588162709;
        Sun, 24 Sep 2023 13:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWcMWKTmSN0kfTv00wCDASzN2wCDt8EDegGAnZ0NNKGCiS3pibO67/pkAQnxbR7S/Utqic+SK40DtF1lRCpbU=
X-Received: by 2002:a05:6402:160b:b0:523:37f0:2d12 with SMTP id
 f11-20020a056402160b00b0052337f02d12mr7496623edv.17.1695588162402; Sun, 24
 Sep 2023 13:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com> <20230922155029.592018-2-miquel.raynal@bootlin.com>
In-Reply-To: <20230922155029.592018-2-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 24 Sep 2023 16:42:31 -0400
Message-ID: <CAK-6q+i_fVbj3ceMcCA8F-6aRcX2YX8+iMdQSYmQ7FWLNKfP+g@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 01/11] ieee802154: Let PAN IDs be reset
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, 
	Romuald Despres <romuald.despres@qorvo.com>, Frederic Blain <frederic.blain@qorvo.com>, 
	Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem Imberton <guilhem.imberton@qorvo.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, Sep 22, 2023 at 11:50=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Soon association and disassociation will be implemented, which will
> require to be able to either change the PAN ID from 0xFFFF to a real
> value when association succeeded, or to reset the PAN ID to 0xFFFF upon
> disassociation. Let's allow to do that manually for now.
>

ok. But keep in mind what happens when a device is associated and the
user sets a short address manually to 0xFFFF?

It should be a kind of forced mode of disassociation?

- Alex


