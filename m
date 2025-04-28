Return-Path: <netdev+bounces-186600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E7DA9FD8D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B856716DD39
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C0F212FA2;
	Mon, 28 Apr 2025 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H37nmlwm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15A203716
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881832; cv=none; b=rP1QBRuoeqgjUmZpWdcoDH9iSTis3TZU7lVZFdgM1e6Mm19N7Il9Zcyb7RURnvUj60UIbyB5bd3/+ov2TsraPTOzyW69Keq8rvzzaRizQzRSyC7Ord0o5we5SdLJmzJn7q/8aUhuy4YjOWR10pmqX5h4vq52lygNRxFsNoOMMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881832; c=relaxed/simple;
	bh=LOsFLvHVVYz+Ny1MIB2EekRl29BuLnmgX3Z19LZ+Q0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jB28ISA7osteG7hec0DMWq63c1tVL4kne4PvW1t1rKPx3gsmYiyAAKBghHtXf7I853dhXxcTMvTS4AyD2A4kf9oNRWxp7XVF4R6c6LmM4Fum6x2Y1aHAmC1BGcHcPi/ee/Ia2yovDI5VqT75lLzbWYIRrHVKvb+Zs9MwHqea9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H37nmlwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C104FC4CEE4;
	Mon, 28 Apr 2025 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745881832;
	bh=LOsFLvHVVYz+Ny1MIB2EekRl29BuLnmgX3Z19LZ+Q0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H37nmlwmmjJaZQ/avM/DT3hPfuhjnDDCq8DNwEj5pVqh62bxLBZMS+vjYxJNQ+LQy
	 2EeXRA+eUnnDnGNP7H4ZLAC0PT7CRbGyAvKgK8KExqFl834CQB8WDEUDJinrtOTaHe
	 VKzyib9ORZxm1+iNLr2ePHmnsg9HNpGs/bYDHsCnmLvg/VkGG9/3wTc+GUjLuaqXNl
	 RUpiGSClLpDOfMQ2DVz1VSfoo8n5m3Xs7oQt/k/dI4z/17/m/AlsDi0+z1zHjXX/2L
	 VUbyM2/SWv5KyyjDa9PZrC1rqJsAiTW38IdrNX2SzTDXuWvHGQSShoEIb7/XFso3cy
	 M9FLU/W3kwPDA==
Date: Mon, 28 Apr 2025 16:10:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 02/15] devlink: define enum for attr types
 of dynamic attributes
Message-ID: <20250428161031.2e64b41f@kernel.org>
In-Reply-To: <20250425214808.507732-3-saeed@kernel.org>
References: <20250425214808.507732-1-saeed@kernel.org>
	<20250425214808.507732-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 14:47:55 -0700 Saeed Mahameed wrote:
> +/**
> + * enum devlink_var_attr_type - Dynamic attribute type type.

we no longer have "dynamic" in the name

> + */
> +enum devlink_var_attr_type {
> +	/* Following values relate to the internal NLA_* values */
> +	DEVLINK_VAR_ATTR_TYPE_U8 = 1,
> +	DEVLINK_VAR_ATTR_TYPE_U16,
> +	DEVLINK_VAR_ATTR_TYPE_U32,
> +	DEVLINK_VAR_ATTR_TYPE_U64,
> +	DEVLINK_VAR_ATTR_TYPE_STRING,
> +	DEVLINK_VAR_ATTR_TYPE_FLAG,
> +	DEVLINK_VAR_ATTR_TYPE_NUL_STRING = 10,
> +	DEVLINK_VAR_ATTR_TYPE_BINARY,
> +	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
> +	/* Any possible custom types, unrelated to NLA_* values go below */
> +};
> +
>  enum devlink_attr {
>  	/* don't change the order or add anything between, this is ABI! */
>  	DEVLINK_ATTR_UNSPEC,

>  static int
> -devlink_param_type_to_nla_type(enum devlink_param_type param_type)
> +devlink_param_type_to_var_attr_type(enum devlink_param_type param_type)
>  {
>  	switch (param_type) {
>  	case DEVLINK_PARAM_TYPE_U8:
> -		return NLA_U8;
> +		return DEVLINK_VAR_ATTR_TYPE_U8;
>  	case DEVLINK_PARAM_TYPE_U16:
> -		return NLA_U16;
> +		return DEVLINK_VAR_ATTR_TYPE_U16;
>  	case DEVLINK_PARAM_TYPE_U32:
> -		return NLA_U32;
> +		return DEVLINK_VAR_ATTR_TYPE_U32;
>  	case DEVLINK_PARAM_TYPE_STRING:
> -		return NLA_STRING;
> +		return DEVLINK_VAR_ATTR_TYPE_STRING;
>  	case DEVLINK_PARAM_TYPE_BOOL:
> -		return NLA_FLAG;
> +		return DEVLINK_VAR_ATTR_TYPE_FLAG;
>  	default:
>  		return -EINVAL;

Why do you keep the DEVLINK_PARAM_TYPE_* defines around?
IMO it'd be fine to just use them directly instead of adding 
the new enum, fmsg notwithstanding. But failing that we can rename 
in the existing in-tree users to DEVLINK_VAR_ATTR_TYPE_* right?
What does this translating back and forth buy us?

