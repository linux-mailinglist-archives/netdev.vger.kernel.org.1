Return-Path: <netdev+bounces-305392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pl2XCi7PTGpXqAEAu9opvQ
	(envelope-from <netdev+bounces-305392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:04:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3576471A187
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:04:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y0RDEDSd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305392-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305392-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBCE4308A007
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB3B3D952F;
	Tue,  7 Jul 2026 10:00:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7EE3C2BA8
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:00:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418445; cv=none; b=R1+xeC/TGwJ5Ef8HIjBr2kNiaItYlYqOhyfixcIErPsYEd4riIwbCsdWYPV7g+JIVA+epmhcwer8gp9LdNkuqwPL6mdKVTejxDBQ1/SUQW0qcu8rvQVj9pogzVAIdr9bS8d8iv+qfpyquu35m12EQiLkUfZ0ygR3TS76Okg8+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418445; c=relaxed/simple;
	bh=Bzh+PVRhjAYCF3zOJVFgAsMimYyWRW26rz7H7+sko0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nshRMAeZZKxm4VXNEeYTgAiOq/bIal5HN6Wji9XcESm0uUxNg5bYGtzlf55A35fHWXm9umRVsaibY71gTYSckY7mupdSbwUKusQd4xfNBQfVrw3w8PPiBPaRA5td6LmsoU20rzHa4i/sqEcWY/oDmh0KDkHiNeEbQ8JR+smgyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0RDEDSd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C641F000E9;
	Tue,  7 Jul 2026 10:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783418444;
	bh=RhpTsXogCidqVoSXLmz+o1vy0yYdauEaLLOvAGijMyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y0RDEDSdIVGo2L8WwALqV4bgmlbKZ03ydYlwd3awUf3vyZPvQFw7XuPUhCy/BAZZf
	 rjdnbTNq5n/sDlzJPzBkotAW3aEpSLeTuNRiTCwSDF/Ggfkf6g3HtiX+o+iXn6pESL
	 oRYMtEBQFgM5dxhliNC0KWe587GL6AgixmuTI0IaXiBb9JzLKH6dVlIFkJdzT6iJne
	 wo1aTHmB6KKxHPWcongZo/99RoNFlC1r/b7FmApk6oRA7/Tt/5yBJrEbyDHxnHv2mA
	 lcuDYXGUqca6/5jFmqpf5W6GKmR6sOJCMGOKT/M/FUhcsb/3OGDHciTK1rbLc0c20s
	 blSTsnt472VgQ==
From: Simon Horman <horms@kernel.org>
To: dddddd@hust.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com
Subject: Re: [PATCH net] nfc: clear active_target when the target list is replaced
Date: Tue,  7 Jul 2026 11:00:18 +0100
Message-ID: <20260707100018.1379850-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625111835.2411251-1-dddddd@hust.edu.cn>
References: <20260625111835.2411251-1-dddddd@hust.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dddddd@hust.edu.cn,m:horms@kernel.org,m:netdev@vger.kernel.org,m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dzm91@hust.edu.cn,m:hust-os-kernel-patches@googlegroups.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305392-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3576471A187

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
nfc: clear active_target when the target list is replaced

This patch clears dev->active_target, stops the check_presence timer, and
resets RF and DEP link states in nfc_targets_found() if the currently
active target's array is being replaced. This prevents leaving a dangling
pointer when the target array is freed.

> diff --git a/net/nfc/core.c b/net/nfc/core.c
> index a92a6566e6a0d..950807906645a 100644
> --- a/net/nfc/core.c
> +++ b/net/nfc/core.c
> @@ -786,6 +786,21 @@ int nfc_targets_found(struct nfc_dev *dev,
>  
>  	dev->targets_generation++;
>  
> +	if (dev->active_target && dev->targets) {
> +		for (i = 0; i < dev->n_targets; i++) {
> +			if (dev->active_target != &dev->targets[i])
> +				continue;
> +
> +			if (dev->ops->check_presence)
> +				timer_delete_sync(&dev->check_pres_timer);
> +
> +			dev->active_target = NULL;
> +			dev->dep_link_up = false;
> +			dev->rf_mode = NFC_RF_NONE;
> +			break;

[Severity: High]
Could this cause a regression by bypassing the required driver and LLCP
teardown sequences?

By directly setting dev->dep_link_up = false, any subsequent user-space
call to nfc_dep_link_down() will return -EALREADY early. This permanently
skips nfc_llcp_mac_is_down(), which leaks LLCP sockets.

Also, it appears the hardware drivers will never receive the deactivate
signal since dev->ops->deactivate_target() and dev->ops->dep_link_down()
are bypassed. Could this lead to a hardware lockup or denial of service?

> +		}
> +	}
> +
>  	kfree(dev->targets);
>  	dev->targets = NULL;

[Severity: High]
This is a pre-existing issue, but I noticed that nfc_dep_link_is_up()
accesses and modifies core NFC state variables locklessly:

net/nfc/core.c:nfc_dep_link_is_up() {
	dev->dep_link_up = true;

	if (!dev->active_target && rf_mode == NFC_RF_INITIATOR) {
		...
		target = nfc_find_target(dev, target_idx);
	...
}

Drivers (like pn533) call nfc_dep_link_is_up() asynchronously without
holding device_lock(&dev->dev). Since nfc_targets_found() and
nfc_target_lost() can free and reallocate dev->targets while holding
the lock, could nfc_find_target() iterate over freed memory if it races
with them?

Furthermore, could this lockless access allow nfc_dep_link_is_up() to
assign a dangling pointer to dev->active_target right after it is
cleared by nfc_targets_found(), defeating the safety checks introduced
by this patch?

