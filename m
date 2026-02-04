Return-Path: <netdev+bounces-256669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGoLJHYjg2nWhwMAu9opvQ
	(envelope-from <netdev+bounces-256669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:46:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F9E4B9C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D0203003717
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439B30F921;
	Wed,  4 Feb 2026 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eqGBhOE0"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2927456;
	Wed,  4 Feb 2026 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201968; cv=none; b=E8TlREqTi89HHsWSMW8bkpmEtmI9ysGSiEQfb+L3nokae7omlVLIMLHd6W/ukkLcu7PAeSBnJXK1ASInU1DYFf01bpDysrTMfJWDH+w2rRd1MIy55xWNo6X+Vl2u5AcARw2RLOEcnn6t6skQTIciJyRyL9g7JuyQvXslUEChCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201968; c=relaxed/simple;
	bh=nE5AQxfl8D2D0mS+A6xy6L0RiK2Y7/zsPPe18durZqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHELCUlXbtTgKIs/aUbiezbWQrobbvAWA7CAUbumzI0i2xHLoCJNz6Bfmt//a1+sbwkegZ8VuFuzq17GaPENviylnt8mQ0Pp15L+4VMuS5+J4TaR4Y0xQOGaFN76bb1hPbQNevaxKc45C+Xi5JQXgi21GdYDuQ+0jrCFON8Bs6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eqGBhOE0; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770201929; x=1770806729; i=markus.elfring@web.de;
	bh=Qh6EGGAuZMfJEqySr8dKIzgzjjzaJf6wwJmEg6oCsfI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eqGBhOE0UDOd/hBFWtt6TZ8EuTD3FawnGknUVS8MsFa2eAs9FPt/CWOrxD14g3at
	 7WugL2Aq4PSjyUZ5oEKqfLA/GHagZkgUbhRuOJdfz3ZIqPHSRI6ftyIRqCXQeR+LF
	 noBl5TLp+PW6MqBL28LZfKtYKi02F/pjADtWZL80mcYyXipjT2ar3EOdXrM0UB4Hi
	 9JEXndmWESA/B9+UlIIyUe1RNhVaKb4OXZ4dDO88Oh38NrBlGMGf4BPlCl4uaYKln
	 FvrZW0pdXOUQ4HsJSMDtAos+1yH4SdfCs3kjG0gaCWrDMZRvGzMzuK4i+7jBkVpQJ
	 u+FQOF1q0IZKSgnCsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.224]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTvvy-1wDSyR2daU-00Pjn4; Wed, 04
 Feb 2026 11:45:29 +0100
Message-ID: <ead52d66-b594-4dd8-91a7-9baa88230728@web.de>
Date: Wed, 4 Feb 2026 11:45:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Use system default
 workqueue in ndo_set_rx_mode callback
To: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Byungchul Park <byungchul@sk.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Himanshu Mittal <h-mittal1@ti.com>,
 Jacob Keller <jacob.e.keller@intel.com>, MD Danish Anwar
 <danishanwar@ti.com>, Jakub Kicinski <kuba@kernel.org>,
 Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
 Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
 <20260204-icssg-prueth-workqueue-v1-2-9a892f4b293d@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260204-icssg-prueth-workqueue-v1-2-9a892f4b293d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dlNPm9i/F9r3OoEmHApQAee0R65ZhuWrKuOcV7xU3kq0eWGj/01
 oveit5oPZoRXjp71+yvtkCQIqy9jgvz+sXQQDcB9vUjjoLGU6uGq3kSPi/6AmibGyfTomMn
 pcEaPwlGGELm58LlLJntMU8z99Te+xDgOPLWer/8zgwwdAaMfL105P5E8UbDV9ikPXJ63fh
 hsDGu+ed+sS8FMFKR1ybg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x+nQq753Mo0=;GeSmyJAETiQuLkkLbZvj6nTscic
 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
 ncJRHjplVjDYDapZEbG4XKb3snwaC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256669-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE4F9E4B9C
X-Rspamd-Action: no action

> Currently, the actual processing of ndo_set_rx_mode is executed in a wor=
k.

                                                                          =
  queue?


> However, there is no need to create a dedicated workqueue for =E2=80=A6


Regards,
Markus

