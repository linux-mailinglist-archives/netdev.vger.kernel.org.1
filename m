Return-Path: <netdev+bounces-34994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7977A662A
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15D62821B6
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844638BC2;
	Tue, 19 Sep 2023 14:07:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5F374ED
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:07:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB6CF2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695132459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMykJCQlkdtke1jV1HRdImSUTkLSJsXVxgTZNCPIZuo=;
	b=hH2WnyJKPiaRQKvqiCxXqUhpc5T5pF7DvUJsNzPqp5NNMaEUU4q4Ioo4mGL0jKayuRKV0F
	2THqg8O6U/4r57S0TOmuNS0lgW2JLM4wXnXB95HHGgnnc2WQHdl2F8DuqW2ixFHsd1/knz
	fBdCqXttxHiVQIbShCsdHfCF16ZNL5A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-pbPE0PGWPZaa5DOVMJRaHQ-1; Tue, 19 Sep 2023 10:07:37 -0400
X-MC-Unique: pbPE0PGWPZaa5DOVMJRaHQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9aa1e8d983aso131294466b.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132456; x=1695737256;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LMykJCQlkdtke1jV1HRdImSUTkLSJsXVxgTZNCPIZuo=;
        b=LYG0rnEIcIoR8YOdoq3FpseDwYVx3IRdcmu6RogjEaGTcAuYRzgAm0P+Y6zrrM7nup
         OhMchOsrlmBi+PCT5lHlM1LIupLvNUVu0hfyeLyFPGmaamL1dpCDC+N7CYOdwxmi5Ng/
         Sj8D8ZOVM3Rkn5aAV0MdlM9WQxZPI2ZR0sFU7r2x3okqQ2veK3dqSktYphRZU+WuXFi7
         Ugf5QNfAkgHax1e9uGa0wBb/3mT8uWZt9PCmoxm3KQyUUL/jSPX5DyNYM9KTVsNmIVLJ
         sEsaZULl/Qt3TW/I87q/zlx/bGxmexcfGZXNWxZt0pKVAeMYL8I0ntT1PjktZmdsDeWZ
         +8/g==
X-Gm-Message-State: AOJu0YxR8kBlSs2qZV8ooLmJ0B2gL5fBwRQ4d4H0MMGRI2dnTfxSugFq
	Yj8CDT0n7RqbXJhNvgkl3erqOTmLAdFuDTDpC7kjpJ4HiR4mU37AOviDoWrZJ+TMsVJ8c0H8Bo5
	o8k779ANsZPXx/bko
X-Received: by 2002:a17:906:74ca:b0:9a1:eb67:c0d3 with SMTP id z10-20020a17090674ca00b009a1eb67c0d3mr10338008ejl.4.1695132456048;
        Tue, 19 Sep 2023 07:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENFS4cpAX8S6AwUFpq/x09AJbWBVQNwDPOx+C99DIJFQmc2UIwUgdKqqVnaAY0+5cwFRnW1g==
X-Received: by 2002:a17:906:74ca:b0:9a1:eb67:c0d3 with SMTP id z10-20020a17090674ca00b009a1eb67c0d3mr10337985ejl.4.1695132455690;
        Tue, 19 Sep 2023 07:07:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id fi8-20020a170906da0800b00997e00e78e6sm7851723ejb.112.2023.09.19.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:07:35 -0700 (PDT)
Message-ID: <6243f8f6b0e110ba48a9e6e974ea3de875857f49.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 09/17] net: ethernet: mtk_wed: fix
 EXT_INT_STATUS_RX_FBUF definitions for MT7986 SoC
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name, 
 john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-mediatek@lists.infradead.org, sujuan.chen@mediatek.com,
 horms@kernel.org,  robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 devicetree@vger.kernel.org
Date: Tue, 19 Sep 2023 16:07:33 +0200
In-Reply-To: <ZQg2AxAIxkadOiIr@makrotopia.org>
References: <cover.1695032290.git.lorenzo@kernel.org>
	 <ebde071cc3cc9c35b00366c41912ee2f25e5282d.1695032291.git.lorenzo@kernel.org>
	 <ZQg2AxAIxkadOiIr@makrotopia.org>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-18 at 12:35 +0100, Daniel Golle wrote:
> On Mon, Sep 18, 2023 at 12:29:11PM +0200, Lorenzo Bianconi wrote:
> > Fix MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH and
> > MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH definitions for MT7986 (MT7986 is
> > the only SoC to use them).
>=20
> Afaik this applies also to MT7981 which is very similar to MT7986.

FTR, I read the above as this series is going to additionally
support/work fine with MT7981; no modification asked here, fine to be
merged.

Please scream loudly soon otherwise ;)

Thanks,

Paolo


