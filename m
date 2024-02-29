Return-Path: <netdev+bounces-76018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263F86BFE4
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51311F251B0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD664374DD;
	Thu, 29 Feb 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyDJIMhy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8B812
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181156; cv=none; b=T1t330tDHMl0cBQdqjkIwyYAyv7bS8r16/mTahU5Tvg2nhl3qIFQHZYellYia3vR5eCc8ftuEbPaiWwRA1c531bICZTewm181HF3/EJSbK0JWPW/FDSShLWgF0HGqeXzxoqHrW78e+I6lQmZ5jnORIinsb5lFmWlLsVLsmR6XVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181156; c=relaxed/simple;
	bh=6yuNG6k7RQaDZBxgdfz9+gHU2+N/xt/XGaEKpSlx19A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoocaQ13sypD7DNdoRnnxipBJhh126Q1n12cApubBIN2f5tE4PIkclBcz28z35E/GxD0P2id376q+qXRnLRDB1PvcgQ1A/ctFppvD49xjs09LeXup3+IQlI9YOV/9jQBa0zVxOdIaKDoJc1bugeTzreNHplg3OWZ/d4NLLft1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyDJIMhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E5FC433C7;
	Thu, 29 Feb 2024 04:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709181156;
	bh=6yuNG6k7RQaDZBxgdfz9+gHU2+N/xt/XGaEKpSlx19A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eyDJIMhy/Lji1Qxl0b2VyzDTR/BJdawB9B14POwM5TqNlatVEXVqPW2HXXzdJ8IBH
	 w7E0ZuLG55T+/JBwNFSTwplEvMcVfJF0RtLcyB0CG6MXsOf4Xf4kHbMXMaLmxW2tL0
	 gVXYVgWkkhGmtdDPWitxohK33oEDdfpBiptiPOWNz0yMUOvFVWM/xF8fxr6iGJcFX6
	 RsJezQ1PL5IFdYbpBgjbcIoC5Vq2EIx1ST6AXm33fSDfNz+C+C4+SnYcj+Z3r2Db7j
	 fZ0sQ1ICmEO/lSh2/pii7BlcMe2982aDLJcCLAOfxA75foGfPVvQIShBYgpTScrMej
	 oAUxVAA0F963Q==
Date: Wed, 28 Feb 2024 20:32:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Louis Peens <louis.peens@corigine.com>, David Miller
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Fei Qin
 <fei.qin@corigine.com>, netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 1/4] devlink: add two info version tags
Message-ID: <20240228203235.22b5f122@kernel.org>
In-Reply-To: <Zd8js1wsTCxSLYxy@nanopsycho>
References: <20240228075140.12085-1-louis.peens@corigine.com>
	<20240228075140.12085-2-louis.peens@corigine.com>
	<Zd8js1wsTCxSLYxy@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 13:14:43 +0100 Jiri Pirko wrote:
> >+/* Part number for entire product */
> >+#define DEVLINK_INFO_VERSION_GENERIC_PART_NUMBER       "part_number"  
> 
> /* Part number, identifier of board design */
> #define DEVLINK_INFO_VERSION_GENERIC_BOARD_ID   "board.id"
> 
> Isn't this what you are looking for?

My memory is fading but AFAIR when I added the other IDs, back in my
Netronome days, the expectation was that they would be combined
together to form the part number.

Not sure why they need a separate one now, maybe they lost the docs,
maybe requirements changed. Would be good to know... :)

> "part_number" without domain (boards/asic/fw) does not look correct to
> me. "Product" sounds very odd.

I believe Part Number is what PCI VPD calls it.

In addition to Jiri's questions:

> +/* Model of the board */
> +#define DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL       "board.model"

What's the difference between this and:

 board.id
 --------
 
 Unique identifier of the board design.

? One is AMDA the other one is code name?
You gotta provide more guidance how the two differ...

