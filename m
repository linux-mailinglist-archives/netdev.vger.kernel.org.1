Return-Path: <netdev+bounces-297868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W2hXJIz5KWrCgQMAu9opvQ
	(envelope-from <netdev+bounces-297868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:55:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C8E66D74E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:55:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E1theoR0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297868-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297868-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2558310BE61
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA9C3B42E3;
	Wed, 10 Jun 2026 23:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E9331EC7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:55:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781135738; cv=none; b=T8e9B1CCUGxe9lY5zlug/fUQjKALjdzQJXmWnzYH8tacgse6geaKlwCh7i748nWe2AGDejU46KrSMWgjTvNUl7LNqkZjggFCj9iQRNuWW+l9vIb1wrKUUeMzEu3uDHlqTwCmQSjSoE8hPO08qZH6/rdNFY5D4Qwlkv97GQ/+EBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781135738; c=relaxed/simple;
	bh=a+b/AeI8VbR8U7ywZt8JZDGcD2L2EIL+pzZQSn0K4nk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGoO6ImOQJDOvvr1cWOon0QA3nelNMWTZPzUAa1+MwYvZCaVTQcy8Zs882i/a+mEduViqtZ75cnF7R9TMLOOEntZnsSX1e47uVh36SD7xE5HuIAJmE67V7A2GqM6ca17GgS/r1ui/fbMN8rjeGxdv4ZuF7R3egImH0tvEO/D3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1theoR0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42001F00893;
	Wed, 10 Jun 2026 23:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781135737;
	bh=fu+irVX7FI/0Lx6+pKK2gmdllICtVtn2Y09Kti2xd1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E1theoR0O9+c0iEw7d4P6kTApB+6Y8huc2JNKb70/mdqkPvUKm/UDH+LARkzi5rNH
	 MaiEEcxibWLVCdO056uKxvE0n0FpigkfQiZicZ5c4Pbx0HvXSmWAPlEnvDQYdp+/Ww
	 MyoNPnQiiO4SdtKolC6vCEp67wc8OVgh0audue+kuNpCBZzwToa3YbNj22Z0hz0+rP
	 tMwPetjRdgkveOTunofU8/xStD8Tf/As02+dLbG3cVK1darSlzDkH2OCgZIDy9uEOs
	 WTsOCFu+LDYf2KakdIfdUaLC75qKLUbFMwpoJG6JFtjNucxnoBYKdI/ha43TzthnsW
	 uxuxq8b7Gs89A==
Date: Wed, 10 Jun 2026 16:55:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, John
 Fastabend <john.fastabend@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: remove tls_toe
Message-ID: <20260610165536.21ce4be4@kernel.org>
In-Reply-To: <aimaArGsuD6Evobp@krikkit>
References: <cover.1781013810.git.sd@queasysnail.net>
	<aimaArGsuD6Evobp@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chelsio.com,gmail.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-297868-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:ayush.sawal@chelsio.com,m:john.fastabend@gmail.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12C8E66D74E

On Wed, 10 Jun 2026 19:08:18 +0200 Sabrina Dubroca wrote:
>  - do some more cleanups in the cxgb4 driver (CXGB4_ULD_TLS is now
>    unused, but then if I remove that I should probably remove some
>    other things)
>      I'd prefer not to mess more with the driver, as I don't know
>      the code and I don't have the HW to test any changes.

SGTM, FWIW

