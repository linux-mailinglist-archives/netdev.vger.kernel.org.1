Return-Path: <netdev+bounces-109580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7900E928F9F
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 02:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D311C21C4B
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 00:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6428A50;
	Sat,  6 Jul 2024 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZHS3ugT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C3A2D;
	Sat,  6 Jul 2024 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720224281; cv=none; b=oJhqL87/3/xfinFRx4m4aC5wZ2zrHKgxNIc0aaqDF6CqNAXYqkioIK9AbvXUijXXxbb8cdx0IcogW/bCCdwFCIYn8nNt6NQj9o+Exj6cKG7vWMLT5L58NB6AfJWM3I05xeQwVBJfTxb2qG5vAgH2PgEyogIoBHMPfUbwu4zBSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720224281; c=relaxed/simple;
	bh=IArMh7LBFAFgRILBSoSxBbLYgPD5itwwAMFiH8rLREM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHT7Fn5UAQguWuVzeGKlGsyORfOqu0jvuXrjh6gQYUBIlhfBwdijDDnbMUCaCnnR4oAouOeby6HAR7L0lREAz/oXHVfoL5j1Bi+88LieUPbiWS3NMke/tX3NTVxlHUw1uwc2PgWwSiO51fCd1Qv6VPR2nizAKupXCq2oXbtkKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZHS3ugT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B7DC116B1;
	Sat,  6 Jul 2024 00:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720224281;
	bh=IArMh7LBFAFgRILBSoSxBbLYgPD5itwwAMFiH8rLREM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZHS3ugTPEhrdsx4ao8bYfhCGh58kXZEX5JQT1O27ohym7WVDSL9Sxf+E/WrNpwGI
	 R7VboSuCOOtOyCo8PJ/wnphv0GSzskpYw2ZDH/DKJPtOJLFdtUia/Ava41IhfugUqH
	 X3E4qQ4Z1pWZ1h0XkKiYfBWn5gKCKjE7pr0zWNIQHqQNjJN33h5rCXkXr3AxaYJ/3s
	 MlF5ak7CbMZSJTkgxavdRRgAaKItaM/584bQ2tVp72zO0Ut969zMPQFg34uyovmGHE
	 kjtNAd8FSHEXB8lyB70DSGCttezXnB0ly7WtWOcI620H4OcREtKtbiH63JiFs9DdAY
	 QEAO2x050RIrg==
Date: Fri, 5 Jul 2024 17:04:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v3 0/4] net: phy: aquantia: enable support for
 aqr115c
Message-ID: <20240705170440.22a39045@kernel.org>
In-Reply-To: <20240703181132.28374-1-brgl@bgdev.pl>
References: <20240703181132.28374-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 20:11:27 +0200 Bartosz Golaszewski wrote:
> [PATCH net-next v3 0/4] net: phy: aquantia: enable support for aqr115c

Doesn't seem to apply:

Applying: net: phy: aquantia: rename and export aqr107_wait_reset_complete()
error: patch failed: drivers/net/phy/aquantia/aquantia.h:201
error: drivers/net/phy/aquantia/aquantia.h: patch does not apply
Patch failed at 0001 net: phy: aquantia: rename and export aqr107_wait_reset_complete()
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
-- 
pw-bot: cr

