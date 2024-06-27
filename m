Return-Path: <netdev+bounces-107469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75191B1C5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3235428430B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1143A1A071C;
	Thu, 27 Jun 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmqL5kzq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3AB45BF0;
	Thu, 27 Jun 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525573; cv=none; b=kHsWPvYicyY9riui7HjgOG7b3d1QVEjXizYoo9UMIX3vyrcvBBU2c7z0Icg1eRwZ0s+HyXfoW7XDwflT9VerriHq6vovJWHTkwAWjSJmXliDK58j5yqOLlsnszJe6b8fuZ/SJvWpEGtP8b1DlyUs/vKY3VJE4AmjfkeCG2BZRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525573; c=relaxed/simple;
	bh=DUtnwwsQweiesgdTDc4dixo2Pw3X2S4EnfQbGOuP09Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erFa79oDry1uf56LO7OxoN4GP1o4KSBBPqlNBaEsEg9xL3O+yETDomNfsMWqU+HY8EuaGDWUEEF5RViPhCcIgtjyclEY5SwwxJ8SQxnmXETeBsQpaXD5dza+9YIDchEstxw4934ahB2/rJdLiigDBJpoxRlXEs3bXBqqoB6YWjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmqL5kzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2537C2BBFC;
	Thu, 27 Jun 2024 21:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719525572;
	bh=DUtnwwsQweiesgdTDc4dixo2Pw3X2S4EnfQbGOuP09Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rmqL5kzqm8S3dhF71anxBg0KKi0Obuaqi4DZKptUdxaHyF8I/C+Eq3O/n4waqe14x
	 uuc8bDOgTlsAz7mEbC0prblFwJhN+P35nKrCU+EcDlftJwr0VfciDCWTz2PwAKzw41
	 t4rPVE4ox3EIooDJ1Yi7h6xDnDqXmZJiTTYlk4D25BLGr7bh+/SCwtqRzcFQQFOnAn
	 iXII03bU8RHdmZHsnTS0PUR2c4Pvnj6BvyJ/Du5vCrkEpiyHVWWgMRAWvlQ/digF/N
	 q8SYm380A1kD06LP4NHY8kr8miFglbo1WTm5+6fvscZEwZs4aFsp3gnlWHqpFuAhd7
	 6rr+K/KCsSQqw==
Date: Thu, 27 Jun 2024 14:59:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH net] net: phy: aquantia: add missing include
 guards
Message-ID: <20240627145931.480ad134@kernel.org>
In-Reply-To: <20240627105846.22951-1-brgl@bgdev.pl>
References: <20240627105846.22951-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 12:58:45 +0200 Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The header is missing the include guards so add them.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Fixes: fb470f70fea7 ("net: phy: aquantia: add hwmon support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

You say net but it doesn't apply:

Applying: net: phy: aquantia: add missing include guards
error: patch failed: drivers/net/phy/aquantia/aquantia.h:198
error: drivers/net/phy/aquantia/aquantia.h: patch does not apply
Patch failed at 0001 net: phy: aquantia: add missing include guards
-- 
pw-bot: cr

