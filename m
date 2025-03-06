Return-Path: <netdev+bounces-172441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA4AA54A93
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BEE169E42
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0792A204698;
	Thu,  6 Mar 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck2/DTgK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF11853
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263771; cv=none; b=q/pxJrPD7DyGTAFJ71j04peSRgv8jwGm+nvgvxUoe/lKKBqm0pKXsZyN0Y6CKp7Z8NvRoyUcTjOXK/4ADB06zV1z3knBFYIRU6BNnXa7e4EujBzeQ4jcpaOEMEJH7k1SQIzHkgnJUoZydPtqXlZd9uV2q2O9juH6MDMdFdH8Os8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263771; c=relaxed/simple;
	bh=BfmQmC2EGoHBukRn0uAgmeFmGOKLYU1vnbHp1Ih28nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtQUzJClo2fEjols950rLc6Du6HH4pCACp87JSv7MbQUrQzmwlz+jCTWYsYNGZsHdglIImQb490NIvw/D4joz2lnepsC3rW+qV5O+4BuajkgreA9ExeH2ZsWlIKYFzXn5q03rxk5z66d++qYDL7vNYKIHH8zEWi/Co4MHS+rZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck2/DTgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB4AC4CEE2;
	Thu,  6 Mar 2025 12:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741263771;
	bh=BfmQmC2EGoHBukRn0uAgmeFmGOKLYU1vnbHp1Ih28nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ck2/DTgKB58Y8hCpofdHbe+gcaQyHMSN1DhKmR9TNHt2hZN66EH3FbvNfYpki9MW/
	 edlO/rM9fKEj43LBGqUbMoolSSOl0pJZ36q5BaTxvsDTARnG4A5BcVH/tJUh/osFaE
	 BZfuEigiENjOQz7NlPFvuB6REplVdDZlgNAtlSYjgWZhVnrNrq1qn1C3V5ua0QwCVM
	 p8Tt1xYZS4RF21tfA++RrlJ4QuTmjDfmBObfKtOqiOl/x2qRIzyXCCdhgrvwhU16Y0
	 At7mOU3aslzzL2yzuEzuhylIaVHiPHfnA30IrNE8U/8Rsz1LPM7mW1pAfBdxw2qhq7
	 4JxpnQ7VtnUdA==
Date: Thu, 6 Mar 2025 12:22:48 +0000
From: Simon Horman <horms@kernel.org>
To: Janik Haag <janik@aq0.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: fix typo
Message-ID: <20250306122248.GA3666230@kernel.org>
References: <20250304181651.1123778-2-janik@aq0.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304181651.1123778-2-janik@aq0.de>

On Tue, Mar 04, 2025 at 07:16:52PM +0100, Janik Haag wrote:
> Dear Linux maintainers, this is my first patch, hope everything is
> correct.
> 
> While reading through some pcie realted code I notice this small
> spelling mistake of doorbell registers.
> I added Dave in the TO field since they signed-off on by far the most
> commits touching this file.
> 
> With kind regards,
> Janik Haag
> 
> Signed-off-by: Janik Haag <janik@aq0.de>
> ---
>  drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Jainik,

Thanks for your patch.
It looks good, but I think we can make it better.


Firstly, it's normal practice to describe your patch in the patch
description, which is the bit above the scissors ("---") and add any notes
below. Something like this.

  Subject: net: liquidio: fix typo

  Correct spelling of doorbells.

  Found by inspection

  Signed-of-by: ...
  ---

  Dear Linux Maintainers,

  ...

Secondly, as this is a non-bug-fix for Networking code it is for the
net-next tree. It is preferable to note that net-next is the target
tree in the subject, like this:

  Subject: [PATCH net-next] net: liquidio: fix typo

Last, I do see that codespell flags some other spelling errors in
this file: "corressponding", "cant", and "Fomat".
Perhaps they can be fixed at the same time?


Could you consider posting a v2 patch, as a new thread, which
addresses the above? The subject should be something like this:

  Subject: [PATCH net-next v2] net: liquidio: fix typo

As an aside, the b4 tool can be helpful for managing patch revisions.

More information on Netdev process can be found here;
https://docs.kernel.org/process/maintainer-netdev.html

...

-- 
pw-bot: changes-requested

