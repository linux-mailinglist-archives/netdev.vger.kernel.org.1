Return-Path: <netdev+bounces-28936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2AE781319
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250F81C20AE5
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C534D1B7DC;
	Fri, 18 Aug 2023 18:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA081B7DA
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A867BC433C8;
	Fri, 18 Aug 2023 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692384711;
	bh=pidLHaTD/OAu/s3IGdmpPPGAw+jWYE00bBcIdCAuQA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcgYQOz9wf8yakoBN6pzjaJsiLiiObwbxYfqt5PjWifELfjBCLJIk9AgNeIMyVP2U
	 3nt1flNNQqxxLKpSAOZGNWTObdVH4ttrsn045KBIYzAtyOLz4BstcayPTZfKU+NY48
	 a4S+n+mxfR11ldYct+hpEfgxEAvPUw3+9ua8MYa1H3iOb0kwLkmNb9gXWFXtd7kQ2S
	 rN4qO1KeY9Co9yQ5bbV+zahPBwQK+8McrrdoVx+67D9gTo/4+623qCp5b7GmGFU2jL
	 jYZgaTDAyT8kWennBoFgMadn5pud+WwdOvHT7orhPUyzZ2Tk4+hDWUx2+vPO4rZluA
	 mYymY6nGtR1lg==
Date: Fri, 18 Aug 2023 21:51:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v2 13/15] ice: ice_aq_check_events: fix
 off-by-one check when filling buffer
Message-ID: <20230818185143.GE22185@unreal>
References: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
 <20230817212239.2601543-14-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817212239.2601543-14-anthony.l.nguyen@intel.com>

On Thu, Aug 17, 2023 at 02:22:37PM -0700, Tony Nguyen wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Allow task's event buffer to be filled also in the case that it's size
> is exactly the size of the message.
> 
> Fixes: d69ea414c9b4 ("ice: implement device flash update via devlink")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

