Return-Path: <netdev+bounces-278794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBjOJ9Wg32kEWwAAu9opvQ
	(envelope-from <netdev+bounces-278794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:29:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7A64054BC
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBBFA30DA029
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE023D3D1E;
	Wed, 15 Apr 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFmQ67eu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8F3CC9EB
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263253; cv=none; b=brbl0ThP0D8qLhpgb8zxC5A9tc07JB0NW92iV3MLqSGegPIPCE/9INtExFmcQsAfbjz9GTLU+V9K3jtjibWAxrOBQINw+iBkfFhha+42T50szLpBwQW0k16pbfnmd7ieDUNLjgSME+DqeM1QPHZdAXqWnRpkKrbNAYvr3Iy3nT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263253; c=relaxed/simple;
	bh=oOIzZsC9lz45sjHKDaOFTn54Y2WN2iyBVliEwttc3p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS34rnPQehOuReIQ8Mvl4pLsJvGUYhmX/0S/g779fvdUNdJFxKhmyqEP38X5V1H3mLpVM7eWUcq1fuBvt4ZDVlzkJCz/BL4+OqWoh7omvB9vr23TP/mb2PuSJMbG27disPRe/zS5Qlmk/eVpIhRDbZuZSj7PD9RRKyZwXs66qhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFmQ67eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F04C2BCB4;
	Wed, 15 Apr 2026 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776263252;
	bh=oOIzZsC9lz45sjHKDaOFTn54Y2WN2iyBVliEwttc3p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFmQ67euydmOkj2SIqtOssQwxgGbwoLtM0v6UOvzw+h7J+cjZPVTrALSlYiaJ4qIx
	 MGdgG9SReiBeXp1OBLTAhdc5HfRT6PrQGMc06wkQxWlIv+LsjNmazUsd8IcmqvYTBn
	 v6YVRkA9A4MOzjljdA9pIb1Uuopx2PyMF5AmJ5GfFhhGQwsX8UjaW68rk6RilusnJc
	 fAfxn4YMJn7JdKpOWBo/CIGJmWoM0ML9ayRilcT5lOTiRFqqAjbXHNup103PA//cQD
	 o3A0W1pLIXa1WdSMH1qmSicsjthCZPWNLDjQ3+vHiKGOs04HDdMgrTvcdGEiLsw2us
	 BU8LWuEoCmHdQ==
Date: Wed, 15 Apr 2026 15:27:29 +0100
From: Simon Horman <horms@kernel.org>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [PATCH] net/sched: act_mirred: fix wrong device for
 mac_header_xmit check in tcf_blockcast_redir
Message-ID: <20260415142729.GL772670@horms.kernel.org>
References: <20260413084927.71353-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413084927.71353-1-phx0fer@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278794-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 1E7A64054BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 04:49:27PM +0800, Dudu Lu wrote:
> In tcf_blockcast_redir(), when iterating block ports to redirect
> packets to multiple devices, the mac_header_xmit flag is queried
> from the wrong device. The loop sends to dev_prev but queries
> dev_is_mac_header_xmit(dev) — which is the NEXT device in the
> iteration, not the one being sent to.
> 
> This causes tcf_mirred_to_dev() to make incorrect decisions about
> whether to push or pull the MAC header. When the block contains
> mixed device types (e.g., an ethernet veth and a tunnel device),
> intermediate devices get the wrong mac_header_xmit flag, leading to
> skb header corruption. In the worst case, skb_push_rcsum with an
> incorrect mac_len can exhaust headroom and panic.
> 
> The last device in the loop is handled correctly (line 365-366 uses
> dev_is_mac_header_xmit(dev_prev)), confirming this is a copy-paste
> oversight for the intermediate devices.
> 
> Fix by using dev_prev instead of dev for the mac_header_xmit query,
> consistent with the device actually being sent to.
> 
> Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


