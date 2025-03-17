Return-Path: <netdev+bounces-175430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C2AA65E49
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3E53AF1EF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E3D1EB5C6;
	Mon, 17 Mar 2025 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syRpsLcJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A11C6FF7;
	Mon, 17 Mar 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240672; cv=none; b=uSn/Iyy5mMLA0/+RaslMTj3yEuDZ4t1KoGvnZ2tIPAGVyc40c+SeTaEvipVNZYOx6/uJnKqtx3CY7Pbhkk7w0PKFrXky0g2XxV6Ifj8xe7prOsJP2jjVUNAV9TItllbsxZeR5yh3UdvH2HKZdLWBQwafEH6n4cGvDfY7JUZ4gI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240672; c=relaxed/simple;
	bh=HlITNVvztffv/YhxjM31NZ5/sBOmrPKFljobJEV2PPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw3E1nbfS/iim+N+8VBfjKLCYB5bb48PN0LDw2vgYarHIX4e2PDW+q8YhhBSpz2Ms6FRb303lPaOUEpbvONNPxYhVgMdPz08q0PIHtxk/dZprDkOUFc2K/hbVFYzv9PmCjT4eV+Acqb31qF7dGwzE/hXKtSpA7xLss4gbelbSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syRpsLcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1472EC4CEE3;
	Mon, 17 Mar 2025 19:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742240671;
	bh=HlITNVvztffv/YhxjM31NZ5/sBOmrPKFljobJEV2PPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syRpsLcJNEt1jnJXJNL/GF67SRnQaAKAngx5z9gtQZwgJdAY6EinU+CmwWv9HLu9X
	 KKJz+yCfhi7/eZIU92/m09HTVCpOqk+T6FlxL9giBq+6jTn+9nvdE875XeYK/hSj0d
	 dwwJ/QP82YyCoae1X7Jhf2Z0Hu2uNdTLy9mEo0InvyFhDFs6agRF5y/8qXZkuGTmJc
	 SdOhUsVmYTesLN+54hy1swC4WdVR1zCSjVyP+z+HY8e8SzzNL0Mu1tWOFaWMdU+ubf
	 Nv5nOdF9wLJwodSFVBXsdfvtT/YDE7C0dAbiFEsPL7RTrba3bwi7lK1WC5vl+M21DH
	 rMTbUtj48Jr/Q==
Date: Mon, 17 Mar 2025 19:44:28 +0000
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: skbuff: Remove unused skb_add_data()
Message-ID: <20250317194428.GM688833@kernel.org>
References: <20250312063450.183652-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312063450.183652-1-yuehaibing@huawei.com>

On Wed, Mar 12, 2025 at 02:34:50PM +0800, Yue Haibing wrote:
> Since commit a4ea4c477619 ("rxrpc: Don't use a ring buffer for call Tx
> queue") this function is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


