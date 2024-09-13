Return-Path: <netdev+bounces-128076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D33977DDB
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A81F21633
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD1D1D798A;
	Fri, 13 Sep 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP2inU4l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD651D6C61;
	Fri, 13 Sep 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224038; cv=none; b=d/77wOZpXfnGaWGUkKxYIK5tfDVQvOsk6KzWGVfXz97b2DQMQSRkZhHURcPHS4G+Buf6LiN3FN0Afoaj48c3wxjDq9lPT/eKosUh/V1PGfmOcdRDuK5gLSh5YjIR2mrJVFtD/ITEPFHTO/pDAy3yTNAM/JScS687OPUzZW4VvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224038; c=relaxed/simple;
	bh=dxP34wf6919+jjMGHjFc2JaMyBABNSA41Fvu/tZYb4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoMobPwEeYUUZjEnS2fBuq86KvJJ9E4TuHe5dPZv+vDHVFroGoJvAIMWJ1m27KFJQJ3/g+dXlcd8u85ud2yx7VvJ1vB9Z8CG3sbYP1zvbzOrNrXgmqDQ14R3DO65NdaW7lwg3IORXKBZndwRovYse8zUSQsG2erVHdPHIrZCSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP2inU4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E27C4CEC0;
	Fri, 13 Sep 2024 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726224038;
	bh=dxP34wf6919+jjMGHjFc2JaMyBABNSA41Fvu/tZYb4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZP2inU4lEp5txQNxR4G5hcdC8pWe7aXvG+5zSS0rgYCjeY8LqFexlrtrRryL02EaB
	 4flqrhN3cc3wrP/qNL3NUuwKvGajuNVU0wdTNo49Gi/t3EcMoQzhLvPmV5gVYhsRAu
	 I8lg2603kuHxTRvL1KsME620qtmhrmQqn74HcT93dLfrkTuaHeaRsgCv8gvRQ+ZJEn
	 TFIoes2Pn4i6hmwf9zXReljOIx7J9xWLuhWgns9Ev9JXWWvvTrKtEhMmFh6blKF/UF
	 R0kwQll31trA0EpKOqel9KBpT49q8SrGZIlPuMRWjATwKqL7Pm21xQBWdB1wyTSZPT
	 SHIEDCM12IYAg==
Date: Fri, 13 Sep 2024 11:40:33 +0100
From: Simon Horman <horms@kernel.org>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@collabora.com, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: enetc: Replace ifdef with IS_ENABLED
Message-ID: <20240913104033.GT572255@kernel.org>
References: <20240912173742.484549-1-martyn.welch@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912173742.484549-1-martyn.welch@collabora.com>

On Thu, Sep 12, 2024 at 06:37:40PM +0100, Martyn Welch wrote:
> The enetc driver uses ifdefs when checking whether
> CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
> if the driver is built-in but fails if the driver is available as a
> kernel module. Replace the instances of ifdef with use of the IS_ENABLED
> macro, that will evaluate as true when this feature is built as a kernel
> module and follows the kernel's coding style.
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Reviewed-by: Simon Horman <horms@kernel.org>


