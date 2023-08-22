Return-Path: <netdev+bounces-29535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A17783AE6
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08D2280FFE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659E7492;
	Tue, 22 Aug 2023 07:30:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3333E2
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF8BC433C7;
	Tue, 22 Aug 2023 07:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692689447;
	bh=BwHak8L0h+xrvYhw1dYhUD/XFRnn/vcZR8VKhgLGQI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPQFvf+DuetHCI1lK6LFxQsJ0RdA5O4USeetwhBhnlMffdIdyWZXyQRQhCM00rlJY
	 qeFoqjosezvciSyjAcb0Slt8xUuV4WlJaXcojVV+/xZgZpyFO9ohLDHAWTFtkS9P3z
	 0lcLuJdR4jQ7SnOr7qVKoKe7AARsnlbWmh1rb2UkNUNxkV15As/+Q0W3gLLlsvQLil
	 ggjyisgaSBR4tGNatqjkjbHuNYBDxhmA/vcMQX7HSwIebfufPei0WLB/qL8FCrro8P
	 BPX5XFY7o9+P7KQlNN8/9n53loq35TJM/9XHc7saTS+3I8XaWzW+omO1bNIlI7PhkR
	 ZfD+0IEqroXEQ==
Date: Tue, 22 Aug 2023 09:30:44 +0200
From: Simon Horman <horms@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, razor@blackwall.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next] vxlan: vnifilter: Use GFP_KERNEL instead of
 GFP_ATOMIC
Message-ID: <20230822073044.GN2711035@kernel.org>
References: <20230821141923.1889776-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821141923.1889776-1-idosch@nvidia.com>

On Mon, Aug 21, 2023 at 05:19:23PM +0300, Ido Schimmel wrote:
> The function is not called from an atomic context so use GFP_KERNEL
> instead of GFP_ATOMIC. The allocation of the per-CPU stats is already
> performed with GFP_KERNEL.
> 
> Tested using test_vxlan_vnifiltering.sh with CONFIG_DEBUG_ATOMIC_SLEEP.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


