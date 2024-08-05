Return-Path: <netdev+bounces-115784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E7947C3F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270C51F233A0
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0CA6E2AE;
	Mon,  5 Aug 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjah7TDD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A653482FA
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866048; cv=none; b=LHqURusO2oigPmRgRc7l5WG4ik98E6iTnmhDCO3jpVL5m0W3Ty5QvBfPHzk7i/HdAzcLpIahH/NrlN6ZTcUZSG46qsThCn5UrgDumH04mDXj1hkCs/ZgZO+eYPqVz7dQeJCn2gbo9QlClvTSKQRrP8ID/KTl2s/ygiFiQaA3ODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866048; c=relaxed/simple;
	bh=ChXD4Tz4RAM9/Jx3G8Br4Jm5SKUDxc5d7INkoi7+YjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly/Migg4ahoXd+VsvLlwWYhaC7R6gnKtsywu3iumBhXQ7yIOEJz11g29snxQXy6gNYAQP1iH9D6FUgmd7wQCrQYSqxiQWL8gW3CTAtj4FQ0W6nYJBazf0bP66zWkdJjUjpqmKeX+W3vft3HLqsZ4+Rw9CoDcXrCsalq4bNlhgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjah7TDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A880C32782;
	Mon,  5 Aug 2024 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722866048;
	bh=ChXD4Tz4RAM9/Jx3G8Br4Jm5SKUDxc5d7INkoi7+YjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjah7TDDvqWJatP8SWYBjX3Z1dRZclo/qBF34GbmFC1qCVpVtgsxkELV3AsrNaSCX
	 FQ4zyWczy607pFWql9CvVzuycKRWUEFQvYLOWPRCWpQJNOGKtcwZ026bSy5p5boI5o
	 Vn5eMzvCgeSm9TdkKOPMfKkV4Vi0egr95Bs7YoggNV3N/tNeWzbhssLwfeo3QOWKbm
	 whWfOQvgWqEsrGnyno2J5U88V9B+a666teRJpDkawgBsm2zF/BsdAAxBFAIlap25zZ
	 WkvMRvJJhRoKiMksZm2vl6s3i3xxjhx8dAGaGY+i0R4tw4lHuicBRtEXze2zvBkrFz
	 lxcYYtUm2CwoA==
Date: Mon, 5 Aug 2024 14:54:04 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/5] inet6: constify 'struct net' parameter of
 various lookup helpers
Message-ID: <20240805135404.GE2636630@kernel.org>
References: <20240802134029.3748005-1-edumazet@google.com>
 <20240802134029.3748005-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802134029.3748005-5-edumazet@google.com>

On Fri, Aug 02, 2024 at 01:40:28PM +0000, Eric Dumazet wrote:
> Following helpers do not touch their struct net argument:
> 
> - bpf_sk_lookup_run_v6()
> - __inet6_lookup_established()
> - inet6_lookup_reuseport()
> - inet6_lookup_listener()
> - inet6_lookup_run_sk_lookup()
> - __inet6_lookup()
> - inet6_lookup()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


