Return-Path: <netdev+bounces-40513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2697C7933
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FF1C20BA4
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E23FB09;
	Thu, 12 Oct 2023 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GufGVWIZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1763B28A
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 22:01:21 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C20D7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:01:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so2563738a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697148078; x=1697752878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odwr8eDy5SCBmCoOrVqIA/yNf2FEEwKvqJwp3o31tFQ=;
        b=GufGVWIZMUS7kr3IyC4izYXap+cKiYLwfoYZ/dvXYGG0UnTeKIbXufmRXbcK2XCE4E
         wWZSOyFnsU6uF9sOB4u8dZttGoUJ1a3SBSpD3MO1WaT9vj2b39P7ZYx4sWWBnG1gKgdz
         Krht4U7UrM+tH6PUoBhgNyou152hTZ+V1unZw2Vc5orixBhmhHNRX0OJSa/CQ2vR2cRG
         F301Wi62seOdctwQ8JQao3gwmuqz5YB+6hYpKeG3NRxeQVBNNzIITSuc2OOqCIrtY5eX
         eWnofK6Bdem2v1dHlqlcODhk1vccdwwHFO/Y/NG7Rqf8ISJ0Oq8RAmzM1nrmGp4aDLpB
         PtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697148078; x=1697752878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odwr8eDy5SCBmCoOrVqIA/yNf2FEEwKvqJwp3o31tFQ=;
        b=hJAA4m2Y3df2nkUlFeYUh0NodxntDgsJIL2a5c0GmNACPVaNEGd8qIK8eW31kjekeO
         V1ZNIulC/gs1G3jjXXjn78DKVDqA9yAZn+OppRtziaiDLheeX2LS2EvTFowH4NIJ64wk
         5LaGNsXlT6mqqXBVQNrGLg8Ly8O8qdYbsFO5BCHx0WQZwmtV5jFFBu0aawRxXNl2XnKW
         QP0tOemYI3hpjNW/HSXGj0LTM/2Ycb7QGUKu0Wqkb4n4c1PROL7ZhwP1lWuTjocJ72RV
         1YNvc3GDPVo2F06ZUFBscfRVVkMTY4y1yqQKxogG4q80eS69VjPz5/kb8qYfTWcLtTll
         Upfw==
X-Gm-Message-State: AOJu0Yx2G21/b6EP0D415IqbGlmWWzQi49fIoLDQODjyP8BE7WmzpP31
	QVMxxQ+WtteiV9KQ9uVM6NJFqGif0tQaw+M/nQIvjA==
X-Google-Smtp-Source: AGHT+IHkRTS5Quw20yMh+SqaVjNY3XB88DzaTtUMhrYwgnSHDbh2ArUGSmO9mOxhUHP6tq7BOTcPgHl87BdqzOm0Vr4=
X-Received: by 2002:aa7:da84:0:b0:536:2b33:83ed with SMTP id
 q4-20020aa7da84000000b005362b3383edmr25702236eds.24.1697148078438; Thu, 12
 Oct 2023 15:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>
 <a86149c3-077c-4380-83ec-99a368e6d589@lunn.ch>
In-Reply-To: <a86149c3-077c-4380-83ec-99a368e6d589@lunn.ch>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 12 Oct 2023 15:01:06 -0700
Message-ID: <CAFhGd8qAfWiC0en-VXaR_DxNr+xFfw8zwUJ4KgCd8ieSmU3t5g@mail.gmail.com>
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 2:59=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Oct 12, 2023 at 09:53:03PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
>
> Hi Justin
>
> You just sent two patches with the same Subject. That got me confused
> for a while, is it a resend? A new version?

Yep, just saw this.

I'm working (top to bottom) on a list of strncpy hits. I have an automated =
tool
fetch the prefix and update the subject line accordingly. They are two sepa=
rate
patches but ended up with the same exact subject line due to oversight and
over-automation.

Looking for guidance:
Should I combine them into one patch?

>
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew
>
Thanks
Justin

