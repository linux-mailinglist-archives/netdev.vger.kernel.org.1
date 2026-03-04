Return-Path: <netdev+bounces-263822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHPVIn04qGkTqgAAu9opvQ
	(envelope-from <netdev+bounces-263822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 14:49:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E31E0200B28
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26FA7308D3E3
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A83909A0;
	Wed,  4 Mar 2026 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fkv0RGbc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657BC36EAB3
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631879; cv=none; b=ib8io55LLlOnyhGBUuAU0x3JUTvHYl6hG5YfbfUohgeXu0i2+VtF4UrrN+b7IFMJ+rV4dXIJ9LkZEyBG8yxH11He+Gxy3tuvK0JquPcL/ykUNrYXlgIJCxZliufz06HUMU8uCwsJhoNWIuqrCLQSaHl0R3qMe0AjtEF8E+CmXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631879; c=relaxed/simple;
	bh=mb8/E7r/JHT4CQjD5aiSO/ltiDaZnTeNfRwQiOerju0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7/l9apC5BYj3GB/PGnhmg8BssPgW2H52f6b+SRQB4kUjOQe2XybTwfs/SzcrYsnkC7PSgISIEJPaVfZp4uRbhC33CiHaLWHqskopKDqMoR4rcLPGhPQ94G3FZm7lG/DI3pc9QDYiet99+SPLsyTx38N3PwNuNzoAuPZgow8exw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fkv0RGbc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BCA1DC40FBE;
	Wed,  4 Mar 2026 13:44:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8DB565FF5C;
	Wed,  4 Mar 2026 13:44:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43275103695C1;
	Wed,  4 Mar 2026 14:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772631875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=S/hqJ4IhKM0l73wJs15uIccMo9eVsjrJwaIKX6REWAQ=;
	b=Fkv0RGbcDbiuVXq6d4OtHGvPeWZkrInwUEVZzQduBAme/+ODBx3RzKWU7gA/osOI8dQTIl
	k1jn4b+9EudsQegtGmE6CQBJOsEPSHlCGaiDo2DbSHvulz3deZTMCD6yg3epV009a+DcSC
	7Mxh7pwoC3qozp+5QHoMfDfbwUQ4fYeEcgQoucyp9cmT1ywpGb7pbDiiHrlYe3EBC/9BuW
	55Km4akBu1GdXRVmDn3ARK0fGL0SZxtPe3kvPJp63f5zZcVZ/9TBoUgAefTGSfV9CnA6xP
	PxZbXgTI4ke/2OuvZe6qL59t0LMCEXVXRTysROwq9NAFLdU4lVdt8ByS6dliIw==
Message-ID: <97647b31-61cc-48f1-bd50-f2e749c0c209@bootlin.com>
Date: Wed, 4 Mar 2026 14:44:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] amd-xgbe: reset PHY settings before starting PHY
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 horms@kernel.org, Shyam-sundar.S-k@amd.com
References: <20260304122305.812541-1-Raju.Rangoju@amd.com>
 <20260304122305.812541-4-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260304122305.812541-4-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: E31E0200B28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263822-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Raju,

On 04/03/2026 13:23, Raju Rangoju wrote:
> commit f93505f35745 ("amd-xgbe: let the MAC manage PHY PM") moved
> xgbe_phy_reset() from xgbe_open() to xgbe_start(), placing it after
> phy_start(). As a result, the PHY settings were being reset after the
> PHY had already started.
> 
> Reorder the calls so that the PHY settings are reset before
> phy_start() is invoked.
> 
> Fixes: f93505f35745 ("amd-xgbe: let the MAC manage PHY PM")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

This looks good to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


