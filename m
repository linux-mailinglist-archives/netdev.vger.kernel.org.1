Return-Path: <netdev+bounces-136636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CB09A2823
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1F0284491
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6051DF253;
	Thu, 17 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDssCX3Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B243C147
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181475; cv=none; b=oNa37kiOI0hOHDovwf5JK18tmvg6xPj9JO2lnurLQk1NOCW9x9I0nfcF7S1C4j9OuggiwWUaGVoHc5mmwQty0Hjua4o9agQT4cI/V4rVf6NfnXvSjzU2FX4Ci6ktqhkTl9lPayNZ9CMGKUDdbi9nqd2aSuB2aXNV1eFXBBp3nTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181475; c=relaxed/simple;
	bh=8dF8e3xu9KQC5/XFgGqKelrlIOCUjjoem8qrecHL8vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHBK97edvDd+v4TmI+iaqEmjZhUOovi5o5ZIGlWS5ilwyRbpbl2kqHMoOBNgD2V5Jw8GX2x5MkSSLc+2koXrYqsE9LZhGX1oqf/5QbMIGA0oW8MhJtASI882nmjugJpyP8XiftRfCyK3LSElUSk0fUqEEGsPdfweCrYA02C8tVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDssCX3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDF6C4CEC3;
	Thu, 17 Oct 2024 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729181475;
	bh=8dF8e3xu9KQC5/XFgGqKelrlIOCUjjoem8qrecHL8vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDssCX3ZBYZzkEhH4sQPfKfcsMGDdMQtTage0XmvKLYFl29+Yb2k8MbD6WTMAmCPp
	 3q4OpMi5omq6pWSipwDiTQUgJf4kYM1VAyZ16NvkXNqZ559BkuIlLTVAofcOxM7NHX
	 P364jIw42Rj3iDPpKTbuEggWyxEQVk9LIe/S7m4o+JqVLmWJQ4cZzpj1HkgTAq5KqH
	 3a3tqwPqcH6M43ZSgGlLk/IEenox6CzfKGBPJHTyUGUVvcInZyA8FA8bwUAEw/3s05
	 XnbKWHvql+5/R3khXA0gDqSvheM/dKaXm/+4gon1tvS+48glTGOHMcD01Z0auvnRnk
	 dUPm5OsB3+1Tg==
Date: Thu, 17 Oct 2024 17:11:10 +0100
From: Simon Horman <horms@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <20241017161110.GZ1697@kernel.org>
References: <20241017071849.389636-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017071849.389636-1-oneukum@suse.com>

On Thu, Oct 17, 2024 at 09:18:37AM +0200, Oliver Neukum wrote:
> The fix for MAC addresses broke detection of the naming convention
> because it gave network devices no random MAC before bind()
> was called. This means that the check for the local assignment bit
> was always negative as the address was zeroed from allocation,
> instead of from overwriting the MAC with a unique hardware address.
> 
> The correct check for whether bind() has altered the MAC is
> done with is_zero_ether_addr
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Reported-by: Greg Thelen <gthelen@google.com>
> Diagnosed-by: John Sperbeck <jsperbeck@google.com>
> Fixes: bab8eb0dd4cb9 ("usbnet: modern method to get random MAC")

I accidently provided my feedback in response to an earlier version [1]
https://lore.kernel.org/all/20241017134413.GL1697@kernel.org/

It is:

I think works for the case where a random address will be assigned
as per the cited commit. But I'm unsure that is correct wrt
to the case where ->bind assigns an address with 0x2 set in the 0th octet.

Can that occur in practice? Perhaps not because the driver would
rely on usbnet_probe() to set a random address. But if so then
it would previously have hit the "eth%d" logic, but does not anymore.

