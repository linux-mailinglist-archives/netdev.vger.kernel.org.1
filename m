Return-Path: <netdev+bounces-48524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDAE7EEA9C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 02:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1543128120D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C705A10E8;
	Fri, 17 Nov 2023 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwD3ULdB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77CFC5
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 17:16:05 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5b99bfca064so1080330a12.3
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 17:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700183765; x=1700788565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Th1PvSE9JdN8vtfl8pbmEMdbVOttXuaci+9IGjXwLCo=;
        b=PwD3ULdB4bLR5JeE4QDJP5euzk9B76XloB8DvLHyl4lCeDDPjkG/CwKJQDB8ZK8xAi
         ulPcsR2wcHrkESHMBHcXnOEf/hfoMaU9HGeJTe0ky8FUOdkMLk5swa4qi9sM9v9wKApV
         ohutW0PQ6bZGPuHgrH+CVT2W6W1lq2MsLnuDFLOYV2k8wQN52ichACUPYtwZuNOtu38V
         IrJBjqdIEtH2S+VcX8Ir4be5p/y82fB3elxASWmazW9F5YdtukWmV014wW1rXCZrV4Dv
         hRcZ8gty8wsSSaIEsD3u4QOXPWWKtAOcjyKVgFtr1OyxnxaZtS+xLd7XZ5yOe+qIc1Ei
         E2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700183765; x=1700788565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th1PvSE9JdN8vtfl8pbmEMdbVOttXuaci+9IGjXwLCo=;
        b=s2VBuHqRfuR6BKvgAORlKxP3jTBUOQyFPovgYSH56Q7jBqA7WTaNxHTGcFT6YprO4H
         8RHovgOU881uaPzVTQdK07e1T5JeVIFNdcWbaXVTZD290LjPu1BAzTa/NP0JJ4dqUGGB
         924zo6lAcSi1x9IHFT5XXyy5vVzowFYnqUOb6Xs11gQ/KophM8pp8QeEMReg09D8gJKH
         TV1VCEWfoY+po2BHfbtvN4klwlGpe7kDYd4h40wkybDnIuTTcUu8lRHT3SNHWShZldBp
         x35ILzFDXHnSlV3A0wxg5gvCMpE0tttzk1FEh5M0+/sQgCRSo1Z/b+xzwHUh0VU1yApF
         ewOQ==
X-Gm-Message-State: AOJu0Yz3NtLoBttKLaC1Nud/TAH1nrn7RDDOkln+pwuY7dVvqvLVkw8Z
	eUsKVNR+JCBWMsywB+l2evs=
X-Google-Smtp-Source: AGHT+IE5J42YFV1dLBu9+YtwRRopJ5wfLm+YZ0gHSK3uTC11yc9z496AIzo/bPD9WjTbqX8huQuMYg==
X-Received: by 2002:a17:90b:1d87:b0:280:8778:c4ab with SMTP id pf7-20020a17090b1d8700b002808778c4abmr14873452pjb.24.1700183765113;
        Thu, 16 Nov 2023 17:16:05 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090abd8c00b002809822545dsm301429pjr.32.2023.11.16.17.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 17:16:04 -0800 (PST)
Date: Fri, 17 Nov 2023 09:15:59 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Daniel Mendes <dmendes@redhat.com>
Subject: Re: [PATCH net] kselftest: rtnetlink: fix ip route command typo
Message-ID: <ZVa+z0yqUzb5Wgt7@Laptop-X1>
References: <aabeb7c156a45c878e1ea94a6d715e6908f330a4.1700136983.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabeb7c156a45c878e1ea94a6d715e6908f330a4.1700136983.git.pabeni@redhat.com>

On Thu, Nov 16, 2023 at 06:01:41PM +0100, Paolo Abeni wrote:
> The blamed commit below introduced a typo causing 'gretap' test-case
> failures:
> 
> ./rtnetlink.sh  -t kci_test_gretap -v
> COMMAND: ip link add name test-dummy0 type dummy
> COMMAND: ip link set test-dummy0 up
> COMMAND: ip netns add testns
> COMMAND: ip link help gretap 2>&1 | grep -q '^Usage:'
> COMMAND: ip -netns testns link add dev gretap00 type gretap seq key 102 local 172.16.1.100 remote 172.16.1.200
> COMMAND: ip -netns testns addr add dev gretap00 10.1.1.100/24
> COMMAND: ip -netns testns link set dev gretap00 ups
>     Error: either "dev" is duplicate, or "ups" is a garbage.
> COMMAND: ip -netns testns link del gretap00
> COMMAND: ip -netns testns link add dev gretap00 type gretap external
> COMMAND: ip -netns testns link del gretap00
> FAIL: gretap
> 
> Fix it by using the correct keyword.
> 
> Fixes: 9c2a19f71515 ("kselftest: rtnetlink.sh: add verbose flag")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/testing/selftests/net/rtnetlink.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index 5f2b3f6c0d74..38be9706c45f 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -859,7 +859,7 @@ kci_test_gretap()
>  
>  
>  	run_cmd ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
> -	run_cmd ip -netns "$testns" link set dev $DEV_NS ups
> +	run_cmd ip -netns "$testns" link set dev $DEV_NS up
>  	run_cmd ip -netns "$testns" link del "$DEV_NS"
>  
>  	# test external mode
> -- 
> 2.41.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

