Return-Path: <netdev+bounces-82206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0088CA2A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1418B1C61EA8
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5481C69E;
	Tue, 26 Mar 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qYEHpAGv"
X-Original-To: netdev@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE41C69D
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472599; cv=none; b=Zl25XUaP2XD+YTxbAyYz0lXNdlEBC9SDkGnxdH9sbeEG8cG9UZc9irN64aFC/pEMUiJYm4Mz0PxKtEk5Pdz4GG1iT36bM1AgkguZ0DihGctdlkNhmlr/DtBb2IN9jmprFMx1tzC2NrjyeAB18DrvYvTrK9hlC2xXZmkwxBYijqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472599; c=relaxed/simple;
	bh=TqvAoicy0PYb4UF0R6/Cx1/0SjfPKX1Rg3iR3agHsQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZiCnwHSEwbP65RzTOw5OasYnLbG3TvWyzinZ+sY/fvWlCIkftNWpYHaxgYeWOpWODaoXsjPYd29sqJ1jKbJ02ann9WSGA2g/zve1z3/NuJUvUnqzMBtkCbTaV0TscaNeheNxACq1/lCWhU1OQzP6mb+Yq/ZHiLkUVliUayxxTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=qYEHpAGv; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id ocRrr2XbIl9dRpAChrWPR9; Tue, 26 Mar 2024 17:03:16 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pACbrMu8NQufZpACbraRnx; Tue, 26 Mar 2024 17:03:10 +0000
X-Authority-Analysis: v=2.4 cv=eK4Vjmp1 c=1 sm=1 tr=0 ts=6602ffce
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=WFmGiULL8WMXhObYpVMA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rFF3IEv1pQkVliIlfBa5Tw/0KDEQACYRpeKK2HhiYeY=; b=qYEHpAGvILy9Vl9Ea56ZcsQpyp
	5d1O12jQAdIGi1w7Xrqw62FzGswWZxmT2PVF7Csv1Oaic02tq+Dw5jWbGdtwDxpW6AMjzrjMDzdIX
	+6cEfQ/fj0fb5N4QLa1Dr0OF9AjqoO1XtiYRC7tQPvv+ThlFXcX7RYWEJ96NGi9E23LEOQe7HnjCw
	y7f3FAxvRaKtJjlgZjQ9VGjcqg1Xs2BzrBZITc7HE+Z2Gibi25Tk682p5eSQf999TCh1g74rwisUm
	5IQiCmg7p1mPjkPeF5xdwdiVrY4fkoPRbXj2y/mfCPCMglN0D7XXhvQhCdfSISEiJtgHHvPrdZLB+
	dUX4mstA==;
Received: from [201.172.173.147] (port=44416 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpACR-001bkE-26;
	Tue, 26 Mar 2024 12:02:59 -0500
Message-ID: <8d2c9cb1-6f2e-4ad4-a1b7-25e6ae953a65@embeddedor.com>
Date: Tue, 26 Mar 2024 11:02:57 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] compiler_types: add Endianness-dependent
 __counted_by_{le,be}
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Simon Horman <horms@kernel.org>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326164116.645718-1-aleksander.lobakin@intel.com>
 <20240326164116.645718-2-aleksander.lobakin@intel.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240326164116.645718-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpACR-001bkE-26
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:44416
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJAxOMvo5nTJXSd9Qvx+6Rjzcv3Fi9kA2AoVDZOWex6wG1U8lF3W+a2a76Fhf+hOlB+6iSK1hLt8DbSDEyOP3megQkGUCiYwvlNcSEDBu20VpWvUPjTe
 8+V5vDax9w0sVR0gdUdmELuvs7Lqt09baGmMEd91KMO5oTaxhWnqoSkHxN+mnpZZDHNG0AWVOqGhMWt8IPQrs3rxDdl4/2Qs3T4=



On 3/26/24 10:41, Alexander Lobakin wrote:
> Some structures contain flexible arrays at the end and the counter for
> them, but the counter has explicit Endianness and thus __counted_by()
> can't be used directly.
> 
> To increase test coverage for potential problems without breaking
> anything, introduce __counted_by_{le,be}() defined depending on
> platform's Endianness to either __counted_by() when applicable or noop
> otherwise.
> Maybe it would be a good idea to introduce such attributes on compiler
> level if possible, but for now let's stop on what we have.
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

LGTM:

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   Documentation/conf.py          |  2 ++
>   scripts/kernel-doc             |  1 +
>   include/linux/compiler_types.h | 11 +++++++++++
>   3 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index d148f3e8dd57..0c2205d536b3 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -75,6 +75,8 @@ if major >= 3:
>               "__rcu",
>               "__user",
>               "__force",
> +            "__counted_by_le",
> +            "__counted_by_be",
>   
>               # include/linux/compiler_attributes.h:
>               "__alias",
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 967f1abb0edb..1474e95dbe4f 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1143,6 +1143,7 @@ sub dump_struct($$) {
>           $members =~ s/\s*$attribute/ /gi;
>           $members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
>           $members =~ s/\s*__counted_by\s*\([^;]*\)/ /gos;
> +        $members =~ s/\s*__counted_by_(le|be)\s*\([^;]*\)/ /gos;
>           $members =~ s/\s*__packed\s*/ /gos;
>           $members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
>           $members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 2abaa3a825a9..a29ba6ef1e27 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -282,6 +282,17 @@ struct ftrace_likely_data {
>   #define __no_sanitize_or_inline __always_inline
>   #endif
>   
> +/*
> + * Apply __counted_by() when the Endianness matches to increase test coverage.
> + */
> +#ifdef __LITTLE_ENDIAN
> +#define __counted_by_le(member)	__counted_by(member)
> +#define __counted_by_be(member)
> +#else
> +#define __counted_by_le(member)
> +#define __counted_by_be(member)	__counted_by(member)
> +#endif
> +
>   /* Do not trap wrapping arithmetic within an annotated function. */
>   #ifdef CONFIG_UBSAN_SIGNED_WRAP
>   # define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))

