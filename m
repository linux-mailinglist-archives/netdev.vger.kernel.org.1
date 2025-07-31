Return-Path: <netdev+bounces-211203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E4B17239
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFE07AAFA3
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE102C327C;
	Thu, 31 Jul 2025 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbhTSNME"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09A16419;
	Thu, 31 Jul 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969173; cv=none; b=BNQopkzK241fX8B4W2uZhkFDwyW+yuVmriEtzh01UKHTy0ZQ6FlAl5Pt+Kn6QW9l92EDrC8fPJs5QTmXfFTVKfT2rjhZJF1/Bd/u5iXbNyO0Yd4f8ORlhx3OUbtC+QtrtPjD8jc0lyZEe19VtLulaigCxCHapwwiCPlrrqayhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969173; c=relaxed/simple;
	bh=eIGnOHPHCfFir2odntzKU7nl56N/qsthCsZPU8BUtpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edA8VsbFSuKUF6RGsqB6XZJF5Qgqk5OewL3FNOyZroY+1Sk1Q5zuu1dLqkbz8QZo7bgaSPK9v2sXJ3H2TuztJBxGBEjWYwTls6At9bf4aeZ54DiDjjOxh5F6DithQyieH1BV/A+jekoO8MA2dNnTy+2M4L6FNE1XSSbZHxdpJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbhTSNME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1ABC4CEEF;
	Thu, 31 Jul 2025 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753969172;
	bh=eIGnOHPHCfFir2odntzKU7nl56N/qsthCsZPU8BUtpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbhTSNMEcpldn/LXd3fvrqvCJBqWWBzVhAHKnj0MOh8FWA2pNOE9UHRdsJopB3kXD
	 wDXBebjS0NELEiQEoYLpCq5eB0sJbjLaPCbYcIifzBvDwyEqd7JrLQBoa6pF3Vn8Vp
	 URnK9x8OfKk9OUYois7k8pB2lM1Ku+KAMp3/Jo3CIkn2YESpwz1sTgaoNzUiG1u5IU
	 XMq/d1TY7sRJLhcs89iM1sE2eBciWa9XcFpMS4dLxRTD2WdGibIJsj6SFNi+6/z075
	 cYUuPjYjC80EMRaaPRETS4qjvBRusFczWN3isJfdUFO3f0n+FEol0zwSb8ho+3q9e5
	 HDq+ro98DQYeQ==
Date: Thu, 31 Jul 2025 14:39:25 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: andrew+netdev@lunn.ch, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, fuguiming@h-partners.com,
	guoxin09@huawei.com, gur.stavi@huawei.com, helgaas@kernel.org,
	jdamato@fastly.com, kuba@kernel.org, lee@trager.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	luosifu@huawei.com, meny.yossefi@huawei.com, mpe@ellerman.id.au,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, shenchenyang1@hisilicon.com,
	shijing34@huawei.com, sumang@marvell.com, vadim.fedorenko@linux.dev,
	wulike1@huawei.com, zhoushuai28@huawei.com,
	zhuyikai1@h-partners.com
Subject: Re: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250731133925.GC8494@horms.kernel.org>
References: <20250725152709.GE1367887@horms.kernel.org>
 <20250731104934.26300-1-gongfan1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731104934.26300-1-gongfan1@huawei.com>

On Thu, Jul 31, 2025 at 06:49:34PM +0800, Fan Gong wrote:
> > >
> > > So the swapped data by HW is neither BE or LE. In this case, we should use
> > > swab32 to obtain the correct LE data because our driver currently supports LE.
> > > This is for compensating for bad HW decisions.
> >
> > Let us assume that the host is reading data provided by HW.
> >
> > If the swab32 approach works on a little endian host
> > to allow the host to access 32-bit values in host byte order.
> > Then this is because it outputs a 32-bit little endian values.
> >
> > But, given the same input, it will not work on a big endian host.
> > This is because the same little endian output will be produced,
> > while the host byte order is big endian.
> >
> > I think you need something based on be32_to_cpu()/cpu_to_be32().
> > This will effectively be swab32 on little endian hosts (no change!).
> > And a no-op on big endian hosts (addressing my point above).
> >
> > More specifically, I think you should use be32_to_cpu_array() and
> > cpu_to_be32_array() instead of swab32_array().
> 
> Thanks. We'll take your suggestion.

Thanks, I really appreciate that.

