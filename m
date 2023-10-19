Return-Path: <netdev+bounces-42465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038267CECDB
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 02:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C55281CCF
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 00:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D57E38D;
	Thu, 19 Oct 2023 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evvpExrP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE938C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 00:39:27 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BD4FE;
	Wed, 18 Oct 2023 17:39:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083f61312eso9048605e9.3;
        Wed, 18 Oct 2023 17:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697675965; x=1698280765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEUeI7TkzWzqhkzUnSidN8EfbC071WzYkxQl0FkcC+E=;
        b=evvpExrPzIcw2aZPw7rul3bKCvqgt2l9frhohlZjkMaZIQ3lREjSdrycBoJsUEG8zd
         QE0n9ngEscHIT/Y/KOr6oSAJrf2Frg7mg3qEC2QYDOjtHzK97Hnb+LMumbVGxL2vdvVl
         FQfkLmnS5ONJajCtni0NS3rKFfUTkL8T7epjS67X2aZfUCh/MVEa/6YoqTQ7vlH78nog
         rIepsctzwi+/8MUfF7Lz0w1iFTpqu7RH6Hi2xfWBRMRLK1t9/KHXTPwwvlTO8rmAUSfs
         q5qscRnJH/yxIx/ZqRht/8CwIdY8BKAWyRPo8XQKoYTbuBRcwcPQ6wiDx8s3FFEtc65H
         4+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697675965; x=1698280765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEUeI7TkzWzqhkzUnSidN8EfbC071WzYkxQl0FkcC+E=;
        b=U6ijm+8lSXPySCGIOhO8YrG+x3thViIb8Viy3wa3JrT62f+f2MdSphOUnOJpdVLs+3
         jvazD+fubvb7EhRyk3REk9c9yQPgS5kIEBGS+uTu+9m7vGI6MiLt9+4PU9CMU+RDeXUB
         M0ekTWM6hdWZsRELJOcFssOTgJODMclGfWIyEl30U/uTGltqo6igTvW7Hk5Bye+Gflet
         RU3ju6pb/+eZegq1x2hwUTzb23C6qSNPUjC6IF6X6qp6LpAn3KgqhQYQzmcPFTfxpMy3
         3Q/N5V+xwculhFsbLHevp3GeALB48CKkxDcj4cfRiy/xS1OW/WlzZbTmtzujBkD85Mar
         cGxw==
X-Gm-Message-State: AOJu0Yx59SS9A9ZxYlsvK7gBI4VgUIoDVrISxAWfuCrNe/g86F133so4
	nKXRoJrnd2n4grRTGFrnx+I=
X-Google-Smtp-Source: AGHT+IGDeesw3VWl9zLEaZDEVphHnZLOPk0plbscyyVstodE7Jnw+ixNcfD3lFVAUBngSITgmTE5oA==
X-Received: by 2002:a05:600c:4693:b0:406:53e4:4d23 with SMTP id p19-20020a05600c469300b0040653e44d23mr588493wmo.23.1697675964405;
        Wed, 18 Oct 2023 17:39:24 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c481200b00407b93d8085sm2939485wmo.27.2023.10.18.17.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:39:24 -0700 (PDT)
Date: Thu, 19 Oct 2023 03:39:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v6 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231019003921.vgdc5wg2eoaq6t2n@skbuf>
References: <20231018175820.455893-1-florian.fainelli@broadcom.com>
 <20231018175820.455893-1-florian.fainelli@broadcom.com>
 <20231018175820.455893-2-florian.fainelli@broadcom.com>
 <20231018175820.455893-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018175820.455893-2-florian.fainelli@broadcom.com>
 <20231018175820.455893-2-florian.fainelli@broadcom.com>

On Wed, Oct 18, 2023 at 10:58:19AM -0700, Florian Fainelli wrote:
> Use more inclusive terms throughout the DSA subsystem by moving away
> from "master" which is replaced by "conduit" and "slave" which is
> replaced by "user". No functional changes.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

