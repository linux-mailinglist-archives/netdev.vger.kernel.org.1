Return-Path: <netdev+bounces-44572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92AD7D8B5D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6375A2820F2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73FC3E47C;
	Thu, 26 Oct 2023 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZDhVB3p"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DC34CDA;
	Thu, 26 Oct 2023 22:03:34 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF4194;
	Thu, 26 Oct 2023 15:03:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a0907896so2060427e87.2;
        Thu, 26 Oct 2023 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698357811; x=1698962611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q5hLrNJsmwnCO5l/iKscXNMyGzsoKX1e7ZUXZvYUQ+E=;
        b=VZDhVB3pWNlapxf0QvGjotICTMY9TfBLlXZobyupzLDSkZcqpvgXJZGl84XIOUViRN
         s5qKGIdW1CwBhDRHF2pyr3jw/ytYtjyVobKjFh7PAEgH890NYuWl/7jphoYlly/nZRxz
         m0EhXRx3AJle++2rYEIGl/8NtfxBngaLRA02a3BMR6zGyBYuz2V/bbjBle3ivDfb8132
         dC7Ut0U2/ACUsCJhRe9sG7nVTqen2iUPRjioCs853up2odndd8cYw6wK28F4NnpowYix
         mzUqtjBTFgmTH/P7NNNGYF0S4DpZ4aldXUuFi0EGlq5/ECkJ7hUlD9wV5ohH5I3SaopI
         8J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698357811; x=1698962611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5hLrNJsmwnCO5l/iKscXNMyGzsoKX1e7ZUXZvYUQ+E=;
        b=eyQ/H9Q5iWKzvDADONE+ofju+h0VsVhO9UrBa1jn4ijGVeYQyd3mFSV5jdq8tAP12C
         vRsmdh3OAEi5dlnOwQaqh9EWDsH8oBNepgp1ScyPfmjYh8T0I7Hr7etrBwOn2PjQpTC7
         vLHJr8eoAhjU7GpQBF0rdxmUGT20t0GFRDjyy2XNHJ2wzzdwCRjehBjVh+CXMXWSRsZ7
         3N077ix21KpdGemlCecqcmTEpcXr34Bw1XuXoS4BMYLhx6DlmVKakhqLSVkfQnBxRkqq
         SykbZ157+eLzpJKbRlWG60QlrtId3Zbiu/8sZC/tLVkDK5JjHUe/rNa2NGKVVBzjdWB5
         lijg==
X-Gm-Message-State: AOJu0YyvKJzqQTbu/J9FWtpX0DdUe5/CUv0ebISjftPIe8woZlozuXUw
	a6/cQn5tOvkCrYczGpDtx4vUZ1IDL5Gp4dwXZBw=
X-Google-Smtp-Source: AGHT+IHbgZl1rbe/BbKbUA0u9EHvueRSJ46VOIWp7wWXxyKGtD3be/nmYvNaoh/DzKVRPpw6egm8xijuXEsCU3DzP0c=
X-Received: by 2002:a05:6512:208c:b0:507:ab66:f118 with SMTP id
 t12-20020a056512208c00b00507ab66f118mr397456lfr.68.1698357811023; Thu, 26 Oct
 2023 15:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024205805.19314-1-luizluca@gmail.com> <20231024205805.19314-3-luizluca@gmail.com>
 <20231026205807.GA347941-robh@kernel.org>
In-Reply-To: <20231026205807.GA347941-robh@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 26 Oct 2023 19:03:19 -0300
Message-ID: <CAJq09z5wm=WMifELQ2cEYWb1L4Wsc4nkaj0o8p+fireY5QG-uQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: dsa: realtek: add reset controller
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +  resets:
> > +    maxItems: 1
> > +
> > +  reset-names:
> > +    const: switch
>
> $block-name is not really a useful name for resources. Generally, you
> don't need -names if there's only 1 entry.

I didn't know the reset-control name was optional. Yes, it is not
useful. I'll get rid of it.
It looks like there are more bindings where it is not necessary.

Regards,

Luiz

