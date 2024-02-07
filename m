Return-Path: <netdev+bounces-69927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C85A684D123
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B74B217B4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7C78289A;
	Wed,  7 Feb 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgoWR/3n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B183A1C
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330252; cv=none; b=Rh/bZTcYGI0u4oAVdjFsPklui3wXn6kfjJfCOmdhRpQ0uPDlhpTu3OYqgXbYZXtSwX/I95AvIHQj0iWjao1y7Yn4InV0tYBs5ZV3a8BYkZlxs1foKWnceN8ViG5ROPrIIaKrT6mITjX3OoGD9TplfKQRM+zwXptSlXDmz3eq7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330252; c=relaxed/simple;
	bh=U+94u1n2ozXXLfie4RZ0zg5n0flvRFT+EzN6rZbkN4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXiIpsvS6+20u24FxyNxf23SwjCs1Z8ZHWkl1XjaKDj6pbkwgW4dH2zvkeBseNvlcEvGj6mrFVktP/A4i12dF+FasrN/sHs9t0EJOdP9k21KzcwpdZviZj/xMS2LtAV/oL5eeT3d4tSqM0bvlWwDg9UVh7svJE77PxpZ8GUbR90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgoWR/3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C66AC433F1;
	Wed,  7 Feb 2024 18:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707330251;
	bh=U+94u1n2ozXXLfie4RZ0zg5n0flvRFT+EzN6rZbkN4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HgoWR/3nzFbOnKMO8KBa/PUw81s+w3ZYkkSvyOWpgeISQAev/gHTqwsUJR79UHFmh
	 8x6HavbFiAkJDGu0O8/mS1pVIJLINO5Lr8SwIEwLu2KlomLIaKeHN5QcvGYzsD77Al
	 1p5FeNxIPFXsDiEDOwClsp+X2UfHJuQY+RjryWHt12ABmh0vwngQtoLnVlGaUAutYe
	 jfjJ7TYgTWw9gJY6CcgejfwVLf52vUcUfPKmKIHhyL8kgFA4AJHM9OnbfgTI0IyTMw
	 I4cFiTh95b65WZLTWG6MhpQOB6YYdMeuHbZ2eauCCsJxFRfzwmQMPz1g9Ag/E+r3X8
	 gDBGvYI095DyA==
Date: Wed, 7 Feb 2024 10:24:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v2] selftests: udpgso: Pull up network setup
 into shell script
Message-ID: <20240207102410.7062dcb0@kernel.org>
In-Reply-To: <20240206-jakub-krn-635-v2-1-81c7967b0624@cloudflare.com>
References: <20240206-jakub-krn-635-v2-1-81c7967b0624@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Feb 2024 19:58:31 +0100 Jakub Sitnicki wrote:
> +setup_loopback() {
> +  ip addr add dev lo 10.0.0.1/32
> +  ip addr add dev lo fd00::1/128 nodad noprefixroute
> +}

Can I nit pick on stupid stuff?
Quick look at other udpg*s*.sh scripts indicates we use tabs
for indent. IDK what the rules should be but I have an uneducated
feeling that 2 spaces are quite rare.

