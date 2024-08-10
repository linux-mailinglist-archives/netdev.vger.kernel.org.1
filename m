Return-Path: <netdev+bounces-117352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73FB94DABB
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 06:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A0B7B21553
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 04:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964785FEED;
	Sat, 10 Aug 2024 04:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsMmd9zd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72495130AF6
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 04:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723264686; cv=none; b=LLLimCfn6/8apg0CWKbFGusMY7xbQ6QfvtEUZKWedGUG945FWzGUTHCqm9Bx1cJ6E5/bVnKS+c+EBnTE6Li3M6XhhJcmup3mHJeFkM8GREcDlm4NHMqWtaubja4Rs6ApowqgK76ooUuRQg5dp2iwV9tGhrIL2Lp/SUK0rB9eoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723264686; c=relaxed/simple;
	bh=BEz4De9B4leKO/E2Zt0KzPwOhwRIoy9KxoMphqOQ2Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teFT1I9UP54KGnS1YfNX6cvK44h76CD0ONEkBWNGRpJQTZjcweFM5d2SpnYjHnK7q4pWPY5uQ0q5wJjHZ9nX5Nudd5X4TxpKfZIhZHOV+cPONm3DDerPgswEaL+DOeR4gCp2fiszPFqaXWGdOujwYBX0k3gyHX4v85qNcwLL/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsMmd9zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8C9C32781;
	Sat, 10 Aug 2024 04:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723264686;
	bh=BEz4De9B4leKO/E2Zt0KzPwOhwRIoy9KxoMphqOQ2Ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XsMmd9zdBefZt4UxxSQFivTPTmMXHR3Kra2BspUaff+X0DkgYl39TA3IL2V1ept/r
	 CxTVPnlTvJiNSy9ovp56YvPExqLL23/TAVFsdFLzb0fw2A+CrSoFT3BqpYucbEdC5K
	 tw5SX3sibcvDmT9pODpwBELmuSAgqxcYq3t4J8gfwji/0m3lM/MZJt8JAcVD0zo6fn
	 cfEkK0uim81eob86iRXGNNk3NOMoe2K0aaEVJZIc1Ep3sflQfKh+9YlyBT325LFS6+
	 1UCD1IG7tYvgxTm3LCecH398T+zHTQG0AFCs/GHzQv2mRN/WUPRotYXbYBJx++WtQ/
	 yjsYevRmlm8nQ==
Date: Fri, 9 Aug 2024 21:38:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org, Tom Herbert <tom@herbertland.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: On KCM maintenance
Message-ID: <20240809213804.7fa79cf1@kernel.org>
In-Reply-To: <c99751b0-ce71-4a27-99c3-097b62078179@yandex.ru>
References: <c99751b0-ce71-4a27-99c3-097b62078179@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 08:13:11 +0300 Dmitry Antipov wrote:
> Recently I've posted a tiny pretend-to-be-a-fix for KCM sockets, see
> https://lore.kernel.org/netdev/20240801130833.680962-1-dmantipov@yandex.ru/T/#u,
> and now I have a question about the subsystem's maintenance status. Since net/kcm
> is not even listed in MAINTAINERS, it would be interesting to know whether the
> subsystem in subject is actually alive and worth any further development efforts.

Maybe float a patch to delete it, and let's see if anyone screams?

The concept KCM implements is really nice, but the lack of bug reports
also has been making me wonder if its in use.

