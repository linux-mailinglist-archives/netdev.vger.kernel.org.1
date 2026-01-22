Return-Path: <netdev+bounces-252203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKw9JpWmcWmjKwAAu9opvQ
	(envelope-from <netdev+bounces-252203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:24:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FB061B31
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2428387119
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D233F23C7;
	Thu, 22 Jan 2026 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vusac/0u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AC50097C;
	Thu, 22 Jan 2026 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055579; cv=none; b=QdZH504P89Rk4aDHu7W+tDmpez8FcmkLlS3FjNRAgnYSkL2zKaRDPTkm+/dDDk4XLX1DGY5c9vyRjIfkj3zCYc3ty2qEkpYtj6bVV8MSwi6GvbjXVTa0edRd9AlrnrVu3Ldni7HXqH41bbSAo8fGPXAbBb1nG4QFSYsqZyxFzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055579; c=relaxed/simple;
	bh=jmxUYwY7zFdJSBRPhS/5oEPKw1pHQ+7ywrjh/m9nv1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXcXrDCAil4C0SPf5B5uzvjgw3hfg9NFM7pWfcg2l9jQdE2Sf6LiiKDE1qXzCzuKTVazzspM0zMYr6SP8emwelY9RfScYrxuyypREsM8uadAV7d1Pxagfh4lJAl32IKxJeugtuPjOwm2N8z4Dpv7KfV05p2iO2g/rUSDU+iHhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vusac/0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A416C116C6;
	Thu, 22 Jan 2026 04:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769055579;
	bh=jmxUYwY7zFdJSBRPhS/5oEPKw1pHQ+7ywrjh/m9nv1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vusac/0usYrrM3mdCLhDV0MnS4Uv6JyShSfr5QDfbyn8jnh9Pk3jwk8OaBzHJbBUf
	 5CCuOETzqbp+Y8cSgXzGbVPJ+m3oWH81tT49ocuH09WJ/lFJbWc/HZoqzL1V5v1fNQ
	 Yc8B9nPx453Pz9fWbwuqbWVNun5BeAtPSp/Vd+LTXraeBXGw+i8TQs2omnYAVgLO8y
	 da7quhnQhgSKp/5RZv44k/hpAZ2p+M2ZoT7N501T4xKknQm/QdBO7Nz0J127Q6Xzg7
	 lCUBcGC/9FO8RtPMChImaIP8JaoXZ80lcJqtcXOZdkNvUsS+b+a2Z3k7Kn3Re7w/uJ
	 4Xa5v92dMNxcA==
From: Jakub Kicinski <kuba@kernel.org>
To: kiran.kella@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	ajit.khaparde@broadcom.com,
	jayakrishnan.udayavarma@broadcom.com,
	netdev@vger.kernel.org,
	akhilesh.samineni@broadcom.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: Re: [net-next,1/2] psp: Support for transmit on logical device when the underlying transport device supports PSP.
Date: Wed, 21 Jan 2026 20:19:09 -0800
Message-ID: <20260122041908.2602647-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121073517.3323332-2-kiran.kella@broadcom.com>
References: <20260121073517.3323332-2-kiran.kella@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-252203-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: 43FB061B31
X-Rspamd-Action: no action

Haven't had the time to think about this TBH but FWIW:

This is an AI-generated review of your patch.
For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
psp: Support for transmit on logical device when the underlying transport
device supports PSP.

This patch propagates psp_dev pointers from lower devices to upper devices
(e.g., VLANs) via a netdevice notifier. Upper devices borrow the pointer
without taking a reference, and the borrowed pointer is cleared when the
link changes.

> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index a8534124f626..0bff50c9314d 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -313,10 +313,124 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>  }
>  EXPORT_SYMBOL(psp_dev_rcv);
>
> +/**
> + * psp_netdevice_event() - Handle netdevice events for PSP device propagation

[ ... ]

> + * Propagates psp_dev pointer from lower devices to upper devices when
> + * upper devices are created (e.g., VLAN subinterfaces).
> + */
> +static int psp_netdevice_event(struct notifier_block *nb,
> +			       unsigned long event, void *ptr)
> +{

[ ... ]

> +		/* Get psp_dev from the immediate lower device */
> +		psd = rcu_dereference(dev->psp_dev);
> +		rcu_read_unlock();
> +
> +		/* Propagate psp_dev to upper device if found */
> +		if (psd)
> +			rcu_assign_pointer(upper_dev->psp_dev, psd);

The commit message states that borrowed pointers are cleared when the lower
device is "unlinked". However, what happens if psp_dev_unregister() is
called on the lower device without first unlinking the upper devices?

Looking at nsim_psp_rereg_write() in drivers/net/netdevsim/psp.c, it calls
nsim_psp_uninit()->psp_dev_unregister() without unregistering the netdevice.
If there are upper devices (e.g., VLANs) that have borrowed the psp_dev
pointer, would they be left with a dangling pointer after the RCU grace
period completes?

Similarly, nsim_destroy() calls nsim_psp_uninit() before calling
unregister_netdevice(), so the upper devices would still have borrowed
pointers when psp_dev_unregister() frees the psp_dev structure.

Could this lead to use-after-free if an upper device's psp_dev pointer is
accessed after the underlying psp_dev has been freed?

Would it make sense to either:
(a) Document that netdevice must be unregistered before psp_dev_unregister()
    is called, or
(b) Walk the upper device stack in psp_dev_unregister() to clear borrowed
    pointers, or
(c) Update existing callers (netdevsim) to ensure proper ordering?

> +	} else {

[ ... ]

> +	return NOTIFY_DONE;
> +}
-- 
pw-bot: cr

