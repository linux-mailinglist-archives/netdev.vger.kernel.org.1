Return-Path: <netdev+bounces-298148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aNSTFLC6KmplvwMAu9opvQ
	(envelope-from <netdev+bounces-298148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:40:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C76672621
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:39:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RwpkzWvi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298148-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298148-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BC9B3017EF0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57613F2118;
	Thu, 11 Jun 2026 13:39:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B793CAE7F;
	Thu, 11 Jun 2026 13:39:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185197; cv=none; b=mCj3/RH3BcQ3ba7bIWxHzaBG/RKpIlOowianfH/KTf68WjtD1VW2YuND6CkhUe8EWV+qn++G5im6OsXF7r5+FMNzgACvLr41HMD5Q5Yg3XlOkACoZwWks2pRU1NbmV7uHMSpo0/btFWWSw9tbq+7SSDCckKjg9wO+M93GfOFNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185197; c=relaxed/simple;
	bh=LYzBC1cJDTz/6me/r11nTjp3dT0PiU2aUWQpfxUfLas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pbg3fWcqrogVKa/vg09CqEHJJBGQyv0de6rGvDlVhIUl3EATJDccqgpuUZK1ytc+PhNr9d7xXZEeFhCYesniHraKf6er4aGy+FlFw5psqdOmX0xW1v6cW6hBrLatxT2ARCEw8gwO6IwsIwoehc49wFspCuwF7rBeuVcIKJmoo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwpkzWvi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4611F00893;
	Thu, 11 Jun 2026 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781185196;
	bh=jSW9a3UytJw/H9wvdOvJc05Jv5lLkV1LYySGAUxS1YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RwpkzWvi8Jo7IZcGPx7gokAtNMaVFNaulpqsFzo4hvCvvaoDY5y6g2zw6LI18qbFa
	 G17PVQRfdQztX+GVQHY9j8TvXFVt2ZapTIGplwHV4PZZpOpBbf3EoRmOAjcG8dVMne
	 jcZGCWcXQMVpAwAcdkzp5JvUW/maJHYYW3AT2VXnNeg3lXZn9EfEwmUCypQePVV70F
	 xABgTuBmvE/dQ4CMafuEHyGqYW4NPpIgOP9SyGN6WkojhGmxaUwG8JBZ59dI9xAdFz
	 AVnJI3gK+V3xl+SCxhS287XuTqiuJ/gAPR8ts/tnJfS0LyT0oEbYytM3PCWVFcmT2B
	 R1UzNeiTXzIbA==
From: Simon Horman <horms@kernel.org>
To: ruoyuw560@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	chandrashekar.devegowda@intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: wwan: t7xx: check skb_clone in control TX
Date: Thu, 11 Jun 2026 14:37:59 +0100
Message-ID: <20260611133757.587136-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609071556.5-1-ruoyuw560@gmail.com>
References: <20260609071556.5-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:horms@kernel.org,m:chandrashekar.devegowda@intel.com,m:haijun.liu@mediatek.com,m:ricardo.martinez@linux.intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298148-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2C76672621

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: wwan: t7xx: check skb_clone in control TX

This patch checks the return value of skb_clone() in t7xx_port_ctrl_tx()
and returns -ENOMEM if it fails, preventing a NULL pointer dereference.

> diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
> --- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
> @@ -106,6 +106,8 @@ static int t7xx_port_ctrl_tx(struct t7xx_port *port, struct sk_buff *skb)
>  
>  	while (cur) {
>  		cloned = skb_clone(cur, GFP_KERNEL);
> +		if (!cloned)
> +			return -ENOMEM;

[Severity: High]
If we return -ENOMEM directly here when skb_clone() fails on a subsequent
fragment, does this discard the count of successfully transmitted bytes
accumulated in cnt?

If t7xx_port_send_skb() previously succeeded for earlier fragments, returning
-ENOMEM to wwan_port_fops_write() will leave userspace unaware that partial
data was already consumed. Will userspace then retry writing the entire
buffer and duplicate the already-sent fragments on the WWAN stream?

>  		cloned->len = skb_headlen(cur);

Simon says: I have trimmed the remaining issues flagged in the AI-generated
            review as I believe that they are pre-existing and do not
	    warrant being considered in the context of this patch.

	    However, you may want to look over them on sashiko.dev
	    in the context of possible follow-up separate to this patch.

