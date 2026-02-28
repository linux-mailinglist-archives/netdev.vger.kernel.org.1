Return-Path: <netdev+bounces-262209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNJaEklQo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:30:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA581C8630
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F764300F193
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B5175A64;
	Sat, 28 Feb 2026 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWKwCMpX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29375430B85;
	Sat, 28 Feb 2026 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309436; cv=none; b=l/62Qp0sAkMmfM3n5RKLQ5ZCCHOUOyCUnjY9rkejnPgLz51M93Iqe+6BfJ3qiaJ/PDY+4E80UkWvRbZk3kPdf/NL+O9FB2W+ofno5zLCQC+KY0RRE+JoI72frshDcgK3vaEfK1wcs+9DMHAOWotw7av9ggwi8jEuf2UXwC1pU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309436; c=relaxed/simple;
	bh=zRmfYXGVf6zSI7IN6jmOqA0lt0pCqBwbVdn+GrAMCdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+NTGFWkSMbUZLe9gTCLm3QAMwmq/EBADkb0khDxhbW+z6UVR7YuhLsusUS7jbZSNMrjq6Xjk7A+GFgvMFAxwrGUVUmSUZUdge/qUkQXDIJ2hhdDeCr66olXPHFnhyW3WedxoowSDcARtpTCKLjOxUMg1qq+GUkUtTXc7E6EmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWKwCMpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300BAC116D0;
	Sat, 28 Feb 2026 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772309435;
	bh=zRmfYXGVf6zSI7IN6jmOqA0lt0pCqBwbVdn+GrAMCdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWKwCMpXanmdIal9rrklAKrAk8pPh9cTxeLjfSssfg6Ka1XQyExoaN9tD4WKBNvEA
	 MfxMFpGzYxEl4gAxwzRaR0cFkgD9h8eZtbVDNyP0eIYrd0V7oJiTWxw7snbUdIJR6c
	 CYXYb90oUR4Uid4FhvlZrSbVVtCwqqiKoMk6F5K6phHrA/Aic7Wo11RGRhP1/oxc2G
	 ALJQSTpobScbFgPu5vQVN/6BEongbrXneAxebdkIg54WPuPj5VqZDiG0xkODpKkEyh
	 yco/N++NOnf+aq+hQYUZF+WznuZMQ2Lqsspl3NhP3XUvwCw6Kepp0poUNygfABZBWK
	 eDXzHjw+/rWnw==
Date: Sat, 28 Feb 2026 12:10:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kiran Kella <kiran.kella@broadcom.com>, willemb@google.com,
 davem@davemloft.net, edumazet@google.com, daniel.zahka@gmail.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, akhilesh.samineni@broadcom.com
Subject: Re: [net-next, v3 1/2] psp: Support for transmit on logical device
 when the underlying transport device supports PSP.
Message-ID: <20260228121034.48c2d282@kernel.org>
In-Reply-To: <willemdebruijn.kernel.1c3d7105f1c48@gmail.com>
References: <20260226184654.3180648-1-kiran.kella@broadcom.com>
	<20260226184654.3180648-2-kiran.kella@broadcom.com>
	<20260228100449.19f6ef13@kernel.org>
	<willemdebruijn.kernel.1c3d7105f1c48@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262209-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[broadcom.com,google.com,davemloft.net,gmail.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCA581C8630
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 14:46:28 -0500 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Thu, 26 Feb 2026 10:46:53 -0800 Kiran Kella wrote:  
> > > This is achieved by propagating the psp_dev from the lower device
> > > to the upper devices in the device stack via a netdevice notifier.
> > > The lowest device owns the psp_dev pointer while the upper devices
> > > just borrow the pointer. When the lower device is unlinked, the
> > > borrowed pointer is cleared in the upper device.
> > > Assumption being that psp_dev is set on the lowest device before
> > > any upper devices are stacked on that lowest device.  
> > 
> > As I mentioned in the other thread I'd like to establish some clear
> > expectation on where psd propagates automatically and where it doesn't.
> > I don't want to see a stream of patches that say "fix propagating PSP
> > onto X upper". And conversely report saying "PSP got propagated but
> > it doesn't actually work" (macvlan in bridge mode etc).
> > 
> > Hence my preference was to require the user who created the device
> > to propagate PSP. Willem, WDYT?  
> 
> Can you give a bit more detail what you have in mind?
> 
> An explicit user (netlink) API to associate a psp_dev with a
> net_device?

Yes:
https://lore.kernel.org/all/20260224002410.1553838-7-weibunny@fb.com/

