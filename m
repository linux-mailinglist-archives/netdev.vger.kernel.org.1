Return-Path: <netdev+bounces-56723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C7D8109C9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 07:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A53B281E42
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 06:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741ACA75;
	Wed, 13 Dec 2023 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCgtkOrn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98811E8
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 22:00:33 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ce9c8c45a7so4149257b3a.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 22:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447233; x=1703052033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1tpU5oHIKSe0uL7Xtwu6c19b9/8qpoX6u95GVArN0+g=;
        b=OCgtkOrnAuuCbp2jb+j1wz7++xmUztYg40KPIWkOWZSK+gNRWoqIEZhKtc12NfY+QR
         YIMyMr0H6kw0Dy65JAnHvIlxN8nWJ5u6U7SpZUp2YMPwtAkXSamyq03lazHUuaEfc84x
         YVPyuzE/q+wpr+gB//JQbdMb26xdupXuhFqZwSi+7f9K/YAnOq76aTyw9Cl91seVYtIN
         KBw9ajHXw6uDv/m8AhaFwGbABHgOW3Y08tOOz9yPjXriAy7062p+We1aPCyWF6KBYlQo
         q8HQJSxua/76KeGiD4u4EK1sV3BTZaV+fos/vvwsKvY7rZ9/63FQUNAkt+HaKWfSWq9d
         dZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447233; x=1703052033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tpU5oHIKSe0uL7Xtwu6c19b9/8qpoX6u95GVArN0+g=;
        b=bIxahy+cb8+3GOa6XfnjLwP5HVIyDk4NVpgXcQzvw5Afg754pQvPp5ONWyrYPvXo2w
         xjcNtpYM+3m0Jo99yomUEI3XFu2zTUf+FGw1bCoDH1nBRXVvJLS0w3NacD6REuPgDU1L
         FKBK3Hizkr3IEbakpjEHWne8k5H+2uErDt9HIgFywrxKvQofIZCBPhtt5IELg6r99QIp
         LT8cBr7JbYIA5BZ8xcpjic3GmIIYRbjMz8vN0A09vrLvotwrS/gnhrn+aiAFY2kp1MEi
         WIk9qE2dQH+sDbkSB6mrHWCKGwZHhRPldhvPHoayu1yV1n04R62q2T7NMU/J9drCYC8S
         SVkA==
X-Gm-Message-State: AOJu0YwRPL8SWXALDXruQ4YMC+rjCNuSXAEiECZPcmK/zq1TEYLCqKT/
	rFQTEgbdK12L1rMod12k4rg=
X-Google-Smtp-Source: AGHT+IFMJRYqmjBiG9EYDEfVB14WXmGUq5SvDhRSxMRXpA4VgtDpWp9zkF4xNl21/MXdsLSU4PVCKw==
X-Received: by 2002:a05:6a00:170a:b0:6c4:d12c:adf0 with SMTP id h10-20020a056a00170a00b006c4d12cadf0mr4611526pfc.33.1702447233001;
        Tue, 12 Dec 2023 22:00:33 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b4-20020aa78704000000b006ce41b1ba8csm9024030pfo.131.2023.12.12.22.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:00:32 -0800 (PST)
Date: Wed, 13 Dec 2023 14:00:27 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com, Jay Vosburgh <j.vosburgh@gmail.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <ZXlIew7PbTglpUmV@Laptop-X1>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
 <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXi_veDs_NMDsFrD@d3>

On Tue, Dec 12, 2023 at 03:17:01PM -0500, Benjamin Poirier wrote:
> On 2023-12-12 18:22 +0100, Petr Machata wrote:
> > 
> > Hangbin Liu <liuhangbin@gmail.com> writes:
> > 
> > > On Mon, Dec 11, 2023 at 01:01:06PM +0100, Petr Machata wrote:
> > >
> > >> @@ -38,7 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
> > >>  	source "$relative_path/forwarding.config"
> > >>  fi
> > >>  
> > >> -source ../lib.sh
> > >> +source ${lib_dir-.}/../lib.sh
> > >>  ##############################################################################
> > >>  # Sanity checks
> > >
> > > Hi Petr,
> > >
> > > Thanks for the report. However, this doesn't fix the soft link scenario. e.g.
> > > The bonding tests tools/testing/selftests/drivers/net/bonding add a soft link
> > > net_forwarding_lib.sh and source it directly in dev_addr_lists.sh.
> > 
> > I see, I didn't realize those exist.
> > 
> > > So how about something like:
> > >
> > > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > > index 8f6ca458af9a..7f90248e05d6 100755
> > > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > > @@ -38,7 +38,8 @@ if [[ -f $relative_path/forwarding.config ]]; then
> > >         source "$relative_path/forwarding.config"
> > >  fi
> > >
> > > -source ../lib.sh
> > > +forwarding_dir=$(dirname $(readlink -f $BASH_SOURCE))
> > > +source ${forwarding_dir}/../lib.sh
> > 
> > Yep, that's gonna work.
> > I'll pass through our tests and send later this week.
> > 
> 
> There is also another related issue which is that generating a test
> archive using gen_tar for the tests under drivers/net/bonding does not
> include the new lib.sh. This is similar to the issue reported here:
> https://lore.kernel.org/netdev/40f04ded-0c86-8669-24b1-9a313ca21076@redhat.com/
> 
> /tmp/x# ./run_kselftest.sh
> TAP version 13
> [...]
> # timeout set to 120
> # selftests: drivers/net/bonding: dev_addr_lists.sh
> # ./net_forwarding_lib.sh: line 41: ../lib.sh: No such file or directory
> # TEST: bonding cleanup mode active-backup                            [ OK ]
> # TEST: bonding cleanup mode 802.3ad                                  [ OK ]
> # TEST: bonding LACPDU multicast address to slave (from bond down)    [ OK ]
> # TEST: bonding LACPDU multicast address to slave (from bond up)      [ OK ]
> ok 4 selftests: drivers/net/bonding: dev_addr_lists.sh
> [...]

Hmm.. Is it possible to write a rule in the Makefile to create the net/
and net/forwarding folder so we can source the relative path directly. e.g.

]# tree
.
├── drivers
│   └── net
│       └── bonding
│           ├── bond-arp-interval-causes-panic.sh
│           ├── ...
│           └── settings
├── kselftest
│   ├── module.sh
│   ├── prefix.pl
│   └── runner.sh
├── kselftest-list.txt
├── net
│   ├── forwarding
│   │   └── lib.sh
│   └── lib.sh
└── run_kselftest.sh

Thanks
Hangbin

