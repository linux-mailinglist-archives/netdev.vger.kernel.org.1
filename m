Return-Path: <netdev+bounces-30355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632DA78701F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918781C20E28
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB86288FD;
	Thu, 24 Aug 2023 13:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF7288E7
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:20:11 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E21BD0
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:19:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso65830325e9.0
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692883165; x=1693487965;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TiusxsD67kpfB/N19BGNZf62GZSOy6zfgumme5v9RGg=;
        b=qVMTFeFaTlSb1uKHGmjvec2GNQTL0JAF8fzdNWqpjhUC5tHMTtgHwUH2PUXPZOCw5C
         tXU+O+Xyp5kVdf80vuTX3vy4KlR+0osDVFu7h/1HEUtM/7prAudfDtly+9vqjsxnEfJI
         RzHygQ5dLGO6nYldkF6wmK0g4ocUIOkrh/uHN3QS8zzS3cws51XptwqY6n0Ok3IOyRrb
         WycAOClrCdF7ONrNyAstI3jloI8Ad2BZB+zL4zXVYAQpUbj+4M3TkDlFvpP2x6eXOjQe
         6IP1SFPTNOKhBwyyRXIB2u2KFzqyt1QaXFCf29w+MWfSx4PwD18Ihs5BAMIhucLLFC16
         UMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883165; x=1693487965;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiusxsD67kpfB/N19BGNZf62GZSOy6zfgumme5v9RGg=;
        b=RNGnmNvTu6YNbAzYS4afvJmPjubeE2wLu7ka7eOG+/vppjdyfD4mGbLR4maNNL0tXD
         IClN/WauFuwobcseYq0Z/6ZB5Wbts7n7Q1HuYvqxkBYVY+5l+mmqibX/WRAVtzyMPFaZ
         MXNN+MuoM3bF+wfThHonWLEeVT8uvwN80qFflrrBvcgfoEeJLNeBu04hA3cHHvihvKNT
         P7bHJeJL5GY+iy4GZIabTpY5aiPWeEV5SHG415Dy3NRG6Ur4SYssbzUu07xugwrUPSU1
         DCxwboTi2A6o/XydK8ovQRt6Eg4ixjM7b5ZgFd5u0ervuHM+29JlUfViPcpH376c6rMZ
         t5HQ==
X-Gm-Message-State: AOJu0YxupjrTvZDD0Awcy4kPf1Bx9idHdxZYA3b08v2X3kybvRPL6Eve
	6cvJp3aGqUTV4F/09uB7e1g=
X-Google-Smtp-Source: AGHT+IFwwCaTZteayR1CK51lQt+7qtPZZnq4aIRCHFHjF4THEkcZzrwk71Aqbtm62eDhkvqNumbauQ==
X-Received: by 2002:a1c:7508:0:b0:3fb:a102:6d7a with SMTP id o8-20020a1c7508000000b003fba1026d7amr11929266wmc.28.1692883165404;
        Thu, 24 Aug 2023 06:19:25 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c204800b003fee6e170f9sm2605616wmg.45.2023.08.24.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:19:24 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 1/5] tools: ynl: allow passing binary data
In-Reply-To: <20230824003056.1436637-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 23 Aug 2023 17:30:52 -0700")
Date: Thu, 24 Aug 2023 14:09:02 +0100
Message-ID: <m25y54h9jl.fsf@gmail.com>
References: <20230824003056.1436637-1-kuba@kernel.org>
	<20230824003056.1436637-2-kuba@kernel.org>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> Recent changes made us assume that input for binary data is in hex.
> When using YNL as a Python library it's possible to pass in raw bytes.
> Bring the ability to do that back.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/lib/ynl.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 6951bcc7efdc..fa4f1c28efc5 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -410,7 +410,12 @@ genl_family_name_to_id = None
>          elif attr["type"] == 'string':
>              attr_payload = str(value).encode('ascii') + b'\x00'
>          elif attr["type"] == 'binary':
> -            attr_payload = bytes.fromhex(value)
> +            if isinstance(value, bytes):
> +                attr_payload = value
> +            elif isinstance(value, str):
> +                attr_payload = bytes.fromhex(value)
> +            else:
> +                raise Exception(f'Unknown type for binary attribute, value: {value}')
>          elif attr['type'] in NlAttr.type_formats:
>              format = NlAttr.get_format(attr['type'], attr.byte_order)
>              attr_payload = format.pack(int(value))

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

