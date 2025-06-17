Return-Path: <netdev+bounces-198765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 945DFADDB29
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 20:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B531942910
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9E2EBB8A;
	Tue, 17 Jun 2025 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWu3tdEW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840942EBB84;
	Tue, 17 Jun 2025 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750183944; cv=none; b=KJKkARFm+Hk0jIlqqrpbnHcgo4uEPyvnSIqSUdeXfzbSICUiIlYQiFdqQ/sUKC1xogKH4ldYx+gGVj2rADXxbJzMRb8JuZn4L0PlXBKEd6mnY+FisxPRFdzSl/IncJgwmJSEn5afvfnAbhAJLY1ei+22BB4yg10PkMCAi7qG9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750183944; c=relaxed/simple;
	bh=PN6qsQoRnaklytAma65XbMxOUtI9t4kJ9UFM3WpYRvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYP5tujQP3naiwg+dJJjjGeRBUUF9XK4nN9v2G+nNN13KLmrCoLl8NhYAiAhPg2uuR7aWjRjuiBw9UGIwTdoDkWpH0sHD3DTYyq5EGriMgUs7GCXU7dW/8MUxUnRXFIkGPT++TGDmpWpvkVjKUbvPoMzZdDZjZbROYNkR/5Muq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWu3tdEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FAEC4CEE3;
	Tue, 17 Jun 2025 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750183944;
	bh=PN6qsQoRnaklytAma65XbMxOUtI9t4kJ9UFM3WpYRvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWu3tdEWJn3GD6RtX+JmPHQoqCmhDQkNGWHkSEf3ZU9o7gbtFkMSIetp98r2MSOVX
	 g/V4+9qr6V1YVaiqTep5UxgAeN2hpYkxTYqJlvrNNwkLWMWVNaZMUw7UEKLKQj0A1H
	 TPiHlCfqjWM5zltG5oxD8pG0vxu4AtQHCjmjiz0sffPhDyiwaIdirNONqh30vMW3jp
	 +mcW+NLDmZmiEnt5T5kHhHIN14ZJmyyn9UeecnRC/sAytC0fIPFZx+zBruSTH7/Vjt
	 NvS1eQhjZRMszEMMSQJz7FyFGQuBognT9E80/cgSMosDrtJK3lsNyfjiYeVGFn60Jn
	 spQIaaSI2UKgA==
Date: Tue, 17 Jun 2025 19:12:19 +0100
From: Simon Horman <horms@kernel.org>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, skhan@linuxfoundation.com,
	jacob.e.keller@intel.com, alok.a.tiwari@oracle.com
Subject: Re: [PATCH v2 2/2] docs: net: clarify sysctl value constraints
Message-ID: <20250617181219.GB2545@horms.kernel.org>
References: <20250614225324.82810-1-abdelrahmanfekry375@gmail.com>
 <20250614225324.82810-3-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614225324.82810-3-abdelrahmanfekry375@gmail.com>

On Sun, Jun 15, 2025 at 01:53:24AM +0300, Abdelrahman Fekry wrote:
> So, i also noticed that some of the parameters represented
> as boolean have no value constrain checks and accept integer
> values due to u8 implementation, so i wrote a note for every
> boolean parameter that have no constrain checks in code. and
> fixed a typo in fmwark instead of fwmark.
> 
> Added notes for 19 confirmed parameters,
> Verified by code inspection and runtime testing.

Please consider using imperative mode in patch descriptions.

> - No changes for v2 in this patch , still waiting to be reviewed.

The text on the line above would fit better along
side the "No change." below the scissors ("---") a few lines below.

> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> ---
> v2:
> - No change.
> v1:
> - Added notes for booleans that accept 0-255 not only 0/1.
>  Documentation/networking/ip-sysctl.rst | 70 ++++++++++++++++++++------
>  1 file changed, 55 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 68778532faa5..38f2981290d6 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -70,6 +70,8 @@ ip_forward_use_pmtu - BOOLEAN
>  
>  	- 0 - disabled
>  	- 1 - enabled
> +
> +	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.

In his review of v1 [*] Jacob said:

  "Hm. In many cases any non-zero value might be interpreted as "enabled" I
   suppose that is simply "undefined behavior"?

Looking over the parsing and use of ip_forward_use_pmtu (I did not check
the other parameters whose documentation this patch updates) I would take
Jacob's remark a few steps further.

It seems to me that values of 0-255 are accepted and while 0 means
disabled, all the other values mean enabled. That is because that
what the code does. And being part of the UAPI it can't be changed.

So I don't think it is correct to describe only values 0/1 having defined
behaviour. Because the code defines behaviour for all the values in the
range 0-255.

[*] https://lore.kernel.org/netdev/8b53b5be-82eb-458c-8269-d296bffcef33@intel.com/

...

