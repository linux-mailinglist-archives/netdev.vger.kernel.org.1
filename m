Return-Path: <netdev+bounces-194100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE3BAC7536
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564457B4620
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 00:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F23A19B3EC;
	Thu, 29 May 2025 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVaE5b9y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075011552E0;
	Thu, 29 May 2025 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748480293; cv=none; b=Y/8dDMt8r6h/tVBdhWDKiouDLcY+gTuQeE+lKvlysLjntio8lpQsy5Dg1ENtybrih9D3h7uQu2N14X0hxsoCPzjB371gyFbP62DUU1AlAUNH7FmbOMjPiT1OBZtwIioBETqVPkbYJxQIDBkvSgo0p0WWkP26toslYUjuK0axGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748480293; c=relaxed/simple;
	bh=j0hXA8T74uv4Z+dSCRihfhK5a1WA8zDwnBn/QxmEGCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1HSovvscd21n7PM1wWdj1RCENiX08vCrTiLnsuMJR7/13fGAfL/yAA9d18nyhQQIKiT4AUGuPzvCJioW9saYOTD8vRzbHdCB4CKT1argnHCZH6Mx+RqFOyB8UDLM8S9WQQ5MAtM1B16WF/OkqN/P0lLYa4jkZfuJeAWXtma5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVaE5b9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328B7C4CEE3;
	Thu, 29 May 2025 00:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748480292;
	bh=j0hXA8T74uv4Z+dSCRihfhK5a1WA8zDwnBn/QxmEGCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TVaE5b9yUxYs/e5u6NA6w+wlYpV8OdeTMTkqeCBL2+sgQDeSKZAx9b+D0EHPxW8gT
	 gTtgZl+CSZSV1rpX/29OzzOBb30yIwVSr7ERgkBRqzbUjdCftCyE4K+OvO3TXSrkti
	 Pm7r4k7PeLG1bmh9EqZbXr43Mm04xFKBL6g2qC4B8GT+IJPMqqk8b7wftm0VLnaF5s
	 RY40u9T/gL4SaDWeQ2iH7nI0rNFPGQ1Y75Mw3Spzt5PlJ7PgcPvgroEk/VCphjOWbE
	 t1B4J6MQAktapWHUD3HgKVLteeVSOrB1qbJ0XHK2adjNn++a7dAUid50DbEK0qcikP
	 HSeu7CvpaNM1g==
Date: Wed, 28 May 2025 17:58:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [linux-next:master] [selftests] 59dd07db92:
 kernel-selftests.drivers/net.queues.py.fail
Message-ID: <20250528175811.5ff14ab0@kernel.org>
In-Reply-To: <0bcbab9b-79c7-4396-8eb4-4ca3ebe274bc@gmail.com>
References: <202505281004.6c3d0188-lkp@intel.com>
	<0bcbab9b-79c7-4396-8eb4-4ca3ebe274bc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 15:43:17 +0700 Bui Quang Minh wrote:
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202505281004.6c3d0188-lkp@intel.com
> >
> >
> >
> > # timeout set to 300
> > # selftests: drivers/net: queues.py
> > # TAP version 13
> > # 1..4
> > # ok 1 queues.get_queues
> > # ok 2 queues.addremove_queues
> > # ok 3 queues.check_down
> > # # Exception| Traceback (most recent call last):
> > # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
> > # # Exception|     case(*args)
> > # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/drivers/net/./queues.py", line 33, in check_xsk
> > # # Exception|     raise KsftFailEx('unable to create AF_XDP socket')
> > # # Exception| net.lib.py.ksft.KsftFailEx: unable to create AF_XDP socket
> > # not ok 4 queues.check_xsk
> > # # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> > not ok 7 selftests: drivers/net: queues.py # exit=1
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250528/202505281004.6c3d0188-lkp@intel.com  
> 
> Looking at the log file, it seems like the xdp_helper in net/lib is not 
> compiled so calling this helper from the test fails. There is similar 
> failures where xdp_dummy.bpf.o in net/lib is not compiled either.
> 
> Error opening object 
> /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/xdp_dummy.bpf.o: 
> No such file or directory
> 
> I'm still not sure what the root cause is. On my machine, these files 
> are compiled correctly.

Same here. The get built and installed correctly for me.
Oliver Sang, how does LKP build the selftests? I've looked at the
artifacts and your repo for 10min, I can't find it.
The net/lib has a slightly special way of getting included, maybe
something goes wrong with that.

