Return-Path: <netdev+bounces-57245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D7A81289E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 07:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8CEB2100C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571DDD300;
	Thu, 14 Dec 2023 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHXKzQnF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4384AE8
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 22:57:42 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35f7589ea1fso4636125ab.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 22:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702537061; x=1703141861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7EQpfToCPi875phSgWlU8vZ8kyxr5QzsLRRCr8c8PA=;
        b=iHXKzQnFD/Paz6VE4pxmcHWfftJRVubKbmi86X/x7hrYBEYQXSUKukPuLp7SRsp6Zp
         h1OhE1gFzCI2rYIyeMMrbddo2le9yd2Nf2HCDVGZGGXGzlsjCnUHZEZMeYJZfGxMHMQ9
         McAM2jeUeRROSK2ylpkJY71by0KhpNnJatlXuckH7+JqFuLxtQ9XG2MkdWPmzkgCTSx+
         /byHqWExn9Ll23txnTHk8T7Cy5UYHSD1FLzWCPQyDuiHuQQ/u7jGVKmaZ2LhbNJ6hSe3
         5tMiSWjMuS3wjVuwlfQxsBnptdTgLK6CuHVmecV04o31YNh2Dip8bPAO9C3WftJSgB3O
         yn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702537061; x=1703141861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7EQpfToCPi875phSgWlU8vZ8kyxr5QzsLRRCr8c8PA=;
        b=B6XDmhji+fInKjgCQ2Dp2SpfWE1dxXu0cKqyqsk2/k+zesovVU6Pr8zVt6lGUvnpbS
         CZuUeXA6NA+9zqY03TBuXcekdJiCMnkJCMwBH753XNrsbN2ixnHAZM37Pl0zJY3lYLWs
         qoEPz1uPZWxav6r9F2OVCmQvace5vwpfPOM65uXR8UA5ZduSxzZlrNonWb2V64sduAAk
         Q9KbAjAQO+4WTs8gX1ZwUM15q1dh2NeeIgZ0/SelYusTc5tbLsZEGmQVnqdHxPU9u7BT
         bX9lbn/e01dLwz4KH8dRSNGnlzeBqB9GQEFZlokT9VpXL1IA0plun3SBREfiP8k6rFVW
         /kww==
X-Gm-Message-State: AOJu0Yza/1hF/Qswj28RbBWAeWFEKK605UN7s5Zny/FDulVS4IwEmqSl
	TKXFMiFmxBXX1lolTmhEB+8=
X-Google-Smtp-Source: AGHT+IFvCpRRyHgU4n6DK37uhW5uc4s77MHi05Iw4s3L7rXqrXrIGLlT2FHX2wTDEn7D/LNtQm1faA==
X-Received: by 2002:a05:6e02:e4e:b0:35f:7475:5858 with SMTP id l14-20020a056e020e4e00b0035f74755858mr2088919ilk.61.1702537061424;
        Wed, 13 Dec 2023 22:57:41 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bh2-20020a170902a98200b001cfc34965aesm7927515plb.50.2023.12.13.22.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:57:40 -0800 (PST)
Date: Thu, 14 Dec 2023 14:57:30 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Petr Machata <me@pmachata.org>,
	Benjamin Poirier <benjamin.poirier@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com, Jonathan Toppins <jtoppins@redhat.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <ZXqnWsRLam2kVcqw@Laptop-X1>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
 <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3>
 <877climn45.fsf@nvidia.com>
 <87y1dyl635.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1dyl635.fsf@nvidia.com>

On Wed, Dec 13, 2023 at 11:31:50AM +0100, Petr Machata wrote:
> Hmm, maybe we could side-step the issue? I suspect that vast majority of
> what bonding uses are just generic helpers. log_test, check_err, that
> sort of stuff. Unless I missed something, all of them set NUM_NETIFS=0.
> Those things could all be in the generic net/lib.sh. So long-term it
> might be possible for bonding to do the trick with symlinking, except
> with just net/lib.sh, not both libs.
> 
> I think that most of forwarding/lib.sh actually belongs to net/lib.sh.
> We reinvent a lot of that functionality in various net/ tests, because,
> presumably, people find it odd to source forwarding/lib.sh. If it all
> lived in net/, we could reuse all these tools instead of cut'n'pasting
> them from one test to the other. Stuff like the mcast_packet_test,
> start/stop_traffic, etc., would probably stay in forwarding.
> 
> So that's long-term. And short-term we can live with the ugly-as-sin
> workaround that I propose?

For bonding only I think this is a good resolution. For other driver tests
that may still need to include forwarding/lib.sh. I think the way Benjamin
suggested is a good choice.

Thanks
Hangbin

