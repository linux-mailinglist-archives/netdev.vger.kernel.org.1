Return-Path: <netdev+bounces-46739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E763F7E624E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 03:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EC6B20C6F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F58804;
	Thu,  9 Nov 2023 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF1AKSit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82483A48
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B574C433C8;
	Thu,  9 Nov 2023 02:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699497651;
	bh=2sXfghKvvs+1Sf+834EoQ/nNY3FKvk1JNShHQLfkGcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oF1AKSitNOeVvDE6ffaLVBtrkkZnT6zVxHa8RDBtgVb+NMi7ItmbWwK+wkYBt13oF
	 pxP8yIL5UKFt7/FDfNT9L75GS9GCpG8xVMp5T/cYDIluwZ/XZl4Z0tSWkrU1LdFdtE
	 CH9RCjHookBzGAUz8vIY6KDdBRsd5G+M3ub9JEUAVLmdshbR5KoLLxh4roX+PieSuh
	 4uKKOgDotKgwm2+hYmZeR6W2CJbE9pruNlSqb/I0dc5I4wze0AQpdF+KELRgrvXE9V
	 /V+Y0k92AerOIBu4OtsEftYzGaCLT3RVjC9dyuJKQI0h+0L5GYrdxeo+FDDzq0sxhb
	 ee+0z6VroHKtw==
Date: Wed, 8 Nov 2023 18:40:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrey Shumilin <shum.sdl@nppct.ru>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, khoroshilov@ispras.ru, ykarpov@ispras.ru,
 vmerzlyakov@ispras.ru, vefanov@ispras.ru
Subject: Re: [PATCH] iphase: Adding a null pointer check
Message-ID: <20231108184049.1f27de01@kernel.org>
In-Reply-To: <20231107123600.14529-1-shum.sdl@nppct.ru>
References: <20231107123600.14529-1-shum.sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Nov 2023 15:36:00 +0300 Andrey Shumilin wrote:
> The pointer <dev->desc_tbl[i].iavcc> is dereferenced on line 195.
> Further in the code, it is checked for null on line 204.
> It is proposed to add a check before dereferencing the pointer.

How do you know this is the right way to address the problem.
Much easier to debug a crash than misbehaving driver.

This is ancient code, leave it be.
-- 
pw-bot: reject
pv-bot: nit

