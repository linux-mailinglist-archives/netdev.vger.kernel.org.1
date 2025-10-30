Return-Path: <netdev+bounces-234495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1D4C21C64
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 19:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3B8188A84E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C748C2E62D0;
	Thu, 30 Oct 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nxGbq1Hs"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561C36CA89;
	Thu, 30 Oct 2025 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849090; cv=none; b=Kv21mihaKna5rCnF+OGvyI7z4v1czfVy5L696POMb5G5vnT/RwBXVGG+NdEMt19IrMh1pwtYQzd2xFXfASp+Udf8/IR8u7JTYXsvjw640nIKM/JI0Z+BwU8/lIqADUnea/hMx+9qOPeZubvK4AmKllvhBybz1CyXsJi6FAPCguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849090; c=relaxed/simple;
	bh=uin4RI4/pIOxXnnoD2ASnp5Z81AsKTxkLGQnh2WoqJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/XQsy9R0F3k0hpybKeL4fugfCb5d2ndw/5gDbBaifMpGqbaUA1cCGSOZYDglbUpWg9KJoX6Drn/1R2A+M56ScqWeIYx1zPRg9CldE/XnyFvfcmB5kjl0zkIZzwX4RI9o+v/6egVU/RWdkRiiQGpxlHtstIm+bJeJe67xHpMvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nxGbq1Hs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XJhc0WlpDBfeauiKFBCI1q6BfUgIV5i0Qbnqf5nRY2M=; b=nxGbq1HsGT0XCYnL6qtbLHSUDz
	VXpTWF6LDrZUQ71huQqAAGCcAITZuZrUp0vmeIlA5ax8nLbfveGpQOfatQK9Lu9OKiqj6C9uP7+x5
	0OvzasZXh77sMLy9hVdgmhu5W9edveKZC4Ll6L79O92CWUFSBdV4ODXE2mNCToFyZnwE4fbHiVPLD
	l/sDnYxvWp5pKz6QTYeYl2+x3WOhPOVjQvczgPz0AYaJWdg91Fh2ZtNjtmt8w0rYgOmOa1VNEh1qf
	15fe4dyvdZH+5EPfN0/ikGq7aJfFDfYIBx54LEGyVmT/RDwb2W4G1UBdYwPR3anNoLfYvejl+fvj1
	gmPf5qDQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEXQj-00000004c4K-310B;
	Thu, 30 Oct 2025 18:31:25 +0000
Message-ID: <8a7a5d0b-792a-4fb1-92dd-89734c85458e@infradead.org>
Date: Thu, 30 Oct 2025 11:31:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] Documentation: netconsole: Separate literal
 code blocks for full and short netcat command name versions
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20251030075013.40418-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251030075013.40418-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/25 12:50 AM, Bagas Sanjaya wrote:
> Both full and short (abbreviated) command name versions of netcat
> example are combined in single literal code block due to 'or::'
> paragraph being indented one more space than the preceding paragraph
> (before the short version example).
> 
> Unindent it to separate the versions.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

again.

> ---
> Changes since v1 [1]:
> 
>   - Apply proofreading suggestions on patch title and description (Randy)
> 
> [1]: https://lore.kernel.org/linux-doc/20251029015940.10350-1-bagasdotme@gmail.com/
> 
>  Documentation/networking/netconsole.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> index 59cb9982afe60a..0816ce64dcfd68 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -91,7 +91,7 @@ for example:
>  
>  	nc -u -l -p <port>' / 'nc -u -l <port>
>  
> -    or::
> +   or::
>  
>  	netcat -u -l -p <port>' / 'netcat -u -l <port>
>  
> 
> base-commit: 1bae0fd90077875b6c9c853245189032cbf019f7

-- 
~Randy

