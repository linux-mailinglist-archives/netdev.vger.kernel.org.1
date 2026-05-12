Return-Path: <netdev+bounces-286908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Jl6JqeHAmpXuAEAu9opvQ
	(envelope-from <netdev+bounces-286908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:51:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537651877E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43B73075B92
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43922287263;
	Tue, 12 May 2026 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXNjczXo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161A2E413;
	Tue, 12 May 2026 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550259; cv=none; b=e+lHdzVsZoSaz/vEg12AXtJ16P+GWWN9sxg5IeCPcSQRN57zaFM55Y7MMkrWiwYkZDDbYGfhBg3uRXnpH78aE+u3db5hJBUwpjqYSBUsCj+O+DcPkeSicR+fNIEkAEX6NcJ7gJvYNt+nYNmVbpJZMJbUZCvrnSEBnR57D3HhiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550259; c=relaxed/simple;
	bh=2oLZ9HEDZfnXFOu7F8sA78Z5EORJO9MgqxSmpKyTdNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNjm4NRjDIF5HqAV8NFE3BfAgyL76LeaLeADZ/kaGajWt2U81AB6ZX5b8xMHQuwvn2WMrY/dWu5EI70ls/CTg9knxgZIM4oKsi2Soc14Zl8DFkdhZDN80ee8eyhMJ3buHrq/17oCWQz+jySO8S+U1ZNpRQxUS5MsRRBhSj1DW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXNjczXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424D2C2BCB0;
	Tue, 12 May 2026 01:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778550258;
	bh=2oLZ9HEDZfnXFOu7F8sA78Z5EORJO9MgqxSmpKyTdNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SXNjczXohtXwgbXcFivDdz7+xN2lOFepOQQiZZFLMHpQEUMI2HFd8LBzcRisLQeTb
	 fGnXyt6jyyXEY9xoLb0Dyz+YqhfgC0Ns40Bd/f9LFb382m3/6eut4cDOGJ8xv/0BPX
	 qMTvnwSTh421JeES8isZQkAHMnHj9ThlOz/eUzbbpXOusO4Pl2A0mTLahuOlVsywjN
	 SzW1A46KcQiz/gNNmdYW9ktAmCLuvgdyVn/41HwTrIsw35fSQK+sk66gENCj7J+7hg
	 RUK8egVCU/YmGNC8dl8j+NmDTRRzhsrZI4tnyF8klFy//L0nFmGcN8WMTnVi2z/LN+
	 cwHdoOQ3YPxrg==
Date: Mon, 11 May 2026 18:44:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v2 5/7] r8169: add support and enable rss
Message-ID: <20260511184417.03f810dd@kernel.org>
In-Reply-To: <20260508121802.2010-6-javen_xu@realsil.com.cn>
References: <20260508121802.2010-1-javen_xu@realsil.com.cn>
	<20260508121802.2010-6-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3537651877E
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
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286908-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 8 May 2026 20:17:59 +0800 javen wrote:
> This patch adds support and enable rss for RTL8127.

Building with C=1 exposes:

../drivers/net/ethernet/realtek/r8169_main.c:5242:24: warning: incorrect type in return expression (different base types)
../drivers/net/ethernet/realtek/r8169_main.c:5242:24:    expected unsigned int
../drivers/net/ethernet/realtek/r8169_main.c:5242:24:    got restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5244:24: warning: incorrect type in return expression (different base types)
../drivers/net/ethernet/realtek/r8169_main.c:5244:24:    expected unsigned int
../drivers/net/ethernet/realtek/r8169_main.c:5244:24:    got restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5303:26: warning: cast to restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5317:34: warning: cast to restricted __le32
-- 
pw-bot: cr

