Return-Path: <netdev+bounces-277570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPGME6ti2WnhpAgAu9opvQ
	(envelope-from <netdev+bounces-277570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:50:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDFC3DC903
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D21300C037
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691C3A63EC;
	Fri, 10 Apr 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyVIhkT8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F93644D4;
	Fri, 10 Apr 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854193; cv=none; b=ONNAPJaM1NiE4Kg/yFrYOJI3w56JAoZrpx6dWb5RWAIvqfhtcOAhapyoxefQMmTXTYsRsvd//nAfG7tr7J+hcQvnJKJw/pvHYwE7bfLWIPVzmIuyA4Op+IDu1DgZK+1MI62f+sezb8aEl7rqx5QLOitXavDWOGH+vYTiVyYi32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854193; c=relaxed/simple;
	bh=BA4rVAHrRJzqSSgJrpMLT50mB/MklDSW0pj2JlzB7vE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezKcuu1Qv/DmNN0vAceUR3FSDM+UdRQgZBYbIQSW8rqEmmTCe5I8QTZRqcxbfBGsT+jAgHWt2Lhv4FoaR56jq3l4WwnlrLwhB1VvEtLPFcjy0BF0U5Nytj6fEffTQGRPAS5pk69jc1MtMN5F+L1CDoLBi8WGfSPwGm7Mxu10KIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyVIhkT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA9AC19421;
	Fri, 10 Apr 2026 20:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775854193;
	bh=BA4rVAHrRJzqSSgJrpMLT50mB/MklDSW0pj2JlzB7vE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KyVIhkT8XM9inBfNeWjmFSxdEzhz83AVmlYNyXhwaY0E3HVb8RbJaopAjQ8YBeugV
	 RqGuCy+Oz+mOhlVHYFEDF9y9zx+LX5cBCWvSVVysUyIQv0+oTQdY+lr8xHpFQXssuL
	 ZHOEWiBr63q34suV665uO5LK0jXLVhHq0BqBjX2YWqqkYh9HHEt5kVdhug+GKUafGG
	 wumlqC7N/G6ZyQ0+iIgDiuSMZIuVzRSt3U9OHDQ+36zXlEM18QYKIeB6dfYBdVStbS
	 mzfwR2IL5Judnz6GTRObeLKvyBnnOmcGLIc5JW9VSW4yNX4ZOmqb++eWWsfKoIR02A
	 rQwwBAU8mOqQg==
Date: Fri, 10 Apr 2026 13:49:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, Xuegang Lu
 <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next v3 00/12] net: airoha: Support multiple
 net_devices connected to the same GDM port
Message-ID: <20260410134951.6f4ee0f2@kernel.org>
In-Reply-To: <adiop-9Mo4ADfvfw@lore-desk>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
	<20260409195950.74e4bc97@kernel.org>
	<adiop-9Mo4ADfvfw@lore-desk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECDFC3DC903
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 09:37:11 +0200 Lorenzo Bianconi wrote:
> > On Mon, 06 Apr 2026 12:34:05 +0200 Lorenzo Bianconi wrote:  
> > > EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> > > Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
> > > manages the traffic in a TDM manner. As a result multiple net_devices can
> > > connect to the same GDM{3,4} port and there is a theoretical "1:n"
> > > relation between GDM ports and net_devices.  
> > 
> > Looks like this driver uses page pool.
> > If you're sharing the same page pool across multiple netdevs
> > it must not be linked to a netdev.  
> 
> are you referring to slow.netdev pointer? If so, this is not set in airoha_eth
> driver.

Yes. Alright, thanks for checking. Pretty sure I saw it set somewhere 
in a file called airoha* but must be another component :)

