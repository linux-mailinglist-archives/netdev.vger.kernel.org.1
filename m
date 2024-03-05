Return-Path: <netdev+bounces-77558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CC28722F0
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1082D285092
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66398664C;
	Tue,  5 Mar 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZNLwzzF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157C85944
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653098; cv=none; b=FDrSTc0HFAD/flxC1dtG4JEcaTuGcewJIweGYSszg6el5P7KF/6gzlm+D5Xz5fO3GZGG/PTUYfIySaZGWhnC8jQAZSI/SNxr7P/Xqq5BwuTh5e8/EyFNGepwfzVeYDJSGaNuTJr+u6IsIORutJxrUvpJn3OyHZ4PRZ8ZfVTow2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653098; c=relaxed/simple;
	bh=1kuG3QN6V2wP19+yBzVNByTin0cge+IUNACAny+DrmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtAptshxxRWEqWZgDykYpq8gyK6BeokvUEkbh+uiYNdR/yPtuiuxRMJw+fTPB8qoTxNPYxV2SCunPwhUnurCDVx0AQyk2nm7oQyFbtnhHd/urHbIPf4QuZhyjmoaOwEC+w+4WyRwgOHHBIiX6URR6suLDAJZdOTitPJ+CtKz4vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZNLwzzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39C6C433F1;
	Tue,  5 Mar 2024 15:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709653098;
	bh=1kuG3QN6V2wP19+yBzVNByTin0cge+IUNACAny+DrmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uZNLwzzFWsTCbDnj5zeBPammeIPvijAEC0wceOyb6uFPbV4oaBKDnaasoj0PXmy03
	 QgQ0yeZrmfWnDPIlbc7b4M4G/TTNTw4O5aNDXRFQ+S24UcvjLtJBQMeCx1StiUYEvo
	 ChjhkXvSKkrWyMGacp9TcYrpOqPXtXSGnWtA5UK0j5/HAPXWgdisn5RhBulcAe6emS
	 vZaepYxMmYn7OGJYU25ACuIgDe5sZOzyAos4EIVtZSXpwhL4M3F5eT+7snRjH6jEg3
	 OKu6nZaHzPVKgahugEso80Y5QxwWZmf+84r/ddXTCYA1guFmWt+OaxppEBZd4s2aCW
	 3bWrwZL5bN87w==
Message-ID: <99f281b1-76de-4a51-a303-1270ffb03405@kernel.org>
Date: Tue, 5 Mar 2024 08:38:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests/net: fix waiting time for ipv6_gc
 test in fib_tests.sh.
Content-Language: en-US
To: Kui-Feng Lee <thinker.li@gmail.com>, netdev@vger.kernel.org,
 ast@kernel.org, martin.lau@linux.dev, kernel-team@meta.com, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240305013734.872968-1-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240305013734.872968-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 6:37 PM, Kui-Feng Lee wrote:
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> index 3ec1050e47a2..52c5c8730879 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -805,7 +805,7 @@ fib6_gc_test()
>  	    $IP -6 route add 2001:20::$i \
>  		via 2001:10::2 dev dummy_10 expires $EXPIRE
>  	done
> -	sleep $(($EXPIRE * 2 + 1))
> +	sleep $(($EXPIRE * 2 + 2))

define a local variable with the sleep timeout so future updates only
have to update 1 place.



