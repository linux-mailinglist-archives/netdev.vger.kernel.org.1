Return-Path: <netdev+bounces-32385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A579734A
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2095E2815FF
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5BD11C97;
	Thu,  7 Sep 2023 15:22:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333C23C3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:22:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5DFCC
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694100127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmpf61eV7S1do3E0eIiuu766NL4mEhMYhw2v0xFldvo=;
	b=FwdlOaj74qs5TVLYx8tawHGJ7nOysX7osakG0pMR3Es51XU+kWOZ/SQUJOt7iUq09kwTkf
	QPB+1JwNjtFrR3Gp5+yWEO9iayCKCBJ/xYQ9uUGEEWnHwn96GnY+Cu3HSR58k1bMR5gPgG
	L8j/iVKo/pFBI1DrHB2vZjMYGUD6PHg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-XrkK-wvQM1SjFm4XywlqTQ-1; Thu, 07 Sep 2023 07:03:56 -0400
X-MC-Unique: XrkK-wvQM1SjFm4XywlqTQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a5c5f0364dso18736666b.0
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 04:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694084635; x=1694689435;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmpf61eV7S1do3E0eIiuu766NL4mEhMYhw2v0xFldvo=;
        b=NAk6R7mCVDo6LVfN+H+RKd+BRpYUJ+ABDwR+7w4ny3WALKzpLF+7FCX/CERsL6eKiE
         YspWrNWKzSSm13Bv8176j8PVZ/J83KWIhuLYRj+hH1dLQRZ72rUIKfQnNyxiRTaDv7SC
         0aD0D6HQNF16MOAe3p4EgSpiQ6yntbCiOWThj0drahg0piuO0Iapv8zwwQjuNIcb82Cv
         2etmG+i06jEW5IAh87Z4kuNe6BofruPK25b9lpBEpELBoWEZAME8F1S7WdWtbLK2u21j
         oAOXCaOuzzOPCx9i78z1V83HcK5J8mXVbeTgZG5Y22shHbINBKgvOrWE/3McDr3/JOfy
         AlTA==
X-Gm-Message-State: AOJu0YzH88Qmjf6X5et9R6N9NGEONzHNJxCeJDZm/j5kvfSNKb6Ex2NQ
	1J0NDgK4LHawJZqVp001O0aSOdq67pn0U1FQeRii95B02975vh+l5C7TNVdULtIiOmNJ4nZLa0L
	vZunokVwreUWuns9/
X-Received: by 2002:a17:906:db:b0:9a5:9038:b1e1 with SMTP id 27-20020a17090600db00b009a59038b1e1mr14440954eji.2.1694084635124;
        Thu, 07 Sep 2023 04:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvNO4RadGZXmyyuXnU5lWN3oiVC1Z2/ox8TFnQe9Oc3q/2wn5hkuRR27s1AMrzP3vnGg9Tfw==
X-Received: by 2002:a17:906:db:b0:9a5:9038:b1e1 with SMTP id 27-20020a17090600db00b009a59038b1e1mr14440930eji.2.1694084634759;
        Thu, 07 Sep 2023 04:03:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-112.dyn.eolo.it. [146.241.251.112])
        by smtp.gmail.com with ESMTPSA id l23-20020a1709060e1700b00991e2b5a27dsm10214501eji.37.2023.09.07.04.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 04:03:54 -0700 (PDT)
Message-ID: <ecde5e34c6f3a8182f588b3c1352bf78b69ff206.camel@redhat.com>
Subject: Re: [PATCH] don't assume the existence of skb->dev when trying to
 reset ip_options in ipv4_send_dest_unreach
From: Paolo Abeni <pabeni@redhat.com>
To: Kyle Zeng <zengyhkyle@gmail.com>, davem@davemloft.net,
 dsahern@kernel.org,  netdev@vger.kernel.org
Cc: ssuryaextr@gmail.com
Date: Thu, 07 Sep 2023 13:03:52 +0200
In-Reply-To: <ZPk41vtxHK/YnFUs@westworld>
References: <ZPk41vtxHK/YnFUs@westworld>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-09-06 at 19:43 -0700, Kyle Zeng wrote:
> Currently, we assume the skb is associated with a device before calling _=
_ip_options_compile, which is not always the case if it is re-routed by ipv=
s.
> When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
> Since we know that all the options will be set to IPOPT_END, which does
> not depend on struct net, we pass NULL to it.

It's not clear to me why we can infer the above. Possibly would be more
safe to skip entirely the __ip_options_compile() call?!?

Please at least clarify the changelog and trim it to 72 chars.=C2=A0

Additionally trim the subj to the same len and include the target tree
(net) into the subj prefix.

Thanks!

Paolo


