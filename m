Return-Path: <netdev+bounces-38433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7CC7BAEA2
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 00:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A57B2281EF1
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931FD42BED;
	Thu,  5 Oct 2023 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgTtaq+h"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B212B74
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 22:10:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C696D8
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696543827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aHMrxnKFRL8eZP2ZR9DPlVMl+BHWqD42jAitaZoUq8=;
	b=IgTtaq+h5aEYICoufoyjroedUcpeVJNDzUtZpoOoV8OWD2w3dTmHjvOWYXQE1C4McsmHKN
	M4sV9rrxpQAFRdYv59NsKBxqtc/J8IHexCR9XEE/8cGnF2n3HFLhCkBsHFrZkUSJhZBlu7
	746xVXbzQ9SpsBSo7YV4YHpNm4xWnZI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-m37Rbf_uPQiCGkj5tHngIw-1; Thu, 05 Oct 2023 18:10:25 -0400
X-MC-Unique: m37Rbf_uPQiCGkj5tHngIw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-533ca50404bso1187213a12.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 15:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696543824; x=1697148624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aHMrxnKFRL8eZP2ZR9DPlVMl+BHWqD42jAitaZoUq8=;
        b=BZNCGVDyUHkkIemnbnHEZDunijFydRYswKMtfpF9KhxlNcOptF34zoJJ39306w+maW
         wXOfYBaB6+NevliBW2GqmUzgaXLpmOXI9eNEz3n4iNJ4eBmO1hzmtNlULT1QMjk3i9dY
         L1DeBys2losvoWv/oU4LsADIro/r3gQFq/eb/atf5krmt1Lc08Nkk/e7z3CnFG4Tx0I3
         3GlOm8XHJZOGLDsj3W7qQMX2SJDUkCaP9ITR0A5MH6AMavtpWPo8TRBAt5/St8Evnw6M
         mYUy9KvgLk1b0Ht6gEyTW5hRs1kziG7wtGvD8sxzeguWazxAsSCIW2sYdLCGHgYHNAxM
         qGHw==
X-Gm-Message-State: AOJu0YyjEuBfswYEPzQ4Wf6oIwLRuSBVCyLq4qIH3gl1V+DyslzxliOk
	Fk/Ou0kd9UhyluGiFsgo2cBcmiGh/jSYYLmw0Ou06dWgLnaVVs/YNEIYSCWpo97o5iREQa+s6l1
	8cJWNdMw/iQHkHqwhLKi2CdZLklp2dtx0
X-Received: by 2002:aa7:d615:0:b0:52b:db31:3c48 with SMTP id c21-20020aa7d615000000b0052bdb313c48mr5783984edr.0.1696543824465;
        Thu, 05 Oct 2023 15:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpNdCbvG6JhfAS3lwMZiyvboAoUGjRJHfOGjkHcza1InSbT5oi3sklaEIketz0hkFWheMaLuZomkliQzgw6to=
X-Received: by 2002:aa7:d615:0:b0:52b:db31:3c48 with SMTP id
 c21-20020aa7d615000000b0052bdb313c48mr5783968edr.0.1696543824238; Thu, 05 Oct
 2023 15:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c91e145-5cd5-4d9d-9590-3b74b811436a@moroto.mountain>
In-Reply-To: <3c91e145-5cd5-4d9d-9590-3b74b811436a@moroto.mountain>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 5 Oct 2023 18:10:13 -0400
Message-ID: <CAK-6q+iG=jX0qudCcszP64HxCwYSpmx7=Fh+Kf3qVft7Z8hBfg@mail.gmail.com>
Subject: Re: [PATCH net] 6lowpan: fix double free in lowpan_frag_rcv()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Angus Chen <angus.chen@jaguarmicro.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Joel Granados <joel.granados@gmail.com>, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
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

On Wed, Oct 4, 2023 at 5:22=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The skb() is freed by the caller in lowpan_invoke_rx_handlers() so this
> free is a double free.
>

lowpan_frag_rcv() does not call lowpan_invoke_rx_handlers(), it calls
lowpan_invoke_frag_rx_handlers(), or is there something I overlooked
here?

- Alex


