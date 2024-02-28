Return-Path: <netdev+bounces-75732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2128686B010
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C751C255BD
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC014A4C9;
	Wed, 28 Feb 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1r4wuq8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5BF12CDB7
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125973; cv=none; b=CygEyg/YSzU37U0w8ZJuHfL1SVYyCiNDh0LmGDJbdOuA+14H23G2c4HcxHqUwXPo3hDEK+IiuSHIEih3VSH0pPhgjfmxvtW+coomrObaZ1XUmf+vASL4Kul7+X2/QlOlIfQsyLekgFBm7CITjARy8cxU28IBa46+Np9e1frNE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125973; c=relaxed/simple;
	bh=5VpSvY7WOxmDGzYxW8sgfrz4Es+i9AAOaY0+E4gIzZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD2fumQ2M2uv2RGHbKBkO9doMpOrq+WSF2qoR7CoNZ45YHAQiHsPSiteAy28muKz78Og6iUfvPgaHNmekmOP8xkhpOF561U6TsZfKs9OxWGvytd5Sm0ULJSEBW8zd8uQ90MidP+LvOJpA3Carb0H4k7GsJzxJ2WPK8a/FJiIr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1r4wuq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F05FC433C7;
	Wed, 28 Feb 2024 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709125972;
	bh=5VpSvY7WOxmDGzYxW8sgfrz4Es+i9AAOaY0+E4gIzZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1r4wuq8nXs8xnWKcyMGLGGfuQlNtvNWm04FJgjV3bJUF1LZg5ynDp6nJGpFHbdEu
	 C5JKtwF0iZi4PKBsPZ88JmZIdOgn8/fl4FAI9pGvrVfCXc80KNiXzHMOZESId6LBiI
	 7yv4IYQyxXoxXG0ITKiidFKmH88pBIufEJc1TYo89cPFXFRj2Hlqb4wUkDmsQaIHCW
	 JMkWJOm0QN+PzX6wR/KbSwHg4a1qRE9rjEMFO6Y1G4IPzbXzpGJxvsvijMVs91gSNX
	 R2ii4176ovbNXCygwAhV46VctAkl66dDvBS3t4qpoSpTpJVRje/gfXAXoZlXXAhSCQ
	 BhUea5W/+DJmA==
Date: Wed, 28 Feb 2024 13:12:49 +0000
From: Simon Horman <horms@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
	tariqt@nvidia.com, yossiku@nvidia.com, kuba@kernel.org
Subject: Re: [PATCH net-next RFC 1/2] devlink: Add shared descriptor eswitch
 attr
Message-ID: <20240228131249.GE292522@kernel.org>
References: <20240228015954.11981-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228015954.11981-1-witu@nvidia.com>

On Wed, Feb 28, 2024 at 03:59:53AM +0200, William Tu wrote:

...

> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
> index c81cf2dd154f..ac8b0c7105dd 100644
> --- a/net/devlink/netlink_gen.c
> +++ b/net/devlink/netlink_gen.c
> @@ -194,12 +194,14 @@ static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_DEV_NA
>  };
>  
>  /* DEVLINK_CMD_ESWITCH_SET - do */
> -static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_ENCAP_MODE + 1] = {
> +static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT + 1] = {
>  	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>  	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>  	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
>  	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U16, 3),
>  	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
> +	[DEVLINK_ATTR_ESWITCH_SHRDESC_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
> +	[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT] = NLA_POLICY_MAX(NLA_U32, 65535),
>  };

Hi William,

I realise this is probably not central to your purpose in sending an RFC,
but my understanding is that the max value set using NLA_POLICY_MAX
is of type s16, and thus 65535 is too large - it becomes -1.

Flagged by W=1 build with clang-17.

>  
>  /* DEVLINK_CMD_DPIPE_TABLE_GET - do */

...

