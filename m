Return-Path: <netdev+bounces-28555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6567977FCCA
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209082820EF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC3171BF;
	Thu, 17 Aug 2023 17:11:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D91ADC4
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5ABC433C7;
	Thu, 17 Aug 2023 17:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292268;
	bh=QWb8uU7er4eHL3xqihUBmuM1/XOUYzoC3V7sc/KlG9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+JO2MaGQc9Tqfzykmd1ioCOc4USf7qcrXDEmggaGIopMW7+8DwezzUXXqUPnk6Qe
	 3o7F+nBp0h8Jea3fOBptG4U2LTL4eQwjjCLk0i5PmJqiILEVY8dZ5q9NZs0aMuRcw0
	 CnpjyJNlVhnRRHerXkHDylfbumgkIX9oWq437SUu7KChKFOG5FN/hUmKlIRgMDOYmu
	 9liNRdWVN4U5oSFtAgI2BSWCU8V19kM5uBH+CS3h5NJrSCemTwbYxoYSP1wmRbw5Bl
	 tH/6EiMijiaQaxBwn2ePIEhyf6zXq9bDfCagHSMqZlR5rLmdqdrAkjwD5OvWG4z3fw
	 IgIicQu14V8kA==
Date: Thu, 17 Aug 2023 20:11:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 14/14] ice: split ice_aq_wait_for_event() func
 into two
Message-ID: <20230817171104.GW22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-15-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-15-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:36PM -0700, Tony Nguyen wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Mitigate race between registering on wait list and receiving
> AQ Response from FW.
> 
> ice_aq_prep_for_event() should be called before sending AQ command,
> ice_aq_wait_for_event() should be called after sending AQ command,
> to wait for AQ Response.
> 
> Please note, that this was found by reading the code,
> an actual race has not yet materialized.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  5 +-
>  .../net/ethernet/intel/ice/ice_fw_update.c    | 13 ++--
>  drivers/net/ethernet/intel/ice/ice_main.c     | 67 ++++++++++++-------
>  3 files changed, 57 insertions(+), 28 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

