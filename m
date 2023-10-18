Return-Path: <netdev+bounces-42080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 488337CD170
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 02:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0436C281464
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 00:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D208563B;
	Wed, 18 Oct 2023 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbzPDxKx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DB630
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB18EC433C7;
	Wed, 18 Oct 2023 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697590207;
	bh=jwQ7jvookRWsVmWHnth+k7y333FVk0rkH8aUcZkGPOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bbzPDxKx4zbXx2CD9F8RgjQWGH1KGZceLMqbF1yUN+aJC83Xlya8PETpfmPaNxawc
	 pwVqm3TPB4R+bKS/R9gruoT8cNDpJ/tMWsMbPJBtswLbggfsHaUxPMFPxiZPk1jThN
	 SES9X5KN5j816yNJ2TbHfY4W42fySwC4hs3W02pATVGMbxDn18EmYnIvSPdmzequzv
	 r0kA9aFiTAX2MWywgLylSEJwapuXHk2zL8GPdBWX/u+K7ppjF2zeWL4/HZDllniqub
	 B6NqptlvRQJr9Wu5t6mGzp6MrUWjWeeez/1+VRNKOhGc+x9v1CRqWx3gWMr50FiVGB
	 m4JXJ0FvVeCsg==
Date: Tue, 17 Oct 2023 17:50:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Guo <heng.guo@windriver.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <filip.pudak@windriver.com>,
 <kun.song@windriver.com>
Subject: Re: [PATCH net-next] net: fix IPSTATS_MIB_OUTPKGS increment in
 OutForwDatagrams.
Message-ID: <20231017175004.1d4c59af@kernel.org>
In-Reply-To: <20231017062838.4897-1-heng.guo@windriver.com>
References: <20231017062838.4897-1-heng.guo@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 14:28:38 +0800 Heng Guo wrote:
> +	IP6_INC_STATS(net, __in6_dev_get(dev),IPSTATS_MIB_OUTREQUESTS);

nit: checkpatch points out you're missing a space after a comma here.
-- 
pw-bot: cr

