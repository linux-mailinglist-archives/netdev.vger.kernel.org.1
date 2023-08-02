Return-Path: <netdev+bounces-23572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE5A76C8C0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2748F281C6B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404295661;
	Wed,  2 Aug 2023 08:52:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B35231
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:52:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1A02701
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690966370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cn4kJjpkm69CQ0RSdkCnqj4AMkcoOLWrcrLXN+EI5z8=;
	b=CRGsYIQLjXZ2OLxgInNaaxLS0DoHyPuGPLjphAuYxnv1nOpxSMBGHXkLGTOLLznEccxY+S
	cQECqs6SO4Ncs/j64xmXQiGXNtKkGqCsEc3PR5SOovnKtnIYmy+H3hO5lUumwLF4OFneMX
	eGgbMuBQKvg8T1iNtrB4N4CrcuMK5N0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-ezbckxUZPcmGUg3BsfB20Q-1; Wed, 02 Aug 2023 04:52:48 -0400
X-MC-Unique: ezbckxUZPcmGUg3BsfB20Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b8405aace3so61064341fa.3
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 01:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690966366; x=1691571166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cn4kJjpkm69CQ0RSdkCnqj4AMkcoOLWrcrLXN+EI5z8=;
        b=BlwFpiOcUvNEi37ob6dnf9WKXMLXvVK45sN2CifLUh/c6hZOCqUZ/LiouEyY0IoxBj
         c8OpQ2bVhEFFd/JNRKHzN2BbWLy/oAFbSrDC+9tJo+nbysd8L9owc0XnGQIpdCdfkKcm
         vNs7wSECvkFKq/KQ8y+JUVNugHWruxgODxDQyFNajestiZtoKfn3s87kx+fKsGjJAwW8
         3DOT6Udim5JpK8P/WsmQkqxJCFaLTHJCWeZL8wcAvQRm/CnXKvLejaWPQtaiL/Iy2VcH
         P0EhLPiqF7GPULPhSUpNuBpZs6uHmowrfCHSAU1MumVbaD3p5wo33oG9ZXwOqsoI7bGA
         +7Aw==
X-Gm-Message-State: ABy/qLZtbAS/4eofvx/y6ir3lXfnWeRr2cbG9uUFYXUQ2MrMUhZOkiuD
	tfx/H3+uQpnmoOZwuFY665RglaSkKIsPcRP8XZUzzdCNiHRStcKkyU/U7KJFjYryw2/SxvLUY80
	D9iM+zqaouKeLvhga3Wkb2F9LqlK19ypNYRbpsy8a2qE=
X-Received: by 2002:a05:6512:ba7:b0:4f8:49a8:a0e2 with SMTP id b39-20020a0565120ba700b004f849a8a0e2mr5722514lfv.16.1690966365988;
        Wed, 02 Aug 2023 01:52:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmAYhXgEfX/ZHs0nEJbO62OlfGK31XNo/obkKMuwsTFlv9NZBzpnPkC0s74alszt9tB93TIXdi/KBdWuoIyX4=
X-Received: by 2002:a05:6512:ba7:b0:4f8:49a8:a0e2 with SMTP id
 b39-20020a0565120ba700b004f849a8a0e2mr5722503lfv.16.1690966365686; Wed, 02
 Aug 2023 01:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802075118.409395-1-idosch@nvidia.com> <20230802075118.409395-14-idosch@nvidia.com>
 <ZMoUPP53JWP7l2pG@dcaratti.users.ipa.redhat.com> <ZMoV1M7Jm51TPtBZ@shredder>
In-Reply-To: <ZMoV1M7Jm51TPtBZ@shredder>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 2 Aug 2023 10:52:34 +0200
Message-ID: <CAKa-r6uFNPa9TtY35LWypRr70Tzo1M+S=yJKea7p8oNjnixvzg@mail.gmail.com>
Subject: Re: [PATCH net 13/17] selftests: forwarding: tc_tunnel_key: Make
 filters more specific
To: Ido Schimmel <idosch@idosch.org>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com, 
	razor@blackwall.org, mirsad.todorovac@alu.unizg.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 10:38=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Wed, Aug 02, 2023 at 10:30:52AM +0200, Davide Caratti wrote:

[...]

> >
> > hello Ido, my 2 cents:
> >
> > is it safe to match on the UDP protocol without changing the mausezahn
> > command line? I see that it's generating generic IP packets at the
> > moment (i.e. it does '-t ip'). Maybe it's more robust to change
> > the test to generate ICMP and then match on the ICMP protocol?
>
> My understanding of the test is that it's transmitting IP packets on the
> VXLAN device and what $swp1 sees are the encapsulated packets (UDP).
>

Ah, right :) sorry for the noise!

Acked-by: Davide Caratti <dcaratti@redhat.com>


