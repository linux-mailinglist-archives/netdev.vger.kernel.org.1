Return-Path: <netdev+bounces-272217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDLtIeOMxWlc+wQAu9opvQ
	(envelope-from <netdev+bounces-272217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:45:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3B33B181
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4457A3059F09
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02073A3800;
	Thu, 26 Mar 2026 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3jR/cqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB0351C3E
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553925; cv=pass; b=ONS0DbSsc1QgepGxAtAfRFi5UFknyQjmP1xHrb224ZVeE9y+hFpHiqEEbGcnHkcwm4o4pjgfA00TRV2GRkS1bhzsISl00da8bIuZs9tV/XXUzuzsSnXBclnQ2+qXyPPjB4Nkzt0gMBkDQ4pyQelhy0g8nI9eEBP+wUXoWi4Pgfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553925; c=relaxed/simple;
	bh=Db4TAAnVc2T0Rf7Wc2cEY/pwtSDY+KMo+MImooH/kK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6dBU+Z4Zr+EfnVn9pGrSw1aID0NKG/UCCmhPMuhuKu8WuNJCzHPFRXa5K1ilbSY4BIXdUi/zjxjcKaqpb3vl+cL8w/kf8BBpvm6QyWKmYAaFqG7FFzPjoEleve9NFtPdOAUK++8Lx98cuodL4bUzHvdl/wT3XWdSijw5Of30WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3jR/cqr; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12a80c36350so1663018c88.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774553924; cv=none;
        d=google.com; s=arc-20240605;
        b=gwIctlBzIg7RD4MNibzIYcM1NFEvmO8ONUiTNETXiz3ZsJxA65pLEbEuzn1F6+0zUE
         bPVX57GAQaStf6wYovUzjXBoP6EU0O6f5VMbsaRhgZGKq0oAtNck3VvByQQVkQF1da3u
         hv1r1Kd6t8duUD65BEpovlyKSqi+rLGUB6TuijIf+X/8rSNQNCTmKXBv76GRXVYbIMBs
         ft5ufl/H7D5QBbdNFNK11a0esYhfN1JVG6WtbMF6vvzjY5k8ZYMoowyx1AkkQfxmRfqQ
         kqbHCdI4PX4qwUgsa90S7++nfH25xhhKaccKN6G+MIfuEGgV2flxIeQss7rwvdPqHbiz
         nWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6mCMJ7IYsFJz0Hh2fdQYOLxKjKcxltIu2zRqwDNj3FY=;
        fh=8BBeoIB5d0r61/D0qXHKXSzFjwLB90I19u7uTMnwdL8=;
        b=OJjDQz6ZU9SwIuxeKZRM/0kanAHdjSB7wdZ9qbNZKIY+x2Hje79pPgECi+iSDwMM8c
         gix27eXF4WRZvyIHJxTHWfhgdgG50JqFzAQJZB96i49S2pXaEnQBoZIJ3WDLL2bXgco9
         vzwg9T+6g+i/XleZZXNZE4tJIzMX6ir1GBb2hRHDcdRJf3mE4FFWX31h0fJ8IeeCydP9
         zc+ohE2n2NskLkHNX24a4hX22LwMjo7ALo6+ckS8WWph5uyxGWpSThcT0ZnySBfDxy8u
         ieD8TUNMsJCZr2Hwvb6X92CmESpUvP4IH53zN0E5pAWFiXO6Zvn4J8/wHBYCTpKgzoxo
         1KeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774553924; x=1775158724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mCMJ7IYsFJz0Hh2fdQYOLxKjKcxltIu2zRqwDNj3FY=;
        b=Y3jR/cqrl0kINzKfFbBAoC7cImw3MTrqpuCBLaasQ1QWJPlQInuzYJzGWfe2QKTeKu
         NDvPc2Olcfdgwy1pZ9bCQtK1uv8rqh1qV4Wg24BZ9Uo9/gDnwryMyE2T0ajOHnslnczV
         DroEV3LZetS6flWcKjEux/lrfEA55mgbR42gW8obt2hbyxnt+mjcOdwB0P8THbR9qOh5
         ZKs1XleSSOWcp5tIU6qgnAZaZGcd6JyykkzK7atz+j9nxNOlZI4uyo8hVm1jYdtK2CUh
         tVQyVS3i1hOX33ENinyeyvP/rxJOcX6IpSHiQo8Cnac2T8+rF55Eip3xwqRGT9747l35
         9/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774553924; x=1775158724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mCMJ7IYsFJz0Hh2fdQYOLxKjKcxltIu2zRqwDNj3FY=;
        b=ZHVJbTNFcU9oWQkRg0C8pYV+5qJMAn64C/J8NGBMH9x4uE3mon7/+kPWOEzykqA3g+
         P851tdOwsY474potGujpfzJZORnJLU1yCWyl2qDHcpQG6W3TQN1PsxMrwSjSaBaqNdto
         m4FqBvVm4UFuOaSUILrJWBgaZo7xQlail3LzOEktnLh9OFMa7Oye0OHBiXUsmwr3n42l
         sVLuNHkL6yelcFf4rEQXI1w/bt0ejc/jbMcXJE5P0WaYe9iSIswmbUDf5f3PCJKex6w6
         6KUVoLl0N3Nv7B+koBNP5NL5Jr+j9x7fCIwOOzEiv3Q1c4eGYZBjXoopkjdlMVtWtnoD
         oyAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRT7MVhRye3w5hx6l4fu+LWUeCIqgRf+sjMlXo05qw45c8+UPMUiVoA3WFh8P7rPrqPJDhHp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WgBHC79lsyNWT4N3q5ZFzNNw+dU/C/g2ZzRmWc6Yo8cN+Kw7
	Fo3FgZr7v7AbmjoId8G7R38O/ax3z4dL6lSGsfFpnFbrvT+8DKkqa19xQ2wQmE+l79DFCeVecFu
	38Sy/H4Wel/ojP0Y0ZZyew9iKcZ82sxist1GpT/+A
X-Gm-Gg: ATEYQzxeKmm8M1clOasf2mDiRiGc2OD64TyfqFjobvINIDlPpA/bfJbGPCJxTQU3RVB
	LpIKWUaC/D6v4eYgG0SGJbJDBOKIHhknfkOxqAEwOQbEqvzGD3NwZjzyR8aI3aLqAoCYK8FwCm/
	fgmIkhSc6mm2lrgNMgR1KEbiKlhXywnuHp8sulKjUeO+yAd+f7mq4ucbhIo5/uxj5PxhxJrayxr
	oWMs5b7a0RUlgAFHh7IbXj8U2TNPwpY8TmDt9m3RBg0yHRFdqSejEx8QVSRwNKHvr7RSGij4d0s
	fzJzlMJ/UObI6ERuJ+A4IJAwPzerFiO2Aq4l3fFZlElyKeJecZMY89Uq2k0ax0MdodaoWA==
X-Received: by 2002:a05:7022:ff45:b0:128:d51a:5157 with SMTP id
 a92af1059eb24-12a96f09443mr4300359c88.33.1774553923052; Thu, 26 Mar 2026
 12:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325063843.1790782-6-kuniyu@google.com> <202603270301.kJulQgkT-lkp@intel.com>
In-Reply-To: <202603270301.kJulQgkT-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Mar 2026 12:38:31 -0700
X-Gm-Features: AQROBzC56kOOvilMQ9x7JfCrqjezesmORZsrlXxqw-kdyJdYRmxiltxnB1IbvvY
Message-ID: <CAAVpQUBdco4wFmdVFdi4yQbH38fDCNLL-SUD=udBUy8uJ0spqQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] nbd: Use lock_sock_try() for TCP sendmsg() and shutdown().
To: kernel test robot <lkp@intel.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>, 
	linux-block@vger.kernel.org, nbd@other.debian.org, netdev@vger.kernel.org, 
	syzbot+7b4f368d3955d2c9950e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272217-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,7b4f368d3955d2c9950e];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,01.org:url,intel.com:email,git-scm.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6B3B33B181
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 12:14=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on axboe/for-next]
> [also build test ERROR on linus/master v7.0-rc5]
> [cannot apply to next-20260325]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
nbd-Remove-redundant-sock-ops-shutdown-check-in-nbd_get_socket/20260325-175=
457
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git f=
or-next
> patch link:    https://lore.kernel.org/r/20260325063843.1790782-6-kuniyu%=
40google.com
> patch subject: [PATCH 5/5] nbd: Use lock_sock_try() for TCP sendmsg() and=
 shutdown().
> config: x86_64-buildonly-randconfig-004-20260326 (https://download.01.org=
/0day-ci/archive/20260327/202603270301.kJulQgkT-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260327/202603270301.kJulQgkT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603270301.kJulQgkT-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: inet_shutdown_locked
>    >>> referenced by nbd.c
>    >>>               drivers/block/nbd.o:(nbd_mark_nsock_dead) in archive=
 vmlinux.a
> --
> >> ld.lld: error: undefined symbol: tcp_sendmsg_locked
>    >>> referenced by nbd.c
>    >>>               drivers/block/nbd.o:(__sock_xmit) in archive vmlinux=
.a

ah, CONFIG_INET=3Dn.  Will fix it in v2.

Thanks

