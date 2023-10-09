Return-Path: <netdev+bounces-39084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A7B7BDDD8
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0029F1C20949
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490961946D;
	Mon,  9 Oct 2023 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1s1ld40"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497E19464
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D33C433C9;
	Mon,  9 Oct 2023 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696857223;
	bh=LKHwPe31kWon9Rwjc97tFZkPtm2/8aB5Mh5don3lBPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1s1ld40p5RgJPzabs1hrNV3D/sRHtWaqMNF1Da4ircj0KXYuIogoISIzihL/ZknS
	 pFGrf9Gc5/v7psrcI8cTCYG1xfKbTTBr7rf0vd5UR4OPr8HlTgKFu8cYFIoi+pR8gt
	 UZccyUDy9+ZslEb/iL25VDSu96NEW1Cf2e8VcKpXTbp2ZMB0R00uPjTFR9xpMmblry
	 xJkcEGyqDdLpRwZLQTmg4UDaKSYYBi4989c7af9+tnVK9b91O/s4iFf6vU3XBIZlRe
	 NUZZkkKenIwtSUn/bePfhltXDJi7aYILx46dDj/Kdc3PEe1YY/GLch+ixFL1eiIjIa
	 GKZPfA4N5tXsg==
Date: Mon, 9 Oct 2023 15:13:40 +0200
From: Simon Horman <horms@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: fore200e: Drop unnecessary of_match_device()
Message-ID: <ZSP8hDuWuJg7qUSf@kernel.org>
References: <20231006214421.339445-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006214421.339445-1-robh@kernel.org>

On Fri, Oct 06, 2023 at 04:44:21PM -0500, Rob Herring wrote:
> It is not necessary to call of_match_device() in probe. If we made it to
> probe, then we've already successfully matched.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

I agree that the check is redundant.
And that with it removed, the forward declaration of fore200e_sba_match
is no longer needed.

Minor nit: I assume the target tree is net-next.
           Ideally that would be specified.

	Subject: [PATCH net-net] ...

Reviewed-by: Simon Horman <horms@kernel.org>

