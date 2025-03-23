Return-Path: <netdev+bounces-176971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D92A6D063
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 18:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53186188A17D
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB515B984;
	Sun, 23 Mar 2025 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2kxYNfq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB15B15A850
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752029; cv=none; b=guYrxivXQwcILngOJ+3cCEUgdRvEjKSVa/Sgkgkt+WpyuN2Uh3r407cZF6pGLE7OIyleLNB3+WfKLMCVYwxEZHZkRbn83ehWCsOz6wHc7MuILBx552fp2Z2Twfl5ZgNcpf6iO8Q9UEmc1nP3zjRA7AZ7yT9u8haqZtFrH8wxoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752029; c=relaxed/simple;
	bh=1/qPBc3coCPvC9EOL5WyLsdFidMIkpko1lYuoYVEzzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUDP5GAZ3tJyLF9sMkzo0+tKIg+3QaS1juOy4dN84F56O8629PPYMgd+BhZQWImZvZsW2dOAu8cyCgLF837BBjMfT4xQcr6yap1ZHBYBin/z0p01rahVjL9EFSM5lPdoO84CdNnyCOyDSiY9aOPED25tQDeM18yLMicA/fcmMsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2kxYNfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF3CC4CEE2;
	Sun, 23 Mar 2025 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742752029;
	bh=1/qPBc3coCPvC9EOL5WyLsdFidMIkpko1lYuoYVEzzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2kxYNfqT3S6+oX+B8Vrs+6ugOFkfeXTuALoEceO5Smu+pki5TpVVVcQh2kux86Gs
	 jPp/usMWp2ykbTjYgzEjwU2ualuZmG+VW9kNpPcTqGi8OKhesbu8q7uG8rABDBqxeS
	 2UQRX9a0hUrWP1fb9CrF2LYQhRehiSafsrO3smIlRs1AyyQvyeWgT2pWVXmTQJ7HXG
	 psfFUK8hdeHzXCoM3Rc6TRFW8bpoQtEmwws0DXrDSnmzupTyp6iMlIcG+po7c9vXGe
	 a2PmlHPJaRpSHKgOQBEV1j9/Y9lD0loYFdg6PEh1vx6l10zbX1EIwYa0hw4SpTdhQj
	 e4xsFExnhaQCg==
Date: Sun, 23 Mar 2025 17:47:03 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next v2 1/4] ynl: devlink: add missing
 board-serial-number
Message-ID: <20250323174703.GZ892515@horms.kernel.org>
References: <20250320085947.103419-1-jiri@resnulli.us>
 <20250320085947.103419-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320085947.103419-2-jiri@resnulli.us>

On Thu, Mar 20, 2025 at 09:59:44AM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add a missing attribute of board serial number.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


