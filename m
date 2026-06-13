Return-Path: <netdev+bounces-298996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qV0fDE6VLWrdhgQAu9opvQ
	(envelope-from <netdev+bounces-298996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:37:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B767F2F0
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:37:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PUzSIUGg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298996-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298996-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 669C9301F9D4
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9133321420;
	Sat, 13 Jun 2026 17:37:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77321EEE6;
	Sat, 13 Jun 2026 17:37:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372235; cv=none; b=P4xDP/a0wlDmuzOnWl8iP/VeuWUvtBhUTK5uxfz1GNdM1G+246URXtNlfkmI0VHWZwLvp7caotlDzVToNj8FQ1AQ6BHg2epiF9rgof5nsE2Q++vNO1nVIZMgvlRSK5yilvyQYpNqB0G566C23T6ZNZhZlLCKF2jp3hMXbQZGpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372235; c=relaxed/simple;
	bh=4FYhViFgpnWRJ3vbbVswfyM+VVJPJoayuFpiGNMXd0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9FzSHwMli5hMWSYbae+iUZbSDzpgD6r9Stzn1atJ+YkXv19Y+5YXu78Q0wVrerRIC7yHBgj0f2oJg9pI8SuQKTbQYLYnxlx3dMpvcjiAArR7NI8OYAbTHVSSP0O9FVs2LIP8WTCORWdJF9qbynV9eNRnEvdSsKMoh/2e2Y04hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUzSIUGg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B19A1F000E9;
	Sat, 13 Jun 2026 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781372234;
	bh=hWcLMAgLghTx7ZPTXhrSM+sTX6PyGogJrrFs8ZkyBak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PUzSIUGghU1qixEAKIvn19ap5OHfde0Zq73cCD0JJeB+snXP7r0pHwS7hJZDYHbYC
	 nLa3s5VnukX7LMVuTAyzsnTSzKJMofvqcloHbeJ5NGmoESXuuiXwcgv5SqPTqAH7Xh
	 vYWoD53r2yzhKNgpZHXdQk102Og+WEEwNvdjqH+36Zh+HRvbPPayI9iOVw1nub5AJF
	 yfG1iub1HCf/wZ9AzGnvq7eV4zh7evxkNi7XBMeyPSU0fwabDLzyBX2hwfLbBfYbcy
	 Jc0eFLuQ06roXKcuLuAqpU6txEB1MYF7ynr4BwfjLussz5kcwirYvhvnAV8s95rsbE
	 JBAYNlG7+m/VQ==
Date: Sat, 13 Jun 2026 10:37:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Raf Dickson <rafdog35@gmail.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, pabeni@redhat.com, stefanha@redhat.com,
 bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
 horms@kernel.org, edumazet@google.com
Subject: Re: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <20260613103713.6e3e27d0@kernel.org>
In-Reply-To: <aivKma8mRjTXV0BM@sgarzare-redhat>
References: <20260612045842.122207-1-rafdog35@gmail.com>
	<aivKma8mRjTXV0BM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298996-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,kernel.org,google.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 920B767F2F0

On Fri, 12 Jun 2026 11:03:24 +0200 Stefano Garzarella wrote:
> nit: title should be updated since now this is not just vmci
> (e.g. vsock: use sk_acceptq_is_full() helper in all transports)
> 
> Not sure if it can be fixed while applying by netdev maintainers.

Updated and applied, thanks!

