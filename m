Return-Path: <netdev+bounces-39948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3397C4FC9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155C3281D87
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 10:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EFD1DA41;
	Wed, 11 Oct 2023 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOyIQ4r+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02801CFBE
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:13:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBAA92
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697019200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLI+gNG/Ik5TmE6Ss6b86D5IYiR1FClxUP9y17ZJqCA=;
	b=EOyIQ4r+d4DqbIdUw1cLWbfBRYqYDdHDer+a0wnDqI+/uVpeSWRrk47/shhr9yKKtPEwnS
	w2hj0/baw3OM/Gu20YCcLXwtTUSrjAQldQfPi551+nYajIVkGw+egw0s2ZsiqVo1UQBrNA
	DKhQ22nIREL2p3gg0V+pUQmCgvaQO8g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-HkqWGfsGPle0qX1RoxQjVg-1; Wed, 11 Oct 2023 06:13:18 -0400
X-MC-Unique: HkqWGfsGPle0qX1RoxQjVg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c296e65035so58465491fa.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697019197; x=1697623997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLI+gNG/Ik5TmE6Ss6b86D5IYiR1FClxUP9y17ZJqCA=;
        b=bbikHl7xWhHp05lLlb4pmKN2Zftgfm5/LNtz2wbX1o9yEDSGtRv+L+TufeMypcD7qw
         B+0gBnweJoXybOToyT89s0wh4DT550xywvMG+UbvfHGyndNVsaNBxzmkkNk3Xqfsb+ba
         PlUibxFZNlHL1ZWk6vJck9p2lYgvxEYDDVn5TdRvQKZMV7hXtf7EwsS2yJgWHxeBZtB9
         3wK2n8wnJrYxqTSSowyvrDIh/OF3CW48/dm5j+M3NZO4wdvyxpnMSDY3cXDcCzNUoaLG
         4nL3bxhn/8642YnsEjC3A7qzCbj5fleSylvc6/yUVe1rKlnhwAH1gaoi6hiRuAfcOmUo
         2BSw==
X-Gm-Message-State: AOJu0Yz8PAxn3UpzFXC8XFG/JANdzB9URglWKwETqsGMVrr1KWbzPS3o
	nS5sdgin6dJXkqICSAYib7by1c4GeYV9bgentPpYBsJoFpNc4/f/qmYhLx3gfvoLAP7FA9lTjky
	Et0p60kxOEr3VqxDVDfl5eU9+MSp4xo/1
X-Received: by 2002:a2e:9001:0:b0:2c1:7df1:14a6 with SMTP id h1-20020a2e9001000000b002c17df114a6mr18885593ljg.9.1697019197156;
        Wed, 11 Oct 2023 03:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzgFBh7dpGZLMqhPmRhYZgbEoyXO+JEnPZeVd6y4j9UPTWyTctRlSWKtNno+D+4ydHwjWMyyV7Txz55onCUho=
X-Received: by 2002:a2e:9001:0:b0:2c1:7df1:14a6 with SMTP id
 h1-20020a2e9001000000b002c17df114a6mr18885577ljg.9.1697019196839; Wed, 11 Oct
 2023 03:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
 <20231010-upstream-net-next-20231006-mptcp-ynl-v1-3-18dd117e8f50@kernel.org> <20231010180839.0617d61d@kernel.org>
In-Reply-To: <20231010180839.0617d61d@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 11 Oct 2023 12:13:04 +0200
Message-ID: <CAKa-r6sT=WaTFqumYOEzOKWZoUi0KQ8EYpQ753+C5JjjsUb3wA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] Documentation: netlink: add a YAML spec for mptcp
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

hello, Jakub, thanks for looking at this!

On Wed, Oct 11, 2023 at 3:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 10 Oct 2023 21:21:44 +0200 Matthieu Baerts wrote:
> > +definitions:
> > +  -
> > +    type: enum
> > +    name: event-type
> > +    enum-name: mptcp_event_type
> > +    name-prefix: mptcp_event_
>
> I think you can use - instead of _ here.
> For consistency with other families?

right, I will convert the whole spec.

>
> > +    entries:
> > +     -
> > +      name: unspec
> > +      value: 0
>
> 90% sure enums still start at 0, only attrs and msgs now default to 1.

Just checked, value:0 is not needed for enums: I will remove it

> > +     -
> > +      name: announced
> > +      value: 6
> > +      doc:
> > +        token, rem_id, family, daddr4 | daddr6 [, dport]
> > +        A new address has been announced by the peer.
> > +     -
> > +      name: removed
> > +      value: 7
>
> Follows 6 so no need for value?

correct, will fix this too

> > +      -
> > +        name: addr6
> > +        type: binary
> > +        checks:
> > +          min-len: 16
>
> Do you not want the exact length for this?
> If YNL doesn't support something just LMK, we add stuff as needed..

ohh yes, we had NLA_POLICY_EXACT_LEN before but ynl doesn't seem to
support it. I can try to add the support and include another patch at
the beginning of the series, is that ok?

--=20
davide


