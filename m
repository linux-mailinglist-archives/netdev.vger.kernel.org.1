Return-Path: <netdev+bounces-32222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B183793A4C
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 12:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229631C20A78
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF2E10FD;
	Wed,  6 Sep 2023 10:48:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D77E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:48:10 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A48C170E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 03:47:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so55650891fa.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 03:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693997278; x=1694602078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLyCL7xfksawPaVIRY4PEBqjrincEleWhjGbBohkPjM=;
        b=YJI0u1910IMwPW41ZWNc63ucA22h/QZyIgq6aalHv7sZE5j+6kHtPsfcxSsiL9DWNj
         YqlHUlTKMvrjNKi5BU0CEPqSEb3NESC7Avv/cvKBn9/T6Ldvh/fEhGYIh7ztbxebxjlM
         vDlWTAUwZ8ivxZ+StHRKDVsMcxZeVxL4icetxNWqzC7KnPkVitoO07bjCc9vQjYt1bOr
         PLRRpW48qKC5IBp4MTQFOaOGVeyErOyKzrkHdyRbEHLbF+QpeU/tUmw4GJH4U08txUAI
         tBwVdHTJFz3c7990IDmb1POo4Vr4GpnyRcyTwvJQGW0o02jGiEkfNQcr2SsiZC7V/jai
         W16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997278; x=1694602078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLyCL7xfksawPaVIRY4PEBqjrincEleWhjGbBohkPjM=;
        b=PsuEybdneRYeT/xVWR38ZBX3VZ3td6KoZ6yc5Q3qoD2rRRuEDJhvgqAUUbAS4QuPL3
         Z0m2Xxyjljw8PzRf1vdy3u5K9AFwwSGnR8ur3FJx062ssMJaNhQyQwNcU84ZgYvmPApq
         J7dBwz7Ma0vMuvbmqSZGLzy+PZY28odYpPxbEOPBAAwMo7YTjIXnSTcZhv9WL24oMrQX
         GqS0UgqWaHuLN8B0jTfPfgrLEGGDr5bkwaA2XVNd2QSwxxN8pGB9hNWMLVLLMDCg1ufk
         rF8LRY3u+JgyXOgZmylv4I8yotqVoY48PCZ77U/vynwgBbd1C9RPpyZW2pOzZA7R+eVv
         lHHQ==
X-Gm-Message-State: AOJu0Yy5g8kqzEtubNeZzEIo7JWarY846/I51BWqTzJJX8Xs8NrkfUtE
	lUj2Hk+JEF7QGSlhJbp9XBxGRoFC/do=
X-Google-Smtp-Source: AGHT+IE6r/H5eFT1M+exDeXXLni5kl1DZ4DHVXVDl3sV6/tOBvsFAAA2krH/77cKQnJ5XIJMDmd8IQ==
X-Received: by 2002:a2e:900e:0:b0:2bc:de11:453b with SMTP id h14-20020a2e900e000000b002bcde11453bmr2098736ljg.1.1693997277607;
        Wed, 06 Sep 2023 03:47:57 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fe1fe56202sm19508728wmi.33.2023.09.06.03.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:47:57 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: richardcochran@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com
Subject: 
Date: Wed,  6 Sep 2023 12:47:51 +0200
Message-Id: <20230906104754.1324412-1-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZO+8Mlk0yMxz7Tn+@hoboy.vegasvil.org>
References: <ZO+8Mlk0yMxz7Tn+@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Thank you for your patience Richard, and thank you for guiding me. Let's
see if I got closer to what we want this time.

Let me know what you thing about these patches, please.

Thanks,
Xabier


