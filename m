Return-Path: <netdev+bounces-75768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAC286B1CD
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A89B2380A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4BB20DC8;
	Wed, 28 Feb 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwxkuPAk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8A15A499
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130608; cv=none; b=CU5fIIQELlMDdWB1LkfpBZ4thfD5fXo2jdL9JLTDC7nrqPbGy7bQmUxNxNgcdzj96ToGvpDHHbUBR/wg0QnJKGU/GzejraeZt0JWzwKKmnf3LiiQ5K+gU2ZPJBU3F12FLWshum1HDDiJ30MYbHtKetKN2VyT0AQWOHGjIgtapB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130608; c=relaxed/simple;
	bh=BCwmu3NsHJ9z9RZdEKXAxJn0MKfKMQFEZ1Y42REEjYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrCM/cplCMzgVsgRmsKDYMoblwxRxcwcf6M29+00qKvAujWC29p+jeldRdfZIGafG+zijH4Su1Oo+M5KiftH+IYAEphQ34iKlLfradcx05tiSFMfcDap84UoFNkTfrZNf7EdXDBbxTN9tUNiGGTqI4CArsGy1j3HLT3KQvcVpRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwxkuPAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A65C433C7;
	Wed, 28 Feb 2024 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709130608;
	bh=BCwmu3NsHJ9z9RZdEKXAxJn0MKfKMQFEZ1Y42REEjYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwxkuPAkXH2CL9mREzwhuXZO+aAKFbOXcDZz3Vh08kiM2xicGbVCPyWJan8/kN1Jd
	 L9rPQVW0T9S/t3FOHGKszXaZRugG2OATSbiI3oaCiGpgdbK2DkDCoCb/K7I+unONSZ
	 KwbOXo3vdTtD1PLTwd9i2+vsyVAEAk4N0QWyc9LwnF10M1SomJWTlDDQK8Ljwak+it
	 adlfLAYdb2irepk6BUrX+Qu4sxLOi+J55S0iwAb8XWcyG78dyleY5dcoKBeL3b0tcr
	 o+E07Q9IIaCGVs4Mg6FL4gogzv3RaKidJ4KrEK1kaKp/s9JbXW0YQ0HRDJUQo+8H5n
	 QQc0kEryeCSUA==
Date: Wed, 28 Feb 2024 14:30:04 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 3/7] net: nexthop: Add nexthop group entry stats
Message-ID: <20240228143004.GF292522@kernel.org>
References: <cover.1709057158.git.petrm@nvidia.com>
 <7b6e4e106f711bf25ffeae1da887f2ef53127ce8.1709057158.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b6e4e106f711bf25ffeae1da887f2ef53127ce8.1709057158.git.petrm@nvidia.com>

On Tue, Feb 27, 2024 at 07:17:28PM +0100, Petr Machata wrote:

...

> @@ -2483,6 +2492,12 @@ static struct nexthop *nexthop_create_group(struct net *net,
>  		if (nhi->family == AF_INET)
>  			nhg->has_v4 = true;
>  
> +		nhg->nh_entries[i].stats =
> +			netdev_alloc_pcpu_stats(struct nh_grp_entry_stats);
> +		if (!nhg->nh_entries[i].stats) {
> +			nexthop_put(nhe);
> +			goto out_no_nh;

Hi Petr and Ido,

Jumping to the out_no_nh label will result in err being returned,
however it appears that err is uninitialised here. Perhaps
it should be set to a negative error value?

Flagged by Smatch.

> +		}
>  		nhg->nh_entries[i].nh = nhe;
>  		nhg->nh_entries[i].weight = entry[i].weight + 1;
>  		list_add(&nhg->nh_entries[i].nh_list, &nhe->grp_list);

...

