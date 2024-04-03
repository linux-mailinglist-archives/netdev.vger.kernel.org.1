Return-Path: <netdev+bounces-84436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3EA896EF8
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21A81F211B1
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE24487B0;
	Wed,  3 Apr 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFTNcF9D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76FA200D4
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147948; cv=none; b=nOtP9Ht3Xzc3tMYfFVFXksgp2uazwwyoA81Qy8uqbMWpZV3tBo5YiFtX+AVxPQ3iQqegKnJbP7UNAZDjPiKY/2z0ygprLtEr/t9D5oOq0F3HLFhmrIGI6WpxvdPMzoHCkY22CkFvmr15ZnNsE0bFsR7KPTqz0dU1DGaWNmZ7vzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147948; c=relaxed/simple;
	bh=HH5gSsPR0NvgxX7qXLK4zyhvXmosnR+kBVsE5ITgZ0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCv1BbhYC29TyHm7ihOHG/2jBS8/Ugu3p4IWOzGj4BjyRCwTXhMrSJl1haNftSzyWwe3TxuYbcPKg0dpR8gfR0es23z2t/P7N0Gc2V20PiJBVLJ10ERJEF1xK2Rp9NfQ1pOKmRZhOyTgqopuoL7GmsETJUeLLGfy+tgaddgDCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFTNcF9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF3EC433C7;
	Wed,  3 Apr 2024 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147948;
	bh=HH5gSsPR0NvgxX7qXLK4zyhvXmosnR+kBVsE5ITgZ0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFTNcF9D9+sqx7FTthxGqOWTg7SrY7JeeXppdoJC0ofmPqk5Os0/hmD+2A8JCWSsm
	 AtkZV3bGZOvgexwydQs8HdDo9RBoCktyiNRYE0auW3P15xJZ1GyuKLrOsAAl6lWbDj
	 cOTD6lCBRmvYjUKexRF6Ty/iydgD3O+NH7g5WpdlGmOwDp6ByX08nXWCH8UoKDsTEl
	 gOl1/sHok1PO9L+IHFGPdBs1atNhmF4qxQtxCDbObxbjQESBnZ1PWkg/GItTmP2z6U
	 DNXxpwGXe+Ft70B/z7b6X5hoPEEt8vSRAFVLJdQPJWJHAB3gNbV9jrs9nWei2KPJpV
	 WUo/bkumxSG8w==
Date: Wed, 3 Apr 2024 13:39:04 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 08/15] mlxsw: pci: Rename MLXSW_PCI_EQS_COUNT
Message-ID: <20240403123904.GD26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <b08df430b62f23ca1aa3aaa257896d2d95aa7691.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b08df430b62f23ca1aa3aaa257896d2d95aa7691.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:21PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Currently we use MLXSW_PCI_EQS_COUNT event queues. A next patch will
> change the driver to initialize only EQ1, as EQ0 is not required anymore
> when we poll command interface.
> 
> Rename the macro to MLXSW_PCI_EQS_MAX as later we will not initialize
> the maximum supported EQs, this value represents the maximum and a new
> macro will be added to represent the actual used queues.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


