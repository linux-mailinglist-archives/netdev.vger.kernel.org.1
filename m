Return-Path: <netdev+bounces-76588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1108086E4B0
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9AB28209C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C96F514;
	Fri,  1 Mar 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzcocQ2c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B841A92
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308169; cv=none; b=iK0Kh+eT/X92v2ItbtJ4HViNOoJiMYqBh5aWAsUzmmX9nHD46CTxkQGtMbULXhUJdecCgIsceOQSkcJU/MDefbaLHS1fRj4GpEMIyHpjD2rEnWf7HbSVCuS07VEHEmsaX8T1KlXUJsRRmg7Tp5CdtSjNhmj2k8P0THysN8mvWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308169; c=relaxed/simple;
	bh=oEmz9ea9XjETz0XS/lckfHSEoSb2l/O9ggkSYYltZww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UA5fXaXzpxq5awPwTY+YE7MNanTlPujCNSM77r2k00nX/Dj1U/0NsHSwms1TmLf5qG3AqiouBDLj75X/3S/oK8A50YzW/1+wQEN4NVQdL8gcjzcGlXKdI7q/WwpEn/4VSIEEjdureKyat7qiPq3LBOitfSjIVxezSj4/zv9O7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzcocQ2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0734EC433F1;
	Fri,  1 Mar 2024 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709308168;
	bh=oEmz9ea9XjETz0XS/lckfHSEoSb2l/O9ggkSYYltZww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VzcocQ2c22XRjfAWsqzN6MwDx8Lpw1ugXPbTvO9t5MCdpzX7ZmX6TSPaAR1Gb1EVL
	 MKwzOMLoGtNKmJ2Xmv3HxYZtb8aL7HDqJCboVoEQBdjNEoCoUW3bVRXISl2qszN0SY
	 hSCSf7hcVXZ+v2hokqWz6xkj7Fmn2K1Ybt11niqRgv+17XcJhwkj+tHFmd7lYZXpYb
	 aZNY2q5kPxWtI2FDqYL/xsHeJWDwj2bjaS7LsGuaTUhkKFMQZpasgUon7ne6xAMyv9
	 6CP90cN/MU7+Z8atWxpInJZKTW1rXyLM7P+M7uKSwKrYfqIgUCmbyAJ7TQfbdhY1Kc
	 q8ESLiW2WDo3w==
Message-ID: <e22ebccf-c65b-49d8-814f-a17e9186eb90@kernel.org>
Date: Fri, 1 Mar 2024 08:49:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/7] net: nexthop: Add ability to enable /
 disable hardware statistics
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 mlxsw@nvidia.com
References: <cover.1709217658.git.petrm@nvidia.com>
 <5766037d73a81ddc72106cde93943bbca9289ae2.1709217658.git.petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <5766037d73a81ddc72106cde93943bbca9289ae2.1709217658.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 11:16 AM, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Add netlink support for enabling collection of HW statistics on nexthop
> groups.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  include/net/nexthop.h        |  2 ++
>  include/uapi/linux/nexthop.h |  3 +++
>  net/ipv4/nexthop.c           | 15 ++++++++++++++-
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 


> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 02629ba7a75d..15f108c440ae 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -37,6 +37,7 @@ static const struct nla_policy rtm_nh_policy_new[] = {
>  	[NHA_ENCAP]		= { .type = NLA_NESTED },
>  	[NHA_FDB]		= { .type = NLA_FLAG },
>  	[NHA_RES_GROUP]		= { .type = NLA_NESTED },
> +	[NHA_HW_STATS_ENABLE]	= NLA_POLICY_MAX(NLA_U32, 1),

numbers typically need a name or comment.

Reviewed-by: David Ahern <dsahern@kernel.org>



