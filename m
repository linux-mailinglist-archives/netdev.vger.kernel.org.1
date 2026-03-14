Return-Path: <netdev+bounces-267778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MY0NC6UtWnL2AAAu9opvQ
	(envelope-from <netdev+bounces-267778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:00:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4376F28E04E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F2A3302410A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1A31F988;
	Sat, 14 Mar 2026 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvsyxJtx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB83093CB;
	Sat, 14 Mar 2026 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507605; cv=none; b=ULT/dBcnc0ioARwuJB+b0XQaGMCrF+i4mg2xZKDtKaw09LZLNFdrJIsEShv2miUQPZmKSV6TIN1O0WlXLt40pJZMnaNgaS4or3Kq3AtuYhpjZ6+crYIdRxj4ZxT53aBDAwQiE0+3LMPnS/A/Z/yRYvhr/YS6xkze33cWF6IYuz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507605; c=relaxed/simple;
	bh=SWSf1uKHv04oZKhJO7ec9IrM9R7Rv9hwNZ3sbrrMO9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISiuDcE9LYVqEGlIx9p9fsEdaVlEAhql26gIRrJpPeckAH7rnI7su1BIIuj8bC9qMUEYqMIE4/xPYR0Sfxk1V7ulfPKblZek90bdrzuiHmoPTmfc7IfFb6dU7kD1S12Rz1thT/mTrgvmrvI5T6YXQ40vewhV+ofzSH0yLdAEnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvsyxJtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A79C116C6;
	Sat, 14 Mar 2026 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773507604;
	bh=SWSf1uKHv04oZKhJO7ec9IrM9R7Rv9hwNZ3sbrrMO9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cvsyxJtxLzbzdxQfk9NjKXbHfh3HaXOz27Ab4Ze1i31Ki9mhDj1QXCd5u/FxXrA2F
	 M1/HOeimPpyjqhQnYOGlC+5ewY1Cp0AOyfFBKxgCUqvj6RNCO1ATclCTN6pgeZ3vVB
	 LKw47pA/BjUBj7iuxON6g5eRJfWigp+Q99PW9JfUwC9QEFK/uMAkDAhgXuRo+QwytG
	 rkuEaDKtY6Qy0MrpRQ48Zp8LytRNnAJRuipNBG2lbgFloBvOeuInEW/q5HHHx5qGwj
	 F71wqynXFD7gKsnZzV8DMHEiegXrjxvbHFzKaq+Fg1xzVt8l1bfDHqmrUPHhXSvqCt
	 6kQtZoj7NhKeg==
Date: Sat, 14 Mar 2026 10:00:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/2] net/sched: cls_flower: remove unions
 from fl_flow_key
Message-ID: <20260314100002.122c8c73@kernel.org>
In-Reply-To: <20260313132651.GX461701@kernel.org>
References: <20260311-net-next-mv88e6xxx-tcam-v8-0-32dd5ba30002@luminex.be>
	<20260311-net-next-mv88e6xxx-tcam-v8-1-32dd5ba30002@luminex.be>
	<20260313132651.GX461701@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267778-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4376F28E04E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 13:26:51 +0000 Simon Horman wrote:
> It seems to me that the use of a union is intentional here, as either IPv4
> or IPv6 addresses can be present in each case - never both.  And that
> control.addr_type and enc_control.addr_type are intended to allow
> differentiation of the address type in use for each of these unions.

My reading was that the initial author simply wanted to save space in
the struct.

As the commit message explains this leads to complications in the logic
which sets the keys. The alternative is to complicate
FL_KEY_SET_IF_MASKED - doable, but given that the union feels like a
micro-optimization in the first place the simpler approach of separating
fields seems okay too? (TBH my mind also initially went down the
FL_KEY_SET_IF_MASKED rabbit hole but once I saw the simplicity of
Cedric's patch I changed my mind)

