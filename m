Return-Path: <netdev+bounces-19748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC0675C05A
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7763C281967
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8B3D75;
	Fri, 21 Jul 2023 07:48:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D1420E4
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:48:35 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636C611D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 00:48:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso2588325e87.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689925711; x=1690530511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gp5//cguHLYjw2SPD+mbFWg9HVuK6b37FH3cK//qGJg=;
        b=hLtlrdlqzqF1rmhouHJVIM2/ulU5yZ6OhVUodGV3dB5sCGxEi03qj8IVodoF3VgjdE
         xT9OOucItuQ02RdRTF1Nr4yjGteCB8TfFGZ4pgJLwGtw1QI20sM+qsEC83h0dkhtSKvF
         AWJj1hmtJ8q36jijCclAjenQOU7/DkMM7XApHLQ32PCHCGOox4y8l4yCoNlA8MGOK35R
         +ztb4wj9z1+JOe8edDF7s3ss/MFjidhe9ieYwM2IfvClWJT/obF+9tOoK7TjlRYe6LU4
         kTy2uRmx9yCLA714T/i/xPpFtC8ELXM0Xbs5o8EkAhozds1zMemX5V5GB8l8SYEVxP+1
         qdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925711; x=1690530511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp5//cguHLYjw2SPD+mbFWg9HVuK6b37FH3cK//qGJg=;
        b=XXDGIMgAMmJce8ai7B8gt3C6kqLWe0mCuOZpQFYBvDt4ozit2rW2Y2DR2pRrOWKOqV
         SdJBeJXABEQdJ+cceQVkqz027oaDVV34nb2oinHbfVMORnsjCsgJy7M96iZTm109G+MP
         yzaGAWKV/9AbkaO2wLr0gFZYQ9M2MnJT4MTiGNHUg0cxXQME8W33aUt8oIdPhc5GbJ0D
         kWGANnRBcuvM5g9XcND0OmjGP4nWOMH9scfOMfhNfJEFQqribq9GbYJ+oYk7rKV4U3hL
         SJCOkbt5fnNnoaI+yVWvxT59aWJJt8H8lFsHP6ZXb85z+ebDUxV5MGITJy1dU/mjyh37
         LsYw==
X-Gm-Message-State: ABy/qLYoAf9/s6MBBt26N2Kpt1fh4gOqxASI/+R9aRvwWSxdwcuenWNO
	R5ykpncwbJm2oHXDZFyUU39zXA==
X-Google-Smtp-Source: APBJJlFOxnjBRmg+6z6oUJTZxyE5vxzlIUhVGdh6m0Y3/2JEb2QyN+bCyEfgV1Jg78je61sknpUG+w==
X-Received: by 2002:a05:6512:2252:b0:4f8:6d54:72f9 with SMTP id i18-20020a056512225200b004f86d5472f9mr1039485lfu.61.1689925711564;
        Fri, 21 Jul 2023 00:48:31 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c028f00b003fc06169ab3sm5598995wmk.20.2023.07.21.00.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:48:31 -0700 (PDT)
Date: Fri, 21 Jul 2023 09:48:29 +0200
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
Subject: Re: [PATCH net-next 00/11] Create common DPLL configuration API
Message-ID: <ZLo4TfaDKlgBVD2N@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jul 20, 2023 at 11:18:52AM CEST, vadim.fedorenko@linux.dev wrote:

>v8 RFC -> v0:

Just to avoid future confusion: In netdev, the count goes from 1.
So this is v1. Next submission will be v2.

