Return-Path: <netdev+bounces-261115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGgbBJaln2lfdAQAu9opvQ
	(envelope-from <netdev+bounces-261115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:44:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 943D219FE91
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46DC53068255
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59F31CA50;
	Thu, 26 Feb 2026 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFRek2wk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843B3EBF34;
	Thu, 26 Feb 2026 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070161; cv=none; b=F1Cy8nTt+BEK1BssxDR1rRnOW0XSR6zLji+Bs+wQMpUnyccV4FergiJ13Zg0kdZPyfsVa2dR70sU4Gn7GXt+i/opLduRGWz2pxjqZkaW2zgzypQSz0N43erdbgQY080u2LufdoefO2MOdc42LoOXbEEqcF9zyl74DeBM1Fo9cC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070161; c=relaxed/simple;
	bh=KphSeiCZB+3nIyNt+E4lIkJVuwWpcQFBGOMlGdcXzao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIDt9ti6VYMHZew71BZ9+8pYNSI312aGy6H+6G7vVSxeki7d0y764KYltfsEvODz4/yQPpCTIOuepyTIj2gG3LSCbkg8AW7QlAkiNjAMAYQcpCBgJVa2pQAsNk+FY1l0d8XcqJj7YtO4UDV83jhOxEMp2oHD3piyeIKugR+KbCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFRek2wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1950AC116D0;
	Thu, 26 Feb 2026 01:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772070160;
	bh=KphSeiCZB+3nIyNt+E4lIkJVuwWpcQFBGOMlGdcXzao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZFRek2wkocVC45U4gxOpQxBkMvOMq1M31L9OCTMR/Y6OqQftccSOO6qgOSgKHqMqT
	 dxFYyTXnu+b2yHNtLou7ztp+6pBzeUFltxloGj0KafiUI640FtzVWXvluqm7rLbnTc
	 VV+SLJLnZxDxrKeXQUjMaN8lHDmSfayIri2RhvRX3qNBM94tprT36YjPutYklBNwGQ
	 BNjUv70HLapw4S+AGFaom2CevM3rxWLIU0AX46k+PSR8zK5uEp6VN4W+vt2C28JQN8
	 M4ZQ2Fyhd5PMJohf/kILt0gppD/BXU5/K8fvBJLAOFDYE0y2g9r0m24t9GbmzZQ92G
	 8+qGNgvFewuLw==
Date: Wed, 25 Feb 2026 17:42:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Wei
 <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH v7 RESEND net-next] virtio_net: add page_pool support
 for buffer allocation
Message-ID: <20260225174239.7a8933e6@kernel.org>
In-Reply-To: <20260225044910.1328791-1-vishs@meta.com>
References: <20260225044910.1328791-1-vishs@meta.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261115-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 943D219FE91
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 20:49:10 -0800 Vishwanath Seshagiri wrote:
> Use page_pool for RX buffer allocation in mergeable and small buffer
> modes to enable page recycling and avoid repeated page allocator calls.
> skb_mark_for_recycle() enables page reuse in the network stack.

Would you mind holding off v8 until tomorrow mid-day (and rebase then)?
There is a conflict coming in from Linus'es tree, if you post v8 today
it will most likely not apply tomorrow :(

