Return-Path: <netdev+bounces-232296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF8EC03F49
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC241A40A1A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 00:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D3450FE;
	Fri, 24 Oct 2025 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE5c04yZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD44A32;
	Fri, 24 Oct 2025 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265523; cv=none; b=eGWXEvGiKSsCpECpdeTXtCI0SSvnFDILD8Fj5WMKUIIwwMflaDAVBYa9TZv8cKTt5FOaCIKMhFuwG/xTIabfnkQtevwqidGptn6VgZLciSX3SiOtJgKYbiM4s4ql12JvVl6CQlshNDlbQ2FP/IeWjkx25Ef2S2NkibKwOCaKMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265523; c=relaxed/simple;
	bh=6tSJtK6i+RJyhHukeEyUwOzdO68eJjjV0xRcMR7d4TA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1RxqY/A5bchTaN8ZVV5j71bodhnWU0J+zGGGuU28SIu4VoyDGiAvTikPHNAdZHR4ff+Q9yosIxLEuZkoS1kvPtCYMIfwywhE4T9toAwNS4ehDDxrr8Ttpvr75FayMKthRYNW3X8vbp/apC1TR+dTZ28tRHr9WfrcwW1vfkBAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE5c04yZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2CBC4CEE7;
	Fri, 24 Oct 2025 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761265520;
	bh=6tSJtK6i+RJyhHukeEyUwOzdO68eJjjV0xRcMR7d4TA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mE5c04yZgxo+W50HAyd8H+9N70RlT//P7co9MqigzSJ4qieTK7i4+QqqpJdKjt3De
	 wcr54SQZQ9bzQbsTXbOeEYNjfhslpD2w5q/5BRZXLIiJtd/w5BWIL4vpqalFKsGpaN
	 Mg6RxmAGKXuA23ULHbU/ATgi8Y2vUHW+uMbJLbTS8Ofck3PK5WXmGaUKxevYxXcJDg
	 ljJ9MzIJRPw+XAcYdU9In2sqriAHCSoc1+GsoQZ4jsQKJnBulI10XcPlrNTvHtdh+r
	 JxruxegqqWBCfCi0JoeowSa3j4Ey7Kj+oLaQQuqwi90g026asyVdJHkRT+p5F67waA
	 4PZ/DJPwmr64A==
Date: Thu, 23 Oct 2025 17:25:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20251023172518.3f370477@kernel.org>
In-Reply-To: <aPdx4iPK4-KIhjFq@kspp>
References: <aPdx4iPK4-KIhjFq@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 12:43:30 +0100 Gustavo A. R. Silva wrote:
>  struct ip_options_data {
> -	struct ip_options_rcu	opt;
> -	char			data[40];
> +	TRAILING_OVERLAP(struct ip_options_rcu, opt, opt.__data,
> +			 char			data[40];
> +	);
>  };

Is there a way to reserve space for flexible length array on the stack
without resorting to any magic macros? This struct has total of 5 users.
-- 
pw-bot: cr

