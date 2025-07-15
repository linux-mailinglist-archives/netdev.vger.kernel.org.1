Return-Path: <netdev+bounces-207153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A17B06091
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FEF5A01CD
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA1D2F270F;
	Tue, 15 Jul 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7OLEC4o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88BE2F270B
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587905; cv=none; b=FmjdLAi3+8hAvH2zQLeKhCaHIJrMIXF3LqiGvlzO4vU6pZbeuwyTLFK/CazHYE48n0NsHyMGuFEUg5/QWZc1qf/qqKmwARSAPeSURE7VxdynhDafv4DksVf7TmhMYyTsMAY6oBcEfFKNrE2MUmkSa8z19ndMxenPEe8XE0ACXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587905; c=relaxed/simple;
	bh=azK0wIRR0+Hp6wdY0YKnR7aVC/wVGif1BMBmHrNOC5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIIH4sCJLT9dkf5eBbq6mf+SWyEa6fEfvR+/0DljOpt6acVU3UZkTfRiiTgqUSerCTXBeFmT84p8EmvnyUS/lvQesdahYY7kn+jVvrnu7b0prW1SgcVLCijzJyqUtn50md+TMs7JbTmvJXmFwNtY6gUSQwqLMvY9wxDKiT5jz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7OLEC4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EF3C4CEF7;
	Tue, 15 Jul 2025 13:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752587905;
	bh=azK0wIRR0+Hp6wdY0YKnR7aVC/wVGif1BMBmHrNOC5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7OLEC4obI79gt2SDur9GzEZq2XxCINeqssWqNN31DSUYEWvzi8KjJSs59yUceHrA
	 xMaZFM5UY6oHq41cgpKX7uf7tR5J3Z2ujAXvGP0IbP6Ya4tJTd+eC+DCEWY7C/hwx8
	 9UBxq1yATuclIzSAQx0hnNEBz2Yk+5TwFQAxImJgkabfuDYDX8B4bgK9BpHnnCwvn7
	 n+MQN2CB1nxAtwRJ5x5Fb6cLQS737XrEYhhvDMNj4m7T3r7QLyPMxhbR6AruMLW0hT
	 jC/SCP5JkGP+yRLjApbtUdHZAJeFV1hXO/5rZdbAgk6jecWo/OarwiBAQjfiVDOG9T
	 Uorl6PMKYep6Q==
Date: Tue, 15 Jul 2025 14:58:21 +0100
From: Simon Horman <horms@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
	pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
	haliu@redhat.com
Subject: Re: [PATCH net-next v5 6/7] bonding: Update for extended
 arp_ip_target format.
Message-ID: <20250715135821.GY721198@horms.kernel.org>
References: <20250714225533.1490032-1-wilder@us.ibm.com>
 <20250714225533.1490032-7-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714225533.1490032-7-wilder@us.ibm.com>

On Mon, Jul 14, 2025 at 03:54:51PM -0700, David Wilder wrote:
> Updated bond_fill_info() to support extended arp_ip_target format.
> 
> Forward and backward compatibility between the kernel and iprout2 is
> preserved.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>
> ---
>  drivers/net/bonding/bond_netlink.c | 28 ++++++++++++++++++++++++++--
>  include/net/bonding.h              |  1 +
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 5486ef40907e..6e8aebe5629f 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -701,8 +701,32 @@ static int bond_fill_info(struct sk_buff *skb,
>  
>  	targets_added = 0;
>  	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
> -		if (bond->params.arp_targets[i].target_ip) {
> -			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
> +		struct bond_arp_target *target = &bond->params.arp_targets[i];
> +		struct Data {
> +			__u32 addr;
> +			struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
> +		} data;
> +		int size = 0;
> +
> +		if (target->target_ip) {
> +			data.addr = target->target_ip;

Hi David,

There appears to be an endian mismatch here. Sparse says:

  .../bond_netlink.c:712:35: warning: incorrect type in assignment (different base types)
  .../bond_netlink.c:712:35:    expected unsigned int [usertype] addr
  .../bond_netlink.c:712:35:    got restricted __be32 [usertype] target_ip

> +			size = sizeof(target->target_ip);
> +		}

It seems that data.addr may be used uninitialised below
if the if condition above is not met.

Flagged by Smatch.

> +
> +		for (int level = 0; target->flags & BOND_TARGET_USERTAGS && target->tags; level++) {
> +			if (level > BOND_MAX_VLAN_TAGS)
> +				goto nla_put_failure;
> +
> +			memcpy(&data.vlans[level], &target->tags[level],
> +			       sizeof(struct bond_vlan_tag));
> +			size = size + sizeof(struct bond_vlan_tag);
> +
> +			if (target->tags[level].vlan_proto == BOND_VLAN_PROTO_NONE)
> +				break;
> +		}
> +
> +		if (size) {
> +			if (nla_put(skb, i, size, &data))
>  				goto nla_put_failure;
>  			targets_added = 1;
>  		}

...

-- 
pw-bot: changes-requested

