Return-Path: <netdev+bounces-124306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7F0968E90
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 21:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17331283729
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F51AB6F3;
	Mon,  2 Sep 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="bRny1xjM"
X-Original-To: netdev@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C355E13CFB7
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725306953; cv=none; b=biCCK8Q+KiGfFpaQApeCnk8GNKZXUqyOwFPNEydWxXdCntLq5J8rydEiX8QD4om/RgNqT7GNenEE8vlv5Chz9KFnHvKVQzCat8P7laoJn2bnwlj9HDsUUDxTyCJgahER1+Af6yIxs5MUW2YWDbKIhf4mrZ0730JJ/WP+pNf7Z9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725306953; c=relaxed/simple;
	bh=4Gl0HPrKQMl+WMydtbAQMHf8HGp50fdjNpDI/SdAZuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAHcf4JxTvJ1Oh+RtkFWFNj0o/GArkD3TW2j3s90zUMsTYydhYcUSzZpUHYunRxskvN0010+lrQBg3/pHY05gdo39KA8954HbgSD5MefXYipFJHv9xuhUgwH/uMeL18WENXqmi5P+h8iCgQt064Z7bUVrhofQCRpDmq2y7XRRfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=bRny1xjM; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id l3qusPGPj1zuHlD9NsZBEF; Mon, 02 Sep 2024 19:55:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id lD9Ms2haVZlJQlD9MsQUq3; Mon, 02 Sep 2024 19:55:44 +0000
X-Authority-Analysis: v=2.4 cv=DMBE4DNb c=1 sm=1 tr=0 ts=66d61840
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=62GdtKjr0Ia7E08erwkA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GhQ01iJSLK8ItBVKt2WxUw/tblsKhoLVEspih28gtqc=; b=bRny1xjMpunawdNKG0yX95lgsl
	jOo3JpFSGkfAHDsF7pyEkh++AQkoIVnB7whs6Cgr+9fQkull+32tyqq+3e2v7k/ro7YkdiPhKPGUO
	QAsPpkA0vBW5aFA8uPjx/kgQuluZ8jN999AiCS4htzyW2f71Ha188kwLBgpr3AoOwPazJNdNj6gfP
	LqxneShjYOBCcqPPvieO8yOJaNdO6HlhwgDTrk5ZysrDonCs7STjOVSnNjvtWjDSSa4BHHIc0+bZx
	NFpe+O3TRRgQFYNwSvs6xen8gzarK2H24b8v+xem8E+Th/4vnogFqOeHyubchzOiqv5CTzOmNh4Ok
	FpbioynA==;
Received: from [201.172.173.139] (port=56798 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1slD9L-0048xZ-0r;
	Mon, 02 Sep 2024 14:55:43 -0500
Message-ID: <88384607-4fcf-4ab1-8edf-9258df0bbf3c@embeddedor.com>
Date: Mon, 2 Sep 2024 13:55:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Consistently use
 ethtool_puts() to copy strings
To: Simon Horman <horms@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20240902-igc-ss-puts-v1-1-c66a73b532c7@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240902-igc-ss-puts-v1-1-c66a73b532c7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1slD9L-0048xZ-0r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:56798
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN13UIXDzW2TvjAo9N7TaoKruCuVYWoi8hruPZSApmFugfV5VdEDltTb199SnTSiueMHM3iI1S8IRqT2I3uvRX7stZ+DsNsAlejunTFoGxg9WxbXYO6a
 2BgiRe5Nxb93St5BHSxuXR7QQbW3wzW8MO7FLPrI/sVwIPzZ2MBbgfVNDPz5xHrvnwYimjEeZGXLz4pT/b7XVLflArQyCKE3nqA=



On 02/09/24 06:46, Simon Horman wrote:
> ethtool_puts() is the preferred method for copying ethtool strings.
> And ethtool_puts() is already used to copy ethtool strings in
> igc_ethtool_get_strings(). With this patch igc_ethtool_get_strings()
> uses it for all such cases.
> 
> In general, the compiler can't use fortification to verify that the
> destination buffer isn't over-run when the destination is the first
> element of an array, and more than one element of the array is to be
> written by memcpy().
> 
> For the ETH_SS_PRIV_FLAGS the problem doesn't manifest as there is only
> one element in the igc_priv_flags_strings array.
> 
> In the ETH_SS_TEST case, there is more than one element of
> igc_gstrings_test, and from the compiler's perspective, that element is
> overrun. In practice it does not overrun the overall size of the array,
> but it is nice to use tooling to help us where possible. In this case
> the problem is flagged as follows.
> 
> Flagged by clang-18 as:
> 
> In file included from drivers/net/ethernet/intel/igc/igc_ethtool.c:5:
> In file included from ./include/linux/if_vlan.h:10:
> In file included from ./include/linux/netdevice.h:24:
> In file included from ./include/linux/timer.h:6:
> In file included from ./include/linux/ktime.h:25:
> In file included from ./include/linux/jiffies.h:10:
> In file included from ./include/linux/time.h:60:
> In file included from ./include/linux/time32.h:13:
> In file included from ./include/linux/timex.h:67:
> In file included from ./arch/x86/include/asm/timex.h:5:
> In file included from ./arch/x86/include/asm/processor.h:19:
> In file included from ./arch/x86/include/asm/cpuid.h:62:
> In file included from ./arch/x86/include/asm/paravirt.h:21:
> In file included from ./include/linux/cpumask.h:12:
> In file included from ./include/linux/bitmap.h:13:
> In file included from ./include/linux/string.h:374:
> .../fortify-string.h:580:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
> 
> And Smatch as:
> 
> .../igc_ethtool.c:771 igc_ethtool_get_strings() error: __builtin_memcpy() '*igc_gstrings_test' too small (32 vs 160)
> 
> Curiously, not flagged by gcc-14.
> 
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 457b5d7f1610..ccace77c6c2d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -768,8 +768,8 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
>   
>   	switch (stringset) {
>   	case ETH_SS_TEST:
> -		memcpy(data, *igc_gstrings_test,
> -		       IGC_TEST_LEN * ETH_GSTRING_LEN);

I think this problem should be solved if we use the array's address,
which in this case is `igc_gstrings_test`, instead of the address of
the first row. So, the above should look as follows:

memcpy(data, igc_gstrings_test, IGC_TEST_LEN * ETH_GSTRING_LEN);

> +		for (i = 0; i < IGC_TEST_LEN; i++)
> +			ethtool_puts(&p, igc_gstrings_test[i]);
>   		break;
>   	case ETH_SS_STATS:
>   		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
> @@ -791,8 +791,8 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
>   		/* BUG_ON(p - data != IGC_STATS_LEN * ETH_GSTRING_LEN); */
>   		break;
>   	case ETH_SS_PRIV_FLAGS:
> -		memcpy(data, igc_priv_flags_strings,
> -		       IGC_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);

In this case, the code is effectively reading from the array's address.

--
Gustavo

