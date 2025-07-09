Return-Path: <netdev+bounces-205202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E258AFDC6E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA591587F39
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7951C7013;
	Wed,  9 Jul 2025 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2SuFBcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38461B87F0;
	Wed,  9 Jul 2025 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021193; cv=none; b=i1bP1JhvKxkwALJymAdambQuJmG/4VrKTaOhj9u8qqtEQ+3120MonNnqR4c+4G6QV+IQrOSH2NVFtf6JnGZfS3iMSRloQ6lrEffYsxlDm2DOGnCIXUSeHUjSyz/PoGn8GMhpRKDDOyemFCeaNxrjQFj+okarNX+Tu16JBi4J63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021193; c=relaxed/simple;
	bh=aO0tVCOFJa4YP+g3yU1gJ8PgZfd6c5KlcrC0VxtfvfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1O5ZKrFCc/RG7fnK+brgMNv4pSfyO2+5LfiSXRhEoslrw/SSvWkeoZ4XUG6MtUF+n6SD33yAbo+wu8O2iAaaVewTMm/yQRBB9JIXU0NGbzR43dZhwHzaMw2s1eWqZCgE66eKPGt95+jwR536a59Ogs57EQuGEyHrFePeUCKlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2SuFBcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1780C4CEF8;
	Wed,  9 Jul 2025 00:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752021193;
	bh=aO0tVCOFJa4YP+g3yU1gJ8PgZfd6c5KlcrC0VxtfvfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P2SuFBcNzw/OiSJP0/eIFoTw0bCtJYYUrONy8vBxsvmx/8sd67p43XYQNM0h1NnlG
	 ldaOXl0FlBECKUpxk9ZRixobL+ikY6paxMB5qFzopYjIB67DcrcC9SpHIsBYTvQuqy
	 OyXNm2w0TOrz+zV8v1+7nUvU28DWNNU9rXu815kRprRL3Kvumyu3I8+o3OLk/xcf5C
	 QH2to4KdIddYzjOnGZP91DEOtbEgmqOr3URydRADifr7kGgpY6YG3XpObKzF8mM7pz
	 4YGUlS779KcJO+x4cOKjyk2i1+ABka7m8xGUR1N4i4OdglllkmhdrnPz7snEya5Pmv
	 mVwaW4rV5Zc1g==
Date: Tue, 8 Jul 2025 17:33:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ssantosh@kernel.org, richardcochran@gmail.com, s.hauer@pengutronix.de,
 m-karicheri2@ti.com, glaroque@baylibre.com, afd@ti.com,
 saikrishnag@marvell.com, m-malladi@ti.com, jacob.e.keller@intel.com,
 diogo.ivo@siemens.com, javier.carrasco.cruz@gmail.com, horms@kernel.org,
 s-anna@ti.com, basharath@couthit.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev, pratheesh@ti.com,
 prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v10 00/11] PRU-ICSSM Ethernet Driver
Message-ID: <20250708173310.5415b635@kernel.org>
In-Reply-To: <20250702140633.1612269-1-parvathi@couthit.com>
References: <20250702140633.1612269-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 19:36:22 +0530 Parvathi Pudi wrote:
>  17 files changed, 4957 insertions(+), 4 deletions(-)

Please try to remove some features from the series.
The chances that a maintainer will have time to look thru 5kLoC
in one sitting are quite low.

