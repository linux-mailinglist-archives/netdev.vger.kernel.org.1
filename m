Return-Path: <netdev+bounces-249692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4037D1C2E8
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9541B3012254
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1932BCF43;
	Wed, 14 Jan 2026 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXWM6BDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2E2356C6;
	Wed, 14 Jan 2026 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359732; cv=none; b=HTPixT/CZS707HGoaB/L6puHRsNds4h8wNvfv3m771wx8ZnkIzj2gUt4tvwVvdzdULgLnkfMdqjTb/N1cN0i+qmO7WI9t65DjEFzxdTorrcRyY1v9OjiavfW2Lifx8hl7IrpvF1fyWaZKejgLG/ihc9ZSrXG/8j+IvF0wUIg7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359732; c=relaxed/simple;
	bh=v7Y0cxUB+ZK/4JUhXqBaIjT6u2OfUUkLzJ7JLKX7x3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyI3r4XmpA7iw3M7KMU3OPWHEVlTWm58otZzBTgvHSb//4z5oW9vA1PH7z46W6aRIJdlyIP48Tcunf6JUV0Cjo0DvdecUY0yFRasCx6X7MEyONrbwsDWaF7b4Tp/pUsQauFVIDjEcOLe4PtBwjtBEjN2vBxqcxVQdAQg75NkrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXWM6BDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ACAC19421;
	Wed, 14 Jan 2026 03:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768359732;
	bh=v7Y0cxUB+ZK/4JUhXqBaIjT6u2OfUUkLzJ7JLKX7x3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KXWM6BDWzLo5Cv+dcEofXhrHvpUMI/aCOPqG6l+P/Gd9XsrP/IYhv22IOWjHGMc5H
	 7LwIRh8RKQEPiwyuOr66ua3mGolNjE4n5bp5J3GuVyUH4LQb+kuUJKA4KbpJPzs8Te
	 9zxU1XkK8ujNkLDCycY2fHNmmZu9OvLR6Q97OT2QpYqMll3lrBxvczfvaGRTpYafef
	 VpSMO7qbt9xyFEtl0yDUDMa8oTXJbxNoqWrz9ORuIZpBoI9ep3bqiyMRJPiNt9x9Dk
	 xV2zEH/WenlRjuHWSwJKKLjVM7WBkyYCPL/knlby/b0GHq80Y29iU97LDTTfwDAv0o
	 J0ICBMYxuFU/Q==
Date: Tue, 13 Jan 2026 19:02:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jinseok Kim <always.starving0@gmail.com>
Cc: quic_luoj@quicinc.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qualcomm: ppe: Remove redundant include of
 dev_printk.h
Message-ID: <20260113190210.5387bde1@kernel.org>
In-Reply-To: <20260112042038.2553-1-always.starving0@gmail.com>
References: <20260112042038.2553-1-always.starving0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jan 2026 20:20:38 -0800 Jinseok Kim wrote:
> The header <linux/device.h> already includes <linux/dev_printk.h>.
> Therefore, explicitly including <linux/dev_printk.h> is unnecessary.
> 
> This patch removes the redundant include. No functional changes.

Unless there's some effort to remove the dev_printk.h header let's
leave it as is. Depending on header dependencies is not generally
recommended.
-- 
pw-bot: cr

