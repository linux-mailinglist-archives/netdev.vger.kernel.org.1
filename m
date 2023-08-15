Return-Path: <netdev+bounces-27627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EABD77C94B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 10:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086F81C20C7A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B05C8E6;
	Tue, 15 Aug 2023 08:22:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D9EC8E5
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:22:44 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A261127
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 01:22:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-318015ade49so4627640f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692087761; x=1692692561;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCxc3+woxGFHwMNa4P16Gu+w7ynVsHQ376qYKaKQT18=;
        b=eDVwmQOgQdNdotF2PieDEzn7LnZ/Ynsc2OAhrkgUp1wvbnuREVsZTBcGwFHWhkbDaO
         xo8I86Z/v0tGr5EVSxts1lZDw4rRRO9YuZR1QCjSxiQcw24Vhg0amTkOtVrfdoWlwVfR
         s5bZwZffM3CcifKCu9v6q8J6hKIeGjni+7FAMgwUCBthbDmIHUrxW2OYxHtRjQPLojmS
         GjrGWMSkWRRfKDhab83fFuW/mWTPCsHRcnWZLIIMyJXbR4QURttdePqURblkaP0QOpF2
         8sCHMkgpeLZe4+b3tJFIue+l0r1axKQm5FdR9o6tLFYFoiPOe/LoGvUyFa3iaEw49l20
         wAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692087761; x=1692692561;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCxc3+woxGFHwMNa4P16Gu+w7ynVsHQ376qYKaKQT18=;
        b=kOw6BtlxjfNtR4rguYDk7kK4rHPcXGk2LnLCt3eiqc68+L/4oIXktfy8eFErED21bx
         EBuwkAgZs95TBdvwyLlUk+XfZlcSEg/dn3f/1bUgpagdSPn7Mlr4wjVhI5w8ahcgairD
         E537XqrS4bI8AdBLaKFWtPnQMsik1qjBiQzCjMVmK1V+8/OYV1C/kkemF1R+5wgtV1+Q
         jb5xbxLpnZ1dvLNYlo39oK0zXsKj4LkxGhkmRDSHp09ZEQknwAXBxSqx7Z9XMAxXifW9
         vfqqb67Ed+QxtI6kLAFZvaso37vGq7dXl9+JT/rT4aMrvkH1Bmc31nqqs2LrRoI7fGGm
         ewkg==
X-Gm-Message-State: AOJu0YzWA1KjKe+ccAKayDSBw2En6nh8jwVZVp8NIAnhujp6l0Bd62px
	mKQQ9SfydrlAUrg3ABHKqXk=
X-Google-Smtp-Source: AGHT+IHiyJ7v1HDqfPdfRG/7Qqg2tRN4JP1drYBuNVYGCI5H/FJnt2G4+afdZ1jPPGpvv3hxXt+QtQ==
X-Received: by 2002:a5d:44cf:0:b0:317:731c:4d80 with SMTP id z15-20020a5d44cf000000b00317731c4d80mr8239070wrr.24.1692087760469;
        Tue, 15 Aug 2023 01:22:40 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:9934:e2f7:cd0e:75a6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffd06000000b003196b1bb528sm10441779wrr.64.2023.08.15.01.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 01:22:40 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 3/3] tools: ynl: add more info to KeyErrors on
 missing attrs
In-Reply-To: <20230814205627.2914583-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Aug 2023 13:56:27 -0700")
Date: Tue, 15 Aug 2023 09:15:30 +0100
Message-ID: <m2o7j8k9gd.fsf@gmail.com>
References: <20230814205627.2914583-1-kuba@kernel.org>
	<20230814205627.2914583-4-kuba@kernel.org>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> When developing specs its useful to know which attr space
> YNL was trying to find an attribute in on key error.
>
> Instead of printing:
>  KeyError: 0
> add info about the space:
>  Exception: Space 'vport' has no attribute with value '0'
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> ---
>  tools/net/ynl/lib/ynl.py | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 3ca28d4bcb18..6951bcc7efdc 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -395,7 +395,10 @@ genl_family_name_to_id = None
>                               self.family.genl_family['mcast'][mcast_name])
>  
>      def _add_attr(self, space, name, value):
> -        attr = self.attr_sets[space][name]
> +        try:
> +            attr = self.attr_sets[space][name]
> +        except KeyError:
> +            raise Exception(f"Space '{space}' has no attribute '{name}'")
>          nl_type = attr.value
>          if attr["type"] == 'nest':
>              nl_type |= Netlink.NLA_F_NESTED
> @@ -450,7 +453,10 @@ genl_family_name_to_id = None
>          attr_space = self.attr_sets[space]
>          rsp = dict()
>          for attr in attrs:
> -            attr_spec = attr_space.attrs_by_val[attr.type]
> +            try:
> +                attr_spec = attr_space.attrs_by_val[attr.type]
> +            except KeyError:
> +                raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
>              if attr_spec["type"] == 'nest':
>                  subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'])
>                  decoded = subdict
> @@ -479,7 +485,10 @@ genl_family_name_to_id = None
>  
>      def _decode_extack_path(self, attrs, attr_set, offset, target):
>          for attr in attrs:
> -            attr_spec = attr_set.attrs_by_val[attr.type]
> +            try:
> +                attr_spec = attr_set.attrs_by_val[attr.type]
> +            except KeyError:
> +                raise Exception(f"Space '{attr_set.name}' has no attribute with value '{attr.type}'")
>              if offset > target:
>                  break
>              if offset == target:

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

