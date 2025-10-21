Return-Path: <netdev+bounces-231392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49096BF8BB7
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0949F426A16
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B982527FB37;
	Tue, 21 Oct 2025 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxqvCWVP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E47278E47;
	Tue, 21 Oct 2025 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079091; cv=none; b=uyJpuYKlGwab9uX1MHtRvz+bshS8kTSIsHJorHy5XS+7SdLvbjA5T1zDG+KCaOKVM2vLx2Oi9Zn6j0L+FWL5e3a5WJY7bedTBliJR/vAdUWDrlxAih8BKltrsDRziDRdgLheyLAJm1YPegDGeGMi84g0wZz4FtCg0hbynbAucl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079091; c=relaxed/simple;
	bh=ia3Nc+aBiEWsw6lzxIwHJIH6FTSei7DoOMNQPMRgNQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0SFNN5PJYt5Lo66cMmQUZIaH6gYqANp142jJJLT2uRjcssxDOFGMuKq2eS0EKtuAzZ9U9xWWOu8zZ5JjTOBvAgujmn6hYt3cljaKRnQt121OVf7fZS94raFlddRjVLjKrN3tinOaRBYj9Q49afjVL0jugYJFUQhLtJ3c3f2Qm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxqvCWVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1742C4CEF1;
	Tue, 21 Oct 2025 20:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761079090;
	bh=ia3Nc+aBiEWsw6lzxIwHJIH6FTSei7DoOMNQPMRgNQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxqvCWVP0bNfEZlCEnqcRk0d7+zRQq1ttyM5+JY19EUytZ8YqqcGgSv+V59PrNoKE
	 eFU+Ca46qgGuUStEMts8ZwrdtoqWi6ifcZKDW/2ghKpMpgWE7my5JHfsVgBYK3+4Bt
	 IxUedaI2zyp5Y41G2HD6C3uuGrbIGI4hla678mkWfi10fWSfE7aafQMz8aCBTP/Kl1
	 PCkJJUw1W9HJxXUotJrur/QtJJ1b9IR9zJ8I/MythhzOJRjry7/CQgo/ONCFVkk9uy
	 bRVlZyYbWyhhL6klUdu39l4ZFQWu55Tu/3p+Q5Gyw2ZrkY619BEwyL4mNJ9xcx7iGd
	 GABHbkBDaat8Q==
Date: Tue, 21 Oct 2025 15:38:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: devicetree@vger.kernel.org, davem@davemloft.net,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	kuba@kernel.org, Frank.Li@nxp.com, netdev@vger.kernel.org,
	vladimir.oltean@nxp.com, krzk+dt@kernel.org, andrew+netdev@lunn.ch,
	claudiu.manoil@nxp.com, imx@lists.linux.dev, conor+dt@kernel.org,
	pabeni@redhat.com, edumazet@google.com, xiaoning.wang@nxp.com
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: netc-blk-ctrl: add
 compatible string for i.MX94 platforms
Message-ID: <176107908528.775814.3309266572882987703.robh@kernel.org>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
 <20251016102020.3218579-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016102020.3218579-2-wei.fang@nxp.com>


On Thu, 16 Oct 2025 18:20:12 +0800, Wei Fang wrote:
> Add the compatible string "nxp,imx95-netc-blk-ctrl" for i.MX94 platforms.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


