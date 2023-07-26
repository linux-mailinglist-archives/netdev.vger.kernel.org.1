Return-Path: <netdev+bounces-21487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58361763B28
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E58C281C7A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12BD253CB;
	Wed, 26 Jul 2023 15:34:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB51DA5F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:34:15 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72B8B5;
	Wed, 26 Jul 2023 08:34:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6864c144897so1561073b3a.1;
        Wed, 26 Jul 2023 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690385654; x=1690990454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWbwYwSV7iiV6v9eT8C4182R5bKMpB+kkZZ7eQ6vX84=;
        b=O9NuTZlCFyepHw+5xc11xK0qyBnILVl1oSHaNXjEcYMPOpFk2SIywI6Hc94q7dB/i4
         k7BDk0dCPgAkXd748xfFiko2FtThKPgfVB8p7ufDi0GCfjRLfa9iCE6SmkuY2MBNUQyX
         /koVe2eClI7gEGcJrhFUeImHiZDDrj4eHk2o9I0Fg9GSvol/jp/JnOklLns+J4Tnmk9n
         hraaPzk8JBASi0E/52rKC9dAgzj8sjJwrY34kwu08FczCzb/MjND23mq2aFh3R8K4meF
         p4wTjN9QMqZjRVvVHItwJMXNWCjIZJEp4c5N+ELlPtiEC7Mwq3IUOSQjP0XGjJS+JE2O
         w8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690385654; x=1690990454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWbwYwSV7iiV6v9eT8C4182R5bKMpB+kkZZ7eQ6vX84=;
        b=LuT4z6LV7brMr5ajcXvfzhIiy3LiSP6IWnvQ3yB/bzQm8UoLxDzz1OSeYgBkDRilMF
         UvstNeouNSQSlNz3YARPYMCkxaAOpZtEVcK1w0FfmDJclei50HVCEzusReMPdLkcYDH5
         JPo+mKetWJ6/kchNdg8d/f0Lx9X3wdLLtSQi5uz/invh4e6XfQRiSNro+DF1QgUXMCYd
         Wm20Vh8BUctZL0w5QuParZxmkzWYaVkZyf1+eKVlKJjuvGKN04IqDk3wD8APY4uRpSwv
         IfSXbySY9NyRpYl2/cbjzxQh+ajXtfogWoJpYboe8f5jAkfEpQOTX9F3rdkLWAtN1eYC
         IWgw==
X-Gm-Message-State: ABy/qLYpca6IbO91reWKj6PDWxRO9DaHefKqYw57/0gsNDGhJEpCveex
	caxJt/rajD74QhkTQnK7LGI=
X-Google-Smtp-Source: APBJJlGSV4nZT1u6Y+/+kpLnfP8AtBGmz13jE940isfGl8JKoJTH8WT3igY56rfoJorcXH1FFrBmWA==
X-Received: by 2002:a17:903:2441:b0:1b8:95fc:cfe with SMTP id l1-20020a170903244100b001b895fc0cfemr3017435pls.3.1690385654076;
        Wed, 26 Jul 2023 08:34:14 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170903278b00b001b89d9a58e9sm5963541plb.132.2023.07.26.08.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:34:13 -0700 (PDT)
Date: Wed, 26 Jul 2023 08:34:10 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Johannes Zink <j.zink@pengutronix.de>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	kernel test robot <lkp@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, patchwork-jzi@pengutronix.de
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <ZME88hOgNug+PFga@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org>
 <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
 <20230726-dreamboat-cornhusk-1bd71d19d0d4-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-dreamboat-cornhusk-1bd71d19d0d4-mkl@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 08:04:37AM +0200, Marc Kleine-Budde wrote:

> At least the datasheet of the IP core tells to read the MAC delay from
> the IP core (1), add the PHY delay (2) and the clock domain crossing
> delay (3) and write it to the time stamp correction register.

That is great, until they change the data sheet.  Really, this happens.

Thanks,
Richard

