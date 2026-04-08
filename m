Return-Path: <netdev+bounces-276670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEw2B/yV1mmiGQgAu9opvQ
	(envelope-from <netdev+bounces-276670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:53:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475B3BFDE1
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A877F301C590
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113133D88F5;
	Wed,  8 Apr 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXgLGloN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCBE3D47AC;
	Wed,  8 Apr 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670744; cv=none; b=sIlYxA1fuTtbT/HupZVJkC6FRRlF96SGYZwQZGRkpaaqv+V171dh5M+GQhv0MT+4BPPQesxMxgDvHi4cIteEK4idpk+NUk/TqtkVW/ZVTzh8Jeyl8etjRrvUuEjpb5Zy7N0EKTxbM0x3sNzLFQn3UL7hRfOpk9F2kAnGmHurhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670744; c=relaxed/simple;
	bh=xs3VurAPxyS3PpD4T0CNvipMweg5HIapbR2V3gFMRN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpNE0MO9CZ88SOIQ/XjINF31J0DcwSboyoqHo8bbAGUX3aziaTQtpdJaBYbLwX7lXqJISDQ1kPF0H6/eW93veWGXm8rG4QRi5pekxAxvQQzzwsoVWqnSRSqFMZdjrwG4goqpono7EdTcAI0AEGAYNeGkciRmKSebwccGDgBX0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXgLGloN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6985EC19421;
	Wed,  8 Apr 2026 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775670743;
	bh=xs3VurAPxyS3PpD4T0CNvipMweg5HIapbR2V3gFMRN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aXgLGloNR4awIMd62VobFLJ6GiRxKHSKLAcJOWm/wiaabStegAME6GPOGLXsEqD7q
	 jpUbn/Jut8IRxAX/SJcVP2WZj8ChKgv9460liauDlFYakhJBk5Csr6DjVC+88FVlyM
	 fQh+e0FluE3uyPFwnquoqmjhEFBIBeNTfQPTUTEENHoSO+mntvUL6oNSgyUrtARrlR
	 Ydk89FUo3FYTGYwAMz8Ek5yYS/2r/ozO08Pj7zE1etO8eNDP4l10Ts9/skKJ/9hiyX
	 UjQhphIkvOegcjNTYURBCDXETz+bS4JYwkRNXEEVpX44zfd1p/VCo2eDwXpD+HLwQc
	 Ptubh8gQk/uDQ==
Date: Wed, 8 Apr 2026 10:52:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Anderson Nascimento <anderson@allelesecurity.com>,
 netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Luxiao Xu <rakukuip@gmail.com>, Yifan Wu
 <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan
 <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>, Ren Wei
 <enjou1224z@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>, Simon Horman
 <horms@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net v4 15/15] rxrpc: fix reference count leak in
 rxrpc_server_keyring()
Message-ID: <20260408105220.11145466@kernel.org>
In-Reply-To: <2234187.1775645373@warthog.procyon.org.uk>
References: <20260401192244.6ad86fc9@kernel.org>
	<aa7aeb86-2430-4c67-9d5d-bb27ad037865@allelesecurity.com>
	<20260401105614.1696001-1-dhowells@redhat.com>
	<20260401105614.1696001-16-dhowells@redhat.com>
	<1938758.1775071956@warthog.procyon.org.uk>
	<2234187.1775645373@warthog.procyon.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[allelesecurity.com,vger.kernel.org,auristor.com,davemloft.net,google.com,redhat.com,lists.infradead.org,gmail.com,lzu.edu.cn,kernel.org];
	TAGGED_FROM(0.00)[bounces-276670-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7475B3BFDE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 08 Apr 2026 11:49:33 +0100 David Howells wrote:
> Regarding patch 15, which provides an alternative fix to patch 8, I previously
> asked you to drop patch 15 - but I'm thinking now it's probably better to keep
> patch 15 and drop patch 8 (and change patch 15 to return -EINVAL).

Should I apply the other 13 patches and let you include whatever 
is appropriate to replace patches 8 and 15 in the next series?

