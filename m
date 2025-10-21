Return-Path: <netdev+bounces-231053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91491BF43CD
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384BB46075A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA4190664;
	Tue, 21 Oct 2025 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ROotCBXF"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0615E5DC;
	Tue, 21 Oct 2025 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009544; cv=none; b=a4YZ9r8lVMtreGHq8rpmU2WrMZqiuXbPM30AZoaPn1hhhSNpe0CNNeDQt0V1HmX2VdcRgtUI5kTTTyEQ0zKnf8STAj4P0QE/a7gJW3uLwxmCTrmd3pG+S281OjC2bI29227qHA6oWTUtncZmXL5kDQ7dVYNRVezVXQcniHN9Jc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009544; c=relaxed/simple;
	bh=nopaWkQFGS2iMxso0Hn2i1ziWVRkua1QbyjI2qTYzpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QB4ky9FQYf7zzRV3tMB1aevbsUgbF0WVTO7xH1ymMz1qOE3b11mP6zCPxjxyj3ftf9HG2tTnkqbegvzhhUVujzpM3W13nq7Q2VabtFRznLNNYrLe5rot/UDL/M8YESZIgN49YBNjYwb5cMA+fwUFhjwjxEYnCCw86voBf+KEbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ROotCBXF; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nopaWkQFGS2iMxso0Hn2i1ziWVRkua1QbyjI2qTYzpY=;
	b=ROotCBXFX6RPOHU2uwrGgEBQcd0I8tPduU2rAlytXQv6Ta7KVvwk1jCqfOnglnQfgOmmrWOME
	1ztwKv9ANvXr3PxJufq5II7blgt3TFOWpaSeR6BfFYhKwahXBHXUU7yAvewxdhdI+wHsZM8BdDs
	IkOtsIuXPIyw0HohmAbZXO8=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4crDtl2kb6zcZyT;
	Tue, 21 Oct 2025 09:17:51 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 11573140156;
	Tue, 21 Oct 2025 09:19:00 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 09:18:58 +0800
Message-ID: <031f1945-295d-4c33-a12e-798220ce68cc@huawei.com>
Date: Tue, 21 Oct 2025 09:18:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
References: <20251020112553.2345296-1-wangliang74@huawei.com>
 <aPYo8wGLna44_57b@krikkit>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <aPYo8wGLna44_57b@krikkit>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/10/20 20:20, Sabrina Dubroca 写道:
> 2025-10-20, 19:25:53 +0800, Wang Liang wrote:
>> #syz test
> I've already sent
> https://lore.kernel.org/all/15c383b3491b6ecedc98380e9db5b23f826a4857.1760610268.git.sd@queasysnail.net/
> which should address this issue (and the other report in
> xfrm6_tunnel_net_exit).


Sorry! Yesterday I worked in the issue 'WARNING in xfrm6_tunnel_net_exit'
and I didn't find any patchs that Reported-by/Tested-by its syzbot link in
mail list, or syz test patchs, so I send the test patch.

Please ignore my test patchs. Thanks.


