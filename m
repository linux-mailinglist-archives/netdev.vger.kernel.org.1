Return-Path: <netdev+bounces-116135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF44949369
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9780728735B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310BC1EA0C4;
	Tue,  6 Aug 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZKEZubA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDEC1C3789
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955243; cv=none; b=XZQCnpxIKSsuANGykdenlP2u/ddx6MCJoHB+iWe56Xk1sezD0JKqtywMUmayfCB4YXHr3Ee8Tb3NHauFerq2DcCzPIimWAuAtncq/YP+foABG+MFPSPDV5gFShNUDKL+MLKGRZ+Vt5fBZaX0EeqQYCYagV93QnibjaVVjP9+AGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955243; c=relaxed/simple;
	bh=Hfl8JVt+9i2BDRR+GncPy+7gfN3h9gG/3zEHOXEw9iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Otk3yg+7NAv3OQhh1jzip6FeIntKRWFhPpV9mWjm7wvF+9JnqoIllOOSdkpfWIfNsAqXT2AWiFYBg/vq9wq68SQm7sAZth04afmu1AaS3K1t9fqjJQ5uNLqkz0NvTuGt7Q5X9L42vuQSa9GVeR0gT8PDA9XYF9Jm5XhSq6mg9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZKEZubA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84A2C32786;
	Tue,  6 Aug 2024 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955242;
	bh=Hfl8JVt+9i2BDRR+GncPy+7gfN3h9gG/3zEHOXEw9iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZKEZubALayCwcSAOs6V8cwKdefKMM/CCn83YQeT3oTrzrtLCrK8ox5D5Fj18J2cM
	 D2003GTqZG/tcd+Ui2gAJaSMRsMTmmGFA1ILnJC18ZpngLgNYyiqEIKpCLoN/HmDHB
	 2xEE8EwOw7+FbWvqHSI16PvRoFnGR90Rpso/Miha0JpE//XNoc3u3IvfgAHCBM5/1w
	 fbKqhCRsVra8NpE1Flnk3Pkzew07bfyfCTk7dr+1l41tJTrZ9eZV4ccIRp6JjOuqQJ
	 w1VgP9nWBYp1SXyZHjSxqrI2JG59LpAhQDu2zvWUiCoSjYCIK2NMbnLyLk9yTQIOYj
	 pHMg5E0c8fmow==
Date: Tue, 6 Aug 2024 15:40:38 +0100
From: Simon Horman <horms@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com
Subject: Re: [PATCH net-next 0/9] l2tp: misc improvements
Message-ID: <20240806144038.GV2636630@kernel.org>
References: <cover.1722856576.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722856576.git.jchapman@katalix.com>

On Mon, Aug 05, 2024 at 12:35:24PM +0100, James Chapman wrote:
> This series makes several improvements to l2tp:
> 
>  * update documentation to be consistent with recent l2tp changes.
>  * move l2tp_ip socket tables to per-net data.
>  * fix handling of hash key collisions in l2tp_v3_session_get
>  * implement and use get-next APIs for management and procfs/debugfs.
>  * improve l2tp refcount helpers.
>  * use per-cpu dev->tstats in l2tpeth devices.
>  * fix a lockdep splat.
>  * fix a race between l2tp_pre_exit_net and pppol2tp_release.
> 
> James Chapman (9):
>   documentation/networking: update l2tp docs
>   l2tp: move l2tp_ip and l2tp_ip6 data to pernet
>   l2tp: fix handling of hash key collisions in l2tp_v3_session_get
>   l2tp: add tunnel/session get_next helpers
>   l2tp: use get_next APIs for management requests and procfs/debugfs
>   l2tp: improve tunnel/session refcount helpers
>   l2tp: l2tp_eth: use per-cpu counters from dev->tstats
>   l2tp: fix lockdep splat
>   l2tp: flush workqueue before draining it

Hi James,

I notice that some of these patches are described as fixes and have Fixes
tags. As such they seem appropriate for, a separate, smaller series,
targeted at net.

...

