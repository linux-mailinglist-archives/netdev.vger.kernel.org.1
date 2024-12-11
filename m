Return-Path: <netdev+bounces-150979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC389EC3CB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9368D1693D5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0868A20DD5F;
	Wed, 11 Dec 2024 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j05yg8aN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1E20968D
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889328; cv=none; b=f2ODkvg+Dzx3E6bTKhLBNrVBDUdHy0UTHYzc6hMcVd/YcD+o4bAWUiXx/kcGQw54eY2bq4mBHDPE1qtEDXarJ2JGa3iMxHudyigTM2C0Wd8glOXuwZS68U8YdRxBalnprpYaCka4RFAKdoWIKr248UxOaGkCT0eQzc7Or2rz6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889328; c=relaxed/simple;
	bh=FHWHVqR/U5k6MGSypu3nGY7F9h2oOPqFnJNrMP71zMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGJkkS5AsnlCZEGg1tr9RFS88vgCBJ7zMSENe6nJuifMPkAePARknD0S97KHZX7ihmFCCKG5RrKtPyNXS9W/vx+pFXwrovTFE+kDBgd2eN3pxKWw3qjxcTjkyKezA1RpwmwElvgPlf0HpkfZaECwmSzecDjA7RauSa1jcACr/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j05yg8aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748F3C4CED2;
	Wed, 11 Dec 2024 03:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733889328;
	bh=FHWHVqR/U5k6MGSypu3nGY7F9h2oOPqFnJNrMP71zMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j05yg8aNcA39Kz3xdj5WXf6cQdp42z7eKazxIBb/wmjnEX/pcExksy+eAdHDipiqL
	 k6dopy4YGfxK7N/5m2K/o8IfEJoAywQBRK2EAxaFnStU8qfanaH78mJukMUwbNpNtr
	 b3LiIKXD8shDIbktZRvRtLxHAiYQmrF38T5UktU+cNbRRC2BDCIFcJx8o3FX4xGLIT
	 5kG1JeLtRwmSiuFeR0bNpWq4WJjEDwBo2GhopqN0GZ/uFxSQuJ+vwhYvXiLNDsKXgR
	 i9wil72WLG/mNVOeEX82w47nXkwXW/TVXeoC1gMTvoX66AqAWfIrgakhU0V1kucJjp
	 OGKRAJpKJMohw==
Message-ID: <1912b20a-1bb5-4aa7-a698-09c8efccdee4@kernel.org>
Date: Tue, 10 Dec 2024 20:55:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] ipv6: mcast: annotate data-race around
 psf->sf_count[MCAST_XXX]
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20241210183352.86530-1-edumazet@google.com>
 <20241210183352.86530-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241210183352.86530-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 11:33 AM, Eric Dumazet wrote:
> psf->sf_count[MCAST_XXX] fields are read locklessly from
> ipv6_chk_mcast_addr() and igmp6_mcf_seq_show().
> 
> Add READ_ONCE() and WRITE_ONCE() annotations accordingly.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/mcast.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



