Return-Path: <netdev+bounces-43186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF737D1B55
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 08:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD2282558
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 06:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFCA2112;
	Sat, 21 Oct 2023 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZQOs92d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C91C16
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 06:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E436C433C7;
	Sat, 21 Oct 2023 06:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697870365;
	bh=ZFrkGj3HfVX5D6A8lJlOOTL0I6Gm0CMc2eljQxuFyOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZQOs92dnUdbAB57OG1wcF5v0uSPGWLeEvu798eAkraiAliAHXnJYhFM2C3HJ9BIs
	 muv74KWET+v0qGdU06/QGfeGHBoRvV3ZKJB/8bf/HKm/4XdXUXmN2ZHdiwY01WxpGw
	 RA27g77YV/OrdbsnvEG0TxPG35xMEJCc4aE5Ky/7HW2AySsjQpJLhrPr1CTvMc7q1D
	 xC8h4EltzQJe5sdI4RbO83Z1mMHBRnW5hlxkiZTF8tR2N58c1BYKfQG6jqfTn8bPgL
	 ddRsJ/SDtZGW1mEXLa4nQP4JZGc0fdoKvIyRt16evFH5IcJQOcr8q8zqk5vCq8YtJn
	 bVwm2OReHBC5g==
Date: Fri, 20 Oct 2023 23:39:23 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [net-next 03/15] net/mlx5e: Honor user choice of IPsec replay
 window size
Message-ID: <ZTNyG1hgZhH6xmjU@x130>
References: <20231020030422.67049-1-saeed@kernel.org>
 <20231020030422.67049-4-saeed@kernel.org>
 <20231020184819.73bddc4a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231020184819.73bddc4a@kernel.org>

On 20 Oct 18:48, Jakub Kicinski wrote:
>On Thu, 19 Oct 2023 20:04:10 -0700 Saeed Mahameed wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> Users can configure IPsec replay window size, but mlx5 driver didn't
>> honor their choice and set always 32bits. Fix assignment logic to
>> configure right size from the beginning.
>
>Fixes need Fixes tags (or explanation why users can't trigger the
>problem which seems unlikely given the first word is "Users"?)

It felt to me more of a missing feature rather than a fix, but originally 
Leon had a Fixes tag, I will bring it back in V2 along with Steffen's
Acked-by

>-- 
>pw-bot: cr

