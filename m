Return-Path: <netdev+bounces-171863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59593A4F2A1
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A1F188CFA2
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FDD14286;
	Wed,  5 Mar 2025 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I24VjWZc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E528DB3;
	Wed,  5 Mar 2025 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134279; cv=none; b=pOayuex/IhrmCyt90f713YCx/7qC22KikNyQFU7wEPFFDC2oFFCd2ssAOqllKFCCm39k9xfB1yEL5nlz85FkpebslmjWdoHDcl8bdQjxzSekabFH52RLkcAxZtSj1BG4FTQQhmLiHm5kqlHqkeL2G3x2Zm/adu0NKtjFEzyoobE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134279; c=relaxed/simple;
	bh=y7MUgOurul1EqCfOPhyeQVHxMvZ/06Rrgth75p612z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esTqZUg9un8sZHI2gnj/7aQUuuLXqEDFywDHNzL+l7qh+3fT5h0WpgVkOkCzSIzGCA1HPWtF+z1moOSbBQ3MLz/JhbY2cpIzBiGARjz3TFwOrJLSIBciod4Q55B1hw8+tkuxwI2IA0mz+4QUwMRB8eUBG8PUud88Ekpsf8xYids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I24VjWZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0B7C4CEE5;
	Wed,  5 Mar 2025 00:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741134279;
	bh=y7MUgOurul1EqCfOPhyeQVHxMvZ/06Rrgth75p612z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I24VjWZcx9Ymy+7xo+8CCH9TX+64bhNNNvNx2o7T1lA/eOFylvVerKppIGqIgh1CM
	 xWVQ9cYsdW2TFSWCBd9dkxuTZ80jX01sUZ+gYa72T3x6fGDCCgO/tZghcrhqhzRg9s
	 4FYw0WJOcZGfWFzDOH2I+W+ohZ61bo1X0Zm7t8NUhkg3vopQ3wY6XmnzUSlsGvJnb2
	 IdlKhbZozjSpte/QIdfm5P2wgkS+S0vaVdC4/dcVvcFBjAN6+jwRz6HChWLuViGkji
	 /3e8whUPFok+qqAFmLYldOD5MWFMM9BKujS+QRTGfx+3RcDM/3TfHYC82SYyWTu2GI
	 i6ryNq/MPaOjA==
Date: Tue, 4 Mar 2025 16:24:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David
 S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Add ICSSG FW Stats
Message-ID: <20250304162437.0160f687@kernel.org>
In-Reply-To: <33c38844-4fbe-469c-bb5f-06bdb7721114@ti.com>
References: <20250227093712.2130561-1-danishanwar@ti.com>
	<20250303172543.249a4fc2@kernel.org>
	<33c38844-4fbe-469c-bb5f-06bdb7721114@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 13:46:39 +0530 MD Danish Anwar wrote:
> On 04/03/25 6:55 am, Jakub Kicinski wrote:
> > On Thu, 27 Feb 2025 15:07:12 +0530 MD Danish Anwar wrote:  
> >> +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
> >> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
> >> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
> >> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
> >> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),  
> > 
> > I presume frame preemption is implemented in silicon? If yes -
> > what makes these "FW statistics"? Does the FW collect them from   
> 
> The statistics are maintained / updated by firmware and thus the name.
> 
> Preemption is implemented partially in both the hardware and firmware.
> The STATE MACHINE for preemption is in the firmware. The decision to
> when to PREEMEPT / ASSEMBLE a packet is made in firmware.
> 
> These preemption statistics are updated by the firmware based on the
> action performed by the firmware. Driver can read these to know the
> statistics of preemption. These stats will be able used by
> ethtool_mm_stats once the support for Preemption is added in the driver.

That was going to be my next question. If the statistic is suitable 
for a standard interface it should not be reported via ethtool -S.

Please leave the stats for unimplemented features out.

> >> +/* Incremented if a packet is dropped at PRU because of a rule violation */
> >> +#define FW_DROPPED_PKT		0x00F8  
> > 
> > Instead of adding comments here please add a file under
> > Documentation/networking/device_drivers/ with the explanations.
> > That's far more likely to be discovered by users, no?  
> 
> Sure I will drop these MACRO comments and create a .rst file in
> Documentation/networking/device_drivers/
> 
> One question though, should I create a table for the stats and it's
> description or should I create a section for each stats?
> 
> Something like this,
> 
> FW_RTU_PKT_DROP
> ---------------

Let's document the user-visible names! The strings from ethtool -S

> Diagnostic error counter which increments when RTU drops a locally
> injected packet due to port being disabled or rule violation.
> 
> Please let me know what do you think.

Taking inspiration from:
  Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
should be a safe choice, I hope.

