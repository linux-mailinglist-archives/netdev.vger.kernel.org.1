Return-Path: <netdev+bounces-33125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9F679CC66
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F291C20E49
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4047168C0;
	Tue, 12 Sep 2023 09:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D847B168B4
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:50:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 518D610D1
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694512220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybhEwqUaCIlKWS1bect2pWaHzY1Og7UtHvV2q1VDcqg=;
	b=Cy/IPqvg7omt2BG2VQsPaiqMYsmc6HPlZYJAeIHauNgPeVv6RG2t0KTsZGSh3X1OwTW9Dg
	Kf7ZhXD+cItUyjmEzg1QzHh7zxWVqQpa0Ceg8dKVdqp5yx3h6WBcWfckkN3xoxWkdGtdlb
	V6oxU7A7o84m75RiRzwuKC/iLssQ99U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-w7-QzarmMRClFcVESy0Dww-1; Tue, 12 Sep 2023 05:50:19 -0400
X-MC-Unique: w7-QzarmMRClFcVESy0Dww-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2f2981b8364so3582555f8f.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694512217; x=1695117017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybhEwqUaCIlKWS1bect2pWaHzY1Og7UtHvV2q1VDcqg=;
        b=SdSkSDB9u+hrI7FJ/IZRK9LMOEtlwN3lM6U9OuLNF0ZBqTleUURWmj5Ckpg84VamV/
         mref07oMb/jiufGQ8vDT94bib6DRNJt/+fmQBVrFFT02+y1SC8tQl2JOAAftUh4pVkAH
         dqDbR4QoBWoCX+LszETwKmf97Z95JOuik99MRZRkhlGhvgEa7Pxn27zRgkeCV5MxwGve
         4B/mlDlGPa6UhgYEi+yk2EtiRSRB4KrmgAsfq6mU3paaAeZQ7PATrBJjr34VWUvJT8ei
         IsJtybBeTrgjOoQGMIb8JoHQKAJ3hPHPKv6ASXA52+KQxv1qeoKmQYBnKQGSXVyJxlmC
         obNg==
X-Gm-Message-State: AOJu0Yzb5bQbiq0MBKa9pIpiCe89EzTyPBxvmZY7eT3GP0h0PYga26L7
	XVET/sH8HjFy4y5z7g4w4d/+rl/IGllMNPQT0uELHcj0wuhYwmNHNEsry6vFyBeg3yOPpxOdf1b
	8vHcT3PaHPdi3WUJtlWHEk0c+
X-Received: by 2002:a5d:4309:0:b0:317:ef76:b773 with SMTP id h9-20020a5d4309000000b00317ef76b773mr8616014wrq.45.1694512217703;
        Tue, 12 Sep 2023 02:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS3z+qx7QqCGr69WMu1UhKSZqeOS+/Y9UpYmjmP/FKx7vkNna5tM7mBG2iBfXVe2TBUTetGQ==
X-Received: by 2002:a5d:4309:0:b0:317:ef76:b773 with SMTP id h9-20020a5d4309000000b00317ef76b773mr8616005wrq.45.1694512217390;
        Tue, 12 Sep 2023 02:50:17 -0700 (PDT)
Received: from debian (2a01cb058918ce00679c89a1e344d998.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:679c:89a1:e344:d998])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600000c600b00317f29ad113sm12290520wrx.32.2023.09.12.02.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:50:17 -0700 (PDT)
Date: Tue, 12 Sep 2023 11:50:15 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Tj <linux@iam.tj>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: IPv6 address scope not set to operator-configured value
Message-ID: <ZQA0VxB1hVqH2o/9@debian>
References: <f878ef3c-d11b-b1de-fa02-d9617308d460@iam.tj>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f878ef3c-d11b-b1de-fa02-d9617308d460@iam.tj>

[ Cc: David Ahern, who might have an opinion on this]

On Fri, Sep 08, 2023 at 06:02:00PM +0100, Tj wrote:
> Using iproute2 and kernel v6.5.0 with Debian 12 Bookworm amd64
> (tested also with v6.136 nixos) setting scope on an IPv6 fails
> silently with no indications as to why and the address is configured
> with what appears to be a scope based on the prefix (usually 0 but
> for fe80::/16 addresses scope is set to 253). Doesn't matter whether
> using scope names (from /etc/iproute2/rt_scopes) or numbers. Similar
> command for IPv4 succeeds.

I don't think we could let the user manually set the scope of IPv6
addresses. As you realised, with IPv6, the scope is automatically
derived from the address.

I had a patch to reject IPv6 netlink commands that have a scope
attribute. I've never sent it though, as I was affraid to break
existing users. But now that I read your message, I feel that maybe
we'd better explicitely reject such commands instead of silently
ignoring the scope. That'd avoid this kind of misunderstanding.

If anyone feels we should reject the scope attribute when adding
IPv6 routes or addresses, just let me know and I'll send this patch.

> ip address add fddc::2/64 scope 200 dev PUBLIC
> ip -N -6 address show dev PUBLIC
> ...
> inet6 fddc::2/64 scope 0
> 
> I used `gdb` to trace this expecting somehow the scope was not being read correctly but it is:
> 
> 2577            if (!scoped && cmd != RTM_DELADDR)
> (gdb) p scoped
> $22 = <optimized out>
> (gdb) p cmd
> $23 = <optimized out>
> (gdb) n
> 2580            req.ifa.ifa_index = ll_name_to_index(d);
> (gdb) p req.ifa.ifa_scope
> $24 = 200 '\310'
> ...
> 2607            if (echo_request)
> (gdb) n
> 2610                    ret = rtnl_talk(&rth, &req.n, NULL);
> (gdb) p req.n
> $25 = {nlmsg_len = 64, nlmsg_type = 20, nlmsg_flags = 1537, nlmsg_seq = 0, nlmsg_pid = 0}
> (gdb) p rth
> $26 = {fd = 3, local = {nl_family = 16, nl_pad = 0, nl_pid = 2381950, nl_groups = 0}, peer = {nl_family = 0, nl_pad = 0, nl_pid = 0, nl_groups = 0}, seq = 1694191286,
>   dump = 0, proto = 0, dump_fp = 0x0, flags = 4}
> (gdb) s
> rtnl_talk (rtnl=0x5555555f7020 <rth>, n=n@entry=0x7fffffffe140, answer=answer@entry=0x0) at ./lib/libnetlink.c:1170
> 1170    {
> ...
> ipaddr_modify (cmd=<optimized out>, flags=<optimized out>, argc=<optimized out>, argv=0x7fffffffe478) at ./ip/ipaddress.c:2612
> 2612            if (ret)
> (gdb) p ret
> $27 = 0
> 
> 
> 
> 
> 
> 


