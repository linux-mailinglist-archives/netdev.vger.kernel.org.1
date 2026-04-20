Return-Path: <netdev+bounces-279838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH7hOBhN5ml2ugEAu9opvQ
	(envelope-from <netdev+bounces-279838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:58:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5994F42EC37
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FAC23262228
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB03DA5C0;
	Mon, 20 Apr 2026 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0pRKIpyv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70283ACA5D;
	Mon, 20 Apr 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695626; cv=none; b=mK9oEgIYzKqxNtM1duj0OtIUB9rd2RkKqhx4X+iWOXXuk84F9M8EMxCfQ6hRDYpSumPz5Cf+4ebhuFCKSQs5FvUg6WrVFKqpAaFAuxFZRG6cWTFhYcZ4cCaU3TVZCLMNEEeDujubDpnJsol/xZqPzJGXb8H3izs1d+PMbYVrt+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695626; c=relaxed/simple;
	bh=5VNt5d/Rj3TQtbF/G929i6xQ263tWkNbpDHl42ZoGPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6sZfWQ5K1cIcEBM7D6p+tVvgMz50muWS3G7QT2Ty+Cp+6nL5jErpPmNye2VdtgdvlHznhiJcppEP/kLiZyFb/I9ekBiadF+wxINXs6Uc1FewU1GoTwceqFhp/GlEqkHN+X7RQjLmIp0yNKGaBAb7JZZZ5ThMMmGokXFRMjZdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0pRKIpyv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HJKWn6JSj62WtPK8ZMsBh+npt0ENGYrQyvDCJMS4J+o=; b=0pRKIpyv76Ha6w9TKCNUOG6Dwj
	1nC9nhFjRtZN+EnXnQBLbh4NxViydJO6a03XKL7s8tsZQpN8ggndCUOlUacR65c7YJRhyozKkzQRx
	iWtPpbJKCgkaVPsz6Ce19qpvaL0WVyRG2hFcbxjymy/u4UV8ier/y/XNpDRaSSVJUc1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wEpgq-00GlJd-4A; Mon, 20 Apr 2026 16:33:32 +0200
Date: Mon, 20 Apr 2026 16:33:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch net-next v1 8/9] r8169: move struct ethtool_ops
Message-ID: <58e35713-1403-48fa-bc49-efc4e9995b0a@lunn.ch>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-9-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420021957.1756-9-javen_xu@realsil.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-279838-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:email,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 5994F42EC37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 10:19:56AM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch move struct ethtool_ops, no changes. Prepare for next patch.

Commit messages are all about "Why?". You normally move code because a
local function is after where it will be called from. I assume your
next patch is going to add a function which will be listed in the
ethtool ops, and it calls a function which is currently after the
ethtool ops. Please name names.

    Andrew

---
pw-bot: cr

