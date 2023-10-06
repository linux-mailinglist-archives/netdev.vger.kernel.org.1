Return-Path: <netdev+bounces-38640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E807BBD46
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB7C1C209A9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2131628E0A;
	Fri,  6 Oct 2023 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jf5tBwEZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBF208A3
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:53:10 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86104AD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 09:53:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so20982955e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696611187; x=1697215987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h970WFqLxvJe5qinLhTrSPPuLT8BDW9gx47optmXmQ8=;
        b=jf5tBwEZFz7nyGkBzrCUrbD8Tm81IUwIEi1cGUpciDJfFG1z1fAUhA6QGKTa7YVN8Y
         iRlwlTLyB0GBvVaVlOIfFr8WIK6t7C9njwzsOwYvVzF61VGjW0x/40mSYhLyzBkrI7c6
         eaLNx8gxGvqBIoQ/PuXkCzzvqElNXZzKoUT6xop/Uv4QWbFvThBXg5NI1372dcjCKTLq
         OyHTxqVtlnWpP3MHSJYRtnlMTbQDFPm4tekhlBWap93Fng03POBnpxTPHgdDiK9+helo
         MAYl+t5x+BZNk9ELcMwFHibzgdngKFSAPwbNe6YGC8wIzkKxQmsVVl4RU3ONm+1JVL48
         LnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696611187; x=1697215987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h970WFqLxvJe5qinLhTrSPPuLT8BDW9gx47optmXmQ8=;
        b=CAYHDTFX6sjaShwAmdKI3+/JEjxhcxj7NOUIQheOY6RvTsQRlGB1ckLJaow67uqEmN
         9/FVkHDcgD8pqFN2Ri5dWtU41AAKIjGx6m0v1L3hPQC3acfVIgq3dF3ZNi/KoYYOnm3r
         9pqS9GRNxs+xe44bk5skP22V6it6IpO/4RFPnPEems9GeUQ91kjGVCCoh1bGUriyiheM
         lOtbDO+Fg9mm/b5xPCwdM7f9rHn6AjmRF1h4yNzEujhrThFVl56wLL2X2QB9eBbWyGfi
         Mx3TWuQv+CLZjGJOjesJq/AoUUMo8FStw4ia6ZquAQanZEJg7W41+/B44zqAmSQEReY6
         lp6A==
X-Gm-Message-State: AOJu0YxcVK98OoZQyeBzE92ll9+iXaGTniMLpWofyY1naM9CW63E6Qx1
	qH3uZ8gJvvP5H7S/fEAtD+Qv2A==
X-Google-Smtp-Source: AGHT+IG7AIHYrhwpOEb9IZJnVzjhVWheK168zk+9p/ADPkPcpyNkE8a+S1hlq/Czi4cKRB1GsbKksw==
X-Received: by 2002:adf:fa49:0:b0:31f:97e2:a933 with SMTP id y9-20020adffa49000000b0031f97e2a933mr7798228wrr.56.1696611186809;
        Fri, 06 Oct 2023 09:53:06 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003fee567235bsm6395414wmk.1.2023.10.06.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:53:05 -0700 (PDT)
Date: Fri, 6 Oct 2023 18:53:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, pabeni@redhat.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 2/5] dpll: spec: add support for pin-dpll
 signal phase offset/adjust
Message-ID: <ZSA7cEEc5nKl07/z@nanopsycho>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
 <20231006114101.1608796-3-arkadiusz.kubalewski@intel.com>
 <ZR/9yCVakCrDbBww@nanopsycho>
 <20231006075536.3b21582e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006075536.3b21582e@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 04:55:36PM CEST, kuba@kernel.org wrote:
>On Fri, 6 Oct 2023 14:30:00 +0200 Jiri Pirko wrote:
>> >+version: 2  
>> 
>> I'm confused. Didn't you say you'll remove this? If not, my question
>> from v1 still stands.
>
>Perhaps we should dis-allow setting version in non-genetlink-legacy
>specs? I thought it may be a useful thing to someone, at some point,
>but so far the scoreboard is: legit uses: 0, confused uses: 1 :S
>
>Thoughts?

I don't know what the meaning of version is. I just never saw that being
touched. Is there any semantics documented for it?

Kuba, any opinion?

