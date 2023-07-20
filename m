Return-Path: <netdev+bounces-19511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DB975B056
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E945B28131B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133F8182B1;
	Thu, 20 Jul 2023 13:47:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08242182AC
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:47:13 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A671989
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:47:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9540031acso11600711fa.3
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689860831; x=1690465631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVQGxFKlfgvd3VgDJEnXjzUdWaSsAReBgjpvdov+jhs=;
        b=21MChUUGBb0WwryxfPLpZgpJWbB5rRG7GM6BFwLBKbhLAD7Yu8Pi2gEenpI6yP8FiM
         6LiA/doc/BnYRhiqqygMNee6nID2+hu+F3Vt0yWQKku0yEe17hKzHHGftDYmD+IogYIQ
         4T4Dsv7lSS0M1pPUk5IGDXQ7K7c7S573zyIoJFAT9j+Hx7WBwM1Mri77RZS7R2pr55Vb
         tPgL1fMzGO6zMBwB2zF8PVwXNah1GD+xoBamrnCWppOLAmNs185bSaopRTU7G7dOZGrX
         mgVsFvvW5OyF+OMEkOumh6vU3H36DmS8ENoSPavNHOSWlOmOmnCrllP44vKncirB+dWh
         kHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860831; x=1690465631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVQGxFKlfgvd3VgDJEnXjzUdWaSsAReBgjpvdov+jhs=;
        b=J/KP8C/zkwATAQydKPru29+VDE5D2MLtAEG+uDROkoKIZGt9gWv1XzvbsPutnPJSTk
         icc9+ApZh4j4Hk7ssgCl1etzu7aHBVo2Ag+9oUaP1y4j+Qc7EFixEug11Cusi0N0G5RA
         2+SP9k2OUFmLs1sTJMdiGdB3IB8NWz5tsfG93apMfO4fipDYEHzyK+f455eYcLHoKvVB
         51mDWXsZrW+etGM8xkpSCxlnY0J2AYZk0G8SOBgiPfL0xdU1S9jParqxXI3mlCbqzP+6
         Icu85R4qTeRvCXDIILK96UsuQxKA2cEFZUHuykzZDeS5j2EQDmvXMv0vLdIhfjqeH+MF
         ZOCg==
X-Gm-Message-State: ABy/qLYbKRx/2SsNV3NelRGCcgF+S/kwpwOQWxfCFW20ypP7W5108SM3
	oI0OMOsJT1mJCNcSP73BbYpYgA==
X-Google-Smtp-Source: APBJJlEEZek5KRIa6bcSu2bM4KceJ2zX4pqJrmYY6RzzI6w3lkw/D+goyhKA17ZLHUk+OgVUe4/qBQ==
X-Received: by 2002:a2e:9416:0:b0:2b6:d495:9467 with SMTP id i22-20020a2e9416000000b002b6d4959467mr1887156ljh.6.1689860830793;
        Thu, 20 Jul 2023 06:47:10 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709063fd000b009894b476310sm717794ejj.163.2023.07.20.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:47:10 -0700 (PDT)
Date: Thu, 20 Jul 2023 15:47:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH net-next 03/11] dpll: documentation on DPLL subsystem
 interface
Message-ID: <ZLk63Uj8a9053BVa@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-4-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-4-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jul 20, 2023 at 11:18:55AM CEST, vadim.fedorenko@linux.dev wrote:
>Add documentation explaining common netlink interface to configure DPLL
>devices and monitoring events. Common way to implement DPLL device in
>a driver is also covered.
>
>Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
>RFC v9->v0:
>- fix muxed get-pin command respond example
>- fix typos
>- describe DPLL_MODE_FREERUN

Yet, there is no mention of "freerun" mode at all :/ Could you please
add it as you state here?

