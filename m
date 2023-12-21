Return-Path: <netdev+bounces-59806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD79581C0F6
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 23:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2488DB232AD
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E361977F34;
	Thu, 21 Dec 2023 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBNa+IKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30477F12
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 22:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D2BC433C8;
	Thu, 21 Dec 2023 22:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703197534;
	bh=8brs7enjKHnPejU3w6Tv/xKzZ2Q8G02i1jZ8f7zx38E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBNa+IKJYd4Z/hQzcja8uUz05bnLSDWjtAKjgAC2ykT5+ozz/BNXyTTAXONsKfV8O
	 6PfT1NAHBjRxugjvCVgxCpyKipaKwi7/6yhNhK85QkKrnoL/KqyRyVwAV0ihzUAGBN
	 9vosLC0k3HVAhW3+NDX+QOOxHTCCw2Kzyigyj4eBdSoT/X0ufk7efGDJxkxtxxemD8
	 5weK24euw33W0msEAS0KE06SRDlHz1BLP84Jzkf6uXXLxcsUqL18ZBVxPJiq8j1+5C
	 R0AGZuLVtkp7T2DFl+Tlo6kitv7REzDewmsatOMegK3a8IKnycTLviU2CaYfEcNu6G
	 4qFzEqIDs8TJg==
Date: Thu, 21 Dec 2023 14:25:33 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Armen Ratner <armeng@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [net-next 15/15] net/mlx5: Implement management PF Ethernet
 profile
Message-ID: <ZYS7XdqqHi26toTN@x130>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-16-saeed@kernel.org>
 <dc44d1cc-0065-4852-8da6-20a4a719a1f3@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dc44d1cc-0065-4852-8da6-20a4a719a1f3@amd.com>

On 20 Dec 18:45, Nelson, Shannon wrote:
>On 12/20/2023 4:57 PM, Saeed Mahameed wrote:
>>
>>From: Armen Ratner <armeng@nvidia.com>
>>
>>Add management PF modules, which introduce support for the structures
>>needed to create the resources for the MGMT PF to work.
>>Also, add the necessary calls and functions to establish this
>>functionality.
>
>Hmmm.... this reminds me of a previous discussion:
>https://lore.kernel.org/netdev/20200305140322.2dc86db0@kicinski-fedora-PC1C0HJN/
>

Maybe we should have made it clear here as well, this management PF just
exposes a netdev on the embedded ARM that will be used to communicate
with the device onboard BMC via NC-SI, so it meant to be used
only by standard tools.

Thanks,
Saeed.


>sln
>

