Return-Path: <netdev+bounces-27007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7181D779DA5
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 08:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDDF281DE3
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3EF1CCB7;
	Sat, 12 Aug 2023 06:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14111CCAF
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 06:19:50 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491519B2
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 23:19:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c0290f0a8so339867966b.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 23:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691821187; x=1692425987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjmLF1rO5TorvHBy4pxrBOw1UIR+s/EKu3iHtx+Nh50=;
        b=P+eORdmHrfUq0eOC5J81tYaBqXZES0VMhvt28KeKlsdwVdQpvsQD5ws3OtjN61fsgW
         LVoGtSoX3FefyuQTIaB8zYNKuSxbNG7Kj9xVwmjUNjHhDFvIEpmCafNB8KvndOfaHzFh
         6HOAOEQ/SJPuUqYcxHwe08SPbR8UNlIIZAEqiZj9YHsM1LzV6oYVfpwyJcb7x6BH49np
         jP1vDVspTKKs8a75LKKcYQbm7izz/USlZJCDuZi0tdgAVHZlT8TGB4+gRbN9bw7qmYMW
         u29Een9xQ3Xiq2P5NnCv95RmRDSHakE1P9iAWWH2Zb9z7WLal0BcUGtiHHfqqri66zI5
         uQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691821187; x=1692425987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjmLF1rO5TorvHBy4pxrBOw1UIR+s/EKu3iHtx+Nh50=;
        b=A0HUUESQ735UBF/Wb0roJ5YYrm9decRk6c+KvZ04X+8bKckoKGkEmx1/DYFcKeGpEF
         XNFydU1m/gtWevwaYNam9ZR/gJqWvhr6t2vpdc1vboa7TvJU0/CbLBj43mEOHr2l18vJ
         iE8OQVRXPZoo24dbSNCKGUcAuiHjl/DVlDUcWNcoa1fWqSCjsRxlBm6N70eWHDcLFr68
         xigaL23kuzNgd6CIBmrYOdVxPhwoOxXAbPIBjs8tXNKKghAGjSv1w+VhBMVsmBkHhj7u
         vOS2IIUvYYu77LoIp9tYofFj8Q7x0+1uqFkUXWMTDMqsmxkYN42fU6Ei06ujz2wV4ZIl
         KA6A==
X-Gm-Message-State: AOJu0Yz+wdjpLq5RyromDugqXhV4mKP5qdTfJMjbxNpkECXwGAIBXt9b
	1L2x8niDtPBWFz8P+JnGGyEHTQ==
X-Google-Smtp-Source: AGHT+IEPlIXz5uM26zKwi4mc++wqqZbRXc7W1xYTx2DsLMBRS7DeeCnK6XHSPYqBnlnaUBHaDTo/VQ==
X-Received: by 2002:a17:907:7859:b0:994:4e9c:30c6 with SMTP id lb25-20020a170907785900b009944e9c30c6mr3096190ejc.57.1691821186721;
        Fri, 11 Aug 2023 23:19:46 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id g18-20020a1709067c5200b0099316c56db9sm3059967ejp.127.2023.08.11.23.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 23:19:46 -0700 (PDT)
Date: Sat, 12 Aug 2023 08:19:45 +0200
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
	intel-wired-lan@lists.osuosl.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v4 7/9] ice: implement dpll interface to control
 cgu
Message-ID: <ZNckgQzRO6uSvnaV@nanopsycho>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-8-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811200340.577359-8-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 11, 2023 at 10:03:38PM CEST, vadim.fedorenko@linux.dev wrote:

[...]


>@@ -4690,6 +4694,8 @@ static void ice_deinit_features(struct ice_pf *pf)
> 		ice_gnss_exit(pf);
> 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
> 		ice_ptp_release(pf);
>+	if (test_bit(ICE_FLAG_DPLL, pf->flags))

This is a duplicate test as you test it as a first thing in
ice_dpll_deinit(). But nevermind this nit, let's have v4 merged
if possible.


>+		ice_dpll_deinit(pf);
> }
> 
> static void ice_init_wakeup(struct ice_pf *pf)
>-- 
>2.27.0
>

