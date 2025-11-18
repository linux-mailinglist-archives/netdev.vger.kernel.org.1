Return-Path: <netdev+bounces-239314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D711C66CCC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 25B0429CBB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E53054D9;
	Tue, 18 Nov 2025 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM8L7t92"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788E2304BC1;
	Tue, 18 Nov 2025 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428282; cv=none; b=U+A10MQUrmY63VYyI7XaBoUNRISYagTXK6uNNK73nKNUMtbE38hDCFTR8cAE2fCH1ThVTNyEnS2SbfB9vE7mJYDQL4Olzu9yz/QdBQ9ba+tzJtNOvXw004snfVxbcwsBJ0E/IqQPmRhx2E06EevBIorfty9y4K9g2uXTg4JGYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428282; c=relaxed/simple;
	bh=0D3DzMI6AUIyGLT1xdmK4Dy/4JexzpPUB0Kp2adQ0UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehB4ZfDBPAf1/cAs5YARQTkecDkO7b97xMyWMwwEduZ5cmsUti8xCzx6CX8V4LUruzW7MbXGiZANDKO+xPTd++o6DZ8tdwDBp7FUMNtk0NbwnqfoZTkFgKsf4UF1TtMtCjvkoqZbvVjfKNfKcdrtPeLFnxNIsjW5viODZThobwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM8L7t92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE56C19424;
	Tue, 18 Nov 2025 01:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763428282;
	bh=0D3DzMI6AUIyGLT1xdmK4Dy/4JexzpPUB0Kp2adQ0UI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NM8L7t92yKFHf7+FVHkbaBbAeXbCtuAnpgeVP5SmipJ1hhhmoV6+WCmwJmDHmGjDW
	 0nOmQqwBeE40h4vbFhWjR5RjwyB1DCcx7xLxWJkvVFs3zhq/BJcUNOxvyUz+zjy8m6
	 QnRef9bt0kkOKruXKTBQzJaZIX3pneFtrcT5hX4jGerklHzbJdCfqfOujgVc8SBvc2
	 z0pW8yPHGdnK7GP3NNW4lYLsv/UCYVXRiRVtD0b1e33SPZ8YQEVmwRXBzkEWOhrOs2
	 EJgZgWtZoga12b/ZHxL16GPdsUH1SrVvtPZ6KrC/gKDm4mTVGsHFiBfxMluVZy4Ynk
	 KptRZNATLV/6Q==
Date: Mon, 17 Nov 2025 17:11:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 eric@nelint.com, Frank.Li@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/5] net: fec: do some cleanup for the
 driver
Message-ID: <20251117171119.7a17ff04@kernel.org>
In-Reply-To: <20251117101921.1862427-1-wei.fang@nxp.com>
References: <20251117101921.1862427-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 18:19:16 +0800 Wei Fang wrote:
> This patch set removes some unnecessary or invalid code from the FEC
> driver. See each patch for details.

Does not apply:

$ git pw series apply  1024201
Failed to apply patch:
Applying: net: fec: remove useless conditional preprocessor directives
Applying: net: fec: simplify the conditional preprocessor directives
Applying: net: fec: remove struct fec_enet_priv_txrx_info
error: sha1 information is lacking or useless (drivers/net/ethernet/freescale/fec_main.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0003 net: fec: remove struct fec_enet_priv_txrx_info

If there's a dependency in net or on the list please wait for it to 
be merged into net-next.
-- 
pw-bot: cr

