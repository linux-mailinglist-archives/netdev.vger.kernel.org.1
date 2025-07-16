Return-Path: <netdev+bounces-207413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C1B0710D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDA217C724
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4446D2EFD9C;
	Wed, 16 Jul 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7Kxgkt4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45E2F0C5F
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656418; cv=none; b=nH6a2/cOGB68m0q5cc4931SjkpUjpUr2chnvCCKFwerKnNkXDqhTFrvWqiT3W+wnl2ys6v40QO9DeSE84bu8JNQ6F8tDaz9qW3TcYL+9PXjjwUzbkEOwSveiDvubqBCqevWGy2UAHZ1mBW+JS3eFbVbTuqu3efvPAWrtdrRI2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656418; c=relaxed/simple;
	bh=GS0LfznfsPsOQY6uBhBMevQIDlTwL6heJJtqCRnf6Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9/xTY6fqso3RADYVlP6DfyqhOGMpG/kX67FoR0TJqsDtfCQoRjiQWqeSV8CPAZv20M+w++wZYaTsJEbZ9XrZTtiX1mOnC8xSeaBaXYdEYaN3re0QMby18dmtWlpnRb2MQ3cIBafNr/sS0RfMp46jNsMi972Iu9y8w8yhoBNWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7Kxgkt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14344C4CEF0;
	Wed, 16 Jul 2025 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752656417;
	bh=GS0LfznfsPsOQY6uBhBMevQIDlTwL6heJJtqCRnf6Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7Kxgkt4/GNo9ck3RfF2Fhj8qBcwO+LvNNY7xbSnTfwqxhAbsEmG3ongjZJYnBOxL
	 DREaZDV0OSFDfmJtEmciJu0DmMKRz6s92O94+wtVKPH3PZBk+9a1AIkBfOTKmOM6DJ
	 e3gX/57w9dQOkjSobf+ZkfQR/ltyfZs0PHnBcx4M/RAhq4T387B4My+yoQe9sRNvYO
	 eigJLiqZrFD9cOZRsEWpXr1KmAHCdO6gkaF29U2uh/qqKokaIQLB1h4Xia6dYtdkl9
	 B5ROedywWRcHVg56VPNuDXbvX+7J7hoj9H/VBYruHA/yaIP2/wkcoE3+TrFfrhhYmw
	 CrOJVeLxsnNjQ==
Date: Wed, 16 Jul 2025 10:00:14 +0100
From: Simon Horman <horms@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
	Pradeep Satyanarayana <pradeep@us.ibm.com>,
	"i.maximets@ovn.org" <i.maximets@ovn.org>,
	Adrian Moreno Zapata <amorenoz@redhat.com>,
	Hangbin Liu <haliu@redhat.com>
Subject: Re: [PATCH net-next v5 6/7] bonding: Update for extended
 arp_ip_target format.
Message-ID: <20250716090014.GK721198@horms.kernel.org>
References: <20250714225533.1490032-1-wilder@us.ibm.com>
 <20250714225533.1490032-7-wilder@us.ibm.com>
 <20250715135821.GY721198@horms.kernel.org>
 <MW3PR15MB391324648F78241D4AC721A6FA57A@MW3PR15MB3913.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR15MB391324648F78241D4AC721A6FA57A@MW3PR15MB3913.namprd15.prod.outlook.com>

On Tue, Jul 15, 2025 at 06:22:37PM +0000, David Wilder wrote:
> 
> 
> 
> ________________________________________
> From: Simon Horman <horms@kernel.org>
> Sent: Tuesday, July 15, 2025 6:58 AM
> To: David Wilder
> Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu
> Subject: [EXTERNAL] Re: [PATCH net-next v5 6/7] bonding: Update for extended arp_ip_target format.
> 
> >On Mon, Jul 14, 2025 at 03:54:51PM -0700, David Wilder wrote:
> >> Updated bond_fill_info() to support extended arp_ip_target format.
> >>
> >> Forward and backward compatibility between the kernel and iprout2 is
> >> preserved.
> >>
> >> Signed-off-by: David Wilder <wilder@us.ibm.com>
> >> ---
> >>  drivers/net/bonding/bond_netlink.c | 28 ++++++++++++++++++++++++++--
> >>  include/net/bonding.h              |  1 +
> >>  2 files changed, 27 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> >> index 5486ef40907e..6e8aebe5629f 100644
> >> --- a/drivers/net/bonding/bond_netlink.c
> >> +++ b/drivers/net/bonding/bond_netlink.c
> >> @@ -701,8 +701,32 @@ static int bond_fill_info(struct sk_buff *skb,
> >>
> >>       targets_added = 0;
> >>       for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
> >> -             if (bond->params.arp_targets[i].target_ip) {
> >> -                     if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
> >> +             struct bond_arp_target *target = &bond->params.arp_targets[i];
> >> +             struct Data {
> >> +                     __u32 addr;
> >> +                     struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
> >> +             } data;
> >> +             int size = 0;
> >> +
> >> +             if (target->target_ip) {
> >> +                     data.addr = target->target_ip;
> >
> >Hi David,
> >
> >There appears to be an endian mismatch here. Sparse says:
> >
>   >.../bond_netlink.c:712:35: warning: incorrect type in assignment (different base types)
>   >.../bond_netlink.c:712:35:    expected unsigned int [usertype] addr
>   >.../bond_netlink.c:712:35:    got restricted __be32 [usertype] target_ip
> >
> >> +                     size = sizeof(target->target_ip);
> >> +             }
> >
> >It seems that data.addr may be used uninitialised below
> >if the if condition above is not met.
> 
> >Flagged by Smatch.
> 
> Hi Simon
> 
> Thanks for catching this,  I will make the following change in the next version.
> 
> @@ -703,15 +703,14 @@ static int bond_fill_info(struct sk_buff *skb,
>         for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
>                 struct bond_arp_target *target = &bond->params.arp_targets[i];
>                 struct Data {
> -                       __u32 addr;
> +                       __be32 addr;
>                         struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
>                 } data;
>                 int size = 0;
> 
> -               if (target->target_ip) {
> -                       data.addr = target->target_ip;
> -                       size = sizeof(target->target_ip);
> -               }
> +               BUG_ON(!target->target_ip);

Hi David,

I think this addresses the issues I raised, thanks!

But please don't use BUG_ON() like this, it will crash the kernel,
which seems disproportionate to the problem at hand.

I'm not particularly familiar with this code. But it seems
that it is filling in netlink attributes. And does not make
any resource allocations. So perhaps this is sufficient?

		if (!target->target_ip)
			return -EINVAL;

> +               data.addr = target->target_ip;
> +               size = sizeof(target->target_ip);
> 
>                 for (int level = 0; target->flags & BOND_TARGET_USERTAGS && target->tags; level++) {
>                         if (level > BOND_MAX_VLAN_TAGS)
> 
> David Wilder

