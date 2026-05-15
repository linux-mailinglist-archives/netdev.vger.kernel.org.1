Return-Path: <netdev+bounces-288128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEKAGQhoBmrOjQIAu9opvQ
	(envelope-from <netdev+bounces-288128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:25:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60339547FFB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 431C73038E69
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FE42236EE;
	Fri, 15 May 2026 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiT7ulLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D18221FB1;
	Fri, 15 May 2026 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804490; cv=none; b=kEDXVoPolcPs63fBrRCzfDA+7/YWl6iCUeX2bW+6eRXBIlmTQ7xckjuzKaPaUs9vWDDM6zPZCBmR7Gs/QuwVel0udsq/AE39pDFAB2s26oxk2Ytv8AQzhxzUB2y2RFgqwGVoRruGEtQ6+9NzwCL7l7P2rFCi2spiZiyrobHrGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804490; c=relaxed/simple;
	bh=Geonpnf5rDoMCU8CrpajCyHwDYg8SoLR9V+hJ/XOLxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0d7gCZBT7hsQSLKFjWqYw7UDO6EjXL1IzmY4PoZOkuEf3O49JZMcuQfuDHkD1zY+xCP6TqcvcDfab5bolEMrXr+Bfr9BllSQZ9ZjHjpG9YJYtNe7A43DY8sUD09nRndOFSItkKPNg/F9L5A8/TzqH05W7Fxx3O+BJeYM6Zmsgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiT7ulLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6D5C2BCB3;
	Fri, 15 May 2026 00:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804489;
	bh=Geonpnf5rDoMCU8CrpajCyHwDYg8SoLR9V+hJ/XOLxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BiT7ulLO/P3AnwJ8HHpnTuYp25WrtDoKeNxzxBHUiBVuLX3zE712XVtX/hLNE0FmU
	 DLGym4cbO6cCjCkOCoRj2Jwr681JCqJ1NC60klXy9O4syeHYPbMHaeChuIVgqMjMUP
	 MawCYfX1z0z7bYwEDGEi+JNFU0IzbjNArLczpoVJBJzMKYeot3rFll3i5/ChxASe1a
	 mYbB36MOxPeK8K5GC8OHNMMIneK1G29Ys+fnZCHeoTCIcgdKEP6L4pYL71OclD/Q2O
	 +87CFlANlCZ/Z2nFClvTGQ94lr8pV+b3b7fN4wHisGMqVhJEbS96tC1Z73qlbnc35k
	 xbVAJi+MLoj0g==
Date: Thu, 14 May 2026 17:21:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v3 5/7] r8169: add support and enable rss
Message-ID: <20260514172128.41093a07@kernel.org>
In-Reply-To: <20260513115543.1730-6-javen_xu@realsil.com.cn>
References: <20260513115543.1730-1-javen_xu@realsil.com.cn>
	<20260513115543.1730-6-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 60339547FFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288128-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 19:55:41 +0800 javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support and enable rss for RTL8127.

Still doesn't build cleanly:

../drivers/net/ethernet/realtek/r8169_main.c:5203:24: warning: incorrect type in return expression (different base types)
../drivers/net/ethernet/realtek/r8169_main.c:5203:24:    expected unsigned int
../drivers/net/ethernet/realtek/r8169_main.c:5203:24:    got restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5205:24: warning: incorrect type in return expression (different base types)
../drivers/net/ethernet/realtek/r8169_main.c:5205:24:    expected unsigned int
../drivers/net/ethernet/realtek/r8169_main.c:5205:24:    got restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5264:26: warning: cast to restricted __le32
../drivers/net/ethernet/realtek/r8169_main.c:5278:34: warning: cast to restricted __le32

Install sparse and build with C=1, please.
-- 
pw-bot: cr

