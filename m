Return-Path: <netdev+bounces-250006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 708DCD224E2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 04:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AADC301E234
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DC426D4C7;
	Thu, 15 Jan 2026 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPF3DOPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77017A303
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768447882; cv=none; b=RqYyUYPh/AUpbhlcyCbMk8Y4vcn93jS1RKQRNTG6Gh3K982hiF+L+OCaBeAmTcNBEmcCQIDmGaypwI3YNR8QAPaoG4C+9nG8VMUIVJ+LIQ2czId0WBoU9u6wCtkLB7enoBsPMgwPZQnJa1b4PSUZZLkCjr2LOZaGU/IWWv34FzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768447882; c=relaxed/simple;
	bh=KKsqBCZCN5nRoNFxlBJc7m/8Cyd5ND1s1FGhengKlfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uw0wTemLy06rolC14dsh7FLXrjJglc68CdimcM9a+TUzpp/G15/2mflimucp2+J0WFb1TrfMUI0AF87RqUU43+Xv9qCA824DM7EoOnjxAuBpWVw16nsvRiMxXl3iTYFtwG+d0ChcWWYXLCAFagCSYpOFx1bCgZzCnaUA9Hkdke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPF3DOPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C70C4CEF7;
	Thu, 15 Jan 2026 03:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768447882;
	bh=KKsqBCZCN5nRoNFxlBJc7m/8Cyd5ND1s1FGhengKlfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UPF3DOPLksCkM30Bqt6K/jd7UsNxhyoEsvVEpyrF9jtHWAWfFm4O8+aNKljVcgOU9
	 W7Si5U/QvRMUU+M9SZmSDxP9SPl9vic2ZN7fqFLYzBb9T73hV8jRm/cXJww9EJQdsq
	 3giydaFa25qGdpoDP0jHT5HEpll09gnM47T/Poa9CQ5mferh32aKaYJNfvETMnAskD
	 I2oZWb4VIQz7LGvL3O5lJeTQLwqG3gHEthebUONf6o/bwIE0N9xJ9FcC65ebI6EJBC
	 R+92UJ4/pnjSFXdHa/V7p8O1NsRe5OSLmPkvWdjeBqjKWiIcsmNw8DOI0tItwwFnwp
	 HJ5QJ7ZgH9cbg==
Date: Wed, 14 Jan 2026 19:31:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2] ethtool: Clarify len/n_stats fields in/out
 semantics
Message-ID: <20260114193121.7366d02d@kernel.org>
In-Reply-To: <e4f56293-34f4-4f1f-a3a2-456c46f25071@nvidia.com>
References: <20260112115708.244752-1-gal@nvidia.com>
	<20260113190652.121a12a6@kernel.org>
	<e4f56293-34f4-4f1f-a3a2-456c46f25071@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 08:50:01 +0200 Gal Pressman wrote:
> On 14/01/2026 5:06, Jakub Kicinski wrote:
> > On Mon, 12 Jan 2026 13:57:08 +0200 Gal Pressman wrote:  
> >> --- a/include/uapi/linux/ethtool.h
> >> +++ b/include/uapi/linux/ethtool.h
> >> @@ -1101,6 +1101,13 @@ enum ethtool_module_fw_flash_status {
> >>   * Users must use %ETHTOOL_GSSET_INFO to find the number of strings in
> >>   * the string set.  They must allocate a buffer of the appropriate
> >>   * size immediately following this structure.
> >> + *
> >> + * Setting @len on input is optional (though preferred), but must be zeroed
> >> + * otherwise.
> >> + * When set, @len will return the requested count if it matches the actual
> >> + * count; otherwise, it will be zero.
> >> + * This prevents issues when the number of strings is different than the
> >> + * userspace allocation.  
> > 
> > Thanks the new text looks good, but we should also remove the 
> > "On return, the " from the field kdoc?  
> 
> I think it makes sense to keep.
> 
> The new text clarifies the in behavior, but the out behavior remains.

I'd interpret the "On return," as an indication that it's an output
only field. Not saying that's an intelligent interpretation, but it's
an existence proof. The uAPI comments should avoid ambiguity...

