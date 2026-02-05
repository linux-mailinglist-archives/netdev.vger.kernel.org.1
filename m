Return-Path: <netdev+bounces-256947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFXLIsIZhGk1ywMAu9opvQ
	(envelope-from <netdev+bounces-256947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:17:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C0FEE7B5
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81E3F300598C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 04:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD601DF258;
	Thu,  5 Feb 2026 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBoRPhDF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED713A258
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770265024; cv=none; b=OXoxRjjaamZGar/ftZ8S44MvejI2vfhNs7uPLT3BJ7+ok8HhowdGC4sQrsKLF7iy4Dp2IKwCBjsFPMuKFW8+lB5Ud9MWGnrL7KhKWlbtu+h3jsnwFCBW8UbM8P2SCWOPgziihLgPITaqUMPJ8/AOqqOadi5j/BwTXehnyo4Kq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770265024; c=relaxed/simple;
	bh=aIt0ANf7j4c2lq4PQ8ZNQCu1LfCE/SAYgeS2+nQn6T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvJ4uLlu2O9WErggGULRXvsdrYV3cHmSPeSOziJnUDEhSWpyBL3NYcopx2IP+UYUUQnUxNTgStnREEhijVX/kE2FsS1DG0FrjhEDymZOQearmnJXUTvcsbkWUggrOwexAG+jiPTFOCg2JIsL+yJ4j5+gDHArqm6I4WpJXctnIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBoRPhDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49913C4CEF7;
	Thu,  5 Feb 2026 04:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770265023;
	bh=aIt0ANf7j4c2lq4PQ8ZNQCu1LfCE/SAYgeS2+nQn6T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBoRPhDFJmLR1qc/+UAMI6lyGE7FKokKQfmfRaJ4Y0ioS+ei/UXmaY48CySYvLvFC
	 zByC0/+F5KmKnOot35KJvcHpOny+fapFVhyY2q9B9t+HASC4L/EY8fs5skSeY24WnQ
	 zis0qp+mvQC5kycNemhqJAhQxSDgfObBB212MCtSSYYFlC640N35KWm3dCsaHkkk4F
	 48EAIjg8HVrneCrwvaYrL0VIeqa09Ml//C5fibDcNvppy+gvh/5VD1FO185mQ2AyDQ
	 M/mULjPYFk9SiOk4Fu+BA8DvqjeQTd0ksqbNzlRiVrvy50Np7HDGHXavx2gbOYHiQz
	 0CBdvtu91F+4A==
From: Jakub Kicinski <kuba@kernel.org>
To: haokexin@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horms@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	elfring@users.sourceforge.net,
	byungchul@sk.com,
	andrew+netdev@lunn.ch,
	h-mittal1@ti.com,
	danishanwar@ti.com,
	pabeni@redhat.com,
	m-malladi@ti.com,
	jacob.e.keller@intel.com,
	rogerq@kernel.org
Subject: Re: [net-next,1/2] net: ti: icssg-prueth-sr1: Remove unused workqueue
Date: Wed,  4 Feb 2026 20:17:02 -0800
Message-ID: <20260205041702.2354424-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204-icssg-prueth-workqueue-v1-1-9a892f4b293d@gmail.com>
References: <20260204-icssg-prueth-workqueue-v1-1-9a892f4b293d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-256947-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 32C0FEE7B5
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: ti: icssg-prueth-sr1: Remove unused workqueue

This commit removes the dedicated workqueue emac->cmd_wq from
icssg_prueth_sr1.c since it is not utilized in this driver.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -783,11 +783,6 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	emac->prueth = prueth;
>  	emac->ndev = ndev;
>  	emac->port_id = port;
> -	emac->cmd_wq = create_singlethread_workqueue("icssg_cmd_wq");
> -	if (!emac->cmd_wq) {
> -		ret = -ENOMEM;
> -		goto free_ndev;
> -	}

[ ... ]

> @@ -883,8 +878,6 @@
>
>  free:
>  	pruss_release_mem_region(prueth->pruss, &emac->dram);
> -free_wq:
> -	destroy_workqueue(emac->cmd_wq);
>  free_ndev:
>  	emac->ndev = NULL;
>  	prueth->emac[mac] = NULL;

Removing the workqueue creation here is fine for the SR1 driver's own error
path, but doesn't the shared cleanup function prueth_netdev_exit() in
icssg_common.c still call destroy_workqueue(emac->cmd_wq) unconditionally?

void prueth_netdev_exit(struct prueth *prueth, ...)
{
    ...
    pruss_release_mem_region(prueth->pruss, &emac->dram);
    destroy_workqueue(emac->cmd_wq);
    free_netdev(emac->ndev);
    ...
}

Since emac is zero-initialized from alloc_netdev_mqs(), emac->cmd_wq will be
NULL after this patch. Can this cause a NULL pointer dereference in
destroy_workqueue() on module unload, since destroy_workqueue() does not
check for NULL?
-- 
pw-bot: cr

