Return-Path: <netdev+bounces-43812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F13AB7D4E48
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7511DB20BD1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B6E219ED;
	Tue, 24 Oct 2023 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LseKrDJD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B905CBE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:53:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDDC109
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698144811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6ob6RKRIAPi5Khx0xpjNiWs6euw8iDGvt/Bc/jthnM=;
	b=LseKrDJDeviJlhuurHo00cTFJQRmO+7iPJamiVPUz4UYkAuAJBxSlQU2yrVSck28SBy+wU
	Ot/EsutMtlgE5n1clX8OXT5oFp3peX1jwUrWwo72gzQ8B9E5z/fN3KPYLWdRa6REnyWrT4
	lHym4e2geEaPvgVik2DioVyCyfGTXnI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-zxz326yeOk2pSRZ7FLhM5A-1; Tue, 24 Oct 2023 06:53:30 -0400
X-MC-Unique: zxz326yeOk2pSRZ7FLhM5A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c50cf8cf25so7607361fa.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698144809; x=1698749609;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6ob6RKRIAPi5Khx0xpjNiWs6euw8iDGvt/Bc/jthnM=;
        b=GvQ1LDdHZjDtrRvtaV146SKVt02r6t3GLHagyLFp8SnanZiS+NJ6YC/Y1DGtGecxsJ
         aZPViE3vSYmXSjh8f+al+8Zfj6TNh5K/FnMV41eNyXb1JPzN7doioc9XXLj8fSIA9OqZ
         5R9EpdARpdmDO9rIVV/JJdASbdcJOcNG7BQJinoT6aTWCKpGsvkODmkUFc1xLvN5VOkb
         GqrnO6n1T0qWyefGUhGyUqWQYsMcXcBuF3swdlTj+pFO4c8W/poVTCjxe6jax6e0m0qF
         rZSqD3DVO2rtu0tylPW1w0DdmXP2wfD6WFk0zmzXEU/slwTQlXYr3IxWYquxVWK3NvXz
         gIew==
X-Gm-Message-State: AOJu0YyajsQwiB7fLfjP6EXZaK3mbjTkb3SlvaECXeg7NbJeMwwqAXLL
	RvkicL750wp8+gLoZVTRi0IpQHVJtcxKTps9ib/m8IDhry6f1TlyY/uRyfaS6/RTC7Yuzev3z6/
	3hz0QR4kWDp4VBDxs
X-Received: by 2002:a2e:9093:0:b0:2bf:e5dc:aa68 with SMTP id l19-20020a2e9093000000b002bfe5dcaa68mr8167968ljg.3.1698144808820;
        Tue, 24 Oct 2023 03:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6+UwT5yEGXNUvPuTwPIUcgM8GHlIrJ64DEgbjtALnH/OkHpdWanmLDXcDqMv2xU2rWv9gcg==
X-Received: by 2002:a2e:9093:0:b0:2bf:e5dc:aa68 with SMTP id l19-20020a2e9093000000b002bfe5dcaa68mr8167954ljg.3.1698144808405;
        Tue, 24 Oct 2023 03:53:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-180.dyn.eolo.it. [146.241.242.180])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906070e00b00993664a9987sm8086424ejb.103.2023.10.24.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:53:27 -0700 (PDT)
Message-ID: <b0b4054adcb5250ad49e19d8f90c89de802f0125.camel@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: ethernet: renesas: drop SoC names in
 Kconfig
From: Paolo Abeni <pabeni@redhat.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-renesas-soc@vger.kernel.org
Cc: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Oct 2023 12:53:26 +0200
In-Reply-To: <20231022205316.3209-3-wsa+renesas@sang-engineering.com>
References: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
	 <20231022205316.3209-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-10-22 at 22:53 +0200, Wolfram Sang wrote:
> Mentioning SoCs in Kconfig descriptions tends to get stale (e.g. RAVB is
> missing RZV2M) or imprecise (e.g. SH_ETH is not available on all
> R8A779x). Drop them instead of providing vague information. Improve the
> file description a tad while here.

It's not a big deal, but assuming that keeping the SoC list up2date
requires too much effort, I would still keep it, with some additional
wording specifying it's partial and potentially inaccurate.

Such list could be an useful starting point for an integrator looking
for the correct driver for his/her SoC.

Cheers,

Paolo


