Return-Path: <netdev+bounces-30359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213F787024
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF7128124E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F420A2891A;
	Thu, 24 Aug 2023 13:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE210793
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:20:13 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B258D1BDC
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:19:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so3455443f8f.0
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692883171; x=1693487971;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gwttFQcziSbwCRRsl3bu0anhBXNZIpWBqnl/lE8mHw=;
        b=fNJ3fIa101nazdwj7ASeCQcP0Ay09Dp3ijlZdytUEsfLA4hIGv2Url6t3KYXm71ysU
         GUydvpDCDA4C3Hxfi25guJvu9J0hRd9AVdzo6vkdWuqyLWxD1v6TZ/pUdxU7ohcGVcN5
         StM4hp7DnCPB9vqjI3dKMeLeD8MzqTDVA2ruYb47t/PUtR4cI3/HbefgNdTZvoWilOce
         sv6N0mMB+TeCKqxotIvXBIKz8yGPSz7i/lAAokLbe9XISj1TmrNbkIU/gKlmJYLkNnJ4
         OwiMaBO4E0RKAcTYa09hVk085q+ugAwLHq0Zsi9Peg0rm662dZZ5WlJHw+yJ+i0plkSg
         0tNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883171; x=1693487971;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gwttFQcziSbwCRRsl3bu0anhBXNZIpWBqnl/lE8mHw=;
        b=VS58EUEY+HF8xg+R5v8+e+p+Uoy8fQvbJDq8pF+7IEJbP4GEtdlZpcaf7GS6qvbK1b
         b2HYHO7tXZ9+5rA7VTbrqeFT+hVtaZ8CvjbltyDnOmBbI8NF3aPfNcOyTr2wmjK8mAZG
         XEbMatQURwZS+pV2e7aqZ4WTu5ZVy5Q0MDvggDbczpyIMLYYe+PmTUA+EbtkHEMD4m1w
         FPA6jfGdCkrQmXMq5YI+KgpOXrqtuPXKhv0yA2s/fpdABiuru2zONuaggpDr2TMc7xqt
         HEVXp1TpQsfTeNYVDw+s8R0sKA+u8obdrP2UVG+KZOQTUekGBzhMvV/vOiVdnHocFhxZ
         YTww==
X-Gm-Message-State: AOJu0YzMBtM8ZtNSQqA8hZrB/7UT/GtBaWf/VkTDwrWbfqcrEHC94tai
	UVKkWgeUyrOeiGSHfkLeQmg=
X-Google-Smtp-Source: AGHT+IFTc7izxqASpTHlbvNyX8iqiGM0ODir0gr+ZtMFWlyl2g6RA8N8zLsh4FXIefRVsjiBUePXhA==
X-Received: by 2002:a05:6000:128d:b0:319:77d4:b313 with SMTP id f13-20020a056000128d00b0031977d4b313mr10917860wrx.58.1692883170974;
        Thu, 24 Aug 2023 06:19:30 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb4a000000b00317a29af4b2sm22091581wrs.68.2023.08.24.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:19:30 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 5/5] netlink: specs: fix indent in fou
In-Reply-To: <20230824003056.1436637-6-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 23 Aug 2023 17:30:56 -0700")
Date: Thu, 24 Aug 2023 14:17:14 +0100
Message-ID: <m2o7iwfulh.fsf@gmail.com>
References: <20230824003056.1436637-1-kuba@kernel.org>
	<20230824003056.1436637-6-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> Fix up the indentation. This has no functional effect, AFAICT.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/fou.yaml | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
> index 3e13826a3fdf..0af5ab842c04 100644
> --- a/Documentation/netlink/specs/fou.yaml
> +++ b/Documentation/netlink/specs/fou.yaml
> @@ -107,16 +107,16 @@ kernel-policy: global
>        flags: [ admin-perm ]
>  
>        do:
> -        request:  &select_attrs
> +        request: &select_attrs
>            attributes:
> -          - af
> -          - ifindex
> -          - port
> -          - peer_port
> -          - local_v4
> -          - peer_v4
> -          - local_v6
> -          - peer_v6
> +            - af
> +            - ifindex
> +            - port
> +            - peer_port
> +            - local_v4
> +            - peer_v4
> +            - local_v6
> +            - peer_v6
>  
>      -
>        name: get

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

