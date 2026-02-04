Return-Path: <netdev+bounces-256646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL9jANYUg2nihQMAu9opvQ
	(envelope-from <netdev+bounces-256646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:43:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D81DE4012
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93B503009145
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E543A1E94;
	Wed,  4 Feb 2026 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wvDQQR6D"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C338F225
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197996; cv=none; b=HAnX68OJBKLfemlx3J8Xz4Kkhe3rhPOZr8JHsZznubJEvRN5xEC2gkqrzdvb71sRHy/jRdX0Dmg1w13qp3t7Qfev2lRWtFZKI0kdHmYT9lOps3Od906V9Xr/zHtNr0s2KK1nE+g7DW6anA8oWtcX8HkY6feTZV8k1rwf3eTkyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197996; c=relaxed/simple;
	bh=C+CMoSHbsVVkKpQx4qWlMSQu8EpXpFjp4jsH5u0O0/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k63eqGdTZti3CaAq0ycQgiPtruG4bL4NXOvB4EWd2ULugS+bCX5KxgiY1s5NMST9CgqfEvjCePHDmiIEDWyfBIQs2cVlCPK85WaHbKos7+7rSM+aDbseH9hNu42YPXF9Qqfw7DLxHqSmGlz6BahKiu+0whCWeN71BsnL3h2PgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wvDQQR6D; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1849E1A2BE7;
	Wed,  4 Feb 2026 09:39:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CAE3F60745;
	Wed,  4 Feb 2026 09:39:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 383D8119A865B;
	Wed,  4 Feb 2026 10:39:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770197992; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=AI/nHMuupilMGKzkZo1RxmEdDDqp05ziOca4mFkFe7Y=;
	b=wvDQQR6D3NBroTTsWxi26R4kPW+9aio4FhNW0rwmIim2KruxF+sPRmVT4VjQMLunA4Ibib
	ltTV/uFCBVhpL8x4kz4gfGY9u0v4AW9gpqgOrDWYYHIlnOqYqtvKuftqQUS4RbjYmT/yK0
	YjU+xglnARFA//o6JyluxbffW0afooKLZrSdVH7axblBGwwbUMOzMgg9CjdpiVdF6S7CvI
	zrFis9TzJqvk9ldNxb6CWAZ3dOGtzx2YkTil1S5YBWp65e4hwT9gARCalzPhbxqHTyeRru
	eilPDcA5AuI3ynI3GOD37z3IgND0dxrW21HaURKjOwfIbAc5H0v3nSodWyPhow==
Message-ID: <5935c13a-04cc-45a7-9b71-3ebd821f2043@bootlin.com>
Date: Wed, 4 Feb 2026 10:39:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net: stmmac: rk: introduce flags indicating
 support for RGMII/RMII
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYxl-00000007hol-3XiH@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vnYxl-00000007hol-3XiH@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256646-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 7D81DE4012
X-Rspamd-Action: no action

Hi,

On 04/02/2026 10:14, Russell King (Oracle) wrote:
> Introduce two boolean flags into struct rk_priv_data indicating
> whether RGMII and/or RMII is supported for this instance. Use these
> to configure the supported_interfaces mask for phylink, validate the
> interface mode. Initialise these from equivalent flags in the
> rk_gmac_ops or depending on the presence of the ops->set_to_rgmii and
> ops->set_to_mii methods. Finally, make ops->set_to_* optional.
> 
> This will allow us to get rid of empty set_to_rmii() methods.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


