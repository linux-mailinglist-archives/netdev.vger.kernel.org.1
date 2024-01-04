Return-Path: <netdev+bounces-61526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46689824314
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49D42825C2
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC67225D7;
	Thu,  4 Jan 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Kfu5KJFE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3352822EE3
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d899205c7so4374845e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 05:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1704376147; x=1704980947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1N0CJHq6htpDij9HAOUTJdfEEnbukPhsaVqFV2O6M58=;
        b=Kfu5KJFEvaFn3dvgGo1N9pFqDDcZGpkSheTw6/hRxPyiU6lTy7rfDZ9XbK+C89S4v7
         h5NBoUlKRLX4FLORzRcW9B1Juj7CDQ8l3aNgIAhcxWnknCfcY2w9PZRo5E6DPv6wllDX
         +cr6V2ndSq3RAJFGHe5QYnREhD+zWOo2g/UDupubR7yeSNqNOLUj1sRWr5HZy9EiinJB
         fLO13ZStiqn8puVb8aXh9owvWgX28UAqyW436Wgcx4VOeRGnFCD7sPNf5CdKuCL/1LIH
         6DFn41Qk4TTBcZCY6Gre63rWVKSpznjbMQSVTKIRTLOGJ3qiLz1fw904hLKuc7ZQSg33
         mv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376147; x=1704980947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1N0CJHq6htpDij9HAOUTJdfEEnbukPhsaVqFV2O6M58=;
        b=ATfWBNm8O0efdJ8IT5VoaoD51oyqnFsj8OvhxxYLfWd9cuGjDTELgYaNhGaZM/6SCU
         TTb0E/EuD8jyK5EV7kWW4tnYc4zjEfBoZeiIHnvG8cXDkiuoDLyhvJrXBUh/kzfmb1cX
         I0FeX160fjpOxzBHfNb4g82Noz5siYCUonXFHOdLO0q5n0inBVlKhusCeWaNAsqyljaD
         BtYIl+kHxhrrrIrcGd15MNSckHI8C79h6Qc0rDeNEj88W9/odRC0tqZ/6wMaojZd3J5j
         l8fHSSS3prf8ywSRwdYYKLgAPiLaedO1rZo4wqmKVosFAUu1x3L7cLdtA47JGDBFjUls
         MSgA==
X-Gm-Message-State: AOJu0YxVOe2fwCGJV4eWBO6WOgdBS3d9VQk3qBp4c0PQ9+pA39QtlvtJ
	Fo8X24k6zy4wbNng9bShI8+68OwkdlaP
X-Google-Smtp-Source: AGHT+IFCXmewWplzS9dS4w5yAqKZ0sUEiQjYEZExiJcpaFkmwIbLwp8oPLCtP/EDEXfUC4t2l0cR6A==
X-Received: by 2002:a05:600c:84ce:b0:40c:2b01:e09e with SMTP id er14-20020a05600c84ce00b0040c2b01e09emr323603wmb.47.1704376147451;
        Thu, 04 Jan 2024 05:49:07 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id az30-20020a05600c601e00b0040e35f28039sm168575wmb.18.2024.01.04.05.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 05:49:06 -0800 (PST)
Message-ID: <fe1752a6-9866-45e6-b011-92a242304fce@arista.com>
Date: Thu, 4 Jan 2024 13:49:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: syslog spam: TCP segment has incorrect auth options set
Content-Language: en-US
To: Christian Kujau <lists@nerdbynature.de>
Cc: netdev@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri@arista.com>,
 Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org
References: <f6b59324-1417-566f-a976-ff2402718a8d@nerdbynature.de>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <f6b59324-1417-566f-a976-ff2402718a8d@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Christian,

Thanks for the report,

On 1/4/24 10:55, Christian Kujau wrote:
> Ever since commit 2717b5adea9e ("net/tcp: Add tcp_hash_fail() ratelimited 
> logs") the following is printed, in waves of small floods, to syslog:
> 
>  kernel: TCP: TCP segment has incorrect auth options set for XX.20.239.12.54681->XX.XX.90.103.80 [S]
> 
> This host is connected to the open internet and serves as a small HTTP and 
> SSH login server, not much traffic is happening here. So I'd assume these 
> messages to be the result of random internet scans and/or fingerprinting 
> attempts or the like. While not really a concern, these messages are 
> flooding the dmesg buffer over time :-(
> 
> Is there a way to adjust the severity of these messages?
> 
> * In include/net/tcp.h this gets logged with tcp_hash_fail(), which is
> * defined in include/net/tcp_ao.h and calls net_info_ratelimited(), which
> * is in turn defined in include/linux/net.h and calls pr_info().
> 
> Can e.g. net_dbg_ratelimited be used instead?

Yeah, I guess it's possible to down the severity of these logs, but may
be unexpected by admins: TCP-MD5 messages existed for long time and
there may be userspace that expects them (i.e. in arista there are tests
that look for these specific messages - those would be easy to fix, but
there may be others outside this company).

While thinking on the origin of your issue, it seems that the logs
produced by either TCP-MD5 or TCP-AO are desired by a user when they
add/use the authentication. Could you try this and see if that solves
the issue for you?

https://lore.kernel.org/all/20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com/

Thanks,
             Dmitry


