Return-Path: <netdev+bounces-14261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF873FD00
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 15:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E3228105A
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A4D182AC;
	Tue, 27 Jun 2023 13:40:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B13154B2
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 13:40:17 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93602D53
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:40:16 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40079620a83so267631cf.0
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687873216; x=1690465216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60sdZ0/W1BRmGu6AlZA3f3b1XPfOStvjGcXbJFjRxEw=;
        b=LPlHfy8cooHiNrwPDxEBAv8dW97XNWe6zYTx1dvItxzz5KxOo2mjJhREUqnO+60d/m
         3SCN2BDwX0CTvlmJBKTeGgqMapjeO0cU+tYU2OkTs3PrAEAZhug6yDdMXeqY6ogFnWk2
         ye4FmZPtyFQX0H1THD641fZ9A3nciqX/YGq7zeFHVCBf2OMvEEiGlIx+xfMHGhzo1+XR
         zrQGEnQ7zTddWpP/iZQZJsnD/mAxZ3s1b6TweApQkGBfUzdGkGmcqo3Qte/T59dfY7JX
         LuSHEqi4Emwz/yU0Ab+isEyO7ZIRUvDn98g+1apPw4+4w8vQNjzFQCoAsq6deyPee7Gs
         ujkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873216; x=1690465216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60sdZ0/W1BRmGu6AlZA3f3b1XPfOStvjGcXbJFjRxEw=;
        b=KGCg4s6pZiP4ecm+Px9cf5uu7sG9RWUljiPhfbl+I2LVZlwYxQuf01OeUljm9yNi+u
         1ANU36wlLfQ+CXs6IkXrWi7l3DrYklgpWG1b6iObi4oShm9/vt+xx7w01DVqMI3mqtan
         UZ9Awep56ZpaV/vWgQuzUcAaUUI3iuxad2JdAUL3foVE9o8tjx+7Gt0Rqu46+scbd3U2
         h1Ylby7vCF9J3qWR6WIyW9Xkf6J1JpzFMg6ZGY5V8frrRen5dwPNEV5WiVfJ+QiSl9tm
         1MCWoFKO2i2sWFO5impU7AXePztmilggxuzj7XeRVdhWDjKrKyoywDlqK/+P4nS7JBl0
         ScWw==
X-Gm-Message-State: AC+VfDyebL/OjsPwuqN0jymanztmh0iI4yN2JFhWK1HTFmpHPvU0/yJs
	olsUt29Pt8hmTGQZ16bQKlb1jGIsDvnvCPd2mHtpxQ==
X-Google-Smtp-Source: ACHHUZ5RX8NhvP7wSDLlGP3QTsJ5bkWcPYFYot8aZjT7gCTVzb7MfhLej0NrJFTLFtduzg3q3TXCM4Hsn3cfIbhwyCI=
X-Received: by 2002:ac8:4e83:0:b0:3de:1aaa:42f5 with SMTP id
 3-20020ac84e83000000b003de1aaa42f5mr577703qtp.15.1687873215789; Tue, 27 Jun
 2023 06:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627035000.1295254-1-moritzf@google.com> <ZJrc5xjeHp5vYtAO@boxer>
 <35db66a9-d478-4b15-ad30-bfc4cded0b5c@lunn.ch>
In-Reply-To: <35db66a9-d478-4b15-ad30-bfc4cded0b5c@lunn.ch>
From: Moritz Fischer <moritzf@google.com>
Date: Tue, 27 Jun 2023 15:40:04 +0200
Message-ID: <CAFyOScpRDOvVrCsrwdxFstoNf1tOEnGbPSt5XDM1PKhCDyUGaw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, 
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, mdf@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

On Tue, Jun 27, 2023 at 3:07=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > +static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *a=
dapter,
> >
> > adapter is not used in readx_poll_timeout_atomic() call, right?
> > can be removed.
>
> I thought that when i first looked at an earlier version of this
> patch. But LAN743X_CSR_READ_OP is not what you think :-(

Yeah, it's not great / confusing. I tried to keep it the same as the
rest of the file when fixing the bug.

I can see if I can clean it up across the file in a follow up.
>
>        Andrew

Do you want me to send a v4 with an updated commit message?

Thanks,
Moritz

