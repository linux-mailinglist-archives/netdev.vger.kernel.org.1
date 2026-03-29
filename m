Return-Path: <netdev+bounces-273007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ErzMX2IyWnYywUAu9opvQ
	(envelope-from <netdev+bounces-273007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:15:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A73A353F19
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ADC3301DB98
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C6388E59;
	Sun, 29 Mar 2026 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQtNixdh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313F8388395;
	Sun, 29 Mar 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774815224; cv=none; b=ZitJsPJj37PN5zJ1UZ1Z7w1FxoVwZ65ECIqEHJHuVEEBmqn557PEysGm5YYc42i2Z3L3g78ebdqlw59p027u9PrrFrNIpHhxO+p1DY5qqXTswLMVGGFX/jTBOtmA+P/QEuHHcXtgcpByqlVwreKef3N1L2CYidzlxjGiKTwgkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774815224; c=relaxed/simple;
	bh=T/O+vv2XveEGA6Le7/8sDkNwlM6qWIJXUFYyD1pzCjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1JXk/Bsazgk6v1F/JvwquKZLqZ7qwZVN0kYnGpP1Mzend2aIcrzH23MYamtnYl/9ZWEtcoag39Tvq3mKI/nAImzd3DpC2mdgDDuhSpaJYVM/VXr/XfZHWXvQibfcq/EuxI9cOxOSzcIzkFm1Fek8RbN9g2KIBfFbjhoA8Mq/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQtNixdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB6CC2BCB1;
	Sun, 29 Mar 2026 20:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774815223;
	bh=T/O+vv2XveEGA6Le7/8sDkNwlM6qWIJXUFYyD1pzCjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQtNixdhqQ4SVcnDTKZQENdsG/z5uQnfTjzbs2qOuOKxD3D8/yKVabN8eFiJsDhA+
	 Mo5OQjGwSjLuliVcFo6S24xarAxWRbMlu57LPZSN0Ljh8229FVhGE4pTJdb85Y6pii
	 kbVyxIn15HRB7bgjl8AokSExx5VEPRFrmDHRSvnCTJneVQPVRD48i+Av6WD5FRW51d
	 Px88KJIK42qG2YYtdlUzuYcXpYS0/NorGtyrFQjANeo2yJ3JOv2hP9X7ir9k9AsdFy
	 nQPlePYKcdVz4EvHTJftfjrwWKoDTFFzLSntfpEP0sjXRbb6U6912l/HBYa/H1tLta
	 jnSJeE8qHDSmg==
From: Jakub Kicinski <kuba@kernel.org>
To: devnull+satishkh.cisco.com@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/6] enic: detect admin channel resources for SR-IOV
Date: Sun, 29 Mar 2026 13:13:42 -0700
Message-ID: <20260329201342.2798773-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-enic-sriov-v2-prep-v2-6-f72cf716ebfa@cisco.com>
References: <20260325-enic-sriov-v2-prep-v2-6-f72cf716ebfa@cisco.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273007-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,satishkh.cisco.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A73A353F19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: detect admin channel resources for SR-IOV

This commit checks for the presence of admin channel BAR resources during
resource discovery and sets has_admin_channel when all four are available.
It also adds admin WQ, RQ, CQ and INTR fields to struct enic.

> diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
> index 67fd780b1fa1c..08472420f3a1f 100644
> --- a/drivers/net/ethernet/cisco/enic/enic.h
> +++ b/drivers/net/ethernet/cisco/enic/enic.h
> @@ -289,6 +289,13 @@ struct enic {
>  	u8 rss_key[ENIC_RSS_LEN];
>  	struct vnic_gen_stats gen_stats;
>  	enum ext_cq ext_cq;
> +
> +	/* Admin channel resources for SR-IOV MBOX */
> +	bool has_admin_channel;
> +	struct vnic_wq admin_wq;
> +	struct vnic_rq admin_rq;
> +	struct vnic_cq admin_cq[2];
> +	struct vnic_intr admin_intr;
>  };

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
> index bbd3143ed73e7..5ca3e5aec7f93 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_res.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_res.c
> @@ -205,10 +205,17 @@ void enic_get_res_counts(struct enic *enic)
>  	enic->cq_count = enic->cq_avail;
>  	enic->intr_count = enic->intr_avail;
>  
> +	enic->has_admin_channel =
> +		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_WQ) >= 1 &&
> +		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_RQ) >= 1 &&
> +		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_CQ) >= 1 &&

Is it possible for the hardware to provide exactly 1 admin completion queue?

Because struct enic allocates two admin_cq entries:

    struct vnic_cq admin_cq[2];

If the firmware only provides one RES_TYPE_ADMIN_CQ, this check will pass,
but later initialization of admin_cq[1] might access memory past the end of
the validated memory-mapped I/O boundary.

Should this check be >= 2, or use ARRAY_SIZE(enic->admin_cq), to ensure
both queues are backed by hardware?

> +		vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1;
> +

