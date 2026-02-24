Return-Path: <netdev+bounces-260629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDShK37vnWncSgQAu9opvQ
	(envelope-from <netdev+bounces-260629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:35:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 487B818B76A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1770B3038D26
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C698E39E6C1;
	Tue, 24 Feb 2026 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohbS1LS2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3983239567;
	Tue, 24 Feb 2026 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958138; cv=none; b=SELpXQ2GdO/RRp/vnvLm+ltHouRV14fTCP8qt0t0lMBpIef/eY11CjFqZ6TED24wEOoRo5ARo2qPpfWJjPPhuLEiHjlghlwPnY3fNlHK4F+GrgHHuOneBgOUvY3KOvOCIkfIFc/yGBGyg0Su5FCNmEefjCxv0rZc1Aa0vBLUpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958138; c=relaxed/simple;
	bh=BSt0iiyTZn334qTMV+2QOzuxLnz0S68wPCAJfm8wFYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3eCSZEsXnvY7IEsbMJIeqaai+LABpORQCuhlnr6ixK0nexfkKSO5g+ccEucYbK0WeiRPxx5g93Rw2pDf5Z2g0zTpk4BFlDDWk955wVpPzrR8ebrNAktPaHr37tj/7hsumEiVsu/dAKns3XFyqJnN0XIOY5d6+AZxTZ/dMTc5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohbS1LS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE63C116D0;
	Tue, 24 Feb 2026 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771958138;
	bh=BSt0iiyTZn334qTMV+2QOzuxLnz0S68wPCAJfm8wFYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ohbS1LS29lyv+8jYPBJeLGYH03CKMTE37haxLVlDe7v8SZiAQRLOSIlPioJTdB4wb
	 VrPYBMPoIQSaIMxmezGdGGa3D5iDX3d124h7jR3H41WG14LoPO17qk8vV2L/tbBcsu
	 TDGQNCpUAFRQvXDQOBrceo2/rRInzmZp/RmbjbGlnnLHKqNAgR77F5fflgg4zZ8nt4
	 SaH5RJlwwlWwNP5GYpMdawgtaOyx1KtfYDfFTanwIlLAX9m+Xf6gFHpUrs+RFpsYct
	 X+ungUMzOF6VcOG1xZzPeyhxz2L3j+QjQb7712O4B2ZwZrSWAFWeV46Hb1w2PNi0Iz
	 SsRqbynQxQ/BQ==
Date: Tue, 24 Feb 2026 10:35:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v9 00/13] NPC HW block support for cn20k
Message-ID: <20260224103537.4eed8e8b@kernel.org>
In-Reply-To: <20260224080009.4147301-1-rkannoth@marvell.com>
References: <20260224080009.4147301-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260629-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 487B818B76A
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 13:29:56 +0530 Ratheesh Kannoth wrote:
> v8 -> v9: Addressed Jakub comments.
> 	https://lore.kernel.org/netdev/20260204182428.05a77b13@kernel.org/

v8 was 20 days ago. You replied to the review comments _today_ and then
immediately posted v9. This is very frustrating, because corrections
I suggested in the reply to v8 obviously can't be part of v9. Making v9
pretty much useless. If you can't follow common sense rules of
engagement with the community we will not merge any of your code.

