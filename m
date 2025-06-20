Return-Path: <netdev+bounces-199806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A79AE1D87
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BF86A1276
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBE29290F;
	Fri, 20 Jun 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9daLWsx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4628A418
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430163; cv=none; b=hJbjI191jz+6RpXlMjfgWY1KNZgDAbXDmk/TzvYvGWk5h2OQBDcmQM7Y14NhTQyAln44BKe0KPt8xG18TGmcLpur55wjt7ogMa7ys/mEGZ1De9Am2k6+WR0QN44zLDj1v8DpiN5EYdl7l0wwUGNGiKUyJOiIdAaR1vB35GNgpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430163; c=relaxed/simple;
	bh=6KW2JHIS2GRn6o9xiB1Y9oAL4UL/33kfTtb/bU9Ypi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fo1Rm10KXt1DSF3tmRPh96vsfxDyAGjuFIxLBxVm5ckHMBY0vsn27l2xcAzzOxP377MwcGTc5tcxbUgx9lMbpjdL0w9NAhG6Rl73R4pCAt9ebhS0/+VvMd3cr0yyUHJ8VT/W6hPJE/rRLROyZZhnkv6iqSWQ0oAvUjmhWEJUJyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9daLWsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA734C4CEE3;
	Fri, 20 Jun 2025 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750430163;
	bh=6KW2JHIS2GRn6o9xiB1Y9oAL4UL/33kfTtb/bU9Ypi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O9daLWsxmyHN0QKDMCXCOWcUZbhZ55RjTO355lXARADJ4Zf/Bq8xkosMrUTM5sJFH
	 YVYZI1OFElozgeuxQz0ZGqoCrUChG+ORTk4py6G7nknmhYw/ZFOKBkMVqCDWRVPNPU
	 f6w2hvinc5xOQimPEO1lu9YZC/SKL3gzFLs71rLbWRDCEhNX7QSqgfe9E2UIOkdvZh
	 XOWONZBtQh3l2JNdM9g1DF76NSH8SGLveiHFnl4Ff2DoVHaGeRuheZJjF41CnVjK/1
	 ajj+CihpMrxxf5POMW1kn9bQWw9XEkouH97rKsOLPcdU0gB7F/xgY9YAhygfxWtcRW
	 oqrJgvVcCHahA==
Date: Fri, 20 Jun 2025 07:36:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kernel-team@meta.com, edumazet@google.com
Subject: Re: [net-next PATCH v3 0/8] Add support for 25G, 50G, and 100G to
 fbnic
Message-ID: <20250620073602.5ea8ea6c@kernel.org>
In-Reply-To: <5ce8c769-6c36-4d0a-831d-e8edab830beb@redhat.com>
References: <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
	<5ce8c769-6c36-4d0a-831d-e8edab830beb@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 10:44:41 +0200 Paolo Abeni wrote:
> Apparently this is causing TSO tests 

I had a closer look, I think the TSO test case is always failing,
the test that didn't fail before but fails now is the test for
pause statistics. Since the driver didn't support pause config
before the test returned XFAIL, now there is pause but no stats
so it fails. I guess we may have been better off using SKIP rather
than XFAIL in the test case, so that the CI doesn't consider lack
of results a pass.

