Return-Path: <netdev+bounces-103532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E98390878D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF11B20C5D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08FF1922D5;
	Fri, 14 Jun 2024 09:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95E18FC72;
	Fri, 14 Jun 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357669; cv=none; b=OebonfAYu5O1jKBhEtlMBn0Fv7ncBE+ZQs6tYYpgOW0rparH6facNOTyS6MLBoeK7KOytYsUvypU2CPIsfMzRSoXpL06FWUFBqfZely03aGFwRNMAFUuiHfgwFjESj0pdds1GQ88Icx6A5EsIfzQt/0ffMcENWiK/RoCWhKBw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357669; c=relaxed/simple;
	bh=laUOS8JdCeTOXbiR8ebqjj/Ea9YWWftJa3slLeFtJT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5pyi+TFa8DupL6U5BAmteyFqwRDCPiustw7D+C4RCewdLnvbjyD7IXKWgE0Wdf2mDNw2H+mApIKligQFmJ1pHtPhE4p5Q5jusdIXO79OmgN9/9dFd5X/qhBPGyq24lAoW/X0qzUKnrvsJbC41CPboRy+2gpLmOc91lnPJVzRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45E9YELI048989;
	Fri, 14 Jun 2024 18:34:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Fri, 14 Jun 2024 18:34:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45E9YDei048977
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 14 Jun 2024 18:34:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ea30d016-a163-4a0e-81c7-46d6645440aa@I-love.SAKURA.ne.jp>
Date: Fri, 14 Jun 2024 18:34:13 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [rtnetlink] 8c6540cb2d:
 hwsim.mesh_sae_failure.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        netdev@vger.kernel.org
References: <202406141644.c05809af-oliver.sang@intel.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202406141644.c05809af-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/14 17:48, kernel test robot wrote:
> kernel test robot noticed "hwsim.mesh_sae_failure.fail" on:
> 
> commit: 8c6540cb2d020c59b6f7013a2e8a13832906eee0 ("rtnetlink: print rtnl_mutex holder/waiter for debug purpose")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d0]
> 
> in testcase: hwsim
> version: hwsim-x86_64-07c9f183e-1_20240402
> with following parameters:
> 
> 	test: mesh_sae_failure
> 

That patch adds debug printk(). But dmesg.xz does not include printk() messages from
that patch nor any oops-like messages. What went wrong?


