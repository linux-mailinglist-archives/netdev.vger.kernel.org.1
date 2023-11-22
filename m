Return-Path: <netdev+bounces-50089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9694F7F4921
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73381C20B11
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F9F21A15;
	Wed, 22 Nov 2023 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag/PjrsQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E84E619
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34C6C433C8;
	Wed, 22 Nov 2023 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700664089;
	bh=PXaGcdCLz162ZThgR2HgL67UEEx4ALPdQ42WRqqkm0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ag/PjrsQJuNC9l5AL3JqroNh618QX9q2uEo8Vr5c+z5+JbBZOqtQ7ELTVr9SJfZuN
	 0rmtsZPgSi93mjUXYd5bVKa4f7jvmcTAZgQD4ZnNbwiuKHe0RMTE8hhegHIwdUOerh
	 pHuYrJOZz7A3qqmyptvJxmHS7GftzbMP1xGDdYZ2PEFIyd9b1nd8YorlYdhkIFLhQ+
	 xltQQWX7u8DfYWh8ZgBnp6gatm+yWOGN6r0uZfq8BUOU3uU3spe7WmsC6ZsyyZPvjH
	 vFoArLLwkOrhj8zZUH6POGb8Tnn5Na8q8ZGFnY5v9phkz1u47OV+kedGIVXMB2L55b
	 0Qnvp6LJ8MMeQ==
Message-ID: <9b367e90-17bc-459b-a8c9-e13a7a65ca8f@kernel.org>
Date: Wed, 22 Nov 2023 15:41:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/13] net: page_pool: add netlink
 notifications for state changes
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-9-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-9-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> Generate netlink notifications about page pool state changes.
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   Documentation/netlink/specs/netdev.yaml | 20 ++++++++++++++
>   include/uapi/linux/netdev.h             |  4 +++
>   net/core/netdev-genl-gen.c              |  1 +
>   net/core/netdev-genl-gen.h              |  1 +
>   net/core/page_pool_user.c               | 36 +++++++++++++++++++++++++
>   5 files changed, 62 insertions(+)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

