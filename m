Return-Path: <netdev+bounces-143251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577A9C1A07
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989F61C21E2E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7F51E0E15;
	Fri,  8 Nov 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/yN4eEN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731181D3625
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060700; cv=none; b=gI14zQtb1M4JOTtCi0AIq6gURt1pNSEMH/Fl3ZbeLDVHzlix0PGh+08swZNJLrHUacx2/GZJ3xTh1zsNDtNBc3HaGKsXtmm1g9cJbUeDRuJaxgWC6vuIOHNVYXh/wh6QlOmV/zXr4ufkeYFb2WgbU/wgaMnZ+hiVh2gWXBDBSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060700; c=relaxed/simple;
	bh=2Y6XQh97IlEZAnUMaaCBRjgRl8DqV3hQ6hBhbo89D8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKml7YWqgMWb8jDqPLsUbxS9tNFFYupyKnh7IDKMk8ZJzNCcYon78C4YcXyjK3ah0XrsxvqS4hmP1OSronDqCgi0w4ZXxx3HWE6gnUvojJRo/vHqwv4DbIzaJ4q1J9R6Ph1N9v4YO9nM54b8ozokD6SDfQ8Liq7Y+4K3+zMJjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/yN4eEN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731060698; x=1762596698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Y6XQh97IlEZAnUMaaCBRjgRl8DqV3hQ6hBhbo89D8k=;
  b=M/yN4eENCGwmtyRyz+vnq/Oo+2BRKHa6MTbEPE9aKc3nzvTolRYN9WJg
   oMja6Ko5fSdAkiTPhLKBCzajRW+kNl+SeOKtvKer+Q/NGmvlsMcN/OjVs
   r5nidHjKmTUBHT0VnM2E9qRh/cuBGwwwQ9RbGy6TW4UMN+mFZdmi+jWQc
   FDTOZq6PtG2qh8qaTxxX+Yts+XBCqW8sNpkB+SzBaFljQzzkju7BHNsf8
   2YaQRvAS53IJ5SeRPvD0k8n+3wB/74lcYrjda36DhjbhU8p9kygV6es5P
   784uE8VepVBgfyBSOxmG+MO7sjjh4991XwTP2AnVZRu0+FsLcQPgOaBHv
   A==;
X-CSE-ConnectionGUID: x61Syf17QrSUNIhXaphEnA==
X-CSE-MsgGUID: fIcSBDDWSg+tpQavX2Q7fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="42337159"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="42337159"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 02:11:35 -0800
X-CSE-ConnectionGUID: GoPS3B+tRh+SvriJNAGP1A==
X-CSE-MsgGUID: belM6j1+TPK6T86HO2nXAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="90133195"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 02:11:34 -0800
Date: Fri, 8 Nov 2024 11:08:50 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Szycik, Marcin" <marcin.szycik@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [iwl-next v1] ice: add recipe priority check
 in search
Message-ID: <Zy3jMhc4Bt1AYXod@mev-dev.igk.intel.com>
References: <20241011070328.45874-1-michal.swiatkowski@linux.intel.com>
 <PH0PR11MB50136A29D7ED13173A313FC2965C2@PH0PR11MB5013.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB50136A29D7ED13173A313FC2965C2@PH0PR11MB5013.namprd11.prod.outlook.com>

On Thu, Nov 07, 2024 at 12:06:26PM +0000, Buvaneswaran, Sujai wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> > Michal Swiatkowski
> > Sent: Friday, October 11, 2024 12:33 PM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; Szycik, Marcin <marcin.szycik@intel.com>;
> > Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > Subject: [Intel-wired-lan] [iwl-next v1] ice: add recipe priority check in search
> > 
> > The new recipe should be added even if exactly the same recipe already
> > exists with different priority.
> > 
> > Example use case is when the rule is being added from TC tool context.
> > It should has the highest priority, but if the recipe already exists the rule will
> > inherit it priority. It can lead to the situation when the rule added from TC
> > tool has lower priority than expected.
> > 
> > The solution is to check the recipe priority when trying to find existing one.
> > 
> > Previous recipe is still useful. Example:
> > RID 8 -> priority 4
> > RID 10 -> priority 7
> > 
> > The difference is only in priority rest is let's say eth + mac + direction.
> > 
> > Adding ARP + MAC_A + RX on RID 8, forward to VF0_VSI After that IP +
> > MAC_B + RX on RID 10 (from TC tool), forward to PF0
> > 
> > Both will work.
> > 
> > In case of adding ARP + MAC_A + RX on RID 8, forward to VF0_VSI ARP +
> > MAC_A + RX on RID 10, forward to PF0.
> > 
> > Only second one will match, but this is expected.
> > 
> > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_switch.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> 
> Hi,
> 
> I tried configuring two rules with same match parameters but with different priorities. One rule redirecting the PF traffic to VF_PR1 and other one to VF_PR2.
> 
> In this case, I notice that both the VFs are able to receive the same packet from the PF. Can you please confirm if this is expected?
> 
> Below are the rules (1 and 3) used.
> 
> [root@cbl-mariner ~]# tc filter show dev ens5f0np0 root
> filter ingress protocol ip pref 1 flower chain 0 
> filter ingress protocol ip pref 1 flower chain 0 handle 0x1 
>   dst_mac 52:54:00:00:16:01
>   src_mac b4:96:91:9f:65:58
>   eth_type ipv4
>   skip_sw
>   in_hw in_hw_count 1
>         action order 1: mirred (Egress Redirect to device eth0) stolen
>         index 5 ref 1 bind 1
> 
> filter ingress protocol ip pref 1 flower chain 0 handle 0x2 
>   dst_mac 52:54:00:00:16:02
>   src_mac b4:96:91:9f:65:58
>   eth_type ipv4
>   skip_sw
>   in_hw in_hw_count 1
>         action order 1: mirred (Egress Redirect to device eth1) stolen
>         index 6 ref 1 bind 1
> 
> filter ingress protocol ip pref 7 flower chain 0 
> filter ingress protocol ip pref 7 flower chain 0 handle 0x1 
>   dst_mac 52:54:00:00:16:01
>   src_mac b4:96:91:9f:65:58
>   eth_type ipv4
>   skip_sw
>   in_hw in_hw_count 1
>         action order 1: mirred (Egress Redirect to device eth1) stolen
>         index 7 ref 1 bind 1
> 
> Packet captures:
> [root@cbl-mariner ~]# ip netns exec ns1 tcpdump -i ens5f0v0
> dropped privs to tcpdump
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on ens5f0v0, link-type EN10MB (Ethernet), capture size 262144 bytes
> 15:21:21.428973 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 8001.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:21.428986 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 8001.18:5a:58:a3:1c:e0.8060, length 43
> 15:21:21.429001 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 83e8.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:21.429012 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 83e9.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:21.429016 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 83ea.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:21.429029 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 83eb.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:21.429039 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 80c8.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:21.944173 IP 1.1.1.100 > cbl-mariner: ICMP echo request, id 7, seq 4268, length 64
> 15:21:21.944182 IP cbl-mariner > 1.1.1.100: ICMP echo reply, id 7, seq 4268, length 64
> ^C
> 9 packets captured
> 9 packets received by filter
> 0 packets dropped by kernel
> 
> [root@cbl-mariner ~]# ip netns exec ns2 tcpdump -i ens5f0v1
> dropped privs to tcpdump
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on ens5f0v1, link-type EN10MB (Ethernet), capture size 262144 bytes
> 15:21:21.429028 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 83eb.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:21.429040 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 80c8.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:21.944170 IP 1.1.1.100 > 1.1.1.1: ICMP echo request, id 7, seq 4268, length 64
> 15:21:22.968162 IP 1.1.1.100 > 1.1.1.1: ICMP echo request, id 7, seq 4269, length 64
> 15:21:23.432386 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 8001.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:23.432403 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 8001.18:5a:58:a3:1c:e0.8060, length 43
> 15:21:23.432430 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 83e8.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:23.432472 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 83e9.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:23.432508 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 83ea.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:23.432549 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 83eb.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:23.432588 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agreement], bridge-id 80c8.18:5a:58:a3:1c:e0.8060, length 42
> 15:21:23.992156 IP 1.1.1.100 > 1.1.1.1: ICMP echo request, id 7, seq 4270, length 64
> 

Hi,

Yes, it is expected. We don't support different priority from tc yet, so
no matter what priority from tc you will choose it will be programmed
with the same priority in hw.

Thanks,
Michal

> Regards,
> Sujai B

