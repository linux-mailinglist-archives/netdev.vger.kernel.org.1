Return-Path: <netdev+bounces-96605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D188B8C69C5
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B541F216D5
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7B15575A;
	Wed, 15 May 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9J3HCG9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B10149DEE
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787094; cv=none; b=RBxnl1OlNCeoXX5Gv1TNnsnYh1yqkA1MhsIcqWl0x++G2ZMuM2tc+RaWO0XFyc2LXmhkf3RgzT0PyX+q1gxC6+kp0ghHKfQjL+h8iONY8nBq8pgt7RWsrXQHEFyLGnxbeVbCyngnTS6dCUOmYEo3b8IFmKpFKsCjmHebQ+g5SA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787094; c=relaxed/simple;
	bh=77ytUDYWnryGCErzSsaUzWktmtB9aQWry3aROJ9oCZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcNXD+ul4CH+2fLG1TPlXC+io5hkkQTs1xoL2r2QO2hOc3nElKB81CFHk0BDWrqFEw6KzwuPJ5VfVDCEBFZm02r1xmq7AYsqmQd3F9z3WlyFAzeXE8ACsOVT8nyEYbdke7H5q99Euj996tuwSV2dPF4PzC6qpw0fpL4yOS8B7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9J3HCG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21966C2BD11;
	Wed, 15 May 2024 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715787094;
	bh=77ytUDYWnryGCErzSsaUzWktmtB9aQWry3aROJ9oCZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9J3HCG9FOreOPSQz1yLQgpXgx11CpWIQR117xtSQEsjFh3WjDeH29vacxaiPUgsN
	 RNTIrbEcR+mj32djjnVfhBBvNoDBlT5aZcBLbIlI0xCDzbEAzVLKIGXGSS50nbvJwi
	 eYaior8xgE2uImm010WVfIqssg4vDg9D26tDu2tczYQ5NLoq4E6JTYMVl0NF/saS5e
	 Xl6n40Y8lbQOPOVrOJZiZFEaSr04aPGxPOUMcDAEWpyOCErZGX/4LMXDqYTc39M16y
	 CV+vy0ceajntuXcxHSImZU0BK6QoOkt9xB5/5SiM883mgbUUtcdg3KjiUOzBYZwova
	 3ibr4ECH7GYmw==
Date: Wed, 15 May 2024 16:31:31 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 0/6] add sriov support for wangxun NICs
Message-ID: <20240515153131.GP154012@kernel.org>
References: <A621A96B7D9B15C2+20240515100830.32920-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A621A96B7D9B15C2+20240515100830.32920-1-mengyuanlou@net-swift.com>

On Wed, May 15, 2024 at 05:50:03PM +0800, Mengyuan Lou wrote:
> Add sriov_configure for ngbe and txgbe drivers.
> Reallocate queue and irq resources when sriov is enabled.
> Add wx_msg_task in interrupts handler, which is used to process the
> configuration sent by vfs.
> Add ping_vf for wx_pf to tell vfs about pf link change.

Hi Mengyuan Lou,

Thanks for your updated patch-set.

Unfortunately net-next is currently closed for the v6.10 merge window.
Please consider reposting as a PATCH once net-next re-opens, after 27th May.

In the meantime, feel free to post new versions as you get feedback,
but please switch to posting as RFC during that time.

Link: https://docs.kernel.org/process/maintainer-netdev.html

Also, please be sure to seed the CC list of your patch submissions
using the output of get-maintainers.pl PATCH. b4 can also be of
assistance here.

