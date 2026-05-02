Return-Path: <netdev+bounces-283444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NBjNRcx9mnKSwIAu9opvQ
	(envelope-from <netdev+bounces-283444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:15:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E44B3008
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25CD8300BC9D
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B180C382F10;
	Sat,  2 May 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnRwgJ3Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8334F48A
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742101; cv=none; b=EdKyw6se+glA09FacbACsFE11MVxq0Cjmhg+cFcOFgN1Rltcu9ntv8WlC+p7jCuj7ee3bL7E1tU4gS8/N1vrA4wF8kEfHIgjeexXq/w5eA2OzRxBqf3ia/UPXmisNnlk/fQX8A+Z4sb6vTU5EXistsWPCEaUMRhHB1bPqwWyMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742101; c=relaxed/simple;
	bh=OXaAjo67SbYNrCeiFpKv/+MBUhbwES7JSeMF/GAOe4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozzGrAnOfm5jDPu8AuBBpduj195HJ+A2/OjsRuffImsO2FIwOtDEwTdZTmbAUpbQWxeI3uLsg/xJosnnh0ARoQVzyW1xlalpO+fYQxqgKwlQGEtNNf7kdZhf8yeSgYq+DoRarsSRvb2SmlNE4IkQ84s4DH0D09DoV8X8z1CLF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnRwgJ3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D487EC19425;
	Sat,  2 May 2026 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777742101;
	bh=OXaAjo67SbYNrCeiFpKv/+MBUhbwES7JSeMF/GAOe4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bnRwgJ3QZH2XBbWLr4/CJCtiFD7a+PwFtEg5RievyY6FXoHmjy5hwpKFmfAOHTdDS
	 dATsN2mRYNJ+qTgT5COpQkpMPARzzZ3NzoqofanfJyTYV3Mv7+wSY9seWhzxVwnKQd
	 Htd9+gsl3MuLwJSZCdaH/AqIjcZ96U9mdwEXnJf5BxhlcoJ2zgapWLfm3iyAYXBE7R
	 5Ni6cHodsGfNWv/H34cgdyHzy3svjO+eRWiG52tTHHm4gE30qRhPyL2OnkKvb2ci2u
	 9/KnigW7+9K7rNUBztQUyZcVEhdQOae1VYZEIg7EJIfEkmpph7o5mzFXa7sDeIA3s0
	 73BY4wXlcxXOA==
Date: Sat, 2 May 2026 10:14:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch, chleroy@kernel.org,
 qiang.zhao@nxp.com
Subject: Re: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
Message-ID: <20260502101459.46e9de13@kernel.org>
In-Reply-To: <20260501122756.GB15617@horms.kernel.org>
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
	<20260501122756.GB15617@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 621E44B3008
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283444-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On Fri, 1 May 2026 13:27:56 +0100 Simon Horman wrote:
> Fixes: ca20e191eed0 ("net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove")

This appears to be a SHA of the second patch in some local tree.
Supposedly the correct tag is:

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")

