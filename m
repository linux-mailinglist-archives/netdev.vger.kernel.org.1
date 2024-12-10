Return-Path: <netdev+bounces-150725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9879EB4DE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8909A280E8E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716021B982E;
	Tue, 10 Dec 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YazBtt3e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0651AA78D
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844430; cv=none; b=VSYMyvLRnOpmADGNc/JehwPmP5b5mlBqNqPPZ2XpXvpyfX+1pOZkP9JJVPZm//48IkeclLpXaVp7u17BFAl1KSgiVJ2x09ehWOT3lh10yTyDbg/eTyl/1zz12gRyV7x69ZQtYAQnvtgs8AnIKHdI+e6PM0oUCz4NESiUurv6Axk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844430; c=relaxed/simple;
	bh=y4LgmUc7RvEv1C+QAjWWd7i3psGBaMi5PzDvn/ejtlM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sgiSrXAt76uuDnCWxf46b2iinNrOzo+shtFgfaKD1KPKtckjsXsebXHh5zE0H69LeShOZ936bqepO3NHEoT1XI2KCs5Ha9O97kIp9+rfXsXQxhKOyklHas1LbSrs5Di2Cmj0MtZWggk937sRTVTWJFrlQRsdLIGGkJT9nFGT+Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YazBtt3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951F7C4CEE1;
	Tue, 10 Dec 2024 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733844429;
	bh=y4LgmUc7RvEv1C+QAjWWd7i3psGBaMi5PzDvn/ejtlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YazBtt3eKTZEioZjvB/7KrOkFFytB879q5nzigXjfa5SVTuNPfHnTydupv0cQ9b+T
	 bFkyX5aE5FrURxMDx2nJELOie3VE8VB7+eLxMEcAoVPn4juJI7wrAbnkSBjb+7p35G
	 Rq5yuO1hJAvR/RXXQIgZyuo0k1kFSBMNBzruasXWAPNGJDKtlWPL+vzgKHUWCrFT8j
	 rn95C+YBIicfGVVCvDB60POEZDKp+rkVcrQOadKqw1wqLdiiGw0bgohuP1HwVfbkZy
	 zTp28VM7kVh9NJTk4CUZLG5/Ld9guLS6NsQT9JnJnaEIVYxOvBSHpRilmZRqzmIcpJ
	 uZdaW17OzMP+Q==
Date: Tue, 10 Dec 2024 09:27:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Gerhard Engleder <eg@keba.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] e1000e: Fix real-time
 violations on link up
Message-ID: <20241210152708.GA3241347@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208184950.8281-1-gerhard@engleder-embedded.com>

On Sun, Dec 08, 2024 at 07:49:50PM +0100, Gerhard Engleder wrote:
> Link down and up triggers update of MTA table. This update executes many
> PCIe writes and a final flush. Thus, PCIe will be blocked until all writes
> are flushed. As a result, DMA transfers of other targets suffer from delay
> in the range of 50us. This results in timing violations on real-time
> systems during link down and up of e1000e.

These look like PCIe memory writes (not config or I/O writes), which
are posted and do not require Completions.  Generally devices should
not delay acceptance of posted requests for more than 10us (PCIe r6.0,
sec 2.3.1).

Since you mention DMA to/from other targets, maybe there's some kind
of fairness issue in the interconnect, which would suggest a
platform-specific issue that could happen with devices other than
e1000e.

I think it would be useful to get to the root cause of this, or at
least mention the interconnect design where you saw the problem in
case somebody trips over this issue with other devices.

The PCIe spec does have an implementation note that says drivers might
need to restrict the programming model as you do here for designs that
can't process posted requests fast enough.  If that's the case for
e1000e, I would ask Intel whether other related devices might also be
affected.

> A flush after a low enough number of PCIe writes eliminates the delay
> but also increases the time needed for MTA table update. The following
> measurements were done on i3-2310E with e1000e for 128 MTA table entries:
> 
> Single flush after all writes: 106us
> Flush after every write:       429us
> Flush after every 2nd write:   266us
> Flush after every 4th write:   180us
> Flush after every 8th write:   141us
> Flush after every 16th write:  121us
> 
> A flush after every 8th write delays the link up by 35us and the
> negative impact to DMA transfers of other targets is still tolerable.
> 
> Execute a flush after every 8th write. This prevents overloading the
> interconnect with posted writes.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> ---
> v2:
> - remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
> ---
>  drivers/net/ethernet/intel/e1000e/mac.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index d7df2a0ed629..7d1482a9effd 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -331,8 +331,13 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
>  	}
>  
>  	/* replace the entire MTA table */
> -	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
> +	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>  		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
> +
> +		/* do not queue up too many writes */
> +		if ((i % 8) == 0 && i != 0)
> +			e1e_flush();
> +	}
>  	e1e_flush();
>  }
>  
> -- 
> 2.39.2
> 

