Return-Path: <netdev+bounces-202084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70668AEC307
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 01:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E01C1C2594A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0466260580;
	Fri, 27 Jun 2025 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb0CXIbT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41725EF81
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067414; cv=none; b=fB+HXr5gdSFR9/CrNc8B9pQDoXSLgjYHlJHzehtb7pKCcwkVApgiIiSksHs0pCtvBu5XjcRVwgZRXcS/BwPbfitYBc6DRhyQMhqrLZDAaS913alLeffgMnbGH6BmTuzeMT/eQ/LjUDUkuCVTvQFCuyqCBI3J96TgspSmL+yvQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067414; c=relaxed/simple;
	bh=cybZmJbj0xlDHMuzu3iwxpHkPGdXkmQUNh8pMvBoszQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCzuyPmmbnRhO3fr4426oNu4rg4vnuQQkc67KFgTRbcR7wTPMyaRybVnPUlqqPgxSj1X1NiIismJKX3E+xuXJd62/K1ImNjdyGfhRqB/Ro21GadEN7auNp6vNSuqy0l9iSs8gxlOHaYG50f9yCz9NPTQuLc6JtnIcc/banwsooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb0CXIbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A106CC4CEE3;
	Fri, 27 Jun 2025 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751067414;
	bh=cybZmJbj0xlDHMuzu3iwxpHkPGdXkmQUNh8pMvBoszQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tb0CXIbTj5UCRWgcAesZkPpiGzP4CBaye9WM+JJKmkgGpaz0dCqT0buGIVcnjSMqn
	 h+N3q0DC4GplUJjK9fkKFu7BNtXH7Qjfw2JPllgSx/lNu700Y/sdMzIo7fLsEcavj7
	 zDFCwL9b4onoATuYJa3B6zgl1IGxpujzygllxOIQMBev74x4MWf1+zcqsTtK7KHLBN
	 IvBZkAISAxBisPkpbw0qHsTK6XkyQHI1ifzL4r3j6+NFciTLHq0L0pupKhXj9cfyAi
	 kTzBTeclpLKN6EOxJkHyxkkYpDdSw57SKdtFAgMd6KyeJDH88Kh37XUBI634Nwsnou
	 W9yO9bF45qqzw==
Date: Fri, 27 Jun 2025 16:36:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Igor Russkikh <irusskikh@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander
 Loktionov <Alexander.Loktionov@aquantia.com>, David VomLehn
 <vomlehn@texas.net>, Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>, Pavel
 Belous <Pavel.Belous@aquantia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: Rename PCI driver struct to end in
 _driver
Message-ID: <20250627163652.01104ff4@kernel.org>
In-Reply-To: <20250627094642.1923993-2-u.kleine-koenig@baylibre.com>
References: <20250627094642.1923993-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jun 2025 11:46:41 +0200 Uwe Kleine-K=C3=B6nig wrote:
> This is not only a cosmetic change because the section mismatch checks
> also depend on the name and for drivers the checks are stricter than for
> ops.

Could you add more info about what check you're talking about or quote
the warning you're fixing? I'm not following..

