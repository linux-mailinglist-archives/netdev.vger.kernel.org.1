Return-Path: <netdev+bounces-40997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EAB7C94E5
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 16:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53952821D3
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1C12B6E;
	Sat, 14 Oct 2023 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb40Oyx8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E35396
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 14:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638DCC433C7;
	Sat, 14 Oct 2023 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697294673;
	bh=11scpju71D+KerC5FhLxK9Ma2HRBqYwq2VHa/P5HXo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tb40Oyx8m0AwzPXsLNlWOiSigEbsAvCNBdUpb2hrFWsFqQCrASeDhLRd7HQzzg0ev
	 LySdTO04dtwnNoNrNM0z2C02dwhFNeXDWP0Npm+pw3FKK07TdejIZJQOnPeqelqVsR
	 8b05MV4RpV1yiNOw6N2VlGGRzEzJfC+imxNtvnA4AYo8xPvQvvsybNz5CqurNrjd96
	 xD4vdsOEmP25fCCGy8pMoFd8k7Nj1ebREcJgHyXIR7Y1W6HHW1bW+Oa/Fs3n8FUNky
	 neYAProozhcaz3AqZxalAfVITm/Y/AZKf2cRlXMPUNYjoapEk+JnLjKWEGhnbVS6TG
	 791CflIJO8iTw==
Date: Sat, 14 Oct 2023 16:44:28 +0200
From: Simon Horman <horms@kernel.org>
To: Johannes Zink <j.zink@pengutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, patchwork-jzi@pengutronix.de,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 2/5] net: stmmac: fix PPS capture input index
Message-ID: <20231014144428.GA1386676@kernel.org>
References: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
 <20231010-stmmac_fix_auxiliary_event_capture-v1-2-3eeca9e844fa@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-stmmac_fix_auxiliary_event_capture-v1-2-3eeca9e844fa@pengutronix.de>

On Thu, Oct 12, 2023 at 11:02:13AM +0200, Johannes Zink wrote:
> The stmmac supports up to 4 auxiliary snapshots that can be enabled by
> setting the appropriate bits in the PTP_ACR bitfield.
> 
> Previously instead of setting the bits, a fixed value was written to
> this bitfield instead of passing the appropriate bitmask.
> 
> Now the correct bit is set according to the ptp_clock_request.extts_index
> passed as a parameter to stmmac_enable().
> 
> Fixes: f4da56529da6 ("net: stmmac: Add support for external trigger timestamping")
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

Hi Johannes,

The fix language of the subject and presence of a fixes tag implies that
this is a bug fix. But it's not clear to me that this is resolving
bug that manifests as a problem.

If it is a bug fix then it should probably be targeted at 'net',
creating a dependency for the remainder of this series.

On the other hand, if it is not a bug fix then perhaps it is best to
update the subject and drop the Fixes tag.

I'm no expert on stmmac, but the rest of the series looks good to me.

...

