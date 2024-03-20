Return-Path: <netdev+bounces-80778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE4C8810B8
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3B31F22907
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841BB3FBBE;
	Wed, 20 Mar 2024 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/9E9ASe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D733FB93;
	Wed, 20 Mar 2024 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933396; cv=none; b=S6Y8urwzZ7kKU945Y5y36FmEfeu/yTGoFuex5F5BJMKPGosKej9WqvmWzAT+GQ2Nc07OcK+5xDvNTrCEpf3wFV9oA0w9uqRYSwUGne7NYk3YRXHingPrSLBBfMyGgAuM9LUlY7JdF/pnUVNAqIgpwpFIVysdzfTUsq0AaFW2VVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933396; c=relaxed/simple;
	bh=3GWao16JQPEam6Tw7RDDRtOVJEBf3YCZKTTgrhUbwj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKZWOFkftXG4FzajkP/jBfjkKetbHvd46CfA6jWMkHCUE6djfTfTCStpbui6X0flplR3Jf9qKiR83TkGJJCWYH4kABgnWbeEp5VdI6uhn170KIl1xuXyF7PaWkYdnrYM4SBExC9vOsENbuvnEyZzHolUFLRpieunim0NiA2IO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/9E9ASe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927B3C433C7;
	Wed, 20 Mar 2024 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710933395;
	bh=3GWao16JQPEam6Tw7RDDRtOVJEBf3YCZKTTgrhUbwj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/9E9ASeX2YKwy65WAwaSyMzYAQfqaHlfYMoJPRNRy7w1xO6artqIz5QegmfaMa3Z
	 ZstAUCdTLMSjcOg12nrTblNJ6wpMsNps2ShFqEWjM4Q8ZcewGF8RJhUXfLrSopLS24
	 RxmrdxOE9DktW6Sng8pkvyJc5Pu/Ojvnt4rT8Ip+F3L0XHsC6PzFmRDk+yL3yEYA/2
	 81jUPqwLZFmrluaYcpD5hljNq5jgzdkW4Hd6s+6wlZzXUKdDAehjshGhePrpwKo4Uk
	 HPxvei9l+zwAbl7i+w+I8ZXElK9Cj+wD6GqMqHBlyfDojurUIgUgbBrlcM7npMsu4I
	 pi8xXOqYmRbtg==
Date: Wed, 20 Mar 2024 11:16:31 +0000
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, corbet@lwn.net,
	bagasdotme@gmail.com, linux-doc@vger.kernel.org,
	brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH v2 net] ionic: update documentation for XDP support
Message-ID: <20240320111631.GQ185808@kernel.org>
References: <20240319163534.38796-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319163534.38796-1-shannon.nelson@amd.com>

On Tue, Mar 19, 2024 at 09:35:34AM -0700, Shannon Nelson wrote:
> Add information to our documentation for the XDP features
> and related ethtool stats.
> 
> While we're here, we also add the missing timestamp stats.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


