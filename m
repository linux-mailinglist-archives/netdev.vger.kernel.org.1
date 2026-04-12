Return-Path: <netdev+bounces-277897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFJMHa8D3GlhLAkAu9opvQ
	(envelope-from <netdev+bounces-277897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:42:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BBA3E5ECB
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77DE0300950D
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEA235E92B;
	Sun, 12 Apr 2026 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlvbPZWo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472351FF1B5;
	Sun, 12 Apr 2026 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776026540; cv=none; b=J9zPGNYR9FjPzAwaqUMFecuCix9w7eSGHb8tmvgqQrE8XlGLJvlNh6oaVEqw/8zOvCkg8xESVDx/HtXi7W1IbBE9/WCxEsUrZkfD663qxl7PigIemRPfWBWLLnPSl8Csv/gjMQ1unlFOAaw5dDMflYiK+FxFkX90RBEflpTxCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776026540; c=relaxed/simple;
	bh=kp6v/f+WGcJoy66Vc9hyvdOsfcFEN7l+a/SVKPij08E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCWJ+6txdHGKCuK+tIJAA934sWDPOLc8cdfkqmUyLixt7kfd5/ATQeItp7FolxG7AjIG1q39HjY2LU4mLCAqmu0bwyzLBxm+P/iXOeMMxkkoQwaaQa5xhn0zp9LZrA0Dzt/ifXjNOPVC6/aBtRTNVVvAzJENTXFsqoAWvVPI6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlvbPZWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915FCC19424;
	Sun, 12 Apr 2026 20:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776026539;
	bh=kp6v/f+WGcJoy66Vc9hyvdOsfcFEN7l+a/SVKPij08E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PlvbPZWo/OZ27PLZgaa2QMXhBDkarTMVr44Zw1ognmnCK2fJ/lzTlsiS0aF44zGgW
	 +AQStzzd7YE8IaDEPsd0ZjrS+9z82r7uNLxf/uG7BeC23KJqjRdLUIJN+ScwAGVuGc
	 2dDvPTibMD1vhr+HShCUDcfYAJ0nlKn8TmqibFkY0G1kpzIGgyS2Er1KcUHeIdNb5I
	 SRHnj4vSAhpkxCFLfArry570iyXhjdJHDOdbdSuJYDXlylnJrp4nOq0NJT1dC8HbF6
	 jyOaCY88LGH44vfdmB6fdtkhJq94aK1Yx4/bHfZzhLdC06pgYCNR92Y55ph+nDmBi/
	 3zsQkuqo1pMjg==
Date: Sun, 12 Apr 2026 13:42:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: hci: fix OOB heap read on short HCP frames
Message-ID: <20260412134218.34cbe88d@kernel.org>
In-Reply-To: <20260409150825.2217133-1-ashutoshdesai993@gmail.com>
References: <CANn89iKq=oQOmvDtK-Vtr7r9yrD29cURgv8VOJ15mFHyJ0kXmw@mail.gmail.com>
	<20260409150825.2217133-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-277897-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2BBA3E5ECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  9 Apr 2026 15:08:25 +0000 Ashutosh Desai wrote:
> Suggested-by: Eric Dumazet <edumazet@google.com>

As Eric mentioned elsewhere - he did not suggest any of this,
merely reviewed your submission.

> +++ b/net/nfc/hci/core.c
> @@ -134,6 +134,10 @@ static void nfc_hci_msg_rx_work(struct work_struct *work)
>  	u8 instruction;
>  
>  	while ((skb = skb_dequeue(&hdev->msg_rx_queue)) != NULL) {
> +		if (!pskb_may_pull(skb, NFC_HCI_HCP_HEADER_LEN)) {
> +			kfree_skb(skb);
> +			continue;

How did a broken packet get enqueued in the first place?

