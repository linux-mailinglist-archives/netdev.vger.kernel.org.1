Return-Path: <netdev+bounces-23521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E917C76C517
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0609E1C211E0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 06:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026CD15D4;
	Wed,  2 Aug 2023 06:00:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4D15CD
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:00:13 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D896268D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:00:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe1c285690so9357897e87.3
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 23:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690956006; x=1691560806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3cBDFlmb0rLF7U5GOTszA6HHKFGynKk1sTqKDLZ/qc=;
        b=GzLGd6zt9F36vIYWCCnW7JC4cohWO1OJumfTx8hZ7k1Js0REj9KbY4Iimnmg1WT8OF
         TLPFyznT9cyeI8fi8odvIwHLQetGrRKNwempF5YxE3YPc7RgezWPE6wagjLjSjqxF669
         6ZjKkCvFNFN6XGG5MDoKz1uqESXiiOfiGbq4sphDa0wwPvXipUSiZuF9SzNUsbMM9xHH
         +skOsZPAmit/E7Iykx3eFUKIO2qgA55dhpFPUCksGZRvRKwTtWLLSReSXZyGWrEzv8wi
         IkHvMLqe9Puo/SdThRI2c17qBPeMePB1tkjuvdCRG+WxO6LZuFUcqP446gLy4L21LHgu
         qJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690956006; x=1691560806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3cBDFlmb0rLF7U5GOTszA6HHKFGynKk1sTqKDLZ/qc=;
        b=fkts863RmK+6aRLdgMg5xiOhpIqsYkM0avWUIayUHhOfYW9jwMx39fI20bFbAzFcbY
         OFf68qlMogYtYAYkv4GubODaEAubY1z6826p7LmbZ8qCBfZOrnUwN4OLxNc1gL7uCBeH
         tq35QnNsSBULj5lKkYNYcx7yLcpvFTvVUtBWCrDeuKkYNjqzE40blT60v9bmjqDaU6r1
         DXTSANf4l/HMBDsuug4aJaiumyIEhj4qGTLC6Frvt6Iq9doa1khJd/SGNbeCkgp3pPzr
         Jc9VOCRHuPiljBn3B3qNPTsu9pOOZBNuzUazYbYMUmimtoTXNalbxSiM72ivEHUFP6uQ
         022g==
X-Gm-Message-State: ABy/qLY7nSFzjZCwTDnxRSfd+GwkDraTuL+bGng1fleT2LlbmX0g8rsX
	eYbiRDE49iDF+fZgypKo5JsAXw==
X-Google-Smtp-Source: APBJJlFGk/uFoEFmSJSgr6va1DLUes/+N8hdaYJZu7fVLQH5vlglbTPNtnJ1o23FikkmSh62nEDj9Q==
X-Received: by 2002:a05:6512:3291:b0:4fb:91c5:fd38 with SMTP id p17-20020a056512329100b004fb91c5fd38mr3437958lfe.0.1690956006505;
        Tue, 01 Aug 2023 23:00:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bc5d6000000b003fe195cecb3sm735815wmk.38.2023.08.01.23.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:00:06 -0700 (PDT)
Date: Wed, 2 Aug 2023 09:00:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ruan Jinjie <ruanjinjie@huawei.com>, yisen.zhuang@huawei.com,
	salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] net: hisilicon: fix the return value handle and
 remove redundant netdev_err() for platform_get_irq()
Message-ID: <079063f5-e8e1-4a5f-8124-34d79d2fc9bd@kadam.mountain>
References: <20230731073858.3633193-1-ruanjinjie@huawei.com>
 <20230801144347.140cc06f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801144347.140cc06f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 02:43:47PM -0700, Jakub Kicinski wrote:
> On Mon, 31 Jul 2023 15:38:58 +0800 Ruan Jinjie wrote:
> > There is no possible for platform_get_irq() to return 0
> > and the return value of platform_get_irq() is more sensible
> > to show the error reason.
> > 
> > And there is no need to call the netdev_err() function directly to print
> > a custom message when handling an error from platform_get_irq() function as
> > it is going to display an appropriate error message in case of a failure.
> > 
> > Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> 
> Dan, with the sample of one patch from you I just applied I induce
> that treating 0 as error and returning a -EINVAL in that case may
> be preferable here?

This patch is correct.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

The comments for platform_get_irq() say it returns negatives on error
and that's also how the code is implemented.

Is zero an error code?  Historically, a lot of IRQ functions returned
0 on error and some of those haven't been replaced with new functions
that return negative error codes.  irq_of_parse_and_map() is an example
of this.  I've been meaning to make a complete list but apparently
that's the only one Smatch checks for.

Is zero a valid IRQ?  In upstream code the answer is no and it never
will be.  In this code the platform_get_irq_optional() will trigger a
warning for that.
	if (WARN(!ret, "0 is an invalid IRQ number\n"))
However there are some old out of tree arches where zero is a valid IRQ.

regards,
dan carpenter


