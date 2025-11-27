Return-Path: <netdev+bounces-242151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAFBC8CC3F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA09A34C142
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591FC29D294;
	Thu, 27 Nov 2025 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxrf74cC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C51391
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764214988; cv=none; b=hKfaxalJVhqdJMGqgRJ+mk5YWAr7Zf2KNSch9RCk9TCDFhSsI61rOyIbV67PankjemZwUCPgFukbetYTAfSct6IzV6X84/746xEUHT8FLqODsmIHxBohIG2OlSy7Fo22lQ4oIvFxkUbz4OjAmFTTpN68WQvEf5Jiy69kXbu9aE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764214988; c=relaxed/simple;
	bh=n9n3yGRDHka3SDIZ8zG0ckFrHUiNrWlkVL4RqQb4kmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTAA32F6fRsQMlSMex96Ld3CYTPcZWxNNIJ7GYm0PfhVI55cYDTWgtgKbr2k0+1oHdq54q1BqnFfxAcCzYhwJ7k9jqGDGlYBgysNWKnIhrIiabA5eSYI86+wQGOi78t40PsullPGfmVDi89M1Ls8cLzAgtUpYWXMylNw3syo2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxrf74cC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E832C4CEF8;
	Thu, 27 Nov 2025 03:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764214986;
	bh=n9n3yGRDHka3SDIZ8zG0ckFrHUiNrWlkVL4RqQb4kmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kxrf74cCmUAwvrhSqC3+oIkwm20Zh8Fq+Q8cmPEfOyF1E1nX1++myYJ2qkRgUCTCb
	 oIYg74skYLzxxF98VssOSKUKeINiNNwqlkBaEIAmFM7lJLXvUU8skebZ/53hjWkoYL
	 CvM/WrSOFvFgdapAZ7ifouoBY4kz9D2JHeAfs875CkIHWnWYUq3rE7LnDJS7n9mtu9
	 hfuk26MVddvvxEQlmYtgfXuNnpPMH+/qsKqKEPIg/7m35lPanaRRkV5wxRHje5o7ZP
	 JmOqp4Jr/lzSFGAt8zw0yJ1dcoHvmqAUTC6YV2G+DY/rn17+5uBgN32C/v5lpGJZfy
	 WydEqk8ts7uEA==
Date: Wed, 26 Nov 2025 19:43:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonas =?UTF-8?B?S8O2cHBlbGVy?=
 <j.koeppeler@tu-berlin.de>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] Multi-queue aware sch_cake
Message-ID: <20251126194305.31ebd8e7@kernel.org>
In-Reply-To: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
References: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Nov 2025 15:59:31 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> This series adds a multi-queue aware variant of the sch_cake scheduler,
> called 'cake_mq'. Using this makes it possible to scale the rate shaper
> of sch_cake across multiple CPUs, while still enforcing a single global
> rate on the interface.

Looks like this needs a respin after Eric's recent changes.
--=20
pw-bot: cr

