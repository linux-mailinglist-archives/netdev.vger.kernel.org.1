Return-Path: <netdev+bounces-305591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ix6iE0JcTWqXywEAu9opvQ
	(envelope-from <netdev+bounces-305591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 22:06:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FE571F790
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 22:06:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305591-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305591-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9743530128E5
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 20:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766EB3D4133;
	Tue,  7 Jul 2026 20:06:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266A3B9D9E;
	Tue,  7 Jul 2026 20:06:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454781; cv=none; b=fbx47/HJ6L4cPlXr69jrdBDLK1NBaCDR5oReexNTcv9K5lKJ+sdbTWTiTOnDrmHQwEFyekGXDSFRK+Omy+xZlXvv72ZuJgeD5vGB0zRhGNDr/ezKNryRn6CvpcL1GNB1pvPzUp3ivVOpYm24ZPxdk5x2kp80G4pLqla26YMX0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454781; c=relaxed/simple;
	bh=WYqFwOi8quQy3Uk+VrFiQW/eZL0UWoAEItTKR3fuMzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy8TqWheW8kwIolC9mWpORCFQdMbKhyFh/Jx477/vuAMWS6Wiw2FxCuqca+Bg0MDUVifLgpXcm34pkLwF4KIew60wTHGzAr6Yn9EymHxgrGES57kpWVjiL7Uu82MGZVyZIGPX2/v3pb/XHi+g3+ey+hxaj2ZCuileydb+YHcRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Date: Tue, 7 Jul 2026 22:05:52 +0200
From: Brett A C Sheffield <bacs@librecast.net>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <ak1cIAwQzKS35x0m@karahi.librecast.net>
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
 <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
 <20260706091706-mutt-send-email-mst@kernel.org>
 <2728c540-2e76-4e06-9064-ed1dff071cbe@tu-dortmund.de>
 <akvhhy_JpH64KrcL@karahi.librecast.net>
 <0d28fdc4-3c03-48d6-bd59-e59f7a01f4b6@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d28fdc4-3c03-48d6-bd59-e59f7a01f4b6@tu-dortmund.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305591-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:mst@redhat.com,m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[librecast.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bacs@librecast.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,lunn.ch,tu-dortmund.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bacs@librecast.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97FE571F790

On 2026-07-07 08:52, Simon Schippers wrote:
> Brett, can you try the two attached patches here with iperf3?
> I think testing with 8 and 16 threads is enough, so where there is a
> regression.
> 
> The two patches are about time when to wake:
> Currently we wake after consuming half the internal ring buffer.
> One of the attached patches wakes after 2 cachelines (128 of 1000
> packets) and the other one just wakes once the ring buffer is empty.
> 
> This would really help :)

Sure...


7.2.0-rc2 (unpatched)

threads 1
[  5]   0.00-10.00  sec  20.4 GBytes  17.5 Gbits/sec    0            sender
[  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver

threads 2
[SUM]   0.00-10.00  sec  12.7 GBytes  10.9 Gbits/sec    0             sender
[SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver

threads 8
[SUM]   0.00-10.00  sec  11.5 GBytes  9.85 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  11.4 GBytes  9.83 Gbits/sec                  receiver

threads 16
[SUM]   0.00-10.00  sec  11.6 GBytes  9.95 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  11.5 GBytes  9.91 Gbits/sec                  receiver


7.2.0-rc2 with 0001-tun-set-waking-threshold-to-ptr_ring_empty.patch

threads 1
[  5]   0.00-10.00  sec  19.6 GBytes  16.8 Gbits/sec    0            sender
[  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver

threads 2
[SUM]   0.00-10.00  sec  11.1 GBytes  9.50 Gbits/sec    0             sender
[SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver

threads 8
[SUM]   0.00-10.00  sec  10.8 GBytes  9.25 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  10.7 GBytes  9.23 Gbits/sec                  receiver

threads 16
[SUM]   0.00-10.00  sec  10.9 GBytes  9.34 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  10.8 GBytes  9.30 Gbits/sec                  receiver


7.2.0-rc2 with 0001-tun-set-waking-threshold-to-tx_ring.batch.patch

threads 1
[  5]   0.00-10.00  sec  19.6 GBytes  16.9 Gbits/sec    2            sender
[  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver

threads 2
[SUM]   0.00-10.00  sec  13.9 GBytes  11.9 Gbits/sec    0             sender
[SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver

threads 8
[SUM]   0.00-10.00  sec  12.7 GBytes  10.9 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  12.3 GBytes  10.6 Gbits/sec                  receiver

threads 16
[SUM]   0.00-10.00  sec  12.5 GBytes  10.7 Gbits/sec    0             sender
[SUM]   0.00-10.00  sec  12.4 GBytes  10.7 Gbits/sec                  receiver



HTH,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

