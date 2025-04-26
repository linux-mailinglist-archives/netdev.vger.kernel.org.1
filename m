Return-Path: <netdev+bounces-186201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1E8A9D709
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 03:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C3E3AF5B3
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C918DB2F;
	Sat, 26 Apr 2025 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJjIXDWe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666CB1898FB
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745631374; cv=none; b=MxWABGziROju6J22t4faLd/9OWpVJUjSwfUEy5Vr8lPsEwbc2nfGbf+zqZ2bqXeP1O/3Qc3JoEoHAjHzC/XLXa2pI7agA4veh4ihQyMGrmNe45PQqCqcQZAcPn4SMIbIhMvKz1eJZuFTuUu4+qhAfI2vtveAVk6Y9HNv7MFdWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745631374; c=relaxed/simple;
	bh=8QcIsCC/+Ogfw6fmDp0vZf/u08Zx2acifAX6KRQTSjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZUzRoFWRfHousoN5w/zWjhoLegA3a1A13etYlXPzJgNC1EWOMo08EhL2gWqbcb8EK2EO6TzqwnTNjmFt4slcpWcckDL8aWsJEgBSxEUeLKpAmTrpvArcs48OQeQFy9H3AwknIxRe6mMan2Ljbx5LZ6ND99oJqrUtOeiIs2x5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJjIXDWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D78AC4CEEA;
	Sat, 26 Apr 2025 01:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745631373;
	bh=8QcIsCC/+Ogfw6fmDp0vZf/u08Zx2acifAX6KRQTSjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RJjIXDWe2keVIcXyDxkmsOvGdYM4t5amMsqhfNJWzjN7csPUBL5RNMWC5Lri+6Ns6
	 JKWhttSZ8rJ9KTDauZ/BR1tmab04HQruoepoq2MGyFEp8uRWLCdGsxGwn+9T4MKgN6
	 laXcOp0Xco/J12XuitneBkj2Omk2Rgty1kyArkUKfQVaBfAGnoFEthzfwjy3CsyGQr
	 aAlvwNTh/aLQt69B5CgJfapcVtT/2L037Bl+97Um4wek5Vz3OEv9F7foNAr+aRvqcU
	 mbI+zi9u7IESH2ivNhP0c58rboHQ0oyxvJqxK1QhQkWV08BoAcanGAOnCtTHLfkArH
	 Ts4utsoN3vYGQ==
Date: Fri, 25 Apr 2025 18:36:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/4] net: define an enum for the napi
 threaded state
Message-ID: <20250425183612.19068f23@kernel.org>
In-Reply-To: <20250424200222.2602990-3-skhawaja@google.com>
References: <20250424200222.2602990-1-skhawaja@google.com>
	<20250424200222.2602990-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 20:02:20 +0000 Samiullah Khawaja wrote:
> -			dev_set_threaded(ndev, true);
> +			dev_set_threaded(ndev, NETDEV_NAPI_THREADED_ENABLE);

The drivers having to specify the type of threading is too much.
The drivers are just indicating to the core that they are too
IRQ-constrained to reasonably handle load..

Please add a wrapper, something like dev_set_threaded_hint(netdev).
All the drivers pass true now, the second argument is already
pointless. For extra points you can export just the
dev_set_threaded_hint and make dev_set_threaded() be a core-only function.

