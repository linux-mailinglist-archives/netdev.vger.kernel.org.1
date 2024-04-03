Return-Path: <netdev+bounces-84433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE93896EF3
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1D41F21267
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E941A81;
	Wed,  3 Apr 2024 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIXQx/6z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DF241E2
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147885; cv=none; b=OBK2Qul2iWpxZldaKfOmCLyQa8Y7X0Rp8lWSW5AXs3uZQ4aO4i8W9UEV7JuQ5rREAgby4tApIFHTt7cpWsJE6SO4N/n97q5UuGwkCFKvFdM3HQD/C03fXKANdbqT4YFntRkstdOwEbaFBnAsuEb4dNJ2MygxqMKO2xP7+Hj6tGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147885; c=relaxed/simple;
	bh=Xnf3gUNjuvfe9rYNNLhsBuw4H63NEbjz9TIrlyZ63xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+BEXjPVT8WNGHUQ3ka1elVg2yZgfVr94VDjQaPpUgoSDdLc0ACDjmh/sB1P/aGal5dSjHjvtpNndtimiR/MvAuMWldUFxi68TPZbF97qccphoqObAnedN74fVmch8oH8iZ9LQgno0z0ahYy7xMVsCs6oSTBJV2sQVrnAz7U76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIXQx/6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C4AC433F1;
	Wed,  3 Apr 2024 12:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147884;
	bh=Xnf3gUNjuvfe9rYNNLhsBuw4H63NEbjz9TIrlyZ63xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIXQx/6zVA76/3Y/C8JCkEr+nwRraJ3XxHCw2gPwAMoRzc1qGL4il4WZIlJ/JpEvx
	 ILp91I8gKUWU4IpPNWNpxYCWXgLlL692vrCfXtBM/XRyZwBKAw1f9wlunGUsrpGRD8
	 LiHP6wvyTaTJV1fPtnrcd76xkO3XNfROU68dgwJeFRh+1QyeSEEo+wCSMHAW8Fyata
	 11y5Yn7JwQPtd5lNnT9qFC1eXW9l/t+D7jQjEAaWXPyhv9jD7ddFH1uisp2XiUHNOe
	 y7VioIDS1RDDatnr3ZIkd95GuAIGXLXQ0Bcx7gq4LBRogIZYm9s3rxfz30orLJNdVd
	 zpJ4LKpuupHig==
Date: Wed, 3 Apr 2024 13:38:00 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 05/15] mlxsw: pci: Remove unused counters
Message-ID: <20240403123800.GA26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <ee9e658800aa0390e08342100bc27daff4c176c0.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9e658800aa0390e08342100bc27daff4c176c0.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:18PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> The structure 'mlxsw_pci_queue' stores several counters which were consumed
> via debugfs. Since commit 9a32562becd9 ("mlxsw: Remove debugfs interface"),
> these counters are not used. Remove them. This makes the 'union u' and
> 'struct eq' redundant. Maintain 'struct cq' as it will be extended later.
> 
> Replace increasing 'q->u.eq.ev_other_count' with WARN_ON_ONCE(), as it is
> used in an unreasonable case of receiving event in EQ which is not EQ0 or
> EQ1. When the queues are initialized, we check number of event queues and
> fail with the print "Unsupported number of queues" in case that the driver
> tries to initialize more than two queues.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


