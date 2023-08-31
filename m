Return-Path: <netdev+bounces-31522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF9878E854
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4CC1C20858
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90899749F;
	Thu, 31 Aug 2023 08:34:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F6F33C8
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:34:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67ECE7A
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693470796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rd93SXkzVQrsb0MjIDJzWkDo+X+z5oZ6JHIikGyKG5c=;
	b=czmXYMY5G4JUnX9seLJjN0BTmuoQQw1zZ+Cisv0A3hRKENnE2x+KHjrwDdBg/uhh7jxO89
	zLKaT94uUmG2ROMZQGhyxAT0cH39ij5uq1mV7hYhR1iinektP2PFf3EfBss6hxtOE8lv0E
	i4Ks6x44PWyziaZdPTXedyx484/BrVI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-XIbmr3s7Mt-jwtsE3cpI-w-1; Thu, 31 Aug 2023 04:33:15 -0400
X-MC-Unique: XIbmr3s7Mt-jwtsE3cpI-w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a1c4506e1eso10021966b.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470794; x=1694075594;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rd93SXkzVQrsb0MjIDJzWkDo+X+z5oZ6JHIikGyKG5c=;
        b=Le8EFsF3SCcqRIY+doURWfca+30dl//MpZUEgn3YedSq782I0FVjW+SAOy3MCsjhXp
         TeEWd7yptZFOCAOiE1cHOHjbJgJQgOlxVpxdIbTiFX35YRjSbgB0egfOIiT1JMMc7Dzj
         EhtOncQ/L0OYsyO8F7ezd0kIS38OxOeHNt8mzsZ2OWq+BoJk1Qci/Kqef7qryU7R5auv
         Qvh+J96+jjFLoeptzq9mE9dpt9ZZz9qtqGhh2ZkQtyDVTmKyWcP5Cq/opcpEwpLLMR3p
         eZLtPDbOw2AmezeUC2X5wruOl/TiMW8167sVkRJAnC7URbWewt09wEg2iFMLDWh/1B6O
         o27Q==
X-Gm-Message-State: AOJu0Yxttw/KsAosAn73PgipsSiSXoiOQt9iNzJyrQ4U1sKkLD2h8QyG
	Zb5UM2asL+u8KuYTNbbtiPZDLcfqg3kYaQzxytyUGusE0bq6/6RjNSxxE4Ey+iR3Ek2O9zWe0I3
	QYZ72bMwvYylqk667
X-Received: by 2002:a17:906:2092:b0:9a1:c4ba:c047 with SMTP id 18-20020a170906209200b009a1c4bac047mr3127809ejq.3.1693470794111;
        Thu, 31 Aug 2023 01:33:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNqNIzx7di/f/cuKWn72qtiJ17xaxRSSNFyFoc/4OHfR+YjBSvedCv/2N6Ca6xo6pDnY/WQQ==
X-Received: by 2002:a17:906:2092:b0:9a1:c4ba:c047 with SMTP id 18-20020a170906209200b009a1c4bac047mr3127795ejq.3.1693470793832;
        Thu, 31 Aug 2023 01:33:13 -0700 (PDT)
Received: from gerbillo.redhat.com (host-87-20-178-126.retail.telecomitalia.it. [87.20.178.126])
        by smtp.gmail.com with ESMTPSA id ox3-20020a170907100300b00993a37aebc5sm497158ejb.50.2023.08.31.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:33:13 -0700 (PDT)
Message-ID: <6a8aaa64b065165031c53427778775f686606cc4.camel@redhat.com>
Subject: Re: [PATCH v2 5/5] Documentation: networking: explain what happens
 if temp_prefered_lft is too small or too large
From: Paolo Abeni <pabeni@redhat.com>
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org, 
	jbohac@suse.cz, benoit.boissinot@ens-lyon.org, davem@davemloft.net, 
	hideaki.yoshifuji@miraclelinux.com, dsahern@kernel.org
Date: Thu, 31 Aug 2023 10:33:12 +0200
In-Reply-To: <20230829054623.104293-6-alexhenrie24@gmail.com>
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
	 <20230829054623.104293-1-alexhenrie24@gmail.com>
	 <20230829054623.104293-6-alexhenrie24@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-08-28 at 23:44 -0600, Alex Henrie wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index ae196e78df88..65daececd9bd 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2469,7 +2469,11 @@ temp_valid_lft - INTEGER
>  	Default: 172800 (2 days)
> =20
>  temp_prefered_lft - INTEGER
> -	Preferred lifetime (in seconds) for temporary addresses.
> +	Preferred lifetime (in seconds) for temporary addresses. If
> +	temp_prefered_lft is less than the minimum required lifetime (typically
> +	5 seconds), the preferred lifetime is the minimum required. If
> +	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetim=
e
> +	is temp_valid_lft.

I think the above could be more clear as:

"""
	If temp_prefered_lft is less than the minimum required lifetime (typically
	5 seconds), the preferred lifetime is extended to the minimum required.
	If temp_prefered_lft is greater than temp_valid_lft, the preferred
	lifetime is limited to temp_valid_lft.
"""

cheers,

Paolo


