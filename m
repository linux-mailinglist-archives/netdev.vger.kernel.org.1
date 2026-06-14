Return-Path: <netdev+bounces-299140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0zqgLvwtLmqRqQQAu9opvQ
	(envelope-from <netdev+bounces-299140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:28:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 091526805A0
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:28:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.org.uk header.s=zeniv-20220401 header.b=I9M4n4nD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299140-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299140-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zeniv.linux.org.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ABE63019512
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 04:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DC22BDC2F;
	Sun, 14 Jun 2026 04:28:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444EB23ABA8;
	Sun, 14 Jun 2026 04:28:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781411320; cv=none; b=kifJU1G0aFh6XaQQ8BlLxWGaByM0EKLfo3susDF72j60WYz9gdi5y5x/yf7DiOLSfcnincpt2h+sZHQ7DMCDUlw98FrpDKASNSFAUM9gSk/ETnyDwk+bPIC8X7SAYRmDePVscHE6ZTFDVLJsCvAY2W0CfUutKGMR6TdaIfzfp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781411320; c=relaxed/simple;
	bh=1CNtR+1XsJcjIVBVOfEfNiScHa+vYZaSO9jfPot9Gks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEuDM3ZDmJfAO05fMccBV0OzymZzonI9fDCWXGjGl7OoxZL8s8DCMwvveenyTMiZQhxTadqp6L1wheliP8mZl26+4BHpghSQVoGiXhbNzStZT4Kd7RJaAlwfLRVPKThOxRroPuH0NmnsnprydWOH3u0L74t3amlzOra72ucfNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I9M4n4nD; arc=none smtp.client-ip=62.89.141.173
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3LmUPVq7ivRet6Jr130UTeBbLDPfKykgEhPeYeh3feo=; b=I9M4n4nDkoSjsiJY2yRbOmaPIv
	X4sAY7NhAgiAvkw13tDkzAsMWpjSphMjEw0gAbsf8N3oj4BqZ5HZ4SnQePEcqKnrOifaiA+PPda58
	jc6kSBEN+jBSqJ9dpqgSrVJTC2T1Wl8Fb2s17ITK/ZpN/2DT7HndcU0n+c6t4rMnLNJuWI+iEdUZX
	XpFzy+VvkKQbc2M2KpMm/B5yd3Tb9IjXghAJagZpWfUHEBgWtkIIMzvdfAamym03kiffH70BIcu4j
	OZTUetIW7yfR1ZXD9wiXYd8xHoVbLBjOMX5KpoV5SjVz2JqkF+xS5nP9R2Lgt77KVTkZLUfem/yCP
	LZ8h4lgg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYcSY-0000000F1KL-2bi1;
	Sun, 14 Jun 2026 04:28:34 +0000
Date: Sun, 14 Jun 2026 05:28:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Ramos <maguraa53@gmail.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: remove obsolete network and 16-bit video drivers
Message-ID: <20260614042834.GO2636677@ZenIV>
References: <20260614021629.656478-1-maguraa53@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614021629.656478-1-maguraa53@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maguraa53@gmail.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-staging@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[viro@zeniv.linux.org.uk,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299140-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:dkim,ZenIV:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 091526805A0

On Sat, Jun 13, 2026 at 11:16:29PM -0300, Gabriel Ramos wrote:
> From: Gabriel Ramos Barbosa Mota <maguraa53@gmail.com>
> 
> These drivers are currently in the staging tree and have been identified as unmaintained and obsolete. They lack modern hardware support, do not integrate with the current device model, and represent technical debt. This patch removes these drivers to clean up the staging area and reduce the overall maintenance burden, as there is no evidence of active users or ongoing development for these specific components. Signed-off-by: Gabriel Ramos <maguraa53@gmail.com>
> ---
>  teste_disco.img | Bin 0 -> 20971520 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 teste_disco.img
> 
> diff --git a/teste_disco.img b/teste_disco.img
> new file mode 100644
> index 0000000000000000000000000000000000000000..13145eb3ecf765e330220f06cf8ad7553c3d9ff2
> GIT binary patch
[snip]

What this patch does is dropping a 20Mb binary into top-level
directory, apparently with empty (and dirty) ext4 image in it
(according to debugfs, that is).

WTF?

