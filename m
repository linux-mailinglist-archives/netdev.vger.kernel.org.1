Return-Path: <netdev+bounces-202019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D83AEC058
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EE53B10D3
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3CC20B80B;
	Fri, 27 Jun 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1uNH8hz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A21FF60A
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053679; cv=none; b=aEP74QWiHAUYj7fQGwDZDMWWeWNtd3yXPkbxHkv0di/Ffdia8sGC5mTp8v8Ihbx48mbWCFmAn2qwvvZMUlNbwYvP501GA1dSYLxUb9Pl8zc8l6gLQjNI5Fnr6QSvxunBx1iwdy6QSmSpb+TyE+xxIjC6+VBP2ydaYJRoQW9FeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053679; c=relaxed/simple;
	bh=lihP7ieCmTYqs+48TPiXcUDWajsL6f+7bTzO3fUzYGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVb5cwQLo10vjeHBOahEtC/y1tM4WT3TNd59YrkHWPsrBZamDbzUa1q4twk/QVdXMFInHX1b+WWVL0TfBhCGkHClxzYcVOJF/ApjUd9CTQb4AT2WrlrS2BFc12/O2fBqYblc7LuSM3u0L5wQdy1R9QxSBCCG41XatcBbrbFJFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1uNH8hz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD90FC4CEE3;
	Fri, 27 Jun 2025 19:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053677;
	bh=lihP7ieCmTYqs+48TPiXcUDWajsL6f+7bTzO3fUzYGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1uNH8hzeyeoXz0QZcqzAnUU/FCbqZ5OQiWh9BAKqK4+vKj5j4jp+jF7r1ayZO1HN
	 caHf3N0qaJt09/gMI3eXLpY93s7+r5WA5IRTjH5FSd2/S54Sl89urPO/zg+wXXUTY0
	 Uqi3PMkL4qqgCRo33e20zommjrkfDWcg8Lm5hCklD/0UfpWpg5SX3KdQ8vAwLY3xud
	 bJXUgj24MwcWftsR8NgqdB/jmESbWCgu0zUNw6gTBHN8bgXkg5cDFGozPmXxjD7rRa
	 BWIiVtKfLnafN+YYdbDovntFs2zAFhXKkOLXdB0jwOqPKTR4qaYJ7uyDREMetZH64h
	 1ki5o92XXp/iA==
Date: Fri, 27 Jun 2025 20:47:52 +0100
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Loktionov <Alexander.Loktionov@aquantia.com>,
	David VomLehn <vomlehn@texas.net>,
	Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>,
	Pavel Belous <Pavel.Belous@aquantia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: Rename PCI driver struct to end in _driver
Message-ID: <20250627194752.GE1776@horms.kernel.org>
References: <20250627094642.1923993-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250627094642.1923993-2-u.kleine-koenig@baylibre.com>

On Fri, Jun 27, 2025 at 11:46:41AM +0200, Uwe Kleine-König wrote:
> This is not only a cosmetic change because the section mismatch checks
> also depend on the name and for drivers the checks are stricter than for
> ops.
> 
> However aq_pci_driver also passes the stricter checks just fine, so no
> further changes needed.
> 
> Fixes: 97bde5c4f909 ("net: ethernet: aquantia: Support for NIC-specific code")

From a Networking subsystem point of view
this feels more like an enhancement than a bug fix.
Can we drop the Fixes tag?

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

