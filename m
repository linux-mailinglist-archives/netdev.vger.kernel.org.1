Return-Path: <netdev+bounces-100607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166258FB4DE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A00283085
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8925F860;
	Tue,  4 Jun 2024 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYBXu/Ov"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8EB5A0F5
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510299; cv=none; b=E2uLA7bYXo0F7gjuJoSr8q07glYCKECy84Dcok0eEIGGDXDwTODX5Z6VyV/4uaDMk3rusj3DXs887vA3w7GBxovY4C8DrqyM/iWJvbJ6GYmKZQMfK3aelJ+EEVq1gxHf/NVRRBWpDzoZvERrsyCYhga62hRLf63dU2sHTzR1cQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510299; c=relaxed/simple;
	bh=uCW9l1759E3tAjaLVBD9paZ4yLJCXyJG2PmP8MngY40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfFQ+4W2/Q54SbPTT362Oqe1t2t3f22UoBcXar2+NJb7DecQWq8x71Ds7VQ+nzwiTH1cGv7egJqb7fx1bczO1L1QMDaEiW1LoLt9lIeZ64+IWcJgJxcLmoInxPdk9lOsn563oLZYiAADdFJoEj3xuIA+okgVZo5mG6Xlk90pNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYBXu/Ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC3AC32786;
	Tue,  4 Jun 2024 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510298;
	bh=uCW9l1759E3tAjaLVBD9paZ4yLJCXyJG2PmP8MngY40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYBXu/OvnopWg1ralSEmnz5+SVo5IYsOv7ivZmJcEi70CR1TIjrLi0O7sz++HUuWF
	 r18AD0VERYm87Fwux6F04F3VVu/0HZUBMomgive+anHwyNi3QOxITejuAJwNg5oakh
	 V5cgnGInMrqxwFzMy4lm9PdCQFXWIrd4fznGxJ5+c1PUFKlarIeJSpjqYS5aQKuFHV
	 xpO7JYrVTEC9jOJzDXbJXlMXnEt28VegKlaO4zXE6ub1Ekr+PZHeBaB/EtojcuEXgx
	 xD2rw3siP/DSgUUQIWdnMRK+JtXvlky6HAdOo27i5F5MuZU4kSu+jiK+ogSlFONNNK
	 tk3Y9P2Aska2A==
Date: Tue, 4 Jun 2024 15:11:33 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net: remove NULL-pointer net parameter in
 ip_metrics_convert
Message-ID: <20240604141133.GQ491852@kernel.org>
References: <20240531154634.3891-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531154634.3891-1-kerneljasonxing@gmail.com>

On Fri, May 31, 2024 at 11:46:34PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When I was doing some experiments, I found that when using the first
> parameter, namely, struct net, in ip_metrics_convert() always triggers NULL
> pointer crash. Then I digged into this part, realizing that we can remove
> this one due to its uselessness.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Simon Horman <horms@kernel.org>


