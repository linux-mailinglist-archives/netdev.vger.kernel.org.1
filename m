Return-Path: <netdev+bounces-14507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117547421D5
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA4280D90
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 08:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439F8801;
	Thu, 29 Jun 2023 08:13:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825F848D
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 08:13:50 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE36E3A81
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 01:13:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc060a2caso1022925e9.3
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1688026425; x=1690618425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCNcU+qQjqANE7miJnt/rRYeXCcZNW96kSXkJVN64sA=;
        b=t+jCRgWMe9clsMdvABkCIyCYTsRENxOd2x1gINk9t8cwUOVP4GpHwYsveP15/BaTxa
         IiY4bWtoAXAchtgGBvWVBSVHajfMyXWMfg8mH09pnBnYrxbBszocjJo87KBBFuLdyr8w
         gDwrrJMKhMocvsJEE+7i6hMpn6aw274D3+HbNb8XDLOh+TxC3BZS79vlWTwn34U7DwIo
         UrNO+xXIyioiE15XYWLzIOxMxZF4seSi5sOpw+1uwvmqFJjPMEFdZ2BjQAT25raMMQuc
         Hd/KixDUkzG8rXkE/gv8cxwnI39xp/f05IZEtVkXU+ZL/rGRqJy4MJyAOvyOgom44ue+
         K2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688026425; x=1690618425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCNcU+qQjqANE7miJnt/rRYeXCcZNW96kSXkJVN64sA=;
        b=W8RGBkwGlqipLqO7DjTNZhbM5gaAw3XtlZ858qHXkaV5TkpgvVXfqf6Z1cZTnAhGdi
         0/AWWKr8fxYnjt2ZC3IvDLSpSGJ/KPAyK+xTbLc9DkMIv8bHxy+KWJ4lDEgd73rMSwB6
         TK9a10Th9JaKnpef+4c2/Wz8k9X1Z7o5yq8UYFpg2Iil99jvtDu2gtlV66G+s6XR9tVB
         XMDpoG/zGtLayd4liTWKoL2eTGTGEkPIcBGnYTv4eUBqbIeLV/45dY6wlGzz7hofCfmf
         mq71/pbbVeStPN5HxW0JNAZvAUv7iYuBKjT3m2b1SWgj8WsLX0aNTiaWRpaOiLI/Tecp
         pNGQ==
X-Gm-Message-State: AC+VfDyvAXhb4jVVd29HTH/L+2fg/cLNY5DdoHxYiQSalcDD0OhdEwQF
	yOVi/pJE8QTVHsOI9f45tMrkoQ==
X-Google-Smtp-Source: ACHHUZ4Hq/Ygv5bP0PW9CWoZ78vG28FdK9CR3U+nUITIwO8dut4OijbZB0fTo6rEzYqGldh55avUEQ==
X-Received: by 2002:a1c:7417:0:b0:3f9:b87c:10db with SMTP id p23-20020a1c7417000000b003f9b87c10dbmr20901942wmc.3.1688026425228;
        Thu, 29 Jun 2023 01:13:45 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003fbab76165asm5145964wmk.48.2023.06.29.01.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 01:13:44 -0700 (PDT)
Date: Thu, 29 Jun 2023 10:13:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: kuba@kernel.org, vadfed@meta.com, jonathan.lemon@gmail.com,
	pabeni@redhat.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, vadfed@fb.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
	richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
	ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
	michal.michalik@intel.com, gregkh@linuxfoundation.org,
	jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
	ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
	axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
	benjamin.tissoires@redhat.com, geert+renesas@glider.be,
	milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
	hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
	idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
	phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, linux-clk@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v9 03/10] dpll: core: Add DPLL framework base
 functions
Message-ID: <ZJ09N2TI4wHrA4rB@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <20230623123820.42850-4-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623123820.42850-4-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Jun 23, 2023 at 02:38:13PM CEST, arkadiusz.kubalewski@intel.com wrote:
>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>

One thing I forgot to point out the last time:

[...]	
	
>+int
>+dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>+		  const struct dpll_pin_ops *ops, void *priv)
>+{
>+	int ret;
>+
>+	if (WARN_ON(!ops) ||
>+	    WARN_ON(!ops->state_on_dpll_get) ||
>+	    WARN_ON(!ops->direction_get))

Please add check that you don't register to dpll instance which is
unregistered. Similar check needs to be added to pin_on_pin register.

Also, make sure you don't unregister dpll device/pin which has child
pins registered under it.


>+		return -EINVAL;
>+
>+	mutex_lock(&dpll_lock);
>+	if (WARN_ON(!(dpll->module == pin->module &&
>+		      dpll->clock_id == pin->clock_id)))
>+		ret = -EINVAL;
>+	else
>+		ret = __dpll_pin_register(dpll, pin, ops, priv);
>+	mutex_unlock(&dpll_lock);
>+
>+	return ret;
>+}

[...]

