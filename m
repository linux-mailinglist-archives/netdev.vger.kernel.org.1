Return-Path: <netdev+bounces-14673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF11D742F4E
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 23:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5AF280ED0
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1249FBF6;
	Thu, 29 Jun 2023 21:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE20846B
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 21:10:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFE42D4C
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688073028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGOWLH5yYZOQguU6z0SZDCNOwqtS2A+CXlPEXU7v820=;
	b=Yut570b8ekLKcuP2MfKu+jr0N1n4tLzy7mAPrRD8XgTq0QWzQEyc0v7wjsAePxKaPhLoE5
	v6QoZRqmOMnAe/GFYRcZlVhpgtp3ssH+0/mRTZkyb89v0ONM/lbyWFqjjUvAasdxObgyKT
	Gr5IpTnuPDrmQcTOL0YrV03TmpoaXNY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-ETeYhFV2Oz6pA_ZfkU_uYw-1; Thu, 29 Jun 2023 17:10:27 -0400
X-MC-Unique: ETeYhFV2Oz6pA_ZfkU_uYw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5771e0959f7so9774407b3.3
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 14:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688073026; x=1690665026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGOWLH5yYZOQguU6z0SZDCNOwqtS2A+CXlPEXU7v820=;
        b=Ce+yWDIxzhzNcHnUjJnk2NuosG2wt8XchZZdr5A8KXwSbYSRJey4h/BGlTm0FRmPfk
         MGnQoOsffRVCPcqLzgXQhpna9KLHTmLncPk28E9+pW+gFk8zogaeRaLgyRcVa6VHwcag
         +R+kc9o4NZuCYIeTbHB9fN0zjCfR+DsaTzQJ7pG9LtBaK1RY3LfESPYlHn940pv5T7DL
         +mgpcL/h5dKZsE8fIsAecriI2UbCk45TW7z1ArJEotfIFeTIH/xv4mQb1eUgqdb3T7zM
         3s6fDJ/klUIloW6HnMeVW/DtnMdKgW7gjiVq120SFdfjMGuYS27AxM1lFe3KHUfk4cEX
         UMGA==
X-Gm-Message-State: ABy/qLZN7ln+GfpOE2WXAXpX2VSLY0ua0CMew3QGVfUkHU24UBNnV5lo
	E6xrOxYOH6EYtqOJHUO1bkmb8Q23S0iiiLsXIfs3Ch72EwV0zJvbu1wTQvllfOJt16RrnPhKHBp
	3MLB5jute2lw7bTcV
X-Received: by 2002:a05:690c:360d:b0:56d:a2d:d08c with SMTP id ft13-20020a05690c360d00b0056d0a2dd08cmr400006ywb.51.1688073026766;
        Thu, 29 Jun 2023 14:10:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFexhIe4+FSUhftLbXEZ7SljYaaxr3sHvF+qUjRjfjmLU8owbauYcWADujmTq/eC0LfyIjjVg==
X-Received: by 2002:a05:690c:360d:b0:56d:a2d:d08c with SMTP id ft13-20020a05690c360d00b0056d0a2dd08cmr399983ywb.51.1688073026548;
        Thu, 29 Jun 2023 14:10:26 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id a205-20020a8166d6000000b0057020aa41basm3041764ywc.65.2023.06.29.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:10:25 -0700 (PDT)
Date: Thu, 29 Jun 2023 16:10:23 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
	alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
	bhupesh.sharma@linaro.org, vkoul@kernel.org,
	bartosz.golaszewski@linaro.org
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-qcom-ethqos: Log more errors in
 probe
Message-ID: <20230629211023.pznzgue6arn7fzfl@halaney-x13s>
References: <20230629191725.1434142-1-ahalaney@redhat.com>
 <20230629191725.1434142-3-ahalaney@redhat.com>
 <e9157117-bd7a-4b75-841e-090103f75d22@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9157117-bd7a-4b75-841e-090103f75d22@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 10:32:24PM +0200, Andrew Lunn wrote:
> On Thu, Jun 29, 2023 at 02:14:18PM -0500, Andrew Halaney wrote:
> > These are useful to see when debugging a probe failure.
> 
> Since this is used for debugging, maybe netdev_dbg(). Anybody actually
> doing debugging should be able to turn that on.
> 

In my opinion it is better to use dev_err_probe() as done here because:

1. If it's -EPROBE_DEFER it will be under debug level already
2. If it's anything else, its an error and the logs are useful

I've ran into both ends of this now (failure of a platform dependency to
load, be it a bug in the driver, or just failing to select said driver),
and I've seen issues where new integrators (say you're bringing up a new
board) leave something out, etc, and run into issues because of that.

Thanks,
Andrew


