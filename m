Return-Path: <netdev+bounces-101405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C627A8FE689
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9BE1F23399
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B81953BE;
	Thu,  6 Jun 2024 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4Gt/khs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC101957E2
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677210; cv=none; b=n7IyQHKgP6uiBaWW6NTArlMl2SMB/UOLWPsvqC60bkczCqNoWsx3HMoUqMU60c9BR8zqUjPvIKTq2myA4i3ePDtkix3xXvfcK2DtnSlwf5DCShIsdZXk2DVLLOYyf1JzK1jn3cTS5p73LsU73I/c2MmkVSpR8tasTwDD5hwzE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677210; c=relaxed/simple;
	bh=v6zwqbT3eNtldS0DZCFshKxvXCvz8cwJ1YakBqbHgLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+8LvtvjZuv8eiqXNSRQKu1jk9zXNqqHGoJrgJA9TKF9FHE3ySlOj/UlcARMoWNJEb9hnwdu/eYGpMF/Nv/ZSU1OASOQvfXeoNQCaDe8Z7o/5aKGtBStNGctk2VmYRWtu/JJYXisNjeuRkYbVZuguTVLnEXn5UwApHEfgnoieGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4Gt/khs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717677209; x=1749213209;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v6zwqbT3eNtldS0DZCFshKxvXCvz8cwJ1YakBqbHgLE=;
  b=K4Gt/khswhSZToAWN/eAmTlBOM1206kuzmd2vrqRxm/PXcWTnlwFkMEH
   g7o3HF0zYOPfuleAQBIS3pcCRj0WEnHCnIf6gfyGEkbNgJxjn7paDyAhU
   SNT2izHn5h3Kfq8hZaj61Jm+zgGjolcT9Irj7MP5uUm6XLKxHsUDP+NiC
   ryw1QZYNMNLpXd5UfzkbFr1I3xkxZntfdWcNSaE+XaxH3oduUkAkjmRYw
   HJM5W6StRGwoq5bbNaXqP+Cb/9LFKX86KhYGk+6pMUlrdwGCRDus0+I1Q
   qv6U8ageWTZ/v7tpraFJqsy0riwCqengQrHqTDhvBWBXz2AqY/VGLTpUf
   A==;
X-CSE-ConnectionGUID: LHFLhItLThmUeLsLjFXSPQ==
X-CSE-MsgGUID: EbK+R8dVR0q2mKqvqDAaqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14460317"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14460317"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 05:33:29 -0700
X-CSE-ConnectionGUID: /YOP+PncSPa1D9kFStS9TA==
X-CSE-MsgGUID: 8jaB9foOTwOqCMQQGPa2Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42417032"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.246.6.23]) ([10.246.6.23])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 05:33:26 -0700
Message-ID: <fbec0c39-8749-4c47-b005-b045253eebd7@linux.intel.com>
Date: Thu, 6 Jun 2024 14:33:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v4] ice: Do not get coalesce
 settings while in reset
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>, netdev@vger.kernel.org,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Simon Horman <horms@kernel.org>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20240506153307.114104-1-dawid.osuchowski@linux.intel.com>
 <0257b1fb-3e0a-d5d2-4e2c-eedc12e7dcd6@intel.com>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <0257b1fb-3e0a-d5d2-4e2c-eedc12e7dcd6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.05.2024 18:11, Tony Nguyen wrote:
> Seems like commit message, and probably title, need to get updated for 
> this change?

During testing of the change, it turns out at the current state our 
driver is in we have to use the approach with returning -EBUSY. Will 
update the description in v5 to account for this.

--Dawid

