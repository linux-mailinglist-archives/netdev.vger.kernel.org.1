Return-Path: <netdev+bounces-233396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82343C12B64
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1EA1AA2617
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6A927E054;
	Tue, 28 Oct 2025 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XC17BuFm"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D226F467;
	Tue, 28 Oct 2025 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620540; cv=none; b=U5vH8miH+DQ9X65OFdBQ3gzbDmElnJBk/VVbzuU/+pqv/ayGRsrsVFgJJOjUfIFR0OaWdAtJg5SsPAcYtboYhES6sxXckGQzpJ/bnab6mhEU2vL+wbAKNy2aqVUzkfs1XmikCYmbnybiJcde2w0+/7Kg6YbpCuN1XIbsSxUmLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620540; c=relaxed/simple;
	bh=ZQvNvNTgIwMz/0FhMCjULlM0zgfyRaaWlEr/sbPqaMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGVhh+lYBj/bGrsGvvwRHwHmZZDyMC0KDWwdpHwbHwv9HqcSBMfSTJVJV5azsyaimxqKufwTaRKZC+2Oq3t940umWGKnRj8bP7U8Tbq1UVztBouOoo6Z3C9DOX7GUXe7/6r6bL8ffzRC8jcs7jnjt1o0Hx7xm+I+MA7R5HC4S9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XC17BuFm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=vWvbvzXPBIraqYix7+1Mi54hoYzhCyJjY4HTqAgKOFw=; b=XC17BuFmxPDBXG8nygR44WPUxI
	RaJ5rRt5MDg/kkiVDGr31fmRfwJRciCkIz2qvVD7PFhIRzFM0ZnJBkm2NqAa1wSrBl3FYny7nOgjp
	YM9W+qtu9kzFcYyykaT4dtTAraJOphyKZLnm7ijZMJL1kJ/WJgCTttiae/1fysV0F8RpzVWaNxQwh
	eqD0Pz5NMD7crtKlTvS3lzBwyB6wcyX2hp+Dibjkb83eHqLdsjEsCIlRORVhWI5pTLMKup82ns2kU
	gIRcF9sH3h2R+09hvYFJqn5XoEbL68a/t4+Rb/sMmySt8MZB1nvbqluGgZ/bcbTY+2gD8Z4cojv8j
	6Ni55h4Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDZyR-0000000F8ql-1m7j;
	Tue, 28 Oct 2025 03:02:15 +0000
Message-ID: <67b64046-1420-43da-9b35-a40959ab1e62@infradead.org>
Date: Mon, 27 Oct 2025 20:02:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] Documentation: ARCnet: Update obsolete
 contact info
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Avery Pennarun <apenwarr@worldvisions.ca>
References: <20251028014451.10521-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251028014451.10521-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/25 6:44 PM, Bagas Sanjaya wrote:
> ARCnet docs states that inquiries on the subsystem should be emailed to
> Avery Pennarun <apenwarr@worldvisions.ca>, for whom has been in CREDITS
> since the beginning of kernel git history and her email address is
> unreachable (bounce). The subsystem is now maintained by Michael
> Grzeschik since c38f6ac74c9980 ("MAINTAINERS: add arcnet and take
> maintainership").
> 
> In addition, there used to be a dedicated ARCnet mailing list but its
> archive at epistolary.org has been shut down. ARCnet discussion nowadays
> take place in netdev list. The arcnet.com domain mentioned has become
> AIoT (Artificial Intelligence of Things) related Typeform page and
> ARCnet info now resides on arcnet.cc (ARCnet Resource Center) instead.
> 
> Update contact information.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> Changes since v2 [1]:
> 
>   * Update ARCnet info link (Randy)
> 
> [1]: https://lore.kernel.org/linux-doc/20251023025506.23779-1-bagasdotme@gmail.com/
> 
>  Documentation/networking/arcnet-hardware.rst | 22 ++++-----
>  Documentation/networking/arcnet.rst          | 48 +++++---------------
>  2 files changed, 21 insertions(+), 49 deletions(-)

-- 
~Randy

