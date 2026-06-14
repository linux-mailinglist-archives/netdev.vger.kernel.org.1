Return-Path: <netdev+bounces-299151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r10FBDhHLmrVsAQAu9opvQ
	(envelope-from <netdev+bounces-299151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 08:16:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6109068077C
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 08:16:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="XamlYa/H";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299151-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299151-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56DB63013700
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D672777F3;
	Sun, 14 Jun 2026 06:16:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA162AD2C;
	Sun, 14 Jun 2026 06:16:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417779; cv=none; b=c3y8l7TwaSLr7VNV8QZnOAzBEReKgoABeHS4FaIJSqBiIcI2hqnxMCWF4pNxnxnDmrxuU83avqIcDeB6ftJk0FbEgf+9G23ocxxGNxE32LSaIwF8S91nW9MaiTJq/nMmwk/IV3XUmGsJyY6dfNruo6OA7BGVz0UmJ4l8p2odic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417779; c=relaxed/simple;
	bh=fUE+ixLMgRwxKlKVMSdLwsTAPmwMzppPX/xq/mSZXhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+42+utMH3iyoT5hZ0Ev/cIs5y0H4hM5d5N81pu6G+lpGiYNSS2M71QMeoly1vYQaGKr2b6Yf4mLkxvZUD7JBiSezACH5pdQM5FdZX2LTumQM78pXx00Poxm5RZf96ctUSG0qg7gFOTCW9cZaBpiow9kk60Jyi3DscgJmjDPHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XamlYa/H; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h6
	UuS0kzMForj/4DigAMdegzm+Yyq511CmAEpPSByMk=; b=XamlYa/HwgBstmOZK+
	d1Hyo0tpNXiNK+tBdxY7FPQWH/JqqGszS4T+01JymI4QshyEdbbvsNps1JB1RvtS
	DL/ugjCmxWgSj6yBbqfCJMyP1j1ZjvnWEUdFik02toMWQ9yaAjfciucdKKSt7vX9
	TPZZjW2i6bsopIpwrQz6eOkLw=
Received: from PC-4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCHwGq9Ri5q3ywFDQ--.46614S2;
	Sun, 14 Jun 2026 14:14:36 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: kuba@kernel.org
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dinghui1111@163.com,
	dinghui@lixiang.com,
	edumazet@google.com,
	j.raczynski@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	liuxuanjun@lixiang.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com
Subject: Re:Re: [PATCH v3] net: stmmac: fix fatal bus error on resume by reinitializing RX buffers
Date: Sun, 14 Jun 2026 14:14:20 +0800
Message-Id: <20260614061420.1156099-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608193059.78e05dce@kernel.org>
References: <20260608193059.78e05dce@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHwGq9Ri5q3ywFDQ--.46614S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4kGw1fXF4xur43AF43KFg_yoWxZFgE9r
	sFgwn7XrWDtFy5JF90kr43uFWq9F47Jr90q3WUJF90kF97Gas3ZF9xCr9IvF1kWrn2vFnF
	krnFgFyxGry7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRC380DUUUUU==
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0QzqF2ouRsxldgAA39
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299151-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:alexandre.torgue@foss.st.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:dinghui1111@163.com,m:dinghui@lixiang.com,m:edumazet@google.com,m:j.raczynski@samsung.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:liuxuanjun@lixiang.com,m:maxime.chevallier@bootlin.com,m:mcoquelin.stm32@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:xiasanbo@lixiang.com,m:yangchen11@lixiang.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dinghui1111@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,163.com,lixiang.com,google.com,samsung.com,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,bootlin.com,gmail.com,redhat.com,armlinux.org.uk];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dinghui1111@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6109068077C

At 2026-06-09 10:30:59, "Jakub Kicinski" <kuba@kernel.org> wrote:
>On Thu,  4 Jun 2026 22:45:54 +0800 Ding Hui wrote:
>> +/**
>> + * stmmac_reinit_rx_descriptors - re-program RX descriptor buffer addresses
>> + *				   after stmmac_clear_descriptors()
>> + * @priv: driver private structure
>> + * @dma_conf: structure holding the dma data
>> + * @queue: RX queue index
>
>nit:
>
>kernel-doc script says:
>
>Warning: drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:1733 No description found for return value of 'stmmac_reinit_rx_descriptors'
>
>You need a Returns: statement in this kdoc
>-- 
>pw-bot: cr

Sorry for late reply. I will update a new version for it. Thanks.


