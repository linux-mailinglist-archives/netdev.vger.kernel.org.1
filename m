Return-Path: <netdev+bounces-233294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A6C111C5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE0A19A2882
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA9E32D0E1;
	Mon, 27 Oct 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX+RUkwW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6823326D57;
	Mon, 27 Oct 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593338; cv=none; b=VNfS4bAzPnoSyCyqRxB4RH/1CBj5epd76Qkv47UUzpPyEf5T5p6FJX9/LzPRy7cevFPO6lRNvrhzOiUcHqnoAjjZXXXIQu7d9og3ZY3YoZ2CWQTUTDaQE25fGft+4obj2jZmecoMWxpZ3q0N0Gq+10BjtODaXukJnrT6VYBc6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593338; c=relaxed/simple;
	bh=PRLEO0PLw/2N3Sj62GQO8zt0wY56DYEiftlRB80ZRtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1JNydZ6lZ5iwvpvJDN5MFUhbpGnyqAlSLMbt1vo/XnmTFUQDy5IyGvJgUotBSd5FVG6k2tfv6mEpLPmQHilda5pEGkY7NBtt9UO2QyJEO5FYBpwff03aQH+WDqlXtwE9wHFj2/mehc2Y70KBJUFzdVJPfwW/14mwmD+Ae2wXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX+RUkwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0106CC4CEF1;
	Mon, 27 Oct 2025 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593338;
	bh=PRLEO0PLw/2N3Sj62GQO8zt0wY56DYEiftlRB80ZRtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rX+RUkwWAroJxG71ukLZJgw8N1y8a2TahXJhsSMjF7ECJIOU3VD5Kaj85D18HA33p
	 cM0RSgAQCvN2qj6JMtqNDIvEjt4euJIoE+ra/g5DAoU5YDRze8q1APKcaxhy489y6C
	 znaR5FS9uyFdodKMZNXdt/tXQYEPYrGrBsMDHSMjD4+nZ5H/zarWT78sW222sxrMIW
	 +g5yeW5B8UnjJTd6l8KkFyqyoyjbSSS4L/3rXRNf2ca7ZIU0JoWlhfZDSD0ZqX+iWu
	 ekPrNsi7iePkhzqSRExidEucBcMetRnjQYL52Rz/QsHjjUJiWZ7qwhCCI9oyeMgcD/
	 f+Clf+ndTOA5g==
Date: Mon, 27 Oct 2025 19:28:55 +0000
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Karsten Keil <isdn@linux-pingi.de>
Subject: Re: [PATCH net] MAINTAINERS: mark ISDN subsystem as orphan
Message-ID: <aP_H935zm6YwW997@horms.kernel.org>
References: <20251023092406.56699-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023092406.56699-1-bagasdotme@gmail.com>

On Thu, Oct 23, 2025 at 04:24:06PM +0700, Bagas Sanjaya wrote:
> We have not heard any activities from Karsten in years:
> 
>   - Last review tag was nine years ago in commit a921e9bd4e22a7
>     ("isdn: i4l: move active-isdn drivers to staging")
>   - Last message on lore was in October 2020 [1].
> 
> Furthermore, messages to isdn mailing list bounce.
> 
> Mark the subsystem as orphan to reflect these.
> 
> [1]: https://lore.kernel.org/all/0ee243a9-9937-ad26-0684-44b18e772662@linux-pingi.de/
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> netdev maintainers: I have sent request message to Karsten off-list prior to
> sending this patch. Please hold off applying it until a week later when I
> will inform whether he responds or not.

FTR, I checked the information in the commit message,
and my searches match what is written above.

I agree waiting a week is a good plan.

Reviewed-by: Simon Horman <horms@kernel.org>


