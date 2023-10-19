Return-Path: <netdev+bounces-42722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F857CFF68
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F941C20BB9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83C32C63;
	Thu, 19 Oct 2023 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PErpdba+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A39321B5;
	Thu, 19 Oct 2023 16:22:39 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94150115;
	Thu, 19 Oct 2023 09:22:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso12899000a12.3;
        Thu, 19 Oct 2023 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697732556; x=1698337356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n5rOzh4NsVaOOSxKWGZFpGCW4lugWu7iKjVHUZWaVZk=;
        b=PErpdba+A12zyy1OOCJPqHb2lgbvpF9ceOuqrAl8eJfcj5yZLD+lF1zEM5SuoWpNJh
         mQVWGwMOkrRyAIGieEH5pdxc/X3mFJEOUB47a/o9v9otsvOHkhJREvcsRPirAMFXk0aS
         X8Z1VTOufxpJCs387ncRcYOWUVPHF1V1dBBTuqZLJ+rN6vV8k9ewe7EmBe1IevcVIZlE
         fQDT/+4eMdDZCnb+9ZvOIdoPhvtPoNVaXxiWwg1KEjpfuFyWYiAjiVGRTkxTV/NhgmC9
         iMgPNDJ9uKbMGW12HG/vpyr5ZGVtGyNSWharbqPSMLcMCCc7IMuDxYLjLcVI1wVK9tJU
         R9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732556; x=1698337356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5rOzh4NsVaOOSxKWGZFpGCW4lugWu7iKjVHUZWaVZk=;
        b=k9oOa3h1aOd8Ll67FqeZsTEwyZufZM++MIdYWLLGFqZ90/QHLxjDW8+Cj3o946GJ4L
         H8EcJ7Ou0pJmNFi7aXoCCenejy7Elj5ynB2zE1BquUbkDgCy1QQYYoXjOKwZ6lN81klg
         ijmTURTbbWe4qUxCeEjscmP5DsRdG8DHl5TpVrfZ1i4a4u2MEmrEzLzVnWojUT2pPi3B
         iEAp1rWGy1njHZ4hyEPPgXZKxP1bETjKgakjgZ9i3HPvc3RsATzaJr7LMo5kFRnXcd/U
         cU9OeRbt/dMpt+J6CnrcG9SJoMzGWrL4Ym43Qjau5jqSc/0g+CN/sY5sqmaAWWTlBGX0
         wBxw==
X-Gm-Message-State: AOJu0Yyw3egDPzM4Sxt3+jyaikvCDu+TbgRTWI0RtPZj11TZlFRGaps9
	FcmEffZ2pYz7wxzAXvsASkw=
X-Google-Smtp-Source: AGHT+IF6bsxSat5ywHjsBB78bIVfof4867geBLkvQA/W6QWXnRiK3ADP7C0r5cvn4SEdlnv0JBowyg==
X-Received: by 2002:a17:907:a46:b0:9ae:522e:8f78 with SMTP id be6-20020a1709070a4600b009ae522e8f78mr1796117ejc.74.1697732555873;
        Thu, 19 Oct 2023 09:22:35 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090627c800b009ade1a4f795sm3773323ejc.168.2023.10.19.09.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:22:35 -0700 (PDT)
Date: Thu, 19 Oct 2023 19:22:32 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231019162232.5iykxtlcezekc2uz@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-5-3ee0c67383be@linaro.org>
 <20231019144021.ksymhjpvawv42vhj@skbuf>
 <20231019144935.3wrnqyipiq3vkxb7@skbuf>
 <20231019172649.784a60d4@dellmb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019172649.784a60d4@dellmb>

On Thu, Oct 19, 2023 at 05:26:49PM +0200, Marek Behún wrote:
> Yes, unfortunately changing that node name will break booting.
> 
> Maybe we could add a comment into the DTS to describe this unfortunate
> state of things? :)

Well, the fact that Linus didn't notice means that there are insufficient
signals currently, so I guess a more explicit comment would help. Could
you prepare a patch?

