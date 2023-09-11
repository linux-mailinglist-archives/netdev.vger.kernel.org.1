Return-Path: <netdev+bounces-32868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC979AA14
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEAD1C20977
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F7C125C4;
	Mon, 11 Sep 2023 16:19:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886111C87
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:19:05 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA881BE
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:19:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a64619d8fbso586029366b.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694449143; x=1695053943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqQhesJRGHJnqwfC0O1HAzzWOfjVQZk+HkQ0PHjZnu4=;
        b=HTQrVouh3EBQI8XuXU6B2SvSnldnvXVg2IjGlKYtNpFpHe5WCLk57fNmYloLVAkqjw
         4RgWtMi/HxghM/RIl5BkW0XTbJ45boeumbN+Ys+eXpRbPyjpW1attq0RUZJYMu4AgTb8
         /f+CM3rv+VKKTW5Yw4H5Zm2U8lFkMFi4o5+9tOSLh/bALkwtrCWDjU48Pl3AZMzk0j7T
         sz8mJ3gIbFd+2yZ/CfOWdpCs6/Ay5NL0g4l7cSnF2ppOCrOWa8shBDA+iSwJwBj8soLo
         vNYG6QlLQE5zstN0pcVPDab+72r/ydrpSA6veSLJknZtrNDTtM22L1vxHTVxvybfdN0Q
         9kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694449143; x=1695053943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqQhesJRGHJnqwfC0O1HAzzWOfjVQZk+HkQ0PHjZnu4=;
        b=U8dPR50376p8DR884UZbMf453f3DJjAl/xoZZwX2Nwm7Ri++ZBzcJPEJo9/vjHXFf+
         3PQoQTZqbqBch/GMZNbtKh6Ca5V7pCmQu6JlfQ+QEAocxeKEPipkRVtcGCfF6SCQGCa+
         RjlELhYPzDLRER4jswE6qZem6piNGPQfO56z1ZzewhL3kFLvCrsLGhfceHeOJbp2odMo
         +shpFc6S/KJcL605iznq9g0jDn5unTlEEdcgb/NPvhw61SDRrR5xhkv+sfL7wJzWTWvc
         ge+47coWn8nCk8tgt6pHyZR/4RqK97ewggjdXlVga/9Lql+QOJhG5NctRTDiVrYf6IPL
         y6KA==
X-Gm-Message-State: AOJu0YyPLKwfHW0gk/udR9O2r6x6JCsdhdRgZdcQ8w/9XQlB9VP1QcGr
	945vR5dE8z8XFOoYzeRXbsU7OUDqoJHmD7Eb0oBdmw==
X-Google-Smtp-Source: AGHT+IHwC0bJIYM/tEObKnA4oW3rShbyhVaW0L/OyP4JJ4LEPc3r4Sw706bE8m/OXQbWsr5eCpL0Mg==
X-Received: by 2002:a17:907:760c:b0:9a6:3e0:ccfa with SMTP id jx12-20020a170907760c00b009a603e0ccfamr8596424ejc.19.1694449143114;
        Mon, 11 Sep 2023 09:19:03 -0700 (PDT)
Received: from fedora ([79.140.208.123])
        by smtp.gmail.com with ESMTPSA id b9-20020a170906490900b00992f2befcbcsm5568038ejq.180.2023.09.11.09.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:19:02 -0700 (PDT)
Date: Mon, 11 Sep 2023 09:19:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sam Foxman <elasticvine@protonmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] Enable automatic color output by default.
Message-ID: <20230911091900.33491a07@fedora>
In-Reply-To: <20230911044440.49366-1-elasticvine@protonmail.com>
References: <20230911044440.49366-1-elasticvine@protonmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 11 Sep 2023 04:45:23 +0000
Sam Foxman <elasticvine@protonmail.com> wrote:

> From: Sam Foxman <elasticvine@protonmail.com>
> To: netdev@vger.kernel.org
> Cc: Sam Foxman <elasticvine@protonmail.com>
> Subject: [PATCH iproute2-next] Enable automatic color output by
> default. Date: Mon, 11 Sep 2023 04:45:23 +0000
> 
> Automatic color should be enabled by default because it makes command
> output much easier to read, especially `ip addr` with many interfaces.
> Color is enabled only in interactive use, scripts are not affected.
> ---
>  ip/ip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Changing the default is likely to make existing users upset.
If there was a generic way to ask for color (ie across ls, ethtool, etc)
then iproute2 could follow that.

For now if you want automatic color just use aliases like almost every
Linux distro does now for ls.

This change gets a no from me.

