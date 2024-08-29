Return-Path: <netdev+bounces-123430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22639964D62
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45981F231A2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299DA1AED4B;
	Thu, 29 Aug 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8shTDKO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029224B28;
	Thu, 29 Aug 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954732; cv=none; b=ANd4ougGrrrAaoctRMTCMy4nASl8s557uvzUeZx4U2L+/LwThv0Rn25DrbAOK75WcYJMqNwaGanMH5TpTHdz6wTaf3fbISaoHzj5mby2xGObb/iWMQEaKRzM3wlgjrfBterkuc0ycrODB/c4Sm1f5QGIz11nal4AA/19oAHaplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954732; c=relaxed/simple;
	bh=uOExzRSlD9BQj+x62zXDds7oBhBJAr0xN4KCzmU5XOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFO77Pm4TR6ej48hGH1QuYItZZk5Qdr+CmhQlXq/AxeWVTv2CXNTZSnb9KLAQ8xX5yueJlV25MsJQjU/g+UGC7wjVWnoJNGDMpXI09Xq/fIUpMJyCfV7bGlboZnZmLBn1CFEvAyHJcRIhxykdztkvinUOMR8lthain9I4AQLwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8shTDKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE3CC4CEC1;
	Thu, 29 Aug 2024 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724954729;
	bh=uOExzRSlD9BQj+x62zXDds7oBhBJAr0xN4KCzmU5XOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8shTDKOecCMK9oWx+WOUx9YNZnRqNYuS2VJkoZ1BmF9XgcKuOhVgzArFdLne+9Yp
	 B8mffVAolxORvf/ngDcbmuNCOxkMeFsIrOSCgktSNQkraqH5M7LLz4Ipk9tUDpBGTv
	 4LOFLBj6JtB9sYBpancePK7PA4mIA3Jcpv+VW0kW5+TQ5MdB07Eo0nKhOmwTLdAIF6
	 2qLGF/JrJtbAUg6SxmA/IKGfJICRCFrd/0oQNZesZviROXCXk3L4As7kqMekr2ZU4o
	 OTOZBVp9ePsANlQMNM+L+DCJVUPf26WQUS9drC21h4aA4lDNfjNSWX3+rc/DM9iM9i
	 Cxd1rJK2pZNQA==
Date: Thu, 29 Aug 2024 19:05:25 +0100
From: Simon Horman <horms@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: kuba@kernel.org, marcin.s.wojtas@gmail.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2 net-next] ethernet: marvell: Use min macro
Message-ID: <20240829180525.GW1368797@kernel.org>
References: <20240829031906.1907025-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829031906.1907025-1-yanzhen@vivo.com>

On Thu, Aug 29, 2024 at 11:19:06AM +0800, Yan Zhen wrote:
> Using the real macro is usually more intuitive and readable,
> When the original file is guaranteed to contain the minmax.h header file
> and compile correctly.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
> 
> Changes in v2:
> - Rewrite the subject.
> - Using umin() instead of min().

Sorry for not noticing this in my review of v1, but, looking at git
history, I think the prefix for the subject of this patch should be
"net: mvneta: " rather than "ethernet: "

	Subject: net: mvneta: ...

-- 
pw-bot: cr

