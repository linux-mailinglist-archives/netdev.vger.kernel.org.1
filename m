Return-Path: <netdev+bounces-224441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5805DB84EF7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C937A31D1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84332234966;
	Thu, 18 Sep 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgKSRqA0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00622F77E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203965; cv=none; b=eGlMnC7pFk0GuFoj9ZNrYu4gNJnzC455eVp17NukqL7jP4qQ0td7F/+bds8mgqsYOMbyMZny2yhIo9OGhY/izAb2FZcDtqb8gof3bw3LKltlLIzmKnHmAX3OuiDj0pKrYhr4nEnBPGgYu99mvutNtrUN3+kQHuPmKfzp25AEr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203965; c=relaxed/simple;
	bh=p5Lv3uUZAHbIQ99lh3jk7U1dwg6LSEj2Bbz5I2CYnbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OunwrjRs2WwKEhw9V0nFioCYw1ZVj2T3ioPSw9tZ2CD4O2IF359s1kapa/tvWYY+qhNwKrZ42JfpCEOnDCuMxR+fTkeJEXpjyQB1TvHxo7M74Qvn7GyDvo81yBRWapD6d54pWbwUYDPgpig9aGvFVUfKn1ieJENUCfGpshCXVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgKSRqA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8BDC4CEEB;
	Thu, 18 Sep 2025 13:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758203965;
	bh=p5Lv3uUZAHbIQ99lh3jk7U1dwg6LSEj2Bbz5I2CYnbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AgKSRqA04k3JrwNjdykMpfmrT2Tz99xMPbKvjXrVTBygsJeAuh04AKi6MfaPN4+ub
	 3g9P+w26QO/Z9RXkQFTQz6kqfZvLFbl67g4hG3MIg2+k8LVATIgGIW0mzyvxWT0/5v
	 9tlycIpqZshLfNCa8c7XHoisPaQl0s3Ysok9spqTn00Vhub6Npb3Vk1EpHDvBCoP+4
	 WlTAKoxwbhpsQtaznUrHCayMBGfD2TAP9aqJyc6pMo+S6DnpP7loITmGIVGlpEPu8g
	 exVvtDaibLrmXsXyda/RSR4M9OpA/eA4I8O/2aPqRH3EUvy+RylkhaUFT+L8cpFe2s
	 NXbAbYHcWTiZQ==
Date: Thu, 18 Sep 2025 06:59:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] ethtool: add FEC bins histogram report
Message-ID: <20250918065923.26331dd6@kernel.org>
In-Reply-To: <3091c796-acad-4c87-9782-3b67210147c2@linux.dev>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
	<20250916191257.13343-2-vadim.fedorenko@linux.dev>
	<20250917174148.0c909f92@kernel.org>
	<3091c796-acad-4c87-9782-3b67210147c2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 11:53:53 +0100 Vadim Fedorenko wrote:
> On 18/09/2025 01:41, Jakub Kicinski wrote:
> > On Tue, 16 Sep 2025 19:12:54 +0000 Vadim Fedorenko wrote:  
> >> IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
> >> clarifies it a bit further. Implement reporting interface through as
> >> addition to FEC stats available in ethtool.
> >> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> >> index 7a7594713f1f..de5008266884 100644
> >> --- a/Documentation/netlink/specs/ethtool.yaml
> >> +++ b/Documentation/netlink/specs/ethtool.yaml
> >> @@ -1219,6 +1219,23 @@ attribute-sets:
> >>           name: udp-ports
> >>           type: nest
> >>           nested-attributes: tunnel-udp
> >> +  -
> >> +    name: fec-hist
> >> +    attr-cnt-name: __ethtool-a-fec-hist-cnt  
> > 
> > s/__/--/  
> 
> That will bring strong inconsistency in schema. All other attributes
> have counter attribute with __ in the beginning:
> 
>      name: fec-stat
>      attr-cnt-name: __ethtool-a-fec-stat-cnt
> 
>      name: stats-grp
>      attr-cnt-name: __ethtool-a-stats-grp-cnt
> 
>      name: stats
>      attr-cnt-name: __ethtool-a-stats-cnt

I know.

> >>   static void
> >> -nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats)
> >> +nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats,
> >> +		   struct ethtool_fec_hist *hist)
> >>   {
> >> +	struct ethtool_fec_hist_value *values = hist->values;
> >> +
> >> +	hist->ranges = netdevsim_fec_ranges;
> >> +
> >>   	fec_stats->corrected_blocks.total = 123;
> >>   	fec_stats->uncorrectable_blocks.total = 4;
> >> +
> >> +	values[0].bin_value = 445;  
> > 
> > Bin 0 had per lane breakdown, can't core add up the lanes for the
> > driver?  
> 
> Like it's done for blocks counter? Should we force drivers to keep 'sum'
> value equal to ETHTOOL_STAT_NOT_SET when they provide per-lane values?

No preference, but if it is NOT_SET we should add it up.


