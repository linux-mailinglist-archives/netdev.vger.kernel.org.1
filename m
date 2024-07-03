Return-Path: <netdev+bounces-108983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91579266B9
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0DA1F21DA3
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B318411C;
	Wed,  3 Jul 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0kXwfjJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D87170836;
	Wed,  3 Jul 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026402; cv=none; b=LuPjLj/vFR20s+N8lyuRbCHA9XHCHVt+sVv5IkoyPFyWGYdnuf4fNVSsm6cOR5EZPpnTjrYhQu2j2hlgYW22UDgXpbf+4BIKjcl4DK5geqS+lKwm0aNg5wFgWhYIBEEnGV25IzU5XTkvrR0iubG2IuzXV92PJw4Ptx+h7jESDDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026402; c=relaxed/simple;
	bh=1BEiPxSraw4YsG2dVuaWuSLhbPOd5CaJh7ecicLafbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B46d8jQVSvz1P78O2ZsYZRwnHGMpEo8Dd12OVVkU14/zC9Ym6v37GUzfW0ahtMCVUwqLQCxk76r8noZAM8KhZqCwJ8aIFGmpraVNph28Vq3EeYljd0EKfAon0j8gEI8X0ZkUPqXMWSjP6BGjICtovoK0SG4mETbG0CYzI3466E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0kXwfjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69369C2BD10;
	Wed,  3 Jul 2024 17:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026401;
	bh=1BEiPxSraw4YsG2dVuaWuSLhbPOd5CaJh7ecicLafbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0kXwfjJWjKBcwyj+QeeQzvkCTav8X7HsXmpkBZaEnVz6ufcS5rovK7KeyOJnjUsM
	 4G22YI/J1ke9aJQcqRcWkBCgtCx7GMXH0uN9e7qqwhVlrvXxqdMPc3QZPlqQDIGcPg
	 KfgKcbph1L+Cjq3Re1kxJeiU9HrrYnpEU0c0g/CwX0ltwhLG7UvliHie7cABEqLR/m
	 Idtm/O4//xoa02UDs396Nd4V+bv89X1L5rpX24vJniuz6qMZfTw/81E9clURsxAD7c
	 y27HHD43CzzkWeBKyQMdDwsrJ2dDuVwUQqIr+VsL/GWB+BCXK0o4z1RfywyW6W07yd
	 1WOrDAKn8sbEg==
Date: Wed, 3 Jul 2024 18:06:37 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 13/13] MAINTAINERS: Add the rtase ethernet
 driver entry
Message-ID: <20240703170637.GG598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-14-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-14-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:54:03PM +0800, Justin Lai wrote:
> Add myself and Larry Chiu as the maintainer for the rtase ethernet driver.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


