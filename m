Return-Path: <netdev+bounces-38150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCB17B9934
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id CEC16B2097B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F73C366;
	Thu,  5 Oct 2023 00:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7PqAFgE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724327F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFC6C433C8;
	Thu,  5 Oct 2023 00:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696465349;
	bh=QhmIDdePJH/MFfwoOkD5QMcLSRTRTXii4788qVz0WU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j7PqAFgEV6intBs4605q5bPSEiLLvaIfo7xx8KgtNcPfiZ+OFmkZNwK3JlUigIqzG
	 nRsoeXgJd4XMLT60qXY6MZbvcN8KPBiSjNEtJi79e4pHorFq0VMgseCcRLPisHmk0i
	 B57vlJW0MJ4ztRIh/WqhoFnZRvIpuYMFG5HpOGERRd9WSQ5vlsOqmv/Y817TLoG1Kl
	 Z5fRvDOSiP1fsVuNOwkbfGK2PpKIMsfwObf7W/nwyTwBDKA9XCvjOFuIr85bzPrnrG
	 tlqOzEHfw4lZcuog8qVVzfZ6fXwpZx7kd3RbnacKXh+gV2LFjnVyDDyPGt39aKI6u4
	 NsAQhB599S5CA==
Date: Wed, 4 Oct 2023 17:22:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver
 Updates 2023-10-02 (i40e, iavf)
Message-ID: <20231004172228.211ad344@kernel.org>
In-Reply-To: <20231002185034.1575127-1-anthony.l.nguyen@intel.com>
References: <20231002185034.1575127-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Oct 2023 11:50:31 -0700 Tony Nguyen wrote:
> The following are changes since commit 436e5f758d6fbc2c5903d59f2cf9bb753ec77d9e:
>   Merge branch 'mlxsw-next'
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE
> 
> Christophe JAILLET (1):
>   iavf: Avoid a memory allocation in iavf_print_link_message()

I don't see this one on the branch, I'll apply from the list..

