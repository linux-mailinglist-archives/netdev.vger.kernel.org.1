Return-Path: <netdev+bounces-128975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066497CB14
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 16:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29E51C213F8
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8754A199944;
	Thu, 19 Sep 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5QEVx66"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A719470
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756715; cv=none; b=lh42jgpkHX2wN9xWc2Vni1AO+pe6EMYPY8nZgq+qR46pThLlOdWfR8AfXlaVVCqhZ2kF8vuZfA4QlWh7GWddoED+sr/P5qqEpzHPxLFq5m2LN28mPc4UmzVMEIzTNI7fHHwYBMFtmpYsEFNeFIacOmgpfmHOLZJVW4yKBO6NMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756715; c=relaxed/simple;
	bh=7kLaRkbVXrhFA7xlLTrLljp4v9ALoherEi9XCAAFivE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OH50Nb7xgVc7DN5yj9UdjAwldfD1YRPowP73yR9rV6rcmYHgApIJ9NlPiIu8IzutgcJZd2z/t7Nq0GDO+vyc3cguE4HLcGzi2PakN1bvVoc2TRR2Uql8oXrGMfZsgGk3dIY3aAhGzNz87KWRfDQMu1cP4ZBeQcOQMQxyjqUoZ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5QEVx66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3F0C4CEC4;
	Thu, 19 Sep 2024 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726756714;
	bh=7kLaRkbVXrhFA7xlLTrLljp4v9ALoherEi9XCAAFivE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5QEVx66qwrvtt7FyBG1oTNZFIoKLB5E5s6zHGftmXZIPKbHMkGef92QgFhO5yWpP
	 4/8/+H8X6eWHPcEZMhLugLZpKSEYmJ/UtBqvB06W16cNntTtguVhiVWGXWyAHqEsIU
	 oHg4dR2qvTvm17374bptZxbVVSIzL11eJAtiZlFtt253aG2D8n2HvaDlIAZKCCBmNI
	 G5N1fBMriSKyE3pYpRSgQTv7Xz37kSAjHDZGhZS/FtnOH+YaPgqP1QH1VRhdkGQ4+U
	 YtH1GXimyvgEOLXWC3/3QagUuPzcp/kMwwU97pF6oCbVkPeOnk6tYuzJtqzkhBEpSS
	 yCX2XlQBZaIlg==
Date: Thu, 19 Sep 2024 15:38:31 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com
Subject: Re: [PATCH ipsec] xfrm: policy: remove last remnants of pernet
 inexact list
Message-ID: <20240919143831.GE1571683@kernel.org>
References: <20240918091251.21202-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918091251.21202-1-fw@strlen.de>

On Wed, Sep 18, 2024 at 11:12:49AM +0200, Florian Westphal wrote:
> xfrm_net still contained the no-longer-used inexact policy list heads,
> remove them.
> 
> Fixes: a54ad727f745 ("xfrm: policy: remove remaining use of inexact list")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Hi Florian,

I am wondering if this is intended for ipsec-next rather than ipsec.
As I see build failures, due to other instances of policy_inexact
when it is applied to the latter but not the former.

