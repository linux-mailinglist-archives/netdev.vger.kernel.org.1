Return-Path: <netdev+bounces-277261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOMeJDeW2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:18:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F053D2A73
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0674F3018AC3
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0022347FFE;
	Fri, 10 Apr 2026 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DMtPVbln"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECCD1A6815;
	Fri, 10 Apr 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801869; cv=none; b=f4sCQlFrHiJQqIckmrPwiOEQbtaiqabx/qJWiIDss5pJCvC+fOQF/3JL3GNMjZqxQTT548V291zcxs3RGlDRKXwbwh/+viUe00PPD5fC0MucLThzLS2U0BuHiVpCVxiI4k74IowezT2g0ztLBxrPek4ATjZOFFqGqDdJ5aQkLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801869; c=relaxed/simple;
	bh=ZIMFqQRGFEoK/xMFC3XhpI3nYdTkwa3+DAIL83BvR4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ErOMmn/1HfJFQ4SLruUVJLj70k0M1FhCrAwfo0BSIDzfMd88lHn4oX7kuyHOkt+locis/7m1g7ZbTfJRXR1iH4jN7s6mSNVAOpuE+3338zOlLBq2euZuvxCsWmswQrqonO37oVslQmkBElaWWr+zVlgjRjXUSaQsV9R5bRJp5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DMtPVbln; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZI
	MFqQRGFEoK/xMFC3XhpI3nYdTkwa3+DAIL83BvR4s=; b=DMtPVblnLyBta20IGk
	vxIcHWSQLFlfXhH2LCqE/drz3FQNT55qY2zfAEX+hJJBwOpDO+Q6yJbH7tWVXhvu
	JrxhQ22NaK31v8KtN422YYro60ggG5AJNKgWd19lUs2gcvVQpZuRgAaU5UyjKN0F
	M11CHPpXESsShJDYuSIg5GVvA=
Received: from YUANZM2-F4WK0J3.lenovo.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3B_nhldhpioNMBA--.57048S2;
	Fri, 10 Apr 2026 14:17:06 +0800 (CST)
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
Date: Fri, 10 Apr 2026 14:17:02 +0800
Message-Id: <20260410061703.3547-1-yuanzhaoming901030@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au>
References: <ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3B_nhldhpioNMBA--.57048S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUE__UUUUU
X-CM-SenderInfo: h1xd065kdrzxtqjziiqqtqqiyswou0bp/xtbBogIuOWnYleIvWAAA3G
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	EMPTY_SUBJECT(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-277261-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37F053D2A73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



thanks for you reply, jeremy.

I will change the identity.

I also modify the optimized code.


