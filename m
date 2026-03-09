Return-Path: <netdev+bounces-265390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NSnJR16rmnMFAIAu9opvQ
	(envelope-from <netdev+bounces-265390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 08:43:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C89234F19
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 08:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9865303981F
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 07:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47051367F54;
	Mon,  9 Mar 2026 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdx4qOUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAACA368261
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042068; cv=pass; b=UZHCh9UakjRlavmdCD3wmciCeUyMOFtpxHWmuL0h9/YBzoHDxn31j5LN06TABd27PiTqbs86mIvFsfANAvKv9etx1v4/zGsKodhdQmPjQ5GlWdMk/biEQQ59ekm++p0FcCzrGom5FqJI4fVpGFGiD+yfQlQLFlIrFavJD75Vh2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042068; c=relaxed/simple;
	bh=DRPq3QzMqBw8oGsLpnJb3UdQp3S1Qo2F5VuF9aWlHmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKuWHQShWJk20xHsWkGa8EOg1RXF+CGUDNpl/Jt1UA/mS6ry3Jm3AuJy9s434gND2qZwBfopknfRCUETGd7mXoQX2D4IrrcwTGS1SXHX7hirt5aSVkFuGJLo1DGxGemTsIvqik/PHuQmqGhKNwxRA1IzeBuwZlOc7AvQLLN/nAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdx4qOUU; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a0ecbc713so79893856d6.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 00:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773042066; cv=none;
        d=google.com; s=arc-20240605;
        b=F4hTtvQA2GMKdLHZgrXGbk3lCVrXppwtiIJGSfv0VeIan86F6g0iIkCBO0l82RYWpP
         VlqS3MDz88egNVhfU2I3PebQR44w4JsNlRRAT6+38KmHvd9rZDtNYwIbGrTHpaHDA3ya
         IsWl/UQKhuZylHGz7+4kp9UA88ABREh+5pB48Klx3IAwKplYaA0RFW93MhoD9SM9Y6rg
         0Z3oG95OCS4KqgspmozEmPBaELzeVPxIurOXijtxeK7/UJ+NJADncuXkymUQE04mTxJw
         MgXtJKBnQmhZC0UqSXGfJwMlX1SRVnWpabGlIWZHqgVxadPumk8CdkcfU6CQOyIuKD6V
         J6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tAKZFKUgV2Kry6TWY43OgsLi7TZBVu+cqXSmsBbAF98=;
        fh=ZjUakARcRmValyZW1g9gRA0G0AzbF3T5j3s/eyEhKhU=;
        b=XTvEDmnGXZDN9cu5Zz11GdelUjY0WMbqyFEHsRCXPSusTqU1V6ga2wvfIXsiwJMLWC
         4nhvTuyjwddj6qiz8NsNsOi0Lhf+guGQ65jmW7LjSpdHPFzAEh4xyVCL2DGWVjX4REk6
         NAT8nY5xoABcirAwXaP51NYPAkXnYNpd55tLTASRBB8fxF7dlFbG2Z2NJbz+6CYf0mPy
         IqhgzcD2ivGCPlCQbc5yg9IO4J4QF+Sm0vGO/tJBnBu/pMHMa+29/SYERyCnVnGEVviu
         LQ2LRvIArOxTMzb2HDOjFZtZhm0gPUlmV4/PLuc+Ktjqe5ZNSlDUzJcP8sOLev/F7Qee
         p5Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773042066; x=1773646866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAKZFKUgV2Kry6TWY43OgsLi7TZBVu+cqXSmsBbAF98=;
        b=mdx4qOUUiFpJOh2uQmGtOb/HBek7YAKLcrUcVfHlOt/Pp+hJlywgPEPk4yB0sPdHmD
         c11rW18QT433vbW893EFAjWe+/vQgCafLfZr+s4WMKbvc7bBN7fsYmjoxB41NnUpL7Mt
         oTVmbx214J4Ak6ef0lmGxZDsewHHSHNMpsNtKB9MiwGgWI2/1xuxFmHEW883iXoe9yaM
         HlXN3ZPV2KNw7CMW9wtE6S6mpFEkLp9kYDj5XDYVec8VkRIEbsiI37vq5MCVSDOQoWfD
         wn3KAOREiVV1jwqo+psQxaqPDTx8VE3t0ZKoB1BQAM38emcDfQlC7PGxUatPMMQqR3dK
         xMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042066; x=1773646866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAKZFKUgV2Kry6TWY43OgsLi7TZBVu+cqXSmsBbAF98=;
        b=Ot8qwuqrPJFppZi8MEBnJos6Sbiesj5kzqovqUBlyU2PVJRGlNs7QH7FAzZip3qHz0
         pW9CCfsEnC43luAuz4CTucJkyy/C9XSC0TEHCzJyzPgJzD1fLk+o2ccrGowswm/ZC4sd
         f5pUa5DrJQco6NJJ/SR/IdxjJLIZnIqTEmrGhgB8+IP2Aq15t7pNCpSJ3yRkHpY0PG1v
         QgEytgpdx3YxvDP39igjKqAiHztcLUJ0m+PLga3oWKTXE/jG+Ho5j2VzauTKMlkYRQIp
         zqZAcdS9qP+4jx9vKduzZ11HLX7XHON4uz32z1rQ4FlC3veiKwB+FyulroesKvpokqLU
         m2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCX1VECEefyT4SjUrmOXS/S7Lpq93ERpLaLRbV6urMLKraf+Txm/b8qQgiezADF+rqdfOieJogA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7X9bsOM63kUk1Nut/w7TovWsELX5ajcm9O4gOwH5qoL96xEqy
	kIKEP4s8f9yUwzY4nLFclxOs2Lt2YviBE/oU8ym9xLl53CcB/FJ+u/f9cw+ATvfMM96pnSRi31Z
	knm3mbDX2XCb4NSqASZ50SB6Ts7GascrFruZJvd13esbw2Nkw/9ukLLtm
X-Gm-Gg: ATEYQzzaOTHV9XGT0RDWIkcbKxLehATWdnIx7wpdpakBHyJMtV3Apjrejtz/p2r7xbM
	sjOqAlpnmHnqhTYH/5KouBkp+k3P58nM5jTR6L/S7hUyl1urx5qDhaw56exjRJxbP0T3m7JyviM
	/U43dmgAkUxhSuEOOMgKcP2BPPSNegfH4RxzfgFBRezK2sde0/txuoCAg2cwg8b+TkTG+cG6NdH
	XcJ1yt2ysu/2dCP0pCZeP+3j8iijkQTcUO2rqe5AYc4wHchTMoD9te0iUNdxKeehTESWbwsoAaN
	E9OlrG8=
X-Received: by 2002:a05:6214:2a85:b0:89a:e8:d181 with SMTP id
 6a1803df08f44-89a24581926mr210589386d6.10.1773042065361; Mon, 09 Mar 2026
 00:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202603091409.866c520c-lkp@intel.com>
In-Reply-To: <202603091409.866c520c-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 08:40:53 +0100
X-Gm-Features: AaiRm50iN2kdxTDIK_N5_LqpaEGQz0R0-2xH8Tt8AzxK8jPQWFw8kUuyjDsbjHQ
Message-ID: <CANn89iKUdtWw4ptM8ZreRP0a2FuvQOJ5FgE3o4q-zTRTmt1Umg@mail.gmail.com>
Subject: Re: [linux-next:master] [icmp] 64db5933c7: ltp.cve-2020-25705.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 04C89234F19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265390-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 7:42=E2=80=AFAM kernel test robot <oliver.sang@intel=
.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "ltp.cve-2020-25705.fail" on:
>
> commit: 64db5933c7adcdc4dd8f5ef6506cc998ecbe63ac ("icmp: increase net.ipv=
4.icmp_msgs_{per_sec,burst}")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master a0ae2a256046c0c5d3778d1a194ff2e171f16e5=
f]
>
> in testcase: ltp
> version:
> with following parameters:
>
>         test: cve-06/cve-2020-25705
>
>
>
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-14
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GH=
z (Haswell) with 16G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202603091409.866c520c-lkp@intel.=
com
>
>
> PATH=3D/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/=
bin:/lkp/lkp/src/bin
> 2026-03-06 06:12:16 cd /lkp/benchmarks/ltp
> 2026-03-06 06:12:16 export LTP_RUNTIME_MUL=3D2
> 2026-03-06 06:12:16 export LTPROOT=3D/lkp/benchmarks/ltp
> 2026-03-06 06:12:16 kirk -f temp_single_test
> Host information
>         Hostname:   lkp-hsw-d05
>         Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
>         Directory:  /tmp/kirk.root/tmpyus4a2ag
>
> Connecting to SUT: default
>
> Suite: temp_single_test
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>  [1;37mcve-2020-25705:  [0m [1;31mfail [0m |  [1;33mtainted [0m  (16.104s=
)
>
> Execution time: 16.158s
>
> Disconnecting from SUT: default
>
> Target information
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80
> Kernel:   Linux 6.19.0-11801-g64db5933c7ad #1 SMP PREEMPT_DYNAMIC Fri Mar=
  6 13:49:07 CST 2026
> Cmdline:  ip=3D::::lkp-hsw-d05::dhcp
>           root=3D/dev/ram0
>           RESULT_ROOT=3D/result/ltp/cve-06_cve-2020-25705/lkp-hsw-d05/deb=
ian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/64db5933c7adcdc4dd8f5=
ef6506cc998ecbe63ac/0
>           BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-ltp/gcc-14/64db5933c7ad=
cdc4dd8f5ef6506cc998ecbe63ac/vmlinuz-6.19.0-11801-g64db5933c7ad
>           branch=3Dlinux-devel/devel-hourly-20260302-003818
>           job=3D/lkp/jobs/scheduled/lkp-hsw-d05/ltp-cve-06_cve-2020-25705=
-debian-13-x86_64-20250902.cgz-64db5933c7ad-20260306-21371-13x9t7k-1.yaml
>           user=3Dlkp
>           ARCH=3Dx86_64
>           kconfig=3Dx86_64-rhel-9.4-ltp
>           commit=3D64db5933c7adcdc4dd8f5ef6506cc998ecbe63ac
>           intremap=3Dposted_msi
>           max_uptime=3D14400
>           LKP_SERVER=3Dinternal-lkp-server
>           nokaslr
>           selinux=3D0
>           debug
>           apic=3Ddebug
>           sysrq_always_enabled
>           rcupdate.rcu_cpu_stall_timeout=3D100
>           net.ifnames=3D0
>           printk.devkmsg=3Don
>           panic=3D-1
>           softlockup_panic=3D1
>           nmi_watchdog=3Dpanic
>           oops=3Dpanic
>           load_ramdisk=3D2
>           prompt_ramdisk=3D0
>           drbd.minor_count=3D8
>           systemd.log_level=3Derr
>           ignore_loglevel
>           console=3Dtty0
>           earlyprintk=3DttyS0,115200
>           console=3DttyS0,115200
>           vga=3Dnormal
>           rw
>           keep_initrds=3D/osimage/pkg/debian-13-x86_64-20250902.cgz/ltp-x=
86_64-92ea0639e-1_20260301.cgz
> Machine:  unknown
> Arch:     x86_64
> RAM:      14040916 kB
> Swap:     0 kB
> Distro:   debian 13
>
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>       TEST SUMMARY
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> Suite:   temp_single_test
> Runtime: 16.104s
> Runs:    1
>
> Results:
>     Passed:   0
>     Failed:   1
>     Broken:   0
>     Skipped:  0
>     Warnings: 0
>
>  [1;31mFailures: [0m
>     =E2=80=A2 cve-2020-25705
>
> Session stopped
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260309/202603091409.866c520c-lk=
p@intel.com
>
>

I do not want to know what this test is doing or expecting.

If it expects sysctls to have a precise value, it should set them ?

