Return-Path: <netdev+bounces-288205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPT2Nr/JBmrynwIAu9opvQ
	(envelope-from <netdev+bounces-288205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:22:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DDB54A7C8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 376EF3001A5B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E03E5562;
	Fri, 15 May 2026 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="endb5xAj"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B385311942;
	Fri, 15 May 2026 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829755; cv=none; b=j1Cbf84vOTPVRQalOOVtujuixyQH0RBuC/lSpMpRCwg/z5+8x0DJJgTVi234ve0abRsmncnaTsMbMXCQ6DwkcwpH/i41GrcX7ApMEgNhA6shRWLkbRav7nKcUX00R/P30ui+Tl9tjjTP4tIlVqP0jfYObSQ80alPewMnPwer1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829755; c=relaxed/simple;
	bh=jG9TAJ1iY3ur3mvjr9IfkjbRHpTulPBwIPCliASiVHU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=orHTgchL6jLy6U7YC2UlYufmbOOwvzDtG7YW0NJo/gxYi2Z1VY9Dnn0eBucsUiBTCmzJ5jktcUTEuU3zHl2hqvhw+XKPBoH4GDwYwkoOsN1kadf+gHsW8I/F3P0ejqo4HkaJBw+mvjhNwqmX2mT1wfJtlQjGsCjLhOFuXL2LAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=endb5xAj; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778829728; x=1779434528; i=markus.elfring@web.de;
	bh=jG9TAJ1iY3ur3mvjr9IfkjbRHpTulPBwIPCliASiVHU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=endb5xAjpPF77YdtJylCJYUWBv/lB4lRN4odz/66K8rKu1oOrid7LfAwWeX8hYsw
	 iqe+I1LwJLVUvODPN0kLJ91q/38euf5NN++Elv96dhZVgjZQ6GMzs9zxCo9AAxHmC
	 xrV1+mWtQnz/FyddndyRd69Gmf9sTh09QYRHOVZ2JmIF7lE78/78UajuhTc8S45Da
	 N9rJyzmgU9pz18FnJ/AT7kT607N062mLVea+Ft+IMacH0s8zYgSf0vBZfe2/rakOH
	 UV0WUR/D0HoL5dgl1hcSoQDexGBmxeO/C51IrRqvOpIGQO6qypM4eBVr3QCE1rfB3
	 1gwUHZQrgn0WCeqe7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc8y-1x3SHo0rNo-00iZ11; Fri, 15
 May 2026 09:22:08 +0200
Message-ID: <635ade11-7010-422c-9a5e-cca4441a8a2c@web.de>
Date: Fri, 15 May 2026 09:21:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Chris Snook <chris.snook@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260515005923.14644-1-rosenp@gmail.com>
Subject: Re: [PATCH net] net: ag71xx: check error for platform_get_irq
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260515005923.14644-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KaoaJOlNKOCE8IxAKUIVVvtO5Cu/cgA+b4qwv1hQd9/Ih4wb7Df
 /AK6Q1oTlFYa3wz985WLa2Ev3cPuFZ5PeCUs71fyvF2EiQYAjXhgcMI8ZcqODpRsHSdehK0
 lIad/a62U9HME3ezIXPNlspC0VNZLkSfGMVoZiRRdPJyFDR0jVCqp69BWHD2283RlTVRu7C
 ZZR73iwOUfr/ssnbRTd0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zyQhuWAQPmc=;O4zsxQirhvdsAUVjqDU6ZGv9rGw
 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
X-Rspamd-Queue-Id: 31DDB54A7C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288205-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,pengutronix.de,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Exit probe if the proper IRQ cannot be found.

Would a summary phrase like =E2=80=9CComplete error handling for a failed =
platform_get_irq() call=E2=80=9D
be nicer?

Regards,
Markus

