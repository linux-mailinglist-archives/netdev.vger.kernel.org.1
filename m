Return-Path: <netdev+bounces-218285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 471DFB3BC5F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E9C5A11B9
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B031A061;
	Fri, 29 Aug 2025 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjuR/3H0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12362EFD9C
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473534; cv=none; b=cGi6hrs0z29MCBiviCgu4ZDlHKh17UM4AisHp+gpGCRAodmj6R1v+3375kjzOYk+5XsTbQTton2fFaqqPN2xk5siDiKEoD6TKJ2Uy1ZwBm63xMEOWAeovlKDTMb+tRTsFoLb+VKOcapq0Y2tha1iDHsYysopSkpuyvPf6t57mlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473534; c=relaxed/simple;
	bh=Bb8YwPlRN1UInK6yeqpatm1g0DdWJwczBh73E9SO8JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V850SG4vumGKUTO6fnQZaxXtkb/yjzYhQcRCQ3k2I3qHfZs5Hepl+i2lvZzJ1VxUeveyTwdwfgLmtu6VD30WfJ/hfNcdRL+jKrYcClii/DbQG52po8vzr7ZpvwzN4OJ2pzeKSKOy9xNNjE1RcihWuNwZJ5CwFkmyA4wigkPO8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjuR/3H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AC9C4CEF0;
	Fri, 29 Aug 2025 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756473534;
	bh=Bb8YwPlRN1UInK6yeqpatm1g0DdWJwczBh73E9SO8JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjuR/3H0yEDUDWCpdMm8DaqRPBy/j2HiAXw5M9Jgy6xXK+nSKYuWgGpdtEsGIPTsi
	 PftGPvbGTA0jdVTmt5UfyAs6BFEUtlRohVL7fkG69ar8midztAYMPjwxJ2W/Y+n8xB
	 fq2PBR6FA8CCpRIlzGapTlyjXQE55gNoUSg3T3vrozvGSAFzRdA1FUgaJzAZBK1EFe
	 OY8lrgmr0plFE9QY+NS9gxqqDQalwU5KOWPnEWKbIeyKvGnxntTJpDRYqnSil1WYSw
	 RLyGaX5qBBzkqkvaMsEz1AfZiXV5nHKdi4r+tEBwa2FAhS8cXVON/vmaCcVh09tUbq
	 MDeIe8YIduDtg==
Date: Fri, 29 Aug 2025 14:18:50 +0100
From: Simon Horman <horms@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
	pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
	haliu@redhat.com, stephen@networkplumber.org
Subject: Re: [PATCH net-next v8 4/7] bonding: Processing extended
 arp_ip_target from user space.
Message-ID: <20250829131850.GK31759@horms.kernel.org>
References: <20250828221859.2712197-1-wilder@us.ibm.com>
 <20250828221859.2712197-5-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828221859.2712197-5-wilder@us.ibm.com>

On Thu, Aug 28, 2025 at 03:18:06PM -0700, David Wilder wrote:
> Changes to bond_netlink and bond_options to process extended
> format arp_ip_target option sent from user space via the ip
> command.
> 
> The extended format adds a list of vlan tags to the ip target address.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>

...

> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c

...

> +/**
> + * bond_validate_tags - validate an array of bond_vlan_tag.
> + * @tags: the array to validate
> + * @len: the length in bytes of @tags
> + *
> + * Validate that @tags points to a valid array of struct bond_vlan_tag.
> + * Returns the length of the validated bytes in the array or -1 if no
> + * valid list is found.
> + */
> +static int bond_validate_tags(struct bond_vlan_tag *tags, size_t len)
> +{
> +	size_t i, ntags = 0;
> +
> +	if (len == 0 || !tags)
> +		return 0;
> +
> +	for (i = 0; i <= len; i = i + sizeof(struct bond_vlan_tag)) {
> +		if (ntags > BOND_MAX_VLAN_TAGS)
> +			break;

Hi David,

BOND_MAX_VLAN_TAGS is used here but it isn't defined until a subsequent
patch in this series. Which breaks bisection.

I didn't check, but probably this can be addressed by moving
the definition of BOND_MAX_VLAN_TAGS to this patch.

> +
> +		if (tags->vlan_proto == BOND_VLAN_PROTO_NONE)
> +			return i + sizeof(struct bond_vlan_tag);
> +
> +		if (tags->vlan_id > 4094)
> +			break;
> +		tags++;
> +		ntags++;
> +	}
> +	return -1;
>  }

...

-- 
pw-bot: changes-requested

