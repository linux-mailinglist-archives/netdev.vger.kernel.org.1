Return-Path: <netdev+bounces-38593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD987BB926
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C057B1C209F1
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB32C21107;
	Fri,  6 Oct 2023 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj2NXk61"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF54414;
	Fri,  6 Oct 2023 13:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EACC433C7;
	Fri,  6 Oct 2023 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696599302;
	bh=WKO6RcQqAG8IX5IcPTGrGweYu9Qjx2yG0cnrvA8Gkd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gj2NXk61K87JY0oX6au3+Ysj6IhCgw3YMqHreFXxuH3eq2QqFWc3/5/ZTKYgi/8a9
	 hVfC5oJv63xCu5zYPoRcLJ23MMNVMESIgLmMBsSlFXuHS1R+mFIupWPvEplDjPZMiI
	 a6gyqSCLjnJsfB0fhXVy9Ia8qWzXE+VN3/5du1rfUEEE+CIyaqDitasrFzQxC61lhe
	 Z60QmQnIionHURo01fqBf47eVJEKImRVeX5Zhu3TFHPoSRc54xIyF2e2j/HRB2jhFa
	 87qYVmtbjuehh1Une71VwddZIH/RaOq1f7Rj2W++MFvFJzpgB7h+EOi1gksX7zJwvk
	 yBywdNK8XiLUA==
Date: Fri, 6 Oct 2023 06:35:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Rohan G Thomas <rohan.g.thomas@intel.com>, alexandre.torgue@foss.st.com,
 andriy.shevchenko@linux.intel.com, davem@davemloft.net,
 devicetree@vger.kernel.org, edumazet@google.com, joabreu@synopsys.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts
 handling
Message-ID: <20231006063500.035f3604@kernel.org>
In-Reply-To: <cjgx6e3agc6gpvs75nhkf6wlztk73epmct6tcuooyqvk2nx2o2@vr5buyk637t3>
References: <20231005070538.0826bf9d@kernel.org>
	<20231006072319.22441-1-rohan.g.thomas@intel.com>
	<cjgx6e3agc6gpvs75nhkf6wlztk73epmct6tcuooyqvk2nx2o2@vr5buyk637t3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Oct 2023 13:08:33 +0300 Serge Semin wrote:
> Jakub, what do you say if Rohan will just re-submit v2 with the
> addition cleanup patch and let him to decided whether the cleanup
> should be done first or after his XGMAC-EST IRQ update?

Sure thing, whatever is more readable for the reviewer.

