Return-Path: <netdev+bounces-267016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNl1MYiZsmnENwAAu9opvQ
	(envelope-from <netdev+bounces-267016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:46:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B94270787
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A6753002D12
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201338F92B;
	Thu, 12 Mar 2026 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmJz0r2J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9738F652
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312387; cv=none; b=gWV4LuYgZiJgawX95xyaxUkus6RQq0JZqVGU03TcBMGZmJlfwb/GDZbQaV8t5JR41ENa1EHvRs5nw10ZSDBk22pc1u6FiVRp6NbZzwLxxo3zA/4ugD66dePWyPrFucOMYEjwYlU2lkogKjQYUuK+tZwOiiTzuyRzNTzH0q93n1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312387; c=relaxed/simple;
	bh=QqK4fKBnKsrw0aRpPX6/Mgiw31EdmjhT0xJqXC7trww=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIdYzY4BMM6c2F32Suk++WTEm+Fwhd83AikxER9sqgldoRc/BZi8duh6qIS/CRNncMlxJ3XnSGmfK2taBnSwcLa7SdIBhi2GLCz1TUK94ENah8Wf424Yu0ebB+n83emEUqGuBc8kbt01dI2o2rywiKLfHPngBsDqYBcUB24Jn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmJz0r2J; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439ac15f35fso807604f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773312385; x=1773917185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3vGgz7KnTK9vuGJli7OEIVFiI/JsHt8PWV7ea4j0pww=;
        b=WmJz0r2JsEpo5cD2TGk5qGe9YT1BLr2qPgz6Dc3Ln+VU1zQh0pxz6dSCE9rogSQZw2
         wmgZRkVKXH5tMpnkUw2ytOGRMNAHvoiV1pq2xYJa8q85X4NhTefMtvdErZOVx33eSBvp
         N3CS3pLbnuj6VLr8O1tSSXqnVqjkqeEFuiBjJUyby+kAJbW8+kS/iYrFcrXo7Z0oxfER
         620ATw+DjFOxJHsX8PsLsszseVTV8wZs1+xE6PoHy0F2a497O+dGYrkp8jXzHPOIp4TW
         sJkPV8Fwrg9TB67662/SzV3K8HBfZ4RJJhwM0nGB6UoiKh3poCG+tj3aCOW+/Bc4GAgB
         W56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773312385; x=1773917185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vGgz7KnTK9vuGJli7OEIVFiI/JsHt8PWV7ea4j0pww=;
        b=UhkDOdcdxJqvNd/mScgaX32ZgHF/H+ieQggLuoYXHep/jTbYkQ1FAT//r6+q6w4Dm/
         WFqcbqTZhqiQtlENYRGrWIxTuVZWanIC95itDyBdojDcadOiF1YJWkU8GEsSN0Gb/GkW
         LeuKJNAgoo+hbpuSR/tTPVwwwcgMoJckzkrsFFeJiDeyo7hC9EuqZr55wuxLrR7cwWFA
         JMXVkRfKRImZJ5d+qwhvC9yVZzqTPS2PAifgATXXAeWnMwSPPVEGwOB3aVEqf9bXoR+m
         3PITwzWzsw+UI6xsWn3TCpwQlJIZ6yS9DwT12dkh47/d5jOmx3Vof9i/wNftFrCmeINr
         RVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXyYM7CKQEwTYV00vhs2RQyLktMUvb6toI/YAqAybNUw2GE/Sa1x1npXKAWVB0ViRUa9ygzN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRWSSrz3eSIB9ecwLv/lZS61zzU9yxCbkDZ6AAWAnHilo9VOU
	8V1chDGaLGegiZm3Xz71lrwzo4XIKRN1cS5lhR9YIJZBTGfaU6RRHLvN
X-Gm-Gg: ATEYQzy/za6T0IDXlBdb9dR7afhP9lTAhSw4k8tLweYxn1+6MpUd6ZjCuJXwe18T/7n
	w844fxm07frlaJu0ukaxF3GKqehuYVmRRSytzbNi6yPUOrF1+pZM+7Z4i0PpWyVfXf1802C35Nt
	9YIWIvEYUKc6j78ujv/ap9Hyug9Xk5/cgkSqUIc/ZIRuVXqIYlf4TqYp411i3bp5ndOmRXi7Mxs
	6orPSlKBJURayfmeYhqsFBotaNqGLk175eZx+idbmCHJDuV8eYHfbIHe4JKUTl/1yoxwfN/HYja
	PKhEvlYrN9z6q8RMh8Hx3Cq+zS0qtnqZpDdtKk8so2EN5GwMfZ0umN7+P+bMweZW/IaeYhuTi07
	7SVdvBFyuZRc+XfhwrsaQb12vdAPZiDuu824RSc9KxHBFpwYAh3eZSXlX687NpZhYq+EjkFDKKt
	So7pNFuXk=
X-Received: by 2002:a5d:5d0b:0:b0:439:b79d:b9a5 with SMTP id ffacd0b85a97d-439f8431382mr10986545f8f.37.1773312384396;
        Thu, 12 Mar 2026 03:46:24 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a737csm6568266f8f.10.2026.03.12.03.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:46:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Mar 2026 11:46:22 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
Message-ID: <abKZfhWs9Gojuvip@krava>
References: <20260303150639.85007-1-leon.hwang@linux.dev>
 <20260303150639.85007-4-leon.hwang@linux.dev>
 <abHwii5stH93Vz5E@krava>
 <931b490b-ab29-44fc-b888-8ac1ee8d8ccc@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931b490b-ab29-44fc-b888-8ac1ee8d8ccc@linux.dev>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267016-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,kylinos.cn,huawei.com,fb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olsajiri@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F1B94270787
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 10:24:24AM +0800, Leon Hwang wrote:
> On 12/3/26 06:45, Jiri Olsa wrote:
> > On Tue, Mar 03, 2026 at 11:06:36PM +0800, Leon Hwang wrote:
> >> Uprobe programs that modify regs require different runtime assumptions
> >> than those that do not. Mixing !kprobe_write_ctx progs with
> >> kprobe_write_ctx progs via tail calls could break these assumptions.
> >>
> >> To address this, reject the combination of !kprobe_write_ctx progs with
> >> kprobe_write_ctx progs in bpf_map_owner_matches(), which prevents the
> >> tail callee from modifying regs unexpectedly.
> > 
> > hi,
> > could you please give some example where this is actual problem?
> > I'd expect it's up to user (whoever installs the tailcall map) to
> > avoid such situations.
> > 
> The self test in patch #6 can verify the problem, that
> kprobe_write_ctx=true progs can be abused to modify struct pt_regs via
> tail calls when tracing kernel functions using kprobe_write_ctx=false prog.
> 
> Explain the problem by reusing the test code:
> 
> int dummy_run;
> u64 data;
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } prog_array_dummy SEC(".maps");
> 
> SEC("?kprobe")
> int dummy_kprobe(void *ctx)
> {
> 	dummy_run++;
> 	bpf_tail_call_static(ctx, &prog_array_dummy, 0);
> 	return 0;
> }
> 
> SEC("?kprobe")
> int kprobe(struct pt_regs *regs)
> {
> 	data = regs->di = 0;
> 	return 0;
> }
> 
> The "kprobe" prog will be added to "prog_array_dummy" map.
> 
> In user space, the "dummy_kprobe" prog will attach to kernel function
> "bpf_entry_test1".
> 
> Actually, without this patch, when "bpf_fentry_test1" runs, the arg "a"
> will be updated as 0. Thus, bpf_prog_test_run_tracing() returns -EFAULT
> instead of 0.
> 
> bpf_prog_test_run_tracing()
> |-->bpf_fentry_test1()
>     |-->dummy_kprobe()
>         |-->kprobe() /* via tail call */
>             |-->regs->di = 0;
>     return 1; /* instead of 2 */
> return -EFAULT;
> 
> Yep, the commit log is not clear to describe this abuse problem. Will
> update it.

ah right :-\ ok, I think we need to do the suggested one way check and
that should prevent kprobes having writeable ctx

thanks,
jirka

