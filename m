Return-Path: <netdev+bounces-25437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE90773F52
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE431C20384
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69DD1B7F0;
	Tue,  8 Aug 2023 16:44:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9936C1B7C9
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:44:22 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B05442060
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:44:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3110ab7110aso5129969f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691513051; x=1692117851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbWGmIHbj8Fahq1igHKB9hf2nQdiiJkK4lnhXY0Uufc=;
        b=DE3CYGJKRXmN7yTFHm2qnOfXL6QZT8V30BBQ8L/gCD/ZaTGdIwl8GpFFg59cxpXwnQ
         ey2boI8MjZVP2cGN6u63uzU1fpwVltzOaeSpLepCDZZwxHMBMB8lUegvnJof3xj8yPDg
         EqVf2XDVkG6cgey2NVN3uwUPQXGgKMk0LtFuavpiNeE5ulQgmLMxDdbChoB1wHG1JCOF
         D/TAnhyX5oULvLCbT8hSoCZnDgoyJdJAIm8U1zR4E+Ndm0vKC8j8w/TvMPCFdeadDiRw
         QbSxRfj2YpeSlSQWLa/pu4gLJBlsifVpPP5jRMrATFcYtdTlV5R9JmrcYJtfHg+Xt3va
         qaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513051; x=1692117851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbWGmIHbj8Fahq1igHKB9hf2nQdiiJkK4lnhXY0Uufc=;
        b=YBQClxqCfLugt8PbjgYy7N6UyA8UzJSRlSFUM/QIXXGA7fwdFrnM9UHNkjO4cDX/eI
         Qe+8UemYGSlV/OcTw1zq1KtS8FwCW2jzUh3wKep8zYPxX0s35gWqwa8n7cYF/BctvhZd
         FNKldx4D9Fxku1Rw2pAP2i33VXOaCOmixxIB1nNUV7pukLpMs4Hu6ll/fvLaYGZTX4KT
         VhLtZVgZZXNv6rCP1vcsLs3KAXm2gQ6Pf1zWE85DxZDI7mnD6JJttc8etvRAoa9cs/ve
         SyiB38twP7CMtKJvve1IM0YDI3lVbeDmeo2y9r8lDlVCb2YTWIRTvvSVp9EqWDZr38pg
         C/Xg==
X-Gm-Message-State: AOJu0YxRvsZshJKgABlc+2GXcQvCavJMj+4CCLPYIOunbHqekBlmCdXi
	HJiZCPJ48CENefnSHvTFzbfDN1EIezgq6Xj6
X-Google-Smtp-Source: AGHT+IHt8P0qiDF+KkrRPWP10n+tFND514RO60QgfBTLHMrCBCg1mRqOPj4VjOd7yYkYojJ/21g1WA==
X-Received: by 2002:a17:906:8a49:b0:977:befe:d888 with SMTP id gx9-20020a1709068a4900b00977befed888mr8980238ejc.13.1691498400874;
        Tue, 08 Aug 2023 05:40:00 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id c18-20020a170906529200b0099c53c44083sm6637174ejm.79.2023.08.08.05.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:40:00 -0700 (PDT)
Date: Tue, 8 Aug 2023 15:39:58 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230808123958.vopmldxrxlri7iec@skbuf>
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 12:12:16PM +0100, Russell King (Oracle) wrote:
> If we successfully parsed an interface mode with a legacy switch
> driver, populate that mode into phylink's supported interfaces rather
> than defaulting to the internal and gmii interfaces.
> 
> This hasn't caused an issue so far, because when the interface doesn't
> match a supported one, phylink_validate() doesn't clear the supported
> mask, but instead returns -EINVAL. phylink_parse_fixedlink() doesn't
> check this return value, and merely relies on the supported ethtool
> link modes mask being cleared. Therefore, the fixed link settings end
> up being allowed despite validation failing.
> 
> Before this causes a problem, arrange for DSA to more accurately
> populate phylink's supported interfaces mask so validation can
> correctly succeed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

