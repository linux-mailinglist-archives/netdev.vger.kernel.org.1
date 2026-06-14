Return-Path: <netdev+bounces-299150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nCEbFYpELmqgrgQAu9opvQ
	(envelope-from <netdev+bounces-299150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 08:04:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E3680732
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 08:04:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=Fh2CbEYO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299150-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299150-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F010E3014413
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0950B30D3E4;
	Sun, 14 Jun 2026 06:04:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2662877DE;
	Sun, 14 Jun 2026 06:04:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417093; cv=none; b=DOlXTA4gNciIwlOLB/VOGembf0PBPC7/yVQ42zt8yzpv0TT8roBvTcNTz4VgMciv7OUapfqbU/eRgJUbL7QwW9VclOmRCqQbU+LatOd6Dt+k1ZnCfMict8Ga6HCZgJuKy1EZuBW2hcIB6zFqGno2CB/MeiL9Ot8q1enXZWNg3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417093; c=relaxed/simple;
	bh=s6WUdKB0HX65tmZzfUVZ+TO2FMtVdJQH40P5H40ejSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhktyuy2Iuz9hcLp+Pyi99Mgexa7DdoIJUIPkoNpd2AOlTc9gEDV7+SjK0VI57cmg+zIRXmZWrZpdDcPXL+dVbfUULTg6seeiWHmC+3ULe2ISRcYG8bc0Jldfl6caP09iFLM40eI2ht3TRfEvLhd0kH+nMMRsXk0ilV0VohWWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Fh2CbEYO; arc=none smtp.client-ip=117.135.210.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Nz
	RaFllgbJUPkQGZbFtgLbRMeFTz9N0dOaTYnx4qasw=; b=Fh2CbEYOo7wtwc8z1l
	yTG/mKSe2YRHnusuHVOM6Kd7dOsmZBAHEL7dlqwjE+dyPvgCVA/cyfVrHvBgXfdS
	sZR/EStm8O2l+pycmnNwVldKWxLtjRZ4/vji+KAjizMVcpcVbt02vD31J3QCdLlG
	+jxMNM0exQa5Tu1T2JYzFpK4g=
Received: from PC-4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBXd8_3Qy5qUeEQDg--.47324S2;
	Sun, 14 Jun 2026 14:02:44 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: j.raczynski@samsung.com
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dinghui1111@163.com,
	dinghui@lixiang.com,
	edumazet@google.com,
	kuba@kernel.org,
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
Date: Sun, 14 Jun 2026 14:02:31 +0800
Message-Id: <20260614060231.1095292-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aiaORbb0lZVxDg8L@AMDC4622.eu.corp.samsungelectronics.net>
References: <aiaORbb0lZVxDg8L@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXd8_3Qy5qUeEQDg--.47324S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4DCry8Cw43Cw1rur4rXwb_yoW8AF43pr
	W7K3yDGwnYyr4xG3yDZr48WF1xJa9I9rW5Gw4xJrsxXw15uFnaqr4fGrWj9as7uF1vywnY
	yFWjyan7uayUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEsjj3UUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0QQ4ZGouRAQ5ggAA32
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299150-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:alexandre.torgue@foss.st.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:dinghui1111@163.com,m:dinghui@lixiang.com,m:edumazet@google.com,m:kuba@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:liuxuanjun@lixiang.com,m:maxime.chevallier@bootlin.com,m:mcoquelin.stm32@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:xiasanbo@lixiang.com,m:yangchen11@lixiang.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dinghui1111@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,163.com,lixiang.com,google.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,bootlin.com,gmail.com,redhat.com,armlinux.org.uk];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,samsung.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C59E3680732

At 2026-06-08 17:41:25, "Jakub Raczynski" <j.raczynski@samsung.com> wrote:
>On Thu, Jun 04, 2026 at 10:45:54PM +0800, Ding Hui wrote:
>> From: Ding Hui <dinghui@lixiang.com>
>> +	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++) {
>> +		ret = stmmac_reinit_rx_descriptors(priv, &priv->dma_conf,
>> +						   queue);
>> +		if (ret) {
>> +			netdev_err(priv->dev,
>> +				   "%s: rx desc reinit failed on queue %u\n",
>> +				   __func__, queue);
>> +			mutex_unlock(&priv->lock);
>> +			rtnl_unlock();
>> +			return ret;
>> +		}
>> +	}
>
>This is not directly related to the patch, but rather stmmac_resume() itself,
>but doesn't this return and hw_setup one leave bunch of descriptor memory
>hanging and effectively leaked?
>
>> +
>>  	ret = stmmac_hw_setup(ndev);
>>  	if (ret < 0) {
>>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
>> -- 
>

You are right that both error paths leave the descriptor rings and RX
buffers allocated without an explicit cleanup. However, I prefer to call
it a memory "hanging" but not "leaked":

The memory is not permanently leaked. All RX buffers allocated in the
error path are stored in dma_conf->rx_queue[q].buf_pool[].page (or
.xdp for XSK queues), and the DMA descriptor rings themselves remain
reachable via priv->dma_conf. When the user eventually brings the
interface down, stmmac_release() -> free_dma_desc_resources() will
free everything correctly.

Maybe I should submit a follow-up patch that adds proper cleanup to
stmmac_resume()'s error paths (calling free_dma_desc_resources() and
marking the device as not running), if that would be welcome. I'd
prefer to keep it separate from this fix to keep the scope clean.

>Other than that, I don't see any obvious issues.
>

Thanks for the review.


