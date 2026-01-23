Return-Path: <netdev+bounces-252978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ+UNzfuc2kVzwAAu9opvQ
	(envelope-from <netdev+bounces-252978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:55:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D08507AFDA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C1053006108
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5752D6E62;
	Fri, 23 Jan 2026 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB30JaPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD632D47E4;
	Fri, 23 Jan 2026 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769205296; cv=none; b=Al7xXgWjyfcibrk3gzH40XJe9sR9/1Fl+oIHUNCHYMmIEjDN31NRBUmwgetqObboeqamXTr9kcdTtNu1jZi9CzvRw64TPd44pEezcJ3hCaJlli5GJwqPxddrSjimG2fzjF1ek4h5tA28F2bJzNvUn9buy58l+eMcwVNewIzm66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769205296; c=relaxed/simple;
	bh=4rNxIGJrzfqhGn17zoSC2KvS3w7SWK7eFut1S/GBwkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OG33HMYFASJc/e7287mO+qEdllLdyJIlKfb0yHe8qh7tZRGMExFbPzqDfhyLvQDOWnIVf8yfoFekNMecyq4sHIT0S6kcLiS2BosX1MnY6fNaLLP0i8JmzCD+obiQj5DZIC8PsPnu6nMDS6wyfVOe92cXaohmufEnWOuHhTb9csM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB30JaPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE9DC4CEF1;
	Fri, 23 Jan 2026 21:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769205296;
	bh=4rNxIGJrzfqhGn17zoSC2KvS3w7SWK7eFut1S/GBwkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cB30JaPO1Z6ybD9AKI6LGhGyQFNYJ/OdoGmywGoC2AexX0Q+XLT/O6pyJB+h2VTn2
	 dqjyJyfKdwT0WSNMM+GS5cQFTSi179c+eoXthrlp8f385hp33iLJL4uYjDn5d8B1hV
	 TWtORvhVBxai1MduKGx5c1Ytw7qT8Nkkm1erdxw68LUKiPm1oEZDmmrsdsu2vEqMOP
	 dXaJmeXDHSj0U6gpDI8Bowh6FqxxEo86BMgDqPv+acvLSeCtwkNxNXclAdZCkQG/9z
	 0+IuGtqp1oAb1LmMaW44AbZa50wjdmVly7l13cY/OR8J5/FJiCn7kKmqROjX4tbT46
	 h4mjltqD+gt1A==
Date: Fri, 23 Jan 2026 13:54:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-01-22
Message-ID: <20260123135454.07955c21@kernel.org>
In-Reply-To: <20260122200751.2950279-1-luiz.dentz@gmail.com>
References: <20260122200751.2950279-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252978-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D08507AFDA
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 15:07:51 -0500 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
>  - hci_uart: fix null-ptr-deref in hci_uart_write_work
>  - MGMT: Fix memory leak in set_ssp_complete

Pulled, thanks!

