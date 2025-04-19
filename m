Return-Path: <netdev+bounces-184273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6597FA94095
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 02:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6A27A96FF
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FB3C147;
	Sat, 19 Apr 2025 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJtjy9jU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B1258A
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745022019; cv=none; b=iKbuoYyXND3505v4Vaakj4FQLFzFW4rIFoOBPcE+E2cZx4Vm9ozMuU2JpNt8INWiKtziOObKRXzL97hRKUT7ik+2+kQsSVxPd6JqyaKsmRq+jbRSVRgAtsrg6gFFwwAfKpAJ9H+tmGdRnzKA01uWx4d9adwxtNQuvZ/RkoBmNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745022019; c=relaxed/simple;
	bh=DxWijX3vCOWKSbWEyGafY9X2YBLSWVdL7ihFSfGBhM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4ZtF7lQ/aPrtZN6LeV1c3U5hogrEEU/ZxRlI/uNhA9CJtSwx53VWnlFE2XLvDE1rDc56rQK2hTzyPip7UCEerMWHUp3m3h963ggaYqTKf4+oxDza2sFzienUduOqqzzRcgGSAHgBCUIRvL2GQkDod22tSGGmifCEMOs7hksRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJtjy9jU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9053C4CEE2;
	Sat, 19 Apr 2025 00:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745022016;
	bh=DxWijX3vCOWKSbWEyGafY9X2YBLSWVdL7ihFSfGBhM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YJtjy9jUTO9OG4mm4y1CK/no28z3rjmEROQfy1ffM4k5a+UMIzcIioicPmUMYAm4m
	 1mxkADHX6UShDYi01n67WxgAI18NFWvhhtwNc1F09yZ4wA8VsXhRPmsP/a/3FqoizI
	 jEZzmDzO/PNiWSdhFcPnS4R2QbHWP9xt1jwh6l3nMiUv8O9GXF6XwIYb5o55N0R3k6
	 llB/DRalnQISGVXcF+u8yXv+WKeo3JDoB+kHXkauQu3qPl5uS989A1avSrv/lLMbIZ
	 mRgJfq0vqU6sRqPvghG0xRDbDhtcTiUWlLyYLaSc8IMUWrE5uCq1wBlPhSCiu+MhcA
	 IC5N+82qUkGIw==
Date: Fri, 18 Apr 2025 17:20:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 horms@kernel.org, donald.hunter@gmail.com,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <20250418172015.7176c3c0@kernel.org>
In-Reply-To: <o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
References: <20250416214133.10582-1-jiri@resnulli.us>
	<20250416214133.10582-3-jiri@resnulli.us>
	<20250417183822.4c72fc8e@kernel.org>
	<o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 12:15:01 +0200 Jiri Pirko wrote:
> Ports does not look suitable to me. In case of a function with multiple
> physical ports, would the same id be listed for multiple ports? What
> about representors?

You're stuck in nVidia thinking. PF port != Ethernet port.
I said PF port.

> This is a function propertly, therefore it makes sense to me to put it
> on devlink instance as devlink instance represents the function.
> 
> Another patchset that is most probably follow-up on this by one of my
> colleagues will introduce fuid propertly on "devlink port function".
> By that and the info exposed by this patch, you would be able to identify
> which representor relates to which function cross-hosts. I think that
> your question is actually aiming at this, isn't it?

Maybe it's time to pay off some technical debt instead of solving all
problems with yet another layer of new attributes :(

