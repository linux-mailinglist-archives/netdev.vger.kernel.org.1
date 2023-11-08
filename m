Return-Path: <netdev+bounces-46644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB2A7E58BF
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8734128118B
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5D1A5B0;
	Wed,  8 Nov 2023 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJoPBWH6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E21A589
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 14:26:46 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAEE1FDF;
	Wed,  8 Nov 2023 06:26:45 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d10972e63eso1043321866b.2;
        Wed, 08 Nov 2023 06:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699453604; x=1700058404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVBE77VBxR9IpyvzgJwRw9S64V6IXgaNTy2Pl9D2aH4=;
        b=UJoPBWH6+W2CAHH5y8m1Icgpb6XSkEa4ul0VKgPScbxUyjhNm6ppRHZwR1v8/XmSo4
         1K474XafrnJZ1J3/WFx3Ol29uUP23hJyGXPDpkdZrLNaCfTEiAx1YW/AWsr8TjENJ8Ru
         Lnosn4RZstdI1N/1KZhNxfyakIVpgfgSONSXYVwdi7heu0oMRQP7niPxPsc7VbXEfIbD
         Eb8C3MlkE1I1xkvYyLKfCtJX6ugSbY4Yza4m7QQil68m+hJnxHkjmV4tsJuNMwEr1lf2
         sZhuEnOUIOOndcKS/lUjrLJ9liVKoXMDh87okgbqzEklZ/G+jCoBa0YoGs3xAOOZgbOV
         y4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699453604; x=1700058404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVBE77VBxR9IpyvzgJwRw9S64V6IXgaNTy2Pl9D2aH4=;
        b=lCA/CkcbMtX8bY0YWRaUzngtaDTLTQrSHURqImNvprQprT0ukJIRLV3EpFukhAiJok
         axIobgKnA+3qgSgwhrmedOgqjS3khQXB7k/OUYr86xBoUKn9qbxlKzsV/yo57sEh8Oyl
         SCidC5R17vUsbHQ7lgtUchb1Iuq1e8++pnasyuVHonXbpjuCQk9eB8P1YJo9Kp/a69CT
         PdtYEPlnu1aZQnRtyVI0goZTK7gbpBoY+Y4tpxZVR3a489zgbJRxCiSL5Vd8cQ9uTIjB
         i5YUT5fzSyaSHr9LK8bR4JsA8yD4gcE6ub50xybFSDk9I/6N7MrDTWaaShP1G/fvoYZI
         UmBQ==
X-Gm-Message-State: AOJu0Yz/kHZNbqmW4naRg0CpHCnwtwzxL4+WI3L9egtdEeo+vULaawh7
	aCQMQl2TmWKNXsclDsWOS0Q=
X-Google-Smtp-Source: AGHT+IGeu2yOuVGSxMaBwyf6wUUUWNLB7feoE7z9tAd1EQvhOpC3cE3veLdFXFYH4H49MAE6ulIGJA==
X-Received: by 2002:a17:907:6d13:b0:9bf:65b0:1122 with SMTP id sa19-20020a1709076d1300b009bf65b01122mr1702011ejc.69.1699453603434;
        Wed, 08 Nov 2023 06:26:43 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id q24-20020a1709066b1800b009b2ca104988sm1136317ejr.98.2023.11.08.06.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:26:43 -0800 (PST)
Date: Wed, 8 Nov 2023 16:26:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/4] net: ethernet: cortina: Fix MTU max setting
Message-ID: <20231108142640.tmly4ifgsoeo7m3e@skbuf>
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
 <20231107-gemini-largeframe-fix-v3-1-e3803c080b75@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-gemini-largeframe-fix-v3-1-e3803c080b75@linaro.org>

On Tue, Nov 07, 2023 at 10:54:26AM +0100, Linus Walleij wrote:
> The RX max frame size is over 10000 for the Gemini ethernet,
> but the TX max frame size is actually just 2047 (0x7ff after
> checking the datasheet). Reflect this in what we offer to Linux,
> cap the MTU at the TX max frame minus ethernet headers.
> 
> Use the BIT() macro for related bit flags so these TX settings
> are consistent.

What does this second paragraph intend to say? The patch doesn't use the
BIT() macro.

