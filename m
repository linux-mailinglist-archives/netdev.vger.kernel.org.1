Return-Path: <netdev+bounces-260180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLf3KGOwnGmYJwQAu9opvQ
	(envelope-from <netdev+bounces-260180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:54:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A617C8E9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D206B3016AFD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C01374721;
	Mon, 23 Feb 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmDP5cNh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E433A9C3;
	Mon, 23 Feb 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876449; cv=none; b=EFSRh5m6PHnzvW2HpVlY7jbige3iZ1sh9DSeK6gRxfBya6amqL7JAsKS9kXiPFYhDqmP/8L1WaiN0ayaYi9Uv2og5n9Pdr3aRSZJb8XZgbS/X0R3ii1D69qNvqfkMev1kFE8rdsDwZ+0gxwUw26dfLSxtkLL1zNy5FD6h+WceSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876449; c=relaxed/simple;
	bh=IYbIDZYsILBSeSQzfO40gPohBY+fqV/kQRQlYXa7IoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR6rV6ToE1PA1L5soqn2hG5FfWxeQmFetP2biDymd45LXV4q/ajmbVkHdlPmWuZk096AX8zHQlIywA+rhW2EK+8D0Wt8gHSwmfjzAtA3AQefvVTFMZp6LiLdjs8mjOkTkdwSecAaT17gL7tAKIVgu7IojPgsfFQBVqAlzZ8hbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmDP5cNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E64C116C6;
	Mon, 23 Feb 2026 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771876449;
	bh=IYbIDZYsILBSeSQzfO40gPohBY+fqV/kQRQlYXa7IoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmDP5cNhzbQtzpC+srXO430Dbat9Mm+n1IVynUOOwTNAN2EOu6rHF/ksoeUwGnzKq
	 4hYJfbbs1uIC+MyTym2aydZMKvG6Dc57S5u7xZT/YLijukZM1yltiiAPCi5mTLgdAj
	 zwrwtLjigi9QBJTy7sql9R5wLPJL/fmwGXiAaXmQHWB3BoccUmALsCkI8ZQgNWJg5J
	 C3PbUuTJmHOqXdEJfIRElOGaREATOBk0Q10CVVySmcheIBM1I+qoVivhFl0vBiu8U/
	 s2I8Wlb9ZmJ86lzGcX8w7hPcmrgLTcI2oQrhVXrUuKEDlYki0+xy7OBti7Ic8YxjCr
	 HdMNjpyNlqc0A==
Date: Mon, 23 Feb 2026 19:54:04 +0000
From: Simon Horman <horms@kernel.org>
To: Abhilekh Deka <abhindeka@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ibmveth: fix typo in
 ibmveth_remove_buffer_from_pool()
Message-ID: <aZywXPt0X-gnNuRe@horms.kernel.org>
References: <20260222054117.14943-1-abhindeka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222054117.14943-1-abhindeka@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260180-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 566A617C8E9
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 11:11:17AM +0530, Abhilekh Deka wrote:
> Correct a typo in ibmveth_remove_buffer_from_pool()
> where gro_receive is misspelled in a comment.
> 
> Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>

Hi,

Codespell notes that Partition is misspelt as Parttion in
the same file. Could you consider sending a v2 that fixes that too?

...

