Return-Path: <netdev+bounces-256949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC5rDVQfhGlCzQMAu9opvQ
	(envelope-from <netdev+bounces-256949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:40:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72AEE8F5
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E78B3010D98
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 04:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E82EACEE;
	Thu,  5 Feb 2026 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAN5H/ex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2A13D638;
	Thu,  5 Feb 2026 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770266448; cv=none; b=ie2QWxlf18TSVGoXBRcUWeuN2XQ22hKvAKBWB4E5CDip5uhPFZHungYbmOa4PV/LsRezg1aE7fkfQuo2i8/uBUyD9yG/PDN5MkJSQ7VmZMbSWeGN2G3aBRD0tB63MP056bl/LKI9AqPZ6s/t7ite0BZ7H7dfPfqXi3+EONBDM8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770266448; c=relaxed/simple;
	bh=rD3N1qVuhS0PYaD7alsoZgGnfkX+PIVIsETHXKEQ+ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KK0mJYZ9EREU8k3JFB9H99qQBz/rxH4vaEiA4dzz+6pISW03cBbbb8TSwEUZ2p/4rWESNvapsW8KHAyL9SFh4ufK0/9AyxEpEOg2AvyRH1Ht/Cwc7t+DiNkJDGD7NC8W5wMA9CEBP9eVODKNgmaD7TTBK12g3mf+PtDPr8R+aNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAN5H/ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FD7C4CEF7;
	Thu,  5 Feb 2026 04:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770266447;
	bh=rD3N1qVuhS0PYaD7alsoZgGnfkX+PIVIsETHXKEQ+ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mAN5H/exnShKukKm3vVQBIg3+RzbfTWhn6XYSICJrl0lVyGhHpLtiCiVVebiyqNJR
	 DRcEseAJ8suZk+m16lUi+G6fGcXgNQDjkamEezxKL4SRrqifMJdynWxG3K7u1WZCo4
	 IfS1sFI/zKpw0sPR0fwnRXCFbgAnB8cyr63SwfucEpSAr5zgMKf2IJ7XM+pyiiGSJA
	 stkoqsVxi+anU+qXpVkhnFTjF4haN4DqtgtHZyLnzM8FVL0xUu0+PkZC0vW4OChoR7
	 JoGkxEwXFv/nibyRSb3FrWiPRZIDcokcgpeMVJ+e2AnQWA5OmM+crl+jmq8o9L+Cfi
	 NqDjrD1JOeC2g==
Date: Wed, 4 Feb 2026 20:40:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v3 net-next] net/iucv: clean up iucv kernel-doc warnings
Message-ID: <20260204204046.44a622c8@kernel.org>
In-Reply-To: <20260203075248.1177869-1-rdunlap@infradead.org>
References: <20260203075248.1177869-1-rdunlap@infradead.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-256949-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB72AEE8F5
X-Rspamd-Action: no action

On Mon,  2 Feb 2026 23:52:48 -0800 Randy Dunlap wrote:
> - * iucv_path_quiesced
> + * iucv_path_quiesced -Process connection quiesced work item.
> + *

AI spotted missing space between - and Process
fixed when applying, thanks!

