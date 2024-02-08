Return-Path: <netdev+bounces-70065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B37584D7DE
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC331F2253D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 02:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07F2171A4;
	Thu,  8 Feb 2024 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9qmREwF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE83710A0D;
	Thu,  8 Feb 2024 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359899; cv=none; b=cN2qlULsB3jn1/mLULRqTyeycixG2HtvT6nlEV2Yi6u6nba+XqBEXhLP+Z4+75a2uK8N60yGu3vwJjDQ/OzIVaKbQhUdL4Vnz1/isHx+RqYk4SEpYavMILN1pfcmCS/TQl+F660BAeiWcS6vp0ebkcOsEn0tnAeeE43wKo+AtWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359899; c=relaxed/simple;
	bh=alI8hx03tzEZVkrINV8j09Uzyr1QpQRmXAhjnkSmvWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4V/cQYvTfB29d/clX76uuIarPIsG5kxxex4QJYpG7pDbSkCQF82NOLhMPlo6fyAgPeByLWniijoJLFsc9E/g0zPCHnSExtOwsCnNKGy4vOUCpUbaSqbeO2Fpi5/xsZL4vX7Qy4SWDCxUDscMcIsfJTQReUe6mQFPCwFm2E5n50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9qmREwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9640C433F1;
	Thu,  8 Feb 2024 02:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707359899;
	bh=alI8hx03tzEZVkrINV8j09Uzyr1QpQRmXAhjnkSmvWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N9qmREwFi8AE4ab5YdIxmo+96XQ7Ml6aB5whTaK2PCpA1jXfwAbHVfO0usuK/k3t9
	 ZD2v07KpQNJCR4SvgDtmn9Ncc2u50yWizaGK7bwakZuOc+a5j+DGcRG2m5GMU+kayC
	 dGK7aoBfXEViTyRhS6uHKitoV+IYFRO2phlqPGEjw2OHitb1FIKQGi2vSKql605aUY
	 atUmDkBzwzNnSmqYGmQ1H10t2PHwLrADuEm5ovcAgwNImCwABypjieAjsPpDCNv2L8
	 +Uj/KN9RSwd1KWKhzNGwn0C57b35J+gFBDbGpMp0Avc+vF+nlWAweE+pXzLFJEfHtz
	 XUMNDwYI8LZXA==
Date: Wed, 7 Feb 2024 18:38:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
 jonathan.lemon@gmail.com, vadfed@fb.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6] ptp: ocp: add Adva timecard support
Message-ID: <20240207183818.65baa6a2@kernel.org>
In-Reply-To: <20240205153046.3642-1-maimon.sagi@gmail.com>
References: <20240205153046.3642-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 17:30:46 +0200 Sagi Maimon wrote:
> Adding support for the Adva timecard.
> The card uses different drivers to provide access to the
> firmware SPI flash (Altera based).
> Other parts of the code are the same and could be reused.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>

Vadim, looks good?

