Return-Path: <netdev+bounces-132928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CE9993BE4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9133C1C23ED9
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3E8488;
	Tue,  8 Oct 2024 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/+VIOdU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C42AD5B;
	Tue,  8 Oct 2024 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728348389; cv=none; b=hbFsoaQb2/Z2LgTOWHdNOdIojdCaBV0jxVDQI1kC8sxkO5Z7AMvidmlN+TQqx5oJwEGdQccUBUk6/RpK5yFx1U83jf0vHGJPkZAWGyb8LWniGzHjShPYWwmqGHDEWmvGFX5kLT3zmjYuhb1M9V8ZdT1cPBHkhn558vOZVw112rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728348389; c=relaxed/simple;
	bh=rbufBsG5dVWcAFbqrpOe245n2KhuK4HWy5jDbknH/MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkxbJZFmdtiounXc0BQB1Imdpzl3m6NJGx/pCNoNCcePn2JSqz/r2Eq9mi2bZM3wHPNwS/TbgCSMb+/SZASO0fwocjXHBgddjZkCcVjer3nDzBg+s0k4+uzjeoGZljioLzPnPA0d8bxGxLoAVq2fbUDNz8HAXm1A3+/qK7LrP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/+VIOdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC9FC4CEC6;
	Tue,  8 Oct 2024 00:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728348388;
	bh=rbufBsG5dVWcAFbqrpOe245n2KhuK4HWy5jDbknH/MQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M/+VIOdU0EhGiVTf85FLLYQD8YNydCcSjNBbZr9B+MjK3UNzGlIrR3aa/YtT7JkR9
	 smkPLFVv89zXjUB4d3uJ7+Q34e6+FJd/v6NchEM3MQr1hJ7uBq84Y+RfhEFyW1NiD7
	 wu/t/A9+0cuiWdF9nGfx4Hca0Pi9/ywO+VrIPPQmYqE15dLZdkGGOwLPWZb5vJvtlX
	 QthMPzLTygdlgwNkqBnsJPk3xcMRPFOZAO5p2qb/WKIn7DpUlHLIVX9nesaaRO0Q0V
	 mLf4U+76BgwZoJA6tZNNNlZpEgwPyarqF6glVylFAdhO8Ia4pzglKCwJGtzllXgZRh
	 p4CoP62gaVMCQ==
Date: Mon, 7 Oct 2024 17:46:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net] net: ibm: emac: mal: add dcr_unmap to _remove
Message-ID: <20241007174626.0c199c24@kernel.org>
In-Reply-To: <20241007172122.6624c1ec@kernel.org>
References: <20241007203923.15544-1-rosenp@gmail.com>
	<20241007172122.6624c1ec@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 17:21:22 -0700 Jakub Kicinski wrote:
> On Mon,  7 Oct 2024 13:39:23 -0700 Rosen Penev wrote:
> > Fixes: 1ff0fcfcb1a6 ("ibm_newemac: Fix new MAL feature handling")
> > 
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>  
> 
> I'll fix this one when applying but please make sure there is no empty
> lines between tags in the future.

I take that back, 'cause it also doesn't apply
-- 
pw-bot: cr

