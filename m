Return-Path: <netdev+bounces-277258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI0GDHWU2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:11:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C66463D28DF
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB893015468
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F3336885;
	Fri, 10 Apr 2026 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nkABXHRM"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1F29AAEA;
	Fri, 10 Apr 2026 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801458; cv=none; b=ltR2hMLOZXLi6bxfXq0lK2hITI9zZHnL5OCZQplsT9tS+QvFAK06O4IETrA7QmOx8NDOw13Blin6gXfctaS9fap+bI52xReIsKI10mHqicNtGITUcRTioTrMywTOuUqhNRjr12CllZY0bbQKUs6M0+M+I049HUGrS0m2cZntpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801458; c=relaxed/simple;
	bh=nDOTZSsMQBVAG7aR3cQ8dVNTGmXhyR0e6CHihMrcgTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ip5YFpJFo2fE9yfNRFaV3Uou00UcrSBtCnBWSWwGSKgo40ydL5fnk8qZ5HTVWRSB5avhgf8WRPAo6HR7c4aiB3waKREQbxLA2q8WKQ8nLqSJBSal5yh0s4gBC60lH8HccTG/Vp1LnyvhMUY8MacLY2akcptyJaU6zC9dvDz8JBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nkABXHRM; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nD
	OTZSsMQBVAG7aR3cQ8dVNTGmXhyR0e6CHihMrcgTA=; b=nkABXHRMOW1AbcrTrG
	0W5f3dDEEw9TRzmoTMrr/qxY/G1S1VEIoGhHPZ4oxUwIrFdibYFYiXE+8JRSJkz7
	BDg+Ngc11bkyEScBIQsznjYUPaNmzsku1A0tRaC9wILt+lyZJHp+8HJSsWCKqS5n
	WeGAFn+P6egc6b/iGKJoD3Auo=
Received: from YUANZM2-F4WK0J3.lenovo.com (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3J_Y4lNhpI8IjBQ--.25708S2;
	Fri, 10 Apr 2026 14:10:01 +0800 (CST)
From: wit_yuan <yuanzhaoming901030@126.com>
To: jk@codeconstruct.com.au
Cc: yuanzhaoming901030@126.com,
	yuanzm2@lenovo.com,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Fri, 10 Apr 2026 14:09:56 +0800
Message-Id: <20260410060957.1336-1-yuanzhaoming901030@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au/T/#rc39d8ae7e5ee7e74556d16fc836cc9f2bf745701>
References: <ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au/T/#rc39d8ae7e5ee7e74556d16fc836cc9f2bf745701>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3J_Y4lNhpI8IjBQ--.25708S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUj2-5UUUUU
X-CM-SenderInfo: h1xd065kdrzxtqjziiqqtqqiyswou0bp/xtbBoxnDzmnYlDm8LAAA37
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	EMPTY_SUBJECT(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-277258-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[126.com,lenovo.com,codeconstruct.com.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[yuanzhaoming901030@126.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[126.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[126.com];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C66463D28DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


thanks for you reply, jeremy.

I will change the identity.

I also modify the optimized code.



