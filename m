Return-Path: <netdev+bounces-115780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25F8947C39
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42CF1C20E00
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C778354278;
	Mon,  5 Aug 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw2r0QCQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C7482FA
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865964; cv=none; b=UlchGceNAtPAQvbnluxHYMUJiYeVMLOyb9p2nSuOnTmF9Sgo98KVSpvn3hx8zDza/R4CbxnuVGg9tvmKLADiam/VENOrOCWe4HtvkD/CzVrIOlufNYUE4q8B13K8efLswF2lUMdQrIZM8ecO4zcG3e1OLNuy72x1cZGpsegEEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865964; c=relaxed/simple;
	bh=zXh8Yx7ODTbCH/cN3GUJv78LeLxTFoAdwE5beq99Xeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qf3zU8DDQFJeOe0oO292HzQ/Ieh7YKGtbYOsaShwwos5CytEljErAF3cXbLl/eFAWyltEJ8j++y3pVIbd8P+s9eDPuoCcprRozg/XQaH/gX0QxUQyU0CZ3SWYuN8ZkB/nopGnz10SrixF9msKdkUnxhPxUobVpCIczyz1kmD3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw2r0QCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C9C32782;
	Mon,  5 Aug 2024 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722865964;
	bh=zXh8Yx7ODTbCH/cN3GUJv78LeLxTFoAdwE5beq99Xeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gw2r0QCQ7TmQnrLm2MQ2FP3Sxd3nOezkKpq4Rv9Zaz5GaJcDJn7nwNodClDQ5fROd
	 Ee6SR8IzyUahHLUlkqgRhD5RxxiNBQpQL0KXml7UL1HS6V4tOYmswoFtI1ULeasPxM
	 PIAjWcGsGWzfInWATg6rPiMXpcxo7X21TN5gY0QNcp/vHwsAkXgfmS+mdqsW02QB6o
	 AfwMbemOHC2501v/t7lYWyS70h0OcCxP4ov9ys/99a8WG+12A9V14jKVqNVZwHYSIB
	 m8yyzjIx/XGlAxXn0PvbVmhdG0C6TybSIV/b/E5rVp4QXWUtNvvJ8esT4mhMIvdkz9
	 iHWFPsmoItemw==
Date: Mon, 5 Aug 2024 14:52:39 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/5] inet: constify inet_sk_bound_dev_eq() net
 parameter
Message-ID: <20240805135239.GB2636630@kernel.org>
References: <20240802134029.3748005-1-edumazet@google.com>
 <20240802134029.3748005-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802134029.3748005-2-edumazet@google.com>

On Fri, Aug 02, 2024 at 01:40:25PM +0000, Eric Dumazet wrote:
> inet_sk_bound_dev_eq() and its callers do not modify the net structure.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


