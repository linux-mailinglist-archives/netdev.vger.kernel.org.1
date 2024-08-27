Return-Path: <netdev+bounces-122468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23580961705
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0E21F229A1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C651D27A3;
	Tue, 27 Aug 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNxeKfff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AC1C824B;
	Tue, 27 Aug 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783582; cv=none; b=nbGNq6j4Q4QXAZYilFIJ37/WLlVqZ6r2R8quflsE42EnAoctdf6bkXBy84heiU8ZA7vR5eyZxA3xF/3R4by3vFmcSFlswWAtyd2MaAWY5ntCW4zHZh/qYVNpX8NQwxLp5qQK/bpZyZC+S9H2M5xQCuq0457m/KEqlo58xKzW9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783582; c=relaxed/simple;
	bh=22xQfkvCRh/Z64SGVRBj5jLW9sg/t1blLHJikuQVEZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aml4a2FEXD4/IUO9ZLP90KLusDZ7wXyDjWV8LOUxpKvEfTiicyk6EB6jSTrGMNgj7pY0obv/tFDB9sQcNEB/wCThnwiXpepFWDzp8lvAgWJweM8UZONh9sZBTA68NJlp5n9+3Pjm/twPs9FVrkeQ5lDMVp8TUHkh6SMyAJiV/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNxeKfff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB41BC4AF0E;
	Tue, 27 Aug 2024 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724783582;
	bh=22xQfkvCRh/Z64SGVRBj5jLW9sg/t1blLHJikuQVEZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QNxeKfffYPlKIKx2eyb+9hmorqakSWv0AK1Wbnjdm8tJvw0FQXQjB6wX0BohHcbWP
	 5RlClugzEqGykZFiSWQPN1zsGMf0xp9C0CwYmxdueNc2uy8uoTC9VnSR+9G4/Mn93x
	 UWafM7qVSZZXkGNXWAfBNG6J7tlloVxQRjE/1TUSz+Wyxu/x9a836sf+vuV1ObOcdT
	 UFGyG1zRU/+OBNPtv9OUEhfOPJJTf1wQK4lsafkKKNSt/4uycsIL61P8yF8cqoUrvL
	 fSabpNqlqW2WJzQmCSYW8q2eqfF9rZKZJWtA2P5xzISrqamHFmfoflBVeJ3wnB6dVA
	 cNieFkOfkQm6g==
Date: Tue, 27 Aug 2024 11:33:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines
 for link quality metrics
Message-ID: <20240827113300.08aada20@kernel.org>
In-Reply-To: <Zs1bT7xIkFWLyul3@pengutronix.de>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
	<20240822115939.1387015-2-o.rempel@pengutronix.de>
	<20240826093217.3e076b5c@kernel.org>
	<4a1a72f5-44ce-4c54-9bc5-7465294a39fe@lunn.ch>
	<20240826125719.35f0337c@kernel.org>
	<Zs1bT7xIkFWLyul3@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 06:51:27 +0200 Oleksij Rempel wrote:
> I completely agree with you, but I currently don't have additional
> budget for this project.

Is this a legit reason not to do something relatively simple?
Especially that we're talking about uAPI, once we go down
the string path I presume they will stick around forever.

IDK. Additional opinions welcome...

