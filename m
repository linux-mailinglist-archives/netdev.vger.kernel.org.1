Return-Path: <netdev+bounces-168096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CFFA3D773
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1DD3BA0F5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE91EE032;
	Thu, 20 Feb 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssPdUvA8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09C1C6FE9
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048863; cv=none; b=Y/9SmotFotBVG7U8brLC9ac9T+l7MXI/2gc/6JOwcl4rl6jaJKDw9PPD1R8bp8QG65wCf2YplitcQNtNw1ZeeYXkrXRp26Bztzko/teemuhPD9CeFvXdNxHkz7b2Ow34V+FuNwisL/cLrLi1iYvctTk2+BfihlMOerfxaW05cio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048863; c=relaxed/simple;
	bh=uC7pudI//KhpS3AYPMrCTAVXTwvHWN8Qb8VjyBYyT+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqoYgL0g0ZO66FAwG70j+SKF9KzMAOdSyGs1qVaqVdcmn49ZRYsRqBxiVZl8wPiFHA5o23mJz8rB03eQ6ksfHhyX0q55vijT6dP/WfJI7UR9iOkYgdjN5J/1xNLr/NrmXKehFQEFd9k8wdcimDu91zUJJxKfkSWe2FoftASExr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssPdUvA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3D4C4CED1;
	Thu, 20 Feb 2025 10:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740048862;
	bh=uC7pudI//KhpS3AYPMrCTAVXTwvHWN8Qb8VjyBYyT+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssPdUvA8j2M22Mi+k4PQSOWq67/pZy2dNEhj1r1heg7XP1z4Z+k24qBjbz9nMR5A1
	 2xGZKt910bm4vJ3R3UGGUjB9fN6A+JJD1TLpuJEzU34fhYsE9u3ADLY0SBHIPX0Zrs
	 4JqTQTJbo+I8Q4te61Q0cXCJZo1uMP2LAF4oX/XwTXdMwxZh4+ypakrO68D8GhzHCA
	 0Of1etYmOgz+8gVD3mtObKhRa+n3W8yziLjcT9O7L3KdPAQJWJ1bPQxLeZuZuTqzkV
	 QHWYYAK4xSO0NVodhM+2e0VJGHumcyxgEnzmOJSqjPzLYFcazVZRdGEf0jfm3bQAVo
	 ttNDcsn8T8Bhw==
Date: Thu, 20 Feb 2025 10:54:19 +0000
From: Simon Horman <horms@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] skbuff: kill skb_flow_get_ports()
Message-ID: <20250220105419.GT1615191@kernel.org>
References: <20250218143717.3580605-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218143717.3580605-1-nicolas.dichtel@6wind.com>

On Tue, Feb 18, 2025 at 03:37:17PM +0100, Nicolas Dichtel wrote:
> This function is not used anymore.
> 
> Fixes: a815bde56b15 ("net, bonding: Refactor bond_xmit_hash for use with xdp_buff")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Reviewed-by: Simon Horman <horms@kernel.org>

I guess the churn isn't worth it, but it seems to me that
__skb_flow_get_ports could be renamed skb_flow_get_ports.

...

