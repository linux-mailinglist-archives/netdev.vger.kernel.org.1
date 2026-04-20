Return-Path: <netdev+bounces-279886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE+yBqVk5mkKvwEAu9opvQ
	(envelope-from <netdev+bounces-279886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:38:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C45431A8E
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4151B30054EE
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20513A6F0D;
	Mon, 20 Apr 2026 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9IKS28M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3D3A6EE0;
	Mon, 20 Apr 2026 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706721; cv=none; b=AIxpxfgXRqH1uGSaZSCDdvlc0L2uI3P0r102Oue8pB9otBDKaJYf+PyzVcMidJ7+45hQ8pnUxORwzYKtuFLk7oiBqJbu+fPTMLXwUZavOcnpRughbqNOfrUUI0d2wgQqNu/rp8fUqfM+9E2E3noKIkmiY0asPCQDLlCHnle4tp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706721; c=relaxed/simple;
	bh=+iB78qslZQP4oKGBKa7wsXpn6b10lPdY6xiEvvj/PCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3PcPSvcaP9G9VaKiOEGfnlxom3EteEhINKcasaT5emasNp7OEV/e+tcJT1XdY6R3jAgyTJCb23Uf9ve17CUwRQFQGNAWob0o2WoyQNaRk8xIQrEpm+CtnPNnl1rR7z6jngufxkrDKLdY9GejUprmKXudyskINR42+ZqYKYiT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9IKS28M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13335C19425;
	Mon, 20 Apr 2026 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776706721;
	bh=+iB78qslZQP4oKGBKa7wsXpn6b10lPdY6xiEvvj/PCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V9IKS28Mw2SXSTNgDy8nd+cOvueV2R/S7qd1kXGd1ErYLFXplKR52uNI4//T1q+/m
	 +N+bIogJyqPauTrE2CZZQcUtwUJ3oZfBcqqTqPElqOwU2JVoeGkU6Ew5FwilhE4Bii
	 U0zL2Vt5KoU/wmMx+zskPt9kHT40JgbcDHGN6dPLQ5jJbiScDkMLKeE7/ScOITwGRy
	 YW5D01fgA4FZ2H2tI17rWG4l6ir1Qbc1y8xv5CQ6gGxTtWrxr6A5j5h0fUGAL487qq
	 oRHM3GS190Ps63nqZAq8FXV20EwWuiTMN/QLL/giXYNBSwhDt269m1BRZA9axCuS5E
	 tHGKHgGgqqMNA==
Date: Mon, 20 Apr 2026 10:38:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Agalakov Daniil <ade@amicon.ru>
Cc: Jian Shen <shenjian15@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lvc-project@linuxtesting.org>, Roman Razov <rrv@amicon.ru>
Subject: Re: [PATCH net-next] net: hns: use u32 for register offset in RCB
 TX coalescing
Message-ID: <20260420103840.6a30683e@kernel.org>
In-Reply-To: <20260420144047.2846673-1-ade@amicon.ru>
References: <20260420144047.2846673-1-ade@amicon.ru>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279886-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8C45431A8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 17:40:19 +0300 Agalakov Daniil wrote:
> The local variable reg in hns_rcb_get_tx_coalesced_frames() and
> hns_rcb_set_tx_coalesced_frames() holds a register offset passed to
> dsaf_read_dev()/dsaf_write_dev(). Register offsets on this hardware
> are 32-bit values; using u64 was misleading.

net-next is closed during the merge window.

If you repost please improve the "why". As is I don't think this patch
is worth merging.

