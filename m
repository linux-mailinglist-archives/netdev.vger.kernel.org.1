Return-Path: <netdev+bounces-267132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAxtML3esmncQQAAu9opvQ
	(envelope-from <netdev+bounces-267132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:41:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFF6274BDF
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB803300A384
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AFD3D8124;
	Thu, 12 Mar 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="e3vaIiIY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C273CA495
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329961; cv=pass; b=ObXKokYpTBRBuZqlrKNy359zw9iazoVk4/kbE1a4R5Wz7jes187iykfRuhfBnVAwfkR3/pWVHVq7t92HeTlmVU/QrN8fHiK6vVz6FFmaUjXOdgEXZj675zcidenT1HbZKRS32QqeVD7aXxRCHkF/l3eiW50TzhU1r0pKWqm9mvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329961; c=relaxed/simple;
	bh=4tNFTOMSBZ1/Qp5RW7o3J5ezE7GBWsXKNJ/prrgOmk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGXssz+S0EM/nbr52H6Rr4B5lpOitvjOFPBOeCfkmJi19vBZbfy9rPSjRlxt41IkI03o4nzzS4Pfx86bDA7HK1zU31WSDGcyGJji3j87RTmUAQL/GpfHDu/laEf1wLJkmkLnNUa2fiR+CzgNMWo5LJX3v0619qbdVzjxBV/WTe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=e3vaIiIY; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c9a6d6b70so1060701d50.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773329958; cv=none;
        d=google.com; s=arc-20240605;
        b=D6FHlhVaa8/vxAComV9R9X2ysYhlU9nYbjoV5QhKlXGQWDrhkBOunuWVs34bhMsRDi
         vE2JaPInfZPhkskdZodFkaLn3cMzFOXi8yjRcv5k6p427PMNCWAzHWh1h+Jq1g32thuv
         Xi3vqM2F4ulnIphxg0Svt5jnGVQIL82LUk3ntWvbtYoylvOI/lYSKGwXghcN1pxlUhsx
         5luyRcX+VtQg08h18BZJjyLXrxIElxr6YP4r5X1H+5/Qw2miaiUzcfIlEss0KPO/8cnY
         bl5M7tzcHWZ6eCk8XEcON2wp+MUBXTTRJfqNsWiu4avNmaRBWy6ghrea+cQk2jgNX4WF
         WhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        fh=GS3BV1yC1wcUa4alTJeNc78zfYym5JJ6mb7v7Qs/DbY=;
        b=BFQ8td5yJpc7PPJvmIU8Zz3/8MCSxUdAQ3kDHenwlazfaWZwTjxrPbpjIQtUrddQeN
         jVf9bT2WLBeFZC/hTHGmBMkShVVyyVR+o8H9D1G8firmtH3909zKwtny5QyzShsRLIxN
         5YcJVUHSP9vpB2J8UzZBsvaAybmeOOejYpuPxMKd3uwDjIxjdme9U7MCkL588XuGFlZS
         qS9V8utprMqTRMwj/FFDOQUGi+UU0SnF/nU1X9vLrH2HdqeaO3r+7QFLbGNN8kJETaMp
         KeKOTeEte2OnXswGroxFF+ISqLOzVFBf17rqG5xMz9brq4tGRqr06/ekbBB04ckemAxc
         rREw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773329958; x=1773934758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        b=e3vaIiIYGWUOtCfN3v0i0XwlQU8iKw5tKJiDxrs5BpZgUFpI7tsKG3ZooWaPnqOdPC
         Z8SAY5DTLTvpjaOB6s9bQ3ZxX+LcGGgsdf6NZnIPHM+cPfYf7mdvQUxOUB0MAZatRAPX
         OPlQ6GS038tCrg8KJ4MGW9OOzjznHa++hyHmoFietr8QqWOe5FW8fUSSVZIetM87CB5M
         jIZEMQ7uYMS4Ig4PCqqRV43UmxiY9EVL0EW92WOQZ4YI2E2FPpEUlNbyASWYFFksXS3t
         9mACIIHPFuYoU4rBir3aqJDHbJg+APFP1wB7a8eG0Ml1cARiYuzc0pJgDxzADpeGYDNg
         MfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329958; x=1773934758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        b=Fxksesapbazm+246+J26sDbHbsQFrKWspNh8p4NRzc+Bu3uwUOOrA2oySuv6gVtk7l
         NaXRUYYEau/pTeiwndRI/95rcwKOcrR0fr9PVuJfNpAXHf/m1+avSakAJuPUgI0OpXlA
         xDEZP7iiXajjLkEnSwRWkSjNfRAlpD10uMIjGjB4h7FUXOVD/q0We3XQycwaZ8ANsE1e
         zDwV2hffe9DZQdElkeF2mrQyGJE1v45UOKzAhqAHXfUlJia7iSfW6FQWLXpJUgQs2KqA
         wNJnGMahEraLoyB/Q40n4GRXsntvfjft3cUNI20x3HEnFq/0RQOHJQMSztJgLZsxKV/H
         bU8w==
X-Forwarded-Encrypted: i=1; AJvYcCWUEX8P1QGY1iLXHk2SAZhk0ywu4BGOC/huz/hYzaC+F8st16MMYdo/9v8bD9OhMPpUczFfUxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlwzG3z//g/d+L8PQ0tGxUMG5Z5qtthFF8W5G/31+U4GFvGfxx
	aWuZPGwBtnkMDTdcK6tpsKfh31zZ/b7QN2Qqy+4PSoVFsjN6MFOwBlwYgSr8wcAe6OcZXtDgKH7
	ko7/nGOwRtO0+JwqPcu5it2LhqrVKnXRzNpFpt0GmiA==
X-Gm-Gg: ATEYQzy45/BHIUUjFrEy+FleGFIdl6gtLlMXj5OyOL9Yb+v81UnsTh7JGvhM2juHfUF
	0/6YQgsQNRx3eLd2yJuTB3VcldBuGDT4yyV35089fMWOhH+GhUtnZ7eQLBO9eaMOU95HhpmXVA3
	LsjsYhCgiw/+cOFsxpKCm00VzUUrHfMkwLpftvSIYBEzsmES+w38nRCfhayfR7jMvR+9hxG3qqx
	h66X+BC1gCdSnFXEmMT9w+6EvJN4mv+NIXJsTi7bJ1jnPWrdTTA6TpGOEuHkPxbOHWPI1Uv+ehz
	xIm+IapabI4fjsUV3A==
X-Received: by 2002:a53:bb8d:0:b0:64d:5742:5ab0 with SMTP id
 956f58d0204a3-64d6577eb37mr4463263d50.43.1773329958142; Thu, 12 Mar 2026
 08:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-2-vineeth@bitbyteword.org> <20260312111255.7925b4e2@gandalf.local.home>
In-Reply-To: <20260312111255.7925b4e2@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 12 Mar 2026 11:39:06 -0400
X-Gm-Features: AaiRm53MQsKCFNMcydaZ5MLANW9ImopAkQThe-DUzJ0WQT8Ah4MCG48E4vTQfog
Message-ID: <CAO7JXPhg-Etspj9YahZrq8cmZ2K6AGWDrMnHO+oD96P_SmOLBw@mail.gmail.com>
Subject: Re: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
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
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267132-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bitbyteword.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,ilvokhin.com,kernel.org,efficios.com,redhat.com,kernel.dk,vger.kernel.org,davemloft.net,google.com,iogearbox.net,gmail.com,ovn.org,lists.sourceforge.net,openvswitch.org,intel.com,lists.freedesktop.org,linaro.org,amd.com,linux.intel.com,samsung.com,lists.linaro.org,linux.ibm.com,codeconstruct.com.au,jms.id.au,lists.ozlabs.org,ffwll.ch,sang-engineering.com,analog.com,hansenpartnership.com,oracle.com,fb.com,suse.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[72];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bitbyteword.org:dkim,bitbyteword.org:email,infradead.org:email,goodmis.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1AFF6274BDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:13=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 12 Mar 2026 11:04:56 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
>
> > Add trace_invoke_##name() as a companion to trace_##name().  When a
> > caller already guards a tracepoint with an explicit enabled check:
> >
> >   if (trace_foo_enabled() && cond)
> >       trace_foo(args);
> >
> > trace_foo() internally repeats the static_branch_unlikely() test, which
> > the compiler cannot fold since static branches are patched binary
> > instructions.  This results in two static-branch evaluations for every
> > guarded call site.
> >
> > trace_invoke_##name() calls __do_trace_##name() directly, skipping the
> > redundant static-branch re-check.  This avoids leaking the internal
> > __do_trace_##name() symbol into call sites while still eliminating the
> > double evaluation:
> >
> >   if (trace_foo_enabled() && cond)
> >       trace_invoke_foo(args);   /* calls __do_trace_foo() directly */
> >
> > Three locations are updated:
> > - __DECLARE_TRACE: invoke form omits static_branch_unlikely, retains
> >   the LOCKDEP RCU-watching assertion.
> > - __DECLARE_TRACE_SYSCALL: same, plus retains might_fault().
> > - !TRACEPOINTS_ENABLED stub: empty no-op so callers compile cleanly
> >   when tracepoints are compiled out.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6
>
> I'm guessing Claude helped with the other patches. Did it really help wit=
h this one?
>

Claude wrote and build tested the whole series based on my guidance
and prompt :-). I verified the series before sending it out, but
claude did the initial work.

Thanks,
Vineeth

