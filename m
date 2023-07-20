Return-Path: <netdev+bounces-19510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AAF75B035
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AE91C213FD
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FB4182A8;
	Thu, 20 Jul 2023 13:40:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038AA182A0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:40:05 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D14198D
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:40:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso6306115e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689860402; x=1690465202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHraClfOgsQuDEhG7LoVlxHfgn7n1hhxIrVLeOTgwQI=;
        b=k5wKAhiGlzWIXosKplzW4sqg5tZMDOzxl2TOzFAQ5iThIPcwzGmctCC7iA7j1csw2K
         NX3MYhkxWPn80zVWrMuGZqM4tQI0oGaMCQAVgrqRsuLIUwYyvcfbeROH/2KZel21hrv5
         wg60emvmeqxatlY5EytYM/ESQrX1maE28NvZAMbxxPpNPv7iV8jf7Xm5mCyYuyqqmbZr
         GblTK7v4DC5ldRoh6z3FsbUZrHni9Qok8m7GGvfPbBnlJnlRvXUhwgwCgUrYsevxDbC4
         blYWPIT4S7JrJJ9UfxB2NtGL0JuHsIAhZ5psEm7bYho1CbvF3uhVsnhMdKWaGWNAmHc0
         3TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860402; x=1690465202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHraClfOgsQuDEhG7LoVlxHfgn7n1hhxIrVLeOTgwQI=;
        b=O3UwMgAKkYEdrDREXLk3/rFKZOg3GZC724JsRCXV788/lGJ+Vt+x7IvMtvC+UUBiE+
         K9UaZWjl+hp5jDiAofxLiDoksZJi35v10k3ZXbNasgsx7OsAOqtr332pfOZvDe5T0Lke
         vaQDfFSGvXPv+WiOfYcsVoV7sGqE8Of7DrW6O1TcKpcRTJouYuxYSS6VJYCCzCdbrj/F
         xRJG4jqvOUQM/ZvRKAXagVOBBItCNXES062s22DNdVXu3dKpRAC+mjrqJpOYUaoqoSFE
         XYONe+2w3VnTqPehuMC3QvZZTjuUTPBqNs13ZrMdaZQN1w5pTPB76aR832qvTM4710r6
         nFXA==
X-Gm-Message-State: ABy/qLZK0R4/062SL5ek3TcKxmqLY3AKXNTUPjXfx6zpOFPHLwCZtx5k
	Xs+IZio+nPtSocXM5cMh3P7cSw==
X-Google-Smtp-Source: APBJJlFiHBXdXjwOaIIZ2mfFscw5kZzLqyBJzDNh5WGxyszNqzVr4ptz4kTLmXwdVR3/Au0G6TW2nA==
X-Received: by 2002:a7b:c4d1:0:b0:3fb:ab7d:ad95 with SMTP id g17-20020a7bc4d1000000b003fbab7dad95mr1826530wmk.4.1689860401802;
        Thu, 20 Jul 2023 06:40:01 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003fbd597bccesm3940534wmd.41.2023.07.20.06.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:40:01 -0700 (PDT)
Date: Thu, 20 Jul 2023 15:40:00 +0200
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
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH net-next 01/11] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Message-ID: <ZLk5MMjChnRFNU49@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-2-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jul 20, 2023 at 11:18:53AM CEST, vadim.fedorenko@linux.dev wrote:
>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>
>Remove wrong index adjustement, which is leftover from adding

s/adjustement/adjustment/


>support for sparse enums.
>enum.entries_by_val() function shall not subtract the start-value, as
>it is indexed with real enum value.
>
>Fixes: c311aaa74ca1 ("tools: ynl: fix enum-as-flags in the generic CLI")
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

