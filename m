Return-Path: <netdev+bounces-271901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDlHFJLixGnz4gQAu9opvQ
	(envelope-from <netdev+bounces-271901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:38:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F19330877
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1E863018F16
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B39434BA59;
	Thu, 26 Mar 2026 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dx1mxg19"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B0E1A3029
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510735; cv=none; b=KpQ8Vn07b92MPt+VFrfbPDoeQxk597AT6VpZBJodMlOcJmBNtwBsDoeC3Ud0XTQp17z83dHBwludF00M6OY1B/YD0Vd/ev32h80wj1uQPSsheHh9/onJkmS9Orm+1PTkp3isvLyF0FYQbvmrTSuuqEmsA+nVob9v1uu56YanXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510735; c=relaxed/simple;
	bh=R3wbXgK2r8UzgrCyD7t5lRhw2OhPhOtemTvhLLUTItg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNdRqxEjv153D7nv755J0qnZ1scouIBKqQshrgoz3W7DvbwIsf2yg5Pv+5TsPv/jN8JTyU6CoIqOsW1x7EwIqv69/cO7wE4SSAx8w4rT/Uy/5/iGlyJ1WLAXEqTAsR1jxmFjoPkd1zxTK4otjDwNlBCa2IvqkUnJTbOoRpHhAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dx1mxg19; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D4C324E42801;
	Thu, 26 Mar 2026 07:38:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A30B5FDEB;
	Thu, 26 Mar 2026 07:38:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1730D1045120B;
	Thu, 26 Mar 2026 08:38:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774510729; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jj3IUh9R4W8+zkoV9vgo47YT8g/4LpTWBqx1PXl+Xuo=;
	b=dx1mxg19tKD42CdR/2YaBJLf7Dr7Fe8A7WsqqtMLBf/vZtK80OAm5Pyjs0aChk3h0Gt1Z7
	SojNhPAdTawdHI+A61XZO8Sf7qSYBxkK+KtMSJJuFjlhzaU7pIciS+fYgpACK7+0S5gK4e
	ZHR0SvQMyICsJ/DVLsjG6QD7JFk1RNLfe2wXVaW500om5NxSsKvJY3BDUROV4g6nFyMZji
	s3tPdWPC4wmX59nJEVTGfXi5AjVssF/xG+WhagOb1GqIwHxbmOI/LmaAmvoNtZcOZB4exq
	5/FNmmAGBUJlp2oyDhgvelvms6ybZx2Mjv1goCN484gu3+BwlnWLEyNudaD9PA==
Message-ID: <2f496443-ea0a-425d-9c83-fb9c33a106fa@bootlin.com>
Date: Thu, 26 Mar 2026 08:38:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phylink: use phylink_expects_phy() in
 phylink_fwnode_phy_connect()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <E1w4zHg-0000000DmC4-2oyb@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1w4zHg-0000000DmC4-2oyb@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271901-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: B7F19330877
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 24/03/2026 11:46, Russell King (Oracle) wrote:
> The tests in phylink_expects_phy() and phylink_fwnode_phy_connect() are
> identical (by intention). Use phylink_expects_phy() to decide whether
> to ignore a call to phylink_fwnode_phy_connect().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



