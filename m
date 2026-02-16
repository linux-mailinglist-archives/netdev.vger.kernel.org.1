Return-Path: <netdev+bounces-258834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD0AHfCokmkWwQEAu9opvQ
	(envelope-from <netdev+bounces-258834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 06:19:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90E140F70
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 06:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA10730097D7
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 05:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F132E275AE8;
	Mon, 16 Feb 2026 05:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6EKho63"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152212744F
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771219145; cv=pass; b=BrBPRn4k5an6ujRmP2C947HvgD36rCnJqQbN4BdjnB48jPe5We5NnM3yPrW8G6eSoipQqjfQWbcQgcQpH3HuvVZThICBiIkwPAyCgnF77WNO0VMcxL6mRU+e3+a0O7vE0Yy7uWxJU/8B2ObgsMvhz0NvnuFUu8dPmSoFai5Rqi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771219145; c=relaxed/simple;
	bh=cTydM6llwe17dEOjiDWqAOfd5hLsCH5gFvItqj94xXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOEcGo1vbgJtlIj9GE+npU+ytj3Qq6BBo6xVjtrXGHWzm06evPXl+/unV83sKVu86Kj5s6HjBG+9MtEq1W9T9nqG5UZfvEQfp/E5gyK5UrDplfkwp7mdaSzb5vxf4dISegiH8n4GOHrFxhh/k626pe7ji/4AjheI3azLShUz1x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6EKho63; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1248d27f293so6545969c88.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 21:19:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771219143; cv=none;
        d=google.com; s=arc-20240605;
        b=UF43uy/rOj69rwEhplyIKalXq/rkAVPDLvkmsdvWFVncgyVp3NmcHbVo4KbCr0MVOg
         7aQU9wHhAOdEYPJKveZ606gCOd2dq8fbCJgGwviSkTn2th/mq5flkVQeSS1xDDM4zHPK
         rpC0I7Fw2Fninb/p7VYT+qK1/gyWvPNmndvntFDgFhT5fe4aWbVQrU8Vygh1d7VZvpOI
         O658OhXiBxeLwv+F+FmMeMs82d/1X9SgTZ8yfdQ9zU9g2sWDqdqCIuQTodO6cvX3+JNg
         XGEzd/7ArjB5QLhpeYAAOTsm0V84RVU3Q/UPoK1L6iN4FC8bd5SaiuQIop1fg3finncm
         sgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=byzn3mYrXH2f08drE1WkmiXr5JyMmD4IsRirzVhSrPA=;
        fh=nFbUjMCOrEANHUQivgwK4pXzqv19uS0R5vSs8+CjOqs=;
        b=Z3z+VtcaddAllpCUUbocO4Drn+M2FERM3fEwNmmBmVASCpv8vXpvZRYNsMTrCoq6G2
         54WlSKMah5ftE4EKiIbqczJjAMpjshTLSdbHl6GHgrTWIPj7y157Y+m8v/NZWPDVY/P/
         vMVDDJl8fd4VceVv4WOO9YlIXsohBTVCc/66BadAD2nerk0HKmfpINRE1wf+83TYfJJE
         XqdVZPxxmoqsNVDUCyjjD8UGcgJjvACHhjdtHNzyX21pGPu9sSH1u2hgzdY2+180dxBO
         IE9A1suRBcw0Xo4Nq9yHBU32+jakizj1ZmgpUQGxHAgUx6e28hx8zkTbn3psyZ9TYKIa
         oDNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771219143; x=1771823943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byzn3mYrXH2f08drE1WkmiXr5JyMmD4IsRirzVhSrPA=;
        b=h6EKho63I5TnD1ikWcNLyhgyfC+oQDTBlzk63i2HXzwM8AOiHsp75mpkoKJnOZ8XPD
         zEZTYfHps8kdI7bI0VV1+5nJvOMaRdcdXdR/S0V56mLrsASjKE45+MK5VwvDPROVMtlE
         8zfk1IF64aA14SfqeU8IHc8Jup+McfyWXdi7u41iSzOHiNMplJsCgOleCGzieHEw9ox4
         Uja1cJ38TF+wn8jAYppNqpr7eJGSOKLsk0ETOS1dyHmWFJJpdGNtF1YKuYPssj1YETkB
         UiotzUuV1Lx6wz19xktzqFjRQqQbzqVXZo8t6PwRMbD+V36rrXtwR6JC3J2hoDyHsiPN
         PJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771219143; x=1771823943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byzn3mYrXH2f08drE1WkmiXr5JyMmD4IsRirzVhSrPA=;
        b=KkGAKUDjC3OlOqGX6frvOD7DC+kMwKkJcPDD0RhUJCPs6nYGeosGkdj/REGua8ogSn
         URjb5Q+CrhDGVHqAxofy52JYcubNlGhVnHzY+bl+l1mQhpC8az9qwjOfsNh2elrY9BOy
         hkYHUm8/Um6/rdjplKvfVjyUBgSWAxO+wwkt7h/OTEI4nDCj4x/L9KAIxL6jbSIIvb4l
         QMw0KuBpDPFEwYPeQV9mkbKHdwJNIcz0AP0xyVadTjBQMFwJyfMyKR1cqXAweThaLMq+
         rzkAur8ZQWNq46IhvEZpSG96OhMoZDW7O6BPjsHCZ5IKdTjGGtZ+WiB6zSkB72kGrEMG
         3Ctw==
X-Forwarded-Encrypted: i=1; AJvYcCUPdVAfpCZ456ICZOUV3ZGjZA08e3H0YlodrfO8gprrJOP3i6VG7cfhdcL1QsD/38To2lQOckM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1kyBasbCxd7riGTvrB7YqoR4X2mTtnKeDj8GRRR7/FMeOWJE1
	Vgr0btkSz8UISkqU6gjeJNiSIXmH31UObDKWYIfk57rNUlnsxRZ9t1j634qOh9oQdjcoH5/IxO5
	QzsiMjJ4iEkZcEGXvcrNQG0dhaSwZEWCtILZS8y3lQKvm/MfQf3062UKvTYE=
X-Gm-Gg: AZuq6aLlelOsrwnz6hOqhK1bLXlksinP42AF+9fCKTfSlUQfwNNX7YZJu8/Og74cDge
	Q9rpjw5ZptOIux2aVm/KbVd3k4npSUf3sPdvzmcn9e/7O/SJO2qE3kvfRBIYjjYd7o8ZIbIwp5V
	KsI8cIjCpcaKmQ4CrvhN27zdFDrQB+bhs7V4kGMaZvnkmSaAAj05nV0EW5jlERYcDoqC6lmpHxD
	xQdwPkOhWYty/nRpweOgHwdTVUx6kvsv4fT7/4PaCCMpvZa/Hgi35ig2QSnEBjjxjqU45vnLY0X
	PJtH/qX245hRh7CS4IGvm+0jzLDojebvm/lZeoWgFsEB16yL18fftkbGrkIkiR40Lrm2IA==
X-Received: by 2002:a05:7022:41aa:b0:119:e56b:c74d with SMTP id
 a92af1059eb24-1273ae20572mr5446447c88.18.1771219142650; Sun, 15 Feb 2026
 21:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215204353.3645744-7-kuniyu@google.com> <202602161010.ohfwdwoo-lkp@intel.com>
In-Reply-To: <202602161010.ohfwdwoo-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 21:18:51 -0800
X-Gm-Features: AaiRm53TuLLrj5i07WCfZaVSzTTG-oZE_UcBw7XWP_S2gWKmb775mn2vrkqu9BY
Message-ID: <CAAVpQUCBY=rcJdBKNb5nMWnFvak7dVzsF4_SpKfJKSWkqXaPmQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: kernel test robot <lkp@intel.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	oe-kbuild-all@lists.linux.dev, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258834-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,lists.linux.dev,bytedance.com,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: CE90E140F70
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 6:51=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on next-20260213]
> [cannot apply to horms-ipvs/master v6.19]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
sockmap-Annotate-sk-sk_data_ready-for-UDP/20260216-044819
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20260215204353.3645744-7-kuniyu%=
40google.com
> patch subject: [PATCH v1 bpf/net 6/6] sockmap: Fix broken memory accounti=
ng for UDP.
> config: x86_64-buildonly-randconfig-002-20260216 (https://download.01.org=
/0day-ci/archive/20260216/202602161010.ohfwdwoo-lkp@intel.com/config)

Okay, CONFIG_INET is not set.  Will fix it.


> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260216/202602161010.ohfwdwoo-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602161010.ohfwdwoo-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    ld: vmlinux.o: in function `sk_psock_skb_ingress':
> >> skmsg.c:(.text+0x8fc777): undefined reference to `udp_sock_rfree'
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

