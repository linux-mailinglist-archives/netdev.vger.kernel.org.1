Return-Path: <netdev+bounces-48122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18427EC9D4
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED28280C7F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613C233097;
	Wed, 15 Nov 2023 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACw//naR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E81EB34
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 17:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFADFC433C8;
	Wed, 15 Nov 2023 17:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700070144;
	bh=JbW47VpDwdRu4c5OuivrKS/Sf1gaYDn+svMHdpgnAL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACw//naRlSgdbF4bo3JspeQ8+Ls1OjiRTsgheudkI7ZAr6FF2krZ+nm20cNXNsypN
	 hkuozuIiCn95u5AZGBCN6aV9cN9s4GIwfaTarAlQfgg/zb0TBDoiug1I3ufBJ068ve
	 h3zs/DZIDp8Tl8xJ+jne9Vdz9H8IWesq1xmf7bCmdw8L/YOpymkln5fuZHc4E96erG
	 d2mwAk8kzj1P9HannKunuCT7u9EfwykWFpG+cyvLdJy+maz7BFqwu2Hg7Y8MysY6BT
	 o19LXzhmKLCd1BlrhsA1YrBT+I5JrklD1DdX8o+NeVfJ7xUAuiOola3tQsuTEIaHx4
	 GbhbdCmbzSShw==
Date: Wed, 15 Nov 2023 17:42:21 +0000
From: Simon Horman <horms@kernel.org>
To: Sachin Bahadur <sachin.bahadur@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] ice: Block PF reinit if attached to bond
Message-ID: <20231115174221.GU74656@kernel.org>
References: <20231113235856.772920-1-sachin.bahadur@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113235856.772920-1-sachin.bahadur@intel.com>

On Mon, Nov 13, 2023 at 03:58:56PM -0800, Sachin Bahadur wrote:
> PF interface part of LAG should not allow driver reinit via devlink. The
> Bond config will be lost due to driver reinit. ice_devlink_reload_down is
> called before PF driver reinit. If PF is attached to bond,
> ice_devlink_reload_down returns error.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>

Hi Sachin,

I wonder if this should have a Fixes tag and be targeted at iwl-net.
It does feel like a bug from the description, but I could be wrong.

