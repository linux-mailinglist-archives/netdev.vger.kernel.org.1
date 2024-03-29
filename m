Return-Path: <netdev+bounces-83264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D78D8917C5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814861F22BE0
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107CA51C5E;
	Fri, 29 Mar 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTRznXmw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32652F61
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711930; cv=none; b=XUWhkrP5LeEVJ2sQBefd/fuxgRqCqZkn2IyzzaNlglQ6FhWFb47SPnKF8JWRyzkIKY56pTCJ6QeNuSBako32o7qmq5D+hQpQHL+TYFjEtYa6bvEYRxuXhOudjlueymQeRlRCwC63irhtJR8Ll7rMN7hEOt1wqaZt62eEvwe1dmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711930; c=relaxed/simple;
	bh=k+azV62oV6xWrBVujeKKk/0NDlkN9zdK/FCzJd3A/lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfEwczbinqdGS/13NVKSvt/bcDICTdchsHJGmaSgKzORryWw9IiKTiR/TAyKgTqrrxXDVTyzt7x1PbEVYJN4JQZFyk2pQjkwm8/kjNVs1nPkaZYSqNPPRjucsQyzj67E2E+tv63TziKJ03T+AOmHOF6hq+8n9EWsIA0UG4zmdUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTRznXmw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711711928; x=1743247928;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k+azV62oV6xWrBVujeKKk/0NDlkN9zdK/FCzJd3A/lc=;
  b=QTRznXmwplj5VOUNeHBJJlb/zkg6UKaOa/NgTF+7enYEuPcLHSqK2YDw
   F/EU0CqXqErrPZSWAcLmSRWfvDyLPT2pd0UwjfhtyKfi8vDXX+GX6gmOv
   F64gJE6PezPGbB+PmfhSoOrxcNOHauKwir9ZfGOCItwZJrM6c09dAlx//
   +0qhkfkgz9ZIQSwdMuAUKuueWxdD6aYWyc8pAQqrlwsABFXtO2twZyJ8q
   v1vH0mCykCxggiT9kK0cgkCaF4fTdK7pkWQiEqHWszJELGnwRITXRIog4
   rWMMqNczN5iU5sNRcTi+t+cTGLoq7O6B8eRIkeb1hDXGGB402Oq/LYSku
   w==;
X-CSE-ConnectionGUID: ZZdddaLQRLGzrzLUnh9T/A==
X-CSE-MsgGUID: o+nk7LShQYCE9Eja86grOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="7114612"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="7114612"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 04:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="17583057"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.35.198]) ([10.246.35.198])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 04:32:05 -0700
Message-ID: <fbf9dae9-c023-4b15-b3d8-6b19240f59b0@linux.intel.com>
Date: Fri, 29 Mar 2024 12:31:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ice: Reset VF on Tx MDD
 event
To: Simon Horman <horms@kernel.org>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 pawel.chmielewski@intel.com, anthony.l.nguyen@intel.com,
 Liang-Min Wang <liang-min.wang@intel.com>, intel-wired-lan@lists.osuosl.org
References: <20240326164455.735739-1-marcin.szycik@linux.intel.com>
 <20240328173450.GH651713@kernel.org>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20240328173450.GH651713@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.03.2024 18:34, Simon Horman wrote:
> On Tue, Mar 26, 2024 at 05:44:55PM +0100, Marcin Szycik wrote:
>> In cases when VF sends malformed packets that are classified as malicious,
>> sometimes it causes Tx queue to freeze. This frozen queue can be stuck
>> for several minutes being unusable. This behavior can be reproduced with
>> a faulty userspace app running on VF.
>>
>> When Malicious Driver Detection event occurs and the mdd-auto-reset-vf
>> private flag is set, perform a graceful VF reset to quickly bring VF back
>> to operational state. Add a log message to notify about the cause of
>> the reset. Add a helper for this to be reused for both TX and RX events.
>>
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Co-developed-by: Liang-Min Wang <liang-min.wang@intel.com>
>> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> 
> Hi Marcin,
> 
> If I read this correctly then a reset may be performed for several
> different conditions - values of different registers - for a VF
> as checked in a for loop.
> 
> I am wondering if multiple resets could occur for the same VF within
> an iteration of the for loop - because more than one of the conditions is
> met. And, if so, is this ok?

Hi Simon,

Good point. Nothing too bad should happen, as ice_reset_vf() acquires mutex lock
(in fact two locks), so several resets would just happen in sequence. However,
it doesn't make much sense to reset VF multiple times, so maybe instead of issuing
reset on each condition, I'll set some flag, and after checking all registers I'll
trigger reset if that flag is set. What do you think?

Thanks,
Marcin

