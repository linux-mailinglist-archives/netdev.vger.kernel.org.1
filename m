Return-Path: <netdev+bounces-204797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B542AFC14D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 05:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C654B4A2B52
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF743235C01;
	Tue,  8 Jul 2025 03:18:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53FA1799F
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944718; cv=none; b=Vn+KiuACxNFRrlg3ORLHRkGKVuHqOi16p/SMxXxs9PzEqWniDIfF9NVkoza26sPlw58KwK51IbTnKkW6KeZ4sQhxSWk/O1TnWcRsqHvjWglcP9p/jqqHNjAuKKj+MrjROgeLCIbmJcThSMhncQmdAi63hBiiDUI0l/i9uuksJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944718; c=relaxed/simple;
	bh=R+ZagSF0Ru2D3X6Unig2RnbtvbHgqFx+w/C9pPD6aTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xh7sDeDlL3GEoQhiwb/9X52Abe2HgC0JQyHgJy6M6aOoDbXM1L2bk5KGukmXeXs70Fqajyjk8vZbzdUjfpJQYGSQNuVvRiZMcepFHa0QGvyXAANJuvjdQel2jPstyVHwwKMSWi1Xzo8kWOeEzJCsJqceSM29nHp7PLfSKPo2/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5683IIH1004546;
	Tue, 8 Jul 2025 05:18:18 +0200
Date: Tue, 8 Jul 2025 05:18:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: Xiang Mei <xmei5@asu.edu>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
        security@kernel.org
Subject: Re: [PATCH v1] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <20250708031818.GA4539@1wt.eu>
References: <aGdevOopELhzlJvf@pop-os.localdomain>
 <20250705223958.4079242-1-xmei5@asu.edu>
 <aGwMBj5BBRuITOlA@pop-os.localdomain>
 <aGxgzS2dZo8fKUw5@xps>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGxgzS2dZo8fKUw5@xps>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jul 07, 2025 at 05:05:33PM -0700, Xiang Mei wrote:
> I have two more questions:
> 
> 1) Is the patch provider the person who usually adds the "Reported-by" tag?

Yes, usually when one person authors a patch to fix a problem reported
by someone else, a Reported-by tag is added to credit that reporter.
When it's the same person as the one who authors the patch, it's not
needed.

> 2) Am I allowed to request a CVE number for this race condition bug?

No, this will happen automatically once the fix is considered for
backporting by the stable team, and the cve team decides which fixes
need a CVE. The process is described here: Documentation/process/cve.rst.

Regards,
Willy

