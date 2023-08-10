Return-Path: <netdev+bounces-26536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA6A778044
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B5F281FD8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDB41F942;
	Thu, 10 Aug 2023 18:31:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E622EFE
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:31:26 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080CF2690
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:31:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99d6d5054bcso157219066b.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691692281; x=1692297081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8UR18nY4nhdVLAO78UBFPT4Nd7k6ZghzGQNJqLilPQ=;
        b=ZOZWRsa5o+C3FLD3uv/886ZBYnERCWusdA9i6hUpQ0IyERTYL0fnJpt2f08gLfCSHP
         QICEr2iEfI79d62uARkF+oL3o5DPlPnKYwh1lNv0vCtML09Z1OCjfnVr5FgDTgRvF9EZ
         xCGsMc3KiWmcp+dLXmNA3MJfQFiPL85WMUtzFSDFpFTUvMshpXf3PWdwCfVXSg2X/sAc
         SyK+wAyL8YBTUvyOPmLxnS5ZBzrIrrHhlR6yjuJLzn+8O3IJfj5tlrgQ3wMjUZ3fEFt7
         C6sdLARH9yifys7+3xBYo5OYzdd4xqhMetKH6Us8/Yc/bC81SL8e8GobEezBwzAWn5Dc
         xKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692281; x=1692297081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8UR18nY4nhdVLAO78UBFPT4Nd7k6ZghzGQNJqLilPQ=;
        b=mGDSedR6YJSaWAJ2dSHFbmuVHkjwG5gKTXVeH+GS3Y82Uw8hvphUyvrjbsvLqN7tyq
         07DSuMBzPqPTZJPJtsOSKE9Pym6s1PSnMc5+B+mOnEx8jMB1Ep5+gCH+KXrdM2WG+YWR
         rb74McwSP3EeWopSAwbh8hRtcfqPW2WtjjvVl8X2RFk5f6UZeic1weaetYQPwWF00Isz
         YJelnLFmqhPbtBJaZ+j3Rz38HOGLB74WQ+CfeNsR4onP8md+nmcP2R+iNEJkumf0Vhfm
         sNiktfjpV3sFPUFejD5oAnGiA8Q7PjdcyvR8q23sCeLfRGv0Gex0KYMaTBE37YqPuYDg
         yZHQ==
X-Gm-Message-State: AOJu0YwDcE2BA6amYjT5Pcia18yS0NoB9NSL6ZqUXwQCtGGXFJsajQUt
	FuzIbSDyXRnnR49motxRAYppaQrQBMSvdw==
X-Google-Smtp-Source: AGHT+IFW/A5ziUMXRpXBExIZyJgTc9rbQgdnmLOVlq6YXShx9r2xvdtqm8mC7WYmKNvRNlGbWo1bOQ==
X-Received: by 2002:a17:907:7f8b:b0:99c:c794:8ce0 with SMTP id qk11-20020a1709077f8b00b0099cc7948ce0mr4314829ejc.4.1691692281159;
        Thu, 10 Aug 2023 11:31:21 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090668d600b0099bcdfff7cbsm1253449ejr.160.2023.08.10.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:31:20 -0700 (PDT)
Date: Thu, 10 Aug 2023 21:31:18 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Sergei Antonov <saproj@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6060: add phylink_get_caps
 implementation
Message-ID: <20230810183118.3z77lrnun5pukgfa@skbuf>
References: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <20230810164441.udjyn7avp3afcwgo@skbuf>
 <ZNUV2VzY01TWVSgk@shell.armlinux.org.uk>
 <20230810171100.dvnsjgjo67hax4ld@skbuf>
 <ZNUglYF2Xy63l4aZ@shell.armlinux.org.uk>
 <CABikg9zcNED55rjnq9a9ZTjp8pCKXWs9HBy5r2KAdECP1Dm8vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABikg9zcNED55rjnq9a9ZTjp8pCKXWs9HBy5r2KAdECP1Dm8vg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 09:17:33PM +0300, Sergei Antonov wrote:
> I am planning to submit a platform using "marvell,mv88e6060". For the
> next release cycle hopefully.
> Our should I rather try to move MV88E6060 support to /mv88e6xxx?

Device tree bindings and the driver implementation should be seen as
separate things. You can submit a platform for mv88e6060 regardless of
what driver it's using, and if the driver is merged into mv88e6xxx, that
needs to support the existing platforms as well.

