Return-Path: <netdev+bounces-256667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEq+OCgig2mKiAMAu9opvQ
	(envelope-from <netdev+bounces-256667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:40:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A85E4AD6
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC3F3013AA9
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7343E8C52;
	Wed,  4 Feb 2026 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cAKUps/s"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894183E8C55;
	Wed,  4 Feb 2026 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201561; cv=none; b=aVS0+11Zv3U89B9VB6Y3h2VQc/7NXsqZgEXj2gB/awMbExXur6Y71zqnkM6DhMu4pvY2rAa4MtEwzutdLYfN2VqKPTYNjfNPj6x9YRGqyjmySJJA7UzXLg8KH6E3ZRbaqCLYFHX5bxZs1Wz7G5W8dWL3mYDU12A5pM4R5gcIRZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201561; c=relaxed/simple;
	bh=cH+eM2pe8TPA5aZppk1u2JeNKgzQ/D0RqRWjqGGVP00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKnfe6BkFJb4TZH/zKFrD3ufMudLEVRe1bp3PO7/KzJPujGmjsjasENlWzHcy010QsdUcomFUANj0WEKh0rJfJuTFcfT5XN1hXrpY8MfvUtBjMz4SKMYFV+yy7d/h8ElYsUDunjMNiSowDofCPXg9j6tbb+osxJkxX9IDUte6bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cAKUps/s; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770201530; x=1770806330; i=markus.elfring@web.de;
	bh=cH+eM2pe8TPA5aZppk1u2JeNKgzQ/D0RqRWjqGGVP00=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cAKUps/sdonjoLoPiTqVDk3S28jS0WQa7gz2ANAWVBbuHJE+3NinYEKEa4c9/pvA
	 quym0xtp/vv6N7ob0ocPEmWKH9I+jrXmC/N2vXQoVcmvjXZ8hIXJzbarUvODsVz05
	 vwXfcZRCbBlt/JC6kfkUeOUGG8Psc46SzZDYL92Yd7IPFGFSoiV6w+clRPimLZCPi
	 6Ndr2QzRIipns5feoUlaBvinQ2zVixEA+RX9G+f7T6sNYN4oDNns8pylEF7fwIVND
	 uQFa4a+Qk9sRoPOXfTLFfh70Hn/yXP40J8SfRlt7eXCEia/D2gq+MkxmP8EiHM5Zb
	 f45y5/a00hVYZ2m9Ww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.224]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79RI-1vmgZq2DvA-00rceO; Wed, 04
 Feb 2026 11:38:50 +0100
Message-ID: <b81fc1cb-066a-43be-8cb4-90a45bfc4b06@web.de>
Date: Wed, 4 Feb 2026 11:38:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth-sr1: Remove unused
 workqueue
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
 <20260204-icssg-prueth-workqueue-v1-1-9a892f4b293d@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260204-icssg-prueth-workqueue-v1-1-9a892f4b293d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pdLzDvVQBdrLIB92mlgz7J4sJ6ezGfzlfjZATPguIiQLipw15/2
 x3pmIZZfz6vT8eAAFN6JI9RHE2kF/x+arjg4/MrgYn2PaRzGtU0jx7QVxZThg6bMHqywaKF
 TBZcx8SY9xaZz50nRLJYHdVw2WVVPgW6gyQ6/RXPNxQTmXk3kcFxK+hNfUrd4pnq8ocSxp5
 zK78GL20aJBynbmvHFgTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ry5on1SLlJA=;4/udk5yiFK1AfjzZ4sogT6OEcht
 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
 +tztjoFI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256667-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49A85E4AD6
X-Rspamd-Action: no action

> The dedicated workqueue emac->cmd_wq is not utilized in this driver and
> can be safely removed.

Wording suggestion:
Remove the work queue =E2=80=9Cemac->cmd_wq=E2=80=9D because it is not uti=
lized in this driver.

Regards,
Markus

