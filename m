Return-Path: <netdev+bounces-187348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4D5AA67DA
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 02:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4D23A404C
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E562DDCD;
	Fri,  2 May 2025 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9hrbSwn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB9847B
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746146364; cv=none; b=X9ZNAkGzNsgVPcfJ6hfHLsMMXkB5jfnUCoJbP7bWVLFNzZrF61TCgu229Jgm+nBks0n5x426uiUQy3xoYgOIjCtix9Eu02ZJG8m6ghRzUbqTLbqSahu5/IQyJDOY+PTPX7rZ0w2o5WgGW4Kv4KMs0TW4LxGTwVejW2e4ItFHrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746146364; c=relaxed/simple;
	bh=+w/QYqOVKjnbGsE3Qy+vqkRkuxFoSRTZyjqMf1XYYAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azCRPM6U8g5nBZg2J2JVolaYrY9/ZCZIpJLI0xaHQwLgdVvkK9qMHpx2RaXjCTJIrnMfkfqSqCNruK7rRgKcpcycXwRMbsomTIvzNkZQc4Pz7E14X4/9Q+2fQ5IimfG22hc+qGhLY5pHViB4gW0OxUdcTuo7ARS5qCXCVs4Mmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9hrbSwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42BFC4CEE3;
	Fri,  2 May 2025 00:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746146363;
	bh=+w/QYqOVKjnbGsE3Qy+vqkRkuxFoSRTZyjqMf1XYYAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k9hrbSwn4zTlYgeaJ4BFHXyPjC5Y/r7zz71/U4c7g6AAE2cx6DeR0z/vOPZ/zgQz7
	 wc0g/I/Ekg6RI1s2DoAb/kKEpC88HhC7QP1CdoussxW5MMnP91804Aqrgyo79lPNiv
	 2AP7ZLAboCpfrrmBgPD7noz4+gWhXjwVYT8Ahzi9BaVmEAupq26JuWQP/H87xq/XhP
	 ShTxy0UA493jpO5KVrq3adwJEm1q7Wwl4HNE9EZoMVGsB947VihQ82bOO6UwVZCGA9
	 +5O4/BwJToeqXCfwIMOLsMazkpieCTUZY2M+XvlkfyegvvBKiFERBVultrotAkwr/3
	 Ps7epGueisJnQ==
Date: Thu, 1 May 2025 17:39:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jiri
 Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <20250501173922.6d797778@kernel.org>
In-Reply-To: <507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
	<20250424162425.1c0b46d1@kernel.org>
	<95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
	<20250428111909.16dd7488@kernel.org>
	<507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 11:37:51 +0300 Moshe Shemesh wrote:
> >> UUID is limited, like it has to be 128 bits, while here it is variable
> >> length up to the vendor.
> >> We would like to keep it flexible per vendor. If vendor wants to use
> >> UUID here, it will work too.  
> > 
> > Could you please provide at least one clear user scenario for
> > the discussion? Matching up the ports to function is presumably
> > a means to an end for the user.  
> 
> Sure. Multi-host system with smart-NIC, on the smart-NIC internal host 
> we will see a representor for each PF on each of the external hosts.
> However, we can't tell which representor belongs to which host. 
> Actually, each host doesn't know about the others or where it is in the 
> topology. The function uid can help the user match the host PF to the 
> representor on the smart-NIC internal host and use the right representor 
> to config the required host function.

Insufficient information. There are many many hosts deployed with
multi-host NICs which do not need this sort of matching. I'm not
saying you don't have a use case. I'm saying you haven't explained it.

We exchanged so many emails on this topic, counting the emails with
Jiri. And you still haven't explained to me the use case. This is
ridiculous.

