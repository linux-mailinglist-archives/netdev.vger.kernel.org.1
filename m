Return-Path: <netdev+bounces-123745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A576B96660D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81DB1C20B70
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A41B252D;
	Fri, 30 Aug 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIY38XoI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA884B5C1;
	Fri, 30 Aug 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032987; cv=none; b=rerWqJnVjkl/3p/MUJlZB4ZWzGrlA+mPyTB4icPDa22kwzUnaIdywNdEnrzQI90/0PlybLfEAs4ZcBFmIzPZq4x7l2rmxKruepi1FxLH79wK8+k2xeZlSKbOdrdgpfLWT/ojdYuzYwM/Kwio+o/xnXJ389EYH+bXb3V5h7VtUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032987; c=relaxed/simple;
	bh=LEu6VZtzgDqj36aq9M1PnI8JHr/9Cybtomn/NT4arCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnbRvn3jh6lfIIonb+CKiGavinCkzJPcSvxVCA1cHSYcFCj5dWC6nuVmoo7AsuFrdjXY5rVXpaSc1ZDKrc8EdDj0pOVo7npqEqSRK71G31qiZW5FsWW/6tgR4CdJzeCVA8CyfwZQat+i+4nKm7MP76yPcewoUJT1K7dL+a7O7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIY38XoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5EAC4CEC2;
	Fri, 30 Aug 2024 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725032987;
	bh=LEu6VZtzgDqj36aq9M1PnI8JHr/9Cybtomn/NT4arCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIY38XoIsiJw3y8m4W2f5EGs0qlauWogslQEvIMqGwiw4hbjg6DkhFuwccpMI5TFg
	 H4klfb86AGWfNqjW/eDYcmrC/ZHWCRItlxFcVao93iHBVBhxq2vk4QQxLDHcY0I+oi
	 qDl7gm1zWrOhEvThqGA65ud0cJoqHu2wc01/EUW6ncMYXQafK8ce72EAdlz5IcbK+3
	 7fmQJ4IAQMF9f3nZoOUk37Wvv4OJi158XGLKGOyd5oAC75YghSNj7MbzJRRRAM15lB
	 cswnTOrjIOC93JsEyjRxqm9NpEVghIZ2BXkFXUysbc1zOq0nZUEtMFNCztuQxSF6m8
	 RJnqGOcHWbesg==
Date: Fri, 30 Aug 2024 16:49:42 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: Re: [PATCH net-next 1/6] net: ag71xx: add COMPILE_TEST to test
 compilation
Message-ID: <20240830154942.GT1368797@kernel.org>
References: <20240829214838.2235031-1-rosenp@gmail.com>
 <20240829214838.2235031-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829214838.2235031-2-rosenp@gmail.com>

On Thu, Aug 29, 2024 at 02:48:20PM -0700, Rosen Penev wrote:
> While this driver is meant for MIPS only, it can be compiled on x86 just
> fine. Remove pointless parentheses while at it.
> 
> Enables CI building of this driver.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Thanks, this seems to work well.

Reviewed-by: Simon Horman <horms@kernel.org>

As a follow-up, could you consider adding a MODULE_DESCRIPTION()
to this module. It now gets flagged on x86_64 allmodconfig W=1 builds.

...

