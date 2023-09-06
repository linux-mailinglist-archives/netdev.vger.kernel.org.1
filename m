Return-Path: <netdev+bounces-32200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA3479373A
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 10:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3782A1C20A11
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 08:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AEC62B;
	Wed,  6 Sep 2023 08:37:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC1A52
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 08:37:38 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97ABE47
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 01:37:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so2905988f8f.3
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693989454; x=1694594254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pLvxqkVcGrj0lGKXFta0h+15ddHO134yyI3SPEEzAKg=;
        b=R5VMhODl9rRQwWpXjU/CKq3PcnrZcYb85/PTd9zRH+WiMVSWE1VSxB7sG/KXqxH5IA
         JchoUIXgoGxEKov7u1fK8i46eh1/+nVtVytXoHBMqnWBgXlSLBg0jvlu7aMhiNXUxu7o
         BTnNlwbw3cIX/lH8lNnpfRulMPoh1+KxTjaE5+E/hcnAyZZvKEp9DzoKxoFk5kMNWM3o
         0qn2JbblY8PXWVm6ICPqCmwe8jH2bTS2hpIweq5X13BTaiDaUEmNfAOgoIiPszzmaQnt
         NHTmtJmlbFTkP4ozmXByj7DpAbMFQa4COJVvb7ID9pqaapOllUdzJ0MvHikLXsF/d1FY
         SSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693989454; x=1694594254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLvxqkVcGrj0lGKXFta0h+15ddHO134yyI3SPEEzAKg=;
        b=Qnjc/cs1H8SkUW2jiuxq62CM9nArJQaJYXV5gxa2LIF2deI26eN9HaajQosuLmYLz4
         T+y0Uu/7B6rt/o5ImAmgGZf7RPtJZ+QKoankCczmNoNe/098Vwf+F5/EAUvl0etunfX4
         kFPP9JNokGbzzJ6lX1xTCw4aexnQiFNN2FeE5ar6KUxdRGqXoM5kcnrNc6Nyk56Ju0nl
         dCs17bzoqe22e/CFPo1F7Yi2kxcJZzFa53FlJWZJLo4N7pHNBUvpU4CefJESWfsQYuR2
         LNVXpnLKs7Lmz6zXFUeHO4W1qWmoeiHOCS822A7NAatN/OTZwZ5pX1cNGhCk2OMe7Y87
         4lfg==
X-Gm-Message-State: AOJu0Yy1dRz94BxWzvuILZU+7AYFpp+F4Zk2h8au58UpegF8FgmlePjZ
	x16pAefoIQqA/XYGiMoOK5xSK5M6baLblhHI9R8=
X-Google-Smtp-Source: AGHT+IGgBixjKxuTBBYWuFq762q1URHhmlYUZ9/8lQFX9qon/QhhHDr/qErp5oYLmkehX7+4VS+HJA==
X-Received: by 2002:adf:ed88:0:b0:31a:e3ad:f30e with SMTP id c8-20020adfed88000000b0031ae3adf30emr1759759wro.68.1693989453796;
        Wed, 06 Sep 2023 01:37:33 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s16-20020adfecd0000000b0030ada01ca78sm19753926wro.10.2023.09.06.01.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 01:37:33 -0700 (PDT)
Date: Wed, 6 Sep 2023 10:37:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: kuba@kernel.org, jonathan.lemon@gmail.com, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, linux-arm-kernel@lists.infradead.org,
	poros@redhat.com, mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, bvanassche@acm.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next 0/4] dpll: add phase offset and phase adjust
Message-ID: <ZPg6Sz6pgLnmQcpe@nanopsycho>
References: <20230905232610.1403647-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905232610.1403647-1-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Sep 06, 2023 at 01:26:06AM CEST, arkadiusz.kubalewski@intel.com wrote:
>This RFC is to start discussion over extending dpll interface
>with possibility to:
>- read a phase offset between signals on pin and dpll,
>- adjust a phase of pin's signal.

1) RFC patches should be marked as such
2) I suggest to postpone this after the first dpll patchset is merged

>
>The RFC is based on latest version of dpll interface submitted for
>net-next [1].
>
>[1] https://lore.kernel.org/netdev/20230824213132.827338-1-vadim.fedorenko@linux.dev/
>
>Arkadiusz Kubalewski (4):
>  dpll: docs: add support for pin signal phase offset/adjust
>  dpll: spec: add support for pin-dpll signal phase offset/adjust
>  dpll: netlink/core: add support for pin-dpll signal phase
>    offset/adjust
>  ice: dpll: implement phase related callbacks
>
> Documentation/driver-api/dpll.rst         |  53 ++++-
> Documentation/netlink/specs/dpll.yaml     |  33 +++-
> drivers/dpll/dpll_netlink.c               |  99 +++++++++-
> drivers/dpll/dpll_nl.c                    |   8 +-
> drivers/dpll/dpll_nl.h                    |   2 +-
> drivers/net/ethernet/intel/ice/ice_dpll.c | 224 +++++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_dpll.h |  10 +-
> include/linux/dpll.h                      |  18 ++
> include/uapi/linux/dpll.h                 |   8 +-
> 9 files changed, 443 insertions(+), 12 deletions(-)
>
>-- 
>2.38.1
>

