Return-Path: <netdev+bounces-225520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B484B95026
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0063ADAEB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8DA31BCA3;
	Tue, 23 Sep 2025 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9pFyYXU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15ED3191BD;
	Tue, 23 Sep 2025 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616450; cv=none; b=XK+OSXV0Q3zLMuflhm67YjaegmtgM1IJmM6tNfFOSZKHjhwU3zw10+pLznCTZ3UXdKEhr2StTVPTeCj32bjBqahs5XDGA61c61b9zFnrTQi2iYMRc0TFV7gaBHOTytA54ghHK+MSmKDLVoCPs2jtn4OrHjcrTGj3JslfV4J6aQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616450; c=relaxed/simple;
	bh=9+vLcO8ESWufQ4GrLTo49CyYtV2hVVePvmbQggCLtHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXIYsZkR47rud0humS3jDGpfintLfMzzCAxLBWxrv39ew2RIqHtxyqUgdQu19CKkT4a9TY2M20phEI69tadY9hr02P3OHx5jquqCZ2hRK0DbeZmut7dM8+zgzmkeC8uzCxqhK+fQLmHxAoF6iUz7Vkex9WulfWp4X9toRn1TlX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9pFyYXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD77C4CEF5;
	Tue, 23 Sep 2025 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758616450;
	bh=9+vLcO8ESWufQ4GrLTo49CyYtV2hVVePvmbQggCLtHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9pFyYXUPRLvq1d2G3N1CVYu95xNSoUl6HBpq5K1cZ8JoRof0mpK+uDiNCF3Lgblg
	 YiMN/J0arDpEfmSNqVgVqBTIU8j/TYHv9AtvOsxkHPa5TuaeyyVgtQ/oL1jTIeKVRv
	 zvNx0aOOB0+i4mKo42wPX43UAHh0Ku4gPQMTxBvq6xLSJ/e3VhW+L277331k45BmSj
	 IsEEWYSyh9bD63d0RpkN5FqT9zHtk3qT7bv56eUNOydyo1jWwqmkPxayoFHPuMtSBl
	 jqKvSQ/7hcuVuoktQaZEJHGPC229XCr+O7rBvxuzS5uxzgAQZOWuRj1P3ZNKqvRXJj
	 WElY3JdEfPdCA==
Date: Tue, 23 Sep 2025 09:34:06 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux AFS <linux-afs@lists.infradead.org>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next RESEND] Documentation: rxrpc: Demote three
 sections
Message-ID: <20250923083406.GD836419@horms.kernel.org>
References: <20250922124137.5266-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922124137.5266-1-bagasdotme@gmail.com>

On Mon, Sep 22, 2025 at 07:41:37PM +0700, Bagas Sanjaya wrote:
> Three sections ("Socket Options", "Security", and "Example Client Usage")
> use title headings, which increase number of entries in the networking
> docs toctree by three, and also make the rest of sections headed under
> "Example Client Usage".
> 
> Demote these sections back to section headings.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks,

I looked at the output of make htmldocs in a browser. I agree that both
the entries in index.html and the header arrangement in rxrpc.html make
more sense with this change.

Reviewed-by: Simon Horman <horms@kernel.org>

