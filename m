Return-Path: <netdev+bounces-299617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id imOqHWxnMGr1SgUAu9opvQ
	(envelope-from <netdev+bounces-299617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:58:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B06C68A134
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:58:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="TQ6Vr0B/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299617-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299617-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 874A6300722D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1AA3B585C;
	Mon, 15 Jun 2026 20:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46883B42CE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:58:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557094; cv=none; b=Lrt3LYdOR8EOHE7GBJFJXirTC7EpIhF0mTuXG6GPsF6P2zMGwR+PNRqK8MPP1jG94zrh4KKSTLoW8Ttu1HxMPfyGb0uPj/Gn9DS+tYJ/m6QxXfkMrLzjpuzpgDUQClRzfR0AYvlEk4Thg6ZnVbFQiuIsg4i7a4Ubh44UqLr62Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557094; c=relaxed/simple;
	bh=UXSjJ8PjM65uSLxlz58RIRFwrovnsMYdMnC/FIeIuIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiXDZVXlzxx7L6Q1GNvtBvUdB464cIiJW+zPrF4zp2NRsdMuLpJxESIT/mS5cIWM6RSdGDg5fLq9nFYMjfA2Q/1/wZ+Lzdo00qxmzo9XA5JQB9+G491CGmEQPmRmXz0gFV2hiQzgE67pwNrcGcXUyD77RhyeT8V/lorqtbQRbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ6Vr0B/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C05A1F000E9;
	Mon, 15 Jun 2026 20:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781557093;
	bh=zUd+W0FeD1SqLu0YbyUslyjd0iunVCVN9DkSX/L7Qg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TQ6Vr0B/WeRQ7w6uAS6excLt3874l2jBGtvnmKRfC9FcOF3WmHYvKOTPGdXCkT7Hh
	 ZfUxc88fRZFRzbwb7ACqZwmbl9QtcZuswFxfd7HSx+mbn+s46HxaVWWZ+SavEfJZB/
	 ixpUWEd0TgdPSWdzP2G0wQRcQptKuVsaRmpk2hGEp/MLUR5mSWJznT/sycwyzJPnDp
	 s4g7P2M4YN+GxMc/bhgTAGH1+nj1izrlvyMQ+dYgtXx45NovtMCu9JeAGzt0uQjl+3
	 qDF7MI+riNRiZ0orpurcARrfvUT6u24eusQxJ+k3yUuUCoMdv3KbCBAbBqfXoSYc+s
	 o+rCBIFSSKh/g==
Date: Mon, 15 Jun 2026 13:58:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v3 12/15] bnxt_en: Support kTLS TX offload by
 implementing .tls_dev_add/del()
Message-ID: <20260615135812.5663998b@kernel.org>
In-Reply-To: <20260614072407.2761092-13-michael.chan@broadcom.com>
References: <20260614072407.2761092-1-michael.chan@broadcom.com>
	<20260614072407.2761092-13-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299617-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.chan@broadcom.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B06C68A134

On Sun, 14 Jun 2026 00:24:04 -0700 Michael Chan wrote:
> Add basic infrastructure to allocate and free kTLS context IDs (KIDs)
> to support kTLS TX offload.  To offload a connection in .tls_dev_add(),
> the first step is to allocate a KID.  After that the kTLS offload
> command is sent to the HW via MPC using the function
> bnxt_xmit_crypto_cmd() introduced in the last patch.
> 
> In .tls_dev_del(), we send the delete command to the HW using the
> same bnxt_xmit_crypto_cmd().  After that we free the KID, making it
> available for new offload.  There is extra logic to handle ifdown,
> FW reset, and device reconfiguration while deleting the connection.
> 
> bnxt_ktls_init() assigns bnxt_ktls_ops to the netdev and sets up
> the TLS TX offload feature.  bnxt_ktls_init() will be called in
> the next patch.

Warning: drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c:320 expecting prototype for bnxt_free_one_ctx(). Prototype was for bnxt_free_one_kctx() instead

