Return-Path: <netdev+bounces-97306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949E18CAAC2
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBF5280AA5
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EC35478B;
	Tue, 21 May 2024 09:26:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFB50A6E;
	Tue, 21 May 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283570; cv=none; b=KXfjc2kL4RSUUWGVR0Hu1l/pFbNgPC8N73a6CyQf4Hpl6AanDx7neAmdHf5Eb99xacUVh8S4HJ7Brz68HFFbMrVLV9tX1qyYOVYOQfr/z55GbL/nAvSXGGeYugGU+OhyO66pJQk8Onx0j2VYdoRJiH4lun2YOa0Gcp0NgEABs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283570; c=relaxed/simple;
	bh=qp8oBdFsawfuJIIVhfh79qxmfUvb81lWJfUIcUyDsCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVR3KxNtmeyKOP2H1nhiLqMjSpUg3u29lCdPRxNyqXOeSjxeQCBt6SucDjGVEdAQUSVI0MeiSlZ/qNgQzx9X6ia2LDP0IezLiRN9IWC7PWl/vM1WQ1rMH/xqe3pFVjx1ZHT8WLUzHHfEJRxmAsmyb6wkLn8n/wdIboiJ5JAhvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1s9Ljy-0007Zk-GI; Tue, 21 May 2024 11:25:11 +0200
Date: Tue, 21 May 2024 11:25:02 +0200
From: Florian Westphal <fw@strlen.de>
To: ye.xingchen@zte.com.cn
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org,
	ncardwell@google.com, soheil@google.com, haiyangz@microsoft.com,
	lixiaoyan@google.com, mfreemon@cloudflare.com,
	david.laight@aculab.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	fan.yu9@zte.com.cn, he.peilin@zte.com.cn, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn, yang.guang5@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: [PATCH net-next v2] icmp: Add icmp_timestamp_ignore_all to
 control ICMP_TIMESTAMP
Message-ID: <20240521092502.GB2980@breakpoint.cc>
References: <20240520165335899feIJEvG6iuT4f7FBU6ctk@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520165335899feIJEvG6iuT4f7FBU6ctk@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

ye.xingchen@zte.com.cn <ye.xingchen@zte.com.cn> wrote:
> From: YeXingchen <ye.xingchen@zte.com.cn>
> 
> The CVE-1999-0524 vulnerability is associated with ICMP
> timestamp messages, which can be exploited to conduct 
> a denial-of-service (DoS) attack. In the Vulnerability
> Priority Rating (VPR) system, this vulnerability was 
> rated as a medium risk in May of this year.
> Link:https://www.tenable.com/plugins/nessus/10113

Please explain at least one scenario where this is a problem.

AFAICS there is none and Linux is not affected by this.

> To protect embedded systems that cannot run firewalls
> from attacks exploiting the CVE-1999-0524 vulnerability,
> the icmp_timestamp_ignore_all sysctl is offered as

If there is an actual problem, then this should be on by default
or the entire feature should be removed.

But I don't think there is a problem in the first place.

