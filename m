Return-Path: <netdev+bounces-38182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0E47B9AFD
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 07:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C58FF1C204BF
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB944A32;
	Thu,  5 Oct 2023 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOdPTqgf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2FC7FA
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 05:55:42 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C225B90
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 22:55:37 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7ab9488f2f0so243825241.3
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 22:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696485337; x=1697090137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZcZ92+aK7pFvnYG3Zmua4wSvYZMloUcgVE7tYVuTB8=;
        b=OOdPTqgfhKSvdxtXNmfCpMtSHONe8CGrGlucUFT1/hKomeEh99dtQpuQVHhOhjNB8A
         fzXqRwHZ+b9+41AsRw8erunFGOWk2n94JxkF7q3RbKks6mZiUdO2TG3ZGTRvde+r18E4
         CTFgUTphDVT2lWMSA9k9WxK9V04P0hFQHpzo3GgCFp09hQ+jEVJxxuYfJjBbYxdV8K3Z
         UeX6+OeTK6lStTLY6oiJhbUncSGuH3+YOOXPJHkcIgWIsAgAqyafN1sfiU7C9SPmsPj3
         yygGVLrIO7ZGR+LB53RtUHpjXrp0n1UrJqy/IB9rnWmV9oGYMOS6YfMduGxVpoaGWStD
         yQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696485337; x=1697090137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZcZ92+aK7pFvnYG3Zmua4wSvYZMloUcgVE7tYVuTB8=;
        b=ltm2WHduQFgpNVXBvGFkZsn7wj8ab0K8KWsEq+TgsM5hkiCLYXLwsMQ5c2DqeZGurM
         JGGP1KLXsCf2+TCPUXncNFv4s4hYWJhc2lxeYITh4BCL6PhOz76tw7/AcYD+JoTEfrbX
         oIOOl8HqGEf+fIUcr6mGEbzC5O1vaLk1oYNK4YXUF+KZt+Y78LSwv3aOuG7YhbsJEjgw
         mD2RqbT3XsTprNUHlzsCtKW0KtzQgPmeVDos4kMd/ysemUqiG5SL6Cg6tGCFE3VETLSw
         CYvZFOnDEd09dGSxnp2dWqRLIAJlit9Lv4ZUR6olk92La/Rj2vGR1XnkKRs8gDFbT5mK
         nFQQ==
X-Gm-Message-State: AOJu0YwrlFWUxCIqrg8Ej9y7ClB0NwhguNDYPlqIxhE6j1e8J+wtWqME
	kxZwS23ahzXRdUeGyQf67NR+IyAwDjHLBb1wpAecng==
X-Google-Smtp-Source: AGHT+IEfqFq+XiDNz2eIQnSJe4kBwvfbehxMBH2culMzbddsGyBv9EAUAsoMj1f9NVtaqL/bP7MZWcqyYrY+8efqtTY=
X-Received: by 2002:a67:b34a:0:b0:454:6faf:204d with SMTP id
 b10-20020a67b34a000000b004546faf204dmr4357700vsm.2.1696485335477; Wed, 04 Oct
 2023 22:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004175229.211487444@linuxfoundation.org>
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 5 Oct 2023 11:25:24 +0530
Message-ID: <CA+G9fYuH90g8jQ5SZHE98k16iQV5n+d2-G64xT9W9wrVmpt_Dg@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	Netdev <netdev@vger.kernel.org>, kunit-dev@googlegroups.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 4 Oct 2023 at 23:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.6 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

While running kunit testing on qemu-armv7 following test failures noticed
on stable rc 6.5.6-rc1.

# req_destroy works: EXPECTATION FAILED at net/handshake/handshake-test.c:477

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
----------
<6>[ 1351.687335]     KTAP version 1
<6>[ 1351.688300]     # Subtest: Handshake API tests
<6>[ 1351.688760]     1..11
<6>[ 1351.689362]         KTAP version 1
<6>[ 1351.689985]         # Subtest: req_alloc API fuzzing
<6>[ 1351.694360]         ok 1 handshake_req_alloc NULL proto
<6>[ 1351.705855]         ok 2 handshake_req_alloc CLASS_NONE
<6>[ 1351.710878]         ok 3 handshake_req_alloc CLASS_MAX
<6>[ 1351.715435]         ok 4 handshake_req_alloc no callbacks
<6>[ 1351.722026]         ok 5 handshake_req_alloc no done callback
<6>[ 1351.726579]         ok 6 handshake_req_alloc excessive privsize
<6>[ 1351.732397]         ok 7 handshake_req_alloc all good
<6>[ 1351.732934]     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
<6>[ 1351.733586]     ok 1 req_alloc API fuzzing
<6>[ 1351.741251]     ok 2 req_submit NULL req arg
<6>[ 1351.745979]     ok 3 req_submit NULL sock arg
<6>[ 1351.753307]     ok 4 req_submit NULL sock->file
<6>[ 1351.763090]     ok 5 req_lookup works
<6>[ 1351.770057]     ok 6 req_submit max pending
<6>[ 1351.774878]     ok 7 req_submit multiple
<6>[ 1351.782411]     ok 8 req_cancel before accept
<6>[ 1351.787423]     ok 9 req_cancel after accept
<6>[ 1351.795660]     ok 10 req_cancel after done
<3>[ 1351.799741]     # req_destroy works: EXPECTATION FAILED at
net/handshake/handshake-test.c:477
<3>[ 1351.799741]     Expected handshake_req_destroy_test == req, but
<3>[ 1351.799741]         handshake_req_destroy_test == 00000000
<3>[ 1351.799741]         req == cae22700
<6>[ 1351.803368]     not ok 11 req_destroy works
<6>[ 1351.804539] # Handshake API tests: pass:10 fail:1 skip:0 total:11
<6>[ 1351.805460] # Totals: pass:16 fail:1 skip:0 total:17
<6>[ 1351.806276] not ok 95 Handshake API tests

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.5-322-g9327d0db36be/testrun/20257175/suite/kunit/test/req_alloc/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.5-322-g9327d0db36be/testrun/20257175/suite/kunit/test/req_alloc/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/config

Steps to reproduce:
# To install tuxrun to your home directory at ~/.local/bin:
# pip3 install -U --user tuxrun==0.49.2
#
# Or install a deb/rpm depending on the running distribution
# See https://tuxmake.org/install-deb/ or
# https://tuxmake.org/install-rpm/
#
# See https://tuxrun.org/ for complete documentation.
Link to reproducer,
https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/tuxmake_reproducer.sh

or

tuxrun --runtime podman --device qemu-armv7 --boot-args rw --kernel
https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/zImage
--modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/modules.tar.xz
--rootfs https://storage.tuxboot.com/debian/bookworm/armhf/rootfs.ext4.xz
--parameters SKIPFILE=skipfile-lkft.yaml --image
docker.io/linaro/tuxrun-dispatcher:v0.49.2 --tests kunit --timeouts
boot=30


--
Linaro LKFT
https://lkft.linaro.org

