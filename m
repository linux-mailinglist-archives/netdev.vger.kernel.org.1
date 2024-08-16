Return-Path: <netdev+bounces-119046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0AB953EB5
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB36B210B8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A153179A3;
	Fri, 16 Aug 2024 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuY3jY64"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6515E88;
	Fri, 16 Aug 2024 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723770463; cv=none; b=JKI/DZVhUSAlGm4Z0eQQxmQH8NJhu7b7b3VSpRNTlt2nMUNpqzTjtJ3+F8Gvr9j+6X+oARdltLVn21+FFCczRXySIrFJGKN5jsABQNhOU9PcAbJ3K4bYUdS3bO26SNzJkQj8f3YIJ0NlrwPkKaGRGwweVW6gX0mFN3Euc1Om+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723770463; c=relaxed/simple;
	bh=Gn/O3CNgEf1uDlPVDLWuU09BObBv32ZSZwlxzBncF3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SlXnRikRLeXzSWK0xPvQIwXej2HrOC+Qpr/4sIIr9BhLfATY6SjbLi5EfR6hyQhyhrsQrca2ZUqfrDDg+gpcwrFuIcXJG2mh++41+MFEEIbVaw4PmepcITX6k6R6ACSM2kG9YwVUs9nA75gz1rXt63dlPeJhi9yWjxwVYb3vDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuY3jY64; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723770462; x=1755306462;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Gn/O3CNgEf1uDlPVDLWuU09BObBv32ZSZwlxzBncF3M=;
  b=kuY3jY648spSu4qnBzDxXBiKSzsKUKsrLZNQsTP3uh0oswjq7UaKa/e8
   1oHhCi6S3IhXW3HoYz6lsIP128YPbR9yN9lMsKbbNK1Z8yfwc9PNtPYDv
   i+cXPLqRTm+6PAYoD3wgjE2juOdxG5NWIrQIi6/Eh3PA6UoYoKdCa/wCF
   OzZcgigNsOQS1BfrowejPRvQPbs2mytZmREpjrkUxmr3jzhUvIEuCGVCM
   XfGlp82fElpEbYDjKPZenNdoOgowZn5cKu0lUdEuLzvA8rc57RCLhWVdU
   mV3V/WPfpt4F6baTTu6hzNozGDoR/JCtLw1QQFzx7dxMmAKIuyexyvIRm
   g==;
X-CSE-ConnectionGUID: TTHn3dq1QWajKCyLoouBLQ==
X-CSE-MsgGUID: hOLegOBSShSFrU56wV/bVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39511092"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39511092"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 18:07:41 -0700
X-CSE-ConnectionGUID: XWUxB4GKTp2vqsOKXfD2pw==
X-CSE-MsgGUID: XESAWVLEQU62V5HQcLJTvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59162704"
Received: from unknown (HELO vcostago-mobl3) ([10.241.225.92])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 18:07:40 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Daiwei Li <daiweili@google.com>, intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kurt@linutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, przemyslaw.kitszel@intel.com,
 richardcochran@gmail.com, sasha.neftin@intel.com, Daiwei Li
 <daiweili@google.com>
Subject: Re: [PATCH iwl-net v3] igb: Fix not clearing TimeSync interrupts
 for 82580
In-Reply-To: <20240814045553.947331-1-daiweili@google.com>
References: <20240814045553.947331-1-daiweili@google.com>
Date: Thu, 15 Aug 2024 18:07:40 -0700
Message-ID: <8734n5uvfn.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daiwei Li <daiweili@google.com> writes:

> 82580 NICs have a hardware bug that makes it
> necessary to write into the TSICR (TimeSync Interrupt Cause) register
> to clear it:
> https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/
>
> Add a conditional so only for 82580 we write into the TSICR register,
> so we don't risk losing events for other models.
>
> Without this change, when running ptp4l with an Intel 82580 card,
> I get the following output:
>
>> timed out while polling for tx timestamp increasing tx_timestamp_timeout or
>> increasing kworker priority may correct this issue, but a driver bug likely
>> causes it
>
> This goes away with this change.
>
> This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").
>
> Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
> Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
> Tested-by: Daiwei Li <daiweili@google.com>
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Daiwei Li <daiweili@google.com>

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

