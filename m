Return-Path: <netdev+bounces-122528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA110961957
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976A128517B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157991BF329;
	Tue, 27 Aug 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0vOtu67"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7576056;
	Tue, 27 Aug 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794773; cv=none; b=GSMpBgcy4FRa05rP0R9ZYkoWwIUCd1cW9daTu3P/JcXu48m9rJvgwQ6juax4Mnld8wkFbBemsF3xcJJIjEYVjWtLIEeyMYsQj98qducT1EHV21hiv7oLX3ZQkpOlr0fi4mMTblROJ3lXSE50qIHVvZywiGOnoTmiMPX4qKITOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794773; c=relaxed/simple;
	bh=OyyfSKarDP0q5xmb3yBIfxUWdPYlP7qMKRaQ9Xra5rY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7ex7Bo+GW8pRkRigjuQ5uBNimBqudxBMfT9kAA5eG7hMBCfoHTh0UgB0u9KDvHp/FjIedxTahXzt331pHk7f/zvEx+uqfr5ZfvFJcxXWSVxK+al5mqJSxXZ9vZ0/+m7XUCn7WR2dYy8pQ6VYIpDDfgfDi88EnCgFM0VrIKZhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0vOtu67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D94C32786;
	Tue, 27 Aug 2024 21:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724794772;
	bh=OyyfSKarDP0q5xmb3yBIfxUWdPYlP7qMKRaQ9Xra5rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m0vOtu67Jqz5xNycs9l0bChqxtZ4eDW2cu3iMoyYWA9cgsk76bbBSYkiGOgdRbUdw
	 obm1NpuoZzuz/nceWk1kFKungtih7kBSXgpGKC0mJlMntjQ866ZoAoTLDHQc8UJn2w
	 1sMwN9pRT0q0F1c8H2MGiZBcBafU1aagEhRjLHUAeLvYfGXXw0A1Z4P6U+AlxYkgpd
	 VDnDADG7pSB956ffSBqbHM0vSkmpUbqj4jZ8i3tZCfFnL0JTGAmlrk6o1B13fDYq46
	 mNrKdOWX6POsieDD+MS7+OtKiks8mGEB2soDpcMCwdVI/hvUImEtq1fp4k8jcThnaL
	 FlV7ZLopgyzRQ==
Date: Tue, 27 Aug 2024 14:39:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Kurt Kanzenbach
 <kurt@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Georg Kunz
 <georg.kunz@ericsson.com>
Subject: Re: [PATCH net] mailmap: update entry for Sriram Yagnaraman
Message-ID: <20240827143931.267bb6b7@kernel.org>
In-Reply-To: <20240827120558.3551336-1-sriram.yagnaraman@ericsson.com>
References: <20240827120558.3551336-1-sriram.yagnaraman@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 14:05:58 +0200 Sriram Yagnaraman wrote:
> Link my old est.tech address to my active mail address

Thanks for updating the email! We do need a sign-off on the commit,
tho, no matter how trivial.

