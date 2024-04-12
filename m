Return-Path: <netdev+bounces-87346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFC88A2D22
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9A61C21153
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F58C5336D;
	Fri, 12 Apr 2024 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="I+mcjpmX"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DF6FCC
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920610; cv=none; b=QMQ50Cuytmqy8RpSAkfsPpn6V3KZVFZxRCZBg3QJZg9FVX80lSlK2CEtD0BilRX0pX+NPAqbXofiwGjk8UbuKnIhAxDdBY/xrAzJRWu8q+ItpeMVa1BRb8gOO6bt2IzmWK0jQMOmL0kaiyyUAiMz9Y4u+/aTa1cMi+tLzU9dNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920610; c=relaxed/simple;
	bh=Ebr7Q+vNeTMePzT5VXDtKO5QQQWysLYOGPkwxJSciWE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=h61hmrp42govx0yCyXe4Hp59C2fkcNYGUWAUnaSarvbIPlp/fB0ohF6WnbBI9G+TGdj0+7rZ/vShm81Eef0otCRv9CUbpe0z/CIxnrcV2Rr5fcGuqrq3O8z9oInYNeeXYF015gmRT6FAttGtw9uCBtIhzlLH4nGiFAbDz8CdfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=I+mcjpmX; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F36AC240002;
	Fri, 12 Apr 2024 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1712920600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ebr7Q+vNeTMePzT5VXDtKO5QQQWysLYOGPkwxJSciWE=;
	b=I+mcjpmXwqfkSrzhm/0R6PVLlgou7q+VRMEW5Fw56Fdx2Nb7RTdg9C6k/9bwJKLNShIRye
	FUglv7Mvl0QpffWwTW4EqPzd2i9XamqD8dnLf8Ena4sMlHvZ+5zHQ0ORbzBPw2q/zI2Zvw
	vL4HTIwzXjmqqrxjs2JowG6QRXpNd4m3+BgHKmQK34hXBv8VLoAn/3aR3Lcjfiry2ags48
	nj/t9+kR1OuOicNDaulE+3XM93mnqCAQfYJqj4Iopx8KjxCIT2/Dxdho4sEGwwDPQn2P3w
	YsIPyefCFGjWlRdRdIxP0p+2FeiKipoCcAP3qEgvdimVWwTkb2A+R3ta+PlPMQ==
Message-ID: <fce3c587-eca3-402f-a31f-5473fd2cd6eb@arinc9.com>
Date: Fri, 12 Apr 2024 14:16:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev <netdev@vger.kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: DSA doesn't account for egress port mirroring by PRIO qdisc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: arinc.unal@arinc9.com

Hello.

I've been attempting to use the port mirroring feature implemented on the
MT7530 DSA subdriver. I've learned that this feature is utilised by using
the tc program and the matchall filter.

The examples section of tc-matchall(8) [1] shows how to create ingress
mirroring and egress mirroring:

tc qdisc add dev lan0 handle ffff: ingress

tc filter add dev lan0 parent ffff: matchall skip_sw \
action mirred egress mirror dev lan1

tc qdisc add dev lan0 handle 1: root prio

tc filter add dev lan0 parent 1: matchall skip_sw \
action mirred egress mirror dev lan1

Creation of egress mirroring fails:

RTNETLINK answers: Operation not supported
We have an error talking to the kernel

After studying the code path, I see that in dsa_user_setup_tc_block() of
net/dsa/user.c, binder_type of the flow_block_offload structure is checked
to distinguish ingress and egress. As the PRIO qdisc does not assign
FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS to binder_type, DSA returns
-EOPNOTSUPP.

After some digging, I've found this commit 1f211a1b929c ("net, sched: add
clsact qdisc"). With the examples given on the patch log, I was able to
create ingress and egress mirroring:

tc qdisc add dev lan0 clsact

tc filter add dev lan0 ingress matchall skip_sw \
action mirred egress mirror dev lan1

tc filter add dev lan0 egress matchall skip_sw \
action mirred egress mirror dev lan1

DSA should either somehow allow egress mirroring by the PRIO qdisc or the
examples on tc-matchall(8) and tc-mirred(8) man page should be replaced to
use the clsact qdisc.

[1] https://www.man7.org/linux/man-pages/man8/tc-matchall.8.html#EXAMPLES

