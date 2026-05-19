Return-Path: <netdev+bounces-289551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGCQChegDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:38:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D298583311
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 435B430086BB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A2E48C3E9;
	Tue, 19 May 2026 17:38:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C586409122;
	Tue, 19 May 2026 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212289; cv=none; b=I4SdDhZhPgMmwvmjMR+o/dMQ6TxDcf7h0LogmrVOJOcmzz6yHLc+xTx+hw+d3/9Yhv9ZNNwFxxp9Zh47ZOBJBjC9V29TmcAbbKZMwLBs5llBAD8zFMm0M6N+mYsycUVtqZ1E+nvSZzj257Uoafib6MOEGoG2CqFblSbbSmzvrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212289; c=relaxed/simple;
	bh=AtrT929H9sA3accdr0mH/7h6YGVnKrtINt2hya3nOuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AIW8zmx/pnJejKCgb/ifOardt9e6VFlrRC0QG8UFc7xcgLGYhSWAOWIjFeHk7ukC+vz4bEfIk02TerZ07lCJARi36vizoTSFtkDg+qMCgRGbf6AgHo9IamwMGlFLBtE1aexT7Ukiwg5G7+0XTiRW1CkmEsuRGlhp2G97YO/vaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 68521160FB5;
	Tue, 19 May 2026 17:37:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 036D530;
	Tue, 19 May 2026 17:37:56 +0000 (UTC)
Message-ID: <33318503dca54fd9401ca99213632c59d5deec12.camel@perches.com>
Subject: Re: [PATCH net] net: fec_mpc52xx: Fix resource size format
From: Joe Perches <joe@perches.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  open list
 <linux-kernel@vger.kernel.org>
Date: Tue, 19 May 2026 10:37:56 -0700
In-Reply-To: <20260518044047.1002235-1-rosenp@gmail.com>
References: <20260518044047.1002235-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: yfzwabfdt3kbtxtc3g84g4s3iuthot93
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18yIAiw2nrCp2W6h9tC531K0QNLmsaiPHc=
X-HE-Tag: 1779212276-903603
X-HE-Meta: U2FsdGVkX19Agru9PSoG/6heNx52oYfDd17MI1CKBhsWQks7LClVOnJuSgrkeGTwwn5b/cu8MP9Z2+6WXNYGGef6Pql/enzGCsqa1LtkgUXDf6Hn++frW3XKT5xX/yqoLGiWY7xKIQvFtavuEC+EB/vWkoD3XmBRXjaVWZeBMPiiFRp/KBazO2TZ+nJPfsQ9I603Tw9qPyIgMcHORjJmRO0KlQn1DWdJopw/shoLNDm7ncSuK9nOGNH4vC0t1JA/AbLRe3mXcoQJvU5t1rAIis0TR2WFMxqXIQVKdPOHAQNghd2ZIvn/9KAAQv2os/1s32UItuwVeI8/1eLPfFZ1sPWM+002wUujB+zC3v/LZPlbEs7mbQtOE0CGcZR6+hQy4KJSv2XhJNHqIergVf79FJG0cli2zgZd
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289551-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[perches.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@perches.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,perches.com:mid,ozlabs.org:email]
X-Rspamd-Queue-Id: 2D298583311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-05-17 at 21:40 -0700, Rosen Penev wrote:
> resource_size() is printed after casting to unsigned long, but
> sizeof() returns size_t.

trivia and I wonder if this code path is even possible

> diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/e=
thernet/freescale/fec_mpc52xx.c
[]
> @@ -834,7 +834,7 @@ static int mpc52xx_fec_probe(struct platform_device *=
op)
>  		goto err_netdev;
>  	}
>  	if (resource_size(&mem) < sizeof(struct mpc52xx_fec)) {
> -		pr_err("invalid resource size (%lx < %x), check mpc52xx_devices.c\n",
> +		pr_err("invalid resource size (%lx < %zx), check mpc52xx_devices.c\n",
>  		       (unsigned long)resource_size(&mem),
>  		       sizeof(struct mpc52xx_fec));

mpc52xx_devices.c does not exist.
It was deleted nearly 20 years ago by:

commit 917f0af9e5a9ceecf9e72537fabb501254ba321d
Author: Paul Mackerras <paulus@ozlabs.org>
Date:   Mon Jun 9 14:01:46 2008 +1000

and

It's possible to remove the cast to unsigned long and use %pa
and %zx could be %#zx to match output prefixes.

