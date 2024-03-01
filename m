Return-Path: <netdev+bounces-76586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE0186E4A0
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF5281EFF
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D040860;
	Fri,  1 Mar 2024 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roYROw7r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25839846
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308021; cv=none; b=tZAJvAlsuflo4G/FF6pNCDNCf6eWKY8q4uHnd+Ig8B55c91knexEBMJkOOJiNffOFE+iWSbxz07HP+cK+Mafhg1rdkBbdCx5HNjHeqfonx+X7JvzcQ8VFXg6VOL6vjzeTPLnQa7Iif9iXqQZNuRlzk9REOoiqR0Uq3jFBvBuudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308021; c=relaxed/simple;
	bh=2t+8d8j+d6yxKSGlV3SDlwnCFBzOPXKSVFDja9o2iRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phd0YR1ONpf8zHt58bDqO2+L852rn1FYH9RE6GBW2BdjZ3YMDnQyDtuciyY6rBgSUqrXVau2OxSmQhxrZ5pVYxS70kDmfDxt6tZeWrzcyF/lfZHIf3JfVL1cyW0QvtDHs1TN9eK4RptGgS5QD9YY9XSIiOu6LO9r5BX1IJ5KldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roYROw7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A8FC433C7;
	Fri,  1 Mar 2024 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709308020;
	bh=2t+8d8j+d6yxKSGlV3SDlwnCFBzOPXKSVFDja9o2iRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=roYROw7r5rWQmmRoeV7HBQQl5MFg5kIIStmhHbejJJP7PE/hs/Byneg9rgBvUZaWd
	 MhriCYMwNz24RrlR1KA0dsCBtD8qOQCpkZgBdld3hVkDIIlmO3fx5VGvcHG1wS++vC
	 EQpSlLYnVvFJjHKfVURPJ3qkAhc5sXT89ivRFKuhWvEJQc1U0dDO2sA2CR16XS/at8
	 /o7GcFyPNFN/Ft99FSYxJK7El5yEaI1jTLjU+VyJLCI4rPNvBJCkPIvqvEgTZHIbJV
	 R+ZJmmuaBe+u35meGdsN3AkhmCk7RSWj8Q7lJstxNgqK7FeTA6T+VvZuiKHSLjqCtT
	 jH2FyhTeaK+8Q==
Message-ID: <daf172ad-b23b-46b8-960f-d3904224c7a8@kernel.org>
Date: Fri, 1 Mar 2024 08:46:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/7] net: nexthop: Add hardware statistics
 notifications
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 mlxsw@nvidia.com
References: <cover.1709217658.git.petrm@nvidia.com>
 <91689768570fd58a973e1be388d2ebdc62438d29.1709217658.git.petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <91689768570fd58a973e1be388d2ebdc62438d29.1709217658.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 11:16 AM, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Add hw_stats field to several notifier structures to communicate to the
> drivers that HW statistics should be configured for nexthops within a given
> group.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  include/net/nexthop.h | 3 +++
>  net/ipv4/nexthop.c    | 2 ++
>  2 files changed, 5 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



