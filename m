Return-Path: <netdev+bounces-296503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NiZrDZeqJmpXawIAu9opvQ
	(envelope-from <netdev+bounces-296503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:42:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A25655CB7
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:42:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=TXq6LN+Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296503-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296503-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51B643080FA0
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5548232F76D;
	Mon,  8 Jun 2026 11:30:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6631D39A
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 11:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918219; cv=none; b=Kzk3b9A+cyUJ3AHwalZYW94i6wLhBHw+RhpvolPqdCLFqgFVN78rNLbSVycIfVuEVhHqADRcsKUqnUcpjBrjtiIdaA1mjTwUdhcjf5Vp5Y9QDYi4FCr82HMdxLPoGpw3EvxBY7qFknaWL7iUbfj6pclLN1FZKzLyaqK2/eIZwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918219; c=relaxed/simple;
	bh=tyd3+C+BS5PJiTMQDRxszaKye425T2FF388CJYSrqZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS++xiuI8i6LDJpinbbuOw2st2bLgpEyYUMKS/1XBI2iLhDxAEX6ZVfGxw/iVmyuFERsXj3+ciX2+z2C7oV8CBaZvWyeGNHicnqZK49cgzwpgknVbF6e1Fg926FB4r8zfT0XvcjQHc4qVg+cVnlgyHsCvTD5hFYcxaJcfjmR0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=TXq6LN+Y; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id E15DF600B9;
	Mon,  8 Jun 2026 13:30:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780918208;
	bh=lCgLJ9gaJT240/Ypm+XErlk+f+KAtV1QE9O1XyfhvUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXq6LN+YF+NoldgpNc2UFQB5Hmhek7UpzXOxBlueYnVcWDKxehLh4erYXsA5hmnxf
	 uBgpth/A9c8ss7D148H8KhLX00Dd9ST/e7M693GD0unJRL1oBUWSOExFnPF2+XIf8v
	 I2fET26pniKsqygwNf2GDV1q84uD5E6lQWNGjx5+LJl09xDaz3mYuvS/xpjlEqJiqe
	 nJK8m9Eio8bDAaw+gaOG5vlKD7dspyRMYp8/POlFzEKdFucDGKYpZMfVoPgs7TlJmz
	 5150ooso0rNQrz0GfWgf96xrakPFMw4MwMfAL4y9/LTO2ESRHIJjCUxDDGi3kJ+isR
	 6kea7HVby5StQ==
Date: Mon, 8 Jun 2026 13:30:05 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: xietangxin <xietangxin@yeah.net>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Willy Tarreau <w@1wt.eu>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Zhouyan Deng <dengzhouyan_nwpu@163.com>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
Message-ID: <aianvVzqzZbOaeR0@chamomile>
References: <20260302205527.1982836-1-edumazet@google.com>
 <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
 <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URL_NUMERIC_IP(1.50)[10.0.0.1];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xietangxin@yeah.net,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:w@1wt.eu,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:dengzhouyan_nwpu@163.com,m:fw@strlen.de,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[yeah.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,1wt.eu,vger.kernel.org,gmail.com,163.com,strlen.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296503-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,yeah.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17A25655CB7

Hi,

On Mon, Jun 08, 2026 at 01:51:49AM -0700, Eric Dumazet wrote:
> On Sat, Jun 6, 2026 at 4:06 AM xietangxin <xietangxin@yeah.net> wrote:
> >
> >
> 
> > Hi Eric and netdev,
> >
> > I noticed a significant TCP performance regression (QPS drop) when using
> > iptables MASQUERADE with the `--random-fully` option, and I have bisected
> > it down to commit 165573e41f2f66ef98940cf65f838b2cb575d9d1
> > (tcp: secure_seq: add back ports to TS offset).
> >
> > Here is the benchmark environment and test results.
> > Environment:
> > - Client & Server: 2 VMs
> > - Server: Nginx listening on port 80 (HTTP), and ip 10.0.0.1
> > - Benchmark tool: wrk (short-lived connections with "Connection: close")
> >
> > Test Commands
> > 1. With random-fully:
> >    # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE --random-fully
> >    # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
> > 2. Without random-fully:
> >    # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE
> >    # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
> >
> > Test Results (QPS):
> > 1. Parent Commit (7f083faf59d14c04e01ec05a7507f036c965acf8):
> >    - with random-fully:    18145.74, 15006.39, 15716.67
> >    - without random-fully: 18556.36, 16339.22, 21506.02
> >
> > 2. Bad Commit (165573e41f2f66ef98940cf65f838b2cb575d9d1):
> >    - with random-fully:    11074.76, 10383.20, 10164.81  <-- (~35% drop)

Can you check where the packet drops are coming? There are several
tools (iptables trace if it is the ruleset, dropwatch, etc.) to check this.

> >    - without random-fully: 17310.75, 20279.85, 18399.48
> >
> > Is this performance degradation an expected side-effect of the security fix,
> > or is there any sysctl param we should tune when `--random-fully` is
> > required for high-concurrency short connections?
> 
> Hi Tangxin
> 
> I do not know why that patch would affect MASQUERADE performance.
> 
> Pablo, Florian, do you have an idea?

With this information, not yet.

Thanks.

