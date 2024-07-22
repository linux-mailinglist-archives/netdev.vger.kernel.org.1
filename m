Return-Path: <netdev+bounces-112475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B986939686
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 00:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5FF1C21827
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9864437A;
	Mon, 22 Jul 2024 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3fSrIAC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C3381A4;
	Mon, 22 Jul 2024 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721687279; cv=none; b=LZ7Ae+lwT2i45yWHaf++ASfLcEVU3Ccpot8Fw1rzocezVc7/cAgI0iim0dqchreg5WX2pHe40f5WfbLY8Gj7+CWBWaC7edrsUlXs4w5NzAayzbqF8jtwQAc8UYc6pkqRO4RFL+kK+SwelJVnntbDTK1ccV3UIGrdxm3pykwnqBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721687279; c=relaxed/simple;
	bh=R5mtcuHZ9CRIoGx11XT1cmKKnknoxjdH2LTf0cGCtX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKC/BEqbgJhmRPkNJyRA+duEMllc2Zsn+lVB2KSUFU/yZQxJ63apPlEhIhvxtbJVljJWkj8hjtGyWvedCz43FDfB5ykogjln19FXZ0YnzoYbbzP+RZzWI5qwo0ZkBWuLKhftkPl40wXW2W/dP4Rh/oi8+cRlsBjIvljEjElNFgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3fSrIAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938E5C116B1;
	Mon, 22 Jul 2024 22:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721687278;
	bh=R5mtcuHZ9CRIoGx11XT1cmKKnknoxjdH2LTf0cGCtX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3fSrIACMRk+QR/7eleVjA29mdzkTBGUVuX5A3zcqXeut6L/xcMmxw4GrWJQWNsHZ
	 X19UROuusSa2ClPP/U+EyHmq6mr1fvGYQ9/AHk6EAYvUx2Hs6lFBqgsxcKwoQGpdJu
	 d4WMMBuNa75SWbpukW5BJ2GuK77geMtg/BCmbX7W/4qLaHf8JCEuhBhAOsopTJclvx
	 rdQ+0CstCiO+a7GAy3uWltS1jjJN6H1n1P/eTMXegWKL0ZSxjJLpzxBH6i3i0WS+qi
	 DeTL9Oi/1owmkme3kTiCeMqbTsVXQTPauiEGRL2ZA4wHRbiOiNTI4viumBrf8+/mrO
	 Uf/GOD9gD0Prg==
Date: Mon, 22 Jul 2024 15:27:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update bonding entry
Message-ID: <20240722152757.7258e3c2@kernel.org>
In-Reply-To: <51dec0ed-7100-43d5-83c1-e465ec08462f@gmail.com>
References: <51dec0ed-7100-43d5-83c1-e465ec08462f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jul 2024 10:23:26 -0700 Jay Vosburgh wrote:
> 	Update my email address, clarify support status, and delete the
> web site that hasn't been used in a long time.
> 
> Signed-off-by: Jay Vosburgh <j.vosburgh@gmail.com>

Hi Jay! The patch appears to be white-space-corrupted.

