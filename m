Return-Path: <netdev+bounces-146051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F09D1D80
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003D71F22147
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0495213775E;
	Tue, 19 Nov 2024 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzdPWv8O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2512CDAE
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980698; cv=none; b=UbqnQvTbUMrvm6OR89oATz4PkJvoraLjW7szTf2DzF+/uGqVvefFoSDq0Lc1QldIjGxWIMBqy9gzg2YKPxk4afuGxPvnJDieWsYSjHt1spUz/+m7uWL9RFHgDXv+qT432k2qqhV5rNOn+8yj9CNZLDA/JdfVdeuelbmSL8Upbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980698; c=relaxed/simple;
	bh=Z/txLvl4Yc8TUyGQzPm6CNP9JhRwBWqdG1jlFr/G05U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ke6UmGxu74i3a3vf9caCa2mNrCTNfj3cfQUHNogyqipvkK9GOandwozYOdJLSsTlh0KXCWdhMfSk46JkCCUWpVFDkAwjGdzdaSSQHHvnidXKuMBqfRa5ELbHd0VaFcJRHyPE592KaTSW0oN9+V//qeY15/gJJlEmW5LkNzv177k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzdPWv8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98427C4CECC;
	Tue, 19 Nov 2024 01:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731980698;
	bh=Z/txLvl4Yc8TUyGQzPm6CNP9JhRwBWqdG1jlFr/G05U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mzdPWv8O3YLS4zPylsi73dd4hK17RL310ZjbTLYXmccEirAGDjvq60xaR4g1/23Dz
	 xFRAt+bAHGiqpS6zYtrZVnOSa5NM+u1h+7/mHRwSIxrDxVJsQo3lZZHwF2Dkm/LnaC
	 rr+210O6vQpnDA+0+5VaFVESxlzQdIv2MZFYLAcsd7IyKucUY8vgxpHCxfsPQuDDAn
	 3dLy7wcXePMnrgiYg750wOShf7CxbS9QrgQYqE73sDkqjpdA/j39urb+MiD7hYr3jd
	 ZXu5DTxiBk7S8Rf9QLOtmFJjdPnEN47syrhvUuLvPAqI8zHW1/8lplv6YSpSL2k8+F
	 bzsZhhHVfmAyQ==
Date: Mon, 18 Nov 2024 17:44:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: wojackbb@gmail.com, netdev@vger.kernel.org,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [net-next,v2] [PATCH net-next v2] net: wwan: t7xx: Change
 PM_AUTOSUSPEND_MS to 5000
Message-ID: <20241118174456.463c2817@kernel.org>
In-Reply-To: <7e5e2bda-e80d-46ec-816a-613c5808222e@gmail.com>
References: <20241114102002.481081-1-wojackbb@gmail.com>
	<6835fde6-0863-49e8-90e8-be88e86ef346@gmail.com>
	<20241115152153.5678682f@kernel.org>
	<7e5e2bda-e80d-46ec-816a-613c5808222e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 03:01:47 +0200 Sergey Ryazanov wrote:
> > He's decreasing the sleep timer from 20 to 5 sec, both of which
> > are very high for networking, anyway. You appear to be questioning
> > autosuspend itself but it seems to have been added 2 years ago already.
> > 
> > What am I missing?  
> 
> Some possible funny side-effect of sleeping with this chipset. Like 
> loosing network connection and dropping TCP sessions. I hope that 20 
> seconds was putted on purpose.
> 
> Suddenly, I don't have this modem at hand and want to be sure that we 
> are not going to receive a stream of bug reports.

Power saving is always tricky, but they say they tested. I think we
should give it a go, worst case - it will be an easy revert.

