Return-Path: <netdev+bounces-65906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D126983C49C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 15:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DD21C246CF
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB063411;
	Thu, 25 Jan 2024 14:24:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943E6340D;
	Thu, 25 Jan 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192664; cv=none; b=cb+wOvhVSjWIaXozelE5o+MCboXuxyzjLpJiS3AjR00HVUZXBVjae2iA6NM3oGjrZFxqmiorUKLwe02RVKnRZ708AnOMG42G5uZhJQ+iC1mz+N0L6onUt3I0X8zxwkZSuKyK0wUqbFSL+cu+1egv7OCGYykVRoC+1MTy2V1/Yho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192664; c=relaxed/simple;
	bh=ygu+dub5SAp58v0IhzyIFTLAsSxgQ6eYUHd7m+hvtz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geJk4R2C61Pgy6of03kai9RxbGGcqI/MQn0gTg1rLd07DwwUgMwbLHAwy0bmhydqbbmLY3ZkMKjw3afJNIHRWnoZUA1T5xAlrz+FiIV5QVwolz/Cr68kRFNSykNehx0d8V19FCl2s3ZtGdh1ZHXWWfItlYys38iGrEnqkbH28ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-510221ab3ebso98225e87.1;
        Thu, 25 Jan 2024 06:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192661; x=1706797461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJg/iy5CsXL6wzjV6P3uPHR2XVzNTQ3/HSn7YWbDrh8=;
        b=tdeFiLWlD3HL9FLVB+Szb33Ch9jCMaGBaWPNrBtBVJv2mHu99+4oiBD7Zm3zrUGD+A
         4zt9eHYi+ecNpJmQvS1JjrBtDfWMS2xJ9AbNhc1fj/tD0drLTSHVz5vkQbfxuLOqjsOu
         KThvfz+DI0qD8ehJPaDaoL7cFJgLW/mrGgL+GMOukIPLFXKRwFOVtlvaWCSo4zaUuXZk
         OpS0vWKCvJDnDKNq7VNd7IYu49HIWdMJcvRz97Ev1ivH2H2ozcZaxpZN1ZLcU8A1Gw6M
         TRGYq3lcTKJRDQdrfKXzTWqxKpmqHuzNCiW4Lp4Cpn2GupPIXERGmGhV3mDPaTfmlZ19
         KyWg==
X-Gm-Message-State: AOJu0YwAGwa3HtQM1dT26TQKsN2XcmaxRYbGa5mCrI+v4xXJUfK5n+JG
	383KxejFxcE7b0uCIz87wYmJ4NPiHewxYTd4w0w4aYs9kh0W9WVGDzvxU7tv
X-Google-Smtp-Source: AGHT+IEFkINwBNPQJ6RaQjqK8qCjJTp5SPFuuvfDh5XID2NHTRlVVVjvNYhxKAsF5DHb91eBxbSaoA==
X-Received: by 2002:a19:381d:0:b0:50f:5e2:d50 with SMTP id f29-20020a19381d000000b0050f05e20d50mr597057lfa.51.1706192661039;
        Thu, 25 Jan 2024 06:24:21 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id hw15-20020a170907a0cf00b00a311685890csm1075732ejc.22.2024.01.25.06.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:24:20 -0800 (PST)
Date: Thu, 25 Jan 2024 06:24:18 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 08/12] tools/net/ynl: Move formatted_string
 method out of NlAttr
Message-ID: <ZbJvEp9fk1hI9rKV@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
 <20240123160538.172-9-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123160538.172-9-donald.hunter@gmail.com>

On Tue, Jan 23, 2024 at 04:05:34PM +0000, Donald Hunter wrote:
> The formatted_string() class method was in NlAttr so that it could be
> accessed by NlAttr.as_struct(). Now that as_struct() has been removed,
> move formatted_string() to YnlFamily as an internal helper method.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

