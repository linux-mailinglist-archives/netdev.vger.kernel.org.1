Return-Path: <netdev+bounces-44494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A588A7D84B1
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EAB2282002
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECE42EAED;
	Thu, 26 Oct 2023 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFoZzxh/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D12E41F
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E71C433C7;
	Thu, 26 Oct 2023 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698330513;
	bh=YzgaZUj7ZwD2nTvz4IUUTkbHe8aOpCBq4y7FYuKdr48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SFoZzxh/rdStD6SKg8rjCt+Yl4FzPX3b4cYze+xMgU/gLUu4pSIVqzQi9GfNQPLdU
	 6A0b/rDx4IGDbekiwsNZ/f1d4vEFdnRVGfeCMeas7s3icdDYg1oWAB28NfjXqctV3B
	 Oli5TFTAbquo8J7Vvnkdy9KIrHt4LQPjDMs9wLsX/w/vVp2isk6Rs8RVp5bG0pI5G/
	 K9hN7R0jVHl2s0+p3fAN9OWGqzOUmTiCNOsCG5b7ePf/85VLV6VYihTqHc43LkSBBF
	 kvRZX/ZDO/2IfINdW3UhJRQRY4+IDBXeLhRNeU8b4l9PmWEUvmG6/lRKFJ9dkmih68
	 EbjQx8/pL20bw==
Date: Thu, 26 Oct 2023 07:28:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>,
 <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <gospo@broadcom.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next] bnxt_en: Fix 2 stray ethtool -S counters
Message-ID: <20231026072830.1202cccc@kernel.org>
In-Reply-To: <1014e04b-5e74-4f7e-b2a5-ed0f8d01629d@intel.com>
References: <20231026013231.53271-1-michael.chan@broadcom.com>
	<1014e04b-5e74-4f7e-b2a5-ed0f8d01629d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 12:36:37 +0200 Wojciech Drewek wrote:
> > Fixes: 754fbf604ff6 ("bnxt_en: Update firmware interface to 1.10.2.171")  
> 
> If this is a fix than the target should be "net" not "net-next".

The commit in question hasn't reached net yet, this is the second time
you're going this incorrect feedback:

https://lore.kernel.org/all/20231023093256.0dd8f145@kernel.org/

> You don't need "len" var.
> Why not just:
> 	num_stats += min_t(int, bp->fw_rx_stats_ext_size,
> 			   ARRAY_SIZE(bnxt_port_stats_ext_arr));

I think it's needed to make sure lines don't go over 80 chars.

