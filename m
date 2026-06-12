Return-Path: <netdev+bounces-298745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HwzCC2g9LGrROAQAu9opvQ
	(envelope-from <netdev+bounces-298745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:10:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6B167B39D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:09:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=CU7IQkGj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298745-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298745-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08C42308AD54
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EBE3F929B;
	Fri, 12 Jun 2026 17:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B1374A1E
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:08:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284085; cv=none; b=YwJv4swB9gEJWfpTMdAVRH/nshPFqAF2/YUSh7Ef+4eHxYnHIKZPx9ZRykHIvLWS/FTyc5u3y+JchsxSvgCYZMSBGICMhQbwOa4NWvYbKoSUkePfeKHWhEzShskPC47juwFQD1RIuT6z70XVc9/EJ2gnZOEwu33Ft/rhbgxwvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284085; c=relaxed/simple;
	bh=h83cZuhx86PznVMJOv1LGALcQExDxFPtMSyWm73fAF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH/xjin7Lwc2soaW0gxFYo+khraCmWppF3Ki7W5dSLVWA+NU71f7Uz78wyDWmjMG2klhzkrwNdohwEkilM8qKVVwYJMBuwEAeUqff6Wy1sWoIILCs0DqhKVtiYmA/HFVf7cZwvfHqSxeGGKe22Q2xOerVnBKVN8lkPvKRXZBSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CU7IQkGj; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0b1a48855so3405ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781284083; x=1781888883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HPeZaPzs0udTqN8U0AOdGBgcRR2p1XdQkPuDGe3FfyI=;
        b=CU7IQkGjJJnqxPl7TVpRGONn95WTHJBnOk9UyeodmgsviVBANzrgc5ElFKfxWAp8Zi
         y0gy/adziAlDfw9f5wKeBXHvF5sDfxdCYMVMidK4svcMN2V+as9KmWjwg+mWgfAFreUR
         f7Hq2MrB66iAk7zlCOhahTyrGR4CU2hiWGfuM7o3b7FXvGjFcMpCK8OON9Ub9O+4Fs3o
         VTK6eYdW0JssHqQF0UrEinryuOLTd3HbRkPBh7d0cm6+WcjZf5c1LEyH/vq8VdAPVmU2
         OuaTvO4N0ABFQjGjfRpvlaqP/ciOKXnOteo21FBViRSvWMqksYDqkAb8xM7X6eabekUv
         FdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284083; x=1781888883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPeZaPzs0udTqN8U0AOdGBgcRR2p1XdQkPuDGe3FfyI=;
        b=cvMhfD7iFLPWb4rWQ1FeugVMz4juIjTfHhJ16zScLcUdD321zsCY2AkJr/j/br962k
         nW/qu2cP6QLEwz2S0VjGIK+NC0ltxUFX2ReYCsHnKXNgeMZI58aAcxu1C+eiOriEaxFL
         0o2l1zK1HG9F5wEOnZ0kb7eJWo0FhciPmEop26UhjFM3uMav8Xytxmxl5PvMiFaCF3bA
         8ZX30I1YlLy+hX9irqYk1sfBRnFCBHA6jD5e8dC7Kan/BolTqx9Bf7b9kl4SXcMkp/VU
         175CnUwAjkhKjdtid/DVcZqaUHDYdLOQZfKIOpRteyvUn2aO4tLfKqaZ71fnjPhQ2ZQd
         U5Iw==
X-Forwarded-Encrypted: i=1; AFNElJ82X3ah1r5a4QcPJEZ/ATmT40VabkTt4BddQqMgsFAyQ4mgbrybr6kiS84wft1mGzmdls4DWQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykudKR72DMNbv6LJNmQKzUyR+bI0cbvtOGl0tXCwbg9Xl+ftNo
	5wbGVSadyNb/rNjkYaDQdGP56Qfq1+mH5hAGAakMFtxiv4D09RuQsI6pLLJ1E/gqxA==
X-Gm-Gg: Acq92OHyNF4i4PaKwFLzgoUFPCNg6i6eoup1MuZXnUMSMZ2ywsGMzUAFSXcVceUEKWz
	PXcQXI+xxS0Mt+S0uwHEXz9lYQL7iZ0sMyxqKpLi7UBdHNZXdoM7VQA2ZGfv0koKB4GLTEhCiRF
	RnKRxYBWKf8LB5ZeAP2+w83x/sfa885aph1M3o+M6AGlrBDC4rEWQDohtPoaZJUVb2uXSIjnJ+j
	BrtbtYj6ZToN7TxfrBAeCxUoDowcgPNYE3peDxbOMhwnlrvs+WhHwjT1ZmcUt+9zYTs4yu32SfR
	zqb16WNtc3a33q3F/56kfJiSL9yvevWP9erfRS0xuVlX6PwJFMn8gPikwJ/i1TvfPi6cZykFNFt
	0zQexxGV2j5sljbwajoQFZl1XheM08Gb3F7WipAj8+YAvQ5XX7iMB2gya9QzjeXqXf9RJcTdQUx
	N7vQ4Yc0l4QajC3m4H2oQttEqZuuDxQR37rCg4HizTScoyMt0E6EWVeSYL11BAKFwADuhFNBfNS
	u/+/o++Kt2ylWLnC05EwJKcOAVmQJ5TIbF/1YAGCjWgWA==
X-Received: by 2002:a17:903:4407:b0:2bf:1153:54a0 with SMTP id d9443c01a7336-2c6651871abmr15805ad.23.1781284082627;
        Fri, 12 Jun 2026 10:08:02 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm25331385ad.36.2026.06.12.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:08:01 -0700 (PDT)
Date: Fri, 12 Jun 2026 17:07:56 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Christian Brauner <christian@brauner.io>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <aiw87FbaIvYrSYDQ@google.com>
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230413.D68967BC@davehans-spike.ostc.intel.com>
 <aipphZ5iCnbXVNSR@google.com>
 <CAJuCfpHmem_g7mEoic7O56LVSLkbftgWYgzexPWy7VSwp7_SiA@mail.gmail.com>
 <131c6a49-9177-418b-a653-8f13942fb8d3@kernel.org>
 <876077cc-db6a-4517-9d81-cdfbb43e599e@intel.com>
 <CAJuCfpFh60wULMkFc7hzxWNg+qmZ2R_HMw_QZe5CNcDRFuoN6A@mail.gmail.com>
 <e9e196ff-7428-43bd-8e06-dc2cf0628c9e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e196ff-7428-43bd-8e06-dc2cf0628c9e@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298745-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@intel.com,m:surenb@google.com,m:vbabka@kernel.org,m:aliceryhl@google.com,m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:arve@android.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:tkjos@android.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cmllamas@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D6B167B39D

On Fri, Jun 12, 2026 at 09:54:58AM -0700, Dave Hansen wrote:
> On 6/12/26 09:41, Suren Baghdasaryan wrote:
> >> I think the key to distinguishing between:
> >>
> >>         vma==NULL because there's no VMA
> >> and
> >>         vma==NULL because of a trylock failure
> >>
> >> is binder_alloc_is_mapped(). It won't return false until vm_ops->close()
> >> finishes. vm_ops->close() shouldn't be able to happen while
> >> lock_vma_under_rcu() is held. So if you've got a non-NULL VMA, you've
> >> also got a stable is binder_alloc_is_mapped().
> > By "stable binder_alloc_is_mapped()" do you mean it would always be
> > true?
> 
> By stable, I meant that it can't change.
> 
> 	vma = lock_vma_under_rcu()
> 	mapped = binder_alloc_is_mapped();
> 	<window>
> 	vma_end_read(vma);
> 
> During <window> it can't go from true=>false or false=>true.
> 
> false=>true never happens from what I can tell. It's just plain
> impossible given the current code.
> 
> true=>false is locked out because when lock_vma_under_rcu() is held.
> 
> > Asking because in your patch you removed this condition:
> > 
> > -         if (vma && !binder_alloc_is_mapped(alloc))
> > -                  goto err_invalid_vma;
> > 
> > So, previously if we found the VMA but binder_alloc_is_mapped()==false
> > we would bail out and now we don't. Are you reasoning that this
> > combination is impossible?
> 
> It's not impossible, but I do think it is irrelevant. Or at least that
> the *VMA* is irrelevant in this case. binder_alloc_is_mapped()==false
> means that the binder VMA is gone. It's not in the maple tree, and it's
> not coming back. If a VMA is found, it's an impostor.
> 
> That's why I did:
> 
> -        if (vma) {
> +        if (mapped) {
> 
> The question isn't whether a VMA was found. The question is whether the
> binder VMA is still mapped at page_addr. *That* is best inferred from
> binder_alloc_is_mapped(), not the VMA lookup.
> 
> At least that's what I decided after staring at it for far too long.

Yes, I _think_ binder_alloc_is_mapped() can help distinguish between the
two scenarios (contention vs vma-close). However, I think it would be
simpler and safe to do an early exit:

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 88c3e1667d5b..9dd7d927249d 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1149,6 +1149,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	 * for 'page_addr'.
 	 */
 	vma = lock_vma_under_rcu(mm, page_addr);
+	if (!vma && binder_alloc_is_mapped(alloc))
+		goto err_vma_lock_failed;
 
 	if (!mutex_trylock(&alloc->mutex))
 		goto err_get_alloc_mutex_failed;

