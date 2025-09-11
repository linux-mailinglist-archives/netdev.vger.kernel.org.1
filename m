Return-Path: <netdev+bounces-222187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F66B53633
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493B7580370
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2032F774;
	Thu, 11 Sep 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxJzUK43"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492ED32142A;
	Thu, 11 Sep 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602018; cv=none; b=R5bYmIxnEpmppXHEF6mqMBrhE/hI6kpEAi4/3qDTNcv0Oy49CmYIbDlEviJkUqi0TKzQqHsNIKSEt9r4i9ZwUVYc39YKeWIJ2yLvymJ11L3GXl6MM1UHa/Dbs6ZeJ+lTb/9twOxG3g7/NRdiNx3oJ25wEumnXAJiX3lqCFb4y1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602018; c=relaxed/simple;
	bh=AScwEGrc4niccpy0at9rPdskd8JseR5y6sdKWlKcpa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anP/4Q6ATM/IQE/dTxlmyYynZUq8jBjyozIuuTxOISg5f6eBNlOzx6Vx3PPY8UX/9SWRzHq9pm+7bbVOBDvXWGJbOJXGtlFVbYK8Cr0nU4L1mJSOvykLZAuxotN0UfpJjF1LQx/bIc+vRNw3t5W194F90j6b79ElHXut4W/IZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxJzUK43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF74C4CEF0;
	Thu, 11 Sep 2025 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602017;
	bh=AScwEGrc4niccpy0at9rPdskd8JseR5y6sdKWlKcpa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mxJzUK43CmteapOxCgIQ0Sx/dqaJOR+ufg/npyB3TLQUBaBEfV2AT68MWo/NOtXpd
	 qHOnmJcR/5ij7BmXZIv6Kvwkwr3RgVseGBAsGQ6SFIYoRb57eA76Wu8K6hhhXkh6Vz
	 D3LUBMfZqrx7S+rNqktJu74fq5ia7ZItgGzufIZrH1mchOSLXsuHfqwRW8Uvl2J4eV
	 8CvxnFc1TYjdfpaaMJwDKsQyVlApykd6Ae/jYLgHhC2cHDrtqJ8vi09EM037O72IJX
	 ZMbggv4SaPNO01B+Gczrn+EFoZx2GBs4ZRsfqDpNIkcqrzpBI0/9aLQStNwdZv/U8d
	 2JyQ/wKi8Rt1w==
Date: Thu, 11 Sep 2025 07:46:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Oleksij
 Rempel <o.rempel@pengutronix.de>, linux-usb@vger.kernel.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Hubert =?UTF-8?B?V2nFm25pZXdza2k=?=
 <hubert.wisniewski.25632@gmail.com>
Subject: Re: [PATCH net] Revert "net: usb: asix: ax88772: drop phylink use
 in PM to avoid MDIO runtime PM wakeups"
Message-ID: <20250911074649.5c6ca7e2@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20250911073858.0cf4bd1b@kernel.org>
References: <2945b9dbadb8ee1fee058b19554a5cb14f1763c1.1757601118.git.pabeni@redhat.com>
	<20250911073858.0cf4bd1b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 07:38:58 -0700 Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 16:33:31 +0200 Paolo Abeni wrote:
> > This reverts commit 5537a4679403 ("net: usb: asix: ax88772: drop
> > phylink use in PM to avoid MDIO runtime PM wakeups"), it breaks
> > operation of asix ethernet usb dongle after system suspend-resume
> > cycle.
> > 
> > Link: https://lore.kernel.org/all/b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com/
> > Fixes: 5537a4679403 ("net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>  
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Ah, missing:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

