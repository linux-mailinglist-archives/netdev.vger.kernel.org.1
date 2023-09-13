Return-Path: <netdev+bounces-33470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C908679E11B
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA5281E54
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF131DA2E;
	Wed, 13 Sep 2023 07:48:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FF1DA2A
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:48:18 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E0F173E
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:48:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso6571497f8f.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694591296; x=1695196096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWoRpt4IEW8slblIeltP44h6t0NbWFyEN4yQEQghXLw=;
        b=UZL3+pq0TTX96+MZQa8+st4Qzu5DXRbEqOToj+QoSOLze09L7cSN5KY9DEEdcjzo38
         E297rgNS14mNixdbvnuHPxIlTKM5m9ashH0G3V3yC5V/wq7nNAWpH2LBnSsY9Yjh5rr9
         20LV+U+OAHLsKJW8SaD27aoVq8XQj8hZegQxzQHShdGwhrjArBWEgPFA+UKCYCVlWgje
         xU/23MQnQjFi5DVOno+sEmoqNPk5KSbsL6AYdC3D+X37Y2zloEW4ekX6CFhfF6qyBuVu
         HKfn6YbmTafbva1A2Osnyj2WljyZQkMXVYxlqPd/appaQApn3ZSSLmsMpaRRU1NnRFN+
         IwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591296; x=1695196096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWoRpt4IEW8slblIeltP44h6t0NbWFyEN4yQEQghXLw=;
        b=JQjfBB8AaFoIAxaqiS0QQJiVqn8SPHU01fTjaLR4cxjUqk/G/FeQeah4VTwV3t91bY
         5352dC6m+bX4p6ma2/GFF6sNu5uEVvLcYqS28NIuPRLgAGFbU3RVdYy7X3S0c+06Pvhv
         M0kq1CYtBDmweISKnz5j2QEA6ZFnqP8nrt4LQhRtSRy95UA3Gj6xYp6Z0gEvoYtAL3fV
         RunIlXFes5gW/jflHk+50J2N+LGMLZQJ3JRz51GF8tRJmeTK0LqO8EMScFmDE1RzphEF
         7XFWU4saDrCmTsq2L7dEf+WQbD2rSQvjHgt/7dMIJWB0eDbfpoGz6mZZCTYw2EIxLGC3
         W68g==
X-Gm-Message-State: AOJu0YzsixofijoeVEaQSxRdnFChk62HuWlSJ9tgLoVqjXyUqoglzhgP
	c6C9bG18z4Rtk5XqF1lvdOkmCA==
X-Google-Smtp-Source: AGHT+IFsO8o0Fm3JRzbY7xchfAXEnBAXZC4iqCbOMK2y0sqKyEIpmynvAxwHwCH7aJH5jrYfUsWx3A==
X-Received: by 2002:adf:f48e:0:b0:319:6d03:13ae with SMTP id l14-20020adff48e000000b003196d0313aemr1514189wro.55.1694591296153;
        Wed, 13 Sep 2023 00:48:16 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5589000000b003141e629cb6sm14652764wrv.101.2023.09.13.00.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:48:15 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:48:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: netdev@vger.kernel.org, eranbe@nvidia.com, tariqt@nvidia.com,
	kuba@kernel.org, anthony.l.nguyen@intel.com,
	vinicius.gomes@intel.com
Subject: Re: [PATCH net v1 1/1] net/core: Fix ETH_P_1588 flow dissector
Message-ID: <ZQFpPuplel7+QZwK@nanopsycho>
References: <20230913063905.1414023-1-sasha.neftin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913063905.1414023-1-sasha.neftin@intel.com>


No need to put "1/1" for a single patch.


Wed, Sep 13, 2023 at 08:39:05AM CEST, sasha.neftin@intel.com wrote:
>When a PTP ethernet raw frame with a size of more than 256 bytes followed
>by a 0xff pattern is sent to __skb_flow_dissect, nhoff value calculation
>is wrong. For example: hdr->message_length takes the wrong value (0xffff)
>and it does not replicate real header length. In this case, 'nhoff' value
>was overridden and the PTP header was badly dissected. This leads to a
>kernel crash.
>
>net/core: flow_dissector
>net/core flow dissector nhoff = 0x0000000e
>net/core flow dissector hdr->message_length = 0x0000ffff
>net/core flow dissector nhoff = 0x0001000d (u16 overflow)
>...
>skb linear:   00000000: 00 a0 c9 00 00 00 00 a0 c9 00 00 00 88
>skb frag:     00000000: f7 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
>Using the size of the ptp_header struct will allow the corrected
>calculation of the nhoff value.

Should use imperative mood in order to make clear what the patch is
doing. Anyway,


Reviewed-by: Jiri Pirko <jiri@nvidia.com>

