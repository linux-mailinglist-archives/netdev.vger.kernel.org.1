Return-Path: <netdev+bounces-32068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD51792260
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34E01C20944
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C215FD2EE;
	Tue,  5 Sep 2023 11:59:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F4DCA70
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:59:52 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D361AD
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 04:59:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so24145685e9.0
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 04:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693915190; x=1694519990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9w3uV4OtPsdBYbHCTZu/QSzm/qmPZOCTm5LGAMv9s8=;
        b=uD2PQQ0XrE3fYNLL0YuN7mGm1A9gTTPFFwi6IGsZ6gOa1nMHXYZewvnOTeQD1DS9Ud
         NFyrR/NBRTJk2rpMOB8KWjZnnRmm78Vl6Dw3BTT70d/LfOieLJR/PrE7KKf9gZ+1WdEP
         tGnYNe8+dET1/cIyD+7+Bka48XdJuvwWPWzEyJqTiM7CgfeR4idahStBR9QUcbkNFFJl
         KJAkWFLn/KDgEaRAgLeepUFHmwUPQA7efFTJO61ALFTu3nWz6/LwDCiDtXBuM8wqdpfT
         vKIVr8Y5MBkruKS+8wpciyurMs7q2KizzgSnGDAcI1hCst4kFYjweYasYBZ4Z1nk7RSI
         2Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693915190; x=1694519990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9w3uV4OtPsdBYbHCTZu/QSzm/qmPZOCTm5LGAMv9s8=;
        b=Vuxx8UwFwfo09NiRNczgXJSQ/jQUfBy9S69eShPW4gEhsm4MQtUq7oTfQumcKywdHk
         T9MPTyBp75QVaIB1Y+DDTxnCqK/RuBkeZPYYKRw1chOrpdtGDVhprLM0uUwdW8tNrxaG
         rwE1PFOUSKZrznU1mrwQLJRNtjaksmPc4OgVxIGS6GwAbR8Rh8Vd7Ib/9iY3pOzzcx8X
         cHbLQ+tvY78NLmF24Y45hJO3muZJGyauOWZUCdHtrzOhcgDNPwk6nkc0OlHpNrdIRVAE
         uFpqb4GvDCUEsEDFK2yRupoMisAZpgniD8fDLlauLL7AgHDk3qGY/j7hZcG6y7yifLhM
         p+TQ==
X-Gm-Message-State: AOJu0YznfUBdh7fGOzMPDFrQIPeXpRzhCEmt2zBPMKwzkc9/Ob8XMxaU
	ImUpj2+6orcVayOAjWEhK1yoOYfHCMQdECQz8cw=
X-Google-Smtp-Source: AGHT+IHXh3GSboJMjsDNLpubzBj884qaOle8e1HaDZcS5Oou0lZ3DTIj6eJGKfPhqNq6aeaPHcx9pw==
X-Received: by 2002:adf:f208:0:b0:318:7d5:67bf with SMTP id p8-20020adff208000000b0031807d567bfmr9465711wro.49.1693915190016;
        Tue, 05 Sep 2023 04:59:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c025000b003fee7b67f67sm16725545wmj.31.2023.09.05.04.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:59:49 -0700 (PDT)
Date: Tue, 5 Sep 2023 14:59:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, netdev@vger.kernel.org
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	straube.linux@gmail.com, Larry.Finger@lwfinger.net,
	wlanfae@realtek.com, mikem@ring3k.org, seanm@seanm.ca,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH -next v2 0/3] staging: rtl8192e: Do not call kfree_skb()
 under spin_lock_irqsave()
Message-ID: <d7326392-56e4-4ccb-a878-0a03c91d0d85@kadam.mountain>
References: <20230825015213.2697347-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825015213.2697347-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Added netdev because they're really the experts.

On Fri, Aug 25, 2023 at 09:52:10AM +0800, Jinjie Ruan wrote:
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with interrupts being disabled.

There are no comments which say that this is not allowed.  I have
reviewed the code to see why it's not allowed.  The only thing I can
see is that maybe the skb->destructor(skb); in skb_release_head_state()
sleeps?  Or possibly the uarg->callback() in skb_zcopy_clear()?

Can you comment more on why this isn't allowed?  Was this detected at
runtime?  Do you have a stack trace?

Once I know more I can add this to Smatch so that it is detected
automatically using static analysis.

regards,
dan carpenter


