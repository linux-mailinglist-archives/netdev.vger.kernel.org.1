Return-Path: <netdev+bounces-262049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J4hGiNUomnL1wQAu9opvQ
	(envelope-from <netdev+bounces-262049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:34:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E77E51BFFC1
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C0AA30A6250
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F832F6930;
	Sat, 28 Feb 2026 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crlFUCor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714313AD26
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772246049; cv=none; b=u4eaV0SblpCJKk7OLb5bFMRJYL5b9wetIrl6fcBLZN+bPO/SJsKAHgwc2BIKm4Q1K/MW0FkjJxVb7W/vVaSZ+OzCmvhg9YxKMddQaAjeXHxO51LTTqgAMd91hnDC9oDFxRNw8CbYhZhB8NrB5Avcu4+KGhxfuNI77Ayopywi258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772246049; c=relaxed/simple;
	bh=lKk3pn+YRFf9WSiifMiL9kpHsv6efoEmsnz6iOp76rY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1BmWWlYCKAxPQxt8e4f1pfhC9ezh9XHgxn2uqL2wp4J/H+l5yHjzbHpS3XCBqeAvABpNBHFxzlwivutqdweVxd7KJcJT82nfYsdX1zdeZgsuBHl5Q2NEwWrzAjHQL41eHw9jr+YRD0cWczxtSNFfVgMhL7IkRvsERbjy5HYChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crlFUCor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089EAC116C6;
	Sat, 28 Feb 2026 02:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772246048;
	bh=lKk3pn+YRFf9WSiifMiL9kpHsv6efoEmsnz6iOp76rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=crlFUCorVSmWFimefhrghL82DJp+dHncF2dqgZEZqmZQHcKjYqzowu9P5xBTV9z+Z
	 9/7DwKnpr555ubNh8LHWi0XHv84QeWtPmFEItWvyozUiPo5rA1Sl8OqUHpCT9Wq2rO
	 dwHWluGvBr2idg5pBh7aPl65sWVbsMzKaGQ0YctqcP3BBEZOcAidc7VjsYJGFiStS2
	 5cO90ZDNOwNTtqANQIA6dvJC6bh8axPFxeAk2QYEvwh4badWYRlEmQm6I43WOjt8Dp
	 T4G5mWR3qxVharBcESs+bNW0aWkRUrh/emj/5NooelVgequnoZSiResV2oUR7ZT86c
	 PjIYLdVe5Bh5g==
Date: Fri, 27 Feb 2026 18:34:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny@fb.com>
Cc: <netdev@vger.kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Stanislav Fomichev <sdf@fomichev.me>, Nikolay
 Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next 1/9] selftests/net: Add bpf skb forwarding
 program
Message-ID: <20260227183407.39b4a207@kernel.org>
In-Reply-To: <20260224002410.1553838-2-weibunny@fb.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
	<20260224002410.1553838-2-weibunny@fb.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,iogearbox.net,fomichev.me,blackwall.org];
	TAGGED_FROM(0.00)[bounces-262049-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E77E51BFFC1
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 16:24:01 -0800 Wei Wang wrote:
> Subject: [PATCH net-next 1/9] selftests/net: Add bpf skb forwarding program

Sorry for the delay, the series never showed up in my review queue
cause this patch never arrived to the list :( Please repost after
a couple of days if email system eats part of the submission.

