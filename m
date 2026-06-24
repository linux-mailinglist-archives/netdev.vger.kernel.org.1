Return-Path: <netdev+bounces-301755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ht0cMSYgPGrskAgAu9opvQ
	(envelope-from <netdev+bounces-301755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:21:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 063196C0B63
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:21:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F4wnAHSN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301755-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301755-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AF8B3051781
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FD1325701;
	Wed, 24 Jun 2026 18:20:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F822329E5D;
	Wed, 24 Jun 2026 18:20:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325231; cv=none; b=orJ5ReRWBcVFDCWz7OlC56LfaUNfSOQCaL31X/Bk4ZophOjzHIsFmjiE0H0wE9QV2/o20erQ3dtTUqKQ8o0cHWDQTN272JZwDgTBGwuwIf+RCnML0CIZtQFz3LFqrejfWOIemzbOZp8uYt8yEiKkWqg5ZrY2/eqxmSeLUflLBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325231; c=relaxed/simple;
	bh=o2h6ixJ8nw9b38Td39gTF6iqW9LeRrMIoTiW63i/HRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLSWQPShEC0aOVLwcIe7rGiotJrxuamfVTvwPS8CN0TQUNBqf7VYauaPg5sAZpiS1xYTwEQXB/+/Fh1UStSp9ZxjnJCcR0vFxwUKBswz/0Lbk4Ab4OJBJ6r+WIM4tkbBCkFmkw4wFhmerdMpVFsL8hVLRa9hazrbxritt2/02Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4wnAHSN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762C01F00A3A;
	Wed, 24 Jun 2026 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782325230;
	bh=Gj/dLmWpu6KCwtYE/WsbeLqQ7EsyJBapuzEt+HhI4+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F4wnAHSNSNsldnTXoICx0hgvmsUSswnIYrCuzHnvAmSZnTzgMEGXkzCRbYDWdzo3+
	 KRXPKTadf167eFnWaXxTbQzhT8LiW4bpxy0SeolTNDk14YlHYHQgOHhhxBeTC+TfxZ
	 ppLr3vPc5NCDoaanSIPRlxBkui23a4LTdpB9L7BT2376Qi3qo+EJ5Y5Q20j97ITVYU
	 aFSMujOMva/VFe2WSixc8dOsAuuwb6+HYjZw8QlcoIL7aeARAhKpTe9yVlPpZaVErP
	 1YTbzbcLyA6ye3EWj4Y3CYZKorwhpSwZ+bOc3BXEkZmhNIy6isufVLWl2heStQiCIT
	 pzNnYxoN8cz0Q==
Date: Wed, 24 Jun 2026 19:20:26 +0100
From: Simon Horman <horms@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] af_unix: move proto info out of CONFIG_BPF_SYSCALL
Message-ID: <20260624182026.GD1131256@horms.kernel.org>
References: <20260623124940.791230-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623124940.791230-1-ben.dooks@codethink.co.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301755-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ben.dooks@codethink.co.uk,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 063196C0B63

On Tue, Jun 23, 2026 at 01:49:40PM +0100, Ben Dooks wrote:
> These two structs are defined even if CONFIG_BPF_SYSCALL but
> the header does not export them, so declare them anyway and
> move the check for CONFIG_BPF_SYSCALL lower into the file.
> 
> This removes the two sparse warnings:
> net/unix/af_unix.c:1060:14: warning: symbol 'unix_dgram_proto' was not declared. Should it be static?
> net/unix/af_unix.c:1071:14: warning: symbol 'unix_stream_proto' was not declared. Should it be static?
> 
> This change is less complicated than trying to make those two
> structs static based on the CONFIG_BPF_SYSCALL configuration.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Simon Horman <horms@kernel.org>

Probably this is net-next material and if so
should be reposted once net-next reopens next week.

