Return-Path: <netdev+bounces-37800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA3F7B738E
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id D853E1F2156A
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 21:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73773D996;
	Tue,  3 Oct 2023 21:55:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21243D98C
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 21:55:03 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A019CA6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:55:01 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a22eaafd72so17953227b3.3
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696370101; x=1696974901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Xv9u3ucLLjlP5EiWRSs6ylR+qTsic8mZD/1X78BJP4=;
        b=JA0Y4I4g7BhjCLGi4a+j/HLLcabYlIaNplf8CR+HK5z3m2h3GBV8S+5cDzQ5jLoNdP
         N0DvaWT4R8xobzl1Mb/HOpD141ufuPvde/YNQO3tO3ijG6hVgJnXSIHuSdFxVz/1AbIM
         F+ZSKV/s85sKQ4dWOE8Do6+CAiRPVMNYCKrQUCObp0DzSPsqULvSd2SW4WG8QVVN1SwE
         +gKfXv51e+Sq2e06OJi1uBNRZfJ3XwT2CHHV39ufU5jqDq2Yj7pbX76r2qmghLBySgUh
         BWR0M1CghUyUQMcW7epB8B1o15Rw32r375KK4FrTnyz1nd7aHKnRyvNMZRwXQyhJsZom
         /l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696370101; x=1696974901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xv9u3ucLLjlP5EiWRSs6ylR+qTsic8mZD/1X78BJP4=;
        b=dM3+nYzlkD6ZURLCWnri+XbDCPOQsgHMEh3u02xk6gysHi99DwsDJuFRLw0/wPJpQd
         SFNuTpw34oiGSOiXm1EvIjKkdTvgyTCCbiiJfRvZu9wW/8Vg3J/vUpBg0vGR15nq7QXm
         bkRThOGFK9f1ICN3baYcABPRohnB0RqiHxGOR+fNGNIxKbzAKRK5wEKwXDjpyejCHQ5t
         p8z9dOpJs0d+2BKV/qWFF3ZR/Ne1e9sW/n//5KKZZgnfUycH8CzVPUG4THgR27QsQiSO
         GrLMNllNersAzWpznMx322rCOLlWr2om3jNCU8ZjF1j2MDMf+A7t6bXq0Et4bNd4ZILK
         4hAw==
X-Gm-Message-State: AOJu0Yzt34oYtctEBNMzqw07f1Ufav44fU6Qe88UPLjM/rH9KhUygiWX
	iJd+MFe91y1TLg7kFr9cdw6QzzqOJjSiOdNrp/ZJPQ==
X-Google-Smtp-Source: AGHT+IFiz9jLtqqyu/bUfWMmxSrAm5G7bYi6ikGRjXOf59sT/YSLJOCOxtl+UgwPUHqNHm1pzNWBgFg+uSCJnwzcVVA=
X-Received: by 2002:a81:6c13:0:b0:576:93f1:d118 with SMTP id
 h19-20020a816c13000000b0057693f1d118mr895084ywc.2.1696370100826; Tue, 03 Oct
 2023 14:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org> <169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
In-Reply-To: <169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 3 Oct 2023 23:54:49 +0200
Message-ID: <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ixp4xx_eth: Specify min/max MTU
To: patchwork-bot+netdevbpf@kernel.org
Cc: khalasa@piap.pl, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 11:40=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:

> This patch was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:

Sorry Paolo, this is the latest version of this patch, which sadly changed
Subject in the process:
https://lore.kernel.org/netdev/20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb9@li=
naro.org/

If it causes trouble for you to replace the patch I can rebase
this work on top of your branch, just tell me.

Yours,
Linus Walleij

