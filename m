Return-Path: <netdev+bounces-252146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDaEBoOLcWkLJAAAu9opvQ
	(envelope-from <netdev+bounces-252146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:29:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A5660E9A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0C514637F7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E5D364EA5;
	Thu, 22 Jan 2026 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gov3llv5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B533624DD;
	Thu, 22 Jan 2026 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048724; cv=none; b=emmpVSicyTYbsiMKVDYz+yxIcJTppLS7fEs1bZ38rqKT0UNrLcgjuS/eB3vLcs57hZfTvJdbXewaoxYHV5xIRl+rR4s0LGnCsODnyC9AlwWcR0+3s5kJnfx3R1Bzkoa3APZ+bbdoj0W25qKzwdgYZ4zW/IdkkUcT2HNZUGuDSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048724; c=relaxed/simple;
	bh=ZVrwz1n/6/cA1e8BUwInum98zNWz0Wc8/4HPBjovpvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFGS/pCXfloqRlnHuBL8fFvllqVxF3pl1mVPCthprKDYcFEfQBW5HKG4IM/lFEMFoFGe+CcP9yGBSWrsdgP8CgCZuGsnRa/RUZLHj4c2R+zhnTGLlke946ijJWnPmQNQb/Kc3tXD3tawTqmHgjOClNhPaCq7JABwVDr3B/BOC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gov3llv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4D1C116D0;
	Thu, 22 Jan 2026 02:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769048723;
	bh=ZVrwz1n/6/cA1e8BUwInum98zNWz0Wc8/4HPBjovpvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gov3llv5MafRqBt6mv51GsxhArImpZtDrb2yClr7PjZAZBGLnQL7bOd4Z9l71PwEZ
	 GCM2Ul/neVZLpnX+ODbUirIZ5Z60O4yYOTIoAOPC0sOVBfzn8X+UGMwqGpBzCLVQDC
	 ELcVtK7Ack3tbGV3DCB5ogKDF+D/67W68Dlo8/5OXQ9J0eWBz4CNZa8Owho5a0UWAG
	 v3XPvV9AxCRyYiW1Huej4EgSl4Nkxx0XWdisN4oPeQLtvYoQEmJD6PtwrRkCNBQpGl
	 oPJqmyUYBu+u4U8DqX7+X2A4n02eaeidSMm6GoLLcQBnCme08+fLpCqzwfOyMForlK
	 WETY5GyqVutuw==
From: Jakub Kicinski <kuba@kernel.org>
To: hkelam@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,PatchV3,2/2] Octeontx2-pf: Add support for DMAC_FILTER trap
Date: Wed, 21 Jan 2026 18:25:21 -0800
Message-ID: <20260122022521.2531255-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120100341.2479814-3-hkelam@marvell.com>
References: <20260120100341.2479814-3-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252146-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: B7A5660E9A
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
Octeontx2-pf: Add support for DMAC_FILTER trap

This patch adds devlink trap support for DMAC_FILTER, allowing users to
monitor packets dropped by the DMAC filter via the devlink interface.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index a7feb4c392b3..2fafdf405c33 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

[ ... ]

> @@ -3282,6 +3282,10 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (err)
>  		goto err_mcam_flow_del;
>
> +	err = otx2_devlink_traps_register(pf);
> +	if (err)
> +		goto err_mcam_flow_del;

If otx2_devlink_traps_register() fails here, the error path jumps to
err_mcam_flow_del. However, otx2_register_dl() was called earlier in
otx2_probe() and succeeded. Should there be a call to otx2_unregister_dl()
on this error path to avoid leaking the devlink structure?

Looking at otx2_remove(), the cleanup order is:

    otx2_devlink_traps_unregister(pf);
    otx2_unregister_dl(pf);

But the err_mcam_flow_del path does not call either of these functions.
-- 
pw-bot: cr

