Return-Path: <netdev+bounces-14275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB973FE0A
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC6D281083
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C5617FF3;
	Tue, 27 Jun 2023 14:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EFE1772E
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 14:37:27 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D5F3AA6;
	Tue, 27 Jun 2023 07:37:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fb10fd9ae9so20026885e9.2;
        Tue, 27 Jun 2023 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876631; x=1690468631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9MhYFB3Vnyn9pGR4cU1f+rWvzWLxp7ZwlU3PpNKPX7A=;
        b=mxf2FptiSsBdSQaiB2DlyXaQq0HHjtnYezWq2o/OGj+B0wLLbMsdEXxnGZw9g8sIEl
         TwgjnBtCuzsf9cHpg31bFI2KOIc7dSHhaBOCSSv7t5XsTo/+QUm0JnrNPyN62JOea4wj
         6GOg/YxUubaY6EwgkrbSO1Db4Uydhrk2sJO43G2/eNUiHrhyYboImKs/zNOQzZ5Yvr1o
         7Ia1LHgNccvI1pGD7k9IauQXg8K7YOqb2g3AKRi5fHh0WjlWrS5PvwISOJHkeoVm2YCO
         vBwzSOd8yZgWYJFYoFPEvYZUu42q1loQawklsneXTtAJbjPpei+WhA9R/VUV7dymDe4P
         zVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876631; x=1690468631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MhYFB3Vnyn9pGR4cU1f+rWvzWLxp7ZwlU3PpNKPX7A=;
        b=Ddn6oEjTZc2a4DuqhuDrwPNZynCMKEF24T5UjzN4W0QHzhg9S6JycnRowN70NCYco9
         rHcdpFiygjPBxuk9hhI/nd8Xf2o1PKuANGI+fluC9Lfk8YI32UgyREQR2PpbRDLWbspz
         oEUo3ZimTuqfZkO5m75hvRhFbhgzRuKlhbnsvGb1WYJHbzdoeQyP0kpeIyglGg/uf8nP
         gLwRg+LShmZs12QlC4ZaDZE+ulZO4C3Uo9emi2ZrF/NYq5uo1W3mR5B2PzlyGXjaABq0
         Wwf7mYZzVHezsZyPx+52jnbIZopsH0/nFhKwtjcC77i4lHckYYzVgYyi09BysJKig/od
         iLIg==
X-Gm-Message-State: AC+VfDwMS9LCICLKb27rjNLQW5c2OCzRXdsBJE9icd25wsPUXJvkecgR
	3c5iAHicmsPmdN0GtN5SU7luLSJQyBqgCJfpLiE=
X-Google-Smtp-Source: ACHHUZ4IpJw+jWEEf0rqZEhsnrHthI5Yk24fPER/Nhoy3Lx53fEEhwSx/7kBB0Fgt74gANa9byWYdRkXN7KHdFAkibc=
X-Received: by 2002:a05:600c:284a:b0:3fb:ac73:f7d4 with SMTP id
 r10-20020a05600c284a00b003fbac73f7d4mr43025wmb.14.1687876630480; Tue, 27 Jun
 2023 07:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627105209.15163-1-dg573847474@gmail.com> <CANn89iJRaT1B=HwWDsEdcAUZzYERzeR8iwGYHZuLcy+G4G39Lw@mail.gmail.com>
In-Reply-To: <CANn89iJRaT1B=HwWDsEdcAUZzYERzeR8iwGYHZuLcy+G4G39Lw@mail.gmail.com>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Tue, 27 Jun 2023 22:36:59 +0800
Message-ID: <CAAo+4rUwQ0Nrb4M+nhpmyEXVssxVLPs0N9pqohTfAeeZ9tbffQ@mail.gmail.com>
Subject: Re: [PATCH] net/802/garp: fix potential deadlock on &app->lock
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I should have noticed that _rcv suffix mostly denotes RX handlers,
thanks much for pointing that out!

Best regards,
Chengfeng

