Return-Path: <netdev+bounces-192533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C4AC0486
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D3F16AC36
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B64822172C;
	Thu, 22 May 2025 06:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090B22155F;
	Thu, 22 May 2025 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894911; cv=none; b=YcniJLDO6cAB0D2GxphjW4kdd98YTO+qwW5H3k9e5Me/YxSBJg4f4pgcK1hf3DfVxVNWRMPP1gAadNQ55UD4hwnvbn7p4/7hNrNAanyqqUzhxLq4UWw96dRbfLRQGqv5x0G/jqXcGwVr8kM0iyG+dXHUTGJQhNDJzg8RnHZ3Zmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894911; c=relaxed/simple;
	bh=ou8GcEFwd76eD0bfSCB/awf41A7XO/qhI2qVUk3p9/A=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=e3qauCl4i/lMNPGBT1L0uJgNq5HJDiPW3DV+vLKOGhEOP+++28uWyOjqMThnZxQCXkA5Oc7KQTM9aBfSnLxMnXjKar+kYiUT234p0/Vo62YIwEP4wK0vXIYZ9EgdYeNLIKabOhLI5m6CI6kVybmodOThExwrKY0Yrr2sIv5xDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4b2yqR57vWz5B1DQ;
	Thu, 22 May 2025 14:21:39 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 54M6LQmg031468;
	Thu, 22 May 2025 14:21:26 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 22 May 2025 14:21:28 +0800 (CST)
Date: Thu, 22 May 2025 14:21:28 +0800 (CST)
X-Zmail-TransId: 2afb682ec268132-e0331
X-Mailer: Zmail v1.0
Message-ID: <20250522142128347DhUL47l1VoaTNFU4XV7h4@zte.com.cn>
In-Reply-To: <20250521101408902uq7XQTEF6fr3v5HKWT2GO@zte.com.cn>
References: 20250521101408902uq7XQTEF6fr3v5HKWT2GO@zte.com.cn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <jiang.kun2@zte.com.cn>
Cc: <horms@kernel.org>, <kuniyu@amazon.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <fan.yu9@zte.com.cn>, <gnaaman@drivenets.com>,
        <he.peilin@zte.com.cn>, <kuba@kernel.org>, <leitao@debian.org>,
        <linux-kernel@vger.kernel.org>, <lizetao1@huawei.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <qiu.yutan@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eCBuZXh0IHYyXSBuZXQ6IG5laWdoOiB1c2Uga2ZyZWVfc2tiX3JlYXNvbigpIGluIG5laWdoX3Jlc29sdmVfb3V0cHV0KCkgYW5kIG5laWdoX2Nvbm5lY3RlZF9vdXRwdXQoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 54M6LQmg031468
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 682EC273.002/4b2yqR57vWz5B1DQ

> From: Qiu Yutan <qiu.yutan@zte.com.cn>
> 
> Replace kfree_skb() used in neigh_resolve_output() and
> neigh_connected_output() with kfree_skb_reason().
> 
> Following new skb drop reason is added:
> /* failed to fill the device hard header */
> SKB_DROP_REASON_NEIGH_HH_FILLFAIL
> 
> Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>

Looks good to me.
Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>

