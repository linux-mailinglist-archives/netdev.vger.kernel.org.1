Return-Path: <netdev+bounces-118236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E807950FBC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 00:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA39281BA4
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE931AB513;
	Tue, 13 Aug 2024 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXIBAScF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221A1A256C;
	Tue, 13 Aug 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587971; cv=none; b=oLOtKNaumZ2XMmtl8prEf2bs+ebvG9KLb5WK5p0VW9+71PgVM6Sno+2hDp+tddjkND8+lRG9xhDL3JdZvVTRj0SV6UoIzRqTjKjInb1UEkVVq9azgn7XTCgaz61ytZXBRmyb+hzxNhQ/KdtCI7LVznNhqi2fR3ZNzbgmejTuUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587971; c=relaxed/simple;
	bh=KFzCLQzasMMzAHmW90HUBXRK0smSMiV9eWOMY+Q99uA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HX2LqhES0udHoG3UrfZqqPs3najGleFP6DMK9f9sy8P++eSBHbkekr/Y9Y+gPTlaP1v9ebYvwUNU1tBqhcPeTt22J7XaEUfiw1RFU0hyElmvEUFE+B6cg1Vd91NmZZnVCGq97KtuF6V5tAaRrkgqo7f02N/e8OCf21loz+CuxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXIBAScF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723587970; x=1755123970;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KFzCLQzasMMzAHmW90HUBXRK0smSMiV9eWOMY+Q99uA=;
  b=PXIBAScF8qL6A7KLDGpLOxV1VwFKZRnMv79N7r6qQeldgRdCqn+3TFGM
   hiKLnnre0MiKOuviDmaHX/ZYdjnvsZBBGDtR7jH+zQJ+bu+7bcaZinJO2
   Vdi3EZ+8ZAgt6nVB2txu/vp17ZoSPxJ1z9hcmn+Dsn4nO29nCDqbdqfTM
   SsOhCQvD9TZO2eHgvAQyclkgb9bbnwO27GKMICN2TA8Ax2GOQ9NXhdT0Z
   KvlzTiUbAgXIro2uL43RtCQAdp46Up+5mUN1YzlfgbobpffJlFXawGe04
   A8AHTzGaBSocY358WnzI2XS3tRUvOsNc+s5QOtmLFQcNz9RjWqGv5MUmr
   A==;
X-CSE-ConnectionGUID: IEHXbi0oR2mxlN8a+5bm3w==
X-CSE-MsgGUID: c/cxZQy/QO+Ku2kti3Rf4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32459401"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32459401"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 15:26:08 -0700
X-CSE-ConnectionGUID: tVl7Co+7Raqs7Dv5UzfQRw==
X-CSE-MsgGUID: YhwQl1U2Qi2LdxQWKIEOVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="62961260"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.164])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 15:26:07 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Daiwei Li <daiweili@google.com>
Cc: anthony.l.nguyen@intel.com, daiweili@gmail.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 kurt@linutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
 sasha.neftin@intel.com, Daiwei Li <daiweili@google.com>
Subject: Re: [PATCH iwl-net v2] igb: Fix not clearing TimeSync interrupts
 for 82580
In-Reply-To: <20240813033508.781022-1-daiweili@google.com>
References: <87sev9wrkj.fsf@intel.com>
 <20240813033508.781022-1-daiweili@google.com>
Date: Tue, 13 Aug 2024 15:26:07 -0700
Message-ID: <871q2svz40.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daiwei Li <daiweili@google.com> writes:

> 82580 NICs have a hardware bug that makes it
> necessary to write into the TSICR (TimeSync Interrupt Cause) register
> to clear it:
> https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/
>
> Add a conditional so only for 82580 we write into the TSICR register,
> so we don't risk losing events for other models.

Please add some information in the commit message about how to reproduce
the issue, as Paul suggested.

>
> This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").
>
> Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
> Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
> Tested-by: Daiwei Li <daiweili@google.com>
> Signed-off-by: Daiwei Li <daiweili@google.com>
> ---
>
> @Vinicius Gomes, this is my first time submitting a Linux kernel patch,
> so apologies if I missed any part of the procedure (e.g. this is
> currently on top of 6.7.12, the kernel I am running; should I be
> rebasing on inline?). Also, is there any way to annotate the patch
> to give you credit for the original change?

Your submission format looks fine. Just a couple details:
 - No need for setting in-reply-to (or something like it);
 
 - For this particular patch, you got lucky and it applies cleanly
 against current tip, but for future submissions, for intel-wired-lan
 and patches intended for the stable tree, please rebase against:

 https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/

For credits, you can add something like:

Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

>
>  drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ada42ba63549..1210ddc5d81e 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -6986,6 +6986,16 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
>  	struct e1000_hw *hw = &adapter->hw;
>  	u32 tsicr = rd32(E1000_TSICR);
>  	struct ptp_clock_event event;
> +	const u32 mask = (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
> +			  TSINTR_TT0 | TSINTR_TT1 |
> +			  TSINTR_AUTT0 | TSINTR_AUTT1);
> +

Please move the declaration of 'mask' up, to follow the convention, the
"reverse christmas tree" rule. Or separate the attribution from the
declaration.

> +	if (hw->mac.type == e1000_82580) {
> +		/* 82580 has a hardware bug that requires a explicit

And as pointed by Paul, "*an* explicit".

> +		 * write to clear the TimeSync interrupt cause.
> +		 */
> +		wr32(E1000_TSICR, tsicr & mask);
> +	}
>  
>  	if (tsicr & TSINTR_SYS_WRAP) {
>  		event.type = PTP_CLOCK_PPS;
> -- 
> 2.46.0.76.ge559c4bf1a-goog
>

-- 
Vinicius

