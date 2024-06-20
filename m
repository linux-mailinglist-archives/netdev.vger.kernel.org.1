Return-Path: <netdev+bounces-105268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D4910519
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9F01F24D8A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A11AD9DE;
	Thu, 20 Jun 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caCx3fKP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD81B3F25;
	Thu, 20 Jun 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888189; cv=none; b=qmLZ7iawBspBnpVeku158oHrMbqEugZB+KYj+5BN4fl49gaj73PZAh0i7Ib7KxjE0THfMYX8P7JARKVNGmjez37jC/6YR8m9rartj0xH9CYEafFHGcTpk0cKW/HetkbPJKXoyDJOz33YHMtTZWSIhmKhLm265s/4SydRqkN14AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888189; c=relaxed/simple;
	bh=XxOGHy5sn3zZ32+a9hXAFXf9fhelQMqz0kS5bb7MRmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5C69c2t3Q7CwO0NsBmd2OmFk5XyYi5THP8bGEUGyG3IcKOLrj9yoqcXB4fZe50GHV3+43qyP1CK2y9xeHtgniswLMT06ZMQxG03av5npaQt/SGeBTS6YmmWSzPm/t/Nyo0pwwAjyluof6bzC8wZhiIM67lCi/N2ePHLdyLwLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caCx3fKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7614C4AF09;
	Thu, 20 Jun 2024 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718888188;
	bh=XxOGHy5sn3zZ32+a9hXAFXf9fhelQMqz0kS5bb7MRmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caCx3fKPe+SHuWsEw3WTxV6Zix9eTHDdh4wWCz0UW4viNkZEyW70TJsPwr0I0iej0
	 9XFFWOS7EF0Pqe3jpHyC6SDX3TrMtZwcLGYnvUFH6S1ROD388/Ugy4RmNcqRUYME7+
	 HuNBXNRxgBD8rUX55iVT3PsOlJ3wzMjB3VlzynPhfKgwWtq4wd0zhPv/lhS1IonsIk
	 KO3UD8YCXWYFxOPFZvYryN4vB3ex4NneSWYy0av6S0JfKall1Ioy4cSPIrvHBlBBzl
	 7cUHBZrOUE560ojkjSDIs9roNhJqvW0TgxFR7dXZ6fRyRY1YLCy+Qm5GsJdhhbwZUv
	 BHd0qMtYT0owA==
Date: Thu, 20 Jun 2024 13:56:24 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v5 06/10] octeontx2-pf: Get VF stats via
 representor
Message-ID: <20240620125624.GG959333@kernel.org>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-7-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611162213.22213-7-gakula@marvell.com>

On Tue, Jun 11, 2024 at 09:52:09PM +0530, Geetha sowjanya wrote:
> This patch add support to export VF port statistics via representor
> netdev. Defines new mbox "NIX_LF_STATS" to fetch VF hw stats.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


