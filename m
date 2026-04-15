Return-Path: <netdev+bounces-278622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME43LEn43mkNNAAAu9opvQ
	(envelope-from <netdev+bounces-278622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 04:30:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9853FFC6F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 04:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A711305377D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17667298CAB;
	Wed, 15 Apr 2026 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4E6fgUc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16EE224AF7
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 02:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220024; cv=none; b=qlYOm7MNBJZT+Ii6HIacMA3C4Km+q4mcoPNPCDym8XwQGBrKRoKRlXlLBYz8eJs9zM92/7LRl06NWqpzX1sgIKoM6/K/6XA/iRTM9sx77FY2cY6pi86HM2uVQiyG2gucGCEKI4uPtS1lrlROzlmJo/U1gFEFpWyBNgYi+7vALLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220024; c=relaxed/simple;
	bh=se/vKvsQL2DCtfKDUVWcw0v6I+7KYGglI/4Bflx1lI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL6wEaK/vzQbKWwf4KzBA3r9nn4HcDTVlTLs7rqrXwyqi2OBMiyyzFj4LbRIf7VIF/NSq0o4TK31ZXo4Yag5D9hsnDcWmt5gF+nCj3VsVfrYEKqTWyhMuLermxCisWNBeM6xThP5PUb+KHFROmDEQ/gFkq5nmuFfXBX/8fUQnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4E6fgUc; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76b6f9a50eso2468525a12.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 19:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220022; x=1776824822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IS60+FjovzFguj9ModkEOLa8EBlu6WeVu5VNYjZqwzI=;
        b=h4E6fgUcR3LZKLSmtkGZXPPp5IUI1VEbvwJkGWoUs+5qMrW7W9wsG/vcyVIb0oVIKQ
         862tixORmrB9AOtw4LOSc0fUsi8Pq6xKvSzEeJigAeR0K/RftafIplf6CjbZQgwVffcQ
         IBxDDsRzxewhyAvpT9v46cM6tg56FjqEoeGny52J/yzdpJynenJpatX4xYcCqHyM0+vQ
         otG4/4JEcmsvs6Na3bs1+UTMqA6Vd38vs3ngg8Ar7IJNhvEguJlMNDgbVEuPfCecuxUY
         OvUqoBDkgnW/er8NoWzxdqR30J5LYWdzI7lkNmrblxoWXKQGkYe4PD9yir5/tGiw/ksG
         FMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220022; x=1776824822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS60+FjovzFguj9ModkEOLa8EBlu6WeVu5VNYjZqwzI=;
        b=L1YN8dIt1Am2z6Jk0clSY2JbrgDpY7k6yCYmK5ZqLCC+TWWc6OVIqIGdBmpMqkiazJ
         U+npeUTRIryCwike4EwIGMYkoQaz2SxPlB3BFBYQWOJBO8ev3IlcjN6kGdF5NzFSSIew
         u1XHzXvLJdsf+7lAWG8sFS1h1K412FhTlsze0cMhQBBAwjPr3XjAD4syWT0SyXzh5fG8
         eTrvfrxapGvi7SG/oQvIU0HFq2fRk6FAbsf/Ke3i67SHICK1uhCf0XtRNtXkEoe6fJk/
         6+RhyFLE3wlpyf1I3Jg+afPJ+YjuxYXl0QfzzFU7clanIWOxAvSdfctvEeFFxLrTJxwj
         w6Eg==
X-Forwarded-Encrypted: i=1; AFNElJ/ETjJuS6boBZ/h7mS9PYSWbVNZnoSpWR8P0BZN8X/PsGY70E7D57olsQ2OaYn212B6nW5C3uU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KcId48qXzfTRjnE1A1Q6ONCrKZOL4EzRlECd6UfL/cNiniAM
	OPQXuwNziPMff/mU5ZwAi6kxPyqIuRxcQx7IF+YxJRbY7EA3Tai4eiWk
X-Gm-Gg: AeBDiet6sBNV9gs7Umkkg+RUocdfGSHioP3s0dCvFZS6aSDYwmI9LA0DW8jzx3FICwl
	B/Qc6i1HFbkgT3IvSo9b0527UmZbbgLG1VkRjZPHf+7VsU1j1YLd85j7t9+nZ2Qj15kozCKSEGD
	YkojDrH1pPNxKBiPKoXtznsQynNXTIUQPGGTXNXM7W6JV6HZYzFye2YzyRvGG9Doag8St0VTS2/
	4oVaqMHFffowJdDBqmA/WQeajcbgG/BiN3WOXoaxOfqsOZtYi2/yTwJbZ0aNtV0RItTv+aP1kDA
	Mh4thge8gC+1U2+0tmRZOny2MkVw8Ec9akGUUMvqTRdqe7JzcaVw2qCFI6pXqJ6pTX3m6RMRewT
	I53N8ipPzhmvBXzbf3HbCcrM09g161f1QYEu4m4pjTOaQIKSyb/eFaGxweD8T2z8uRO5eMZ98iV
	uaauF9Kf9SXhyorDP5vBQtSyp0g6zB6AgO14ij3T8vca2QvqNyovADTJMKzubnNbj6Q5ohRt7hn
	M8APzfzLQEqi5VUf2VuaTGhPBTyjHJB/1+Ob5zCwgrsF0uaCb2dFPwLOBwb9mLaUpr83yKgR2Se
X-Received: by 2002:a05:6a21:3286:b0:398:7e11:ad6 with SMTP id adf61e73a8af0-39fe373c516mr20699334637.0.1776220022218;
        Tue, 14 Apr 2026 19:27:02 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79581a3015sm187924a12.16.2026.04.14.19.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:27:01 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:27:00 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: ameryhung@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bot+bpf-ci@kernel.org, bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net, 
	eddyz87@gmail.com, ihor.solodrai@linux.dev, kernel-team@meta.com, 
	martin.lau@kernel.org, memxor@gmail.com, netdev@vger.kernel.org, 
	yonghong.song@linux.dev, linux-open-source@crowdstrike.com
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Use kmalloc_nolock() universally in
 local storage
Message-ID: <ydbdk5fj3mbjoninyt5lcg5czcrcgghk6ownothijy667zn6h3@eczgskgj43iw>
References: <CAADnVQKeFF--bgnZZSU12UY0muuwYA=7EdzLyOi837oZs+bXTA@mail.gmail.com>
 <20260413034829.39307-1-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413034829.39307-1-slava.imameev@crowdstrike.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278622-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,meta.com,iogearbox.net,linux.dev,crowdstrike.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C9853FFC6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 01:48:29PM +1000, Slava Imameev wrote:
> On Fri, 10 Apr 2026 21:39:00 -0700 Alexei Starovoitov wrote:
> > >
> > >
> > > This allows value sizes up to ~65KB. Before this patch, socket and
> > > inode storage used bpf_map_kzalloc() (backed by regular kmalloc)
> > > which could handle those large sizes. After this patch, any
> > > elem_size above KMALLOC_MAX_CACHE_SIZE will silently fail: the map
> > > creation succeeds via bpf_local_storage_map_alloc_check() but every
> > > element allocation returns NULL.
> > >
> > > Should BPF_LOCAL_STORAGE_MAX_VALUE_SIZE be updated to use
> > > KMALLOC_MAX_CACHE_SIZE instead of KMALLOC_MAX_SIZE now that all
> > > storage types go through kmalloc_nolock()?
> > >
> > > Slava Imameev raised the same concern for task storage in
> > > https://lore.kernel.org/bpf/20260410014341.47043-1-slava.imameev@crowdstrike.com/
> > 
> > Right. Let's update it, but I don't think it's a regression.
> > On a loaded system kmalloc_large() rarely succeeds for order 2+.
> > That's why kmalloc_nolock() doesn't attempt to bridge that gap.
> > One or two contiguous physical pages is the best one can expect.
> > In early bpf days we picked KMALLOC_MAX_SIZE assuming that
> > it's a realistic max for kmalloc().
> > It turned out to be wishful thinking.
> > kmalloc_large concept should really be removed.
> > It deceives users into thinking that it's usable.
> 
> In defense of supporting 8KB-64KB allocations for local
> storage, we can consider BPF_MAP_TYPE_HASH with BPF_F_NO_PREALLOC
> as providing similar functionality to replace the missing 8KB-64KB
> local storage allocation support. However, these map entry
> allocations can also fail with similar probability since they
> depend on the same underlying allocator.

I really hope that 64kb task local storage is not your production code.
Severs easily have 50k threads. Sometimes more.
64k * 50k = 3 Gbytes of memory wasted.
You need to redesign it from ground up.

