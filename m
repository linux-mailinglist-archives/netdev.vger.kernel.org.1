Return-Path: <netdev+bounces-99771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C31AC8D6500
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9F8B22B6A
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA695731B;
	Fri, 31 May 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qz//jns6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF191CF9B
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167385; cv=none; b=q+8rKLeut1LxascYBcvtzBe71XppR/P+VxPJgJCqrqnhN+DbKYdquAcICx1Gzm9/i5dYVEVojRQn81iOXKl68QgU7hH9ybBHjv3+a80nU/hPk9MKERr8dR1HrJ+Jugg0lJ9lkustRCBVOm4HvPz4p03JZXFqlw7DlfVXumrUcCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167385; c=relaxed/simple;
	bh=W5p25Dr9o9bWDw6/lWapXT9NOVQHwp1leOzXG6dfaMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlYxrgTWHMndl0qX1s/s7j35CWYvgNR9jNfAKa3XD3Wjwd+1KxIE/q+X7K6Co2oQkq3ulqWpWxvkQFA8VX98ILXJhuCL2tibDAArK3cXYkVblGIQwNcydS4Q32V83Tg+p86+a2xN7K4s656CGOmIlXCt//UPxQHbsDpptiYjuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qz//jns6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC9EC116B1;
	Fri, 31 May 2024 14:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167385;
	bh=W5p25Dr9o9bWDw6/lWapXT9NOVQHwp1leOzXG6dfaMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qz//jns6zlw2cqcaSvaRC0mkRvhThTGRgaecJWvKg4H8knaZEX6CFf61nXoZlrm1U
	 5kk+BxMeaNW7zPR5S5mvqGGfdlUWuJ7TLf/iovpghPWnqcE5GBYyQ2QoQOhvpTUNCz
	 NEFEjFYFaB3Zg8kbwRQH59qDA5rKNIKtfS+pRtknA5GQe/Molvdn9FPZ4uJWXHluyx
	 GYHZu2RtSAgkbkAFrcQ813lrl8AhuNTfWmxcyAiu1BhzaJY6MNp8a6tetlA/h+Uxsg
	 liv0SzRg42d6GXYYZz3Yky14eSCR9VBectIzR9JjlSiX/1zJfj+HotYp85YkD9YjPs
	 2kB6LBReqZq+w==
Date: Fri, 31 May 2024 15:56:21 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	Carolyn Wyborny <carolyn.wyborny@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH iwl-next v7 7/7] ixgbe: Enable link management in E610
 device
Message-ID: <20240531145621.GN123401@kernel.org>
References: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
 <20240527151023.3634-8-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527151023.3634-8-piotr.kwapulinski@intel.com>

On Mon, May 27, 2024 at 05:10:23PM +0200, Piotr Kwapulinski wrote:
> Add high level link management support for E610 device. Enable the
> following features:
> - driver load
> - bring up network interface
> - IP address assignment
> - pass traffic
> - show statistics (e.g. via ethtool)
> - disable network interface
> - driver unload
> 
> Co-developed-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


