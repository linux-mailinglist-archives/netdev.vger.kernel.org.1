Return-Path: <netdev+bounces-266572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJF3IIw9sWmtswIAu9opvQ
	(envelope-from <netdev+bounces-266572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:01:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A7F261A1B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38329305B3AB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA39033FE09;
	Wed, 11 Mar 2026 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rLziUR6F"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4FA2BF3D7;
	Wed, 11 Mar 2026 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222714; cv=none; b=JJQ2eenaRioFC4xhUv0ADaUz9xET6QXnOGmtj0GJIBtZGuPnRElda5v6fg8PTr1FB6jRC7aPr/HeUYzAX8kzLkbvC1zYW5/Tvn7GZyu3V+SyG1/1RjFOa/7vcz59SPTM+8lq8VfHUsiHEN5gZLUcHL4keR7K+Ci4RzzTArsQcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222714; c=relaxed/simple;
	bh=cExnAvTRQL08xCRWa7TIxAepcmjcrHtyoskiV8BvuKw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bXSjfXihK7J8LD9eaoxGdsHGTAA3DL1aYhUF2z4I+yWVSPeVdgCTIk/zkt7Aq0EpUyrVbOtsLvWmzHNwqI5TVi8F4Dhak8FdRHTA7ngXTeBb8DzRjJZS9d83eaPLgj676zgPuSWRnLDkp+p5AQe9Tl+xdTVYVopXs+WM2a9YBgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rLziUR6F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BYxECjAf/3z/8zbu3rDMRNzt6GWu02sPG+fcCTbQXIc=; b=rLziUR6FlAwwuEYG98evTchBwE
	WkkP9qvK3fhbwYIwgiBRHMpm5X8AQX4IC9uw+rWeMr5OjpHregu59mi8HU/MGqRKtky7ajYoRqo1f
	Vods+WFxMq9uIuqae3HMAFf9QmauWopQKgQsXLeO0EsOXexAImCaeesz/p3WlL50lGvlbmEL5iRIW
	ogZwmybG7APdq32S0MAK/T+I8WoVbYNAHdAdz3vbleFhbUqfmxblL064+KpGIwkhue6Pwb0YZjIft
	OaDQKQN7q1o0q0D9rkLfr3pRJ4dZhL2Mb2o2AlNSmmaeEPXrmLtQdQ+azvvpelTRGZ/ekzIMNv29s
	7l3TGTSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57338)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0GEE-00000000662-0oAE;
	Wed, 11 Mar 2026 09:51:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0GE9-00000000692-1IDS;
	Wed, 11 Mar 2026 09:51:41 +0000
Date: Wed, 11 Mar 2026 09:51:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next 00/15] net: stmmac: clean up descriptor handling
 part 1
Message-ID: <abE7LWj04-JNxgS2@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: 85A7F261A1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266572-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,shell.armlinux.org.uk:mid]
X-Rspamd-Action: no action

Hi,

Part 1 of cleaning up the stmmac descriptor handling. Rearrange the
struct stmmac_tx_info to pack better, and introduce helpers for
duplicated code handing the transmit and receive descriptors. Remove
unnecessary struct members that are only transitorily used.

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 458 +++++++++-------------
 2 files changed, 194 insertions(+), 272 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

