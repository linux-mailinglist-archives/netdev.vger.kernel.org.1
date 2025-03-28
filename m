Return-Path: <netdev+bounces-178104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57163A74A8A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 14:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133683A7C91
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5814D70E;
	Fri, 28 Mar 2025 13:25:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9CA14AD29;
	Fri, 28 Mar 2025 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168317; cv=none; b=cFNYKebmC6uH1OI3fq68PYwMPXThyIWgAhjKklsBi3YMOdTZ2+1GxkOl0Z8tAOxqJiIs6kmhSMIwTVwTkPIowHhPEuz/eWjPOKpd8Om/qvm/Q9tOj/AaZFw1EU5iQ+kBgoFLJYyJy7STWF6x+W/GB4snadMUxSgAd9QWIj/IIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168317; c=relaxed/simple;
	bh=QEU3qP7xBFmNSOwZI8ArIPeXl8beJzBZsv3FjIIhwXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRmDjoNYvb8Zan41QCmvJncg9/kSjvMwiXLzZv6pxq3MzvpYY3rvm0cWFaZ4Dnq8NhCXr8U8oY5kQLpySeSACtw/KzxlIgOVcZ95syTX2v3Sjc3lue5E/Fq/OBk127bIuCSOcaUMjgpOs+5O0DWXE4XFN8u68SEh+GP5sl735oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso325664666b.1;
        Fri, 28 Mar 2025 06:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743168314; x=1743773114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jE6wfGvalw6lmInB5D0RDV8sjg9mzE1CqGAw4Fmt5c=;
        b=jwDlq5m69DmpbDZcVe6AHGNh/+q0hDBVAQHUNHhWLcJws72PiIuPdhOPJH5MeNta1z
         N3XfqjYdzIyD+lYU0bOOolZUqZ73PzOnV/qhJxtwsFz5qeytiWVCSMC+fS+EI/X+O8dc
         gdHdogXK/QtgHzkxZ29kddKam0V0q7XjqhOUTXAnoWMzKHjOlpXMi+RCafJtvDzy8fM+
         Y+LzMtLSNx7o4MK/E35Yxg36t7FgFco3oVdzeclkAHUxj1n1Af7FcVWRWO9K65ohpkDs
         BRlrC4mmbxeR35EC6MsHIZhajPNO3QrQS/S2qx4u7EfOv/J+bganFHgUqVpJc4hyqcjz
         aeog==
X-Forwarded-Encrypted: i=1; AJvYcCUjBfIi7HZwZgm5/fnavajJ0xnbDSykJLFN7t4YJJonineY1n6S/diNJnEdi9oRFdN2b7c9OmCL@vger.kernel.org, AJvYcCXZPOZcxGVU4M5YY+ZN9VBb1XD9Nb0Fbzf589GTYN61ZoDtfq7I82FVYPNRHlYVa+Eyd81n84Xy7w25Hog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HxNe/1swDRHPKPvDVh3Gr9H8IsKWTbbacI3PExLsxottbAa1
	4YYuXsq1pm0qcO5FG89lh4ILoHB3FXl2HCiP8qsXPe7DBqtaUnkP
X-Gm-Gg: ASbGncsFYwqmVLh0nmndCVXiuJRkPxBLLEKkO2bSRtziEwBlDvWdNLoHmSbcploexL6
	6pVtNgGR7OIIsNvZNGLAYimwsF7xweqd0tvDayEAsSmboWhBEyKDh8lTXIPdwjdECDfU3PFMHt0
	LskIHEDjazhL8nGdfEsg2oZskhhOhD8gtID2PeJkfzqxVYW8B5t9ANRE4LIFDU92dy/8SNiCW84
	7RRzeKHmszyEm1Pr/SL5GEInveob9Kf0/OmvhA1t1zzDq/s/ckQEbBMnZ8jP5pBykDntqcYfR/1
	KHlQwvW8kLnFPWm9qMFS6+ctCGVFg9mwPOc=
X-Google-Smtp-Source: AGHT+IFXGwAU9n1xb603UH5lCv05YvwrWsrQGLx1xmvw8N9JhQ8l280OHFMZl9TiNuWEQKARzpgZFA==
X-Received: by 2002:a17:906:eb4e:b0:ac7:30a2:696c with SMTP id a640c23a62f3a-ac730a26a0bmr44412366b.16.1743168313556;
        Fri, 28 Mar 2025 06:25:13 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961fd76sm156872066b.110.2025.03.28.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:25:13 -0700 (PDT)
Date: Fri, 28 Mar 2025 06:25:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: Avoid calling WARN_ON() on -ENOMEM in
 __dev_change_net_namespace()
Message-ID: <20250328-electric-buzzard-of-completion-bedfc5@leitao>
References: <20250328011302.743860-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328011302.743860-1-i.abramov@mt-integration.ru>

Hello Ivan,

On Fri, Mar 28, 2025 at 04:12:57AM +0300, Ivan Abramov wrote:
> It's pointless to call WARN_ON() in case of an allocation failure in
> device_rename(), since it only leads to useless splats caused by deliberate
> fault injections, so avoid it.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 8b41d1887db7 ("[NET]: Fix running without sysfs")
> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
> ---
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 2f7f5fd9ffec..14726cc8796b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12102,7 +12102,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
>  	dev_set_uevent_suppress(&dev->dev, 1);
>  	err = device_rename(&dev->dev, dev->name);
>  	dev_set_uevent_suppress(&dev->dev, 0);
> -	WARN_ON(err);
> +	WARN_ON(err && err != -ENOMEM);


I am curious if we shouldn't skip the rest of that function if
device_rename failed. Something as:

	if (WARN_ON(err && err != -ENOMEM))
		goto out;

