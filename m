Return-Path: <netdev+bounces-193033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 599CBAC23D4
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F9F1BC7EC2
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF321293443;
	Fri, 23 May 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBsglFCq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3B29293E
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006857; cv=none; b=KPQPudOYDBYhCdlG/C/8MGUq9/DxZKzQuUEAGTPoXUl9w27lH7w2CoLiDxCFzZATD2khS4UyYqBVLM0nvxS+DkKn02Z8/bisnIqK4JhuYxzuSeOuaxqieaCdTV/yjNA6vBTJnwaAgklBxsTeXS9iXjqWLROYZ4BBW9vdZlsUIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006857; c=relaxed/simple;
	bh=dAOtIe3XvK8U32aX8pNmPlDlY8BxUPfeW0hUyFXS3tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNeYTC4dG+ntXzgfVpi2F2t5qPWrSAVyWWUEp4OYnGRrxaeXlrj+DIMBwL5usu89Xg9DVXUym+iIWElJPU8MWjF2SIwrZiG4d8GCK6aKiUz/Bq6CIUAR0WQ/RxxqW1VKhFz7HZKfmXDUHmzUlyweFETvo8GDb+GO/1jCmreuDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBsglFCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879E8C4CEE9;
	Fri, 23 May 2025 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748006857;
	bh=dAOtIe3XvK8U32aX8pNmPlDlY8BxUPfeW0hUyFXS3tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBsglFCq11wuqPspNRsMPDHLCLdvcRhY/ntWfOPpDv7tAdS6fe7IUnsoqTx0JO9rF
	 Sk1pB6DeG9Nv9JqMGadOsoqTQlW84hb052zsNSvboBLDUmj1Tr5USVoIg7xNXpw8fu
	 0CiF2XR7dLYlCpmWFY+3HpcDEzf//MmTUzO3/IGOjE33EsdtXDft1rQfSZ1/4erqC/
	 00/t5nDyyEK2Wi7IGGgI/9iEIJqbz/cn6ILzIpwjZgBsEuFsjjFmPjnw2bUnmMse3c
	 AaUm3BBih8abMGuwGGrbleAcyNNwMUrgSH25DxW7yd/3iZrJgagp9BUQ3uCvJVq5Lf
	 pe0XhsQkx83Yw==
Date: Fri, 23 May 2025 14:27:33 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 2/2] net: txgbe: Support the FDIR rules
 assigned to VFs
Message-ID: <20250523132733.GW365796@horms.kernel.org>
References: <20250523080438.27968-1-jiawenwu@trustnetic.com>
 <BE7EA355FDDAAA97+20250523080438.27968-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE7EA355FDDAAA97+20250523080438.27968-2-jiawenwu@trustnetic.com>

On Fri, May 23, 2025 at 04:04:38PM +0800, Jiawen Wu wrote:
> When SR-IOV is enabled, the FDIR rule is supported to filter packets to
> VFs. The action queue id is calculated as an absolute id.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
> v1 -> v2:
> - Rename i and j to index and offset

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


