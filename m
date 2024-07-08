Return-Path: <netdev+bounces-109890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE392A308
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE41E280C83
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA780BF2;
	Mon,  8 Jul 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUwXsNDH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028C80635;
	Mon,  8 Jul 2024 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442499; cv=none; b=DaLkZR5KeG1qdisidsMUu/FiEUUTKh+VaAXiRg6YXn6Xt0noBptwPmPsBoaW78t/LZrp00VbfevO199l/5gApEWnZBieXPVLtOgMDN2snCtyU54oqfVydzi17xbb0FCPUMkH3c/NWoCIFKYAXtrkDko880oZP8wbUGHZcPKDWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442499; c=relaxed/simple;
	bh=1ZxkTJ3Adc0/pfDFlGf2NV/gKURgzXUH1JFdCRZFnfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hluGZO+RNDgH7jkguZQO5K67qjIJorGz7V4BjSYOdVBh160SIx0W0ESmhN7hBVnUFQSvcwvh6/huUzZP4O4IdaSQKzOIBBWkRuIHSY06Chqp6ZnJF8pe7lX6O59lGvCl7qqopjCrEYsLsR/OnhYeQxwcPRMKA2ezIMREaNQlE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUwXsNDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC54C116B1;
	Mon,  8 Jul 2024 12:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720442498;
	bh=1ZxkTJ3Adc0/pfDFlGf2NV/gKURgzXUH1JFdCRZFnfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUwXsNDHUD1hxz6gwXpCrfSbi+EeDxBZQdLlQ4Qn4kFF+iJkauCIf9vKqaYYAcDX3
	 XAu2AH9kmDlhIKFLz6SslxV6f94LbdEgaS0PExSUzti1XwhFZAmfrycph6VK3qEbgK
	 xj7hdqGBc0rMQWu4HA+tJ1QTosVlQodD3SVmAdyltcYpeVaPJFD09jNSAQECjIcdXH
	 P2XSi+FCk1adSKcRF1y4eQFLxH5OZFcmIu6/FlHD4oVbgVFS8j3q8xrZDM9XF5+6aW
	 8jK/jrInOUJrq+DPOzKX2KImz9+Oha4Ee1vL1YbKxIq3xLswNUNOrCac941wyJpe+g
	 BqvYmvIFwGqAw==
Date: Mon, 8 Jul 2024 13:41:34 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, apw@canonical.com, joe@perches.com,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org, willemb@google.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 2/6] devlink: add
 devlink_fmsg_put() macro
Message-ID: <20240708124134.GP1481495@kernel.org>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
 <20240703125922.5625-3-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703125922.5625-3-mateusz.polchlopek@intel.com>

On Wed, Jul 03, 2024 at 08:59:18AM -0400, Mateusz Polchlopek wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Add devlink_fmsg_put() that dispatches based on the type
> of the value to put, example: bool -> devlink_fmsg_bool_pair_put().
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


