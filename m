Return-Path: <netdev+bounces-286872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB5QKwFtAmqosgEAu9opvQ
	(envelope-from <netdev+bounces-286872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:57:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA02E517A4C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 057F33024284
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254836A358;
	Mon, 11 May 2026 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8BsJar4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27807285CAD;
	Mon, 11 May 2026 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543405; cv=none; b=R5HEF4Y9BHzEgydeFMcm/63Zy5oUelOlq1fmukKKHl1lSld21elltJI/tNT8RK0iZ4nIjUT58qs5cjwHzRidEtk+URQxhoZaJdso+FBLdvyHRm4Ui8i+6Y5OP8rOG1uVYUgh/hmxhqrpITxGYhULoj+i5lTAvpfssKrPJI38pqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543405; c=relaxed/simple;
	bh=rPj6SxaQ6jhCHXuTYCPE/1ioS/qiF+7562agQyPg2Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHzZr4/zE1gROHW0fd+PhrQFcQqqQ5K/Dp/N9DBgYznRvm31eq9Y4J2HXXWF3aPxdptMokPgcOqytJluFGQ+0Rv7mp1RCwrnscyCBHdvpA2VGkJ6/1KjOqzI1z18RqODXnvpiFb6hr4s3bK91jQJEnDKzz144eVJxWdTe4xbrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8BsJar4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57316C2BCB0;
	Mon, 11 May 2026 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778543404;
	bh=rPj6SxaQ6jhCHXuTYCPE/1ioS/qiF+7562agQyPg2Zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a8BsJar4w83nRlR3PgQRWyOpiVmZKBbe7z5lPLj3egWHZ4oNULLTyd3q9cWRWFYr9
	 uUgIILnvzeFSiNvgihO4rLcZegMr45rJHIAigXnwVocG+XzgisdXQqiBZ3Rd1n0vx2
	 yXnEVsxFrIOOSXa9IjBm5QX4vwfYIYylUXxLs7FnL+yoNmJXhpou67SDXJNJOBZgx8
	 wCRPrCQGxq3AgmZM2DpHVhOg41zgwrNghIj1WrDDF1Q0sD1FDNyLc/dS5Es3onjUfZ
	 DG6/iTH9GdaRmZNSCqK8z3478N7fVRwAoLU8lM/xnmlfeuDwzR5EDzFScIMfjl3K6q
	 mUCGSqpHmwsMw==
Date: Mon, 11 May 2026 16:50:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Igor Russkikh
 <irusskikh@marvell.com>, Egor Pomozov <epomozov@marvell.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v2 0/9] net: atlantic: add PTP
 support for AQC113 (Antigua)
Message-ID: <20260511165003.3a9edc41@kernel.org>
In-Reply-To: <SA1PR18MB4600B9CEB989661CFCE73DDBBA382@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
	<20260508120156.3060-1-sukhdeeps@marvell.com>
	<20260508160656.2a318b34@kernel.org>
	<SA1PR18MB4600B9CEB989661CFCE73DDBBA382@SA1PR18MB4600.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AA02E517A4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286872-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 12:26:23 +0000 Sukhdeep Soni [C] wrote:
> Thank you for raising this. Igor Russkikh has left Marvell and I have
>  taken over as the maintainer of the atlantic driver. I apologize for
>  the lack of responses to community patches =E2=80=94 I was not aware of =
the
>  outstanding submissions until now.
> =20
>  I will:
>  - Review all pending patches for the atlantic driver on the mailing list
>  - Respond within the netdev review SLA going forward
>  - Submit a patch to update the MAINTAINERS file to reflect the change
> =20
>  I take the maintainer responsibilities seriously as described in the
>  documentation you referenced.

Ack, thanks for reviewing the pending submission!
Looking forward to the MAINTAINERS update.
(We'll get to reviewing this series in due course.)

