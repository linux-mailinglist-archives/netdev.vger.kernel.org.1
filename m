Return-Path: <netdev+bounces-176557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED30A6AC84
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE378A6F68
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB62225403;
	Thu, 20 Mar 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKem9jXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39351D7E41;
	Thu, 20 Mar 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493225; cv=none; b=AZCLPlH4YbyQwow8aMXvSeL3KU1OEwoV8sSwcwK5nUsK1Tk9scufVPKrjaOUArK7nyT180biMOrkvUP8pv3y2y/4WJGylisApTkB1O4YNxQN9V6bu8STXPPK3yeqkkVeR6sZO/zEYJ10oPWs4MusijpAr0vU5UQok8iK22cUZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493225; c=relaxed/simple;
	bh=NfejFgFMJmtw9Ssdd8VUUQ7M8kg22pFWLFzjgaEcklQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+f/ZTXbSOIgv/ldTtdkPL9ID9DREZ0gZl4iE0rmN/J/cVS892KtSbVyBYPGsdaunzYN5cORRzz/WzKX+j0Axs2cXVyc2owT/jtFeLonUJbg83yyDfH18Uf7R7l07Tks/5t8RmMd9268a72upkl+MA8e3VFNca56hPyFvMvUpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKem9jXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E15BC4CEDD;
	Thu, 20 Mar 2025 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742493225;
	bh=NfejFgFMJmtw9Ssdd8VUUQ7M8kg22pFWLFzjgaEcklQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKem9jXcKLxlSu4PNeq3u0UL86FmYQR9hDlXQUOerOBG7tjkc4pE4pZJgvIwtTsMU
	 3qRacCn9NvwfZlPgsYAP+/GuHBVzOkZTueI1W53nPQNc0uisu2G1EswR11n+JRr8Iq
	 vmXkdQ7KO+Yzz45HXByoYn0MyAGt0Ir8ivY+014Ra04uwxRXqVMMApbqjWT3n5NB4H
	 UqRgqy2oOMQ82VbbBKROFIV5kQoTfn+/Cj4ss/mZZvmf8LIseIi1gVjF649YZ8wawa
	 ddhqys6FPf4aGz1LpHDm1q754UM+RShWEYHF5LZ1b/Oq8WG1fN9cNKiL6cKRnpR3Ax
	 5ocLV46oKpULQ==
Date: Thu, 20 Mar 2025 17:53:41 +0000
From: Simon Horman <horms@kernel.org>
To: Yui Washizu <yui.washidu@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, almasrymina@google.com,
	sdf@fomichev.me, linux-doc@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] docs: fix the path of example code and example
 commands for device memory TCP
Message-ID: <20250320175341.GH892515@horms.kernel.org>
References: <20250318061251.775191-1-yui.washidu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318061251.775191-1-yui.washidu@gmail.com>

On Tue, Mar 18, 2025 at 03:12:41PM +0900, Yui Washizu wrote:
> This updates the old path and fixes the description of unavailable options.
> 
> Signed-off-by: Yui Washizu <yui.washidu@gmail.com>

Thanks,

On inspection this patch looks good to me although
I am unaware of the history of the -n and -d options.

I suppose this could have been two patches as it does two things.
But it seems simple enough to me in its current form.

Reviewed-by: Simon Horman <horms@kernel.org>

...

