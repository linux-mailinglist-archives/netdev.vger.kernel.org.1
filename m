Return-Path: <netdev+bounces-25426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDECB773F05
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A719C2814CE
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F99E168CF;
	Tue,  8 Aug 2023 16:38:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150651CA02
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:38:26 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2724947F5
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:38:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so43406a12.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512692; x=1692117492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tR6XCxEiv7m8LkCHulofmUdb9pjDB/8nQo2qfzA1rc=;
        b=ZXEaeLRpcCaz9QtMEkqMqAcaBSM8AfIbYRl5K1N3l6QDpJi8NqRdWNK7bIFLK5vtkP
         Ig7Ayw9JRhLhz165hsPHz4c7s5N491KXwDo7hjwOmNCQNWQXeRBStALjzXoeWu55i4bL
         34BU/HHzPVfpP+Ml+q3jKRWVRh6xBhRLcAoEBUvcRuUaCT3oz8jdMKRjDLc2kYTXbZck
         uLVUxr/AeojTpuf9/Q7JRe4qkdYO3aIJqW17P5g87h9+ax518ll9W04lCTpb9Z3R+flJ
         1he/A9JL5Y9552fSHRsjBhD5VYR7B8aZT1/lSDOi0Pl1PjaFnEoBQkX+MFidrR/IwyPg
         DHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512692; x=1692117492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tR6XCxEiv7m8LkCHulofmUdb9pjDB/8nQo2qfzA1rc=;
        b=QIbH+1zUcgoCx+8cOyxMtWX771tfpLNVNqsMy6oLWu6T9hIB9mvz/AeyJ8FnHn7GFx
         AItsopHfif1LN8J0zLkmMu/9ckmeHtUu8crLYwRIY3WEi/TmKHOoVfvRjEd0BbpMYcnX
         3fABMeHB6UWp2jgrrGkDHe9XKfgm2zrkK2fK6yA0o5AoQ/zzRoqdcBNPUb9677H9DPzz
         xZ/SZz4mjtu+N3CuSj/zUobaBcaS5cy9pXEomomSGkO7GTSAEFEIkpYaKtbQFgKgIrNa
         gMXJTM2Ik+7bQm9Zx+groy3upG4b9WOZokJFeQtlE/5Qu7M+h0LSs5vRLsX1jzcA+KJp
         H8ZA==
X-Gm-Message-State: AOJu0YxbBzPoqpXH+TO037zagp+QJ9pGAGQdvv/Y8bqP3yo0x6gebLi6
	gMo+UVU9ClZgeKL4oiYBXIxD2eW/uMjB/b3f
X-Google-Smtp-Source: AGHT+IGTMpPw942l8ampBnP6+chwSFaJcXZWo0EhKISWCfPicDdwWO4LKrQx/tQTP1AZJRhFv/9/Ig==
X-Received: by 2002:a17:906:7494:b0:988:71c8:9f3a with SMTP id e20-20020a170906749400b0098871c89f3amr11040706ejl.16.1691496415409;
        Tue, 08 Aug 2023 05:06:55 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709066b8700b0099c53c4407dsm6617259ejr.78.2023.08.08.05.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:06:54 -0700 (PDT)
Date: Tue, 8 Aug 2023 15:06:52 +0300
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
Message-ID: <20230808120652.fehnyzporzychfct@skbuf>
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

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

How did you notice this? Is there any unconverted DSA switch which has a
phy-mode which isn't PHY_INTERFACE_MODE_INTERNAL or PHY_INTERFACE_MODE_NA?

