Return-Path: <netdev+bounces-19889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59775CADB
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B694C1C21743
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642F27F37;
	Fri, 21 Jul 2023 15:02:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90619BC5
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:02:19 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404DA2727
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:02:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso17490635e9.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689951736; x=1690556536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHTZrJjv5WqndLGnL7DVBJ2n68L3K3xFvi3X7ULZFK0=;
        b=J51+SQr/vsPd39jfRgoynZuapCWMVSNvinSJ0y1WxOnMCrW3ur4+SVyyPY1KRBF/pG
         GUPWcc6iX6UbmXc7JTYvV1Jtl72jFIV5fnP0Y+sZxvGxmTmu17erS5UTKmm1hm00iDY2
         og9Njmd2LNpd0yMNFlZ/GQD87Gc5DoWYQPDCYQsho7PeKEki3bOsS3he8yaBvhbmiYeS
         AXASpnutteh+qETiLKWHyJDk5a46LWprnXKMSOXK50jGhQcfQsBvoBRaptOi+ki9oRKb
         1OO3EAJdt2c5P7JGq76u7Kj6j9Kr0jQO8K6hGmLjEMr++cIggfz7bMeSakJBCwRG+I30
         p2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689951736; x=1690556536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHTZrJjv5WqndLGnL7DVBJ2n68L3K3xFvi3X7ULZFK0=;
        b=E297E7MqT39t1oHVShkW37ndCwf3fI6zHxi4tpx2fcNaLsOT4wEFo34x0Lr9jQYTku
         Nlsh1hCbCpuyDljxU2uzUMOLtCNIx0T7BrHiIx4NQ5D/LUDmnf/KROxic0Y2TnvJsMyX
         sIa3JOBpITuTQFlD3ysT/RCo5pbSrM65C0fmtQwWwnDweQEMe6Wrj4PjvuzvAJ6L4fuH
         zoIrWp0ZKXWf2UrkVX2y9i7uxGB4w8392fGINJz+i//GXMUz3LftAvFADsZ00HPdEYcD
         9rgvTBqdHJdIiHc3Q4amgRQLPB5Yt2wm/BL2o6b+nT0HfJLCp5z1Bi0u0iqbT8GdM4V7
         RaZw==
X-Gm-Message-State: ABy/qLb3sbsvyUPGfQq2ZFsc0qOBfpI2SYQlaUgUJNBgUaOs+Qwy4jqH
	Xq7tx8b1xksTWoN+V4OQlns=
X-Google-Smtp-Source: APBJJlHF+Qk0zdorUygC5TOwJeGNBmHYzwISvkvHUiWKI7N2xlsVPsBXVd2G/Bsc3roHSCEIzk3g7g==
X-Received: by 2002:a1c:770b:0:b0:3f9:b30f:a013 with SMTP id t11-20020a1c770b000000b003f9b30fa013mr1647808wmi.6.1689951735313;
        Fri, 21 Jul 2023 08:02:15 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fbb1a9586esm6314286wmj.15.2023.07.21.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:02:14 -0700 (PDT)
Date: Fri, 21 Jul 2023 18:02:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, maciej.fijalkowski@intel.com,
	davthompson@nvidia.com
Subject: Re: [PATCH net v4 1/1] mlxbf_gige: Fix kernel panic at shutdown
Message-ID: <20230721150212.h4vg6ueugifnfss6@skbuf>
References: <20230721141956.29842-1-asmaa@nvidia.com>
 <20230721141956.29842-1-asmaa@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721141956.29842-1-asmaa@nvidia.com>
 <20230721141956.29842-1-asmaa@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Asmaa,

On Fri, Jul 21, 2023 at 10:19:56AM -0400, Asmaa Mnebhi wrote:
> There is a race condition happening during shutdown due to pending
> napi transactions. Since mlxbf_gige_poll is still running, it tries
> to access a NULL pointer and as a result causes a kernel panic.
> To fix this during shutdown, invoke mlxbf_gige_remove to disable and
> dequeue napi.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---

What is the race condition; what does the stack trace of the NPD look like?

