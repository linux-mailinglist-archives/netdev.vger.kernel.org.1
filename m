Return-Path: <netdev+bounces-127736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A819C97640D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE951F24299
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C60318F2FB;
	Thu, 12 Sep 2024 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnjBzjON"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1018BBB6;
	Thu, 12 Sep 2024 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128574; cv=none; b=Cw9Mx58i/HRFoaBkoO77opI9oU4B4yxzcPzUwu8PdnQNz4JDy6oizro7Yku5h3Iy4YU8yC5qvys5NVaVqN6eYmiwp4Mt3NtDWgTCISeBzBh2RPNaQUo9yE8/uVRW3T1XShNh1uSBXG8/V/t+qL0n7CEtvD57zpSyqSaL4zc2kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128574; c=relaxed/simple;
	bh=SES32wNoIGrGed28oBc2F5wQIjRruZj+eJv3fRuFOgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8Rzpy7fEQcI76hvrBY5zvLTdxMV64VcjLxVdyAOyXcW3v6W8Apc4yzS5NqR7QVgjXLFGDk2ihtDo9IhXWQoNIQ7m977/ovXR9ZA3nStjujudGwXPwFplVcfpCftI0jlnn+CxznBX051DBfQfMsczQA0INpB3eIW+XkpbJafzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnjBzjON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7046C4CEC3;
	Thu, 12 Sep 2024 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726128574;
	bh=SES32wNoIGrGed28oBc2F5wQIjRruZj+eJv3fRuFOgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnjBzjONOKd5NBx/TMxrHMdgJkPExfk3Qf6fErCrrlEOQNURa2YUtyrps27kbKwzy
	 rErspzq4hsieZJbg5HO5OjegNnRonh2tiHjaN0TDAZgc8xbFcgB8nFfboNMJhjDEaa
	 7QXumVS7YM1b0lQVUDmq5PYkh2rAgiR1I22dC/FAM8JWQszkd6IY4EX//4If9nIXqz
	 Mu4g5raHbRkOqh4xJY7NrlUjL6ML46CuAzb4CiT/tmnGAuQ7qjlwQl0U/ErDD3he89
	 dRz1/R1MLAWxZmHKw9dOKt/GGFxy9M9Z3F7QR4UIdwNFpPHXUmdxJAjzX6m0wjkccy
	 SAdXHse8argzQ==
Date: Thu, 12 Sep 2024 09:09:29 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: networking: Fix missing PSE
 documentation issue
Message-ID: <20240912080929.GD572255@kernel.org>
References: <20240911144711.693216-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911144711.693216-1-kory.maincent@bootlin.com>

On Wed, Sep 11, 2024 at 04:47:11PM +0200, Kory Maincent wrote:
> Fix a missing end of phrase in the documentation. It describes the
> ETHTOOL_A_C33_PSE_ACTUAL_PW attribute, which was not fully explained.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  Documentation/networking/ethtool-netlink.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index ba90457b8b2d..b1390878ba84 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -1801,8 +1801,9 @@ the PSE and the PD. This option is corresponding to ``IEEE 802.3-2022``
>  30.9.1.1.8 aPSEPowerClassification.
>  
>  When set, the optional ``ETHTOOL_A_C33_PSE_ACTUAL_PW`` attribute identifies
> -This option is corresponding to ``IEEE 802.3-2022`` 30.9.1.1.23 aPSEActualPower.
> -Actual power is reported in mW.
> +the actual power drawn by the C33 PSE. This option is corresponding to

nit: While we are here, perhaps we can also update the grammar.

     This attribute corresponds to...

> +``IEEE 802.3-2022`` 30.9.1.1.23 aPSEActualPower. Actual power is reported
> +in mW.
>  
>  When set, the optional ``ETHTOOL_A_C33_PSE_EXT_STATE`` attribute identifies
>  the extended error state of the C33 PSE. Possible values are:
> -- 
> 2.34.1
> 
> 

