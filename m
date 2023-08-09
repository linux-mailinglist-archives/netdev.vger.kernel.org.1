Return-Path: <netdev+bounces-25914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D915577628D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FDC1C21301
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8A174FF;
	Wed,  9 Aug 2023 14:33:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86B19BC7
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:33:07 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD79F10FF
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:33:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so2239166e87.2
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691591585; x=1692196385;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DMO22sR7rAGAsh9owaqhAcsytx1Lgh3WgAie+WDnqQY=;
        b=IdZaweNg4Th/nemZFwDoyVpxr04PCgeAhNDebKThe8BpjM2BFvBp+WIqtKqwuan7nF
         cC+tl0rR/WOUidMbq7fYYGBv/rrHw8f5Bv9UdiiUNG162MNaHowh6KR35W8iIsWBzr7l
         XJyJbKYSY3/qLUVN6eNvYsc6CFJ3V2owqVQ3Q8U2ZXFgaKfyHgVmSzHLSOPhotnwoYIQ
         Zwj8tULy6Jl//GeyHn5vPuQtPG8ZnXgG7kc2Cbxz6tJpEURmUhxMq1C5y5rOencNWTcK
         Ybyx4AykN+Fz3RdVKiZDYP0LaZG/P/dbg3df/UR/r/UT7x9fFiAlHDsniZG/I7cl4rB5
         kwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691591585; x=1692196385;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMO22sR7rAGAsh9owaqhAcsytx1Lgh3WgAie+WDnqQY=;
        b=gdHgmUm7j5PR+j72CLXi+MB3CfbLTHzYr+KZrAzotgfQurM6NY1nP6hND5eXG8K5xr
         rAkrIDm2u+2g2z6TIoyftUWot59mHn6uCeexBMeLLfQQzQwtKxgUM9lGFUyCduKjVPOC
         b+cqSnOBI2pq6ddwhD0YRq5X4vDPKgi8cNEPMhly79pRYsgAX3WFLJYIC1hfnRWWHG+m
         Jp8167JsfF4Vc5O3Ao6JB/L83ByHwfnvJ7M/CNpAwJq967Mceh1y7TCrM0brGNYcaixQ
         QDuHDvcujWBYpzYzoEa5jT5kKlEy8P/dUp2cZpywPx7HRMLV+kiKLsFmfJTwZU0BwNGq
         9Fyw==
X-Gm-Message-State: AOJu0Yz6r8a+Cxlgz9APpnalcy/cFDsjxEtM/Lf+zLgVWgA96MwX7DSu
	T2Tj0bG75ULzBzsH1hIxwv4tdqech3c5e65sGIVzShdXDeY=
X-Google-Smtp-Source: AGHT+IEgK7weqYfgpTXeqyb4kADdJKsVwqXT6stgAkkwm0brS0UOxfCtuhFyQCBn4loZ9xWbof/jIBUFgbIobaq5DCg=
X-Received: by 2002:a19:2d45:0:b0:4fe:a2c:24b0 with SMTP id
 t5-20020a192d45000000b004fe0a2c24b0mr1906362lft.26.1691591584559; Wed, 09 Aug
 2023 07:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nayan Gadre <beejoy.nayan@gmail.com>
Date: Wed, 9 Aug 2023 20:02:53 +0530
Message-ID: <CABTgHBvx62nrr2fSOFFyDaB7OUpOJ-uozOg7_Y0adbLJxJhZcA@mail.gmail.com>
Subject: Calling nlmsg_multicast and nlmsg_new in softirq context, netfilter
 hook function
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I have a netfilter hook attached at NF_NETDEV_INGRESS, very early in
the network stack. I am doing some filtering on the sk_buff and if it
matches a certain condition, I want to send a netlink event to an
application.

This will involve allocating a buffer to send using nlmsg_new, with
GFP_ATOMIC flag, as the hook will run in the bottom half and then call
nlmsg_multicast().

Is it safe to call these APIs in the softirq context / netfilter hook function?

Thanks
N Gadre.

