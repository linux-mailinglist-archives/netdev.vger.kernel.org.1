Return-Path: <netdev+bounces-107933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B091D134
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 12:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B271F21202
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EDF12F5A1;
	Sun, 30 Jun 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYIUnDHO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335312AAC6
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719744197; cv=none; b=Sve5k4dCE46jqJnjd4iU4i89ZPNXywGQWjPzjn9Th/t1xt6ZqcD7yBlC1FFozWkRlxVrG0ON7FOJeaCpbGrBzQPHhYii3E+v/stwecuT/8jIO0PpNGvWATq9RqMmborIqE/SCfkK4Y2LycpqtNUVe5NAzXVV3hZkPj4/PpZyQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719744197; c=relaxed/simple;
	bh=XJcuvq6R+WfJ7EQe0Ozbv/fhZsy0aZQgFsFF9zgepIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcbkNmNoxTI+JW47T9IuV1oDZTeJUNu9SkF7yCN4HhaxsvVY24a0iIJ0hzX7Gg73d6tEUR5/xs4qSc1UoJmA15jS7RUFjRJ5SFfZlTz2Wncdz9oXCWkNeFW7LZF+PBOQf60RyK1eV1bgxpiOR8y/f/rJd7cNtsS0FLbR2Q14YeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYIUnDHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6597DC2BD10;
	Sun, 30 Jun 2024 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719744196;
	bh=XJcuvq6R+WfJ7EQe0Ozbv/fhZsy0aZQgFsFF9zgepIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYIUnDHOKGNgtDhy0lcyAD10FLnm/usIw4RV+3qA4XF3Hlglm7i2iqpgBELxb9oXq
	 UtbPPzomzupwFXGh85ks4yesG9Tdfb8J83ZDUQ0sy5UgtNxHnCx9QKqCxJk28AE379
	 LFlwlk38Ic9Kx1EgwE+FqMfnONc0wJY4joxVMIx/9FKiwDcE+y1y2nq5jUapxkNFTx
	 8NJmJ0AMCM3DMp7SgRIdz4ynd98xuluHWHZ2XS9YpZ7sXhjy9I/rK4z6Wfbb34/Dog
	 xM1InugoAJ4AyU5FQwMc9Fjt/uTKODgSAfk8KpPGZrTvEnmcFIr1YKERtvkzeGI1un
	 NxNnxsuTQ43Og==
Date: Sun, 30 Jun 2024 13:43:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH ipsec] xfrm: Export symbol xfrm_dev_state_delete.
Message-ID: <20240630104311.GA176465@unreal>
References: <Zn54YVkoA+OOoz+C@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn54YVkoA+OOoz+C@gauss3.secunet.de>

On Fri, Jun 28, 2024 at 10:46:25AM +0200, Steffen Klassert wrote:
> This fixes a build failure if xfrm_user is build as a module.
> 
> Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> ---
>  net/xfrm/xfrm_state.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks,
Tested-by: Leon Romanovsky <leonro@nvidia.com>

