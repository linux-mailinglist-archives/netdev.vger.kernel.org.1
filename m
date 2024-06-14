Return-Path: <netdev+bounces-103646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2807C908E3A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39E328D6AF
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E1916D31C;
	Fri, 14 Jun 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m+GJT4R1"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851116C438;
	Fri, 14 Jun 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377582; cv=none; b=WyDg/4bfFLcpwsUh+kNuh3cNEkQPymPOJJ/0P/OP5sQsdnz0mk3PuIedBbXz89KtT9AYllnC40lsvPHo2xQp0ENqvTTEg8lrduUhc99jY0hu4Y2yrFjMzfMDl2dIeglIaBfUaJyN9EUIAASviJm8KUShgB/zx1HKm1gn9as/uOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377582; c=relaxed/simple;
	bh=34ohSfG/19qWn2etFbhp9iM+FQgkPY8fkgZFPwCTa0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sg6NSQzEgGUiAummkXLjxRuwo6FqdsO7Llxrg41vr95nxA6xBYa1vskSTXS4kbpIQrFYAN+gzINRYmvIVR2Fecf0mTj7cRYXwFDKC0fZ00LnOEY4qV7Bb3vgp02y44qPR9YI/PKmyQFX8efIbVNmoL9+Jcv8DrxVcM10r4oTrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m+GJT4R1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=TPWeQET4FCKXxDGX1xF4koHOa0ZvF4mNa6FEu8k1Afo=; b=m+GJT4R19N7iFPs+QEnUVDnoI0
	QHj72LwHtAWCxFgRBHh5R2WW82+URvw6y6pjl4wJbX0yFQm22cJ0E7T7bDP6z6a/lvOwppc2+VNSm
	w+JaUFORMm0qz65yJb7Oz6Fl2sBeranqE4qXNYEkkEyjlCtgqcx8HS1NyL+xbDNjw+gcf1VzKemNI
	DxOQXGeSiNbDiCgOsOySVd57JvCi4Zn5P90UxzxH+PfaiL0ZHNjk/Lqjpp5R1ZlQ8qF19Q385AlQK
	XgtjDh1i44L19MjE/6dYtlJOXtc0uV5Vcps5tiLjMeSLhpqKysqVZ8+dPibjtUF7h/gNDP++aYeY1
	iLQOJq9g==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI8VM-000000039lw-476j;
	Fri, 14 Jun 2024 15:06:17 +0000
Message-ID: <cb3613ed-210f-4fd2-bca3-28542c1b961c@infradead.org>
Date: Fri, 14 Jun 2024 08:06:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Remove "ltpc=" from the
 kernel-parameters.txt
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <20240614084633.560069-1-thuth@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240614084633.560069-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/14/24 1:46 AM, Thomas Huth wrote:
> The string "ltpc" cannot be found in the source code anymore. This
> kernel parameter likely belonged to the LocalTalk PC card module
> which has been removed in commit 03dcb90dbf62 ("net: appletalk:
> remove Apple/Farallon LocalTalk PC support"), so we should remove
> it from kernel-parameters.txt now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 423427bf6e49..a9b905bbc8ca 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3184,9 +3184,6 @@
>  			unlikely, in the extreme case this might damage your
>  			hardware.
>  
> -	ltpc=		[NET]
> -			Format: <io>,<irq>,<dma>
> -
>  	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
>  
>  	lsm=lsm1,...,lsmN

-- 
~Randy

