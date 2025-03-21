Return-Path: <netdev+bounces-176740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9634A6BCD9
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 15:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDE81678A0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 14:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291BD154426;
	Fri, 21 Mar 2025 14:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682178F51;
	Fri, 21 Mar 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566955; cv=none; b=XEQqvlsEGXacZRpwA3BujO5Y7CoJIX4P3jPbAtpn6ocydiK96hv+H9nzKhEo2Q6x4VUMdwM4siU04JRidoP4i6DPy0drgq83U9HeNV1nYaHSc58FtB2BvFenKyw16CIEDql4IPuTJ8NpGK6/73kpHKwPdKhmqMuFpTP1Uf9emmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566955; c=relaxed/simple;
	bh=CQZ8kkNl63C+QjvQ7gFi/96yZTVOu/ee44z80daZagQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNllpnTIPSnvoL9euGGIW2stKMOW+Y+HtglRvInJPpbfnLhyBrR0BFtd1oVqYQ+phMOljNQwKT8CSq7XeshFyY/oBINnkKevc9cvJPw6wnrFnLSPlRIVF76UBPfAy7RJkUoZaqHSSe1ieo02TRr4DMrI2crA5RldMcrGDYCeLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so2685759a12.1;
        Fri, 21 Mar 2025 07:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566951; x=1743171751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zrlrukzDiw4iVxK9TyD29phGrqtRDGCavFyioGRMQs=;
        b=rVEid82MnirIcLyn2qFt2u8IjUMq1GMBSBMYKVBf918JGeUuMuVvatbFrMwxOwIJWX
         2qaRCapmjbecr+ekIZoI92g3jsmw4dLrbi7jDDeeiqxuNMmISW1Q81Fow44vwgBqGgJv
         1n3M8n5147td2XlPsU3pb4tvcTCmEN3OfDkOwkbbqU1n74ELPpb7e83+MEVFMrwt71rS
         nlWGUwVUE9SqjluxtABmfKZ84wV7boQRFnphlgRlYar4FDIR+9Gr9V87jBa/y+VKCrvS
         zKAevY9VspjtYQ9SA/tzO+uCAKxflbOWbmha0ig1WT7kPJbtExzoiRmYlEQuRCuNWGBv
         I8vw==
X-Forwarded-Encrypted: i=1; AJvYcCUjP43zGJtcz7S576ylxYwVnZU3pJZ55eH+gID1VYS/UyoReuc8tlIrOy1VC/q/RGm6MuCxxnTgNj+LHIc=@vger.kernel.org, AJvYcCXl2owR/NwNQVn39b+2NaKAGhrehj3C1vUbwTUv+wdMdBdqllzTH7HqRokkwF0Oybodyi9nliWT@vger.kernel.org
X-Gm-Message-State: AOJu0YwphPRRAqL+VTim4nUFWf+Mmlo5NHV6UsT3CJD29eBxN8qDhCcA
	eiDyKyqZbQk40SEPebzlM1wz772gbSvGQRumTeR/1va+AeIwLMgD
X-Gm-Gg: ASbGncs7Oe9fWiQCfLoNN/IVD3z7oGbOR8wzSbQvxpbVFsbCKe3Fw2mxYy8Z2sQCuv+
	0oxSmRmlghwWg6jVgHG/fKstabdysrlLNXpp3O5i77h7XHN5Jt9sCMNtcb9FbASCp2IMhwletcn
	mRbLvJbLlU6+vrcri97ObBdNrWH8ng5c43oNnAo3DD0JSbnYnH/PU759pSGSbj6NGHxjlzU1lE2
	pnsvIVsw0YUg2wMeUAucb4YcR8mM5pMUrgw8nW3t7V/6C5/R+nG9PsTGEGDbAt+CQBh2/0VwtLj
	b4fuOdbM/n46xs0OI71Eh8OpOBZSH6Xkk6M=
X-Google-Smtp-Source: AGHT+IHxkoIcgQxBbj0ciatdL7H4EBGHVSGfFVFHwRZVnlMCWlyOVBnZV3aq1Br4MZ+u1VewNyVCmQ==
X-Received: by 2002:a05:6402:234e:b0:5e7:b092:3114 with SMTP id 4fb4d7f45d1cf-5ebcd4337e2mr3314190a12.9.1742566951167;
        Fri, 21 Mar 2025 07:22:31 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0df302sm1468638a12.66.2025.03.21.07.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:22:30 -0700 (PDT)
Date: Fri, 21 Mar 2025 07:22:28 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <20250321-olivine-harrier-of-cubism-f2ad98@leitao>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <CANn89iLpON7eV9rHvErsoEu+GqDz18uYMv6M_4TLsh+WX9VQeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLpON7eV9rHvErsoEu+GqDz18uYMv6M_4TLsh+WX9VQeg@mail.gmail.com>

On Fri, Mar 21, 2025 at 11:37:31AM +0100, Eric Dumazet wrote:
> On Fri, Mar 21, 2025 at 10:31 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > lockdep_unregister_key() is called from critical code paths, including
> > sections where rtnl_lock() is held. For example, when replacing a qdisc
> > in a network device, network egress traffic is disabled while
> > __qdisc_destroy() is called for every network queue.
> >
> > If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
> > which gets blocked waiting for synchronize_rcu() to complete.
> >
> > For example, a simple tc command to replace a qdisc could take 13
> > seconds:
> >
> >   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> >     real    0m13.195s
> >     user    0m0.001s
> >     sys     0m2.746s
> >
> > During this time, network egress is completely frozen while waiting for
> > RCU synchronization.
> >
> > Use synchronize_rcu_expedited() instead to minimize the impact on
> > critical operations like network connectivity changes.
> 
> Running 'critical operations' with LOCKDEP enabled kernels seems a bit
> strange :)

Apologies, I meant to say that at Meta, we have certain service tiers
that can accommodate the performance trade-offs of running a "debug"
kernel. This kernel provides valuable feedback about its operations.

The aim is to identify any significant issues early on, rather than
having to debug "hard issues" (such as deadlocks, out-of-memory access,
etc) once the kernel is in production.

> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for your support during this investigation,
--breno

