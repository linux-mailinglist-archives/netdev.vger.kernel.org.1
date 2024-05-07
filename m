Return-Path: <netdev+bounces-94220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5808BEA17
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD04D1F22FA5
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAAE15E5D4;
	Tue,  7 May 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="P4D67cMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141F15E804;
	Tue,  7 May 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101764; cv=none; b=m8FwSkpFxt1aGAtgMc5ggkFCBya5RFAuCGE5eOvY92jabhmZsA7TpfhSW0rrw9547ej4WalPUvvL16oub/D7rnRuD9rCSkf/F/IwG2OhHe1o9YXudZXR+oLdatbMfVKDBVaSNaH/xs8Ioq9hVQjYZLN32wWepXVwPxjxTq2ez2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101764; c=relaxed/simple;
	bh=BXFYAuK2f3o9ZbfPuARv2bct8DASWQ4QtSWWePDLILA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=T+hHawMJuim3Yurxrsw9S5uMhruTJc3W5kZyZL5V2b8IBiU55tdzhGitqgMZScMqYqdBSedr0Wss9pc6o2qlMg72EkJTsxL74MvYdh1IOKGGwyiMLqdsBPgxslhDxM/dXe0spKbXM5VIElktKJSGtIZYg4D/KvBYY3poneYEEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=P4D67cMQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715101724; x=1715706524; i=markus.elfring@web.de;
	bh=BXFYAuK2f3o9ZbfPuARv2bct8DASWQ4QtSWWePDLILA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P4D67cMQVeeab/N0U1pzK1DF6NNjV/4s6DcTSzdvZBd9g3dTEtwC1P3rUgBrOQJu
	 xg3hQbO9PW2VoBOhqTXTJnlrNNfIk2CHr0pkL6SG4pC68RjRHO9BF6QWNDxBERlL6
	 sEMCAD1wAMieXt4A50SESvQtc0ea86Punik3hzxVgly7FECT2LYp/BIxnBS1Edhhy
	 ej6jduge9FF5tQ3kpVTkR8KwIyfT1BJMOBHiRBUF2dW0RxBRIUeBuf5dH2ok82mac
	 Bc1MvCZCosQ/0zfKYK3rajl/9h3h18lw63uWmChNqPArEatWcqjcA0H2RssjkNjPL
	 8MPfZi3tpW0mF6Edgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2PdU-1s2kwU2XyI-002FNj; Tue, 07
 May 2024 19:08:44 +0200
Message-ID: <bb650760-576b-4ad0-b026-13f29ae45db0@web.de>
Date: Tue, 7 May 2024 19:08:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jijie Shao <shaojijie@huawei.com>, Peiyang Wang
 <wangpeiyang1@huawei.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>,
 Salil Mehta <salil.mehta@huawei.com>, Simon Horman <horms@kernel.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Hao Chen <chenhao418@huawei.com>,
 Jie Wang <wangjie125@huawei.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Yonglong Liu <liuyonglong@huawei.com>
References: <20240507134224.2646246-3-shaojijie@huawei.com>
Subject: Re: [PATCH V3 net 2/7] net: hns3: direct return when receive a
 unknown mailbox message
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240507134224.2646246-3-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:t0WGCuJXSyPFZ+yLpUa/X3W/lBAx/QRKxussUmTsJVFq7hTkIib
 vGjFeS0FOJZ9Kdo1bQdiYW65SoBaF5/RqockWidxxPQoSUyFWjYs71U2FpRwcwJhNi1K3PZ
 Urnl22cPirVCFha0vaHzMxhXJw/GYwdJfAbsezZuvj0SKbc79FJjlwW/Lad9B8kCi4D1mqc
 HWkA+pwCJPiSLzQzCW4HA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OkuV9a7nTNE=;ORNzrwDdGTlNAh0neGWJUejWE1o
 X7HiuVJCJTdpp4Mj54fS0UpLQQY7BJxDfleyI6pROQ0SaDCLFQ5YkvHuaqn1vh0D97G6xQU6d
 QPXqfA8l1HQSJ5MP2Yj5Hp+B6dvbHFxpWDlAXp+fIRAOElOdJ4XOEqOVtDy9qHNXg5UFu26ss
 AGXwWYuTrV1dm+RkEhALXxZeJV7zsUrtzE2KBtiSr64F5hMkdfxzZ3RIJXSSnYnvJukhWk6r4
 aihygLofWAbULGwrP3xcdDeWcuS+OHQ+tB5sJoQHu/ogXDR92YSgOVUd11skj/gY9gLij+EhJ
 3vTxaLserPX7A2uDrWlFSUdUTsZ07o1L4WMLDWRVjdsLrCeAW2F4aP/0Eo11B6dQpnIhLZM3H
 o1QGtXT43LrR0h9+EIrBXXXLDzI6Nwx/lwuoQVWiYrEGaSTpDbWBj2riDdEajTcLweSkmxS6r
 0Ua9P8fhdBurfPj77rRloX/2MKsfW6RDbHrDZvBIBq8dtahkA3p2j7GFKiDlL7waJYQgsq8ue
 HQwZyTTdcn519VU35gFB4KVu4idkqkkAdKlrDx/SEahGRVTQJH95Usn6eqIoE5koBIZw7Qyd+
 9fNDxqJEl/EtEFSLoCL4x4cEksOqzMAc4ZnPfnO184Rx9eYSYCym6xAU9ambIgaIAdziLpqOm
 p9Tn0aBzC6VqYcEQXUEZA+MS4j2S27DnimFj7mk6mEweGW0tUT8Wgi5duZ5qWHEgW3MZbjZd9
 t19voLg8rd8Ai3v3lOqWBsSCtrxwLQMsL5LWJ9IzKYqVnA1dK9PcA0s5hA8o6Uf5aCAuLS2jh
 TxEsWnjHc0vLoqMWnIfSrD3PLqdJJfg5RK3aTb7T30phg=

> Currently, the driver didn't return when receive a unknown
> mailbox message, and continue checking whether need to
> generate a response. It's unnecessary and may be incorrect.

Please improve this change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc7#n94

Regards,
Markus

