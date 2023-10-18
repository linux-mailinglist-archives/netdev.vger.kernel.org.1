Return-Path: <netdev+bounces-42203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466067CDA4F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAEECB21029
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4891DDE1;
	Wed, 18 Oct 2023 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyEqx+qC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144716427
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D39C433C7;
	Wed, 18 Oct 2023 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697628453;
	bh=cBS8iPeDj6slggeTZUr0Yc9TQoHt7y7o/45kNU8IDbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyEqx+qCg14/Xbq+If6ae+zR1j4HJDc0QV0W35oQcyFjvWOgz5s+oI1YPd7F1kdfO
	 OtMbry/ZzEfK02V3hunNL7jihBznljtaSJENPjbQepqPKOOG5AyQgjgx3Hw+XjtAuS
	 +O95gxyt9g71/7tHJ7ksjx9DWzdwp/LMLhxtYJ/qLqejTklXzjpbSB4F3liHo+nbu4
	 OBxS/RvnjPX7BP/VUdJawXLTYC/FSM8Kq0cnUoJk9mFM7jdVRh/8zUJHL1YagkEGX9
	 o53bmx8QNeRSopaKv29f1EdSSrgfTZcVlx/wxnm5ez76LFsM7c8A1EZUFTL4UpgEP2
	 IsRWBst2J5ZQA==
Date: Wed, 18 Oct 2023 13:27:29 +0200
From: Simon Horman <horms@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] rswitch: Add PM ops
Message-ID: <20231018112729.GL1940501@kernel.org>
References: <20231017113402.849735-1-yoshihiro.shimoda.uh@renesas.com>
 <20231017113402.849735-3-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017113402.849735-3-yoshihiro.shimoda.uh@renesas.com>

On Tue, Oct 17, 2023 at 08:34:02PM +0900, Yoshihiro Shimoda wrote:
> Add PM ops for Suspend to Idle. When the system suspended,
> the Ethernet Serdes's clock will be stopped. So, this driver needs
> to re-initialize the Ethernet Serdes by phy_init() in
> renesas_eth_sw_resume(). Otherwise, timeout happened in phy_power_on().
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms@kernel.org>


