Return-Path: <netdev+bounces-123604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279589658B1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4501C20F4E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E93C153BF9;
	Fri, 30 Aug 2024 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YggrZ1hP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CEE1531F9;
	Fri, 30 Aug 2024 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003389; cv=none; b=JoA/bvmUTJzobK/0bUgxcYeoDyVaQrh3zOGxNWN+bfYXFSh5bzgTxD3leYxosZZU1x6jLMArBdX6lvzZROyJJK7NSX19Vb60/QP6mbXzOG4VZlMdn0pb2p5SBtNdM1yGGAKbgVD+il5ewVB8NTM0jeKKPAP7p14suyfE/m6N6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003389; c=relaxed/simple;
	bh=2CRPO++kUPSFsSZ/xxI1Y9KHYmM8bqk9kozrdAzqUH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh8YkuVoKbMnGn49JVAdll74Qn5wv3rDhFda32IagHfFtv5Bj+DR2lxNU4fpFS4mQbOcJz6WyByCzcDSo03wRuYnQOAT7q8CGMCBlDaB3UXlqkEY9+NImyR5VcSmmLZj9XXZIpmFThKZsWIxgfE9GnUjOp2OVpjO47W31qEQQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YggrZ1hP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FCEC4CEC2;
	Fri, 30 Aug 2024 07:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725003388;
	bh=2CRPO++kUPSFsSZ/xxI1Y9KHYmM8bqk9kozrdAzqUH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YggrZ1hPX/bTo7NTskqqXKqdspqmuIgMmZRzFtwmuc1uUORT2Ra76xU1Cbm19DZWJ
	 7V2mVxA2Xck9gazUl3X85Gr8bQYYtjDLybHH25S9xpuHzwE8qDmvwZ16F6idXR8kVV
	 HSqfNseRPqfqOCZMS14oWpMFKxIgDP/9wcliWTXtTyZst2pif747S1c3lVZnUu8qUG
	 sQ7IXm8qprZu/E4MoaJD2QjxrBBWddPd6yDZadjy1TW+v6K3uOyu3N+iblC4cvgeky
	 PaYvnU0tsle2aw8rA9sK1FZ/iuZed0JmP9JvsLADaaJ1A2r+yM9ZF2J/My14AdyuhK
	 Ovk/frLIBzmig==
Date: Fri, 30 Aug 2024 08:36:24 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: bharat@chelsio.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] cxgb: Remove unused declarations
Message-ID: <20240830073624.GG1368797@kernel.org>
References: <20240829123707.2276148-1-yuehaibing@huawei.com>
 <20240829123707.2276148-4-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829123707.2276148-4-yuehaibing@huawei.com>

On Thu, Aug 29, 2024 at 08:37:07PM +0800, Yue Haibing wrote:
> These were never implenmented since introduction in commit 4d22de3e6cc4
> ("Add support for the latest 1G/10G Chelsio adapter, T3.").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Hi,

I agree that these were never implemented, but I think the at the
correct citation is:

commit 8199d3a79c22 ("[PATCH] A new 10GB Ethernet Driver by Chelsio Communications")

...

