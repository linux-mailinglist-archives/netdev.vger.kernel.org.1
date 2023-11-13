Return-Path: <netdev+bounces-47370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AD67E9D3F
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE652280D12
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56752208A2;
	Mon, 13 Nov 2023 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F311E511
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 13:33:05 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8B1189
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 05:33:04 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso46179705ad.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 05:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699882383; x=1700487183;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB/kuL7vFT98LZmFF91gvWSL+IxDP4W37pGpBzzEqVk=;
        b=B/ceGfuIzg+7tmsU07r9lt2v/G0Oqx/icLLuhGWEI9OO/4pfop0aww2kMWVhdt4Aiu
         p/u0PW7ZfSMM4N6RWka1LVJMsTi+LIoti9E3HubBQIoOnq88nrwYixLRwRM7k5VYWQcS
         wrBGkIEeitwAmXoK0+mw/Qi/59RfQsOVMOZl/YA0K00+eLAUIT9pQ2bvgewme/FKPES9
         IvW0ZDf3flXX2Xe904grdGPuaS5U0yOaJbAtqSdPb3aLWwvLVWQAN+Ph+qC8nFS8Yx1E
         Hi6neBuPwOba7BOEmGdQhJ06IQcVMq5nXT8q1uNte7E10DdXdiCK/WFQZFD1dYjGj6OC
         apdg==
X-Gm-Message-State: AOJu0YxrsDKSptmWNH0EftyMW5H8GC9ktCz8UvDZB//Cnq5YgDdyLsC8
	pWLEkJrwGSnqt8LaPHuZyfA9Q1OpL+dJCt+ZwR7q0Pateg25
X-Google-Smtp-Source: AGHT+IHoH4RkKf5R6bXhUl2xzABwW/H+21wb4up6JATs/YraPvWwco/JudetL/R8CkjbxaXfq/gdHA2MM5i9E9gIl0Wxw/1mTMcz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:25cf:b0:1cc:323c:fe4a with SMTP id
 jc15-20020a17090325cf00b001cc323cfe4amr2024518plb.12.1699882383722; Mon, 13
 Nov 2023 05:33:03 -0800 (PST)
Date: Mon, 13 Nov 2023 05:33:03 -0800
In-Reply-To: <d9657547-fbd2-43cc-ba78-e1cf308eb954@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4540f060a08b52a@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From: syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To: code@siddh.me, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to create VM pool: failed to write image file: googleapi: Error 500:=
 We encountered an internal error. Please try again., internalError

syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D"auto"
GOARCH=3D"amd64"
GOBIN=3D""
GOCACHE=3D"/syzkaller/.cache/go-build"
GOENV=3D"/syzkaller/.config/go/env"
GOEXE=3D""
GOEXPERIMENT=3D""
GOFLAGS=3D""
GOHOSTARCH=3D"amd64"
GOHOSTOS=3D"linux"
GOINSECURE=3D""
GOMODCACHE=3D"/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=3D""
GONOSUMDB=3D""
GOOS=3D"linux"
GOPATH=3D"/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=3D""
GOPROXY=3D"https://proxy.golang.org,direct"
GOROOT=3D"/usr/local/go"
GOSUMDB=3D"sum.golang.org"
GOTMPDIR=3D""
GOTOOLDIR=3D"/usr/local/go/pkg/tool/linux_amd64"
GOVCS=3D""
GOVERSION=3D"go1.20.1"
GCCGO=3D"gccgo"
GOAMD64=3D"v1"
AR=3D"ar"
CC=3D"gcc"
CXX=3D"g++"
CGO_ENABLED=3D"1"
GOMOD=3D"/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod"
GOWORK=3D""
CGO_CFLAGS=3D"-O2 -g"
CGO_CPPFLAGS=3D""
CGO_CXXFLAGS=3D"-O2 -g"
CGO_FFLAGS=3D"-O2 -g"
CGO_LDFLAGS=3D"-O2 -g"
PKG_CONFIG=3D"pkg-config"
GOGCCFLAGS=3D"-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -fdebug-prefix-map=3D/tmp/go-build1681865836=3D/tmp/go-build -gno-record-g=
cc-switches"

git status (err=3D<nil>)
HEAD detached at 500bfdc41
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231103-130513'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231103-130513'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231103-130513'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"500bfdc41735bc8d617cbfd4f1ab6b5980=
c8f1e5\"



Tested on:

commit:         b85ea95d Linux 6.7-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db5bf1661f609e7f=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbbe84a4010eeea009=
82d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10070d70e800=
00


