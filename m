Return-Path: <netdev+bounces-149307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2AD9E5140
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095B5288D55
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854301D5AA8;
	Thu,  5 Dec 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvhpH3y6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5605317B506;
	Thu,  5 Dec 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390684; cv=none; b=QkpHwHgLeMDQ4ULeY1KqBbFgTDMZDR2rEE23kW9dGsd42hCJpeDR/UOa4+9lLpGIzGipXKbNNWOP/3fhldLNlwNTj2hLAUyHw5jX14isPTd6epSsvX/sTIUBMn4e3s9HV5AAkvTpItQPDArlNcayB7QyTEfnQOEgAPTPSDj4PuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390684; c=relaxed/simple;
	bh=R9+a6nlwwoiKxu9OrmK/cGNy0XFUzMcNB/HKwUNSsxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYmQJI5eYNLaQX6N7N3AKilQ8gB9+qqAOom0BM2qa9K3YV25TrURC8tiwXeJq6PmYp3yZsDYT0FjDJTPHFyN1B0m0DEwFGqeHbofwQNR89r/MmkIaTwiAYysvqYZlqEM5iuIsH/z9tRL3O3Pd717fMXuBA6+PHFSbqWIU7QTlCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvhpH3y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9A9C4CED1;
	Thu,  5 Dec 2024 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733390683;
	bh=R9+a6nlwwoiKxu9OrmK/cGNy0XFUzMcNB/HKwUNSsxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvhpH3y6lG5qf2CP5ScjVt0MtxFTV8lfNj3eTFYITbPy1ihiPFaY/iJi/Rn2pRarg
	 NYDQ6qWlgC6GoSFEMHT2EU/K1rwbYQQv4frzgX5HUm1FKeAPjcOEgnPa8jkHNfmNwn
	 VBLqflDIQFW64GCL/LvhmqPK5gp2Vs8CCsYTQ74tZwiK27EWTlMQ4rrnMBxUK80Dx/
	 pmiCVfOO75/5961QlYy9/OwYvyvfNB0Ne5dbkEGUIVimTJAi5K8aCQY7E+N8/S6H/D
	 7UKo7+14e8dD6OhP2R0wc7NxVFZ9nb8FaHI6AD4oU+eUdgHQJWTW/3fgXtvzUvXHmG
	 qKGAoh3OG5+Og==
Date: Thu, 5 Dec 2024 10:24:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: support for
 AST2700
Message-ID: <xradp3b5vcmpew2y2xtrlzjt6dofo7ledbx33ekm6hsjorwnkt@t36oomttchzv>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
 <20241205072048.1397570-2-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205072048.1397570-2-jacky_chou@aspeedtech.com>

On Thu, Dec 05, 2024 at 03:20:42PM +0800, Jacky Chou wrote:
> The AST2700 is the 7th generation SoC from Aspeed.
> Add compatible support and resets property for AST2700 in
> yaml.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

You were asked to post upstream DTS.

Hold with your new versions till you have DTS ready.

Best regards,
Krzysztof


