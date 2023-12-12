Return-Path: <netdev+bounces-56178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376DF80E156
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B911C21674
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC2A15BF;
	Tue, 12 Dec 2023 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw7c8mq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D78B8
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 18:20:45 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce9e897aeaso4440665b3a.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 18:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702347645; x=1702952445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwe4RKacTPP0IG7NhCiDvOFd1abSfQrWA3Ko3lf8lwA=;
        b=Bw7c8mq43C88vsqSnaAX3OTr9onhncVJRl40FCB12Enndi5emg31R5G6CMKo2C1+Xh
         AdxK12VuW4Eql4EA+WBdvE7erUX155eGr55YXDleA3if2/W6REHPf5bQ+aTeKDg06Odd
         T0SIxzh31PUcEkKIjeeuJyaplq1r/LxGstE2+A6F1ebu/9sqNCHh7m1nfsIC1mZeOy6k
         PHCjLLqpss7icFVawhgyPnW9gPdomUPQCCM10zVNa+6TqIyhFoPeiWw4zmhrbxLAgbLm
         F+WZjOk7/JIPge3z8Kv2AoCmVX6WmCfQNBZM7nYyV2nXCWKMv5IcjKl5uo2/dLrlKXuU
         OuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702347645; x=1702952445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwe4RKacTPP0IG7NhCiDvOFd1abSfQrWA3Ko3lf8lwA=;
        b=LTtwjIptdySsP4SrbALXGYThrfcwkMDaOEaYy0hLCA6427HWmhpJV4WKEJQ4NANQhz
         kfrwZbLnOCpGqNmmmSxi/i0mrOWRJfN2JculBRwtW0jI5u4M8CLbsCcljIz/cse0fjx2
         rc3ywCAWdvURSNzhqqWTsdT5Gw4B43yqjr72Sy3Jv5TCksYGmMnNKRV4pMlDuHIoW5Gv
         RLzVyH1CbDfkPEK5aXlYlJjSniqPbQWWlMSjEd/zb5/icxUbyK75YcGMIYQBM+vXpqtl
         hkPXfF/MPu9+wZhToblv69rnrtPkorcdnACDPRo9zNP6Bp/w+qXkD9Gts5G5BnZLiXSP
         0xCw==
X-Gm-Message-State: AOJu0YyZZSIkH/iDMEtC5gCn+Iio2LamsbbV+EiL9oEIjwvcjCkIj+JQ
	/tpyr7KpItxH33wbAlaKGjQ=
X-Google-Smtp-Source: AGHT+IF1egmgGQKqC+DwNi/5vDOZ0NdpIGxcTqGw8ANdm3WMU4E2YqDZuc702gd/WbQJKZXqUMuFBA==
X-Received: by 2002:a05:6a20:5497:b0:18c:331f:3abe with SMTP id i23-20020a056a20549700b0018c331f3abemr7522841pzk.24.1702347644790;
        Mon, 11 Dec 2023 18:20:44 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a4-20020aa78644000000b006ce36ffb0cfsm6964733pfo.33.2023.12.11.18.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:20:44 -0800 (PST)
Date: Tue, 12 Dec 2023 10:20:39 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: thinker.li@gmail.com
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, edumazet@google.com, sinquersw@gmail.com,
	kuifeng@meta.com
Subject: Re: [PATCH net-next v2 2/2] selftests: fib_tests: Add tests for
 toggling between w/ and w/o expires.
Message-ID: <ZXfDd_tzAwDbi66Q@Laptop-X1>
References: <20231208194523.312416-1-thinker.li@gmail.com>
 <20231208194523.312416-3-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208194523.312416-3-thinker.li@gmail.com>

On Fri, Dec 08, 2023 at 11:45:23AM -0800, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Make sure that toggling routes between w/ expires and w/o expires works
> properly with GC list.
> 
> When a route with expires is replaced by a permanent route, the entry
> should be removed from the gc list. When a permanent routes is replaced by
> a temporary route, the new entry should be added to the gc list. The new
> tests check if these basic operators work properly.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 69 +++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> index 66d0db7a2614..a8b4628fd7d2 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -806,10 +806,75 @@ fib6_gc_test()
>  	    ret=0
>  	fi
>  
> -	set +e
> -
>  	log_test $ret 0 "ipv6 route garbage collection"
>  
> +	# Delete permanent routes
> +	for i in $(seq 1 5000); do
> +	    $IP -6 route del 2001:30::$i \
> +		via 2001:10::2 dev dummy_10
> +	done
> +
> +	# Permanent routes
> +	for i in $(seq 1 100); do
> +	    # Expire route after $EXPIRE seconds
> +	    $IP -6 route add 2001:20::$i \
> +		via 2001:10::2 dev dummy_10
> +	done
> +	# Replace with temporary routes
> +	for i in $(seq 1 100); do
> +	    # Expire route after $EXPIRE seconds
> +	    $IP -6 route replace 2001:20::$i \
> +		via 2001:10::2 dev dummy_10 expires $EXPIRE
> +	done
> +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
> +	if [ $N_EXP_SLEEP -ne 100 ]; then
> +	    echo "FAIL: expected 100 routes with expires, got $N_EXP_SLEEP"

Hi,

Here the test failed, but ret is not updated.

> +	fi
> +	sleep $(($EXPIRE * 2 + 1))
> +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
> +	if [ $N_EXP_SLEEP -ne 0 ]; then
> +	    echo "FAIL: expected 0 routes with expires," \
> +		 "got $N_EXP_SLEEP"
> +	    ret=1

Here the ret is updated.

> +	else
> +	    ret=0
> +	fi
> +
> +	log_test $ret 0 "ipv6 route garbage collection (replace with expires)"
> +
> +	PERM_BASE=$($IP -6 route list |grep -v expires|wc -l)
> +	# Temporary routes
> +	for i in $(seq 1 100); do
> +	    # Expire route after $EXPIRE seconds
> +	    $IP -6 route add 2001:20::$i \
> +		via 2001:10::2 dev dummy_10 expires $EXPIRE
> +	done
> +	# Replace with permanent routes
> +	for i in $(seq 1 100); do
> +	    # Expire route after $EXPIRE seconds
> +	    $IP -6 route replace 2001:20::$i \
> +		via 2001:10::2 dev dummy_10
> +	done
> +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
> +	if [ $N_EXP_SLEEP -ne 0 ]; then
> +	    echo "FAIL: expected 0 routes with expires," \
> +		 "got $N_EXP_SLEEP"

Same here.

Thanks
Hangbin
> +	fi
> +	sleep $(($EXPIRE * 2 + 1))
> +	N_EXP_PERM=$($IP -6 route list |grep -v expires|wc -l)
> +	N_EXP_PERM=$(($N_EXP_PERM - $PERM_BASE))
> +	if [ $N_EXP_PERM -ne 100 ]; then
> +	    echo "FAIL: expected 100 permanent routes," \
> +		 "got $N_EXP_PERM"
> +	    ret=1
> +	else
> +	    ret=0
> +	fi
> +
> +	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
> +
> +	set +e
> +
>  	cleanup &> /dev/null
>  }
>  
> -- 
> 2.34.1
> 

