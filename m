Return-Path: <netdev+bounces-36391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D47AF7B4
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 03:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 6C0661C2083A
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 01:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5BE186A;
	Wed, 27 Sep 2023 01:37:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C499804
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:37:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A7B5277
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 18:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695778658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FSPOrGsZPPuOb1xbGdmbpSAkvWmok6p4XRywUEGr6A=;
	b=d7ChtemhJrKJqVJIiZCKVYpqBCRpPCbf2zsXlsonUl0RfpTkMzHXjf7eE9ITqX1F+9ZR+N
	UbSoQqZ3jXbX+uhjKHQYVoYfnRjLu5FhBjxm04bUcgiDmJir4nfU5OYgAQMTvzyQUF8oqf
	AkZx8X/MQSmwqc8DCic73m8qYX6EAUQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-nuZj3bumMr2MpdWIIK-dUQ-1; Tue, 26 Sep 2023 21:37:35 -0400
X-MC-Unique: nuZj3bumMr2MpdWIIK-dUQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b282c72954so466720366b.3
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 18:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695778654; x=1696383454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FSPOrGsZPPuOb1xbGdmbpSAkvWmok6p4XRywUEGr6A=;
        b=HDE+TRZIlXO1V5JKa1FWvQWkcWHWGwlPpHWgje2FYeU4ArtWEr673uTpoZrmA49zwH
         cDSySET373eevrqC90MGnkNkhbLuVbeN1yp3d51o7013sTtxrpRGnYF0siecZGTTVC0y
         nmE8SEz+ksiFDGaHoJAyeRIcyqFOmW8auF0ZQT+gJ0dpHzwV75WWc05whNh26vMPB0K7
         fijyva5Cw2OsDfkuz47HlKw76XjWRhc33shzFmv3nBzDiPLQ0WefShpkH/Vw8qyNoVnW
         YVmxo7kets+u0Ph3mGjJLlsfSM+cb0XcRUwj2XHIgeOpdDyEYsZJ0cWwfjK776TqWJ1c
         AObg==
X-Gm-Message-State: AOJu0YzC/wz3eo+933owjz8ZrrslUCvUGL+2MP9uRBlP7sHsFdwjlPA9
	dbUR3XhrLrRr/JlzpkC5G10dnTRKqJf+6dO3QxetFOCqwJLJktjuoEFxRYtJLi2zXvLI6g+HTPS
	xuGDLBVEEQ21LNVK+EcfE7knvFegtHeVj
X-Received: by 2002:a17:906:5dae:b0:9a1:ea01:35b1 with SMTP id n14-20020a1709065dae00b009a1ea0135b1mr303919ejv.62.1695778654754;
        Tue, 26 Sep 2023 18:37:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFo3vNisBp7330YnyG4faJfX+OOPuaqXwu9lTZhRetZ+vqzEwSOWdTF5BN2y7CPnYMMgixy3MJG1blaQjXsgE=
X-Received: by 2002:a17:906:5dae:b0:9a1:ea01:35b1 with SMTP id
 n14-20020a1709065dae00b009a1ea0135b1mr303908ejv.62.1695778654503; Tue, 26 Sep
 2023 18:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com> <20230922155029.592018-8-miquel.raynal@bootlin.com>
In-Reply-To: <20230922155029.592018-8-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 26 Sep 2023 21:37:23 -0400
Message-ID: <CAK-6q+j_vgK_5JQH0YZbqZq30J3eGccMdwB-AHKV6pQKJGmMwA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 07/11] mac802154: Handle association requests
 from peers
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, Sep 22, 2023 at 11:51=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Coordinators may have to handle association requests from peers which
> want to join the PAN. The logic involves:
> - Acknowledging the request (done by hardware)
> - If requested, a random short address that is free on this PAN should
>   be chosen for the device.
> - Sending an association response with the short address allocated for
>   the peer and expecting it to be ack'ed.
>
> If anything fails during this procedure, the peer is considered not
> associated.

I thought a coordinator can also reject requests for _any_ reason and
it's very user specific whatever that reason is.

If we have such a case (that it is very user specific what to do
exactly) this should be able to be controlled by the user space to
have there a logic to tell the kernel to accept or reject the
association.

However, I am fine with this solution, but I think we might want to
change this behaviour in the future so that an application in the user
space has the logic to tell the kernel to accept or reject an
association. That would make sense?

- Alex


