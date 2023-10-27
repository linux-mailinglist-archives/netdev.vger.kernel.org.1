Return-Path: <netdev+bounces-44688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1317D93A8
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82422B20C1B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652415ACE;
	Fri, 27 Oct 2023 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pmLWYRZr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9588156F7
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 09:28:41 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3CEAF
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:28:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40850b244beso14378995e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698398919; x=1699003719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sO3pDvoK2XqmvW6XHeM4oFmiaQfjqAPIGza9kcBSOXQ=;
        b=pmLWYRZrolHMoFmXLhtIvD779H8Jwz4X48JrbJmDTLfrdNwMOeqzVHXLHGvAsf35Df
         ebuq819O0SERRdemY+/BptLNmq0FXkheS1U5mbKbQqE/KmzlL96/bUjSsGPUgKf6yIsd
         ha56eVJf2mLfyGkugYE03mjZhk5oyN757jOziNpEi1Wq3B+4Lo00oc4i1RHtdJh4qpDH
         nC1dDde5C9XQrKJOKhNAs0jgaUkq89aBxaaxhj62pLp5fpFhhu/311G9QhAVfMKn115T
         50l9o2j3J6NmMu2YhjNgjL4YybpXr+njYl7qm1hoP5hau8Q+amGpsPZwMm/lQ3NUE2Uz
         dX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698398919; x=1699003719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sO3pDvoK2XqmvW6XHeM4oFmiaQfjqAPIGza9kcBSOXQ=;
        b=u53whbg2RJ5arfDx1eEeJ88HqgbF9ALISmoqGkJeVz+RRRz5ImYU3hJHYjCM5t59xd
         AB4stKtYmo1D+HCQMXjEDxgpok6D4Upfa13YPql8pkcabgZF86/9RfUqQOlUOFTPOcLL
         Ip2YIML4GoTzvgl7jCtBhv2JoNyX5SC7Sz0bWN0vNdmvDkwxjlkJ6GmIzs/nFz9OXpeH
         HPyWhKIJBgVE+XlnmA8RWJwcO8PRsWC3Aa+djcZQn0gFnoN4xBB2Uh3p8CxSSW5CPWE1
         yVA1HCNCYs3DcYaoc6YNTkjzDIFMqMahlMy9BqqrRxCYUr/RbXz7fDiwwf4ax5UPA7WM
         pr5Q==
X-Gm-Message-State: AOJu0Yx4y0Kf6ZFhVXxVea8uku+TGX2nxrW4Cp/4tO/Lhv4S6wkXx+22
	ftU/5lHyVmLITASSYF9u8ebYLA==
X-Google-Smtp-Source: AGHT+IGdZOFPu9N5qOq8J7r7QUSsltfmeU/YPCuaLg36q9UbxhlikmRWvDBae+Q+yyhiXBe+tOd6sw==
X-Received: by 2002:a05:600c:4748:b0:3fb:feb0:6f40 with SMTP id w8-20020a05600c474800b003fbfeb06f40mr1996803wmo.11.1698398918799;
        Fri, 27 Oct 2023 02:28:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040472ad9a3dsm1168755wmq.14.2023.10.27.02.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:28:38 -0700 (PDT)
Date: Fri, 27 Oct 2023 11:28:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
	pabeni@redhat.com, imagedong@tencent.com
Subject: Re: [PATCH v17 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <ZTuCxUJnQM509L8e@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
 <20231024125445.2632-3-aaptel@nvidia.com>
 <ZTfNfvtZz7F1up6u@nanopsycho>
 <253h6mcjuq0.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253h6mcjuq0.fsf@nvidia.com>

Fri, Oct 27, 2023 at 11:11:19AM CEST, aaptel@nvidia.com wrote:

[..]

>
>>>+      notify = !!ret;
>>>+      ret = prepare_data(data, ULP_DDP_CMD_SET);
>>
>> Why you send it back for set? (leaving notify aside)
>
>We send back the final caps so userspace can see and compare what was
>requested vs the result of what the driver could enable.
>This is following the convention of ethtool features.

Okay.

[..]

