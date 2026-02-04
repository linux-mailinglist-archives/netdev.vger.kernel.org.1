Return-Path: <netdev+bounces-256516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOvnN62tgmliYAMAu9opvQ
	(envelope-from <netdev+bounces-256516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:23:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1360DE0CB9
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C83630142B5
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC702C027B;
	Wed,  4 Feb 2026 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHLe4e/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA672C026A
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171769; cv=none; b=Y7j+z0mvU+1QBbrj+HylZbtpMx2F+g6gRpMHTK0SPJhB8uUKxOWndzoFb7KxPdBydERk8rweEvTGHt6xLrWI7vI0o92t3mVCkRe0yb6nldBbhWfBRES+dcbqlXfSc5aB+tt9EH1DbfyT0doLYX1zhQs3uKJY6IK01GrEHzJxp+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171769; c=relaxed/simple;
	bh=0rjSqEan6d9aStSSDOHkRnG++RWuXn+VDoWuGFq/470=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2+o3QJWK+hqJqg5CZt/BrVi0+LytRwzQ5ismyGlvzXAksNCPVzSuudhRFVmp8ERwYDUclQ9mzXJwCdi5GeicRif5/mCIqeaB6JTp+NquGlUxq82RK1KpkkbZzcvX19WZP2w/YXX8bBfhhIKLc50aYLDFXKuh60/KxmYMSCk6X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHLe4e/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD13CC116D0;
	Wed,  4 Feb 2026 02:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770171769;
	bh=0rjSqEan6d9aStSSDOHkRnG++RWuXn+VDoWuGFq/470=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHLe4e/WqFc4BIVMho0iSOhWit7W5GdskXHGjeFP4vgKIAL96vDs8ril/WBS8b8nD
	 pemvtE0b8OenXCPB2i63XVIgZ88jU/4N5y7WjPWHFASd+CPfRuUbLWnAQg3RSBB10A
	 NUUf3oa2PCm7tFSNDBfFVRvJ/+o8qRwDasK1OINeXdiTA9b34tGjkR8vONlP9guvtS
	 YsiReuyCRMNn22Y5gf7q+evEQrZl738EahAlLLE7JdYuCU9qcFLRjv1ldTHRMEygcf
	 go3OKhOrIa0/MvyNCaKMKO4AyyErtm/hHnoZ856shwGTuDkYYsQKwmcoXvY0DC7/TK
	 llLJhfF6m0TmA==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	mengyuanlou@net-swift.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com
Subject: Re: [net-next,v1,3/7] net: wangxun: move reusable PCI driver ops functions into libwx
Date: Tue,  3 Feb 2026 18:22:37 -0800
Message-ID: <20260204022237.1572988-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203075759.5852-4-jiawenwu@trustnetic.com>
References: <20260203075759.5852-4-jiawenwu@trustnetic.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256516-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1360DE0CB9
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "Sending this out without checking since you have to
repost. Please note that the AI code review may be wrong especially
around defensive programming (which we recommend against)."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: wangxun: move reusable PCI driver ops functions into libwx

This commit refactors PCI driver ops functions (suspend, resume, shutdown)
from ngbe_main.c into the shared libwx library, adding function pointers
wx->close_suspend() and adjusting wx->do_reset() to support this.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c

[ ... ]

> +int wx_resume(struct pci_dev *pdev)
> +{
> +	struct net_device *netdev;
> +	struct wx *wx;
> +	u32 err;
> +
> +	wx = pci_get_drvdata(pdev);
> +	netdev = wx->netdev;
> +
> +	err = pci_enable_device_mem(pdev);
> +	if (err) {
> +		wx_err(wx, "Cannot enable PCI device from suspend\n");
> +		return err;
> +	}
> +	pci_set_master(pdev);
> +	device_wakeup_disable(&pdev->dev);
> +
> +	wx->do_reset(netdev, false);
> +	rtnl_lock();
> +
> +	err = wx_init_interrupt_scheme(wx);
> +	if (!err && netif_running(netdev))
> +		err = netdev->netdev_ops->ndo_open(netdev);
> +	if (!err)
> +		netif_device_attach(netdev);
> +	rtnl_unlock();
> +
> +	return 0;
> +}

Does wx_resume() need to return the error value stored in err?

The function assigns errors from wx_init_interrupt_scheme() and ndo_open()
to the err variable, and correctly skips netif_device_attach() when errors
occur, but then unconditionally returns 0 instead of returning err.

The early error handling for pci_enable_device_mem() correctly returns err,
but errors from the later calls are lost. This would tell the PM core that
resume succeeded when it actually failed.
-- 
pw-bot: cr

