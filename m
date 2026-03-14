Return-Path: <netdev+bounces-267772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH78Gh+PtWmX1wAAu9opvQ
	(envelope-from <netdev+bounces-267772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:38:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB628DF2A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68AF730157CB
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40530506A;
	Sat, 14 Mar 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="madEBiRR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925C1C84DC;
	Sat, 14 Mar 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773506329; cv=none; b=BieRB/i7PMZXBI4aXj0SrhgRWbs0BCms89ln5UAP+s6QcT9OrtBlRU0lpzlbaH0i7SfN+wYVfNj5xDlTm5OpfCClgnEGi7k8hdCicpDA87yTQhGr2DS5nyhBXMMIdLxea+BOFlAUL2AVC/4/dtQJ6668XhMCE6zhUpdmJJsVdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773506329; c=relaxed/simple;
	bh=Zk3nvbJgyIwDuexRaR19OiC+ZPEwPRntdVtEBhGXEEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFJISNenU2gQoKHWvDi6c6ndC0CtEOJwNYe0zK8SFzazrBbaewamVJXgL482vqAXL4Qbvtwep+yIZgxPtphPQKMg5rua/pDvhFG9E7f+iA1TwAtIKhPgBCGyZMKSsPQGk1ERTSH1TDzc5ptCpK78STOA/8afo81pryr3Bf7Qcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=madEBiRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89B8C116C6;
	Sat, 14 Mar 2026 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773506329;
	bh=Zk3nvbJgyIwDuexRaR19OiC+ZPEwPRntdVtEBhGXEEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=madEBiRRZ64jp9PCTXsImHcVOQcQQAd4XPsUXYntX861/vM1df7n+EZAWDW8BqThD
	 Z1cpE6ZXvhRUE+1nQFqoBlQtMYPy5DctTlZerNHBypY3r7kevVPazp7DMjPUiblpVH
	 kQ3WhElPBTB/z9nISfLv4Io5YpDMGjnscJEUsnHx/zoGdZfrFUoHWIthmNDpRKqohy
	 A81XOuXfCCZx3zfnpl8hGZZYZ7Wn4Hzwxl9NBKmgNr9mK4rk2NYAzxkcguFp8woBt0
	 jDiPZNaMQUpkzjhbpGSfv7cPyAdn5L11Rx9aqiVK511RF/g/KrVzOibdE8gPGXTp9J
	 k2E/fhTvAMPcw==
Date: Sat, 14 Mar 2026 09:38:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Rishon Jonathan R <mithicalaviator85@gmail.com>, Vincent MORVAN
 <vinc@42.fr>, Paul SAGE <paul.sage@42.fr>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tg3: replace placeholder MAC address with device
 property
Message-ID: <20260314093847.4904d26f@kernel.org>
In-Reply-To: <20260313060810.1314-1-atharvatiwarilinuxdev@gmail.com>
References: <20260313060810.1314-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267772-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,42.fr,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEDB628DF2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 11:38:09 +0530 Atharva Tiwari wrote:
> +static int tg3_is_default_mac_address(u8 *addr)
> +{
> +	const u8 default_mac_address[ETH_ALEN] = { 0x00, 0x10, 0x18, 0x00, 0x00, 0x00 };

Please add static as well. I think it should result in slightly smaller
object code.

> +	return ether_addr_equal(default_mac_address, addr);
> +}
> +
>  static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
>  {
>  	u32 hi, lo, mac_offset;
> @@ -17103,6 +17110,10 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
>  
>  	if (!is_valid_ether_addr(addr))
>  		return -EINVAL;
> +
> +	if (tg3_is_default_mac_address(addr))
> +		device_get_mac_address(&tp->pdev->dev, addr);

Shouldn't we return device_get_mac_address(); IOW return an error if
device_get.. failed?
-- 
pw-bot: cr

