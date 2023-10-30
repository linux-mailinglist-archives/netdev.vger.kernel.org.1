Return-Path: <netdev+bounces-45289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687997DBF37
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E4D2825CE
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B92199C4;
	Mon, 30 Oct 2023 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A037199B4;
	Mon, 30 Oct 2023 17:40:47 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384AFF7;
	Mon, 30 Oct 2023 10:40:46 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b3e13fc1f7so3123496b6e.0;
        Mon, 30 Oct 2023 10:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687645; x=1699292445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ5oAod886BZiRllPnNSf+OACyPikK6Ytfva5XZfKj0=;
        b=LqEVjLbVoRn6eaG9pv7IFusre964nDVaaBMCKGt/+Ws1gWYuWFYEuklopcy9WzOxq1
         kJjJn7kxtWV7cgcM82mFuGzD192qx8nW5Tp1xfkmhuHcWbDpBSTUPkyjagjKzvJxMfa8
         6BtaurEZNqtxgV+M/DV2TL3RnFQiWk8M9W2K6Ii7oBW792rmcRGYhvG0EY3OX0sBpQ6Y
         EWlZ44z/rPjsaZiJFrAAfmCYJ3hbYNATlgeG60mPbRuSXcw81GwIt4YXP0ExZyFwoxZ+
         wM5XSAEdjI9D8X/n8VzdM6kTi6/srvIK/R0JnVoldY4aRnAddaxYDlDokcLRY4YEedQQ
         l2ZA==
X-Gm-Message-State: AOJu0YyLFMqL5jOOCt7FgzRHcBHofzBezROesaubPCcOVBlxGGWFcMNo
	kSAPGgYgW4xyyxh2Lr5Iog==
X-Google-Smtp-Source: AGHT+IHgFAqSFrl3MX7sqxVH+YqGhWTgFanvGblSaSbgMxnNtStRdjCy4NakKnUWFT9AGZlvDWyxvA==
X-Received: by 2002:a05:6808:1309:b0:3af:5fea:2f7b with SMTP id y9-20020a056808130900b003af5fea2f7bmr12931749oiv.47.1698687645438;
        Mon, 30 Oct 2023 10:40:45 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c7:c3eb:a6fd:69b4:aba3:6929])
        by smtp.gmail.com with ESMTPSA id p5-20020a9d4545000000b006c7c1868b05sm1486763oti.50.2023.10.30.10.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:40:44 -0700 (PDT)
Received: (nullmailer pid 1560911 invoked by uid 1000);
	Mon, 30 Oct 2023 17:40:43 -0000
Date: Mon, 30 Oct 2023 12:40:43 -0500
From: Rob Herring <robh@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: krzk+dt@kernel.org, robh+dt@kernel.org, arinc.unal@arinc9.com, linus.walleij@linaro.org, pabeni@redhat.com, andrew@lunn.ch, vivien.didelot@gmail.com, davem@davemloft.net, f.fainelli@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org, alsi@bang-olufsen.dk, olteanv@gmail.com, kuba@kernel.org
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: dsa: realtek:
 reset-gpios is not required
Message-ID: <169868764284.1560852.3246926733405023134.robh@kernel.org>
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-2-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027190910.27044-2-luizluca@gmail.com>


On Fri, 27 Oct 2023 16:00:55 -0300, Luiz Angelo Daros de Luca wrote:
> The 'reset-gpios' should not be mandatory. although they might be
> required for some devices if the switch reset was left asserted by a
> previous driver, such as the bootloader.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/net/dsa/realtek.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


