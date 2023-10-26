Return-Path: <netdev+bounces-44452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADEB7D8037
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619D9B2124E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950729425;
	Thu, 26 Oct 2023 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PD66Qnv1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F771A59E
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:04:04 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6160D93
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 03:04:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ad8a822508so116147566b.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698314640; x=1698919440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRjGO1P3xZbeZScN6e8wcfUXyCE5/0r7RnYpU1CqyH8=;
        b=PD66Qnv13AQrroh3mbjeKf8Ozd/ikgMY4d7/gsRClfeOa0g+uTgAtj7CCcmxQem8bq
         deEb9RQ+UCIIlJFHZOU3KMzTv7GSj2/Ce6qutxJsbNyzg5txlt/acYYwxxU9Us/1q4zf
         46MQ0iunrH6fOvWdeiMjQnIdc91tD5iWYw+ih6Ak8YFjL9DXvDsHkZyynO+Ma45eIPuT
         eg9SA8M9PGPtukHSA4PHYlNNXGkJq00+HJ+jOy2725iuoZMJv8X7DNirB44GLwRgfp4z
         HNoaWyMNolZQP0TgxdvUOiSj58PMAxRZNw/ja0AVUR/4w9kFqIfr5/EKd7AqBFssqLcY
         WeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698314640; x=1698919440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRjGO1P3xZbeZScN6e8wcfUXyCE5/0r7RnYpU1CqyH8=;
        b=d71CNAVX75K/nEo+J8w63Qg0z2/CbKdmfxt6mIeYccWRp9TxMIR637lanKdsAIevtO
         w1wdfPHL1ksYabo84fMmWvyEdbR+cvxfPragw3YW+eYeLlS32PPxaHqtpeFpeTDw4WFU
         x8np/bWw5r4rTFgkbzd6azJipPaWlK1ovk2v63avTajQEQQMRCC0OwiF1SGtRkmNtd1i
         5qUaxaTHZmCZgugWUkJM9zTyRGY+yl9eWdLp/OrvD6qrGZCgIECO7h2nKGKzIOhjMPLD
         TV5mxg4DIN683+ZMlHLzBcb7lukc/hIvQJcFuyroHba4fgX+jHJ+ZM1T1xys8n9vxrVy
         wbGA==
X-Gm-Message-State: AOJu0YwlnxTset70VoiUaZ9FG+JDXZkYaZiTAWME4dwLlCcZt2/3fM6c
	FR9rHhChvkYCEsj7trgU7soLCg==
X-Google-Smtp-Source: AGHT+IG43OM4ZwOwG5GyN/O6ixBgfIxI7hAf+wnMngvFnv2dM1/lgKIPBqxl9TOyCfbZiKmB3PYazg==
X-Received: by 2002:a17:907:1c2a:b0:9be:9e69:488c with SMTP id nc42-20020a1709071c2a00b009be9e69488cmr15538305ejc.59.1698314639609;
        Thu, 26 Oct 2023 03:03:59 -0700 (PDT)
Received: from localhost (mail.hotelolsanka.cz. [194.213.219.10])
        by smtp.gmail.com with ESMTPSA id g19-20020a17090669d300b009944e955e19sm11467400ejs.30.2023.10.26.03.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:03:58 -0700 (PDT)
Date: Thu, 26 Oct 2023 12:03:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next] netdevsim: Block until all devices are released
Message-ID: <ZTo5jWlkYOE4nFBe@nanopsycho>
References: <20231026083343.890689-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026083343.890689-1-idosch@nvidia.com>

Thu, Oct 26, 2023 at 10:33:43AM CEST, idosch@nvidia.com wrote:
>Like other buses, devices on the netdevsim bus have a release callback
>that is invoked when the reference count of the device drops to zero.
>However, unlike other buses such as PCI, the release callback is not
>necessarily built into the kernel, as netdevsim can be built as a
>module.
>
>The above is problematic as nothing prevents the module from being
>unloaded before the release callback has been invoked, which can happen
>asynchronously. One such example can be found in commit a380687200e0
>("devlink: take device reference for devlink object") where devlink
>calls put_device() from an RCU callback.
>
>The issue is not theoretical and the reproducer in [1] can reliably
>crash the kernel. The conclusion of this discussion was that the issue
>should be solved in netdevsim, which is what this patch is trying to do.
>
>Add a reference count that is increased when a device is added to the
>bus and decreased when a device is released. Signal a completion when
>the reference count drops to zero and wait for the completion when
>unloading the module so that the module will not be unloaded before all
>the devices were released. The reference count is initialized to one so
>that completion is only signaled when unloading the module.
>
>With this patch, the reproducer in [1] no longer crashes the kernel.
>
>[1] https://lore.kernel.org/netdev/20230619125015.1541143-2-idosch@nvidia.com/
>
>Fixes: a380687200e0 ("devlink: take device reference for devlink object")
>Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

