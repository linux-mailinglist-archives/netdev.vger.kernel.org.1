Return-Path: <netdev+bounces-31113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F91F78B88D
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5527280EEE
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5D114012;
	Mon, 28 Aug 2023 19:40:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669AA29AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 19:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94338C433C7;
	Mon, 28 Aug 2023 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693251650;
	bh=yS/x4S3B0SAE5WxEAeTZKQjfCSYVYBosMEntmMa+VI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jImMnye5gpm7ZO4ZaxCapaI/8gtOFPHtHJ3agla8hS7pT1PVMw3pEn0/vy1SRG/5Y
	 YWk9xZM0L3EITRbgp2k6ISva7Gik/vxeXKkuxkZcePBR3C2iKv7i0KtQehtFdIdrNp
	 NAGEnplyMNQ0PxGrYHFdKYv97Uk56mdYcYtHHqXW3IQ4EYo3kYQWoFHD/edHAx7vJK
	 xgfISi9apw9LQ/z+m8Hi55WPSDfQYkHFp4UHhlN4ORu4PStJ7TvmsuvuYZQTgWN+QE
	 6Wm0U/Yp0zScf2bIFldUuUDoMbXXaBsqt/sd269PcZey2emu4D75OJZScKAqBJFljY
	 Ghxp56ko0c/7Q==
Date: Mon, 28 Aug 2023 12:40:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Chas Williams <3chas3@gmail.com>,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] idt77252: remove check of idt77252_init_ubr() return
 value
Message-ID: <20230828124049.6bec893f@kernel.org>
In-Reply-To: <20230828143646.8835-1-adiupina@astralinux.ru>
References: <20230828143646.8835-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Aug 2023 17:36:46 +0300 Alexandra Diupina wrote:
> idt77252_init_ubr() always returns 0, so it is possible
> to remove check of its return value
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 2dde18cd1d8f ("Linux 6.5")

How is this a fix and if it was how could the release tag possibly have
caused the issue?

I think this is pointless churn, unless the error handling is buggy
in itself you should leave this code be.
-- 
pw-bot: reject

