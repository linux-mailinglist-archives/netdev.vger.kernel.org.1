Return-Path: <netdev+bounces-38575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3557BB79D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AEA282303
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66B712B8C;
	Fri,  6 Oct 2023 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JMtW2IJI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC721D551
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:30:14 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53113120
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:30:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9936b3d0286so380510966b.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 05:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696595403; x=1697200203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7B9CLKlUxsIh39zlkJAcrlPeYuSRY+4E8JtipU09tMs=;
        b=JMtW2IJI4zciA6Gos6E68QktuUC6h20tyT44OAFG30LH7QZB+XK1ayXz+GhAMB7sKu
         Drvp7HUDma+QrRxgcacXMVdKrdzQMx+vw5pr+mTYKL8yFNuRJ5bkG1cs4ttuVoCRXJwS
         QAfPnxsxXIofCQIpBDsS7v11BoTcmJf+iZUOnev2HJRESgxLajCuHpLIeXdT2qSR7WjZ
         G7dgfBqDxKuACMQRWFpFFvPi8+VpmOf6/W7zoktclfA3AV5XxEvrAnxv/REc+jez6nQB
         jkBuruFUFuUsUD4i+vKBTs+x/28CIoTiTTbgPTEsq+lYPmEU4UWEr+ChQweSs57i+lsY
         JOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696595403; x=1697200203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7B9CLKlUxsIh39zlkJAcrlPeYuSRY+4E8JtipU09tMs=;
        b=WXbGYzw4QR4buW7244NMNGmOqHvrq8GFJbJiLigCieYDtax4n+txEcR7aDXpdcHIuE
         L15blEL2KuPrDywcsF9Y/zbpx9A12es0wKy6woWtdJ8Ui+CfExtlEn9ZAC2ny+qxUUR7
         RJAY8k7mAinPaaNrYP1xRLJ37XyvfvY5RYm3QV5ZD/g5kXVzvPMm/0ZtWIqlL3c+4fqh
         r3bsYlJww9VzlgtpvQbjoBlEioj3S24PTfgoOpm+UbIFzo/aEqa7+Hnul+Ldd9fTqSAd
         j4MoPgl+pQpDKKUmWvHfoohrq8gocyRSsg9e11HL1wqTovPDA5IMkiJiIXtR2bf6lo24
         xytw==
X-Gm-Message-State: AOJu0YyCnqDMJ04Yy4hczC/FdRBSKP71/LZBkMHEsCxgQiAo6iLBWhh7
	nzgovXHH1eS59u2Gd9tYvDhjPA==
X-Google-Smtp-Source: AGHT+IHe9lJ23bjLqmLRIXxnGNwvqvPXBegsmUly8qbAY3I43hhzINf4vHLPwy+eSvh/yaIjoc5ZFw==
X-Received: by 2002:a17:906:3012:b0:99d:e617:abeb with SMTP id 18-20020a170906301200b0099de617abebmr7096298ejz.23.1696595403416;
        Fri, 06 Oct 2023 05:30:03 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b0099bc038eb2bsm2767264ejb.58.2023.10.06.05.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:30:02 -0700 (PDT)
Date: Fri, 6 Oct 2023 14:30:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 2/5] dpll: spec: add support for pin-dpll
 signal phase offset/adjust
Message-ID: <ZR/9yCVakCrDbBww@nanopsycho>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
 <20231006114101.1608796-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006114101.1608796-3-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 01:40:58PM CEST, arkadiusz.kubalewski@intel.com wrote:
>Add attributes for providing the user with:
>- measurement of signals phase offset between pin and dpll
>- ability to adjust the phase of pin signal
>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> Documentation/netlink/specs/dpll.yaml | 33 ++++++++++++++++++++++++++-
> drivers/dpll/dpll_nl.c                |  8 ++++---
> drivers/dpll/dpll_nl.h                |  2 +-
> include/uapi/linux/dpll.h             |  8 ++++++-
> 4 files changed, 45 insertions(+), 6 deletions(-)
>
>diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
>index 8b86b28b47a6..dc057494101f 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -1,7 +1,7 @@
> # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> 
> name: dpll
>-
>+version: 2

I'm confused. Didn't you say you'll remove this? If not, my question
from v1 still stands.


