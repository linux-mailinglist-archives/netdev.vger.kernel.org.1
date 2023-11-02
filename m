Return-Path: <netdev+bounces-45737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3097DF4B2
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052A5281ABD
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 14:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D7718E2D;
	Thu,  2 Nov 2023 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnWxQNXH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C911185
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 14:13:40 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BCF12E
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 07:13:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so92146666b.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698934417; x=1699539217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4h7T8mewgronFd9tUJGPAlxvPnAF6wo6KX/ortdn/Q=;
        b=TnWxQNXHjnHWVUXG+PEvqOXfdH88sPt3IBGE7NQToPUcspUUJIiOb3zEDns3OeIX7F
         x7oUDrPeFm4rHyRVYcs3mdQYKtXUeQGXf2tAMp+bDBRiK8V5/ISOntXkGLYGGfgnFATb
         HUc0+EGghJ5u2g8Y2F596B3iXO+oHEgyiVFIUMeXXt3D6ftnxa6/BeafqryLwtcZ9Jxv
         QwwS92vbE+HfhbP3vExd4Iv5WzM2xdCH/Iy9UTWQDru8KtfHmii929WYLxIkei4zCTAU
         ZJ/aGRg9/MZtrnw2wyvJue5ICFmn2g1n9nFBg9Apnl0OHZ/huWu5tPTOw6xXPYr726H7
         Epxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934417; x=1699539217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4h7T8mewgronFd9tUJGPAlxvPnAF6wo6KX/ortdn/Q=;
        b=XvyYIfAMMvApkLcIPqqgAPe/5X/FY0V5vnSWw4zsAoKXtC6l9DHKQmLEBRDxeLxe0x
         Jfqe7BXKPlrHpQS9IAwJsweScpnse7O9cmy8DYApk7TIDAEjSJC3OKAZfKePMFZw49uy
         FUN/FxL6TIj/N4qJJHiif6FAqj9j+4t7mOF6UwPtC+FwIYP/4FLz4mDLP/6P1ivxstV1
         O0AtXnsqUAJVc36Ur+8yH0MYo9MTThH0GF96elfSa99n/nUTE5HOpjIKdFhpi8PhayHq
         jv0P+nM0ne4mdzGA/oPe4WhPPfci6tEvwdCViwyox9v9A3Fj9xcHZLm3W01CZ6Abf09Y
         INtQ==
X-Gm-Message-State: AOJu0YxEEFZVwk4IC0rfk4MM7tr/ciC9sFmf+wPsQ4zKeh/46a2ZV36O
	JU6/275591BGHu7pZWe0wes=
X-Google-Smtp-Source: AGHT+IFRZvRK7dqvJAUuaoNo8F7Rwqno5GsTlX4sxZd5mdBxEiPojCZ4N7ToSUDgGYZEUh0Osl3mYg==
X-Received: by 2002:a17:907:7ba9:b0:9be:40ba:5f1 with SMTP id ne41-20020a1709077ba900b009be40ba05f1mr5251454ejc.60.1698934417295;
        Thu, 02 Nov 2023 07:13:37 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id lv1-20020a170906bc8100b009ce03057c4dsm1195441ejb.2.2023.11.02.07.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:13:37 -0700 (PDT)
Date: Thu, 2 Nov 2023 16:13:34 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzk+dt@kernel.org, arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset
 controller
Message-ID: <20231102141334.6hd4b3xsdnlvgf4j@skbuf>
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf>
 <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>

On Mon, Oct 30, 2023 at 09:30:45PM -0300, Luiz Angelo Daros de Luca wrote:
> The remove/shutdown are probably similar to any other DSA driver. I
> think the extra code around a shared code in a new module would be
> bigger than the duplicated code.

When you start looking at the duplicated parsing of vendor-specific OF
properties like "realtek,disable-leds", I am starting to question that.
There are also differences in the handling of the user_mii_bus, which
stem from the duplicate implementations, which are hard to justify if
you are saying that the only difference is that the switch is controlled
through a different interface and it is otherwise the same.

