Return-Path: <netdev+bounces-56372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D7280EA67
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44942B20B49
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2125D491;
	Tue, 12 Dec 2023 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gh0E60bJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE915D2
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:29:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-551d5cd1c42so7a12.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702380587; x=1702985387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUsWzoiKkur9C9emmZSdkT5RnnG1X16l1arCoLx7TSk=;
        b=Gh0E60bJ4tq03fKcuHPG3Z6D7fqV0CtJdUJnDhjcWK3TQCfWmiCZxK9s5d570h4hVA
         Yzjtjjnk9UOhiuoYivwh8WEpskXAYtNyE2mPELLvGEQVId9Q/WBK7VWrAdod6r+4HloB
         JO9Yg4EDvCUPWCHKH7fP3lhtVJiEAQ1KyLfTnLx3f1XgdioSAI2t7dI6tx2oYYkXQnyI
         XIuLwcAmQLkXXWy11OqKSpdk46/n629naJ+bExoTX5FpaAylJecULvNvlMGJWp9/Z3lY
         SgekbDQ5ddH8PCF14rA5geo385nSViQnDzTcTolKGSjuq/72w0wDx18CUL5wYQSnmgnM
         /98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702380587; x=1702985387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUsWzoiKkur9C9emmZSdkT5RnnG1X16l1arCoLx7TSk=;
        b=cycY7D5StJT5I2OxT3P5tO2+AzfxdV8tleQNdjOS535SaNcjP+d2QJdn598NvsSCnG
         KhjhPKMY07yBnM3X3bcMcX2B545npW4jyiHFghfbDfIN2qhCXUZwaxQ3MPnx8w0pNS+n
         X4CXL/BF2ykBfzHLEaUxSPLFknOOcAvF2WVqYCpCkbnJGg9MUZmk55cFuCyoVOU5LBUo
         UMURTby7fqmOKvHJlmYq7HhRMSaLhmBheNmWWGHEdu2JrM9aJc3n44tQquePF7MNYIQ3
         B299/7G7l+RUxg8dOuVYynybT/bEhb3syH7zpX3a54IE38nbnY8P1v3v4JShoBfv0U/T
         3dXg==
X-Gm-Message-State: AOJu0Yzuy8mVGrPoUa+c/rAZ1QnwqssquQA3NNFs0WDrbX0QvB6lRaAW
	BtquF5gfPaxa1RY1M+GaUl4W0ZcZ121npE/LXZ5yXw==
X-Google-Smtp-Source: AGHT+IHkMoB+B5JYGajLVu4YxwDlzr70OwEQ7Y/yG9tZL04h/eqVn6ZKQWt8xTZusN1rPoPq9KsSfv+hQgtHUmzxb7o=
X-Received: by 2002:a50:c092:0:b0:543:fb17:1a8 with SMTP id
 k18-20020a50c092000000b00543fb1701a8mr297533edf.3.1702380587164; Tue, 12 Dec
 2023 03:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+BNkkg1nauBiKH-CfjFHOaR_56Fq6d1PiQ1TSXdFUCAw@mail.gmail.com>
 <20231211155808.14804-1-abuehaze@amazon.com> <d003752ef45da9401ba6e044aa0e180f3dc46228.camel@redhat.com>
In-Reply-To: <d003752ef45da9401ba6e044aa0e180f3dc46228.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Dec 2023 12:29:33 +0100
Message-ID: <CANn89i+mw-qaex1R3sXPby9sskWRadUS74nucO-31oj73vH0Tg@mail.gmail.com>
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY
 flag is set
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, alisaidi@amazon.com, benh@amazon.com, 
	blakgeof@amazon.com, davem@davemloft.net, dipietro.salvatore@gmail.com, 
	dipiets@amazon.com, dsahern@kernel.org, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Mon, 2023-12-11 at 15:58 +0000, Hazem Mohamed Abuelfotoh wrote:
> > It will be good to submit another version changing the documentation
> > https://docs.kernel.org/networking/timestamping.html editing "It can
> > prevent the situation by always flushing the TCP stack in between
> > requests, for instance by enabling TCP_NODELAY and disabling TCP_CORK
> > and autocork." to "It can prevent the situation by always flushing
> > the TCP stack in between requests, for instance by enabling
> > TCP_NODELAY and disabling TCP_CORK."
>
> The documentation update could be a follow-up.

About timestamping documentation I sent something  cleaner I think

https://patchwork.kernel.org/project/netdevbpf/patch/20231212110608.3673677=
-1-edumazet@google.com/




>
> Please fix your email client, the message you sent was not properly
> trimmed.
>
> Cheers,
>
> Paolo
>

