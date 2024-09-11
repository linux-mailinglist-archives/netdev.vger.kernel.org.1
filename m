Return-Path: <netdev+bounces-127192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAB4974866
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA861C216B9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2462746B;
	Wed, 11 Sep 2024 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtcCZsxA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0FD224CF
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023648; cv=none; b=uufQcrVDioABqtHUT/oLonfL5p0OWrj/IArwuAYlhJ1gyvVxZ0vnQHDWOJO7SdVqIjr2g6WUQ+tElkvkTeIinqPWtqe1mZkgkQ5Rkadh7Lx+/JsVNX302kmxeVQr4CM6/fDGWV06bSdiYkskorM0vPO7iLxUbuNBIahSo37KC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023648; c=relaxed/simple;
	bh=KuGV1rIufI5kF4uh/ybrLUwlPr6FgJdhDUHHdr0r4M4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWGpia8utJlx15O70WLSOH/kvQXaQKpK6vqLMfk5EEKwlyhIV7hc0dx2yyVUAbc744ebndSofl/qtLaiVaaA6wG/BktErqJE9eCOP0cPnQGOSrtxlz2dVAVk3QZu5QrmJi36IpPZ+WG/4TcWio1KkEp/p4NIGGTNwfwi1qfuHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtcCZsxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453DAC4CEC3;
	Wed, 11 Sep 2024 03:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726023647;
	bh=KuGV1rIufI5kF4uh/ybrLUwlPr6FgJdhDUHHdr0r4M4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AtcCZsxAjOxgJEnuZjOQTnJGwh0Un5xtDDKFeYb9AP9Cc/2Aa3bt/NO5U7Zld7niT
	 LIvP2PaXmQp8sQRyM5RAtrc5V/m9b78GlR+6gL0pJJw3bQkW8v8lFrNsehITQVOFZO
	 OKLdydE4PHXGQ7kki4Hitr15ZcUGEz/xzEbQhNC/oZ93XsGYurqd3iaJ9baxdBdRyd
	 Y87IlvpOaAaC+WcC4VhqlShgW+ktLBeNOX1Z9TxxshcYJeSluylEwOcFh+KCt33DD/
	 DhPiL2nP7zTph9L1s+2lyoy/pbeZq2IJNLb/Tk7YUP+eDg90SWtfkVo3nkDu1XjYlc
	 lRBKcpYwLkthA==
Date: Tue, 10 Sep 2024 20:00:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Erez Shitrit
 <erezsh@nvidia.com>
Subject: Re: [net-next V4 15/15] net/mlx5: HWS, added API and enabled HWS
 support
Message-ID: <20240910200046.30df2803@kernel.org>
In-Reply-To: <20240909181250.41596-16-saeed@kernel.org>
References: <20240909181250.41596-1-saeed@kernel.org>
	<20240909181250.41596-16-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 11:12:48 -0700 Saeed Mahameed wrote:
> +/* Set a peer context, each context can have multiple contexts as peers.
> + *
> + * @param[in] ctx
> + *	The context in which the peer_ctx will be peered to it.
> + * @param[in] peer_ctx
> + *	The peer context.
> + * @param[in] peer_vhca_id
> + *	The peer context vhca id.
> + */

I'm going to pull, but why are you not using kdoc comment format?
Would be great if you could follow up and convert these.

