Return-Path: <netdev+bounces-217565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F82B39113
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E221892065
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2152189B80;
	Thu, 28 Aug 2025 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ5aL40n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC630CDB8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344757; cv=none; b=inPHTSpKtOxkV3qiNVhhV+3JsLKoeMC4oqMY3C7RX4pOroGy9vVHTvThKtdnpuWfWVJINdQqCefREtXGpgia/JirRWvyxz+VJaajzdi6PHAoXYs0Z64VmlDil+GBIMrNHi1ohmtFLmHU/inZNPV3nDRXasjNTjcmeETnamm74Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344757; c=relaxed/simple;
	bh=JvcmOE/1v7HTPxqmgveaFG3NuwFzrESwQk0Thn3UIK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSzQYZC0/JQeU4/U1fvq8QI6oMyPljCwoTzHMeVLWETBEEcxQQ1U8uppFAaausW5Zg1Jkmxr+xn+5nu1uqxtIOd4aGGMf/+DJ5CLFzWMAF6kSK5hV5Pp8hTReajQcA2y0JgTOI9bthVNZz9DmH2fTzpTZZwB3M+E+Puc1NrNMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ5aL40n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A59C4CEEB;
	Thu, 28 Aug 2025 01:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756344757;
	bh=JvcmOE/1v7HTPxqmgveaFG3NuwFzrESwQk0Thn3UIK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQ5aL40nPGqqNJP6uz3jm80IednpfbxdFnPJXBqFp8fK4Q0yt5smGVNBs2vqbsIhN
	 22GYnTqjJKa7HptM6LgJNSsVJFqLHI0CZvPCA7NwL2S9lOTT0qo6NX5G49l7DXvo4+
	 mNB1l2+hEbj/iJdNToxY8YcQho3HZqZ4UUM74YW2y6i7F7B5DcfiU+lhjRtcSIVzoX
	 L3i7FXfrB9Ql6d2nVBLtl5IS6dT68KbpWhEv4x4ywe75jzxE9gmMHDc+6jwjzllj21
	 DVuXbWs57sG6rb4pqiYHW/OijxmzEHI2R60nUocVMj9cbpRQL/d+/hQzBP5pZ3hCCR
	 tis9bQL+Ikdxg==
Date: Wed, 27 Aug 2025 18:32:35 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	mbloch@nvidia.com
Subject: Re: [PATCH net-next] eth: mlx5: remove Kconfig co-dependency with
 VXLAN
Message-ID: <aK-xs-EwJ15kfuqu@x130>
References: <20250827234319.3504852-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250827234319.3504852-1-kuba@kernel.org>

On 27 Aug 16:43, Jakub Kicinski wrote:
>mlx5 has a Kconfig co-dependency on VXLAN, even tho it doesn't
>call any VXLAN function (unlike mlxsw). Perhaps this dates back
>to very old days when tunnel ports were fetched directly from
>VXLAN.
>
>Remove the dependency to allow MLX5=y + VXLAN=m kernel configs.
>But still avoid compiling in the lib/vxlan code if VXLAN=n.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Nice improvement, Thanks!

Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>


