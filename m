Return-Path: <netdev+bounces-138704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34AA9AE95F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656ADB22669
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A241E2009;
	Thu, 24 Oct 2024 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQS/ojVN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729D8614E;
	Thu, 24 Oct 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781547; cv=none; b=V5JiWDy7OgfU1R+d6sMA/1yMMxYz+u9gdopGNtWseemGGCMTYLmKW0i3i/iTV+E+gGGBrtRP6M6lzxHcsaItk0ZAXAkt76wsgUr0HD0him1y+yZX0x0iuG2Cpi0p3aaPZE/MUVLCjDbR7ziibTZNRaMf68sbG+Om9DtGzuuMIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781547; c=relaxed/simple;
	bh=qD7+gao6cTEv2ink4Tsu6QHfw9nuzASJ9nrEHatmtLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YachJJTrNVXHOVus5IlFGu0kGOP1ZA4YpOrSesnc5q2lOgAQZ54iwe/Qd0+8LcfN3IzeRth64vygURYtcJoWXLraLhYmZm/fYpiHbojIgtOde6Ab68DCnIOlRtV1Cp0GfA+goXZDrlsU00nD7osVjoN8BRNR/pWUjvD7Aoc2GQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQS/ojVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CBCC4CEC7;
	Thu, 24 Oct 2024 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729781547;
	bh=qD7+gao6cTEv2ink4Tsu6QHfw9nuzASJ9nrEHatmtLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQS/ojVNjvQysCvhsmbOYimUCpIdTf8g7S1pqeL4V7U2YdTB6a2RyEJ8qJt5+PrHz
	 +g7VZn3018EYj0UrGIMQDBviAyKi+I3v8k3UjjgQ6sbtuA7tDQMQkBMRPNlZ6+plbC
	 SJVsd2BLNuLpr4lnvGmqIhIeKlf/DBHPRH7CQwu9+UJgUl4LcJzCltsRA2eKTKPCEj
	 AruweojLY22iteSBFwkEmindThXL/ruRyhr7gSPRsO+KffD2l8BfT8dzvXEiy2y4Vz
	 wBRBst/UmGYwxQ3R2V6x2QwubaAgGxbcxh85uZ5Ai04eyDFtgR88BKJYeh4twIEdsk
	 ZPJFfW15wpwfQ==
Date: Thu, 24 Oct 2024 15:52:23 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: networking: Add missing PHY_GET
 command in the message list
Message-ID: <20241024145223.GR1202098@kernel.org>
References: <20241023141559.100973-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023141559.100973-1-kory.maincent@bootlin.com>

On Wed, Oct 23, 2024 at 04:15:58PM +0200, Kory Maincent wrote:
> ETHTOOL_MSG_PHY_GET/GET_REPLY/NTF is missing in the ethtool message list.
> Add it to the ethool netlink documentation.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  Documentation/networking/ethtool-netlink.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index 295563e91082..70ecc3821007 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -236,6 +236,7 @@ Userspace to kernel:
>    ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
>    ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
>    ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``   flash transceiver module firmware
> +  ``ETHTOOL_MSG_PHY_GET``               get Ethernet PHY information
>    ===================================== =================================
>  
>  Kernel to userspace:
> @@ -283,6 +284,8 @@ Kernel to userspace:
>    ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
>    ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
>    ``ETHTOOL_MSG_MODULE_FW_FLASH_NTF``      transceiver module flash updates
> +  ``ETHTOOL_MSG_PHY_GET_REPLY``            Ethernet PHY information
> +  ``ETHTOOL_MSG_PHY_NTF``                  Ethernet PHY information

I wonder if ETHTOOL_MSG_PHY_NTF should be removed.
It doesn't seem to be used anywhere.

>    ======================================== =================================
>  
>  ``GET`` requests are sent by userspace applications to retrieve device
> -- 
> 2.34.1
> 
> 

