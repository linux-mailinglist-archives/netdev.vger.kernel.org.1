Return-Path: <netdev+bounces-272166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMoxIE5txWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:30:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B7A339285
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21366302803A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4049F41C30B;
	Thu, 26 Mar 2026 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIE9gC6C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD221C173;
	Thu, 26 Mar 2026 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546189; cv=none; b=E6aTkgoQIgnBai3YK8HislWGVpJmq51C1u9MkahCJuM8eTuHWgWy8V8yJvS1+5zQ4MQoNVIgIam+zPc4s2qpNxK52BEHVzNDrg2WtYeRJ9t0UDTnGWPJJNr7p7tpcCwhSXlGqB/3xegmGLxWLUfuEteVcqHZydekZfQ8dSiTlkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546189; c=relaxed/simple;
	bh=+1oNWwkOQNqPFvhgNYp/LhaQS4lNd0Ijc16A6Wr40VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAozFsnGCJFiN+F+5b96TgSUYodvAqcgHee05I6B2n8WqkinkSiwAlDBUUipJI6nrR6x0BZ5Ikfdc00lkQeyYpJogifDB6K4ZIJbHZV07KQjv3CI1JUsJWmBbI9j4L2sq+xEw+Bsx/Rr/fpZEJ3foX8rytETS8HcZUMYIV+sg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIE9gC6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF9BC116C6;
	Thu, 26 Mar 2026 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774546189;
	bh=+1oNWwkOQNqPFvhgNYp/LhaQS4lNd0Ijc16A6Wr40VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIE9gC6CRKFa3gJhsAbOAdhI5cxa7+OV5UzYRCYu4G/pOrB0cGkzcmTvUrL+/FBbN
	 1tOCKs/tIjNA1xaBTUww4zks7IdYSdQ4uOUwhK9wIbYHvyZKQuCBcwBc545xDP/NR8
	 PddxWnO21H75JtgNkorAIMByVCU/jRXG2ac5HzJdT0/WkLA6p8WRTV0RXRfHySkH/v
	 dFFIZMaNXoP4ObiZTCNyf7l3j3mhAwmJ80q3e/Xq0FLY3CPhQIk42fYPdroFGtp3Yu
	 vH8Ly8nnwDTm0BL4Al8TE8b9x+/wNffcoqEcWwZS4Qf/JUfRSArQcs5ShoLS243RWK
	 rfPH+4IP8zh5Q==
Date: Thu, 26 Mar 2026 17:29:43 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH net-next 1/2] net: stmmac: remove axi_kbbe, axi_mb and
 axi_rb members
Message-ID: <20260326172943.GR111839@horms.kernel.org>
References: <acJh4z3pRKkeaFbR@shell.armlinux.org.uk>
 <E1w4ydo-0000000Dlpb-34jd@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w4ydo-0000000Dlpb-34jd@rmk-PC.armlinux.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272166-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: C2B7A339285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 10:05:40AM +0000, Russell King (Oracle) wrote:
> axi_kbbe, axi_mb and axi_rb are all written, but nothing ever reads
> their values. Remove the code that sets these and the struct members.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Hi Russell,

FYI, AI review suggests that these fields should also be removed from
Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst

