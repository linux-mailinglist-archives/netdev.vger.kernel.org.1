Return-Path: <netdev+bounces-216182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D21BB32601
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 02:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC491179049
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CC033991;
	Sat, 23 Aug 2025 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFlC4Rma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E207917555;
	Sat, 23 Aug 2025 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909663; cv=none; b=a8hxeYHnVnC82cyiQSeP5b2BvfJWWNDHnaw+yYPwj7ZpCtC06g7EotluS9/82PxiaN2MXpq3+vw/E0Sb8+NvUapZDAb9RAfrS1XUa94KoRFNXAElUVfPuJeamVyAGWaCwEvVkLlaCak0We6CDD+CvZixyqqcSB3d9HA70Wk0zS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909663; c=relaxed/simple;
	bh=2mzoyM2JBNjfl77GWifwuEf7PZ+aIHVWVYOq0Ryj65U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTd7CJzY9I+jJWu4sxxfC2r+qB6/aPlWQMYQrVICZeFQ90OmoKb+VnOcIiHQYTS53HfkZGzR25DUy3vW70Nhl5rvXJnYsITyS/WKWMIsrOD1amgJPZhwj8q+owxqDeNBTecP5wtZJgEF04n0PNvvTYjhm2QIxfHKsHijcDnIl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFlC4Rma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349C1C4CEED;
	Sat, 23 Aug 2025 00:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755909662;
	bh=2mzoyM2JBNjfl77GWifwuEf7PZ+aIHVWVYOq0Ryj65U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WFlC4RmaHgt+2X9BoqJj/TxLhNzSxypS0dcn/BI+JBGJxrK/SCMkk/IuuuqJIzb+t
	 NSZOOfDA6PP9aIOiZ0lgAIcNlors0huZmjTdI/FZKTFHlQxrwriEQpch9kn37eJTML
	 SIqD0kpdC8vQHRGj4eVLNrKHSTd7Rp0xGFuLQCQn41D2urjf+WsH+Vr2RQWC/G2Ge2
	 jNRBSK6L3Un+pMKecgf1klt0/IqXTVYnuhye9ct3Ul1GRV3PC24cpMvZH8owdDNFUM
	 9Y54P7LmS8RBxP2M6uSAjENEMLSCDCA0MEOBZ20fGx/mf4Jnlbw3QwEN4RmoHr0Uv4
	 0SFW59qPb+KZA==
Date: Fri, 22 Aug 2025 17:40:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, Vikas Gupta
 <vikas.gupta@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [v3, net-next 1/9] bng_en: Add initial support for RX and TX
 rings
Message-ID: <20250822174059.4db32c9d@kernel.org>
In-Reply-To: <20250821211517.16578-2-bhargava.marreddy@broadcom.com>
References: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
	<20250821211517.16578-2-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 21:15:09 +0000 Bhargava Marreddy wrote:
> +		page_pool_destroy(rxr->page_pool);
> +		if (bnge_separate_head_pool(rxr))
> +			page_pool_destroy(rxr->head_pool);
> +		rxr->page_pool = rxr->head_pool = NULL;

Please update with the recently-committed changes to the bnxt driver.
-- 
pw-bot: cr

