Return-Path: <netdev+bounces-23570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F097476C874
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D98E1C210DF
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371A566E;
	Wed,  2 Aug 2023 08:37:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A65670
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617B5C433C8;
	Wed,  2 Aug 2023 08:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690965470;
	bh=e7HVn8jnabAhoQs1LJYpx/7sv6qR7TqR5arDP9CPs8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7Sww42EsubRI9/Q1+04p0aLyVZF9ZQVZtbPcKG1nQwqZmk32PTWbd7ogad5w24yb
	 lGnASeMnCm/BNESYJehIaBBfAqL97burELlJ13Kxth22sg/wn+VDzfHz7L2utjMkzu
	 Oyg/zcCFGx625gFZKJ/92PZZUU/CjHfzsQmZVpYsOyxCmKMkFSQeJbnPScdcy4C+zH
	 0CDmd0/dSb4PMt0smPpM7uMASg3g0HjU4VWnXxcBU/72VMc6gs+Rc12G064Zdxls4F
	 awJCbc9Dl8my4HXJBz4EvRG/7n/tEJUo2DREifhwl3KhlbARhzojgrURySyw4h4UBv
	 s+wIc+N8oX8oA==
Date: Wed, 2 Aug 2023 10:37:46 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: Remove unused function declarations
Message-ID: <ZMoV2qYHru4QModa@kernel.org>
References: <20230801134337.24452-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801134337.24452-1-yuehaibing@huawei.com>

On Tue, Aug 01, 2023 at 09:43:37PM +0800, Yue Haibing wrote:
> Commit 685429623f88 ("mac80211: Fix circular locking dependency in ARP filter handling")
> leave ieee80211_set_arp_filter() declaration unused.
> And 164eb02d070a ("mac80211: add radar detection command/event") introducted
> ieee80211_dfs_cac_timer() declaration but never implemented.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


