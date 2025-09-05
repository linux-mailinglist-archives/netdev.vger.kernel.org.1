Return-Path: <netdev+bounces-220497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE8B466B4
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804371CC58AD
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 22:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E328504C;
	Fri,  5 Sep 2025 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri0gJETl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B3524F;
	Fri,  5 Sep 2025 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757111565; cv=none; b=AeMKVOlWbbHFlHUXvURHsi3aJhrpSFeCjHGyM3HQL1iyfnyP+Uj+aYtww8PKjOZm2JJJc9+I/Eks62QaHun4W0V5TEP1em5KiMHZV19uI3fEsLoNT9e/p3lu+Ba21N/ukBNGB6oEQFwJaGffvwd6rVwPxQ6MNfVtJ4cRp6sY2pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757111565; c=relaxed/simple;
	bh=15bRWi7su5MvAmKGNxXt2owYHWtH082o7pkz6sGkzDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av3OUL5VJ3VxV6Lr4AENCMiCeRvwXyRzgflkGLKIqjGlXaEmOcx9reny/WZDe5C9+gmDhf+BvPiKViwVZMiB6UMP5rTIKY6AnZLPXmUif3w/ifh6LxMFFq1HjmrBWGjYoREpo3yiNgx67r4vuQjY0sQOGGaf0hBdCmVDtCjxdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri0gJETl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB12C4CEF1;
	Fri,  5 Sep 2025 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757111565;
	bh=15bRWi7su5MvAmKGNxXt2owYHWtH082o7pkz6sGkzDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ri0gJETlbk+vs52iaTgfVqWmVYfGrw9ZmcjZYr6BcHJ2L4YIbnB6ipwlKoEx8WZ6c
	 VXseXr3SExClQXaiCHF1k0ZYuZDVUMrOE6/84ol2v9Mka+I2O46DjRMNAa6Ibb90cV
	 ifT0f7wAYzxBKKUIzDKh+MNbG9zZlLIBdGJQZglYkl98Z3ERHjAdmyKZ1hepecVJm+
	 XKh+oTFKV4lnzPtCBLN2EzJf1GFVRcN7VT44EkjMDgYa7zjH+fJmD60LTqlNlPtOQw
	 ogd15rRJatEtBsOozt7b/PgXzVMQJbLSseVG2maK3Cg6TkWP14+e1JyGgCMifVKSdE
	 RJ+DfgcrenbhA==
Date: Fri, 5 Sep 2025 15:32:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin Ratiu"
 <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 3/3] selftests: drv-net: Relax total BW check in
 devlink_rate_tc_bw.py
Message-ID: <20250905153243.6c03e257@kernel.org>
In-Reply-To: <20250902162101.5c78cc88@kernel.org>
References: <20250831080641.1828455-1-cjubran@nvidia.com>
	<20250831080641.1828455-4-cjubran@nvidia.com>
	<20250902162101.5c78cc88@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 16:21:01 -0700 Jakub Kicinski wrote:
> On Sun, 31 Aug 2025 11:06:41 +0300 Carolina Jubran wrote:
> > Because the measured total is the sum of two iperf3 streams that do not
> > always start or stop at the same time  
> 
> That's solvable, tho? iperf3 has --json support, it will give you 
> the b/w readings in the configured intervals (1sec by default).
> With the interval based samples at hand you should be able to select
> only the period in which b/w is stable ("middle" of the test).
> 
> While at it it may make sense to switch to lib/py/load.py wrappers
> rather than threading the python locally in the test.

Hi Carolina! I think you replied to me but the reply never reached 
the list, I purged it from my inbox before realizing. 
I think you said that the direction of the flows is wrong for load.py.
Perhaps adding a reverse= attr which will translate the --reverse in
the client process would do?

