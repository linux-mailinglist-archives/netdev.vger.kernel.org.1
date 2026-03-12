Return-Path: <netdev+bounces-267153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OObkKa3nsmljQwAAu9opvQ
	(envelope-from <netdev+bounces-267153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:19:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE44127575A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 318203064D8D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382363F7A80;
	Thu, 12 Mar 2026 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="m1ki3q6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE73EDAC0
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331744; cv=pass; b=RW8mT0nWmqCDVMLcLOBP1KgUq4zBI0umrbdBgvmKMQmnHTIBQrI74Tn+8pw+Bh4vW/NQspTio/EZeO1xloh2E8f0h/HMlKvegHh92J0iXqltl8l3/BiHQ9BILA+lGxhaF/T/hUmqanwJDwcL0svWhinWKo+YTPYdktA61W2/wEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331744; c=relaxed/simple;
	bh=/9ZhlXnE8IpHyY7rKGq8AMXoEoLmeVmAM+IAe1Oezhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwVM9tV12CvDAX3YFseBfOV5085cJJjZh7PkY7UydIqkCdhODDtA0Gh4guCKa4LBfl5o0NSzhzliMD4MhE9gx3+JgMHxNOR93NFc+BUfV+aAtYDb7F4HIa/WbqDmyFXpVANyF84+oskUy2qr4bD2LDp5bBV6aYcZ1Uh6nLBy9lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=m1ki3q6s; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64aedd812baso1195686d50.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773331741; cv=none;
        d=google.com; s=arc-20240605;
        b=fotJpYtND+UJPicCk2hWD42/n67jEep/nFMNUZGoQggi9R9kMSbraH2/orwwNj9di9
         FHVbQdtqj9lqNlmj4my2k8rPJOQJsyKEDnDuBeWyqnkbYFr8Wfoxr+DEVdIfbNDT1YxD
         owCPOz5Kb/NoqBhDkPF53PJBY8nJpVGMsIDGoumiGrb5ERgLw2eTdhRkqriSgcKS+169
         IcehbwYPTt5Q3dHk02SJfMOUwahT0bRLZV+Gms9yA1Va9OHk6wDqhWnoDhg9jJpBZzoC
         ALxkCueka9hmS4jcp0sICibadRgorfP7PO7FstP4tRUQb7qQYSMRrEcDfTspY8TMDNd5
         wB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kI5PTFr09piXXwe+dHgxbmefu5uh1N96l8rxcGpDT20=;
        fh=Bp+cIotoemU4Syy/v73eT+Hsm5/CrHxHGuPHV/SLYWk=;
        b=Xs/+CMXnbVbYVaKFeIKf/hub3MqQ0srM47mFbbds0p4h8Oiv7xc65VdjE8/fX8SrOR
         /C87CM/gjTFH7K8/I9lsy1re+dW3shhiXI8Z46bR0x11WTeoqUDVwLSLyAGotqk80AEM
         1F33GD03F4niI1PvfrQDHokhFqUt/Ne6tsQ+x+fO/esMQbdl5LZyG4oSQ2+b3irf5ggB
         92yOO/1qUD+azQribj3f44kQmYKvwG3hYoeyQUZlUHkbEeAT5VjYnpqZP+oBvm8eXosf
         sirZ2IXwyCS0jsH2mWzcLNdfa2r9B6/zHGyPqNFIbv76IrFVSJZbpOd1I70Je/Exbm4R
         apsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773331741; x=1773936541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI5PTFr09piXXwe+dHgxbmefu5uh1N96l8rxcGpDT20=;
        b=m1ki3q6sM4E2UACesTTqdadtI+Q0abqlUwfIdHI+OjmsRX2whEFMpQZptypVWhQx7h
         QD04yZlyfzP3xSivF9scjOrX5/FKYwiLrKA2X7JGefZSd1ksKzyMr15sFt8BUlBtCA1S
         qJU7H/z8w1uO+F9Lf0dqC/P0kEVsXjabxHZfvBx9uTBgICn+qEBxH7rHMoE2jVFa285u
         ZgHMmgqvOB2dgKagDrzwCVgXrpWT6UXW/+5qlE/3A3PliRynwsbURLgRm9zWpjrvx8vj
         l50ZunSLyn6Bt2c18cyLVOhmld8Lw2f3Z/Tl83A9P3MTDzd0bDNTqIw9vU+Apak8seEn
         KC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773331741; x=1773936541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kI5PTFr09piXXwe+dHgxbmefu5uh1N96l8rxcGpDT20=;
        b=HhbS4OWkxH8/sD+fNflFMrj1kuQd7xB4HLXww6X0wfrgzvls9bFCxcomheKDqaf+In
         DjxRSm7kBiTDHkRYOBms0hk+2UZBLknwdAdopmZH490LRpZIemX9p5WiIEzSf+LDqfd9
         oTCLpGS0gQRarak3JYO0KFn0FnienoZtZbQhVDxiMNoE3tBEyu5VKwyY7NPJ96yrSfXk
         2AkdXcrkS3tIMHrcm2B/54wBaCPwPoTW8VosEhC+pNX5utrMuS6OM/n7Z5NZnlnCDms5
         M7meiJs47Ua1R3jlSfOoy94nSJuzsiwH3m7XJQls8gs9hkE6Foa1tu0gYaYpvqg3Mfzm
         +v/w==
X-Forwarded-Encrypted: i=1; AJvYcCXK+0ro2E1tRlwGCWLB25sSq1DiCYrGdVcXe+Krk70aS+nrTymm9Sy9Ju7r9c3XrcmHgkN7OAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybssWLI409CiXpfnB7EP7XyG9cWwgjIc0Q9sTMwLaNhnqvhgLu
	qsnfaLE8c5J78AF7aAxV1Nrkm56UirCdtTXPsqqwlPYGr6W99PF8EAtlslx7d9X1gwGZkNhLvsX
	7szENSWshxvHTU91MTpsdKO4mzWkSNC8dIG6F9IclUw==
X-Gm-Gg: ATEYQzxv4z/cY9ocdTvyLyViKpi5DUBAisKLJ+r92HRxj8ZRTODU4Ct0v8TtDYbdqlY
	AlU7e1bqSCL76rtyDCbvade9j0FdytoUqD3lvUMdThmnsqB1+m19vrq8ka6kkLYod7R1yTtKxVt
	rZiv9LtYuZlcuYDgQjVU3HocUtODDCla+c2HsRrqWR8n3EyUTqJJ4YkPvqzTJ5Lvh6l8pHqd+sa
	vX7N3+HgRs1xcWSP1A20WbQM+oPsyrGRWOyYItb/I0jGzGDr/lSNfWtUimAO5dS2jsnCbA+ml8c
	sSJ5iB8=
X-Received: by 2002:a05:690e:448d:b0:64a:e799:1d9c with SMTP id
 956f58d0204a3-64e63079bb0mr62693d50.60.1773331741406; Thu, 12 Mar 2026
 09:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com> <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com> <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
In-Reply-To: <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 12 Mar 2026 12:08:49 -0400
X-Gm-Features: AaiRm50l09G2avZYKQas6kLTqrDst8ZjnHTnngudy3h6MyVa79lzABXaRh3Trz0
Message-ID: <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dmitry Ilvokhin <d@ilvokhin.com>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	dev@openvswitch.org, Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
	dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
	Eddie James <eajames@linux.ibm.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267153-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[goodmis.org,infradead.org,ilvokhin.com,kernel.org,redhat.com,kernel.dk,vger.kernel.org,davemloft.net,google.com,iogearbox.net,gmail.com,ovn.org,lists.sourceforge.net,openvswitch.org,intel.com,lists.freedesktop.org,linaro.org,amd.com,linux.intel.com,samsung.com,lists.linaro.org,linux.ibm.com,codeconstruct.com.au,jms.id.au,lists.ozlabs.org,ffwll.ch,sang-engineering.com,analog.com,hansenpartnership.com,oracle.com,fb.com,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bitbyteword.org];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[72];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CE44127575A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:49=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-03-12 11:40, Steven Rostedt wrote:
> > On Thu, 12 Mar 2026 11:28:07 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >
> >>> Note, Vineeth came up with the naming. I would have done "do" but whe=
n I
> >>> saw "invoke" I thought it sounded better.
> >>
> >> It works as long as you don't have a tracing subsystem called
> >> "invoke", then you get into identifier clash territory.
> >
> > True. Perhaps we should do the double underscore trick.
> >
> > Instead of:  trace_invoke_foo()
> >
> > use:  trace_invoke__foo()
> >
> >
> > Which will make it more visible to what the trace event is.
> >
> > Hmm, we probably should have used: trace__foo() for all tracepoints, as
> > there's still functions that are called trace_foo() that are not
> > tracepoints :-p
>
> One certain way to eliminate identifier clash would be to go for a
> prefix to "trace_", e.g.
>
> do_trace_foo()
> call_trace_foo()

This was the initial idea, but it had conflict in the existing source:
call_trace_sched_update_nr_running. do_trace_##name also had
collisions when I checked. So, went with trace_invoke_##name. Did not
check rest of the suggestions here though.

Thanks,
Vineeth

> emit_trace_foo()
> __trace_foo()
> invoke_trace_foo()
> dispatch_trace_foo()
>
> Thanks,
>
> Mathieu
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

