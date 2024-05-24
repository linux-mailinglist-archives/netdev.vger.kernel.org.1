Return-Path: <netdev+bounces-98046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A9F8CEC48
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 00:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C2F282A28
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 22:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE1F8595B;
	Fri, 24 May 2024 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LXeKuu8v"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045522334
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716588317; cv=none; b=DpsfYXbNhAoteAmy2nut1NSACJR0PmASRFotxR5bph4ltpo9LHyFxeAsEgqvbCseUHqJWeHWpFJl04Od3fTIiMeES+OKL0wRQtlnOR1NZuJUb3ZDybIBJ1HZkJy9fEDQxBDlWq44MHv/fSnotRW1IRtp6WpyEI86udt5quI7l1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716588317; c=relaxed/simple;
	bh=vMs4YOFyURRUecmo+heZ0QP1vl0nQXNhHlhE/KbRYOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TO4xWc0YR7Wz0clXiO+rXe9e05BnFvxGPKktsK1b/9L2e30lcZqwp1YpQvlph3iKSFNldZT2/u1LHxKLLmm6m5Da1usHONO3NRyE2+n/XhF1MM+XMFBcTFd0J0wuS+VMdsZOZCNq5pdD4GMs9GuC4Csn6q9GZ7Kz11OVPK5AWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LXeKuu8v; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: daniel@iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716588309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBTv/qqIYfqBTTKh2uCV1BhEjT7Zq6TCkav6UKyskPU=;
	b=LXeKuu8vM3N0Ll/buFd5U2uLqOjsYVaN/0eKYWhPJkbUwVK950uDsZfuRQ8q8dibcqCkM8
	TOSQjGDyZdz9dG/KjI9IcgOyvi1Y/t5vKW+uvbusNQl/zRGHTdlBXE1sUsMb5EVsWmaBF0
	iCea4cjUHduqNwfj4Kwt+h8NYM7AEag=
X-Envelope-To: razor@blackwall.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <31b97318-38fc-4540-a4a9-201c619c4412@linux.dev>
Date: Fri, 24 May 2024 15:05:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Add netkit test for pkt_type
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: razor@blackwall.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240524163619.26001-1-daniel@iogearbox.net>
 <20240524163619.26001-4-daniel@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240524163619.26001-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/24/24 9:36 AM, Daniel Borkmann wrote:
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
> index 992400acb957..b64fcb70ef2f 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_link.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
> @@ -4,6 +4,7 @@
>   
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
> +#include <linux/if_packet.h>

The set looks good.

A minor thing is that I am hitting this compilation issue in my environment:

In file included from progs/test_tc_link.c:7:
In file included from /usr/include/linux/if_packet.h:5:
In file included from /usr/include/asm/byteorder.h:5:
In file included from /usr/include/linux/byteorder/little_endian.h:13:
/usr/include/linux/swab.h:136:8: error: unknown type name '__always_inline'
   136 | static __always_inline unsigned long __swab(const unsigned long y)
       |        ^

Adding '#include <linux/stddef.h>' solved it. If the addition is fine, this can 
be adjusted before landing.

