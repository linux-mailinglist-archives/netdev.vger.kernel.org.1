Return-Path: <netdev+bounces-24639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BD5770E76
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825D11C20B31
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC866D24;
	Sat,  5 Aug 2023 07:34:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0D1FDD
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:34:28 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFFC4EC9
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 00:34:24 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76af2cb7404so216465385a.0
        for <netdev@vger.kernel.org>; Sat, 05 Aug 2023 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691220863; x=1691825663;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w9uyawjZHnUZYQY4bK5UiV75xekF3m7LclUMpvxGdxc=;
        b=IbJDK+jO92ODgVuLtNd5BBX5bHS0jhghWsv4QkoqAzLulspcFU8J8yP5oK/BKCNU5A
         TImYgK80BkmW2VgCAHSNC1BDqZAXspVbZqkioNomL687pSAlRxTa4r05UdShc7p8lNHi
         C7D9tHV2ZJ2JwPthfG7VlYJhyKxhnpivk4/OdMpf08pr6L83MKupPBa10hBkLEaq1HVK
         Xzv8LTPaBfkLBggHQlTmWmU4Fb+5wIppzN/iuFeUlynHviv5lq2coOcmHdjzAKfprwUy
         mrERV9Ciy4ScmEU9XmK3ArrstMjEqBph4wRxHI1O9AYBkOXm3R3gfUI83zbDkyveYui9
         1oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691220863; x=1691825663;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9uyawjZHnUZYQY4bK5UiV75xekF3m7LclUMpvxGdxc=;
        b=H4dsWw/VKAaa2r3qsMnMBWa3gLS5S214S1gSMLgx9NQIf3M3WnzpZpSjWEqQD9xFJZ
         XrfcmntDgnI/pbA+G/W8sA/y8xDICFBXiOdpZiBC09Pd6tQ+IRS8K7Da55At6kaqogy2
         udJ6YK4Xp/dj+J0WI4ez+xjHcDsqshqFqhz4wJwDamDN6GWFttP0Ld9rAPFDjfzgaEde
         et9t9+LhUfes8PIrJ9eTMMBocyhPcZXkjTn8st78flj4Pzju11OGMSgFt0pMSNz/+3z8
         s3c5C/P9m94ve5Wb+oIewYiu7g+ScvtkDRBGeZqjT3DFdD73fehnDhU+Kko8WOkgFQgZ
         0KHw==
X-Gm-Message-State: AOJu0YwxbzV9P/V8/O3QowWGQD7rbmdoOTtfvq2B8MQBMloS1RQ7Vsnl
	hiMbujZ676+kbrR/mmkD8r9NjsSl8VutnCvBKiHZTg==
X-Google-Smtp-Source: AGHT+IFdYcostVh57kE1L1S3kadAFjg+9iFXDHE2FAEn7ZWsTWYXPzw41CWvawMnXI34J9XRxsLPlCDQgPGLl/MPP7c=
X-Received: by 2002:a05:620a:c47:b0:76c:97fd:c106 with SMTP id
 u7-20020a05620a0c4700b0076c97fdc106mr5134931qki.70.1691220863327; Sat, 05 Aug
 2023 00:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Sat, 5 Aug 2023
 00:34:22 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <c38e208b-4ffa-4310-ae00-412447fc4269@lunn.ch>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
 <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
 <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com>
 <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
 <CADyTPEwY4ydUKGtGNayf+iQSqRVBQncLiv0TpO9QivBVrmOc4g@mail.gmail.com>
 <173b1b67-7f5a-4e74-a2e7-5c70e57ecae5@lunn.ch> <CADyTPExypWjMW2PF0EfSFc+vvdzRtNEi_H0p3S-mw1BNWyq6VQ@mail.gmail.com>
 <c38e208b-4ffa-4310-ae00-412447fc4269@lunn.ch>
From: Nick Bowler <nbowler@draconx.ca>
Date: Sat, 5 Aug 2023 03:34:22 -0400
Message-ID: <CADyTPEyQcHd5-A2TLf_-U5KdtA5WKZ_mNYKvx3DSMjkNi99E0g@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-05, Andrew Lunn <andrew@lunn.ch> wrote:
>> > It was also commented out before that change. It could be that gpio
>> > controller is missing. Do you have the driver for the tca6416 in
>> > your kernel configuration?
>>
>> I have CONFIG_GPIO_PCA953X=y which I think is the correct driver?
>
> It does appear to be the correct driver. But check if it has
> loaded. It is an i2c device, so maybe you are missing the I2C bus
> master device?

That's it!  I needed to set

  CONFIG_I2C_CADENCE=y

and now things are working again!

Thanks,
  Nick

