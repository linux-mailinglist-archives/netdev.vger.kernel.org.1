Return-Path: <netdev+bounces-16596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADC74DF55
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FFE1C20BB8
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3715012B86;
	Mon, 10 Jul 2023 20:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B259156CF
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:31:45 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08611B8
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:31:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-54290603887so2619397a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689021094; x=1691613094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLUXzW45fNtKQUTxM0cQ+LpI4FCLZwAkwBZ3h864l5M=;
        b=E8fC5eW+KBgE3o2KWOm0ydGtw3mA0Qg431pvJU15uoZfSSLPXIdSy0ms5erQBT36Bv
         ssgLPOY3trmY/XL1h0CYYJiY21FRE0dh2U7dFWNuEUDay1jUbcvJhe1m8LuGMFduMK0e
         3Kwh6I1a43i94OhzNHBKrmUWWYP+okOSaqkDDItjpldYjgZAs4eKymIBczKfTF7wlcyg
         D05ztzXi0agp5IsozWskclFgzDv72aCpwmDYuv0xdzF2IM/aazrV/fQZ03FgwqihxZrg
         WMhj6EJxCPlYnYLSXiBemm/XkysIkc/qZfJoHeIWg24C14yu7E09/PJ4dtm4jgzJeMKW
         L4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689021094; x=1691613094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLUXzW45fNtKQUTxM0cQ+LpI4FCLZwAkwBZ3h864l5M=;
        b=FidZ15kQwmb8Lt6pW1Z2tDgt2MXoOnkU3hFE8Uuvzjv08vMoCs96xnvnI6301LwkH3
         6dkWkhUfdVjqA4fiLoXFbcZDAxX1CgsMzYXga5+22rRZEhJpaDsk6o5LTxPb9esklY3q
         qEo87KsG6HwVzjom54hKYxwtUCJhyEaIS/rGm0w45LxPK9fsMdblKAerWlddK1Dr7BPp
         x/Mn8LXZCH4+CLQ4hjIKI28rZzWHKgiMJYgLD4JkY6thKH00X7Bb23PHSbEZ0imDaA1o
         wQR0DHCHwqmcywVx0Tfg2XE0ZCdQ6rNp8L8v7dmux6wn3vuTj6fN/pSfRZfcAFdpoolD
         dDYA==
X-Gm-Message-State: ABy/qLY6F7MNfuZxaPIAtluylBGMe8bev2TGCnWqi7Je1r2E+8ZghWj8
	gcKuPyKGEX+DjHZMhEAlwC7aNXflHI2wCjsxXhV8TA==
X-Google-Smtp-Source: APBJJlFbOdJcfnAUcAtYooYEBwbQ/E3Y81++E7RzrYe01HqpIPF/4rJyRoeWsc/TFbCWw9phgrDUmg==
X-Received: by 2002:a17:902:e80b:b0:1b8:a812:7bc2 with SMTP id u11-20020a170902e80b00b001b8a8127bc2mr12930915plg.8.1689021094399;
        Mon, 10 Jul 2023 13:31:34 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902728700b001ab12ccc2a7sm304589pll.98.2023.07.10.13.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:31:34 -0700 (PDT)
Date: Mon, 10 Jul 2023 13:31:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gregorio Maglione <Gregorio.Maglione@city.ac.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Florian Westphal
 <fw@strlen.de>, <netdev@vger.kernel.org>
Subject: Re: DCCP Deprecation
Message-ID: <20230710133132.7c6ada3a@hermes.local>
In-Reply-To: <20230710182253.81446-1-kuniyu@amazon.com>
References: <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230710182253.81446-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 10 Jul 2023 11:22:53 -0700
Kuniyuki Iwashima <kuniyu@amazon.com> wrote:

> I think it would be better to review others' patches or post patches before
> stepping up as a maintainer.
> 
> However, this repo seems to have a license issue that cannot be upstreamed
> as is.
> https://github.com/telekom/mp-dccp

The whole license here is a mess. IMHO it is using existing DCCP code
as base, which makes it a "derived work" under GPL rules.

