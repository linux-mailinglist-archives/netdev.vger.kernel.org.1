Return-Path: <netdev+bounces-276091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA29NKw21WmP2wcAu9opvQ
	(envelope-from <netdev+bounces-276091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:54:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5CD3B21C0
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37776300C029
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B7D3D0905;
	Tue,  7 Apr 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc4NGNgr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4939BFE7;
	Tue,  7 Apr 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580612; cv=none; b=kKdmLtA6xqQJhhKg18sJnDInMC8Fua6rASubUWFh57xm965hNhdi39IrWq4mWRgV/CjRKqfYrSPRw+HiqtmupEdbWfM/0ZP1y+peBgy1QsJtiekBC5JQcMMweg5CUuj0z0zNtpvyyKtIL0iaouz2SWpSLR04aBpNFfmtmTVMMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580612; c=relaxed/simple;
	bh=ri8IO14108CEqPLdT9t/jLXWHbAL9X8Xe/xDNM4QM/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czatUwNx+vB2CDOzxabJoL6AWHqvCOk7DcxIAZjk5HfRWzXCkBhv7VTfsyyA9WZ7+SiwG11V92OeS4xRN62uyiFFY/gB4nSvmuxCLJrJVKp4dGbaTHpXw1N5hyfpLlezsgOkxaUEtFxcHwweK3CHTbQkr6iXp5CTmtzlq/+r5ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc4NGNgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DEFC116C6;
	Tue,  7 Apr 2026 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775580611;
	bh=ri8IO14108CEqPLdT9t/jLXWHbAL9X8Xe/xDNM4QM/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dc4NGNgri7l5NComqQHJcaJgSoiNWB42bESS+8alpV/LFD/QBdEgH+d+zqY26FXdX
	 KrAlhT9K9p+mH0YW8qPbmxMqQrmbzRbSbcBCBvIWLNmSaLOvkB1yLjO+GJ9UnYOBLv
	 8/BQ9kyhgzV2G+jsYvv2Qp9Hy9x5yKt7cxhZWMHnJUAGKpvGq6ag0uZtO6SmR8ZQkf
	 Bg+FMmAVshFSA116/47bQRGGJjzDemcX9iwV03dSj/WzO6LhMU7SpK+y4POg7mn3Nm
	 uOCaSzFs5EPIFsh+NNbhTTw+j7EQRTjxToru7sjOhAR6DReqiw1l9xdDY1i50Ha+ex
	 jNYggky+9Pd6g==
Date: Tue, 7 Apr 2026 17:50:07 +0100
From: Simon Horman <horms@kernel.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com,
	ajk@comnets.uni-bremen.de, linux-hams@vger.kernel.org
Subject: Re: [PATCH net v2] net: hamradio: 6pack: fix uninit-value in
 sixpack_receive_buf
Message-ID: <20260407165007.GB469338@kernel.org>
References: <20260404085658.GR113102@horms.kernel.org>
 <20260404100350.299117-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404100350.299117-1-mashiro.chen@mailbox.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276091-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ecdb8c9878a81eb21e54];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,mailbox.org:email]
X-Rspamd-Queue-Id: 1A5CD3B21C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 06:03:50PM +0800, Mashiro Chen wrote:
> sixpack_receive_buf() does not properly skip bytes with TTY error flags.
> The while loop iterates through the flags buffer but never advances the
> data pointer (cp), and passes the original count including error bytes
> to sixpack_decode(). This causes sixpack_decode() to process bytes that
> should have been skipped due to TTY errors.
> 
> Fix this by processing bytes one at a time, advancing cp on each
> iteration, and only passing non-error bytes to sixpack_decode().
> This matches the pattern used by slip_receive_buf() and
> mkiss_receive_buf() for the same purpose.
> 
> Reported-by: syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ecdb8c9878a81eb21e54
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Simon Horman <horms@kernel.org>

FWIIW, I don't think my suggested by tag is strictly necessary here:
I just suggested a minor tweak, not the idea the patch implements

> Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>

Sorry for not noticing this earlier, but AI generated review flags
that while this change looks correct, it's not clear how it relates
to the sysbot report: IOW, how is it that bytes with TTY error flags
may be uninitialized?

...

