Return-Path: <netdev+bounces-218441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157FB3C763
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C457B6A61
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AC8253B40;
	Sat, 30 Aug 2025 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTUHcIGL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9251DED77;
	Sat, 30 Aug 2025 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520859; cv=none; b=hzYOIIPw7PQr4FWC4p/MpqW3v8Fxc++nZiRFnS0a+pVmscdOjPQR/qZaEKGi9zwr0KNX2N6BdVXJd6sgU34Kq/wq0bxYwFKk9SSIS8nD8fomnxVJbooMUGt1Mmmq9WZqA/TM3sFi1j6Um3s4fN+WeTaJbOvcsQpvaB0DYXrVDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520859; c=relaxed/simple;
	bh=5RXi4pJRsXObTbDsfzSeX4WdCKP9e0ajdMX0jJ92VRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzyus+PZlDn4NXz132AoauI/F8PDQ8KLaMihQgUXTTIvdzhkjrS5KNEKQR72Scs5YsVhcTEw0IZFlYQthl8ICFCIvg9RHR3rJ3/8PV9gXs0z4YX/H89TMiFUL4tw6/iKKJ8Y4NS0mQ1Qs/xRbY+hqGOoZk3sEtOryLRNV1z2R9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTUHcIGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6558C4CEF0;
	Sat, 30 Aug 2025 02:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756520859;
	bh=5RXi4pJRsXObTbDsfzSeX4WdCKP9e0ajdMX0jJ92VRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FTUHcIGLoI6G1KfgUr3C1Q/thDACsQfp1MSBbYMrmtSiKFPJcyw8r3jS+6B7aQiES
	 gb1xyBiS8j8c6GCdAQcvLar10VU+EfTyi64TBDAXNdFGl2pR4T41LsGu+lp743kQ3O
	 Sa0hKN9n6G6IMxDUaLJSFbWlIdJQPwOsLyqRRih0eEBMYNmRX5fW4tcg3a4cTbOqpZ
	 yGhiTjThlAZDQmHBOfS0goALW4uRAWS/E9jknD7LndVkIfuoZlxwhq2xWXg37cGcZd
	 UJeRNKtcqewh7Z7P0Al+Es37ezJF0xx4pv5KL/VWKJOHxZIDw/yuu5lm5Wnef/eXxX
	 96V+qubHapJVw==
Date: Fri, 29 Aug 2025 19:27:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
 <alex.aring@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] ipv6: annotate data-races around
 devconf->rpl_seg_enabled
Message-ID: <20250829192737.680488a9@kernel.org>
In-Reply-To: <20250827081243.1701760-1-yuehaibing@huawei.com>
References: <20250827081243.1701760-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 16:12:43 +0800 Yue Haibing wrote:
> Also initializes extra1 and extra2 to SYSCTL_ZERO and SYSCTL_ONE
> respectively to avoid negative value writes, which may lead to
> unexpected results in ipv6_rpl_srh_rcv().

By unexpected results you mean that min() is intended to return 0
when either value is zero, but if one of the values is negative it
will in fact return non-zero?

That's a fair point, but I'm not sure whether we should be sending
that up as a fix. It's more of a sanity check that prevents
unintentional misconfiguration.. Please split this patch into two
separate ones, and send the minmax one without a Fixes tag.
Please include more of the explanation I have provided in the first
paragraph in the commit message, "unexpected results" is too vague
by itself.

