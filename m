Return-Path: <netdev+bounces-36731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF787B1820
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 1E6651C20852
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41834347CC;
	Thu, 28 Sep 2023 10:15:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BCD8821
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 10:15:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEBE9C
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695896126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9zsNLbLnCU4lNBdlZw/DGhkUiRnbBbJJ8YLzQ651Dc=;
	b=HNgvlUE549/Co1Le82/JF4KtkKVD7+XI6+fHImfp1LZvmbqq34JGWxLP7dZcVQtx18auv0
	9EugPFkvcBl5u/h3x3dcBcVgYCSfQILr6brVg/uPmQzkD44zp5LIHpsS3Y91S1u1adUIE2
	xHWdnIdBVy3rbtPPLDIroeyOoHIO5UY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-fE7gk3gVO1WyVhTmJuKDdg-1; Thu, 28 Sep 2023 06:15:25 -0400
X-MC-Unique: fE7gk3gVO1WyVhTmJuKDdg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae5f4ebe7eso266699066b.0
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695896124; x=1696500924;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9zsNLbLnCU4lNBdlZw/DGhkUiRnbBbJJ8YLzQ651Dc=;
        b=Lu2GOmjf0L5EjCrkTpRCzfIdsuexSwj/C9mPP8R7L+cbvh66ehaCzKZOTIXFxC2H7a
         tl658yJ6RtdzwTiGzGuM6CjxLmK7pfMrNBDuAVjqnx7/EdY6Kr49EU7lsjnJB4Yjg8iI
         tt7apuuNYwL5BMjb/f34XJh986D5ZqxE4Nxti3K/jNEqdx799SR09zk35ED2Mjv2Y/pT
         kyPC6Ok78NXEfHeBjsMkmpOI6nGcQo9aeiusbCUc6HZ+o6ERW12v56IvTpYt8zEAElLq
         6Rt3+KckYroO+OUn1wZ/YGfYrSpnC6qyDynT0djF4fUv6HbP+VN0F+4aI9tEhxMpgS8M
         Pdlw==
X-Gm-Message-State: AOJu0YzMe9um2ztOAdh4j+e14JNdMbB7mvgz2yr3/rba9tYaoShd316T
	Z5p4LdYe5HKrQ44TG+WzSIyHXbKcCCSOElFyXJkbnONy+XczT2+mNu2W9EZMdwBUvGETG6Lmk3w
	gcm9CROstfQA1d5ZHLj6v8jSQCwU=
X-Received: by 2002:a17:906:24e:b0:9b1:488d:afd1 with SMTP id 14-20020a170906024e00b009b1488dafd1mr838490ejl.5.1695896124010;
        Thu, 28 Sep 2023 03:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAsw29MLED9uSlH01enxXplGNM1b5fgpauKcGu9LsqFVLjcwRFT9XuOIRpAUQiwxX50SvEJw==
X-Received: by 2002:a17:906:24e:b0:9b1:488d:afd1 with SMTP id 14-20020a170906024e00b009b1488dafd1mr838469ejl.5.1695896123587;
        Thu, 28 Sep 2023 03:15:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-183.dyn.eolo.it. [146.241.233.183])
        by smtp.gmail.com with ESMTPSA id o24-20020a1709064f9800b0099cce6f7d50sm10748324eju.64.2023.09.28.03.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 03:15:23 -0700 (PDT)
Message-ID: <ffeeac4ea45e5a087aab44ac137a945111d941e7.camel@redhat.com>
Subject: Re: [patch net-next] tools: ynl-gen: lift type requirement for
 attribute subsets
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com
Date: Thu, 28 Sep 2023 12:15:22 +0200
In-Reply-To: <20230919142139.1167653-1-jiri@resnulli.us>
References: <20230919142139.1167653-1-jiri@resnulli.us>
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

On Tue, 2023-09-19 at 16:21 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> In case an attribute is used in a subset, the type has to be currently
> specified. As the attribute is already defined in the original set, this
> is a redundant information in yaml file, moreover, may lead to
> inconsistencies.
>=20
> Example:
> attribute-sets:
>     ...
>     name: pin
>     enum-name: dpll_a_pin
>     attributes:
>       ...
>       -
>         name: parent-id
>         type: u32
>       ...
>   -
>     name: pin-parent-device
>     subset-of: pin
>     attributes:
>       -
>         name: parent-id
>         type: u32             <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>=20
> Remove the requirement from schema files to specify the "type" and add
> check and bail out if "type" is not set.
>=20
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

What about updating accordingly the existing specs? They are used as
references, I think it would be better if the info there would be
consistent.

I think the tool still allows writing something alike:

    attributes:
      ...
      -
        name: parent-id
        type: u32
      ...
  -
    name: pin-parent-device
    subset-of: pin
    attributes:
      -
        name: parent-id
        type: string

(mismatching types). What about adding an explicit test to prevent
specifying again the types for already defined attributes?

Cheers,

Paolo


