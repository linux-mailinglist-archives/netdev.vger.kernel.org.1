Return-Path: <netdev+bounces-41257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB07A7CA617
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 12:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BE92815A6
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38371208CA;
	Mon, 16 Oct 2023 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtP+LPaT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAE1CA85;
	Mon, 16 Oct 2023 10:55:26 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD6AC;
	Mon, 16 Oct 2023 03:55:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so7584932a12.1;
        Mon, 16 Oct 2023 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697453724; x=1698058524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2IhcbshZ7IEXHsad/cfhuQEVHGHbmw/BOyh8FLp7ef0=;
        b=ZtP+LPaTD7valvTgxq/3Kx4gxQ0eCP3KCSsnQ9wfCOWHH36r4q7OcZ4mFLrqHrnb8X
         FN8vhYsq9zK+hbGzcLLJiaOq1ji0LC9t7eF6yJFr7ESx0GstN+8urYiDWRDBzLupSifE
         EE1rrwFq6AguucSOsFBLp9asGJJ+8swrBLQgBFfYRWYImoxxVUfWk32y98YPBew2GyJI
         UMTqTaYF3Hi7JwJnOG7bPAAzn+Tb7SuObfVg+Isl+UJzQnrmPIRuUkgFnd/DolzbNFGU
         IfWGVqt4rHnE1IWf47GyzBA8H9KM4WKyXCGpQTwDhVzYRnhiXcy3wAAOh/ReXkKWRedP
         7FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697453724; x=1698058524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IhcbshZ7IEXHsad/cfhuQEVHGHbmw/BOyh8FLp7ef0=;
        b=CCwOrNUhGysP22MFr/EMiuLFSDN4my++Rv/Qqhzy9Z9+CBN6EJtggpp4cfPwfoOXmi
         wh16Ok+t/kYo3tLl82RO+aOjYCRQuQi5kzEVKrnzntba4QQ4mAhQhw8ZfijKKnOn/A3O
         hEv3UVxMD+Q4eiSCtv4M/3cJGRkdDekHLTRCZQuQEi+yyDxmy7F87YNmc4o2Cg2/Ucjq
         MhDmK7BMQA9pdii5WZXyGeFMS2YOqJgS9nimLcYluNFPPT+MVOaPZSLdeY3ZhLLozLSn
         yKobZTMCIEttVMfq0t74EVFsqeSYWdf+KQKr5VsVCP2ShqpcxIUxJ4e/+92fqjmENwXY
         RVrQ==
X-Gm-Message-State: AOJu0YwUB/foGtbxkKgpzlznvqRdu1rDLDhfq938sAOYxvxqyc87IIVq
	o1KlNUD7/YqFKDMLZbr46rg=
X-Google-Smtp-Source: AGHT+IFJVMWLKXQIx770G0CQpF48Srsw0pMJC9hAdXdlZnJLZWktbRLgJH/ugs4I0s0NplvkczZxWA==
X-Received: by 2002:a17:906:3e52:b0:9b2:aa2f:ab69 with SMTP id t18-20020a1709063e5200b009b2aa2fab69mr31720583eji.30.1697453723848;
        Mon, 16 Oct 2023 03:55:23 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id g7-20020a170906594700b009a9fbeb15f2sm3791434ejr.62.2023.10.16.03.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:55:23 -0700 (PDT)
Date: Mon, 16 Oct 2023 13:55:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	marex@denx.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: dsa: microchip: enable setting rmii
Message-ID: <20231016105521.xsjcz5phcpdds2s6@skbuf>
References: <cover.1697107915.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697107915.git.ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 12:55:54PM +0200, Ante Knezic wrote:
> KSZ88X3 devices can select between internal and external RMII reference clock.
> This patch series introduces new device tree property for setting reference
> clock to internal.
> 
> Ante Knezic (2):
>   net:dsa:microchip: add property to select internal RMII reference
>     clock
>   dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal

The dt-bindings patch should be placed before the kernel patch.

