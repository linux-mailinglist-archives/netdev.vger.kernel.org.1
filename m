Return-Path: <netdev+bounces-294836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ULaLMOdcIGq+1wAAu9opvQ
	(envelope-from <netdev+bounces-294836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:57:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0C3639F91
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:57:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L6yRa7t7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294836-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294836-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7652A311E8F7
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63AA3E1D16;
	Wed,  3 Jun 2026 16:23:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443639A079;
	Wed,  3 Jun 2026 16:23:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503792; cv=none; b=anTnSz8lLvkO8GKFPW+fpS+DnhNrDH3XxImZWwyQ+vtfG7giZuOK6tH0sh9unERb8TTeW/2LmnUH90tVTvr+1D+hw0hPbsdF0UdZmtekR+bEzPRmF0eL1F4Tmsn1Vfc9BdJLq8jidHNY5utQtFGuqVG3J7l0eH9zgR7C3MJ2ny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503792; c=relaxed/simple;
	bh=bhPDkEYizj2vA6EDquDiMA1tOe2OrGhVbbRNZ4ZARqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOzjmPkX9NSKJOYUu57M3sxAb71bBAXSI1QNhQGB41qVyOP/bQowDOdM3+rz8u9SIh0chvBLywaG0a36fwCZCimmfJPyRwDH5rsS6RX8agNx9ZoGxEtAdsTNNAXQ4FSst0fvbEUsqF7JtLCtlN87MwC2ztKsZc1nSvN9XxjAdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6yRa7t7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68E11F00893;
	Wed,  3 Jun 2026 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503791;
	bh=fjNBJrIha85FqeqfaconIz7Vic1SQcjfH7ztG0j9Vs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L6yRa7t7mogM9ighYdBQmCkIt9fqp1OJ0h5+tX7DamlCaxGi+hVxDfMLKfurkqgmE
	 CxeHLLImQaPMHwW8h5zkZ8vc7y68e5sarzff2FNNyntogppqUJusHvigB8jvrgh25c
	 l8R2b8BdJpFZBbQCPUxU5lxKQzRc7imcM7gLrRTds7rtCRsD5iwq9ip/KMXRMe52z5
	 CU4F42GKIJlfwLTvZmJjTYIsg1ht5MGdwgm26q/aiEzeWBHRCjP/YDXAUGuK/odycx
	 kx/FTucI/2LhQVPZFBMORoAoABUnr1JUPtwhdzVrJl6rs1HK/wDUHfshg0pvysnjtb
	 8pxb2G6k4A0CQ==
Date: Wed, 3 Jun 2026 17:23:06 +0100
From: Simon Horman <horms@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Kito Xu (veritas501)" <hxzene@gmail.com>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH net] appletalk: aarp: zero-initialize aarp_entry to
 prevent heap info leak
Message-ID: <20260603162306.GF3766816@horms.kernel.org>
References: <20260529105017.81531-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529105017.81531-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294836-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hxzene@gmail.com,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F0C3639F91

On Fri, May 29, 2026 at 06:50:16PM +0800, Yizhou Zhao wrote:
> aarp_alloc() allocates struct aarp_entry without zeroing it, but only
> initializes refcnt and packet_queue.  When an unresolved AARP entry is
> created, hwaddr[ETH_ALEN] is left uninitialized.
> 
> aarp_seq_show() later prints this field with %pM when users read
> /proc/net/atalk/arp.  This can expose 6 bytes of stale heap data for
> each unresolved entry.
> 
> Fix this by zero-initializing struct aarp_entry at allocation time.
> 
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI generated review of this patch available on sashiko.dev.
However, the issues flagged there appear to be pre-existing and I do not
believe they should block progress of this patch.



