Return-Path: <netdev+bounces-253549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEgNLK+ed2kCjQEAu9opvQ
	(envelope-from <netdev+bounces-253549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:04:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D968B41A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 425993002B74
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6EB335547;
	Mon, 26 Jan 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obr9O4M1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDCF27B358
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447083; cv=none; b=NlsxYe+0PmuLIKrIBj9eCGLwFvEClaLbJVnyiGQzfUleIAaXn/spBTOT4O9Kwpkz7UcDnt5NCKXzyok2GY3dl8P7HCULCJ57x0YSHJQBomD8UkyE1HNJ0diy2tF3NYLxYXmCHtvTKMq0gEB9G4q14yiKl9kk4RSMl39cZhoeeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447083; c=relaxed/simple;
	bh=Q1NoHrO1ZQky5deC5cWXZqkEivHkThu9bvM7bFYoSU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7Oenk1Kz6lHJnfVFNsC7zuqHDx0PlSmzB4Vtm44eXJ6ntrngIVNJM72PPvoqxuKG01vASpvTawZ/g31JdW4EkILotCqcV0b6obRYv82fagbuGfZsFHfWkCb5wDPJFBb6wjRFpwnz+WkkmlFy6gmd3nya9zf1o9MqlE5+4xFrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obr9O4M1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00037C116C6;
	Mon, 26 Jan 2026 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447082;
	bh=Q1NoHrO1ZQky5deC5cWXZqkEivHkThu9bvM7bFYoSU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Obr9O4M1qcMdaZwPhgpTcLZN/x9GDS6EvcTqnnqFdVwZk0LTyvNmRZnc12x9tCng2
	 UTr98PzaLsuOuQ6QgPSnqI/KFiXWCsiTCRLytTQqjTnhT79Spx4/tO76L7BH7IjShw
	 MaGXbeJBxSN1XIVnHVYZpXqzmIpCUiQMe/8f5CUHabIvzjb1u69Ltm28eaxdbp8sid
	 PiHUIBu+whN47sYa+ixPMyMpH0hjYgfJyVDZfy9UX+xJsgVHFOxF4quxS0iJQS/oDj
	 4G13RLh3XCtjs43W1srPXiwaZc55JnYalQkm5mNZwhUXejRPofp3NL2rhyiDLedPCK
	 ZMKMrEdjg12gQ==
Date: Mon, 26 Jan 2026 17:04:39 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Javen Xu <javen_xu@realsil.com.cn>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add support for extended chip version id
 and RTL9151AS
Message-ID: <aXeepzcnU2wf05_h@horms.kernel.org>
References: <a3525b74-a1aa-43f6-8413-56615f6fa795@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3525b74-a1aa-43f6-8413-56615f6fa795@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253549-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realsil.com.cn:email]
X-Rspamd-Queue-Id: 99D968B41A
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 10:27:24PM +0100, Heiner Kallweit wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> The bits in register TxConfig used for chip identification aren't
> sufficient for the number of upcoming chip versions. Therefore a register
> is added with extended chip version information, for compatibility
> purposes it's called TX_CONFIG_V2. First chip to use the extended chip
> identification is RTL9151AS.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> [hkallweit1@gmail.com: add support for extended XID where XID is printed]
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


