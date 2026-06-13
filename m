Return-Path: <netdev+bounces-299014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lq8MN9afLWr8hwQAu9opvQ
	(envelope-from <netdev+bounces-299014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:22:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4AB67F487
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:22:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="C/0Y3q6z";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299014-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299014-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E5CE3006157
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6432F7F0E;
	Sat, 13 Jun 2026 18:21:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BA26F29C;
	Sat, 13 Jun 2026 18:21:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781374876; cv=none; b=SSR3PzuVhN+dsYXWc47KS4IypVlS5Q1mj7IG/q8SFRL9tjlVjsWFQSuZZ8qR2FzB/uCFiCqE9cWz4cgcrkKikx0UIE7HGnD7arP1ccDDm/OauFnjK7DqWZfTiDydpRNjbkx3WGYhmX4YqKdrt12HRaXkNMumRFpF+jdwosdS0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781374876; c=relaxed/simple;
	bh=qCwndZHyXA6xUFuzUo1gjzi7k2UxYupYS00ajtitHeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9WgOrF7v3HihvgWmJjA7TCPZWkBaqENRVn79M6tSZrcQtP5Y3j0f1Vq0G5lwtFgqZ+VSx5t0Mfen/zROrBlVs2QpsbkjXULNylpByxEJTOGC0YGrrd4cDk3Z2o4ULgNsENyscArVkiaNHx31CCB2IxRCDFdjXQlovQpHpU6IeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/0Y3q6z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9811F000E9;
	Sat, 13 Jun 2026 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781374875;
	bh=blcmY51mUhrNozT7HIFdG8GhMoBehBU1E2kCKeAJ478=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C/0Y3q6zoX8+6dr7X6HlsOEXaGuN2o37Svsp5c6BPqYPmEKFYDs9bY8jLHaowmYVd
	 U5eWvCrGBgTzFjPADHSE7v/Glbzz1uMzIUvym6u+tE8pfmMydrj58yAkhJFLgaPBNU
	 OLFCsCnLd5OTCuzeF3XquFmZn5nU0cSo1iQbftzwMU4I9fbfyk6+eP+BStg6t16+aa
	 CQeetiMjwcj2zXtA8D+0lrWh3oWLHz1qYYugT5Kd6kcG6SXT9d0PEW6g6ymEpfuJZE
	 qe6yy1u6VG/NcwtUTpVv1tKcxyhBqoBcD8jWvwm+r5ud4TRP0nfc3AbF36TT0s7ecG
	 1uPDS8iIxXsnw==
Date: Sat, 13 Jun 2026 11:21:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: menglong8.dong@gmail.com
Cc: jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bjorn@kernel.org, kerneljasonxing@gmail.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce
 sk_tx_busy_loop()
Message-ID: <20260613112113.55d9313f@kernel.org>
In-Reply-To: <20260611071242.2485058-2-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
	<20260611071242.2485058-2-dongml2@chinatelecom.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299014-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,intel.com,fomichev.me,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:jasowang@redhat.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:sdf@fomichev.me,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A4AB67F487

On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
> For now, we use sk_busy_loop() for both rx and tx path. The sk_busy_loop()
> will call napi_busy_loop() for the specified napi_id. However, some
> nic drivers have tx napi, such as virtio-net. In this case, sk_busy_loop()
> doesn't work, as it can only schedule the NAPI for the rx queue.
> 
> Therefore, introduce sk_tx_busy_loop() for the nic drivers that support tx
> napi, which will schedule the tx napi if available.

First, I thought the only difference with Tx NAPI is that it can't be
busy polled. So if you want to poll an instance don't register it as 
a Tx one instead of adding all this "tx polling" stuff in the core?

Second, can this problem happen for any other NIC or is it purely 
an artifact of virtio's delayed Tx completion handling?

Third, this series does not apply.

