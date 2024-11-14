Return-Path: <netdev+bounces-144721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697809C8469
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA80283778
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B01F5842;
	Thu, 14 Nov 2024 07:58:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9671F6664
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571112; cv=none; b=Js+3YRlP1jmgxMDn9AbOWw/LMJ858jIpsjopcGA6RmkssG3Fr9JtrhLK503EyD9S5q7tEna/mVSOADun53PrR9hftQJXPhZnUxzjU20yFR5vQ5vF94JN/MoSIL7G5fqhp99rAx7OA8AToGpNAdCi/EHGtg6ceO/nnSVp59Ee1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571112; c=relaxed/simple;
	bh=U5ofaavnQg8oaEcb668iHdGS+0xq6Iv8xfkgK/r08N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEk1g2U5sc0vT5DyfLdiqqrfVNaNiVE7TR0a5npleo3MlAKEMPpPUVyOgcnFjHx2f8vNJtdZfZmew+LavNzgoDXE3N+KEdZKpxcOGgl++TcSjWhcvQKtLp/yPPGw4984WvR3fDg7pdDcHryVwE/qrxq+fz3RQlMGR7/MVCUVCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af533.dynamic.kabel-deutschland.de [95.90.245.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 36F8061E5FE05;
	Thu, 14 Nov 2024 08:57:39 +0100 (CET)
Message-ID: <5f190ef3-7801-4678-a9e4-7a44f704b6f2@molgen.mpg.de>
Date: Thu, 14 Nov 2024 08:57:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/14] igbvf: remove unused spinlock
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, Wander Lairson Costa <wander@redhat.com>,
 przemyslaw.kitszel@intel.com
References: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
 <20241113185431.1289708-14-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241113185431.1289708-14-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Wander, dear Linux folks,


Thank you for your patch.


Am 13.11.24 um 19:54 schrieb Tony Nguyen:
> From: Wander Lairson Costa <wander@redhat.com>
> 
> tx_queue_lock and stats_lock are declared and initialized, but never
> used. Remove them.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Would a Fixes: tag be handy?


Kind regards,

Paul

