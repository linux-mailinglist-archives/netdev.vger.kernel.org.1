Return-Path: <netdev+bounces-58697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE9817E09
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8842B210AF
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 23:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2C8760AD;
	Mon, 18 Dec 2023 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnU5BnuC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4118760AA
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 23:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B8FC433C8;
	Mon, 18 Dec 2023 23:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702941797;
	bh=eD+mMWVhnrwLBVKS3Lz2C3DwZWW9y3tsTe3VW+ISPXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dnU5BnuCLcm5RhYeV72gvye7V9KqY/4yYJlV69YJEKHlW51QxD+YF+TmHB0wy5Ud6
	 ClMPBz+C0do8AOUy39r1eHUfjg4QXiXn7QhgGPQ7ueiJVUL/5rM6CbL4HChgpXofgE
	 KFBfFyeHhLLpv40AC1u/gcRgZ6iTb05Yo6KgF8coG/feg/Stw9OQCat9iwTPES85Jq
	 Xu53R2IMWJOSktKG+0oC2Q1H/5oFp+2Oix1qrcMiKnn+y0VzmI0K9DRQJZllWewU9K
	 GL7hxQOBqtnD2mAaHlrOT5nbFyoGsPNI7WgMVgQGni2Snp6TFoc/xZrkCKZOq7NPlq
	 31DcLogPmGJQw==
Date: Mon, 18 Dec 2023 15:23:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: ethernet: cortina: Drop software
 checksum and TSO
Message-ID: <20231218152315.6d566b96@kernel.org>
In-Reply-To: <20231216-new-gemini-ethernet-regression-v2-1-64c269413dfa@linaro.org>
References: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
	<20231216-new-gemini-ethernet-regression-v2-1-64c269413dfa@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 20:36:52 +0100 Linus Walleij wrote:
> -		NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
> -		NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
> +	       NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM )

nit: checkpatch is really upset about this space before )

