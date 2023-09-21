Return-Path: <netdev+bounces-35467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1387A99CF
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE3C1C20257
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27BF45F7E;
	Thu, 21 Sep 2023 17:24:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095D45F6F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:24:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7497F80A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695317040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8073cadbomZvzn1x3/jFCjzqqbS1eUbDSTmbFgCsS0=;
	b=ail57T0wAXAFyCDL691B7TuGjUyUx+JIdmcEVYJf5ApJj5tTEZHLWHxkHHSHxIq5pmuDGR
	kQxcTsb68F7K41Lw1YOlRCe1hFCDIXS4nRi85WBDVfE6DFvz9ijP1FwXq5vAvJ9WBui2ib
	IuctH1p2C9RZNUYvtUWpsfWuxt3Cw8A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-XVm1yxX6ORmLUQn8z4pTRg-1; Thu, 21 Sep 2023 03:55:19 -0400
X-MC-Unique: XVm1yxX6ORmLUQn8z4pTRg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae5101b152so16560966b.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 00:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695282918; x=1695887718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8073cadbomZvzn1x3/jFCjzqqbS1eUbDSTmbFgCsS0=;
        b=ZLwQ8PMVmF6poQHheZVVaSvDVhbxfWKi2z5Oa+s7OAMNhxL9PB9n2Jad3XZ7cPbyTt
         GjEOGCseBawPtsiN4sglPOxYIi6WgQvqUlgScu/Yu/0rq5UE9q/LlVGtYd5sPYSOkoMc
         wcIhS9YH80e5PS08DFhmfq32CM7JrAbJHYribce18gbqnuLXUqSAwum0v5XQUcFeYexb
         CA76G3u7osqHnRd2nP4deeEJuCAMIz2DFKjI/Xao9+e+PbYPP7vx9XZ2ayd/aUx/CN+g
         IUsIZBcks/hYHTvo4uurrffY25ibQa+ifwcahw+/RxpcMhjkS1j2Ogn16qJFBn1c5ZKe
         1+2g==
X-Gm-Message-State: AOJu0Yx5MIBzatTG/jXAXb2VEa4tmAlZtnpPmrOHAdGb+dADEq0KaHbK
	atRr1gY+J13LFJDhT3rJaNow6Qnfi+x8m0pEWJJ4b7oAqBrujo/JXXExkPOYXJIvenvig8YuI+A
	dPxQo1LkUc2CQILoz
X-Received: by 2002:a17:906:d3:b0:9a1:d915:6372 with SMTP id 19-20020a17090600d300b009a1d9156372mr3807383eji.4.1695282918004;
        Thu, 21 Sep 2023 00:55:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSF1UlZO3avrXPLFXBb/vxNsqsACyKLXNET84ThtyZNLMmNfBCh4PTxsgjk9xoZz4KcuIv7Q==
X-Received: by 2002:a17:906:d3:b0:9a1:d915:6372 with SMTP id 19-20020a17090600d300b009a1d9156372mr3807366eji.4.1695282917682;
        Thu, 21 Sep 2023 00:55:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090614c400b00992b510089asm647510ejc.84.2023.09.21.00.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:55:17 -0700 (PDT)
Message-ID: <9eac9749406d91fd42520479b4c463417717246f.camel@redhat.com>
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-stm32: refactor clock config
From: Paolo Abeni <pabeni@redhat.com>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Christophe Roullier
 <christophe.roullier@st.com>
Date: Thu, 21 Sep 2023 09:55:15 +0200
In-Reply-To: <20230919164535.128125-4-ben.wolsieffer@hefring.com>
References: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
	 <20230919164535.128125-4-ben.wolsieffer@hefring.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-19 at 12:45 -0400, Ben Wolsieffer wrote:
> Currently, clock configuration is spread throughout the driver and
> partially duplicated for the STM32MP1 and STM32 MCU variants. This makes
> it difficult to keep track of which clocks need to be enabled or disabled
> in various scenarios.
>=20
> This patch adds symmetric stm32_dwmac_clk_enable/disable() functions
> that handle all clock configuration, including quirks required while
> suspending or resuming. syscfg_clk and clk_eth_ck are not present on
> STM32 MCUs, but it is fine to try to configure them anyway since NULL
> clocks are ignored.
>=20
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>

This patch is for net-next, while the previous one targets the -net
tree: you can't bundle them in a single series. Please re-post the
first one individually, specifying the target tree into the subj.

If there is a code dependency, you can post this one for net-next,
after -net is merged back into -net-next (Usually within a week since
the net patch is applied).

Cheers,

Paolo


