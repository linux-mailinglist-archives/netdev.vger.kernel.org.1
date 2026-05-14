Return-Path: <netdev+bounces-287937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ2pCpC1BWqeZwIAu9opvQ
	(envelope-from <netdev+bounces-287937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:44:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A06F541267
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3F63008A61
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304C43C1F40;
	Thu, 14 May 2026 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rToDaxWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E938736B
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758911; cv=pass; b=rwGSuB30q6yQXekkOf4cx1F5THauzUciv4FimjZwQwzqn1jHrT5paLp7WtiuHSKKuuvFXR8yUq0EkANn2eTeBnV1pt2BznIcF2JWoUzFPQkXU1oTM2aXaq8+kpghogsfTA5TmSoObSNXtHXwZIXqDFznPUScGI6qxgnxWBn79QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758911; c=relaxed/simple;
	bh=kv467D/XoMhGiSVjKU11VbhHNBo8WeJHJpbMRzqUQvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8HUNnq0cQ+dIurIwTdmIbI8a2EuYm1OZMx1/UBQslJaZPKE48HmBLU6XtszCcvJxyFITtKRQnWSvm+og7qBDugttslO+zcCY8zgqmvArYxrCFohRFQ7t7/i+zAj5WliYVSkoFu+NeKqAYUWHe0H947/U/oPo4ctAswRkyd40Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rToDaxWu; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5165195c8b0so1132341cf.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 04:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778758908; cv=none;
        d=google.com; s=arc-20240605;
        b=K8EEaxyazV8KbfhaC/Yq6XtmmI4q928tWrKkC41juo1VMeiI5SrNZdlPvUOvjo6mRV
         COfQj9tYb1Yi0IE/pK2qiVXA9/slhMMrjHnHoplNQcRaNuzkwT+C7HVchgDgLu/Adyl/
         z78m4WuVDVWInqm3iy94JCgfpC7FVguVYCG7tJtgPqhKsZNWw1FIzqf2s9UFk/to8OoB
         xAicYIcZAPn5n2tE2Rn8FMQmpT5JFegTeUC/yD4KNoqOMJQjS6LIROBOrFJ9ySSYY4qG
         LYsaXI0bILim6Zorcv808nPCu+CAuGXu5MR7DbAkuHsntcZlOlE2sQeL9Q97zbAiA8sC
         C0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FyYIDxnGqYFvsZOiPf9MOOGSH/PxiYpL7rMNChWORiU=;
        fh=5C2woG64U508Htc0luwbRxxhATyiu3f94AXBAQocSz4=;
        b=Ko54P0IU5zI+LMITEkzeWBNDvW0xe6/4GUI4sez5e98f+/haY2/A5EC1A42qkvNz1E
         K2hUw0EyE6rW+QLTBQgyzxRKkAZeZAgBae+LTiLH2FnwdE+uSsPX18ummcNOHji1dnmA
         g6bO5QhJkJI/DoXcQoaruR5fzA3VuI4PltjHC5hGVxKdEXz+8kv97tXHik3IyNxd+OVE
         AnMi+hZmVgLQItIZvPJ4ELMVdcO3Cb/AgKgd1AAzSkPl74iiaA7w02nkPk9zYKucd4tN
         xVi7MPuMRhzZSQm9LK/1jfpE+Bu4sG0OyEiMLQqqRLCBsZHZaxXrXY3wfxVwRcUbVy3E
         t+pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778758908; x=1779363708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyYIDxnGqYFvsZOiPf9MOOGSH/PxiYpL7rMNChWORiU=;
        b=rToDaxWu/wn3TAoIL3+W/lzjodnro+AAGxqbkU22xhjplk3LIqq7dNjO1XfVQUw/Zj
         a4hgNey1mrRooJZIX5E2qnIoGtZNJK1QlN2tZ1Evoaz/VViRx+lsTIhA5YsMMSpIK/6U
         JGSa0Bqw25J0JhKUCExal/kn2jfRjXRJ/tRPlhADiv0+zuzme9BpE4FbTJ9D4DTCNUTc
         q8FVtWjMnEuS6ScnSASNs+mKYD9+e4OrE3OSrA3XdZlNdjFXuGJJcDsWg4wTdceFGTnp
         eu9o+6MAO+vZLstkeOZeIyuRNhMerAquWvV0MkHdtj9OqSgAPEpWkRbyu3hIRlQIW5iZ
         mfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778758908; x=1779363708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FyYIDxnGqYFvsZOiPf9MOOGSH/PxiYpL7rMNChWORiU=;
        b=I2eclS9/GWwzhsTUz8aVOvcN/li5gfjJteJpYFtQP/6x2ifhRxtfd5AZGk5UjXzsuQ
         hmzT2BIqPu5xsQZJgYZCqmzjVnV/B/LdAfj/5SYbInTec8d5C9GmNxyTJiqCsmNXw++7
         rV1nOpCF+wZPK0cXEpMK3bfcsjHX9wKuyhO15WN7Y0+wyZYJQiNMpzCx2N78y0RSW8GS
         4I3bR2EGkJ64t7sBV9gMh8tPsbv8gdNfqtSoJakG9nxk4rUlTacFD7eQzNB57kbeI+7q
         6M3kTezRdjX0pFjzYkOjW0vjTVpdbRCpUM3kNcGjIpl1TdjY9gKfCgK7VxawD4fr4Nln
         XbnA==
X-Gm-Message-State: AOJu0YzwZRP2dgQcT3UwPhPSqIOHt4d1Nc/R2H0ulgZlGuE9ok6DJeRI
	nCVaiEJWlppLhXSOE0F6wWc4XjSGYN7vAqB6+FdHs2pAneOrlg45tBI4QAP7yGWbWJOtxx7D5QI
	Rvl3AGWTmN9YWEGadTM/5XmcUZtXnMNazFrMY6oPn
X-Gm-Gg: Acq92OHSoDfaFVbNceyJXtE0/RS94bltLKCQRzI2i1pE8CSAmNHJed/ALIkMRfYLXXa
	gR5wXGi9X7dm8LqguNtr+hf1/y5ASfOZCOh5ZFvdJy/cAobiBBsOm5KGzhDB6HzWWBd/1PNuikt
	p9aw79STLEKu7nyHOqsdJUddAy7qDZOmHeO+iNGRkZr+tzbH9JH2g8hFKm9UjtVHe/uI+J+mttU
	woVGKZ8COqsa4uNtppWy84jpKEqLlSUT2lBRLibwAqqrrHef4KrtAAnxcv4c6Js0bbeWLo2EmfV
	WJb5zIM5rjlVg+Y799vlICUBdDKMB8K0oVIIs50GFKxVQQG+zAFsol6IWEdKH+dJzVNFd5/w/a+
	zKYE+HEZ2MRPFIr+Bt+ViDPWGqAU6HjgnH5v69mt8
X-Received: by 2002:ac8:5996:0:b0:50f:b257:9301 with SMTP id
 d75a77b69052e-5162f625bb0mr98872181cf.52.1778758907886; Thu, 14 May 2026
 04:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508072918.324797-1-agarwal.vineet2006@gmail.com>
In-Reply-To: <20260508072918.324797-1-agarwal.vineet2006@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 May 2026 04:41:36 -0700
X-Gm-Features: AVHnY4KsUbeVyglV3gUXtjT0w6MfWMHctdVoEHMDw5qkkO4w62bUONu4Pgel1bQ
Message-ID: <CANn89iKDAZJ8Xm4yGjnoMt5uSpezsYzH9RyiazwcsCio1Uop6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/sched: sch_dualpi2: annotate lockless
 stats reads in dump path
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7A06F541267
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287937-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 12:29=E2=80=AFAM Vineet Agarwal
<agarwal.vineet2006@gmail.com> wrote:
>
> dualpi2_dump_stats() runs without holding the qdisc lock and provides
> best-effort statistics to userspace.
>
> These fields are updated concurrently from enqueue and dequeue paths
> and may be observed locklessly in the dump path.
>
> Use READ_ONCE() to ensure safe single-copy loads of these counters and
> prevent compiler optimizations that could otherwise result in torn or
> inconsistent observations on weakly ordered architectures.
>
> No WRITE_ONCE() annotations are added because these statistics are
> maintained as best-effort counters, and the update paths already use
> simple non-synchronized increments consistent with existing qdisc
> statistics patterns. The intent of this change is only to make the
> lockless read semantics explicit.

I missed this V2, sorry for the delay.

I think we can cook a  more correct patch, with READ_ONCE() and WRITE_ONCE(=
).

I will send it now.

Thanks.

