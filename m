Return-Path: <netdev+bounces-275865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FejIWuQ1GmKvQcAu9opvQ
	(envelope-from <netdev+bounces-275865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 07:04:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E4E3A9D43
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 07:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADEA83017270
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 05:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF6375AB1;
	Tue,  7 Apr 2026 05:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugn2cCFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7723368BD
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775538279; cv=pass; b=GZW9jqgCix728Xc5h3cIF0mTiOTrwsoaS1kDVvGtgwQiBZ/vSgSf8LZ0vMMJPCXdTFl7T/siET/wH2UoQgRJ6lNDq82tA8tNT5emi6IEsLilCyfZBXjsDcEMViuLQKxb3VCCZF7xeLvTxY7Ejf+jwJJkmqgUB2tGsSOef1+5Brc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775538279; c=relaxed/simple;
	bh=pR75v0+K8Ebngm+mOi4GYi6HyIecwye1FToL+3OGSrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNNQJL0nMLQ7qc4ypcSc6kQCFsWJzN8CYO9kFYs/4WxIrV1TGnWxYULbz9k4GN+OFcD3j5hBs9R+Ee+duBOijjlsTT4ET5aUkuVLMGaaRT5kqF9oJAry19Wx6rRmiZgznMSL82p32f6Q17Oh7qBbF0BbUPGqI9V6zQQaQKfEMqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugn2cCFP; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso29493a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 22:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775538276; cv=none;
        d=google.com; s=arc-20240605;
        b=ZyjvHjNSeYCgUnswmXk4z7gY9fmiHDFeWNeYzg7SYLTnk88808R5uKdsOzp2jq7yGk
         63x+basdA39VeXD7WB5qI79qh83K8iMjG5Ilbk7Oxkm5iUsZaWswqblZAwI6ASH805km
         TCZhC8goyA2GeuwFIUS5amP9eXypS0fSFsu5Nufwb3Fa9RxJLs7979+xzb4yij0bqT4/
         bpLLq1+jVv2ApRmch8i83drcTiwwFOb0dswSGLjvxHEIWIJyPWpQvfoN+41pGIKhLLbp
         PZIzp09WMh+U7iPt13Aik8aagbe/KvfeXwQ4U6Tr/cYUcAYn4t1ZZKea4oLIpveSGU86
         L0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=25GmHcuPSEteOmJErKcJfWIQ20/JH8qsbM1yjXNIBGk=;
        fh=TLgFZiJircXcCj2/OdRjmJ8To8nnlwQcQzV4tTmkpjc=;
        b=b0HYaL9AvIW4djT7H7Q+I0qd8vCYo15sT3RbIvalH+oA7mLTx2av/dbJNJGupg/ATb
         kyZ6kkifdN9OFdnV1ckuj/baoe33VE9AGa3cBCAvGFBphm1EU2G2fKV8wB7dUp01mYun
         usvzec6PuhnewV/cqbF6G9mHZbkBc86q7owlxilNMx+rUX62+Pmc7+tZWY9Ye50ctmIw
         JgtJGizQB1BxOlil9ORaueMESw0X4xtoKMahodTaN87r0I1EnrW0PigQLNRD3wRHqm4B
         slq1qo9Sc3uFlIZPhXZJTeV4S9tHqEVZBa9MiVxcnNxziH2UJyJGvUa9mypd02uPLgDG
         9PsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775538276; x=1776143076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25GmHcuPSEteOmJErKcJfWIQ20/JH8qsbM1yjXNIBGk=;
        b=ugn2cCFPLVtf7RqXH0j6l7suoKVd1SKnkYEW99irar/lvyMbbQf3Ed7Nh3KPxGC86r
         jv4KFYOSV2bRUZp6ttVLIxt7JbXE10C+0EZ0gEtLVR+kCEU4Yyt2tnJukPYnxmInLOEs
         tjCqb96kpmk/pCFsXAO9OLvlDP6tcXrXAqeruhn6BXE0QMfgI8V3DLnt4RMuo2gvUY8M
         n0p1AxCvIkaP464NM2UFvJ0S2He7C+FzoQyoB8RKewiGu2H/VW6hF+5KPHTNuKJq022g
         OB994vy7RwwLcsekxZmf51vREBMLqyjb8DEm799RUB7Dd7Qy+ySYlVclL0/SFjaKCIST
         6+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775538276; x=1776143076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25GmHcuPSEteOmJErKcJfWIQ20/JH8qsbM1yjXNIBGk=;
        b=XJXhjzsoM6iFvwWepyqFkRQwdiXI8P2RxGY4kCG4yXo9aIiHan4AQTbsaCE0SLB3kx
         q5AclnC4ke0R/9fy5AqkiclN51zm8k0T53T0mBh/9ZUFQPo/niRHyeiuithJUjSm9zkr
         J8yY1wBzi3PpUPe+/5zqvnzZ4w4LensOqCmJ7H500+9WzN46me7pL1wsXhwsC35fTHba
         yTWTzny3UPQN6+YWykypY0INoPsCaVYwCwP4M2oYhZmV4k90rMWGEUbzLQbIWkjAt7mU
         R0ix+rhSFOVk8551qi1dILv63jnUV7sxgk4czenjG5YL6NYssiLKfHfp5kZwQQr7pN97
         vGMg==
X-Forwarded-Encrypted: i=1; AJvYcCUL34anJG/IOfMLZ/lQKiJSge3PruD25fLZocOCTHOYJ+vpZk3caszvkAVfnjZFvqonRoAZT+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTTp47fRJymywfrk+tvc6znpQb+UqK19rX7Z6kULrr6auKUzvv
	0XupDXZQgT7nmKjTQKgLz1BXlXef3wINJPcRfEsDftuamGnJmcam9JOzde+OZK6DupPmFv1VN/B
	biOPZF/P3MvOLR/uop/eO9uBwZhKnfUa2xCtshYAdpg6QujI+yTTuuRc1
X-Gm-Gg: AeBDietxA5s3RO02fZAqjopIbZyIbF78Yxq5MY0hGMDfbHA0DJ8EtNKRquoEwMfv6jS
	bawho88SmIOC1aDFtRw1X5lnPqorK3hl+8114gl1DUiEPLuwfj65JIalx/dluPwfROd6oEswm8X
	6Pf5USDMxaeic86HL/5V3ecoe1SVpZjurrzE0AV390HNivuMRAoB9KR+SygLvbJXaNGRYnfm7IH
	NJgPMGx5dCuJ/bN7iK1mrrqk2aDcCkJs3pLjBmkfIBuHCr/+/zGjOhwb60rYD2CCsydanU/ilni
	3zXZiuBMqyNRsejxopAa59ggVnvgW7azHguNRQc=
X-Received: by 2002:a50:fa85:0:b0:66b:b4da:a8b0 with SMTP id
 4fb4d7f45d1cf-66e4136b3b3mr143872a12.8.1775538275237; Mon, 06 Apr 2026
 22:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com> <20260406074437.3ebb904a@kernel.org>
In-Reply-To: <20260406074437.3ebb904a@kernel.org>
From: Marc Harvey <marcharvey@google.com>
Date: Mon, 6 Apr 2026 22:04:23 -0700
X-Gm-Features: AQROBzChFB6cRcn-i5tgpGES8rLGUFP-i2wknSViONSNsMGB8Isf8uEKGuixfcU
Message-ID: <CANkEMg=DOiwj-ZbTLGC3oXaQuPM=sGOjg09CTXNpguCL5dh7Ug@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/10] Decouple receive and transmit
 enablement in team driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275865-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,transmit_failover.sh:url,linux.dev:url,teamd_activebackup.sh:url]
X-Rspamd-Queue-Id: F2E4E3A9D43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 7:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 06 Apr 2026 03:03:36 +0000 Marc Harvey wrote:
> > Allow independent control over receive and transmit enablement states
> > for aggregated ports in the team driver.
> >
> > The motivation is that IEE 802.3ad LACP "independent control" can't
> > be implemented for the team driver currently. This was added to the
> > bonding driver in commit 240fd405528b ("bonding: Add independent
> > control state machine").
> >
> > This series also has a few patches that add tests to show that the old
> > coupled enablement still works and that the new decoupled enablement
> > works as intended (4, 5, and 10).
> >
> > There are three patches with small fixes as well, with the goal of
> > making the final decoupling patch clearer (1, 2, and 3).
>
> activebackup:
>
> TAP version 13
> 1..1
> # overriding timeout to 2400
> # selftests: drivers/net/team: teamd_activebackup.sh
> # Setting up two-link aggregation for runner activebackup
> # Teamd version is: teamd 1.32
> # Conf files are /tmp/tmp.ydjNK9Um7H and /tmp/tmp.xZuc3cWbN0
> # This program is not intended to be run as root.
> # This program is not intended to be run as root.
> # Created team devices
> # Teamd PIDs are 21457 and 21461
> # exec of "ip link set eth0 up" failed: No such file or directory
> # exec of "ip link set eth0 up" failed: No such file or directory
> # exec of "ip link set eth1 up" failed: No such file or directory
> # exec of "ip link set eth1 up" failed: No such file or directory
> # PING fd00::2 (fd00::2) 56 data bytes
> # 64 bytes from fd00::2: icmp_seq=3D1 ttl=3D64 time=3D0.753 ms
> #
> # --- fd00::2 ping statistics ---
> # 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> # rtt min/avg/max/mdev =3D 0.753/0.753/0.753/0.000 msPacket count for tes=
t_team2 was 0
> # Waiting for eth0 in ns2-lZ0gqd to stop receiving
> # Packet count for eth0 was 0Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # Waiting for eth1 in ns2-lZ0gqd to stop receiving
> # Packet count for eth1 was 0Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # TEST: teamd active backup runner test                               [FA=
IL]
> # Traffic did not reach team interface in NS2.
> # Tearing down two-link aggregation
> # Failed to kill daemon: Timer expired
> # Failed to kill daemon: Timer expired
> # Sending sigkill to teamd for test_team1
> # rm: cannot remove '/var/run/teamd/test_team1.pid': No such file or dire=
ctory
> # rm: cannot remove '/var/run/teamd/test_team1.sock': No such file or dir=
ectory
> # Sending sigkill to teamd for test_team2
> # rm: cannot remove '/var/run/teamd/test_team2.pid': No such file or dire=
ctory
> # rm: cannot remove '/var/run/teamd/test_team2.sock': No such file or dir=
ectory
> not ok 1 selftests: drivers/net/team: teamd_activebackup.sh # exit=3D1
>
>
> transmit_failover:
>
> TAP version 13
> 1..1
> # overriding timeout to 2400
> # selftests: drivers/net/team: transmit_failover.sh
> # Error: ipv6: address not found.
> # Setting team in ns2-yxjiUo to mode roundrobin
> # Error: ipv6: address not found.
> # Setting team in ns1-Jht6kA to mode broadcast
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # TEST: Failover of 'broadcast' test                                  [FA=
IL]
> # eth0 not transmitting when both links enabled
> # Setting team in ns1-Jht6kA to mode roundrobin
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # TEST: Failover of 'roundrobin' test                                 [FA=
IL]
> # eth0 not transmitting when both links enabled
> # Setting team in ns1-Jht6kA to mode random
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # Packet count for eth0 was 0
> # Packet count for eth1 was 0
> # TEST: Failover of 'random' test                                     [FA=
IL]
> # eth0 not transmitting when both links enabled
> not ok 1 selftests: drivers/net/team: transmit_failover.sh # exit=3D1
> --
> pw-bot: cr

Apologies for all of the test failures. Before sending this revision,
I ran each test thousands of times and observed no failures, so I
thought the flakiness would be resolved.

No matter what I try, I can't recreate either issue on my end. I've
tried building with the exact config from one of the test runs
(https://netdev-ctrl.bots.linux.dev/logs/vmksft/bonding/results/590921/).
I've tried stressing the VM according to
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-st=
yle#reproducing-unstable-tests
(this makes the tests time out, but I can still see traffic). I've
tried using the netdev-testing/net-next-2026-04-06--09-00 kernel
source. I've tried in nested and unnested virtual machines. I've also
tried running multiple test instances in parallel, but nothing
recreates the issues. The issues seem related to tcpdump, but without
reproducing them, I can only guess. Any suggestions for running the
tests exactly as the CI does would be greatly appreciated.

- Marc

