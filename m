Return-Path: <netdev+bounces-209122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCA5B0E65E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6866F3B7E54
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D572877E6;
	Tue, 22 Jul 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grdsoTYN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193A76025
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222843; cv=none; b=KzWD+BzefuQ6DclzDAvR83FEJFMNs6YAAu6rZ+6Uiqp2XxN3QcW74hfi8w76PWKkwbdKANcx9vJjPYXTkESA5LLmzoEQA0eQ3KGwPNnvBJFJww+uJHnl+sAXpG5/9JDb+bbyqvGQrhNNsYqgQB/mNuBehF4jCA/wIkN1F57jHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222843; c=relaxed/simple;
	bh=KT0ivhVqdG0XQ1zOIvWfZU8FOux3AzURVn+aHGWdJu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrMaoAPYXpYCIbWJoLds91jaj1MACUEevuRjg/8WFdUyr/2ml07SmnAB3Jq8XWth4VHB5Mt0Lp0Gv+g8UsdBIwDABdounIXQZjQYPSIz9glF35hLHkxuBGIXjlswh0w31D214JXRLmpPdoibbdXVsPec92whtl5km6bYnnCJnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grdsoTYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22A6C4CEEB;
	Tue, 22 Jul 2025 22:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753222843;
	bh=KT0ivhVqdG0XQ1zOIvWfZU8FOux3AzURVn+aHGWdJu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=grdsoTYNWZk/4DIVLzSacQh6ZLLqmT/1Zj8a6x1bJDut6s08h3e3EPR2YhqnrQ8yn
	 G7PaVBr75LY/QzxwfvouiKc3+s0SxdG79NIGvTKL+Tr0EwMUYGSYsgFQ8pUDaJP0lB
	 s76U7dF9z9mibwHNbw1vACGLtlj+VK8UsaZic07jAsbnBqzNIFQTOV3GxoPVTtvbyz
	 n6TuskpSnBcf7tj3LzfzKBbFNMllJXoQgzc6lfIg4h/a02OKcxO/iOFg3PVMUlCat7
	 KINzqlTV7PbnBJD2TkfwURdrV0jD3nKunl7jLlGstDsETSI5cO1INu2XYUlbyExH+E
	 sM9IPPCi6ByWA==
Date: Tue, 22 Jul 2025 15:20:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v3] netdevsim: add
 fw_update_flash_chunk_time_ms debugfs knobs
Message-ID: <20250722152041.053b3953@kernel.org>
In-Reply-To: <20250722091945.79506-1-jiri@resnulli.us>
References: <20250722091945.79506-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 11:19:45 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Netdevsim emulates firmware update and it takes 5 seconds to complete.
> For some use cases, this is too long and unnecessary. Allow user to
> configure the time by exposing debugfs a knob to set chunk time.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

