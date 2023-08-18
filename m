Return-Path: <netdev+bounces-28679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD397803C6
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8E51C21562
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918781B;
	Fri, 18 Aug 2023 02:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD12808
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23519C433C7;
	Fri, 18 Aug 2023 02:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692325326;
	bh=/WfObG0cK4LLbyZBi28R1HJuFjXmaYaAIOZUjAbN+qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nJquKp6675laP2JX8Ee7cllyxm5H7rWB0dDJ8UqBdNIonZrAkeXGtCXrfcNbZ0ufN
	 YPMhc0OUiUgxEyQvCv5rJ2C3zkvuC7O5EXEpFOJyveRXAto15u9xq6P5Mjyi3Ela6T
	 Yj9uhrmnjxMXwShT6fl4vG48DiWTNvfZlMe7ZOgNdM8o2yLz2QrXI3+TqMNDsK4PVc
	 4wdCmwHr2rJaKT6T+u3v72twDYOzbmoSqupcwf/IOHX7f9aRkSAZ4O9ViML2hsYeDE
	 wcokHzW4JWPxFCYT/XZ/ohprGm7D2iLmtxzvLfwsFP+2HiQlk2QoKKFA7U+eRCBVXW
	 yWd6VntzgK32w==
Date: Thu, 17 Aug 2023 19:22:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <simon.horman@corigine.com>, Yinjun Zhang
 <yinjun.zhang@corigine.com>, Tianyu Yuan <tianyu.yuan@corigine.com>,
 netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 00/13] nfp: add support for multi-pf
 configuration
Message-ID: <20230817192205.599f108b@kernel.org>
In-Reply-To: <20230816143912.34540-1-louis.peens@corigine.com>
References: <20230816143912.34540-1-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Aug 2023 16:38:59 +0200 Louis Peens wrote:
> As part of v1 there was also some partially finished discussion about
> devlink allowing to bind to multiple bus devices. This series creates a
> devlink instance per PF, and the comment was asking if this should maybe
> change to be a single instance, since it is still a single device. For
> the moment we feel that this is a parallel issue to this specific
> series, as it seems to be already implemented this way in other places,
> and this series would be matching that.
> 
> We are curious about this idea though, as it does seem to make sense if
> the original devlink idea was that it should have a one-to-one
> correspondence per ASIC. Not sure where one would start with this
> though, on first glance it looks like the assumption that devlink is
> only connected to a single bus device is embedded quite deep. This
> probably needs commenting/discussion with somebody that has pretty good
> knowledge of devlink core.

How do you suggest we move forward? This is a community project after
all, _someone_ has to start the discussion and then write the code.

