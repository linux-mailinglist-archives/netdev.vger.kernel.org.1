Return-Path: <netdev+bounces-26233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5577773D8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524E0281F78
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDFC1E52C;
	Thu, 10 Aug 2023 09:12:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D321DDFE
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:12:24 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20F826A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:12:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31792ac0fefso623228f8f.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691658742; x=1692263542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6aD/I80hfh+wvoeGp+eZpdMGT18J8si+17LjDa78/Y=;
        b=m+0UJWreGgOPNl9UyfmQoyY+8jwokffL41BR+UJoqzwCeJ88XT4nKkSbVQXJshpxPP
         lcPJbh/2Ht4gd+MIdVBuc1/fIpsDRtSVXR8kDrgcN8YWQIJSb5dBoNZ2h/kiarNsOs09
         iI1rGb/3mwacXadCFEhY15fW4ES40JoPHYSN2mHLaZE+ak4gQGnSdryww4bmURw9dmfc
         DadQw6gZ8VKyEYB6TjbQiVDOsvGvUzBVOGXtCtE65MrP9KBRx/FX2rOw6/Hgvwr9NRIN
         NH5+boAFAHWnul3a/Gm34cs1ad1m4M25B0SdePZL/cZLDokHfWa0fLdJDjp316qA5Fj3
         +LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658742; x=1692263542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6aD/I80hfh+wvoeGp+eZpdMGT18J8si+17LjDa78/Y=;
        b=OpFh5wKMof57Ax04bEXfqlErhF1qJ1Og5cz6XV2irH6U+TQelC6nWA6awomx0+rGv/
         FVAxObzFHpj/xhe4NXtFGAcQSDEJZgNHdAgqa2FlqmhkOyVbEMhS0UCWLYzGQgGVXt/7
         yE9F9Q3QJtmZ6n2vy9IMdD/1+cwt3XWDeTXqP0JTZQT31nDFnTKBqOHsc4mKCv2ZooEQ
         Q/DZ59hVO7joajWj1kq0NjNIGs458THaHmKM7Tr9l6nI+O2krK6OMH1wRIU283WLI87X
         UlFY9/0rOGfBau6clJa2shylh9MeR01CZv+6tb7Fp/PvU9pL1huDXYDhNr/y9tkSYGo9
         GGaA==
X-Gm-Message-State: AOJu0YzA8wRuk+gON4LcyJzYJ/nY0BHI6DOiylzlhlUHHsB1U38y9WwN
	tdZ7NeLdWR+z+TXCiCBbQ2isag==
X-Google-Smtp-Source: AGHT+IGFpCUkAnXyh0Jdwe4t4WvViggWsH0rSGOwVQNDVu7+6XHuqmz+tKILrE0DfOxzvxw+c2hVKg==
X-Received: by 2002:a5d:5646:0:b0:317:64f4:5536 with SMTP id j6-20020a5d5646000000b0031764f45536mr1569366wrw.44.1691658742334;
        Thu, 10 Aug 2023 02:12:22 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b00301a351a8d6sm1463794wrx.84.2023.08.10.02.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:12:21 -0700 (PDT)
Date: Thu, 10 Aug 2023 11:12:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net, mkubecek@suse.cz
Subject: Re: [PATCH net-next 09/10] ethtool: netlink: simplify arguments to
 ethnl_default_parse()
Message-ID: <ZNSp9E4tWxAm0/qV@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-10-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 09, 2023 at 08:26:47PM CEST, kuba@kernel.org wrote:
>Pass struct genl_info directly instead of its members.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

