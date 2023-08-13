Return-Path: <netdev+bounces-27102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5045277A60D
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 12:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471971C2090D
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F43D74;
	Sun, 13 Aug 2023 10:59:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41841FCC
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 10:59:24 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0871D170D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 03:59:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bed101b70so468552766b.3
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 03:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691924361; x=1692529161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUkOCDgMbe4HtJ5KVuy5PNulyqCVnGGCHOXRR9jkCWM=;
        b=igjj2VMiBHOaufZOmvU/9DJpXdDKTDc5zubObRdPvWyiMg5gsOveMK/aBme/zk0Gtj
         uE7iS26vKu+ztyT8W6DvVjoGWRCSouSk2gw89Ehzu7H0Zk6cAC7IlmNSgNk9BBu+DzM6
         a9H2F4KvuCxIEpg+xrsZ40xdyvNZGHIwVwl7OstKYGfHespB+uKJVubfv775OR2bvhu5
         ia0RB4Pw+ROH7Tm8ACoxEhBTdaBgnjzfe3Z6cPjS+8O51Qx1fm+AIpwzhYtwKvP3VL2M
         s8ZaikV0zb+lez8R2fWga7pZCXdSG0DFAbzGhCTq98Ac7wDemjabv42/Jvz31aFMNNX2
         Nlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691924361; x=1692529161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUkOCDgMbe4HtJ5KVuy5PNulyqCVnGGCHOXRR9jkCWM=;
        b=NfPNGvgmjnPkjWsdKvlzUcOq/z9QyzzUFyWTu6OYm/hu1pESXAPOsLxXEV8yMgpG8z
         1sgXRo0raMzcE2VTh2Y1B3J6N5k59Gao8ecsVFb3vr6ubAW8aABRka0f/GHNZRpt8E+S
         D7y9Q8JX/7vXF9uKtDg3M6nUFPqwyhA0b+ncQlHvNjc6cpFThiQdcjCu7SMU++dfmruD
         bGrJbA87znv6jegCaXub/5xOm2VdbceKo7Zd7buApCIZI1AxsHseOFvrMz84i97giL0M
         8tBQnAKQLadKEsKBC7ueOSrtuvHHMbwfJlbqcl4m4HsLVi7YFAf45dkffUQg500k5O7M
         OfAA==
X-Gm-Message-State: AOJu0YyVIUGbP1FgYNzzWnhOR9CC5j/0V0ZpxRebW3+Pdk2zM0axN4Nz
	usf/oZlBh0nFZEaIgGq+Lj0=
X-Google-Smtp-Source: AGHT+IGeccqf10JBT4frZ8qVV6ymSM2uS7RXCVzBDv9HcxqawycBH/cHFnuO55SKxMXoVxlAPEzyVw==
X-Received: by 2002:a17:906:5a4b:b0:99c:8906:4b25 with SMTP id my11-20020a1709065a4b00b0099c89064b25mr5716071ejc.74.1691924361333;
        Sun, 13 Aug 2023 03:59:21 -0700 (PDT)
Received: from skbuf ([188.27.184.148])
        by smtp.gmail.com with ESMTPSA id jx20-20020a170906ca5400b0099d804da2e9sm2866393ejb.225.2023.08.13.03.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 03:59:21 -0700 (PDT)
Date: Sun, 13 Aug 2023 13:59:18 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Sergei Antonov <saproj@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6060: add phylink_get_caps
 implementation
Message-ID: <20230813105918.fmfcoiaqlqecivep@skbuf>
References: <E1qUkx7-003dMX-9b@rmk-PC.armlinux.org.uk>
 <E1qUkx7-003dMX-9b@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qUkx7-003dMX-9b@rmk-PC.armlinux.org.uk>
 <E1qUkx7-003dMX-9b@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 10:30:33AM +0100, Russell King (Oracle) wrote:
> Add a phylink_get_caps implementation for Marvell 88e6060 DSA switch.
> This is a fast ethernet switch, with internal PHYs for ports 0 through
> 4. Port 4 also supports MII, REVMII, REVRMII and SNI. Port 5 supports
> MII, REVMII, REVRMII and SNI without an internal PHY.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

