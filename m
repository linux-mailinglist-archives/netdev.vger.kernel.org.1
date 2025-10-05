Return-Path: <netdev+bounces-227891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C2BB9782
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 15:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AFF3B16F6
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717E228750A;
	Sun,  5 Oct 2025 13:31:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C359F9D6;
	Sun,  5 Oct 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759671075; cv=none; b=m6punh/IYcOglrLss1gangpqWIttSSaAE67pTSfJs213kiNlbQIODvRoun0f3+dYEsvF3fpJfQZhPiH1ceWqjdWCEZh7KTtAGCFdvFmG4aywWXx+GE93lVr8lJqF8gf55y7T8P6yP2iHgDkaHaQ0RWFLLkgrW1KvT+xE1AC2yJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759671075; c=relaxed/simple;
	bh=263yADL3KIq/zo3QgwyPk5gYw7Uj826c/NA5P+yK5VQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+3zdoeiCUdsaas8IP6gdWJRpeS+IyDRAgx25xtE7UUijy5s21JSlLqnrbh1MdAe3T6G5CrBGEM54tB65+m0zAnLu4oScry12ns3PC5g+GMxAbGS2YRuA47VORW+ULDRstWPyjLkhuD4tU2rho43qfSf6WXyP8vg/idjQtJb//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <edumazet@google.com>
CC: <Jason@zx2c4.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <wangfushuai@baidu.com>, <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
Date: Sun, 5 Oct 2025 21:30:31 +0800
Message-ID: <20251005133031.31891-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <CANn89iJs+Y7Ge2sbAOQSsuE6O1GbxuHbNrFxBO0fq1C3HOfxPA@mail.gmail.com>
References: <CANn89iJs+Y7Ge2sbAOQSsuE6O1GbxuHbNrFxBO0fq1C3HOfxPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc6.internal.baidu.com (172.31.50.50) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

>> Replace call_rcu() + kmem_cache_free() with kfree_rcu() to simplify
>> the code and reduce function size.
>>
>> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> 
> Hmm... have you compiled this patch ?
> 
> I think  all compilers would complain loudly.

you are right.
I uploaded the wrong version of the patch. I will send the correct v2 shortly.

Thank you for pointing it out!

Regards,
Wang.

