Return-Path: <netdev+bounces-71807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82A8551E2
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6020A291279
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A23127B51;
	Wed, 14 Feb 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C26yjwf9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4885EE78
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934492; cv=none; b=pD88xo7hY0LbuXDP5sc8MGTRjH56Bry3zZO6DsaNUkhZb4sE4r5hly1Jb8Bn8t485jqM21y0rvLg8hVMfXhvqoFXeW4EvcOF7p4iJ8MPcTJHqiJhshd4mYvRE8UbFBUiFuGk2GfmjOcQKYTL0usLtuIWDXUg+JfRRMLuKAGJDVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934492; c=relaxed/simple;
	bh=hgrNm3dEPCYY2Rgg/MhflH5B5qaVovGlZSH+/gZ2aA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EC0+/cl9nF2p5vZEgCrzuqv/OxUm0iApVoshPNMHH/wp/sZSYK83qTRuDbOh19Gm6yjS1AlT3xEXiFj9A7aKyJv+O5+lmtSPJhoh0ZDuosb7RgCy+x7uvhdht4nMrONUMV+a3PTDaFMhmQU/D9svfbqimnN83Jbb3MXCON6msxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C26yjwf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4E5C433F1;
	Wed, 14 Feb 2024 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934491;
	bh=hgrNm3dEPCYY2Rgg/MhflH5B5qaVovGlZSH+/gZ2aA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C26yjwf9FrhsmRy6+OIpsTzwE5nM2eMavvzgUw85oQzkd7x1z10AvnxAXy56BVWz+
	 pfpUVwqJuKsrrIsGd1uKUl7lyW0aSwIyBeZvqgT7nEv2E5erVvr9ZLYb35ZABskseQ
	 FciIwLoowMlvBMLUboIk47Fyxmzudn0hyXKHOtIvaTFq/Qyl/WbGL4g+7MRxQhUKob
	 pf2VkYkLSnYOGhrd49WzYUFgRG0UnbDoxnCmN6M9iOhr16qA5SJ+sS8JnF+5AxJ0Ss
	 VAVtQt93tpbrACSpyXYpOWALlMDHhlsbjDjxUf/Dr6eAF5nvBkbXX2VUpuS94gpsbr
	 iDklMTpyJdD7Q==
Date: Wed, 14 Feb 2024 10:14:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next] net: page_pool: make page_pool_create inline
Message-ID: <20240214101450.25ee7e5d@kernel.org>
In-Reply-To: <499bc85ca1d96ec1f7daff6b7df4350dc50e9256.1707931443.git.lorenzo@kernel.org>
References: <499bc85ca1d96ec1f7daff6b7df4350dc50e9256.1707931443.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 19:01:28 +0100 Lorenzo Bianconi wrote:
> Make page_pool_create utility routine inline a remove exported symbol.

But why? If you add the kdoc back the LoC saved will be 1.

>  include/net/page_pool/types.h |  6 +++++-
>  net/core/page_pool.c          | 10 ----------
>  2 files changed, 5 insertions(+), 11 deletions(-)

No strong opinion, but if you want to do it please put the helper 
in helpers.h  Let's keep the static inlines clearly separated.

