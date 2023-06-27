Return-Path: <netdev+bounces-14175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EBE73F5AA
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 09:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704FD1C20A89
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F128A92F;
	Tue, 27 Jun 2023 07:28:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F0846A
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:28:27 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3226B7
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 00:28:10 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4008b90d2f9so37166931cf.2
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 00:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687850890; x=1690442890;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTa9WgC2aqAhDQVp0qS00kuU6fbWOJaz0rosyaiq0kc=;
        b=Z1jx04Mf4ca0CPFI+NLFmoJLigdRp7Djj8WXTT91KBkOTKJef1V49pZTkmnr3q7IdG
         8rBNbwEFJwi+YJVR2F3awTpt16/OwIs55kl8zoJhIIi4YFeqRSQMQy3CN6QIxkCJ3sZ6
         AiP2dg8BwIOnfA/tcMC0AIi4Dthr6j0RZoU9DOBZcFKAKuVSjVGQ53Iqo+VTVVlDnncp
         6giylaiyu9eQzGLnl5csrY80sPKuC6Ql4t8gUY+3tka+WpqLMZgZjaBdFY5AL1/Uxod7
         6xUuQdIjpkoOpiJchCeAzNL03m+by0J6SETnCuwZJ3OvpSyqTnZeankxB6ZazjRLu7Xh
         YLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687850890; x=1690442890;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTa9WgC2aqAhDQVp0qS00kuU6fbWOJaz0rosyaiq0kc=;
        b=XW9PvLoNasQr1ySpjMvaupuA0jbJ8F3NBSVKpy0aC5M5SGfSj7nnG5klTJpygIUgD7
         HQKcYfIRZj3h1vF+4g5R8Xcrf1oh5A1sD57Sqot7BQ0i0iWhvPPVNzXeZ5m8TghWHqkP
         saPgJeclfyhHnbh3L930JDKo6v5qjDE8+UMaGOtINlkKdLS3HYGHBhNhP6DTdX1B/Cys
         vEzV5USeXYx1GmjPT5cw1j+OEkHd60carKuEX6j93GFAWVw9iT6v23aq0Azdf78Kitq+
         ciT31sUv/XFsRGQXYqCudbTVo+bja6OyCoJ0hHfU8qVMx8nx9wkhiBoQHGlwI2942I6S
         xLNg==
X-Gm-Message-State: AC+VfDzoihnZcCwIPrb6ApFtjq0qMvxQSX0b41XLRRcQnWGaVUOUvdlI
	w4hSURWjQ2FRPHRH0rnM9UNiL5DfSCGlgg==
X-Google-Smtp-Source: ACHHUZ5ca2zdLgPjuF2rMTK/TBPkVDdwLFweaJEQ2mB3x3rNjbSO4cBXZphVrTZOT6VhAdiY4Tsnsw==
X-Received: by 2002:ac8:5e50:0:b0:402:43d:af09 with SMTP id i16-20020ac85e50000000b00402043daf09mr1616924qtx.43.1687850889759;
        Tue, 27 Jun 2023 00:28:09 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7822:1d40:9d84:74b4:64c0:8bcd])
        by smtp.gmail.com with ESMTPSA id g28-20020ac8775c000000b003f9aecb599fsm1362501qtu.35.2023.06.27.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:28:09 -0700 (PDT)
Date: Tue, 27 Jun 2023 15:28:03 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Lebrun <dlebrun@google.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org
Subject: Why we need add :: at the last when encap seg6 with inline mode?
Message-ID: <ZJqPg7Ck8ulDp2f+@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David,

When I tried encap seg6 inline mode via iproute, I saw it added a :: address
at the last.

# ip -6 route add 1234::1234 encap seg6 mode inline segs 1::1 dev dum1
# ip -6 route show dev dum1
1234::1234  encap seg6 mode inline segs 2 [ 1::1 :: ] metric 1024 pref medium

In the iproute2 code

```
static struct ipv6_sr_hdr *parse_srh(char *segbuf, int hmac, bool encap)
{
        ...
        if (!encap)
                nsegs++;
        ...
```

So is there any reason we add this?

Thanks
Hangbin

