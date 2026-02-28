Return-Path: <netdev+bounces-262190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOriID5Oo2nw/QQAu9opvQ
	(envelope-from <netdev+bounces-262190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:21:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B391C8426
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 066393300556
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812BF345CAE;
	Sat, 28 Feb 2026 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIwXg469"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D56F33A03F;
	Sat, 28 Feb 2026 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301891; cv=none; b=d6fq5YOCmxWcwN8XKYqSLLYsRvq/abGPTZG/v0luau2iceFypHjryAMgvfM1f1J6Cct4c2bZaqS1T1/5m/i2R+3+saltDNy8DRW8T2YvTb3gX0YC7eH8PEHwHAZ32SOuN7LhtkNvJdYrPrLqdOMjAE9CqdleKHLCImXxRerCr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301891; c=relaxed/simple;
	bh=IyZ03u1C71sNfZ4iXYae0FRb/6Tl8yj5/uTpy5toIyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLQBbcwf+zjehRa5WBEEI+XYUanuWgf+OLJgmUR2fCQW9m5MCoSpwIZotRjZmlBkw/N6lyQ33N2AmFAFKTdWZ0Q8dkPHi1LKZRSakiQuA8jE+3/fQ4hc9SpWApKkltn11Nlr/fpNzEL+kmGc/Qjomg9B94ho+Olslqd8I23lHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIwXg469; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B69AC116D0;
	Sat, 28 Feb 2026 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301891;
	bh=IyZ03u1C71sNfZ4iXYae0FRb/6Tl8yj5/uTpy5toIyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mIwXg469l3LWltd1cE+Y5xaNRTGGrNzbjZDtIcbJamwSBIrY3nwx4bjgkLcFzGQMk
	 HdSSn8Wzasg9oBu5KLzbVxiQQ5At9BxCJ+bqaZQxXrwQHCuvPvD0WuAJQ8qP+hJkL1
	 EWNLi0BuE6Zlk+v/L8zJNUN8irbSA+xR5Vy378WgToKiqP9F/syWLdj81kANdf9vun
	 6AT36sXE4LtZnVzi5I1AYATeApyY4jlF/m+Sfzt5gOFI0WXFvQ1+kJXy5MZCfx6bGv
	 m39K5zL3vxQVgmfY84JB/R5nUbBiSE1yP/sscOc6hyrMLvV4y8L9ZwbmpP8MGvc96m
	 5bqNbKargBh1Q==
Date: Sat, 28 Feb 2026 10:04:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kiran Kella <kiran.kella@broadcom.com>, willemb@google.com
Cc: davem@davemloft.net, edumazet@google.com, daniel.zahka@gmail.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, akhilesh.samineni@broadcom.com
Subject: Re: [net-next, v3 1/2] psp: Support for transmit on logical device
 when the underlying transport device supports PSP.
Message-ID: <20260228100449.19f6ef13@kernel.org>
In-Reply-To: <20260226184654.3180648-2-kiran.kella@broadcom.com>
References: <20260226184654.3180648-1-kiran.kella@broadcom.com>
	<20260226184654.3180648-2-kiran.kella@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262190-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,gmail.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08B391C8426
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 10:46:53 -0800 Kiran Kella wrote:
> This is achieved by propagating the psp_dev from the lower device
> to the upper devices in the device stack via a netdevice notifier.
> The lowest device owns the psp_dev pointer while the upper devices
> just borrow the pointer. When the lower device is unlinked, the
> borrowed pointer is cleared in the upper device.
> Assumption being that psp_dev is set on the lowest device before
> any upper devices are stacked on that lowest device.

As I mentioned in the other thread I'd like to establish some clear
expectation on where psd propagates automatically and where it doesn't.
I don't want to see a stream of patches that say "fix propagating PSP
onto X upper". And conversely report saying "PSP got propagated but
it doesn't actually work" (macvlan in bridge mode etc).

Hence my preference was to require the user who created the device
to propagate PSP. Willem, WDYT?

> +/**
> + * psp_clear_upper_dev_psp_dev() - Clear borrowed psp_dev pointer on upper
> + *				   device
> + * @upper_dev:	Upper device that may have borrowed psp_dev pointer
> + * @priv:	netdev_nested_priv containing the psp_dev being unregistered
> + *
> + * Callback for netdev_walk_all_upper_dev_rcu() to clear borrowed psp_dev
> + * pointers on upper devices when the underlying psp_dev is being unregistered.
> + *
> + * Return: 0 to continue walking, non-zero to stop.

Please (tell your LLM) to avoid adding kdoc which restates what the
code does. For static function really kdoc is only useful if there's
something not-obvious to say.

> +static int psp_clear_upper_dev_psp_dev(struct net_device *upper_dev,
> +				       struct netdev_nested_priv *priv)

Please (tell your LLM) that the action goes after the object / noun.
psp_upper_psp_dev_clear() or some such.

> +{
> +	struct psp_dev *psd = priv->data;
> +	struct psp_dev *upper_psd;
> +
> +	upper_psd = rcu_dereference(upper_dev->psp_dev);
> +	if (upper_psd == psd)
> +		rcu_assign_pointer(upper_dev->psp_dev, NULL);
> +
> +	return 0;
> +}
> +
>  /**
>   * psp_dev_unregister() - unregister PSP device
>   * @psd:	PSP device structure
> + *
> + * Unregisters a PSP device and clears all borrowed psp_dev pointers on
> + * upper devices (e.g., VLAN subinterfaces) that reference this device.
> + * This prevents use-after-free if upper devices still have borrowed
> + * pointers when the psp_dev structure is freed.
>   */
>  void psp_dev_unregister(struct psp_dev *psd)
>  {
>  	struct psp_assoc *pas, *next;
> +	struct netdev_nested_priv priv = {
> +		.data = psd,
> +	};

reverse xmas tree
-- 
pw-bot: cr

