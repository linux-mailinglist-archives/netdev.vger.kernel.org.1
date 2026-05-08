Return-Path: <netdev+bounces-285668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEkDAxuA/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:18:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 600DE4F2574
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 501B5303AB57
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 06:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83516377ED2;
	Fri,  8 May 2026 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KM4KFiy3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WC73NZfr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E0363087
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221026; cv=none; b=FUAVpZDdes1oVn35BQl/ZvFcWR71uxLC5y+PBpZOMzUWs/aWj7Qqva6+ywnMZj8wHDwp/AmmLbq/SFdatA1h2QeAomLkOjL3DB6lq9TQlJzXgkEC1JB3KhOxzifvtCmmPvqI9DU5Y5XXKFJfNbnuCHdYwwF+7k3v7CGk949Fk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221026; c=relaxed/simple;
	bh=maMKpG5JtsahwCoCistRB9wzcOXtXjO7nbLwk2IXAhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDqEeQW1iTHiMfCoG188JmPvdhOH57QFz9bi4AOlL8REXS5zIXVzi4JDbZk3tahMIqX4aG63MejFA15JIK69+kowKNBdK8oRkAGi0Pbsq/RQ1RPZfkMUIyxXgCC+vP0H0hdS2yCGXSdQgX+ax6zN34toO40NUoTwBB5u9tJZ2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KM4KFiy3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WC73NZfr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778221011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2unXq22HY2FnCjKT6qtydtFufJI+AwXDzC5gFdjej0M=;
	b=KM4KFiy3W6T+yPa/+5TBYd1nyixpSjiBEJeevhfbKczLBojqwwkjOZLUt2rw0Ippl6mMJO
	yfKH2GOb9iIeVrJVZMfkS6Wc5kPOkuifcWfQXjSCfMObaClabjHAnD5TLiFT9O6ezCZ8ia
	sCxxM31/M5PT44GCBVKwju3q0slF5KA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-bgAczFDhOpOzO1GzG9YIHQ-1; Fri, 08 May 2026 02:16:49 -0400
X-MC-Unique: bgAczFDhOpOzO1GzG9YIHQ-1
X-Mimecast-MFC-AGG-ID: bgAczFDhOpOzO1GzG9YIHQ_1778221009
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d035e8593so9291325e9.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778221009; x=1778825809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2unXq22HY2FnCjKT6qtydtFufJI+AwXDzC5gFdjej0M=;
        b=WC73NZfrVgDjnu9fLdg0DG0PNzAYjDzBpAAqvdnQ3noZcCDgG8C6zkzHWRBebhEwoS
         wqlmKSbNHs7cYITn77UlnU4LMNrsjg3DwxMy/g9NtTnzJLg32dnDcDhv66njJ2+zH7+A
         umaBOoW+BWWymzERrSReGwmoiv95l2aL2dy9P5abjufqwrwxJ7LFnkBm8/ketCmfC+WP
         b07FmT1YyAlx21PQqBwK+zeeVuZpqllaG/jhm5Ug3Sh30CkZVkdZOzGLjgDRaR8b06Pd
         wS7Prx4Rn5EniTLLHs+N+1aKx3NvXiOSZJvrjh96GESKXM5rmbSyxe/3YkVtxFBKo5Kh
         694g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221009; x=1778825809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2unXq22HY2FnCjKT6qtydtFufJI+AwXDzC5gFdjej0M=;
        b=F/fzFdNfqViSvDq1k3wf3krbzlKma9VkKRHcevepSGSOos+DCm7YTYGlOu0P/89N9p
         hd/g8L6iZODR2seibkdZWTNRv3g5weSkqEINbnzcYcmpQ5aUexczqukK59b6vZ/cL3TG
         fBUGix0uhBY50U9f5v5TNwOt7Wi9R1lyaSrc4gN9WvLyfR8v4JPjY/csHzNW05Gp8T2C
         mO9dP+GolVETLCEx9qofzXHu8PHHJO5F5XXmLV64y3rSr23yYplHNxAgrnw7YBpNth7q
         wPItWKPD12nfCYnLJ6ib9TR0JYRQgre9KetR8qSOV/qlV9DeA4vRnns18t2c9+JsMUhk
         YRGA==
X-Forwarded-Encrypted: i=1; AFNElJ/LII6RYaiyVOdbnmKNgY61H/jrLSbW4Rn2crge29S7R7wrYfIk4MyWHJxdgRlhvdl8E2Rrx0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfERRJUkHpVFYvzfedgHQqWV/6n12EEoBhrHnbM2M92jqSoSHq
	B56pULI09AkYw7eV+WnUrBDxmaIje6SzF8MeiRHb8a0ptwDbJBE1Vtz03K+6fQxAhlf6wsK+xeX
	lMNHCmy6qbpR/deaIZakEopIPNvJq8SO8yZ2kRLOHc0rLi7ZLV7MOo8Ao7g==
X-Gm-Gg: AeBDietBjldau/3idxOikVd5HS3oVaLW/E6Hd00yqIckNDWltmvQxCXpUztjF02Ghgf
	fp3GwyuLy3pcq6R3/E6ccgaQmVac15bMaIBPu+AORzYJOlpXbFqsnO9poVaxrjBP+lDY+UEaQy0
	JdG/KlE43xxYhq11nA1FRknOS9lsMiVYJz5KilzisK1/ls6oGrG9medStItQu1SCge8FPbc4nqJ
	0mKMDxwU/fMelGKp9oyX0N5uYcGN4nRfD++TeCecuQqy9b972iHHmF0TV3lnplMfwe5Y7Wdsh1v
	LW+xxmH10TCNS7c1vnI7p0nKY6dlEAuvBDGIjyxcWqtvZiMkH0J3o8sqcFDFKk3CrtNEteOszXp
	2c8g4qqBg+O0kwbYwDbxEQ4+OgP2LzVrEtv26jRps
X-Received: by 2002:a05:600c:a47:b0:48a:75b9:5e07 with SMTP id 5b1f17b1804b1-48e6767e04fmr19385165e9.11.1778221008536;
        Thu, 07 May 2026 23:16:48 -0700 (PDT)
X-Received: by 2002:a05:600c:a47:b0:48a:75b9:5e07 with SMTP id 5b1f17b1804b1-48e6767e04fmr19384575e9.11.1778221007973;
        Thu, 07 May 2026 23:16:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68eef558sm15122585e9.7.2026.05.07.23.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:16:47 -0700 (PDT)
Date: Fri, 8 May 2026 02:16:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [mst-vhost:balloon 4/30] Warning: mm/mempolicy.c:2527 expecting
 prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages()
 instead
Message-ID: <20260508021630-mutt-send-email-mst@kernel.org>
References: <202605080331.y1eIdVUC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605080331.y1eIdVUC-lkp@intel.com>
X-Rspamd-Queue-Id: 600DE4F2574
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285668-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:56:56AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
> head:   9f56ee36fbf6a6d336dc6a9eaeb4f8a67cb42a31
> commit: 95744e0e9c4df79c6bc8ec96306b29c7a8e8984e [4/30] mm: move vma_alloc_folio to page_alloc.c
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260508/202605080331.y1eIdVUC-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605080331.y1eIdVUC-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605080331.y1eIdVUC-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> Warning: mm/mempolicy.c:2527 expecting prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages() instead
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


kerneldoc messed up by a rebase. will fix up.


