Return-Path: <netdev+bounces-115115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C595945372
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBCA2881A3
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2B814A4D8;
	Thu,  1 Aug 2024 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAVS9pcx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA71494C3
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541173; cv=none; b=dSCiiGv7ia/oPqr7nSUJtRC8GbognlBQyYTTnkTnGmad8N+7DqClOkOEKtzjqPkSL4m81zD8y/9pvOzgssanyfD2bMEYIeLPoNQyyWf+7QCA9qRzImYsq+5QPrg6iTeTpMZ4f2U2wKXjoaOKK+Lg3qyZV5SJ0SR/mS1LHOC4q4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541173; c=relaxed/simple;
	bh=f1PjFdrV+7WYI18dhOWvu7E5+cgpO6igUNyNwbUDnsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vobxb113AF/0X8fKViSqxpMkBmt5xeLW4EKwPCla8tXEWqObF84+eG3W/JAo7gotdcKlvBUsB2SJutrg/lnHp06QlupXh3ThP8nncxWXxou8zAIBnv2wKY/r9tef8hAoBBXXDBQUViRctCgQnY2tTCo5ZGG3z2IgGU6l3Pfsvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAVS9pcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D28C4AF0D;
	Thu,  1 Aug 2024 19:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722541173;
	bh=f1PjFdrV+7WYI18dhOWvu7E5+cgpO6igUNyNwbUDnsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAVS9pcxOVtW8r4yDhhrg2O4z5FGzEjXXM36x/kVzjcfrz+LC3XhTsPeu/vV1QJQs
	 bhPO9A7IZhk76zEA1WK4F4ZF0GOnPo+j42VeLNvQz9xCQx5mjJMq2fpY3wbXoOrzbr
	 WJTZKUFNqZRmhb0X5gzUMJwwnmntvs7wRYp7VDqL7rRRL0QHeXcyxCxZyc/mMSoTDQ
	 EVeXOw95oYVl35dF7lww8ElSbF0p54otljBkAWEIkG5lqeYAu9s/y3bjC5M7ezzk4T
	 gXRN+BdISxnWw+0/evDvr8Gnbf2C/ekzWqXKWwvau480AzIbHBTtRlGWSYULQ7dubB
	 Vl1yVhESAyycg==
Date: Thu, 1 Aug 2024 20:39:28 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 2/6] net: nexthop: Increase weight to u16
Message-ID: <20240801193928.GC2495006@kernel.org>
References: <cover.1722519021.git.petrm@nvidia.com>
 <e0605ce114eb24323a05aaca1dcdb750b2e0329a.1722519021.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0605ce114eb24323a05aaca1dcdb750b2e0329a.1722519021.git.petrm@nvidia.com>

On Thu, Aug 01, 2024 at 06:23:58PM +0200, Petr Machata wrote:
> In CLOS networks, as link failures occur at various points in the network,
> ECMP weights of the involved nodes are adjusted to compensate. With high
> fan-out of the involved nodes, and overall high number of nodes,
> a (non-)ECMP weight ratio that we would like to configure does not fit into
> 8 bits. Instead of, say, 255:254, we might like to configure something like
> 1000:999. For these deployments, the 8-bit weight may not be enough.
> 
> To that end, in this patch increase the next hop weight from u8 to u16.
> 
> Increasing the width of an integral type can be tricky, because while the
> code still compiles, the types may not check out anymore, and numerical
> errors come up. To prevent this, the conversion was done in two steps.
> First the type was changed from u8 to a single-member structure, which
> invalidated all uses of the field. This allowed going through them one by
> one and audit for type correctness. Then the structure was replaced with a
> vanilla u16 again. This should ensure that no place was missed.
> 
> The UAPI for configuring nexthop group members is that an attribute
> NHA_GROUP carries an array of struct nexthop_grp entries:
> 
> 	struct nexthop_grp {
> 		__u32	id;	  /* nexthop id - must exist */
> 		__u8	weight;   /* weight of this nexthop */
> 		__u8	resvd1;
> 		__u16	resvd2;
> 	};
> 
> The field resvd1 is currently validated and required to be zero. We can
> lift this requirement and carry high-order bits of the weight in the
> reserved field:
> 
> 	struct nexthop_grp {
> 		__u32	id;	  /* nexthop id - must exist */
> 		__u8	weight;   /* weight of this nexthop */
> 		__u8	weight_high;
> 		__u16	resvd2;
> 	};
> 
> Keeping the fields split this way was chosen in case an existing userspace
> makes assumptions about the width of the weight field, and to sidestep any
> endianes issues.

nit: endianness

...

