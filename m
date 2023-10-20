Return-Path: <netdev+bounces-42901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E087D08E7
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643852823A1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 06:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8BCA5F;
	Fri, 20 Oct 2023 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/zZ9RXb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26ECA46
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:56:23 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2537B1A8
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:56:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40853c639abso511895e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697784979; x=1698389779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9LEiI73HKl/yMmpsQOiFinCN5KnlO7an5SddP9Ej00=;
        b=h/zZ9RXbaO6rAMYh0u9MNKdaz1N2GUNDrj0mfc9tH9JPEDqCCTixPhr71XprBswFpU
         zw1UDvRG1gxZjStRUOUJ22FxlnDBF1cdw0aY6vLGihvZVTbAXxRSl4I6J4Q7S4noXN2s
         ivtewT2w6+s4XOX1A43g8i1gjRwINtvhtRpvXg55ON5YvbqBfMIc8gvJqxhwopN/F18z
         a8gkfuK5yM1Zr4H0dH1Q/30ICWdmJtInyuaRboQxhuC5DfU7SndpLWEaC16Ks3+B3Rvt
         iCIrUzRBvNw9pLmh9lnHbt/wwPBaiKDI4g/r97X0LhRv15n4Xn+n5KkzPno1g83eh5gQ
         WLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784979; x=1698389779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9LEiI73HKl/yMmpsQOiFinCN5KnlO7an5SddP9Ej00=;
        b=l9IWd+GXDUqs2WdEHBEiMhVnKzaHqN9JC1VHtwSE5I3yf3eUOsgT2w3bnRT3Da0IWG
         NgFKVXd96CbaFt8CmMRdK4hv8JL66kO66BoSAbK4qH9hxWee3zGXGXlTYhbuA4ZCT4ix
         YxcQGKD2fvY90T9BqHpp7JXtuCehOtajPi16jRWWwL43PRGr+4eEF5qNF6gB5jv52Rob
         t47gZSHGgp03w5tauduJ11jXyxAA3cWFIepr/wJGTB/F7DAzYF6wiD8kYJxPlFOfdyK6
         qkHo/IpKj1JoJKbuXfDjySL9dgVbkzyYA0rFNxoDLyROw15vl+9HxVgHRTotpC9tmLA1
         SXmQ==
X-Gm-Message-State: AOJu0Yx/NkN5SNBK0dXVXg19WVpXH/vPTfZyROVX0zVNX6KeBozM3rSQ
	uPV8GDbTi1HEpewl3ADvtpYG0g==
X-Google-Smtp-Source: AGHT+IEvEEtQGpyk+q26WaO58peFpV+y2bXO492uWGPLm75ilrOY/3/PfE6IuqfhDBM16huGVo92EA==
X-Received: by 2002:a05:600c:4f12:b0:408:3696:3d51 with SMTP id l18-20020a05600c4f1200b0040836963d51mr833558wmq.4.1697784979490;
        Thu, 19 Oct 2023 23:56:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b00405442edc69sm3580447wmb.14.2023.10.19.23.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 23:56:19 -0700 (PDT)
Date: Fri, 20 Oct 2023 09:56:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] i40e: add an error code check in i40e_vsi_setup
Message-ID: <be0b618a-4732-467f-bb99-f623fe4da962@kadam.mountain>
References: <20231020024308.46630-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020024308.46630-1-suhui@nfschina.com>

On Fri, Oct 20, 2023 at 10:43:09AM +0800, Su Hui wrote:
> check the value of 'ret' after calling 'i40e_vsi_config_rss'.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> v2: 
> - call i40e_vsi_clear_rings() to free rings(thank dan carpenter for
>   pointing out this).

Looks okay now.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


