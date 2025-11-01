Return-Path: <netdev+bounces-234818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1146C277CC
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 05:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 854B14E075B
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 04:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783B22874E1;
	Sat,  1 Nov 2025 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y2uKnDlv"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45928727C;
	Sat,  1 Nov 2025 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973120; cv=none; b=JZdqTDVUW8jY8GkBBqOvjPg9qHYpEJXXVyezQ++wdbq8K5v84T6LCYmCv+NBjFI9TMFDH/sMaVNFGOLhBP6xlaSHY1r+VDr2LpPXomk9FUFUcJxinRhL/13lhRx+jUuFhoB/DUj+pfPPnExzoB5VLWAXIpEMXvpk6uAqefjDoeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973120; c=relaxed/simple;
	bh=YMs1w9S+H80dm1g+URi47pDI38LAQC0A5TWyQ0U05fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jf73jIVzWqHY7cLohs4sHfwo5Za+WvvDu9L7+B32e0s4aheDF3w7rOBvuMFX7qugIhlOfIGrb0+khNnANhN6EUDbn7WXL4BygIYYA1jkt//VBKr4KJ3uClpzFfFkUPNXIz3JbMJXXpKvcMcIW5y2PBjdCq5R0N7GEgudbDkopmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y2uKnDlv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=SkqFHxTzPtvdZSFHXSFJYdPDfuap8B8//bBnjvhmajM=; b=Y2uKnDlvlwJHFFi+qcE5GqBIW8
	zFAvMdU7D6jyyd3U2slqBFskRL32/F9kUtgG+VdHhhhjZJQ3wmOpu9y6djrmsRalaaDjYAFfUUDpi
	O5GmJfv3FhSk7bzK3OslxhWpjwFLQZqK08v8GSfrYaxmSRZLmWByQ7rlCTUqmFefupiufoAAD2+jG
	MxjzoG3gkQNMLyUZhxR3sy/uqu4/aAAFAg0AAeIOCOF+pADC6tV/VFPmTOamNiTvp7JXSFW+VkqqE
	D62P/+rrthGVMhu0siOVLArp13MoNYlOsF/VVF2X46EUwTGaXfXKUazptwdExG4wEqv9mywwGFnv3
	K5VzB70A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vF3hB-000000075N1-35Rd;
	Sat, 01 Nov 2025 04:58:33 +0000
Message-ID: <7148e00e-14c4-4eb7-a940-112e86902bc2@infradead.org>
Date: Fri, 31 Oct 2025 21:58:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] xfrm docs update
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251029082615.39518-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/25 1:26 AM, Bagas Sanjaya wrote:
> Hi,
> 
> Here are xfrm documentation patches. Patches [1-4/6] are formatting polishing;
> [5/6] groups the docs and [6/6] adds MAINTAINERS entries for them.
> 
> Enjoy!
> 
> Bagas Sanjaya (6):
>   Documentation: xfrm_device: Wrap iproute2 snippets in literal code
>     block
>   Documentation: xfrm_device: Use numbered list for offloading steps
>   Documentation: xfrm_device: Separate hardware offload sublists
>   Documentation: xfrm_sync: Properly reindent list text
>   net: Move XFRM documentation into its own subdirectory
>   MAINTAINERS: Add entry for XFRM documentation

LGTM.  Thanks.

for the series:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

OK, one small nit. 3 of the section headings end with ':'
that should not be there.  See xfrm/index.html:

XFRM Framework
XFRM device - offloading the IPsec computations
  Overview
  Callbacks to implement
  Flow
XFRM proc - /proc/net/xfrm_* files
Transformation Statistics
XFRM sync
  1) Message Structure
  2) TLVS reflect the different parameters:
  3) Default configurations for the parameters:
  4) Message types
  Exceptions to threshold settings
XFRM Syscall
  /proc/sys/net/core/xfrm_* Variables:

Oh, and could/should
  Exceptions to threshold settings
be numbered, 5) ? It looks odd to be unnumbered.

-- 
~Randy

