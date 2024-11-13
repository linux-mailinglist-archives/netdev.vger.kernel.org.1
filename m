Return-Path: <netdev+bounces-144565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9699C7CAB
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2891EB2B614
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85F92064E9;
	Wed, 13 Nov 2024 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyT+5abr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E886206055;
	Wed, 13 Nov 2024 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528676; cv=none; b=jHPfuW/TjvQ36OXQr+C4L8x0LUU3N4aDo7lkjMOtwZsYbYbHHtAZySc235fZQ8IB/sBFnUZWoIHJ6Lfy0jEtkfDpNvjAmQ+10B5x73IIPex/JzfJVLio17Bvo+dNdUkoHaegibFArHQ85rTYUNjItBEwe/59Q1HTMU/GZhChTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528676; c=relaxed/simple;
	bh=0K5rEeoeObf9zxwGU6THIE8DvR8gVbXKv8jXOEA7K80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8zq7pcQBwmzAF2JHLgG2vHaxfE7xGD7DjXzRsvnR6kg43I9DP3hQEzYm5oUcm5ZPhv6gtPKZSQkJwwhfKmDWOoImCED5jll41il2hclxvyNypLu6UUZ+a4dt4sohNSJcc+DUhmtufPHOeJLExPC7pdTEZplxF7kRyWN9HMyMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyT+5abr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2819C4CEC3;
	Wed, 13 Nov 2024 20:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731528676;
	bh=0K5rEeoeObf9zxwGU6THIE8DvR8gVbXKv8jXOEA7K80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oyT+5abr/w519HqrX7WQHtQIild3YhjmXDnqCxIPTbAwsacnjmXEuo8sCXS55gw0I
	 dqbq0cLTYIeQWcAJCKqs8O0wvIWVfdVkgvkRlO6uPC7eBgMN0Ao3mtTF0A2eQlP6Zn
	 NYz/wVRRQcnsZbCRwhQkkKbkchWBL4GG+xIXfbOJPj8mAEaso5BMeao3dmrFvv2g5l
	 jfV+Dm/XjqsOn/XqSX48egu97XPhv4hxJexyrGsqimVLmTo89yVPmMi7GoqiLmGm4a
	 5EAZschDwy1jdXMEe3UyY5j92Gh/8a3xYlb3dkuIZOwPbgTmMfAqMu3J3EbLVfZRIQ
	 2qSslapbNI1rw==
Date: Wed, 13 Nov 2024 12:11:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, horms@kernel.org,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, kory.maincent@bootlin.com,
 nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 2/7] ynl: support render attribute in legacy
 definitions
Message-ID: <20241113121114.66dbb867@kernel.org>
In-Reply-To: <20241113181023.2030098-3-sdf@fomichev.me>
References: <20241113181023.2030098-1-sdf@fomichev.me>
	<20241113181023.2030098-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 10:10:18 -0800 Stanislav Fomichev wrote:
> To allow omitting some of the attributes in the final generated file.
> Some of the definitions that seemingly belong to the spec
> are defined in the ethtool.h. To minimize the amount of churn,
> skip rendering a similar (and conflicting) definition from the spec.

Hm, is this mostly for enums and definitions? We have header: for this.
"header" should tell the codegen that the define is "foreign" and
should be skipped in uAPI, and in -user codegen we need an include.

Coincidentally

make -C tools/net/ynl/ -j

In file included from ethtool-user.c:9:
ethtool-user.h:13:10: fatal error: linux/ethetool_netlink_generated.h: No such file or directory
   13 | #include <linux/ethetool_netlink_generated.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

