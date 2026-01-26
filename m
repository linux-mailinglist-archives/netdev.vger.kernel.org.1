Return-Path: <netdev+bounces-253543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH9tN3abd2n0iwEAu9opvQ
	(envelope-from <netdev+bounces-253543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:51:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803068AF12
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23319307221A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932E345757;
	Mon, 26 Jan 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtC4TyBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F43242B1
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445910; cv=none; b=JiaEqdyDGca+psI0e0Q/XiEaaNPELzPS4RHUNOOV0H8Q6n/r0sbswOQ5/7VREnBXsuFJ2U1O0/i4jRvCn+szBqpuMoLSX1GOTO8cnwcyfcLVIlgqLurMuDToIhIVLw5dtHFE+vc7s8be7HTR9N4cOtwTe3Co9MM1D87eE30U9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445910; c=relaxed/simple;
	bh=tE3Uxmr9IsUS6mJokT1N6n0qqojE4/K3/OnOvYAIYeY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlvt3YwMyVqeNME2NDWuLE/+/YCCh/+sWfDLH7W0TZM2tjvQGVIbusRtMBUPQq37JYb63PRCIqgeHqcH2TDpOYU8cFrsgs8/CjQhrU7F1/IUhrb5l6uywxHGBBYpBDsxJu5voZ+5JdvFChUiIkKfnQb+VPP8QySa/UpchiqgNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtC4TyBb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b710d46ceso4530688e87.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769445904; x=1770050704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67gINf8nv70IfGM4en9MXo18NWyvtv/UqgQR1tCJ+fU=;
        b=WtC4TyBbh8yct5Y9IFzhxu13T+HfvneZprkfZ0mAaiIw3wzxldQspYusobja5GsuP4
         X5kOWhqhF39lZCG16fxs/fKUIE5THQRzlVq0W4vNDmcl48JAaEHKD8EQbCswT9K7Om0M
         +9jnqNGKD5Jc2BTFPAdgcLWw8d77Zwvbj6uPV75RsXJvj8oTtWJOqVeruQUhcBuRSwTb
         z7/PqGTIdy6K9vh0VBxxpA0zyNBnqmk6UH0YXkBF8MMw0CDVbt5K7arQBIXmU7Y/9Dhi
         xkW9VCVt8gU3LAlm3Ymxey5lhrSOs9uyZ8Pyl5YRI9s+puriPhqfgADmu6rXkB/9illR
         NDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769445904; x=1770050704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67gINf8nv70IfGM4en9MXo18NWyvtv/UqgQR1tCJ+fU=;
        b=sJwwo3osO9oL//JHr10OjDFQJ/0zMCRJMjc7Mzn4VsOukTg0hrNxSlIh+tUDOacSRi
         i7ZQXa/fLgBPHpofOaJHC6CBcV3Qx+bcLHNCokFcXoSqgsnIfV54+dMbNZ/1N1PhoDRq
         fYNau6YuJg72sBR5fhVw2Z5vNVQAe523qwh8eQzA/Hz/AlKhW3lOZgfp/DrCkpCI9qg5
         E6ybr6A6FKHXXZUbDC4qBDeZ8Dlog+jGWhbT+pUMB7yQLiHufN4WXku3YaSKF2RcQ8wr
         wfIcZXOxXjvHdzBZU3dyjhkQq30NzTqQZvQKTVXV0QA/p9ofWaMUPfAv7NAzH/yfM5jN
         KZPA==
X-Forwarded-Encrypted: i=1; AJvYcCV5clSnj7nBqebCRuFaPNf27E2mQTDZM9PJKiCzWl8JysSYgl5e67+eCsNGkhsQZ97KhGeHOQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+PI1Qop15bnhPoiafvUxu48pGa2WAZpOsW/Qe+fAWTAKedQr
	reGMnexUZVBJQSZJv5UthXoJ8cvs9gHFGSEh9lUiHudHVhtPHK2OVbXp
X-Gm-Gg: AZuq6aKu4XvhEcTUi7phZJ/jZ/dhZsNiKialtVRTeqmGf//QQTZdVy7rDZuHWPlMMvJ
	ScaMLiHXfx1PXuHYlaG5OwQh04kxJVpzAEDDzWBapU7Jw7lCVfYCE9r1nEq+/TCfvX083YvUlKZ
	b8Tb7MJn6hCBe1/M79VsASSnIKBc8n+i8cQ4x2s30Z66/LOrSk2pJ6jZXCW7dk8AtxPpzXBr2Sw
	3j3VFxcvsLhX2izVp8nB87pUKCz9K1mnugyZI8VqDwvOOddPLZEGnKhxI97ve8bBcQ6quCfVKxL
	30v+IEEDxjpYqes6enj297P8cEgLc8ZaeYvbPMqA5kbqGH1HnX7P3tEPX2pY+3pfcQ7aDErdWNx
	ETavsF2rsz/d4TAiD2FmIGPTodCK/7u0+6bqeAdgIPPKUtKyJodW9
X-Received: by 2002:a05:6512:3f06:b0:59d:f2a4:3e98 with SMTP id 2adb3069b0e04-59df360afd1mr1753347e87.4.1769445903361;
        Mon, 26 Jan 2026 08:45:03 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de492cd32sm2794304e87.100.2026.01.26.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:45:02 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 26 Jan 2026 17:45:00 +0100
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <aXeaDMczmQl6wn9v@milan>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <aXdB3lsm3w0fJT3Q@milan>
 <20260126120226.GA6424@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126120226.GA6424@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253543-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,kernel.org,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 803068AF12
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 08:02:26PM +0800, D. Wythe wrote:
> On Mon, Jan 26, 2026 at 11:28:46AM +0100, Uladzislau Rezki wrote:
> > Hello, D. Wythe!
> > 
> > > > > On Fri, Jan 23, 2026 at 07:55:17PM +0100, Uladzislau Rezki wrote:
> > > > > > On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> > > > > > > find_vm_area() provides a way to find the vm_struct associated with a
> > > > > > > virtual address. Export this symbol to modules so that modularized
> > > > > > > subsystems can perform lookups on vmalloc addresses.
> > > > > > > 
> > > > > > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  mm/vmalloc.c | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > 
> > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > index ecbac900c35f..3eb9fe761c34 100644
> > > > > > > --- a/mm/vmalloc.c
> > > > > > > +++ b/mm/vmalloc.c
> > > > > > > @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
> > > > > > >  
> > > > > > >  	return va->vm;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL_GPL(find_vm_area);
> > > > > > >  
> > > > > > This is internal. We can not just export it.
> > > > > > 
> > > > > > --
> > > > > > Uladzislau Rezki
> > > > > 
> > > > > Hi Uladzislau,
> > > > > 
> > > > > Thank you for the feedback. I agree that we should avoid exposing
> > > > > internal implementation details like struct vm_struct to external
> > > > > subsystems.
> > > > > 
> > > > > Following Christoph's suggestion, I'm planning to encapsulate the page
> > > > > order lookup into a minimal helper instead:
> > > > > 
> > > > > unsigned int vmalloc_page_order(const void *addr){
> > > > > 	struct vm_struct *vm;
> > > > >  	vm = find_vm_area(addr);
> > > > > 	return vm ? vm->page_order : 0;
> > > > > }
> > > > > EXPORT_SYMBOL_GPL(vmalloc_page_order);
> > > > > 
> > > > > Does this approach look reasonable to you? It would keep the vm_struct
> > > > > layout private while satisfying the optimization needs of SMC.
> > > > > 
> > > > Could you please clarify why you need info about page_order? I have not
> > > > looked at your second patch.
> > > > 
> > > > Thanks!
> > > > 
> > > > --
> > > > Uladzislau Rezki
> > > 
> > > Hi Uladzislau,
> > > 
> > > This stems from optimizing memory registration in SMC-R. To provide the
> > > RDMA hardware with direct access to memory buffers, we must register
> > > them with the NIC. During this process, the hardware generates one MTT
> > > entry for each physically contiguous block. Since these hardware entries
> > > are a finite and scarce resource, and SMC currently defaults to a 4KB
> > > registration granularity, a single 2MB buffer consumes 512 entries. In
> > > high-concurrency scenarios, this inefficiency quickly exhausts NIC
> > > resources and becomes a major bottleneck for system scalability.
> > > 
> > > To address this, we intend to use vmalloc_huge(). When it successfully
> > > allocates high-order pages, the vmalloc area is backed by a sequence of
> > > physically contiguous chunks (e.g., 2MB each). If we know this
> > > page_order, we can register these larger physical blocks instead of
> > > individual 4KB pages, reducing MTT consumption from 512 entries down to
> > > 1 for every 2MB of memory (with page_order == 9).
> > > 
> > > However, the result of vmalloc_huge() is currently opaque to the caller.
> > > We cannot determine whether it successfully allocated huge pages or fell
> > > back to 4KB pages based solely on the returned pointer. Therefore, we
> > > need a helper function to query the actual page order, enabling SMC-R to
> > > adapt its registration logic to the underlying physical layout.
> > > 
> > > I hope this clarifies our design motivation!
> > > 
> > Appreciate for the explanation. Yes it clarifies an intention.
> > 
> > As for proposed patch above:
> > 
> > - A page_order is available if CONFIG_HAVE_ARCH_HUGE_VMALLOC is defined;
> > - It makes sense to get a node, grab a spin-lock and find VM, save
> >   page_order and release the lock.
> > 
> > You can have a look at the vmalloc_dump_obj(void *object) function.
> > We try-spinlock there whereas you need just spin-lock. But the idea
> > is the same.
> > 
> > --
> > Uladzislau Rezki
> 
> Hi Uladzislau,
> 
> Thanks very much for the detailed guidance, especially on the correct
> locking pattern. This is extremely helpful.I will follow it and send
> a v2 patch series with the new helper implemented in mm/vmalloc.c.
> 
> Thanks again for your support.
> 
Welcome!

--
Uladzislau Rezki

