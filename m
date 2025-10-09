Return-Path: <netdev+bounces-228339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EDDBC8238
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 10:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71F5D4F6BE8
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF502D3728;
	Thu,  9 Oct 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcrusI7c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447152116E0;
	Thu,  9 Oct 2025 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999980; cv=none; b=tPCwKc43Cv5jTwUqQh4S8/hFSryvp6IyWc1gKut/lk0/pJ8WQlFhVpqKUJzGQ9KizaqGVxiwE0gnUDsxMldrIHAGnqX4e2bdchzOqIrNccdt+VhhjNy0SxCISs83YbpiygptkTHTJUv+QOaCxgy6WnMBXOIKVKEVQFrOUj5l/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999980; c=relaxed/simple;
	bh=xaaWco/OEe3tHYV/WmmcqEzdfHfoUl79hJUYEF5ZI4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV79+7Wp+Ju6UA9deUy3olrP/PUW+Mk40voivbT0R/cHxBiZv2oPkh3ql/K9xDZxHdtohTv6iBJQbIIgiscOYAbg/u6RAu4Gax0yrNNT2B0eDu0wlU41zuLEyEMr572NFzHWiL7EYbwhLv0iD7/gL2RFw2s7M2fW1/DT+ERQrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcrusI7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2E3C4CEE7;
	Thu,  9 Oct 2025 08:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759999979;
	bh=xaaWco/OEe3tHYV/WmmcqEzdfHfoUl79hJUYEF5ZI4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcrusI7cCqYFcdilbJ/C6N5wfMgDkuV2VIMr8LMDE6wxNynKVXINGffCKJjwBlINZ
	 T8HH7jCqhFMzOD/Vhqlpjyu0z/zu8km18bUC5UPXbepUxINtULcAN2zgm56UjTcBI8
	 UDcGgkUPjjqcwp9PYkwDk4EKCnJBBEhXyO+hGiQ3so9a5qN2XcEZVDyAbt5gZStP+J
	 qURxH7cI9Qg8QDCXLyNP6ygNRB+ZWWkyt7ZCNme/jJ4pBQQql1pwr23/oMcjJCZh3k
	 K8ToX9tj5AGYOUuObilI8olF10rNfCAAhodwzgBgb6gKnJJ2b4OgEOk8AXwgR8jKYv
	 zjbU8QzK9XiAQ==
Date: Thu, 9 Oct 2025 09:52:55 +0100
From: Simon Horman <horms@kernel.org>
To: yicongsrfy@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	oneukum@suse.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, yicong@kylinos.cn
Subject: Re: [PATCH] net: usb: r8152: add error handling in
 rtl8152_driver_init
Message-ID: <20251009085255.GU3060232@horms.kernel.org>
References: <20251009075833.103523-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075833.103523-1-yicongsrfy@163.com>

On Thu, Oct 09, 2025 at 03:58:33PM +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> rtl8152_driver_init missing error handling.
> If cannot register rtl8152_driver, rtl8152_cfgselector_driver
> should be deregistered.
> 
> Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
> Signed-off-by: Yi Cong <yicong@kylinos.cn>

Thanks Yi Cong,

I agree that this addresses a bug.
And that the bug was introduced by the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

Some points to keep in mind for future patch submissions.
(I don't think you need to repost because of these,
 but others may think otherwise).

1. Please tag Networking patches with the target tree.
   In this case, as a bug fix, that would be net.

   Subject: [PATCH net] ...

   Otherwise it would probably be net-next.

2. Git history is not entirely consistent here, but
   I'd say that 'r8152:' is good prefix for this patch (less is more IMHO).

   Subject: [PATCH net] r8152: ...

3. It is, TBH, not strictly followed for networking patches. But officially
   bug fixes for stable should be CCed to stable@vger.kernel.org. Greg KH
   tends to be CCed on such patches, and has a bot that complains about this.

4. Please generate the CC list using

   ./scripts/get_maintainer.pl this.patch

   Perhaps with --git-min-percent=25

For more information see:
https://docs.kernel.org/process/maintainer-netdev.html

...

