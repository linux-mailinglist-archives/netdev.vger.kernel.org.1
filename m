Return-Path: <netdev+bounces-19512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14C675B061
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB281C21410
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E7182B6;
	Thu, 20 Jul 2023 13:50:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD5182A8
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:50:49 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AA1A2
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:50:48 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76731802203so82943785a.3
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689861047; x=1690465847;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3qhQEC8Ls/fwzBUjmuEM9SZ1//1LQypH5b0znKJ4nk=;
        b=ovT6IzUCqDI16ffGtMVWfsopee1QcN3QS6PJw5CJVDvN951JKY0biU6YyjeDSRkSlN
         emHFHqCW7RE9NBIs9x8+951cQhaehVu7TRqRH41Q1i1Sha8degsM81cbbVx2raDeZNeq
         p2bVrARHHg1T/HwshZKrCJ84L3Sbf7xLYp1j2cjTRdpKdvTjjaHi1nIcmd5NHSE20TXX
         KdHBwUevwiwMu/Vxgo+IyT5NAS/n3os0R6HJ7D0TTXFS+87MZpslFUxl7lz0m+O5dAxw
         FYHOfKNpBl1AAbPZPABCdTzoVs1h+1o4rA1eAv9L9lkB/WcLZbXr/t+teXKcLdEcwkPX
         OzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861047; x=1690465847;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C3qhQEC8Ls/fwzBUjmuEM9SZ1//1LQypH5b0znKJ4nk=;
        b=WLUkS+CutXrkInyKGvh5TUb7yPCsl+dpkGOJ4rh02QtCSNBUzyeW3uOEI4/TLIgb0P
         GcKwTaz0HMej1yFJCNzQrwMcVfUiGwEGsoBePJ6GNdb06ExnOZ/1bqYACONrNviD0ZMA
         yJoWPH0fSRVRXhf6SybBdNUBCYWClr0AVy8Sxmw6KnXdT3XsiZnllTRypYQmEXYXAOKl
         JyY7FHxdxOJG2sF8nHOOjQ4ZbUq/iYePT+wSokavpBR+ssE2FKd5czhSuCqrPM4bh4qG
         hL4IS0P/5GXqlfLqHqE1TI1VA8hiD4WDRoKLrsbVkKtDpsQ+2Ktzc0SQTSqt+QOKdORT
         HRrg==
X-Gm-Message-State: ABy/qLa0k4A/s5Z7D5he+1aK9jIZyyoDqNKYlgbh7ltNRecMd6POuiju
	QL4G5W6/6O6QMSAuwohquxo=
X-Google-Smtp-Source: APBJJlFYsnTv60xdcoePBblK6MUDzs7hfO5P1l+qyifIGamwnjo4IigkEEUX2AhXi1f29Ur5Z2YV4w==
X-Received: by 2002:a05:620a:2793:b0:768:1394:45e5 with SMTP id g19-20020a05620a279300b00768139445e5mr14286344qkp.12.1689861047477;
        Thu, 20 Jul 2023 06:50:47 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a141300b0075ca4cd03d4sm249616qkj.64.2023.07.20.06.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:50:47 -0700 (PDT)
Date: Thu, 20 Jul 2023 09:50:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Breno Leitao <leitao@debian.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <64b93bb6d30dd_2ad92129482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230720005456.88770-1-kuniyu@amazon.com>
References: <20230720005456.88770-1-kuniyu@amazon.com>
Subject: RE: [PATCH v1 net-next] net: Use sockaddr_storage for
 getsockopt(SO_PEERNAME).
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kuniyuki Iwashima wrote:
> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") started
> applying strict rules to standard string functions.
> 
> It does not work well with conventional socket code around each protocol-
> specific struct sockaddr_XXX, which is cast from sockaddr_storage and has
> a bigger size than fortified functions expect.  (See Link)
> 
> We must cast the protocol-specific address back to sockaddr_storage
> to call such functions.
> 
> However, in the case of getsockaddr(SO_PEERNAME), the rationale is a bit
> unclear as the buffer is defined by char[128] which is the same size as
> sockaddr_storage.
> 
> Let's use sockaddr_storage implicitly.

explicitly
 
> Link: https://lore.kernel.org/netdev/20230720004410.87588-1-kuniyu@amazon.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

