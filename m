Return-Path: <netdev+bounces-26384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34C777AA5
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3891C215EB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692AC1FB55;
	Thu, 10 Aug 2023 14:25:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD3E1E1AC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1FAC433C7;
	Thu, 10 Aug 2023 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691677511;
	bh=6cGOvNoykusDaf6Of5RjamYUXKMze3La+qVxd6f/ihM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oeUjikqDD0vlkCHVBso+yDHIalbbekvyd8GI/r6gRirQ3QYapq/cRvZSfjYunSP84
	 VjIA7W42EALTh1Ci0C8s5nWdycAlhbeFuDwQSLyKIcp1PhDMsztNC2V0VptWBBa95b
	 l2dzl53uwt7WAMyxdjCh3u2V2sPWqzSZhk5vqY4AyDKTe+/IWv5+p57jIW74JELOMt
	 yU6EEnYHMx75I39kf9nAmmRNuAPUasSJu0HzZSAqgljR3ItvaJM2lxuW6jPjVn+Y+8
	 VU/8I/YP0yr0Aumy2uy3xg1PpntjX25L/7WjEveLNRfjNtVZI0uYbCw2WpFGOo+kLu
	 6SeQBisAhnBeQ==
Date: Thu, 10 Aug 2023 16:25:07 +0200
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, avraham.stern@intel.com,
	luciano.coelho@intel.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] nl80211/cfg80211: add forgetten nla_policy for
 BSS color attribute
Message-ID: <ZNTzQ3QgKdWWpVop@vergenet.net>
References: <20230809033151.768910-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809033151.768910-1-linma@zju.edu.cn>

On Wed, Aug 09, 2023 at 11:31:51AM +0800, Lin Ma wrote:
> The previous commit dd3e4fc75b4a ("nl80211/cfg80211: add BSS color to
> NDP ranging parameters") adds a parameter for NDP ranging by introducing
> a new attribute type named NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR.
> 
> However, the author forgot to also describe the nla_policy at
> nl80211_pmsr_ftm_req_attr_policy (net/wireless/nl80211.c). Just
> complement it to avoid malformed attribute that causes out-of-attribute
> access.
> 
> Fixes: dd3e4fc75b4a ("nl80211/cfg80211: add BSS color to NDP ranging parameters")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


