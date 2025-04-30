Return-Path: <netdev+bounces-187017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5271AA47AA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D719A834B
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CBB23505D;
	Wed, 30 Apr 2025 09:53:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8C21325D;
	Wed, 30 Apr 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746006811; cv=none; b=ff3RYhQwRXTndE/LTmQtJpS3FMcVpFNMUz78GGJfqTW/xPDOHpRXJRkqh+CkLVqSCg1KVw6LR53DyOvY0cgJP9S0TpfUNDXlbDRkiWpZV8kTq27iyh9Z54SSbr3Q4cyx0fF0Khtp7MxaTJuvABXmKGdXCcKZfuPvl1B9ZST7gGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746006811; c=relaxed/simple;
	bh=JzQpokK6fstc6jMeRyD83tGumvON7WS7NNjqeNY3D98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiOHIXUQU1s2qpnkgO3rxnzF8Gbtn5YmlLuUTACFLmYmaND7oK8JEZlpfCTV1sI/SDSQW3w3p7bsiPfJlxO3plEWg0Ur51qd5pv0oEQBAbq1mgkDoP2R+C7eKUsnEEm050TJu6KDjfn4fnpqzPk4sIGWZrFc/o30qpODy+jmeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=none smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpsz17t1746006696t61dbbf8b
X-QQ-Originating-IP: SgdxThapkgx48M+mCvGDLsHXNAQ5atEQrIwqzuEiytg=
Received: from localhost.localdomain ( [175.9.43.233])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 30 Apr 2025 17:51:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11376402698331337444
From: Zhou Bowen <zhoubowen@kylinsec.com.cn>
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH WITHDRAW] amd-xgbe: Add device IDs for Hygon 10Gb ethernet controller
Date: Wed, 30 Apr 2025 17:49:12 +0800
Message-Id: <20250430094912.6590-1-zhoubowen@kylinsec.com.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250416185218.GY395307@horms.kernel.org>
References: <20250416185218.GY395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MX+1SEN3H+wAU6OWG1ICS4n58oY0tX6NTu///qtjaJUJiwo52GIvs6DF
	9/dk+ZURmKVZuGMV87PiB4lP6ZKY9wFG66C6s1hPNg+DfwGKUM1KcJzNs7zZaRVRh1JQjxi
	yql/D04/+IacHSQB5dwSokfQ3yicOSiVcXrDOOc0MinAjufzULnxzV/Q8R6ndfofuQfgakO
	TU1FAt1vARXmtz6ebtVhYjq8Lk8xkXalElWiMm62bidzkEoMt4hj3Pyy/wlsGbtI1E+LvRe
	VpK0KG90czmx+zHE0s6xWblEuxbJ+Q6ZSAXesVpYFuOHS5JxGjQVFVkRf6jG8//Za/hs8NV
	t+rC/+n2zh/ASxu4dC/BW+DhPPrZVLwf2mvd1nN2b8Ms162Xn5UjFDgrpmWPpu6RFE4rG9p
	PVCaDAkNnQZQMr78kGjHcc87O5XGkFu8/uYy1ttaPWCFxAQLiXX/h2FMpH2PUwa2zMl66Dv
	mFObEdwGam9jjeAU+yJkgTDTfF4UghG4MPCMaCaxGokY/jmLOJ23tyBy/vx8KEYcW9ORMc2
	hhJ19UiARN3pGW3q7zF+jbnP+HyM9Dt2Hj9c2Ru7Afn+0VuGKKWKllehRzwjT57yiho9H5I
	gKeB8a9BXdjQasCkDAFm086v8JCLRw8oKD3OtWp7oyRt+iQa5xLwa4iTFY8UDFB7+VzV9DJ
	3XXsgwzzMVpQS2HREbwlDDaouUc90PYOgSoxLcCjRomDnr4bvG0BwcEJt/iQBfAGB/UjlNK
	5JpA81LLQBuy/pvXMkjc8jBPLrjeKLrLo3SvxzZ+h3hPsOpCmIL+5wQnXzX3py+pBxyq0Rn
	X+85Ym58hMMNcEweRt7qiAbVtjxmjQFRxmbl5WMfhwp12ZVTiJ40EwNt5BzcITDgWBLYsGq
	/WNg1eXLc1FDzy543VVhhCMA1XyCjjPODRloFRZpji+SqkywL6suPRNLC7DVMq6gIZZPmx3
	DVMxgr6U9wJf9dGCByEVd+wIJOwHoF9rOdkT3ntH25ll/c1JWzTV5Wlkb
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi all,

I would like to formally withdraw the following patch due to a possible conflict
with Hygon product using in the future :

Subject: [PATCH] amd-xgbe: Add device IDs for Hygon 10Gb ethernet controller
Message-ID: <20250415132006.11268-1-zhoubowen@kylinsec.com.cn>

Apologies for the confusion and thank you for your understanding.

---
Best regards,
Zhou Bowen

