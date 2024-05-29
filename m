Return-Path: <netdev+bounces-99188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 119168D3F7A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841C6B23CAE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD521C68AE;
	Wed, 29 May 2024 20:19:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB41C6896;
	Wed, 29 May 2024 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717013995; cv=none; b=P0/OoD2+KD2i+oWe8fhb8mEnRH/b2Pg+rCrqklsbeiwGX3bANDNjQi8gXzQebtCH0L9V/qY8SbktPL6HFGhIPpRRVrvFgny/vZXkXjGSjAb+NmgZJoHzNctTTl+QgEJJ2lPUG97ktQyGrmlhRbnyhBW/u8XuPzKdSqTW3+KRMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717013995; c=relaxed/simple;
	bh=ZVHdP4P1gAprOsHPZPWQubP/bxr6Z6y1soXdoOoGlkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWqEU5azK7+JT+/7xUMRKpR5fobVKe3KGaAeX3IsS24PKKCdAb7Vmizg3L5bk1siMo3GBH0SYnKNo9eWH/fYuHovZ4AeDUXheFdZZOurL7MUbDjWt3x9haFwvMvdHKc0hTdBmKncy5a5Fhf40stazMrv3g58Vg/P5Uw9YWc+F7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.45.140] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E9D9E61E5FE3E;
	Wed, 29 May 2024 22:19:00 +0200 (CEST)
Message-ID: <971a2c3b-1cd9-48c5-aa50-e3c441277f0a@molgen.mpg.de>
Date: Wed, 29 May 2024 22:18:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] ice: irdma hardware init failed after
 suspend/resume
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
 rickywu0421@gmail.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
References: <20240528100315.24290-1-en-wei.wu@canonical.com>
 <88c6a5ee-1872-4c15-bef2-dcf3bc0b39fb@molgen.mpg.de>
 <CAMqyJG0uUgjN90BqjXSfgq7HD3ACdLwOM8P2B+wjiP1Zn1gjAQ@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAMqyJG0uUgjN90BqjXSfgq7HD3ACdLwOM8P2B+wjiP1Zn1gjAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear En-Wei,


Thank you for responding so quickly.

Am 29.05.24 um 05:17 schrieb En-Wei WU:

[…]

>> What effect does this have on resume time?
> 
> When we call ice_init_rdma() at resume time, it will allocate entries
> at pf->irq_tracker.entries and update pf->msix_entries for later use
> (request_irq) by irdma.

Sorry for being unclear. I meant, does resuming the system take longer 
now? (initcall_debug might give a clue.)


Kind regards,

Paul

