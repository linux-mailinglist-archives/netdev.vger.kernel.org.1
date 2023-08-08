Return-Path: <netdev+bounces-25467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859AF774370
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA212812CB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2DA168D9;
	Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF8F15AC1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F919E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:09:32 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3490b737f9aso5395ab.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514571; x=1692119371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOAkw9vX1bFj+8ur0a4XlOPe+B5XLi+XT1bzG2Ujp3w=;
        b=f+iv5xxSyxHyFrceLCKhlVsgJ9J521tN+p3oaOaSzOrdEYDop3XgVfOiGUkxmfSQ+8
         NzuCI3HZVzuZUbihRTHWwfmSzF/JyWDa/7zqqhpOffy+bEHd6QzSWz4KLnJC7dcULJSk
         DtT3NENaIGsc3PhbPHMKRxFx65DbmW4t+GLV7sHwxP1pZopQ/vfPVInHLYFoyK3iBQUb
         si/7ivVOLUbfu6gBr1bl9OS/CVH+o/rNs30wW+klF4OE7lNuU3XnzNqIGAXEMgoF/9AB
         QkHsDRGlEMZi4Zk0gJEeNbedUHUXkiNPb7seogL6/Ymd44cj9fnx5X4uuhVy9R0me7w6
         kmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514571; x=1692119371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOAkw9vX1bFj+8ur0a4XlOPe+B5XLi+XT1bzG2Ujp3w=;
        b=S2H9VcK+XjGsj2J2vQFmVDNtE/iGjwTtwL5NojbMVbvxG/xfELuX6cxZ0HrRZZeHYn
         mFzwLQWrHgL15meiKWiGsamTXELuNU5lg72yy7jXGK9NLLcLImb0TJkp/x9LMKDfXTci
         AQWU7aR7fBTcQLrKp0/MIbq2zTLCbdog3hPia32B/EijOBAsZYYwj3z/NkIFm3+Wz+r4
         mnpCK0itSMvwt39KGDc0tI8jpEEp/5N54Cua/9SHiqcCO/2/CsJPTj9dMZiUrV+YpXg9
         cPg/Y+IAhK562wTtvxhM7KVJtWtMYiqGhoOUgtH0NfWhTs4SbmT3KcheKEHfUO+S2890
         ZZpQ==
X-Gm-Message-State: AOJu0YxSA/D8Ro6arqce75NHId7is+K5XRbQ213TlVPYv/CgA1mZnYRl
	dZTRyRYNnJzoH6Nxp7YmMpqGBzQ5W+nkd5r6ihsGq200KmARG3Kb6KM=
X-Google-Smtp-Source: AGHT+IFqstGgotZzb4KFoXK1TD3nC1rcdCXQr6OMNvalH3JDWasJN0aI8XT37ZKsEsm8j1LN/OnjGht5kTFZxnPOKus=
X-Received: by 2002:a05:622a:1456:b0:3fa:45ab:22a5 with SMTP id
 v22-20020a05622a145600b003fa45ab22a5mr586164qtx.27.1691479748884; Tue, 08 Aug
 2023 00:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230731230736.109216-1-trdgn@amazon.com> <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
 <CANn89iLghUDUSbNv-QOgyJ4dv5DhXGL60caeuVMnHW4HZQVJmg@mail.gmail.com> <1327499ea2f2b43c9de485435e028797198ea2aa.camel@amazon.com>
In-Reply-To: <1327499ea2f2b43c9de485435e028797198ea2aa.camel@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Aug 2023 09:28:57 +0200
Message-ID: <CANn89i+hMLpUD3DtiygnM09jfLcpg1N1mYMqUzv0wXWM3-SAKQ@mail.gmail.com>
Subject: Re: [PATCH v2] tun: avoid high-order page allocation for packet header
To: "Erdogan, Tahsin" <trdgn@amazon.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 3:22=E2=80=AFAM Erdogan, Tahsin <trdgn@amazon.com> w=
rote:

> Hi Eric, I believe your changes are merged. Are we good to apply my
> patch next?

Sure thing, please rebase and resend.

Thanks.

