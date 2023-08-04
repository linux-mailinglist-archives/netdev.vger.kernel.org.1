Return-Path: <netdev+bounces-24419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DBE77022A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13632826D5
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE474C14A;
	Fri,  4 Aug 2023 13:47:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E3A929
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:47:48 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8D71BF6
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 06:47:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id ffacd0b85a97d-3178dd771ceso1898193f8f.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691156861; x=1691761661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvbyZl7o3izzZQLp7Y0b9RIMj8QAxcAwWaunav84SDw=;
        b=FbpksK0asFziyiy+hK5v4TcQeeIaIR1NUXNvp0T8YwIEs6vbTIzOOo5KfzF6tSkBgO
         +OdFIboek/+rGTvwJN79ftPr13X8lXu6aHUbX1g+9fbgNpR9v7UIn2dpeeOfg+CW28K6
         IXUq18aclWGyg78WIg5kIQmrgzHvo//yDiiOnUyM5YsU0X/AYIQ6lbBi+7LZ0qtVEZZ/
         dpCzQLrCgHa7TCAU5XGJIgQQf/npJHeGH/CIU1W/Np8jwk5rYm8oNkXIQLm81oc/WcY9
         KTwJHeXxbI4QdnwLIUNXypwa12L+YonKHEMlefiMtlgb9HuxhmpKQzLV5h27Mk+Qarn3
         tY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691156861; x=1691761661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvbyZl7o3izzZQLp7Y0b9RIMj8QAxcAwWaunav84SDw=;
        b=fc4HSP09rARSmvpbzr801dBK46MJDjLTgV/nOl1z2OWuCjbJPVYl93XzyUSWQosic9
         UOU8NTDcNcv0QqFfFce6vbC4MTj6SGS3YNTBnptuScu/jMHobQfN5pRdMvlXiASKeobz
         4M3M3qhjf16QMkJZu/vSWS1AGA/1cZWgpToRZrNNvu+giqbKP00lyY5oUucJNk2XdsTK
         9d3bZ4wuag4UvWitv/a6EHcNLlpwnlzANOlan1bKi9DqR1TXzE7jTaqhNXXBXFpcy39t
         vaV1kCm0POgrQiLclrWc8WYgq4zJA98omGGTMlpwoy/BbQCghA6YCj9uUCx79pFSKNT1
         EcIQ==
X-Gm-Message-State: AOJu0Yyv8eWXvToA6CkHIZp7pTEzoX7UorUsUU6ynqNod7CZRqLXL0Q+
	RF0N/vGZ2aTN08WXvzkxm1xvCg==
X-Google-Smtp-Source: AGHT+IGtmkXCcqnZuQaRYwvop1xV5GK+cjBPXEH1CvswNseUlrG58a4yXauQA15UyMe4/lX00LOAFQ==
X-Received: by 2002:a5d:4a4a:0:b0:317:6175:95fd with SMTP id v10-20020a5d4a4a000000b00317617595fdmr1319065wrs.43.1691156861110;
        Fri, 04 Aug 2023 06:47:41 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q14-20020adfcd8e000000b00314329f7d8asm2594246wrj.29.2023.08.04.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:47:40 -0700 (PDT)
Date: Fri, 4 Aug 2023 15:47:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nicolas.ferre@microchip.com, conor.dooley@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, maz@kernel.org,
	srinivas.kandagatla@linaro.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, sre@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Message-ID: <ZM0Be8S8zII8wV4l@nanopsycho>
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 04, 2023 at 07:00:07AM CEST, claudiu.beznea@tuxon.dev wrote:
>Update MAINTAINERS entries with a valid email address as the Microchip
>one is no longer valid.
>
>Acked-by: Conor Dooley <conor.dooley@microchip.com>
>Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>---
>
>Changes in v2:
>- collected tags
>- extended the recipients list to include individual subsystem
>  maintainers and lists instead using only linux-kernel@vger.kernel.org
>  as suggested initially by get_maintainers.pl

Consider adding entry in .mailmap as well please.

