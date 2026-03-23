Return-Path: <netdev+bounces-270659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCo/MFCFwWn+TgQAu9opvQ
	(envelope-from <netdev+bounces-270659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:24:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EFD2FB3A9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79FA6300D0EB
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AF63AF647;
	Mon, 23 Mar 2026 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arfznNLk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2DE3BF69D
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290253; cv=none; b=mkwpGdlYos4eEeW5ZIS46nocGyC2VhlWxwJFERX8S3Hn4C1Ly7+iBMQKPADeCe66qnvhA+SuQPa5JCxMMs5w5ZRGSbPfc245k9V3FlI9m16+KNBL0hksr8CTNAi5SXA+h/rEbidtQLKRib6azmxNLg0jpHyK5I0tZjY1wxc2AZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290253; c=relaxed/simple;
	bh=6UtWPnVfvsKBmtqMaCXhb9lkfRopD3ME5ghIo3ATN7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8lZqpXxFp/FAMSRdloyp1q07sw8WAYMBFtM6SgcWmdHxj+X2xAiZzN/c2gVODmnFg6b+HljUVtzvMFxuJngUyO/HS5LcEDP0RiQHAkUHEIVvr+NTd6ml9NlKm9KFKKtuBL1/EDJ3I7vJbF/JLS/vG2wJYpw/hJw8hPjInv8bAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arfznNLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D9FC4CEF7;
	Mon, 23 Mar 2026 18:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774290252;
	bh=6UtWPnVfvsKBmtqMaCXhb9lkfRopD3ME5ghIo3ATN7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arfznNLksLiodP849hsjgHXzwF9CMZc9Sl2KFxCAxlpi9Ov8p3uhYhaQauD56VYR/
	 1WCsTTEGDfhlvlzvkHClyR7+KZswFD55AXJCF0KvpGHN3xGm++ay2Xuu+MVow0w5I6
	 6hm2BQtQkz6cgkyuriXuf7wqlyWQ0u4b8hJ34eogdDlGAqAtNJNI8le/sMDSA26NMA
	 gR+6NFmHSbOJpnw3EF/Fgcj8Q3ekqsB3ymJzqEWLUjumlu1myHV6jW/U4A8/I521wo
	 KTgbl1Y8DDxVivGNW3fUzEVxFM3PR9SomXMUhwqFL2UX9UcMv8+Kr/cK2FR5hsAZvc
	 Zq0lCZp5Jf6dQ==
From: Simon Horman <horms@kernel.org>
To: weibunny.kernel@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	weibunny@fb.com,
	daniel.zahka@gmail.com,
	bobbyeshleman@meta.com,
	kuba@kernel.org,
	davem@davemloft.net,
	dw@davidwei.uk,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH v7 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Mon, 23 Mar 2026 18:24:05 +0000
Message-ID: <20260323182405.177135-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322040704.991766-4-weibunny.kernel@gmail.com>
References: <20260322040704.991766-4-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270659-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,fb.com,meta.com,davemloft.net,davidwei.uk,lunn.ch];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 79EFD2FB3A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
psp: add a new netdev event for dev unregister

This commit adds a netdev notifier to handle device unregistration events
and clean up PSP device associations when the associated network device is
removed.

> diff --git a/net/psp/psp.h b/net/psp/psp.h
> index 0f9c4e4e52cb..fd7457dedd30 100644
> --- a/net/psp/psp.h
> +++ b/net/psp/psp.h
> @@ -15,6 +15,7 @@ extern struct mutex psp_devs_lock;
>
>  void psp_dev_free(struct psp_dev *psd);
>  int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin);
> +void psp_attach_netdev_notifier(void);
>
>  void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
>
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index 178b848989f1..db4593e76fa7 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c

[ ... ]

> +/**
> + * psp_attach_netdev_notifier() - register netdev notifier on first use
> + *
> + * Register the netdevice notifier when the first device association
> + * is created. In many installations no associations will be created and
> + * the notifier won't be needed.
> + *
> + * Must be called without psd->lock held, due to lock ordering:
> + * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_lock
> + * and takes psd->lock).
> + */
> +void psp_attach_netdev_notifier(void)
> +{
> +	if (READ_ONCE(psp_notifier_registered))
> +		return;
> +
> +	mutex_lock(&psp_devs_lock);
> +	if (!psp_notifier_registered) {
> +		register_netdevice_notifier(&psp_netdev_notifier);
> +		WRITE_ONCE(psp_notifier_registered, true);
                                                             ^^^^

What happens if register_netdevice_notifier() fails? The function ignores
the return value and sets psp_notifier_registered to true anyway.

register_netdevice_notifier() can fail with errors like -ENOMEM or errors
from replaying existing device registrations. If registration fails,
psp_notifier_registered will be permanently set to true, preventing any
future registration attempts.

This means the notifier will never be registered, so NETDEV_UNREGISTER
events will be silently missed and PSP device associations will never be
cleaned up on device removal.

> +	}
> +	mutex_unlock(&psp_devs_lock);
> +}
> +
>  static int __init psp_init(void)
>  {
>  	mutex_init(&psp_devs_lock);

[ ... ]

> diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> index aa60a8277829..44e00add4211 100644
> --- a/net/psp/psp_nl.c
> +++ b/net/psp/psp_nl.c
> @@ -515,6 +515,13 @@ int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
>
>  	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
>
> +	/* Register netdev notifier for assoc cleanup on success.
> +	 * Must drop psd->lock to ensure lock ordering: rtnl_lock -> psd->lock
> +	 */
> +	mutex_unlock(&psd->lock);
> +	psp_attach_netdev_notifier();
> +	mutex_lock(&psd->lock);
> +

Can dropping psd->lock here create a use-after-free window?

The pre_doit callback psp_device_get_and_lock() obtains psd via xa_load()
and holds psd->lock, but does NOT take a refcount on psd.

When psd->lock is dropped here, psp_dev_unregister() can acquire both
psp_devs_lock and psd->lock, complete teardown, and call psp_dev_put()
which drops the refcount to 0:

net/psp/psp_main.c:psp_dev_unregister() {
    ...
    mutex_lock(&psp_devs_lock);
    ...
    mutex_lock(&psd->lock);
    ...
    xa_erase(&psp_devs, psd->id);
    ...
    mutex_unlock(&psd->lock);
    mutex_unlock(&psp_devs_lock);

    psp_dev_put(psd);  // can trigger psp_dev_free()
}

This would trigger psp_dev_free() which calls mutex_destroy(&psd->lock)
and kfree_rcu(psd, rcu).

When this function then calls mutex_lock(&psd->lock), it operates on a
destroyed mutex and logically freed memory. The post_doit callback
psp_device_unlock() would then call mutex_unlock(&psd->lock) on the same
destroyed mutex.

Should a refcount be taken on psd before dropping the lock, or should the
notifier registration be moved outside the doit handler?

>  	return psp_nl_reply_send(rsp, info);
>  }

