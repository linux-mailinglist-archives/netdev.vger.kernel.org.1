Return-Path: <netdev+bounces-24494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032117705F8
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FD21C218C8
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992AE198B2;
	Fri,  4 Aug 2023 16:28:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C62AC14A
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:28:42 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E514C03
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:28:38 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44756c21105so1519448137.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691166517; x=1691771317;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CmP6zS1uXQ/K4lwCiJguuc04GVnNi9A4y0catAtEmbc=;
        b=sW9yq5KzPS0L46lWKz5VGV38bjUrHawEujFHjlMsubd/4Hqs3gHprOmO4gNbRr5D9j
         bF14WYricFRhWf0RpG7+XjtjygcHTfFEA5NAXecROdNgaMMVevu1CBZfZmnKV4tbVtSI
         3biRnPq6hyMii/k8zEj6YNUBeOWrhTWHVYjBcS9Q9KoJYS0gEemky9i14HCPVj8c90Gj
         tpDxYLUGTg3z8ImpwN4ERkgGoG/gvUa7ZuvIKpLyndXieNsNunV6JM58UxK8RJ+93xM4
         KnJMdzrBQXcGsI4sVicBtIqKlggrB5jDoIRhBzVUeZDo+hBCXfOuqvrP4k9SsE0S89HS
         Dp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691166517; x=1691771317;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmP6zS1uXQ/K4lwCiJguuc04GVnNi9A4y0catAtEmbc=;
        b=W53FDID031NZuhCQ6+tuF1b1fpY7jqv2nUEO+RqI7AAEZUqOocFFPACx99Aydlc3GV
         avOrh+QtqHE88VxoU33Zn24q3vxaO0j6XHzGjok3ily5cY2KHEwt+uauefcGYmAYnATG
         gJQYq+vRz+tf7bxxYcr36+Z6Q2c0r8bM1uzbhoL7dcJsO5PL/gFzp4HtWlog/7SpxdxM
         hF4A4+39FiQcmpmOdoUAzinP/N6vUygTSMd1EDPdKTGsWEIp60wIKvXs5cmncb86GKr/
         kXt0fJ0cz4GBHeXCOtwo6KQyJsDzTO9Hyuk58towIkTDcw+27eWGmt/yMfCBWskjKON1
         n4PQ==
X-Gm-Message-State: AOJu0YzJLFeMHlWKP23iCrx+QW9PJSOz/CAWa4ePdAaonLMrfJDMBqnX
	eNIwZXzEFBW9QHfQ2cxv5LRXsnrKCNCF8ZOdmg33AQ==
X-Google-Smtp-Source: AGHT+IHtQ9SnoRs+JPYtT5RMH212OiXnM2yKMpz4zFAz0pvLJ97XKzr3dhy2e6GbNWkDQAh9094YSIW9rpR1kW4fGuk=
X-Received: by 2002:a05:6102:3127:b0:447:c2f5:ee09 with SMTP id
 f7-20020a056102312700b00447c2f5ee09mr134792vsh.2.1691166517567; Fri, 04 Aug
 2023 09:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Fri, 4 Aug 2023
 09:28:37 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com> <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
From: Nick Bowler <nbowler@draconx.ca>
Date: Fri, 4 Aug 2023 12:28:37 -0400
Message-ID: <CADyTPEwvxrEUnHtMq==nUC7ai8AR-N_1CHXErkQo4Pbfcx0OKQ@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-04, Nick Bowler <nbowler@draconx.ca> wrote:
> As far as I can see, this is supposed to be handled by the code in
> drivers/reset/zynqmp-reset.c driver, it is enabled by CONFIG_ARCH_ZYNQMP,
> and I have that set to "y", and it appears to be getting compiled in (that
> is, there is a drivers/reset/zynqmp-reset.o file in the build directory).

Correction: I typed zynqmp-reset.c but file is actually reset-zynqmp.c.

Cheers,
  Nick

