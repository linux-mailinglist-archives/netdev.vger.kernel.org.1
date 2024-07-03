Return-Path: <netdev+bounces-109071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94407926C96
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 01:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEFAB226C3
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955FE186285;
	Wed,  3 Jul 2024 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvBGQEPy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21813BAFE;
	Wed,  3 Jul 2024 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720050500; cv=none; b=sbsxjQLn8ugjqqDWdFg7dFfIRsQQsClPdcxls8D3JEs0KcFPWOTAmxWzvb1VLHl2CiI8wcd+NlzWnrRqVGI0PcA7pXPSjbwHSxqJ0+ACqCN1qqR9XWinZNRYUi8Y3YRKTl8r2LeKi97KDG74kc1cxbe67Y5aXg58A2c5vQmlS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720050500; c=relaxed/simple;
	bh=3EAKouPpI6FP3niYbt2D0U7O15uPOgW9c4Vzms3YCG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gbvmf4CmKMN5pq3y0VYHaLsC2vOAtd1ixPcHXJ5VYcUl6Tg7dwVLQ9PoiUSOyK+AFrrLl2wvNbL7uCls/hauqswsluloPRWIuXNMeCwuRt+mCK5MhGgD33RBJ7oKrMsjUYSheTgNb4eJRD1GQU+FW42dfnpX4fo/wRhyzZ9pAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvBGQEPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6678AC2BD10;
	Wed,  3 Jul 2024 23:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720050499;
	bh=3EAKouPpI6FP3niYbt2D0U7O15uPOgW9c4Vzms3YCG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hvBGQEPyXQxi5gzRvHcmoT3Ohm634kdj2IMUgLn9Th5jV4RnjPvxLmaqYllM8IIKt
	 ZambVVFgH3Vld0yFsjRo5T5Pxy+v7BItlvVytW4gH49/vOmu0N3lqOVCrAVnleDnZE
	 uHSFkfdECysIUt5395FkoMS3Aksf9Lbn/mls0bQDYPmYgMDT1PfKEwa8lWD8BB6qPF
	 vPpNB7x/xA63Bv6f/8b/rq6hq916mtKbkZgPwV/ih+5Dds1Ic6KHi5QAl40kQiYtgW
	 UDUjtXFoRaRAHrftiAliGdVSWp/knD1ANy57cFOzfeMBcfIJBmpId8VFH1QkKFwExg
	 BL8mBSyHq5K3w==
Date: Wed, 3 Jul 2024 16:48:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, pablo@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, Elad Yifee <eladwf@gmail.com>
Subject: Re: [PATCH v2] net: ethernet: mtk_ppe: Change PPE entries number to
 16K
Message-ID: <20240703164818.13e1d33c@kernel.org>
In-Reply-To: <TY3P286MB26119C0A14621AD8D411466A98DD2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <TY3P286MB2611AD036755E0BC411847FC98D52@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
	<20240702110224.74abfcea@kernel.org>
	<TY3P286MB26119C0A14621AD8D411466A98DD2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 01:38:50 +0800 Shengyu Qu wrote:
> BT download and PCDN would create tons of connections, and might be
> easily to reach the 8192 limit, one of my friend sees 50000+ links when
> hosting PCDN.

I don't know what PCDN is, but what we care about in Linux is whether
the change under Fixes introduced a regression. Optimizations, and 
improvements no matter how trivial in terms of code are not fixes.
So did ba37b7caf1ed ("net: ethernet: mtk_eth_soc: add support for
initializing the PPE") make things worse. And if you're saying there
are 50k "links" in real world why is 16k a major win? it's 1/3rd of
the total.

