Return-Path: <netdev+bounces-229372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8E3BDB4B0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B76B4E6AC9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA44C306B20;
	Tue, 14 Oct 2025 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQvwyvap"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15272C17A0;
	Tue, 14 Oct 2025 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474452; cv=none; b=RJVy0atbk+B/ZT3fwTg2vu+cnXKSHTfrYe4ha1OasIuGQc4vTqEeXoU22nXIJfC4GkbNp0UHIwYHgp7mMCtuPgL1VpNxmAWBeKzMmFWdtIKrYMflnSQcuivffEwb1BH7oryr12Ssu5T3B1o3AADdPG9dLIIiN84jZ3BjpIDZVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474452; c=relaxed/simple;
	bh=jImoalCcPHmDFBiacMfQm6yGQJymS2ov7FLU0F5bxfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQhy2+5McuN+YYyjqoRDdC2/p5TlXDwe6/LTXpFEzLAPCweqs1iqaFPJwtHgBlvx32F5yjrUOaRpY8+chige451lxjfpV0Du7Ep6aI0TzzBA1YWqZWrq0TnfNmKMA1bhLiFtdZM0fVLA7eEfAMh4J4QfyDpmInAeo6Fa7ZTgCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQvwyvap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A321FC4CEE7;
	Tue, 14 Oct 2025 20:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760474452;
	bh=jImoalCcPHmDFBiacMfQm6yGQJymS2ov7FLU0F5bxfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQvwyvapJDAzAymxezDh2olc4lO3euRwirQUj7nDo5L20NgpBYQHt6Zhk0Gu49lj9
	 X0OfNT7Wlh8z7fdLUtIumR7xhro/W/rwn3ec+5PeXyQAYfQKCTXW5QwkC+/Cao2+D1
	 GQ+/g0Dfpe8Ok6SOWqVACvC9/4Px8/U4GXBjUU8ltgn+oV5zJVUqmVLtBjTDxrDaFU
	 l5VORK5XWJdv+uNLlzXi/oqzEFyT3IFZdJCbt3WdiwOS1rMNPiuHCXKf5hfv+6JQW/
	 pwYCeex3AmupQPwMEzqcTg2KuJsAO0HjdVkI3RTDvAga2LVCY3J9IOpSEWIuTBZc2r
	 ya8sgCgRcunHg==
Date: Tue, 14 Oct 2025 13:40:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251014134050.371d0c97@kernel.org>
In-Reply-To: <20251014-unclothed-outsource-d0438fbf1b23@spud>
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
	<20251014-flattop-limping-46220a9eda46@spud>
	<20251014-projector-immovably-59a2a48857cc@spud>
	<20251014120213.002308f2@kernel.org>
	<20251014-unclothed-outsource-d0438fbf1b23@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 20:35:04 +0100 Conor Dooley wrote:
> On Tue, Oct 14, 2025 at 12:02:13PM -0700, Jakub Kicinski wrote:
> > On Tue, 14 Oct 2025 19:12:23 +0100 Conor Dooley wrote:  
> > > Hmm, I think this pw-bot command, intended for the dt patchwork has
> > > probably screwed with the state in the netdev patchwork. Hopefully I can
> > > fix that via  
> > 
> > The pw-bot commands are a netdev+bpf thing :) They won't do anything
> > to dt patchwork. IOW the pw-bot is a different bot than the one that
> > replies when patch is applied.  
> 
> Rob's recently added it to our patchwork too.

:-o  Nice!

Do you know if it's the NIPA one or did he write his own?
I think we need to add support for some kind of project tagging 
to avoid changing state in each other's patchworks?

  pw-bot: xyz [project]

(with the [] brackets, not just meaning that the project is optional)

