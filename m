Return-Path: <netdev+bounces-279251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNJYF2Ti4WlUzgAAu9opvQ
	(envelope-from <netdev+bounces-279251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:33:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28148417F45
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84848304A67D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78836375ACF;
	Fri, 17 Apr 2026 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="rq83WVmT"
X-Original-To: netdev@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD3377EDF
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411213; cv=none; b=sEhXX5R1ixqJ88dIPH9HSTWsjGunjwKRcl6kLQ7kbl3xvDEtNA5K77V8dU7h+gWjzrpcMtzZWawrpG21VXsLHMvAN6gBQTFQjTI94XdZ9ISFAPXDBeDi3sntxVtNX5JXg7CbEIaIkIPx7fDDqupyAxvtFAfc2r7980XFfDy0MPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411213; c=relaxed/simple;
	bh=UnCYp3+W2633JQtIPdpsWm7iCdn6zJj4NmATD/Xnsmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOv+VNmg+7vhxtJU18ECRpVQu4vhC6j5H/P/PbFsEkNwz3s7mqr69kxeJ/34ZiJU4whwLMasFp12NnLVdj/d8hB6L4Aw3QYCgn3Ko2k5VBCc7lKTKCyVsLnMysU2eAZgAVzpk9ZMG8RCjTb4/LKGhn0YKmkIbpsxBTXFPiCI1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=rq83WVmT; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1776411201; bh=MOhanKb6AZLhOyaPqPoQAbJ1wsyGCGvKin3rNvvfWHE=;
	h=From:Message-ID:From;
	b=rq83WVmTT/Ll0u894xftVzBQsLLKnahiHR7FYGPl9FXcF5J9zM+MlkfVyfbU4R704
	 /SHbentLGlaWFPHdRC7U5vflGD8nIuw1NYxUSnpifg1EJW2YlmUx+yvalaqgu1l2Is
	 8tGWVSyb7JD06PLLuugAxMjNMSSl1g/StrEkWJS4=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id A3785C0D1F;
	Fri, 17 Apr 2026 09:33:21 +0200 (CEST)
Date: Fri, 17 Apr 2026 09:33:21 +0200
From: Willy Tarreau <w@1wt.eu>
To: plantegg ren <renxijun@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org
Subject: Re: TCP default settings (bugzilla)
Message-ID: <aeHiQag9Os_BvB0B@1wt.eu>
References: <CAMrUUotdnC+Gv3oud75Ns3BMiOCEo+_fNYX4_L=r=YhtyzZ0Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMrUUotdnC+Gv3oud75Ns3BMiOCEo+_fNYX4_L=r=YhtyzZ0Qw@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1wt.eu,none];
	R_DKIM_ALLOW(-0.20)[1wt.eu:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[1wt.eu:+];
	TAGGED_FROM(0.00)[bounces-279251-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w@1wt.eu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 28148417F45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 03:01:08PM +0800, plantegg ren wrote:
> Hi,
> 
> One more real-world data point that just happened two weeks ago,
> directly related to tcp_keepalive_time.
> 
> AWS recently rolled out Nitro V6 (8th-gen EC2 instances) which reduced
> the ENI connection tracking timeout from 432000 seconds (5 days) to
> just 350 seconds:
> 
>   https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html
> 
> Our MySQL/HikariCP connection pools started seeing intermittent timeout
> errors every 20-30 minutes after migrating to 8th-gen instances. We
> captured packets on both client and server simultaneously. Here is what
> we found on a single connection (idle for 818 seconds, well past the
> 350-second ENI timeout):
> 
> Server side -- MySQL receives the request and sends responses normally:
> 
>   #270  71.51s  10.23.99.71 -> 172.20.64.240  [ACK]     last activity
>                   ~~~ connection idle for 818 seconds ~~~
>   #271 889.94s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  client
> request arrives
>   #272 889.94s  172.20.64.240 -> 10.23.99.71  [PSH,ACK] len=11 server
> responds OK
>   #275 890.15s  172.20.64.240 -> 10.23.99.71  [PSH,ACK] len=11 server
> retransmits
>   #278 890.59s  172.20.64.240 -> 10.23.99.71  [PSH,ACK] len=11 server
> retransmits
>   #281 891.02s  172.20.64.240 -> 10.23.99.71  [PSH,ACK] len=11 server
> retransmits
>     ... (server keeps retransmitting, client never ACKs)
> 
> Client side -- sends request, but NEVER receives any server response:
> 
>   #267  71.51s  10.23.99.71 -> 172.20.64.240  [ACK]     last activity
>                   ~~~ connection idle for 818 seconds ~~~
>   #268 889.94s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  sends request
>   #269 890.15s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  retransmit 1
>   #270 890.37s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  retransmit 2
>   #271 890.79s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  retransmit 3
>   #272 891.65s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  retransmit 4
>   #273 893.38s  10.23.99.71 -> 172.20.64.240  [PSH,ACK] len=5  retransmit 5
>   #274 894.94s  10.23.99.71 -> 172.20.64.240  [FIN,ACK]         gives up
> 
>   Zero packets from 172.20.64.240 after the idle gap. Zero RSTs.
> 
> The ENI silently drops all inbound packets (server -> client) because
> the connection tracking entry expired after 350 seconds. Outbound
> packets (client -> server) still pass through, so the server receives
> the request and responds -- but its responses are black-holed by the
> ENI. No RST is sent, so both sides are completely unaware.
> 
> If tcp_keepalive_time were lower than 350 seconds, the keepalive probes
> would have kept the ENI tracking entry alive, and none of this would
> have happened.
> 
> The trend is clear -- middlebox idle timeouts are getting shorter (AWS
> went from 432000s to 350s overnight), while tcp_keepalive_time has
> stayed at 7200 seconds for decades. The gap is widening.

It's up to the application to configure the keepalive interval if it
is relying on long connections, it's done using TCP_KEEPINTVL, and if
you're dealing with an application that doesn't expose the setting,
you indeed still have access to the system-wide setting above.

It's been well-known for at least two decades that no middle box could
sanely keep idle connections forever with the amount of traffic they're
seeing. 25 years ago I was already tuning the conntrack timeouts for a
bank firewall that was dealing with only 6k connections per second so
as to stay within reasonable memory sizes while keeping a good quality
of service. There's nothing new here.

Willy

