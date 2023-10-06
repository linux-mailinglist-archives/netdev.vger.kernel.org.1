Return-Path: <netdev+bounces-38553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64917BB656
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72B51C209AE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127251C689;
	Fri,  6 Oct 2023 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdZZwAQS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60231C2B8
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881E1C433C7;
	Fri,  6 Oct 2023 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696591268;
	bh=2OvrbOVd1DKguidAQ5wXL9nm274STWXog0it8L1OjsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdZZwAQSgZBHWp1jTnfdzwFBAtEaTGAn8O2qY7csoymxukv1i+x6bVX714q6IREqu
	 CEl0BDx9ADZFQ4hPKZbF7j6jaMQEN9IGE2L2Scvto9fcflXDe0ly/ULA8TZOPHcWVW
	 USV0yQ/MPTbYN40TNv6D6v3Ox6msODB4Fw6AJpaU4YK+AmuVDQEnZlwOXSpCS+pcRj
	 Mkn5eUhg/LMAUYNirlKoiX4QeeU125ckl/GfElank9zcVUNUPA0oXi9psoL5RNU+J7
	 QLuZYVdl0crucpwbB3AHsZXUqqHovYkTP8lOhruoPURrj4mpcAeXbq33Ef5oeZPLt6
	 pJKSvTHkYQVkA==
Date: Fri, 6 Oct 2023 13:21:04 +0200
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] ixgbe: fix end of loop test in
 ixgbe_set_vf_macvlan()
Message-ID: <ZR/toAqmRnTWljdy@kernel.org>
References: <4d61f086-c7b4-4762-b025-0ba5df08968b@moroto.mountain>
 <34603f41-1d51-48df-9bca-a28fd5b27a53@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34603f41-1d51-48df-9bca-a28fd5b27a53@moroto.mountain>

On Thu, Oct 05, 2023 at 04:58:01PM +0300, Dan Carpenter wrote:
> The list iterator in a list_for_each_entry() loop can never be NULL.
> If the loop exits without hitting a break then the iterator points
> to an offset off the list head and dereferencing it is an out of
> bounds access.
> 
> Before we transitioned to using list_for_each_entry() loops, then
> it was possible for "entry" to be NULL and the comments mention
> this.  I have updated the comments to match the new code.
> 
> Fixes: c1fec890458a ("ethernet/intel: Use list_for_each_entry() helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


