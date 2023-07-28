Return-Path: <netdev+bounces-22109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCAE766167
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4128259C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7DA15C3;
	Fri, 28 Jul 2023 01:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FE7C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:40:24 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F27F35A2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:40:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso25073761fa.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690508422; x=1691113222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsvPJY+VBTqE0LdgXqK5KYxEPsSBisJ2WKCxekzzaKs=;
        b=pv7dDKN2YAyvwe/Z6xaiM4O4h7BBC87qMhVVjel1sRvA+l6IAzRioVBxIl+2/Al0o/
         ies0wyWiIYXAvRjZbD6SygS6DtXtTvW/i92x2RCbQliOEH67exqNasHFR9f8Ag0xPcQ6
         XmEoBNvtNt+ZNDNjGFs7YRTPb4lM79+MpTFWhrP2CE4n17bHEMlqnBQgxOnMTFQd3qn6
         cM5+R60YoHyPsUTaZyPqn8wTsCyNlVo45xD/68Orvm7ippbZUk493tpSSetnYl90MRQO
         pk4vev0Kak9pXNFsflJCAjCmsqfsQ/q/aZ8J+3Wf42notqYsSEF93xELkx2C6n0acxut
         W+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508422; x=1691113222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsvPJY+VBTqE0LdgXqK5KYxEPsSBisJ2WKCxekzzaKs=;
        b=BcTTpFbIZEzy7EqwRg77V4sFibmyU6nzI1pKsJn8B5KHOZdN97qx/5ite4g0aNb+8F
         RUnT/+deztnAiehrGxYBM+zgRwmVJ79s2lyMs/3EtTiYaX6lLm2c7OJoRun/UWL7hjfn
         m4dVqNPUXy5Vxnw/BaUdBArB7aaEH+SDSGJ7Q8waVP3hNqE5/2pHRAbc+8xchxkFS0xa
         /uUitOP7k0z2idK4wWzKDVlUg9RIJ+Tu6MC07Asn6jXt6jCz0KOJWVwa1rPdQvATLn3w
         oKvjhSQgdsjE3RHw5SPvAr/o3hV4rL2KR0+ChA9hnVlxlFA5IWYUL0ybw8v2bLXGItOF
         qaNw==
X-Gm-Message-State: ABy/qLZetPq6r0vyMbpuJsP2cM1CNKufLLhTOap352fkYDxdO3/sts/Q
	cLrOD5U5IsZCKMALwhd9mJwNy/HF5fh1iNxtrQs=
X-Google-Smtp-Source: APBJJlEYD4UQvSjU89/TGVCa9wtPSpfmOs96j9XdHmge3XghaWHlBFIUTdAMIoVQiZq6JZTD7lNsbVslNM5pBleJEIA=
X-Received: by 2002:a05:6512:2391:b0:4f8:651f:9bbe with SMTP id
 c17-20020a056512239100b004f8651f9bbemr708813lfv.54.1690508421447; Thu, 27 Jul
 2023 18:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <74a7f82d516836ba53edae509b561f50b441dd63.1690439335.git.chenfeiyang@loongson.cn>
 <677d06af-eb83-4e11-9519-8f3606b97854@lunn.ch>
In-Reply-To: <677d06af-eb83-4e11-9519-8f3606b97854@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 28 Jul 2023 09:40:09 +0800
Message-ID: <CACWXhKmgO8YAaremh-cYnv3S0yrVBCBjay3=PEHd5uK_zODHpg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] net: stmmac: dwmac1000: Add 64-bit DMA support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, chenhuacai@loongson.cn, 
	linux@armlinux.org.uk, dongbiao@loongson.cn, 
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 5:06=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jul 27, 2023 at 03:15:47PM +0800, Feiyang Chen wrote:
> > Some platforms have dwmac1000 implementations that support 64-bit
> > DMA. Extend the functions to add 64-bit DMA support.
>
> I wounder if it would be cleaner to implement a new struct
> stmmac_dma_ops for 64 bit DMA support?
>

Hi, Andrew,

Yes. I will implement a new struct stmmac_dma_ops in the next version.

Thanks,
Feiyang

>         Andrew

