Return-Path: <netdev+bounces-231970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA8BFF1FB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 06:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54AD24F1734
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 04:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03FE2264C7;
	Thu, 23 Oct 2025 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4Cra+8YC"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0727453;
	Thu, 23 Oct 2025 04:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761194152; cv=none; b=TLNh3AvxG8bRDkungOG1La5cH5FyGP1AhpSdhiL1znSCFR5I1nEEwVHCW7cPnfBaLnXpmuR0iUcYOjJvjuY3JEozabtmPUUesBAlJO9zvKIegyhWVlwSYPiG0dF4jKQrm87vJ3HixSE2KFXJBl+JCbb4xNV4i/fhxCJ2oDr2TmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761194152; c=relaxed/simple;
	bh=bG17bXfu9x6pfWXTp7QTaxcGzZe7c56rlbfTENaRIIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+QJHnTNmR1Y9hrknYixsdcZuJ1NOZDYf8nb0PefSzQfBSDDCXZxttb2iTD5uZvd4vMJBAsxNMSijILvIqLIB9ligon9VWS/1WVsQWwCuekJjK5mOp33Q+gzrzbQRrZ75JZkCum1EUIHpZ7+lxVCP+I95e59CM2+q9R7BqOn2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4Cra+8YC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LJ+B0g7yed2GknCtBTnmSgZYVV2Vt70oFUEIP8qAFxk=; b=4Cra+8YCe2oRoUYv7sff8PKF0M
	xDJkgKc+goYIATxYyaqIDFuf3CT4Z0ORQNVHHzhxHK6tSdeyDcGq3bwo5yk1eIMPeSMZnLymWT38v
	BDIgZ+EKV62CmadTrut/Lnn1K++L7uVUD7VGdLmSSf4X0fNzAqWndJCytNK15uEclRCU71RQxHfYV
	Al7vnSChQMxoK2VfENM5AYXWC/Ul7EieFPzOe0BZvyJL8i60ERNvyIE5GSr/oSLTbc+IYQ/I+NpM8
	UPjjpvZD8wx9kUpn42efdbsJUXAepkua0pB+WqQhxtmqhwDOTbXI3ZqB+MPpJENXyi2Xq/oRwoot8
	FUPedJMw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBn3F-000000052sZ-3BQu;
	Thu, 23 Oct 2025 04:35:49 +0000
Message-ID: <b9863e00-9ae4-4930-af65-12838b07c249@infradead.org>
Date: Wed, 22 Oct 2025 21:35:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: rmnet: Use section heading markup for
 packet format subsections
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: Subash Abhinov Kasiviswanathan
 <subash.a.kasiviswanathan@oss.qualcomm.com>,
 Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20251022025456.19004-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251022025456.19004-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/25 7:54 PM, Bagas Sanjaya wrote:
> Format subsections of "Packet format" section as reST subsections.
> 
> Link: https://lore.kernel.org/linux-doc/aO_MefPIlQQrCU3j@horms.kernel.org/
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Nice, better with these headings.
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

One question to anyone who knows about rmnet: This doc file says:
  Command 1 indicates disabling flow while 2 is enabling flow

and it also says that Bit 0 is the Command bit (or field).
Should the Command bits (field) be larger than one bit?
or is it just 1-based (i.e., 0 means 1 and 1 means 2)?

Thanks.

> ---
> Changes since v1 [1]:
> 
>   - Keep section number letters in lowercase (Jakub)
> 
> [1]: https://lore.kernel.org/linux-doc/20251016092552.27053-1-bagasdotme@gmail.com/
> 
>  .../device_drivers/cellular/qualcomm/rmnet.rst         | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> index 289c146a829153..28753765fba288 100644
> --- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> +++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> @@ -28,6 +28,7 @@ these MAP frames and send them to appropriate PDN's.
>  ================
>  
>  a. MAP packet v1 (data / control)
> +---------------------------------
>  
>  MAP header fields are in big endian format.
>  
> @@ -54,6 +55,7 @@ Payload length includes the padding length but does not include MAP header
>  length.
>  
>  b. Map packet v4 (data / control)
> +---------------------------------
>  
>  MAP header fields are in big endian format.
>  
> @@ -107,6 +109,7 @@ over which checksum is computed.
>  Checksum value, indicates the checksum computed.
>  
>  c. MAP packet v5 (data / control)
> +---------------------------------
>  
>  MAP header fields are in big endian format.
>  
> @@ -134,6 +137,7 @@ Payload length includes the padding length but does not include MAP header
>  length.
>  
>  d. Checksum offload header v5
> +-----------------------------
>  
>  Checksum offload header fields are in big endian format.
>  
> @@ -154,7 +158,10 @@ indicates that the calculated packet checksum is invalid.
>  
>  Reserved bits must be zero when sent and ignored when received.
>  
> -e. MAP packet v1/v5 (command specific)::
> +e. MAP packet v1/v5 (command specific)
> +--------------------------------------
> +
> +Packet format::
>  
>      Bit             0             1         2-7      8 - 15           16 - 31
>      Function   Command         Reserved     Pad   Multiplexer ID    Payload length
> @@ -177,6 +184,7 @@ Command types
>  = ==========================================
>  
>  f. Aggregation
> +--------------
>  
>  Aggregation is multiple MAP packets (can be data or command) delivered to
>  rmnet in a single linear skb. rmnet will process the individual
> 
> base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59

-- 
~Randy

