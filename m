Return-Path: <netdev+bounces-19906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC7475CCA4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A5128118D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AC41ED2C;
	Fri, 21 Jul 2023 15:52:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC327F3F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:52:12 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737DF3C11
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:51:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99454855de1so304420766b.2
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689954693; x=1690559493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9cwznzOyqJDHu1/UhNckA/YkZqmokkA3oSqw8rZ1hk=;
        b=yTQ5wr9/bSl1aYjgUbtyKyg8tBdMOvv1hZaWwKPZJV+OoBzAj1Uavi/48Sj6rg8LHA
         GK0/ZWOa0skXA6ZuaWlQS15fkkymddLNmq2d+5yzppO82tTrv2jLbYywAAdakqz+8GMQ
         bGxuK48ZJC0XIwKrUK1lyxTclyKD1QQjdEQ1/UR8XzauYi62fUfcnsU/Skc474iY0uWw
         BcbG6s12Ro+UovLxy/rk1pY74J7kIAKEdbL9ignde0mcW1s8bzqQ8gA8Wrxn8l1GdAUV
         Oy/PG95dFBCZYPbi2OgFUwar81wm5Uag6MAStGREx2UErz2TDkJ6X/6inn6Vo4Mh3Wa5
         h+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954693; x=1690559493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9cwznzOyqJDHu1/UhNckA/YkZqmokkA3oSqw8rZ1hk=;
        b=dIuniv4mM7tvFjjIJL7HTZwecikW+Jce9YlIrok48IgFfv5nbq0u6nv18XXgKkELu/
         mtJ1CcYhWQNpfAHkAaQSFqHhLOJzW9aBOuFIKcW6ME6nczItEBd+nvai5s0mR29y52Ax
         sSIPbhvA62fn3rx6q1X5LUN7XAoTg5aVKcejfE4EELT9ZC9/vmFcgDB5iSEhVC+7q38z
         OCbs0wvzZhWFTN4dNVJPe0SARhCRQb6KcLCks0+vUppZc9j03UcK2jZRtlEYSuo2mTSi
         Oh60ReQFfkqmeNt9G8VIyuR83xIL2mNrsugeKKawMo/H82+eKpY4/D+DhHXeQEeVJCcb
         3k+Q==
X-Gm-Message-State: ABy/qLb1D7v2L9N53oilc6KMKCh8NlPq2zhYPTRmL5rJy5iBV9+SP97c
	Bgk8yXzSWz7pm8/PjgN1jigpuQ==
X-Google-Smtp-Source: APBJJlFEwPtUfRs4GScQym4N9EIjtvMfz4M+uCsYtdVnHBQl7gNckmj2NfBO/8nwtkgU6hGJ4TkPsg==
X-Received: by 2002:a17:906:538b:b0:99b:627f:9c0d with SMTP id g11-20020a170906538b00b0099b627f9c0dmr1966315ejo.27.1689954693002;
        Fri, 21 Jul 2023 08:51:33 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jx21-20020a170906ca5500b00988a0765e29sm2332570ejb.104.2023.07.21.08.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:51:32 -0700 (PDT)
Date: Fri, 21 Jul 2023 17:51:31 +0200
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
Subject: Re: [PATCH 10/11] ptp_ocp: implement DPLL ops
Message-ID: <ZLqpg8sKBDxr7wLj@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-11-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-11-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jul 20, 2023 at 11:19:02AM CEST, vadim.fedorenko@linux.dev wrote:
>Implement basic DPLL operations in ptp_ocp driver as the
>simplest example of using new subsystem.
>
>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Signed-off-by: Jiri Pirko <jiri@nvidia.com>

