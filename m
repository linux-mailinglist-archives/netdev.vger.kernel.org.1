Return-Path: <netdev+bounces-42468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3460C7CECE7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 02:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A2E1C20A63
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 00:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A09E38D;
	Thu, 19 Oct 2023 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS8GOY5S"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890238C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 00:42:57 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F76C11D;
	Wed, 18 Oct 2023 17:42:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso8928235e9.3;
        Wed, 18 Oct 2023 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697676172; x=1698280972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oEsE/+qks89QI4eb1Y3e4mK4O1PQPTOYfAd9vXSG79U=;
        b=OS8GOY5Sb+i/NZ62vayvgzkRgmOhzdhdOy32dV4bsPYeqRzqw5UHU0Q3+nO4rDMaF2
         nopASjIMZTRnoTF+3XLLR0CPeXpEgbHpOftEgpPihvIo6oXDeYnlVw0QF+P+hZkEV+TF
         j1b5Z69DN5hYwaiPNUPjGNwKxofHXHzzXLeKsko+/EU+cyp1tRuFJly0CYhTt4UbLS1H
         J607LOYy6PrXANpWqkd2rYnl7mUp5uScIqIY8HY3uotQAILOB4uYbT4NbuT7th2fMDCF
         alHClvvZTmhitMA8OjigiyYWD/tDOReEscSnw9Gj+mo42iZq2D8cpNf+hvEKifhhc0pF
         1QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697676172; x=1698280972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEsE/+qks89QI4eb1Y3e4mK4O1PQPTOYfAd9vXSG79U=;
        b=tX758ttfJAHNnuFbP/AwqrZ4urmMjSGuBbPvRlfjNiXT7eaxO8xb/AldGAL1fbFLPg
         DE7UedzuPmDkeBRseIqEIUmJHNR3RFLj11clQRrTUD06HEBMZ/oyg6wfquhHEmzDbk7W
         Xta7vU/1/3x4XWxC46gSk+PnpNneNcCKdVynenTiOYF9BQUfNYXwhA4U3Ksc3DlSW2qO
         E5CtB+1bRwMF7Ff//3JuePaz+BYo7schTEy1/g9Oghldgt4sjzBLCLlVpWJ8yFq5Naps
         1avpGfE6geiP3f41KKTaW5iRh8/W8lMdiVIjWex9IRUfj8GkOXefmCZRKSjCQo6sEF6V
         x/bA==
X-Gm-Message-State: AOJu0Yypb7y0yWQEri6cfwRcUd1qRrARGwAKzK5tpFnb3S2bjblk95Tw
	Gwe22wwupRwOhy1rbJPZ718=
X-Google-Smtp-Source: AGHT+IF4BhRxQY0I79+pOR23Kn9puugy8LkI+A2ymuJCK9OGr71dSyxlcqy0ilVsg4LAZ1g/arAemA==
X-Received: by 2002:a05:600c:a44:b0:401:bf87:9898 with SMTP id c4-20020a05600c0a4400b00401bf879898mr666226wmq.25.1697676172221;
        Wed, 18 Oct 2023 17:42:52 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id n13-20020adffe0d000000b0031ad2f9269dsm3186662wrr.40.2023.10.18.17.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:42:52 -0700 (PDT)
Date: Thu, 19 Oct 2023 03:42:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v6 2/2] net: dsa: Rename IFLA_DSA_MASTER to
 IFLA_DSA_CONDUIT
Message-ID: <20231019004249.as4zlbb754eyagwz@skbuf>
References: <20231018175820.455893-1-florian.fainelli@broadcom.com>
 <20231018175820.455893-1-florian.fainelli@broadcom.com>
 <20231018175820.455893-3-florian.fainelli@broadcom.com>
 <20231018175820.455893-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018175820.455893-3-florian.fainelli@broadcom.com>
 <20231018175820.455893-3-florian.fainelli@broadcom.com>

On Wed, Oct 18, 2023 at 10:58:20AM -0700, Florian Fainelli wrote:
> This preserves the existing IFLA_DSA_MASTER which is part of the uAPI
> and creates an alias named IFLA_DSA_CONDUIT.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

