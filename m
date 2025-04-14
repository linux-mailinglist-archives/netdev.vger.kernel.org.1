Return-Path: <netdev+bounces-182169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55583A8811A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D496188394A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240A81547F2;
	Mon, 14 Apr 2025 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbcNtLm6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FEE25C716
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635843; cv=none; b=L7spZc/6RdsleUqUqxmcmljNDEclSzgL1peC5LNxNXGw1m6EMeA9jDXWi6ymg76MfSwDVsAdYcrDhDELBqgixujCG83fpdIXZbLag6E8LZ1/4HKO5ktgBo2RPmV63nRYrek3eFZbtBlrUfXnDivpZMlbIO0pvBfnA+73Z1H6d80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635843; c=relaxed/simple;
	bh=Zm1CgYtCNLvYuMxyg3rrAoJm/vpL/E3L6SClMlF+xmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMPywQE0qUwQ2pQderBngOGOtabnAsmTe+xba8nXKGo4F5O3HXSYp/qhUKITasXLQR59x8FOB6zAfNmfXyq/mDPH6dYM+oNP5eLoWk4zGJkZuZFQxK+YX9f8vqrPNt1Oehapj6tOQtUvF3R5AwmV4GTVyaWiyaqpTTs9bTWRlMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbcNtLm6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744635842; x=1776171842;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zm1CgYtCNLvYuMxyg3rrAoJm/vpL/E3L6SClMlF+xmY=;
  b=QbcNtLm6VgR4tGIF2HbAlzNI1SUqby2HhDvv3kRX9AIFjIdPUkeM7miU
   U84ldEqHD/1JTFbXt4iXAQkqscGBOfKwf2P4vq8PWiKN4QY8QRvJ/yFp3
   DaKzlK21IIv+EfQcqSYvJmiMS3MzY8OWK3CwHeQws6JsO1NvfI0waaTCu
   vFQJG5uCnouQAnjAEY+sFZePR84r3LPAQhtmtonyoOaZR7Wio2EkTJMKd
   jfoxqBZSGIZ+TS25809Y4YSksqC8c3stCuiOqNtUTmr8jcs05l0rYxV9N
   V1kGBacy8wGpTvtA61bb1WGf26l8ZMZmUkiP+Xa6GF1/L4WDEySQQltbK
   Q==;
X-CSE-ConnectionGUID: 2mQd/LTRT0ySgPiqbAKC0g==
X-CSE-MsgGUID: 3fFyn/s+TTqiycOgftYmoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="49760436"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="49760436"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:04:01 -0700
X-CSE-ConnectionGUID: pJHfrg0kQOytdkNNGeB8CQ==
X-CSE-MsgGUID: 5FjZVOS3SE+mB+sCKf8g7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130669308"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.98.242]) ([10.245.98.242])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:03:59 -0700
Message-ID: <feb50784-4efc-4b2f-9c26-9c1b059fd9a8@linux.intel.com>
Date: Mon, 14 Apr 2025 15:03:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/2] ice: add link_down_events statistic
To: Ido Schimmel <idosch@idosch.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Michal Kubiak <michal.kubiak@intel.com>
References: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250409113622.161379-4-martyna.szapar-mudlaw@linux.intel.com>
 <Z_ZiwNUJy7xGeT8m@shredder>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <Z_ZiwNUJy7xGeT8m@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/2025 2:06 PM, Ido Schimmel wrote:
> On Wed, Apr 09, 2025 at 01:36:23PM +0200, Martyna Szapar-Mudlaw wrote:
>> Introduce a new ethtool statistic to ice driver, `link_down_events`,
>> to track the number of times the link transitions from up to down.
>> This counter can help diagnose issues related to link stability,
>> such as port flapping or unexpected link drops.
>>
>> The counter increments when a link-down event occurs and is exposed
>> via ethtool stats as `link_down_events.nic`.
> 
> Are you aware of commit 9a0f830f8026 ("ethtool: linkstate: add a
> statistic for PHY down events")?
> 
> Better to report this via the generic counter than a driver-specific
> one.
> 

Right, thank you for pointing this, I just submitted v2 where ethtool 
get_link_ext_stats() interface is used.

