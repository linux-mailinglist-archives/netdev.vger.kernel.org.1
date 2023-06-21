Return-Path: <netdev+bounces-12848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDA6739198
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692892815BF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF11D2AB;
	Wed, 21 Jun 2023 21:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618D19E52
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:35:37 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E779B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:35:36 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bc43a73ab22so9436589276.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687383335; x=1689975335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a9oVKOS3hKiaurU+C8B/jf21qpSFSdbTRfDL8gXf+M=;
        b=QyXdhBwxRQYaHsD8caUiTbIkKW2bksY1ZMBQROy87n8W67UkkMRKDyO/w8J1+cItRX
         u9h9HbgEZEdBNKmUZZytziB+ZWsC8WFpb+2xQmchnbGd3k5w6KylfhE++iW2n9WzrUo/
         sRZCGi6dkk7pai/citsVzqIqionwaSwUFCxWitNy8soIMhTO0vAL26YMdWD9K7rNDZj3
         Kuf+GlRAjtz8pJ9woo86PwBVUA61y6JufkEURLHDwWUhk/VC9NE0V2OCLcb1VEq7y2bt
         fOiCqGzMi8wTi4KOYvg8nRomJ0v41XFZ1ZnpKzgKbGYtyJQiVKB5jWxqBbkqgPyEHb7/
         7BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383335; x=1689975335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a9oVKOS3hKiaurU+C8B/jf21qpSFSdbTRfDL8gXf+M=;
        b=RfJoAZyRIz8ynCzj8PyXMLBxkP6JS+9wH8WcjYMDLmSzJgTOZr9k/Hv2tTcHKV4qzT
         eWYwvNaRdlRv5BouS3Ngv00rKTU/nIDlTD76AWfzapWlNlEYmj8MOIixYvLyRNRAAkk/
         DC2GsTh9JiSLKT+XrEmUf5jNj66Ea+Rq0WhSeZmQ6Q/7sXij4woHASVh94COArwfBxc3
         ti0pVrHT6qkmfyP2wiyHK/P7ZdfwQDCjnReQ58Z3Q2QsG74PebmjlGH1zM54I/Rb3l/Q
         0yDgQ4pDWHNpvvhmBCB9LWpBrUgXU9FZaJb1H2nKr0VuVKIeBOPvPa3ZxOpmHHEZZp6a
         r2Fg==
X-Gm-Message-State: AC+VfDyCF6XO13Au/un6LF99HRHeBNPVovRLwMl8Ctxkgx3pm2ilbFvu
	rk9ooP+Zwglc6FmKMaXD2ct51+INFdgJMi4liwCPUA==
X-Google-Smtp-Source: ACHHUZ73Y7ww5KI7+S1wZpvD/2S7BPuJld4uWbQgfQLvmOJfdP1VL9ryh8Il7M0BRloVqM1kbxjhL04BYBQ8SjeJD5U=
X-Received: by 2002:a25:42:0:b0:ba1:6bad:9270 with SMTP id 63-20020a250042000000b00ba16bad9270mr15933237yba.27.1687383335686;
 Wed, 21 Jun 2023 14:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-6-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-6-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jun 2023 23:35:24 +0200
Message-ID: <CACRpkdafXbhW3=6kAS0h6YjiOCcDa_zwhRVVRcun-GNPbroasw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] net: dsa: vsc73xx: fix MTU configuration
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 9:14=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> Switch in MAXLEN register store maximum size of data frame.
> MTU size is 18 bytes smaller than frame size.
>
> Current settings causes problems with packet forwarding.
> This patch fix MTU settings to proper values.
>
> Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Ooops my bad. Thanks for finding this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

