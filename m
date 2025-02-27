Return-Path: <netdev+bounces-170362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93042A48559
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3C81884DA1
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BECA1B0421;
	Thu, 27 Feb 2025 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4RsCdOi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F671B041A
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674087; cv=none; b=YgZw0fMl57qVj31wND53a1KSpvZmyM1MKufNLeCw0cbiFpCLW8+bH7ufA+HJu+ru1CrJiHom/FmiruIZ0852V4Y57P0x32Fk3uXhPIoRnYTus/snzM+4OQxHUvnHa5KxndrvMG2ssSB/2afBSjk9vEzuyyIHQsnsRDLz0pnc6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674087; c=relaxed/simple;
	bh=0OWAyt3dqDZpOPG8zEzY5KOJn6j0Uth/O3OxqkWjWog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCql47+aQkjIZ+S8gS7AV7wWhjJt5GGZ8dquXeKn8Zp/bmCgSRcz/npmNw3/vRXdq1joVTjKgqvSEZy6S1iyzDeiKPRbBDcPK7Ku9DO4Lre6xY59E7owwVDbdsWlyvzar9xEWyrMqMpRMKAiDdMYel8P2avRchYt2uOxIjt4ZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4RsCdOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113E0C4CEE6;
	Thu, 27 Feb 2025 16:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740674086;
	bh=0OWAyt3dqDZpOPG8zEzY5KOJn6j0Uth/O3OxqkWjWog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M4RsCdOiAW/CPvflutqrgmUImvsKfiP1bi5o8NgIi1N3SCFbjUJpno8fy9q8FOjc2
	 aMDybi3dn2VwIi5Ub05jGVieL4yzNU3Unf00bVzVP7EbdwfgzbLM0rvPu9z7rykeLl
	 OKUuPLxrf3R3ZBkpBmGQwqOk9/m1OTosmOVWwQmy0n2j3p9eQfK6P513e3mkISIJOY
	 cfqNqBYSeN+wwTNgVRPvP4l66y4uPPExDiofozknh44JtCn8ubZcMz9E26v4ZZNVOg
	 9H/bJFQ4+WWhbQC02goBB58duYf1RZJ0Me0clhDzAwYxMkkvzDUW4uBLIeRLaGiNvw
	 ie3i9/terG3Ug==
Date: Thu, 27 Feb 2025 08:34:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alvin =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] net: dsa: rtl8366rb: Fix compilation problem
Message-ID: <20250227083445.7613e2b9@kernel.org>
In-Reply-To: <20250220-rtl8366rb-leds-compile-issue-v3-1-ecce664f1a27@linaro.org>
References: <20250220-rtl8366rb-leds-compile-issue-v3-1-ecce664f1a27@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 19:48:15 +0100 Linus Walleij wrote:
> +config NET_DSA_REALTEK_RTL8366RB_LEDS
> +	bool "Support RTL8366RB LED control"
> +	depends on (LEDS_CLASS=y || LEDS_CLASS=NET_DSA_REALTEK_RTL8366RB)
> +	depends on NET_DSA_REALTEK_RTL8366RB
> +	default NET_DSA_REALTEK_RTL8366RB

Is there a reason to prompt the user for this choice?
IOW is it okay if I do:

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 10687722d14c..d6eb6713e5f6 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -44,7 +44,7 @@ config NET_DSA_REALTEK_RTL8366RB
          Select to enable support for Realtek RTL8366RB.
 
 config NET_DSA_REALTEK_RTL8366RB_LEDS
-       bool "Support RTL8366RB LED control"
+       bool
        depends on (LEDS_CLASS=y || LEDS_CLASS=NET_DSA_REALTEK_RTL8366RB)
        depends on NET_DSA_REALTEK_RTL8366RB
        default NET_DSA_REALTEK_RTL8366RB

?

