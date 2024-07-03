Return-Path: <netdev+bounces-108974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F399266A5
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77063B24BC1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679C18306D;
	Wed,  3 Jul 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOKeMZ2h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB2170836;
	Wed,  3 Jul 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026107; cv=none; b=G7X4z1Cmq56CawnHqkjgxdWzcscRCSaZfQNe8qG4HM+00RLhStlYSAXc7JsR6zu7sWd+F+HP56QPjnpOyvwpWLOgDe0wv2qbCtON6Jkeg7cMuUAzeC66KkaZE6emWx1CG9UQkhhhI1wocXUDFeaFdY/kKpzhu3vGH2d797hb0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026107; c=relaxed/simple;
	bh=59WedtXTU/293B4d2pukM4DrJdmyzK+ardNkFn9MYww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHZOQfNRNgBbVlsegFGNTXXDAB+bXp+NKrOw6w3oe5Gd0902bam5qnPaeOU6sQ3qHrwMAHAGeLUnD4NXbh3ytb053OQQWYIKuoYvawCUo2hWGnFaovlnnQAsd4Ggv9ppoP+VYYQTA1LqVMXpVT8QfazN4e2hWbCFprnBh7Ay2xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOKeMZ2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A9BC2BD10;
	Wed,  3 Jul 2024 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026106;
	bh=59WedtXTU/293B4d2pukM4DrJdmyzK+ardNkFn9MYww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOKeMZ2h6ajbkKYVAIZDmbXd4RR/oRZn52pmXHJ8byzNwa3jaFv6rckKjxewUzxXz
	 PDubaQ03jsbYImzbxX64h1FqG/dV6LPfuYV/LG863oScVOmIHHWNy9o3uLzFor3LEw
	 vovCaIhZGGj2dA2OtEMAv0UMVj5V7vhbNGm//fZJq4xt7MAUCEgAtpfRFrVm+OUne4
	 qCKX08AHLiR53qN+T9lQMMEWvn4XRqdlKuaavmNTcu6U+MYEgSvQti1oROwAYK2q3L
	 kSOsFC8/nsRSpf7LSSCXEwJ/s7V9X9kKaxz6JfmX+ndzmb850qDw25OS36vNvo1ria
	 tPjEU7K7pOaIg==
Date: Wed, 3 Jul 2024 18:01:42 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 05/13] rtase: Implement hardware
 configuration function
Message-ID: <20240703170142.GX598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-6-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-6-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:55PM +0800, Justin Lai wrote:
> Implement rtase_hw_config to set default hardware settings, including
> setting interrupt mitigation, tx/rx DMA burst, interframe gap time,
> rx packet filter, near fifo threshold and fill descriptor ring and
> tally counter address, and enable flow control. When filling the
> rx descriptor ring, the first group of queues needs to be processed
> separately because the positions of the first group of queues are not
> regular with other subsequent groups. The other queues are all newly
> added features, but we want to retain the original design. So they were
> not put together.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


