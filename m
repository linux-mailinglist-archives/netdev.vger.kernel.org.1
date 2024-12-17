Return-Path: <netdev+bounces-152689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A849F5677
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB9716E4D2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC801F75AD;
	Tue, 17 Dec 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewu1+T2O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC39461
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461158; cv=none; b=Y/bol2TKyTY4XFM26lABx8Kll1UtWhY64g56ldAnK3Wj/OQKpCnuzVY0Q4G8op5l5YII17i3ZRxXdL3FGPByvsGXvEt7Rsszur6A0k3zDipjwD1t2QoFX9Q8jI98lwwgL1lNfLZCD93ovOLQ5O/Tge7RjC0G01AQR19VRsqaM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461158; c=relaxed/simple;
	bh=tPp7i/NT3R4gbrIghEp9ZzysKK1UnfceYHuG6Wt8asc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fa2N+kbMbfL4dK+QxRiYH/5wUVSiWa3MSPLIeLT3FCDIeUncPsLP9HFUS8sGutuzRcD+TMEtkWVEq07dfTY/n7wJXpdBr/K5gxCtG8xtCL3RuFaq3Y6Rve3pseKcoTPOSucFISocS2/8i0sdzUOR9MDmrOwjLwwaY6qx0B6iM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewu1+T2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF74C4CED3;
	Tue, 17 Dec 2024 18:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734461157;
	bh=tPp7i/NT3R4gbrIghEp9ZzysKK1UnfceYHuG6Wt8asc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ewu1+T2O6b2DS10grMYoI8kpp2X8XvOs1I+2xGrleLp6Ux4kfGrFEGZ75yO0lJFRX
	 a+gp+tdVeS0y17SmKS7CC/r9aWisadJPvdM01dd9eM0V2w+VaQk2QR1UdSYx6NnHug
	 aa1orZ1Sa8+6MJ0FuNKXA/i/f9UUxaooPofo6g+GB0rvVgQYI5WyBwP2AJCWPnB5Kg
	 9DE4Kxs1iH1bmk5GaTHbxzJth/4qSCy+eOcWCOm0tABYjx8iuVk7Wjv9k1QRC1q2Si
	 IClFSetkpTlk4aXUdYbUUlFUrYrWstfRvfOE0z0+tsk+nz4nCzN1BVNneRhpGou24o
	 e0Oebj1YgRUig==
Date: Tue, 17 Dec 2024 10:45:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: saeedm@nvidia.com, tariqt@nvidia.com, gal@nvidia.com
Cc: Yafang Shao <laoar.shao@gmail.com>, netdev@vger.kernel.org, Tariq Toukan
 <ttoukan.linux@gmail.com>
Subject: Re: [PATCH v4 net-next] net/mlx5e: Report rx_discards_phy via
 rx_dropped
Message-ID: <20241217104556.18e4571c@kernel.org>
In-Reply-To: <20241210022706.6665-1-laoar.shao@gmail.com>
References: <20241210022706.6665-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2024 10:27:06 +0800 Yafang Shao wrote:
> We noticed a high number of rx_discards_phy events on certain servers whi=
le
> running `ethtool -S`. However, this critical counter is not currently
> included in the standard /proc/net/dev statistics file, making it difficu=
lt
> to monitor effectively=E2=80=94especially given the diversity of vendors =
across a
> large fleet of servers.
>=20
> Let's report it via the standard rx_dropped metric.

nVidia folks, could you review? Or you're just taking it via your tree
and it will reappear on the list soon? I want to make sure there is no
off-list discussion with the author that leads to the patch being
"lost"...

