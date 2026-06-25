Return-Path: <netdev+bounces-302043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U66DBvhaPWr01ggAu9opvQ
	(envelope-from <netdev+bounces-302043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:44:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808346C7873
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:44:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b2v21fIA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302043-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302043-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8564A3016832
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5451E3090C1;
	Thu, 25 Jun 2026 16:44:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48821234973;
	Thu, 25 Jun 2026 16:44:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782405877; cv=none; b=bEjyCb0y/cZmMTT1SUorg4o1JsEKwGdY2Uzq2K63Tl6qNhD2h0/qdK4pcUMSAxyUv6ovVGDgeROEmDi5tW0iIKaxF3DNLbS5c2lmVIxza65IgooYUPzqQOxCAJo7Fso8k8xxGFhZF3TXqaDmdBIfQ7DdbfKgjlambHpvW4OK6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782405877; c=relaxed/simple;
	bh=kNt9QrFfh80uOPSfI9Nt2YZ0FsaXnE0dmAZBxM7411U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD9VSmZUhsewpK9+a/36NcdgNGViK9sxcwY7DCCZYPr/5TJDGyyFbQtnckVRsqIj6KilOjE52z14Olzq9mU0Dy97OsxBCTFfXzoZsdkdShDfaluEyIZatgBWEut9XFnfBCKR6Swr7mmU/2hKRlGYhws12gFxiLszbcBB3Az1wwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2v21fIA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A588D1F000E9;
	Thu, 25 Jun 2026 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782405875;
	bh=yYoSG8Q0/z3dVqwDUiXME2MGOAvB0sQt1yyfNt3ktMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2v21fIAG6oZt2/0Rh2Hb6vWLmm7ugzOp2s3LcD6KD089EUqgR/QL5tM7lk/+48xC
	 DLgfgTFVlemA4ONOgx/H5H6pEDMHYjTB+D8X7maz3wkDVUS93Xz+E+Nr7Y9q1nyM7p
	 u/yb6OkoAsGLDsWxARPg9WKk/C+b+Icu9jBRV0NE5vctzrF0CgwRP8wCUw90oKzTaY
	 e5ub5sfxjeHmobRM9kt/DZax66oCLPkEUEzS4giPYMYQ25xZ3L6DiNoMBCaf/SZFpG
	 SwNjKTtGWvGpvf8FW4zuj73fZvzRPfukfB8Vtr05lOw0aY8GfcGkZCAXkG58DNKNee
	 oxrECx04jyPsg==
From: Simon Horman <horms@kernel.org>
To: zhaojinming@uniontech.com
Cc: Simon Horman <horms@kernel.org>,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sean.anderson@linux.dev
Subject: Re: [PATCH v3] net: fman: fix use-after-free on IRQF_SHARED handler after probe failure
Date: Thu, 25 Jun 2026 17:42:37 +0100
Message-ID: <20260625164237.1222477-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624094922.2971930-2-zhaojinming@uniontech.com>
References: <20260624094922.2971930-2-zhaojinming@uniontech.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302043-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:horms@kernel.org,m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sean.anderson@linux.dev,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 808346C7873

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: fman: fix use-after-free on IRQF_SHARED handler after probe failure

This patch fixes a use-after-free in the error path of read_dts_node(). It
manually releases the registered IRQ handlers before freeing the fman
structure, preventing the devres cleanup from leaving a registered IRQ
pointing to freed memory.

> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> index 013273a2de32f..ba2338da0cea1 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
[ ... ]
> @@ -2786,7 +2790,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
>  		if (err < 0) {
>  			dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
>  				__func__, fman->dts_params.err_irq, err);
> -			goto fman_free;
> +			goto free_main_irq;

[Severity: High]
This is a pre-existing issue, but since we are modifying the IRQ error
handling here, could the shared interrupt handler crash if it fires during
this setup phase?

Just before this snippet in read_dts_node(), devm_request_irq() is called
with IRQF_SHARED while fman is still partially initialized. Since fman was
allocated with kzalloc_obj(), fman->cfg and fman->fpm_regs are NULL.

If a shared interrupt fires immediately, fman_irq() is called:

drivers/net/ethernet/freescale/fman/fman.c:fman_irq() {
        ...
        if (!is_init_done(fman->cfg))
                return IRQ_NONE;

        fpm_rg = fman->fpm_regs;
        pending = ioread32be(&fpm_rg->fm_npi);
        ...
}

Since fman->cfg is NULL, is_init_done() behaves like this:

drivers/net/ethernet/freescale/fman/fman.c:is_init_done() {
        if (!cfg)
                return true;
        ...
}

Would this cause fman_irq() to bypass the early return, proceed with a NULL
fpm_rg pointer, and dereference it during the ioread32be() call?

>  		}
>  	}

