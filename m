Return-Path: <netdev+bounces-201044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB7BAE7E8D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9DC1895261
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8821C29A30A;
	Wed, 25 Jun 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+1YpWQV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA42877DC;
	Wed, 25 Jun 2025 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846005; cv=none; b=Ht7QrPQy3KF/t4l36SClyN6KJ2M0QK+89FSYgJtodw8m2nRDLw5w+LDn2f9R8sCJK1FCL9XxW9SVjKcycsvNZs+XTIJMlKNtqWH9kiKfAtWI8VWka7ScRFSdqMcHfOABVQWC+9XWhhAmQUWv53itIWC2js/RWEjua4mIcjjU3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846005; c=relaxed/simple;
	bh=iHMj/RauhcxyZhwOzLGCRfpI3N+TWuE9wlNN6ag6r6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTIN/e6LU84Dm4p6I/117WIQC7A7Es5ilZyo9sIcbXvaDSdMcEWxYZeXQSDF3DJS7wg+dJFHp01avGd+QjBzOEuQ9SD7CzaKzwLVXNYHTU9uX15R2wlgcRhSSMPRTnGnZSm6oKn2xuRId6+ndBT7pEFDxOTd+7WuWCUN9bI1F78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+1YpWQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652E9C4CEEA;
	Wed, 25 Jun 2025 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750846004;
	bh=iHMj/RauhcxyZhwOzLGCRfpI3N+TWuE9wlNN6ag6r6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+1YpWQVK1TxpmJ8DKaSLrMpMOdqxcs6RCQW9niMnnjL9isIbe/4hFTbTMWqgKtVf
	 p2TnutsdT6jaAwsnzQY6F4lqP0Ms6VCn4uZ/9Z+UENqx06xYQ2rbCscrZ8BevnSt2x
	 1xrvS2mr9Quv8o5WdSv6FTfrKuP6gBifxXtl6eLHouDb6mT7ukfFS+J8R3FWhmTQLM
	 bFp3uAvZgpUeWk9O5nt6g8lZ3eLHNy0WJuF1UWyzTEhiNxLDAtzwzqs6SV2bA0RKAN
	 JaU9Z/3OiSSh/8/4+zI5j+jHkajEjK9U5kNxhcHHmGfnI/fMVeNnAo4rzzVPAxixdL
	 Cvbg6DWkpNfIw==
Date: Wed, 25 Jun 2025 11:06:39 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/7] tcp: Drop tcp_splice_state::flags
Message-ID: <20250625100639.GQ1562@horms.kernel.org>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
 <20250624-splice-drop-unused-v1-3-cf641a676d04@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-splice-drop-unused-v1-3-cf641a676d04@rbox.co>

On Tue, Jun 24, 2025 at 11:53:50AM +0200, Michal Luczaj wrote:
> Since skb_splice_bits() does not accept @flags anymore, struct's field
> became unused. Remove it.
> 
> No functional change indented.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Simon Horman <horms@kernel.org>


