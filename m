Return-Path: <netdev+bounces-219083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47470B3FAD2
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05F61A81FD6
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67482EBDD7;
	Tue,  2 Sep 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4pf/faw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4AC2E8B8E;
	Tue,  2 Sep 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806069; cv=none; b=l3cbyzM5qY7LGx/xJ9HmrW3Wledh7zpcV/IQCG1zrp1wOfwx+Z5FcWpIRCsHf08UmEZ9Fuh6EGeZ3hP1nTf0I2FOebMjV41Fkl7W8zTFWzGqxHWn+V9ngO0mGS9fpuvQfZw11/O9ZnWYcpaMRgch1WCf0tydX8d99aRTkDRt3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806069; c=relaxed/simple;
	bh=Qm/K82b1d7UeJV8s6u7mEozqLgeUaRfnTN/+70BlTuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRcwEu7a6i7NhleL4skR4CEsOwFVXXWfhLD9JgjSMIjKsPvQXZYpsx/aSFv1XPxNtUeGBRlS907vuMFjphJ6ztIH9oq2qrhLWq2O8AP6O2N4N/0/WZE9LHMdiUaCq/kOEV0yWIUm7DZVrLVJIV/5OLiIKT38NIGL/43nTtHskmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4pf/faw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01923C4CEED;
	Tue,  2 Sep 2025 09:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806069;
	bh=Qm/K82b1d7UeJV8s6u7mEozqLgeUaRfnTN/+70BlTuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4pf/fawM/Uz4jReejEjgNqalfniyoydZ7sLJ5fLRrYlwwJR6tP22jQl4/ZRABbkF
	 yUZhoZYnGboadF+FgDlO+e7NCZhAIcywyNNni7jP3cNlzTdRjvM+/EkNn2cundFd3S
	 ThuY+ylM8oNtX3g1LgDLGK3Sz5rsjJZcUTrlQdHVDdRQr1WN1JqrWZoQPcTr/Epygh
	 o1KlLxR7poQDmv+yIOZANhD3S+8K87xIuKY9BcD2HOsyecb7PhjuvQn0/xb2jJzabX
	 UvmOX8nZ51hkxL3pmWsdSYmjLQIMB28jfr1lWORthkhyQUVUu+v477Eit+UV+tyX0s
	 04mHKkqdwhdBA==
Date: Tue, 2 Sep 2025 10:41:04 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Daney <david.daney@cavium.com>,
	"moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: thunder_bgx: add a missing of_node_put
Message-ID: <20250902094104.GZ15473@horms.kernel.org>
References: <20250901213018.47392-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901213018.47392-1-rosenp@gmail.com>

On Mon, Sep 01, 2025 at 02:30:18PM -0700, Rosen Penev wrote:
> phy_np needs to get freed, just like the other child nodes.
> 
> Fixes: 5fc7cf179449 ("net: thunderx: Cleanup PHY probing code.")

I wonder if this leak has existed since commit 4863dea3fab0 ("net: Adding
support for Cavium ThunderX network controller")

> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Otherwise, LGTM.

Reviewed-by: Simon Horman <horms@kernel.org>

