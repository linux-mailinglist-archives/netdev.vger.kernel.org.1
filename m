Return-Path: <netdev+bounces-194610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63707ACB17C
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 16:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36903B1057
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9570F22CBD8;
	Mon,  2 Jun 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B53WIa4b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BF22C32D;
	Mon,  2 Jun 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873248; cv=none; b=M0mNWgtlUdWxLWdHjx1FL1sZymBamEKi2a+VmoLzxNO/g4Fs1bSh/0tC10qd+Gb660nWp/u1Qa2dl4RP5MTg9cXgzpWtTaDdfR/lSciLJV556b3oNbj6ozmmVUAEsIF0KPd/tLU7S9Rj3mE1QUOS9PAt2zXaNMoT4h/QFqU5Y5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873248; c=relaxed/simple;
	bh=w+RSkZm0dE+tSBY1cwi1pxFBizUVbWZVb7RDencG4jg=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lKgoConlxlVp5mXm5QmTPju65WZUG42tHwLgeelDUR7hdMs/4yfHP8kgot72ZZ5712FHrTUMR6r5Yr+cV2B9OPkAqS0sQ2unziAUy8bI7cZEPEgTJZHaDI/hDnelToSZurj1e32xkLHVDbXYTVP6U5K6slx5GEHwZBuHmwsTa9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B53WIa4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98669C4CEEB;
	Mon,  2 Jun 2025 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748873247;
	bh=w+RSkZm0dE+tSBY1cwi1pxFBizUVbWZVb7RDencG4jg=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=B53WIa4b6cMZe4ym8Clujmp38c5wvyZBWRr1IiCBHjLjms+bKH86r0aqdEWjtMHwZ
	 aahGkobJPyI0uhCoCppUqMIoHNJoibt13GDTQPKx+MVjh2X/Bl1cJH0N/v8kQHx0hK
	 ueJdw+VRPjlDXeJe/s1batWD9CU0/uC9YqChnMfK4G7F7Rk364lyFY6PXCtGibpUYn
	 Uj8t9DNmNxNQ7/DlqdzYBzNWGDc0hVmesVPlpSYLqoOK3phvarCqLKZCfG6vEnTc3G
	 2GqXOxDMKkQwJCHTvfNT+TmsSTc4MSdKduUhr5ulOyTk2jWtDDp4w6EleFxQrv25Gd
	 wPpnmCmPA+/PQ==
Date: Mon, 02 Jun 2025 07:07:23 -0700
From: Kees Cook <kees@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, keescook@chromium.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net: randomize layout of struct net_device
User-Agent: K-9 Mail for Android
In-Reply-To: <20250602135932.464194-1-pranav.tyagi03@gmail.com>
References: <20250602135932.464194-1-pranav.tyagi03@gmail.com>
Message-ID: <EEF63CCD-BEED-4471-BF07-586452F4E0BE@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 2, 2025 6:59:32 AM PDT, Pranav Tyagi <pranav=2Etyagi03@gmail=2Ecom=
> wrote:
>Add __randomize_layout to struct net_device to support structure layout
>randomization if CONFIG_RANDSTRUCT is enabled else the macro expands to
>do nothing=2E This enhances kernel protection by making it harder to
>predict the memory layout of this structure=2E
>
>Link: https://github=2Ecom/KSPP/linux/issues/188
>Signed-off-by: Pranav Tyagi <pranav=2Etyagi03@gmail=2Ecom>
>---
> include/linux/netdevice=2Eh | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/include/linux/netdevice=2Eh b/include/linux/netdevice=2Eh
>index 7ea022750e4e=2E=2E0caff664ef3a 100644
>--- a/include/linux/netdevice=2Eh
>+++ b/include/linux/netdevice=2Eh
>@@ -2077,7 +2077,11 @@ enum netdev_reg_state {
>  *	moves out=2E
>  */
>=20
>+#ifdef CONFIG_RANDSTRUCT
>+struct __randomize_layout net_device {
>+#else
> struct net_device {
>+#endif

There no need for the ifdef=2E Also these traditionally go at the end, bet=
ween } and ;=2E See other examples in the tree=2E

-Kees

> 	/* Cacheline organization can be found documented in
> 	 * Documentation/networking/net_cachelines/net_device=2Erst=2E
> 	 * Please update the document when adding new fields=2E

--=20
Kees Cook

