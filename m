Return-Path: <netdev+bounces-235688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B72B2C33C03
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 03:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A2B189AC6E
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B22080C8;
	Wed,  5 Nov 2025 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axORwLR/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79D6A33B;
	Wed,  5 Nov 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309237; cv=none; b=E2NUhTJq82LKmEJa7BsHts2LVlqKTbkfXot7uVD8VixtNELX1bmgPmV6fPrd5eUZ7W5sk37iDCRy7103i9FByt5/5twLT9pNNIxyU0UXhA2VB0snJJIcZeFTiFFYwCI7/7JbLSZdl2rnE7/sHs/IIXiH2tctL7+yvrvFe5br+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309237; c=relaxed/simple;
	bh=siu99kukBiiervgH6j7Qp18m5/cq8S+7+ud47iygqU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gesHafLydYpXpbMX4Tr+t5UgGywEa948i8J6jg16lviySWtqGh9e2LbdV6eqd1W/P8iCyrMrsTYCzo3ABHjzotrdeBnasaL0S5FRK/7bPycHsHPdcSJvUZ+ElyEzjwcSG2ocK6xEUe1qRcSxxzNRYIqwEwEtz/CtMicCAX2uuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axORwLR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103CDC4CEF7;
	Wed,  5 Nov 2025 02:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762309236;
	bh=siu99kukBiiervgH6j7Qp18m5/cq8S+7+ud47iygqU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=axORwLR/ybOg6tEvjNILFMj8JaFmkVxdMqarGN4x8bHNWc+pApG6JWZ0GE3SMDN3q
	 s+oSvzV9mUXKrVjxmSzyu+4DyAiFF1mt5qhQ4Gv5MtxLe3cMtA6+NoQ1OTV7O7G5iS
	 oSEq+ozqc1JRAei+X6UYaGD4rgs3AjxNyPHbeX1JeaoZe7mapwk8bS0r4316B5pDPj
	 wzPANsrAFmKb+7BKP6NlqGEreMXHB9fpE+TL/Ij4RBOYzZOP568TE/TOYqXFK5u8Li
	 QvErucOaGSzvoQKU+clJbONyFn/TlCEYiU710qj0FgHvfZTYXbS9R3WjUvNP8VjK3f
	 f397froJTDmkQ==
Date: Tue, 4 Nov 2025 18:20:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, Boon Khai Ng
 <boon.khai.ng@altera.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew
 Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 1/4] net: altera-tse: Set platform drvdata
 before registering netdev
Message-ID: <20251104182035.29082775@kernel.org>
In-Reply-To: <20251103104928.58461-2-maxime.chevallier@bootlin.com>
References: <20251103104928.58461-1-maxime.chevallier@bootlin.com>
	<20251103104928.58461-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  3 Nov 2025 11:49:24 +0100 Maxime Chevallier wrote:
> We don't have to wait until netdev is registered before setting it as the
> pdev's drvdata. Move it at netdev alloc time.

FWIW sometimes the late setting of drvdata is done to make sure drvdata
is NULL if we error out but forget to set ret (so probe returns 0 even
tho it failed). But the error paths looks fine here so =F0=9F=A4=B7=EF=B8=8F

