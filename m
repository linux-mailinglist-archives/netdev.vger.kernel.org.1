Return-Path: <netdev+bounces-23579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CE76C903
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A201C21147
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD465685;
	Wed,  2 Aug 2023 09:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7253B9
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:10:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CAF272A
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 02:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690967412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oWHTeJvlnm0jf1/cFsO139/8A/ikDQpPTfQfteJUZYo=;
	b=GV/qzRW/DQovR87c2Qm1lcKTSqan8wf4GJOM5rRIROxK1m0yO78uWiNMx5V7mPNofyGIU8
	TjcQOVXfoR9vkC6s82NFZQcfOY0wyjcd+ZdOWidRCFsbuNpVJq6HmpFylPKgVj+kWoDb9b
	Nk+yzG9rU7GSpYknpEbBusHD9U47GjY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-muZ8nDGtPlWGfABV2Z3o_w-1; Wed, 02 Aug 2023 05:10:11 -0400
X-MC-Unique: muZ8nDGtPlWGfABV2Z3o_w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fd306fa3edso17924565e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 02:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690967410; x=1691572210;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWHTeJvlnm0jf1/cFsO139/8A/ikDQpPTfQfteJUZYo=;
        b=ksoEfk5GxkFXsjlVJLsoFv7PT+uGETNLp6wtnnZj3py1aLYL6E7zc8so6y/hMPpTgh
         0gYV75rYchABTHLj+MmSt8nWhUOxUVewHYGF4PbNJVwIWogP5yH8dm7EVCnpMPDnk0TO
         lmp5jeFGn6JmiFfpkEj3VqOb1wwoxulxtCBsqnTxC6l0cgTshMSVPC8DgiCYydF6xEFj
         Y8Pv8i94r4nFKKe6SDijsiK8MqcJQhMdBhw8SCouZ3snCabJ6u1OwFlLOW3svlIfBEii
         aIToxLZLA1Yyg3epjeJcxsViW1n8h3GI8fMjDaCV4MqI334GttcrVIK2+EujIj6/lOnh
         40JA==
X-Gm-Message-State: ABy/qLZUNva8E9mvcaXH6/3gApxMhYnvZWZfo8slX/A7A2L+fevvWj1T
	k8YkxDyTq1SbJC28bDfJpXS3IoKeyi/AMh1IhAlcbY8QALcDEkGgKatr874wljBk0g8aoTk5CKO
	0Z4xqhQew+F00h76F9s9hhXq01qs=
X-Received: by 2002:a5d:46cf:0:b0:317:57ec:4c3d with SMTP id g15-20020a5d46cf000000b0031757ec4c3dmr9887388wrs.0.1690967409889;
        Wed, 02 Aug 2023 02:10:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzDKXYVTrlOAYDKbFJqPKzLJ8XbucCExCNBYZSoJb1dQSUhPeSN8MWCYfbQrXtZHzj+m7phw==
X-Received: by 2002:a5d:46cf:0:b0:317:57ec:4c3d with SMTP id g15-20020a5d46cf000000b0031757ec4c3dmr9887372wrs.0.1690967409645;
        Wed, 02 Aug 2023 02:10:09 -0700 (PDT)
Received: from [10.0.0.196] ([37.186.180.70])
        by smtp.gmail.com with ESMTPSA id o3-20020adfe803000000b003143b7449ffsm14693312wrm.25.2023.08.02.02.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:10:09 -0700 (PDT)
Message-ID: <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
From: Thomas Haller <thaller@redhat.com>
To: David Ahern <dsahern@kernel.org>, nicolas.dichtel@6wind.com, Stephen
	Hemminger <stephen@networkplumber.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Date: Wed, 02 Aug 2023 11:10:08 +0200
In-Reply-To: <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
References: <ZLZnGkMxI+T8gFQK@shredder>
	 <20230718085814.4301b9dd@hermes.local> <ZLjncWOL+FvtaHcP@Laptop-X1>
	 <ZLlE5of1Sw1pMPlM@shredder> <ZLngmOaz24y5yLz8@Laptop-X1>
	 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
	 <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
	 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
	 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
	 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
	 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-07-28 at 09:42 -0600, David Ahern wrote:
> On 7/28/23 7:01 AM, Nicolas Dichtel wrote:
>=20
> > Managing a cache with this is not so obvious =F0=9F=98=89
>=20
>=20
> FRR works well with Linux at this point,=C2=A0

Interesting. Do you have a bit more information?

> and libnl's caching was updated
> ad fixed by folks from Cumulus Networks so it should be a good too.


Which "libnl" do you mean?

Route caching in libnl3 upstream is very broken (which I am to blame
for, as I am the maintainer).


Thomas


