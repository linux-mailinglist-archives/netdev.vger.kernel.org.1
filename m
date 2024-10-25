Return-Path: <netdev+bounces-139053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8F49AFE16
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB69B1F241FC
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEFC1D5AA2;
	Fri, 25 Oct 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpBXfALn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D1189F32;
	Fri, 25 Oct 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848090; cv=none; b=iNxJUM0AezVeOqMJCYmB1PIuIET5vkVhGRe8oml0lOyVFQ/NoZ7BZqV7Ny6hxymLRB54tx67TYMprHqtPRe1Zb7k1Ilp2zv8YcXSSeGB7fXhfSRIazBp1HatfNMWpiOSXRR8n02IwiaadTVMVONEDkuHOFhbbfU5QToinfgOAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848090; c=relaxed/simple;
	bh=Kjy+AdUAhMvp/ILbNHUhzlJpnYJeglFdr6e7jo9fkOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykwr2N0uHWH15akSDFoqclXbghsuAJSkrOY6l1qHF6TpTdFhBr3OSHapS2LW5J0AjYe3nPDY5aw2D43cACbTO7mcFz+YaKsOwvu0tkV/B8NfdIqMwJcEtdW0QeLcoUMeWjykzieGqo0nf54klUs4/SadVnma5WJj0Y7l+3YEtio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpBXfALn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37012C4CEC3;
	Fri, 25 Oct 2024 09:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729848089;
	bh=Kjy+AdUAhMvp/ILbNHUhzlJpnYJeglFdr6e7jo9fkOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpBXfALnkkcbFsXFAXrUtEQD/1ekPtzMCha5yXvJhU5dFaJs+Y3F9lJ6X28hLKhkt
	 IOWql/yRJSZxSSMG3GEc90SxPu573cdunElyvvR1XAlnqbSl7Y12CJs9ltnrSxbeLm
	 dOZXwQKcBO6s6iCw/8y/qOxeTT6fnkE+SsbI8euY0QRDy8/EnkFYEapp6+DHJQZtpS
	 Kc81JApB3zu6OixSMJ4TJGq2a58nNczySUoKDn4HPXsBSPvOt5EMgaIk/z9dQsn6qL
	 Wp9D3Xg7XHjOfB4xN2u0DGaCL+y8Hi0XKOc0MuugfbVBDHD2/aNa4cMX83QKRmTHq5
	 k+mNj6gkjE3Eg==
Date: Fri, 25 Oct 2024 10:21:25 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	"supporter:NETXEN (1/10) GbE SUPPORT" <GR-Linux-NIC-Dev@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shahed Shaikh <shshaikh@marvell.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: qlogic: use ethtool string helpers
Message-ID: <20241025092125.GK1202098@kernel.org>
References: <20241024195534.176410-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024195534.176410-1-rosenp@gmail.com>

On Thu, Oct 24, 2024 at 12:55:34PM -0700, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../qlogic/netxen/netxen_nic_ethtool.c        | 14 ++---
>  .../net/ethernet/qlogic/qede/qede_ethtool.c   | 34 +++++------
>  .../ethernet/qlogic/qlcnic/qlcnic_ethtool.c   | 60 +++++++++----------

I do suspect some of these drivers are quite old, and
we would be better off restricting changes to bug fixes
and updates for API changes, rather than cleaning them up.

That said, these changes do seem correct to me.

Reviewed-by: Simon Horman <horms@kernel.org>

