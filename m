Return-Path: <netdev+bounces-99232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3427D8D42B2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91900B250CB
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABE0E56C;
	Thu, 30 May 2024 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="enXq+bZn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798CD1BF31
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031324; cv=none; b=d8htbPQCXiM9HkC6NRcwYEHK4wB3HpDsh2HmzAMaQdnFc6EmTyGXL/Vl5PHsR7cqLs3P7tO2uM2LodTThr9f9NZNFM6dajjR2+OAVzejURFvjzz1L1IBSWofQK3pTYRL8k9ulLDH59U+xZAVDcJTcopZ2WQpwNnYn7ic2kmNKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031324; c=relaxed/simple;
	bh=gB8bEZ610lVZ71qkLuw5KH4taGnGkatOCo0aPaqZfXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su6Uw+8UerAaoPyVofuz1edEtvIa4ZKAry6X135/JZyl6Y2dm1RBlH0i6JF64iScOS2dD8XQTlYDQUqV8+yo5QJ4XqBV43MB0GkjgoNaav0IWLD300OBmWN9c8KyyxH7t1Ckl6BwoT5EJE5hlioXz85kAVdvaTTFIrbyqphP5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=enXq+bZn; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717031317; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=NJlhl3JN8DSamcWsAYlYUUsgJOlGWpH3hXAQCcvri6E=;
	b=enXq+bZnXo0EuV4ZgB8hlkPalMg5FDA2qbxpw1Q+h9ftQxDeA2fvaYcAZln2Wm4caVMmqi256XkG3pBRIRllV2yEQvtDQzolhuXZYR0IB2TOverDv9sqha0ccHKbczlSqMS1bcczqhuyjAHEM4JNDv0cvsLrDbSC7QDGsmAanuw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7Uw2OM_1717031316;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0W7Uw2OM_1717031316)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 09:08:37 +0800
Date: Thu, 30 May 2024 09:08:36 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kevin Yang <yyd@google.com>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
Message-ID: <ZlfRlHmfc7ZTd9LL@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20240528171320.1332292-1-yyd@google.com>
 <ZlbXeytf4RkAI40N@TONYMAC-ALIBABA.local>
 <CAL+tcoDBdRyrzEtkkZ-9orffzts43-0EKajSpu3-dAVYgMECbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDBdRyrzEtkkZ-9orffzts43-0EKajSpu3-dAVYgMECbg@mail.gmail.com>

On Wed, May 29, 2024 at 04:49:39PM +0800, Jason Xing wrote:
> On Wed, May 29, 2024 at 3:21 PM Tony Lu <tonylu@linux.alibaba.com> wrote:
> >
> > On Tue, May 28, 2024 at 05:13:18PM +0000, Kevin Yang wrote:
> > > Adding a sysctl knob to allow user to specify a default
> > > rto_min at socket init time.
> > >
> > > After this patch series, the rto_min will has multiple sources:
> > > route option has the highest precedence, followed by the
> > > TCP_BPF_RTO_MIN socket option, followed by this new
> > > tcp_rto_min_us sysctl.
> >
> > For series:
> >
> > Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> >
> > I strongly support those patches. For those who use cgroup v1 and want
> > to take effect with simple settings, sysctl is a good way.
> 
> It's not a good reason to use sysctl.
> 
> If you say so, why not introduce many sysctls to replace setsockopt
> operations. For example, introducing a new sysctl to disable delayed
> ack to improve the speed of transmission in some cases just for ease
> of use? No, it's not right, I believe.
> 

Hidden behind the words is that if I am a kernel engineer or SRE helping
users troubleshoot latency issues, and I need to tune tcp_rto_min, then
my only means of not intruding on the application are eBPF or the sysctl
mentioned here.

Comparing sysctl and eBPF, I prefer sysctl isolated by net namespace,
which can be modified and verified more directly and quickly. eBPF is
powerful, but it is not easy to write, debug and manage.

> >
> > And reducing it is helpful for latency-sensitive applications such as
> > Redis, net namespace level sysctl knob is enough.
> 
> Sure, these key parameters play a big role in the TCP stack.
> 
> >
> > >
> > > Kevin Yang (2):
> > >   tcp: derive delack_max with tcp_rto_min helper
> > >   tcp: add sysctl_tcp_rto_min_us
> > >
> > >  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
> > >  include/net/netns/ipv4.h               |  1 +
> > >  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
> > >  net/ipv4/tcp.c                         |  3 ++-
> > >  net/ipv4/tcp_ipv4.c                    |  1 +
> > >  net/ipv4/tcp_output.c                  | 11 ++---------
> > >  6 files changed, 27 insertions(+), 10 deletions(-)
> > >
> > > --
> > > 2.45.1.288.g0e0cd299f1-goog
> > >
> >

