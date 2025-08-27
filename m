Return-Path: <netdev+bounces-217387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B2FB38817
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447A3462213
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5EB2DFA3C;
	Wed, 27 Aug 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTaDHGE5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765042DCF6E
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313764; cv=none; b=TmNb5/Ox6d//U44M0ncuvWvlPuMzMQNqS1CjNXto4N06Lpmkkiv0jka0JYh0fSlFSLiNWqeGs0GwFnMhbNKMSsIu+1nl8ESCJUoHtVPkDx1Zx0MsBeRqkM4/vL8PKNEjynZ9EqhkPymtbbxmUWdk+96f+e0uvzaOBe0EEgeZEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313764; c=relaxed/simple;
	bh=jYj9qsJSJwplBvtfDmpi+mYrWqDN2gmQxuI9MCXnPXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtMrXR9cXbAAe9bnTBwP4jbLf26DkuYRlcia8HbZP8PBQHk/BVmMqjhJF8LPpdQQ37JCVZmiP3iDWt8vPyVynYoBWQ1Ui4D5D5Exhg0TzUSJy/HXNEgBm0Xw54X6bZqrgZLS9YcvFGWy5rs7j/bcCZ2hVvG18TTIoSC82ngRvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTaDHGE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A424EC4CEEB;
	Wed, 27 Aug 2025 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313764;
	bh=jYj9qsJSJwplBvtfDmpi+mYrWqDN2gmQxuI9MCXnPXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTaDHGE5EiRMl3lcjug5tr6/t2H3MK9E1E9q9ZTyUXqcAv6ko7ginDJR4bo6XD5rw
	 BKYJC1KmoPDMg4fbXB+nkmeQUcat7cq39lKhDlknq7u792TVznI3tljy8NUPpWURsS
	 OKsdTnTQYARWIHtIfuXmHVgtbJq79LqXLw0L7TUKsWM7YTbHzteGLj3ak3MeKihNan
	 9f/MT7wQAkIe9n6PZ+mbUoqmGp4w7M3EvC6hp1L7oFZlvZwC/irnhvdC7YD8LG7Hoq
	 RqlCCyfD+saP1rX8kWb9pOQM5mxBzOsXzqCgHrskSGquS3hzrisJ060hYayvGrFF5v
	 JLWp2y0m/NqaQ==
Date: Wed, 27 Aug 2025 17:56:01 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/13] macsec: use NLA_POLICY_VALIDATE_FN to
 validate IFLA_MACSEC_CIPHER_SUITE
Message-ID: <20250827165601.GL10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <015e43ade9548c7682c9739087eba0853b3a1331.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015e43ade9548c7682c9739087eba0853b3a1331.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:28PM +0200, Sabrina Dubroca wrote:
> Unfortunately, since the value of MACSEC_DEFAULT_CIPHER_ID doesn't fit
> near the others, we can't use a simple range in the policy.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


