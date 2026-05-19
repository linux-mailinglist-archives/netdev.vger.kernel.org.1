Return-Path: <netdev+bounces-289637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDIoNhDlDGrIpgUAu9opvQ
	(envelope-from <netdev+bounces-289637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:32:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A0585ABE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74BAC308F774
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA372F0C62;
	Tue, 19 May 2026 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPiwVpye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C8343889
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229819; cv=none; b=FFZQuqzqHfGjItz3070Z4hnB9H+cdb9dzmwdi9Va7AIvSp3XLEJeT49EKuQMAg6U2ZuFHl1q+fpeTRBP4zcMUqd3qiK5k3TfQ5s6gN6guxnPqAIZkZ0WnE1k9DA/mA1JTuzl9GEbDhBObrs26VTicQRmjkAMpU92B7zyOEbP0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229819; c=relaxed/simple;
	bh=dAzRsYKuGvBreymHNHss5IcwlKD66sCyBOROx6Sy04c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAPOMAH+IR4xwM60zf7gY4MphKDEarsWX+GXM5okj+QrPhageHMOqU2Pxo3G3Qk5rmFbX/J2s/0AHOoEE3H3M1S22VuW/Hh6Df4zOWGTGJtMkNIn+nlcouBU/AgqTdynYnlhHjC9C7AaTLwV0uxkRH9aNeaC7O5/N66lZjE2UT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPiwVpye; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6361F000E9;
	Tue, 19 May 2026 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229818;
	bh=b+uPr2wEeLMmo//EeABgKX4QMdU6Ywquwv2EaKNSEPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QPiwVpye9b1nrk6WGzVhcFGtfMK+T+qkvAZ6e5+55RJaYsDtxkze4Jg6jeFZGHqV+
	 iwNMIFnlKE3vjW8oKkOML2pYGjbF6z9QbsrCjAH0Dtu/yk2iOiho8FzUP97JFsIZgQ
	 PMCwn3siyfeIWpXjvUHbXHRwjivfY8+rjEWUkTAobklb4/L53+XgYHaQGUmABnwsmy
	 dZ4RGmIuqIevkEFzKo/tIgEwHNxva+nMP38oYB1Er3edqHk+lwME3AwVgiEVtLvOIB
	 An88/74gaumrBG/Rsn4Wy86nYpG3vER1RmUl6+qTToymv3dbuP+iR1cSus4Eeeu906
	 RXVcyw6YN6b/g==
Message-ID: <c5dd5dd8-44ec-45da-9e5e-5adbdceffab4@kernel.org>
Date: Tue, 19 May 2026 16:30:18 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: use WARN_ON_ONCE() in ip_rt_bug()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260519193248.4018872-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260519193248.4018872-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-289637-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AC9A0585ABE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 1:32 PM, Eric Dumazet wrote:
> It turns out ip_rt_bug() can be called more than expected.
> 
> syzbot will still panic (because of panic_on_warn=1), but non debug
> kernels will no longer die while repeating stack traces on the console.
> 
> Fixes: c378a9c019cf ("ipv4: Give backtrace in ip_rt_bug().")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 



Reviewed-by: David Ahern <dsahern@kernel.org>


