Return-Path: <netdev+bounces-285329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN3yI7SR/Gn3RQAAu9opvQ
	(envelope-from <netdev+bounces-285329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:20:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B7A4E921E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90D6430010F6
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C703F54DB;
	Thu,  7 May 2026 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4sUXdld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F243BD650
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160050; cv=none; b=fm0W2056EyJkzbQMZ+ppCZoQ3Kgn41EW1TjVziXCFE0AksZATqldp2BIksfyCTMXneDwaFbUlWUuZxsIo1hSgb2ma4RYTM4gWLVDrOzn7kOaUl2yd9pPRPHOGnnttEl4iTer1uuMjNXehzJV8Fy0pw/X3cVmQMz7SJPpUy9ljMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160050; c=relaxed/simple;
	bh=N2662rK4tPvBr/Loy9PP5duWViu6RfVtl2ZI4p9yelI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLo30aU8uMfyPM3vilu81EpIrQ5E0TEJqO+bS2zDxUDbNHzEesElICe9HxasWqR6ufGo6CapuJxbEvNsA7gmaX675MY2P5IwScAkyZKIm9NDmuS6CEvU+/B7u6rV9UDwJaoVVwznGHNIKu/sUSkIIjn0G5RkkJUYvHt0bps/SPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4sUXdld; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ea8563c693so91062485a.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778160048; x=1778764848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtTh1VUuY32XFa4d5Z8nQKKq0cbbxgXwcbvx9pZAPPg=;
        b=Q4sUXdldqpqbAmMyR8mMaibjnw3F61339ACBb5uu3YQl6O+LRaIVvg7gNkzDVO6Qm3
         TRFtpnwUjMyoUMo2nS53PqNDX+k736nhthYS0DcSuVGmK/ZhR3OCx6pULmnvujCdcc4V
         0kxbmJtr+6TeOwYWg3TnPvMf3P4pHIHDcm76JVKNxuPqVXzfJpRcegoVIPsjgjHdWd1c
         1MXWhsxQoonT6rQjkuLKzOv70bADFp9nu7TNqjyDdGXRn6d7dzoN92kDZJUL3HksSwsp
         rvar9oW738m9VfYkCzsZ/z1g5xVVkkEZbvnsYaZKTM7xGAKKfu+4QlEE7s101vaadD3b
         DNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778160048; x=1778764848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtTh1VUuY32XFa4d5Z8nQKKq0cbbxgXwcbvx9pZAPPg=;
        b=ZW6Do8B4+91azvUfCsj4gYDK8jxttPM/2M22fQuCMuotWQ32DfqeMpmWSiGh0Aaaon
         hPSYFKq8pahq1Pgn+aGhP/v6pdUD7q2GljMSk1UeV45U4JilrDVUujfTFyYLvFoAd7l0
         ALAsnJjho5c6LFvfod0P8mJ27D3Z2M8AyBMmlyHU7E+qP40XsIvAkOZSi44JynT4UQsS
         CxXCh7ndQzSUHsAlJ/ogP+bDLhM7gRKOmNKAXAEBo0ZYO1gry3fCs9CL4sUloAKRCVQt
         DwUk6mM1kKYPg2BkBsDIqGonjhAEdAqWUS9piF9s/v/Dnk95qQfcduHvJlSLaRKd+NVL
         jP5g==
X-Forwarded-Encrypted: i=1; AFNElJ+vOkoPeMu9SsmsEyKNMt8bFlvPnJ+ojxpJAYCNCAjLwGQMPHwF7vIgWbXYg7J26QKM/OsMAoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FF05M0Q+uJ05Nu+nGb6JXv61Mq59/CleI2NH8EPXi5OUUU6M
	NyRaqgYu9gOEQCL85WQOOyqMTP34PPvGPCR7wGlRW8QfI77mq9gjpFZu
X-Gm-Gg: AeBDievRWz++cUPHOVdjz+WANMS8V2K2rTkdPDtqiliGVxk+SCwLCqdbBZxPGdUaiBc
	HP+aw4niOzIXeDUcJkB/UvACiM05XLLbP0xQ+xlLlXxa/jIFgS0oo2PcG6yVFTEojJ7di5lyK/s
	KQNbXIZVTguS8JeHWHo4FudxlDJ+iK+8Ri0iMDsf6YfbH4AUceL594fawaipN4aquCp5Q6x7bH7
	sssqEMesaZBMTKUy5b2gOBGPKht8XF4+LtYPzqsSWiVCxorTRM0so794h3dp0RNJadVi/4uWfIh
	tVjWhvkgnn+YX+S2xhcUqFc7tilY6ADlND9/uevqGXuzQXXVMq1cisU0eixckNV1I7KTj48s1dj
	gPIH7dNj/WtU6q5f7j5GLUkn4XENPFqq6RHwoCeLJ3npkmZPVM2VLXjYET8WQgVwMPceb2P5k92
	PulhmnUObmDXoNoohMceyJ5VdMie5X3Fo57p6V/crHp13DvxIcfeTD0Cw/5NJ1KvTPtdscxBehD
	F+4Qw==
X-Received: by 2002:a05:620a:370d:b0:8d9:5463:132b with SMTP id af79cd13be357-904d68e0465mr1165521385a.49.1778160048192;
        Thu, 07 May 2026 06:20:48 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91fb3bsm1884500885a.41.2026.05.07.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:20:47 -0700 (PDT)
Date: Thu, 7 May 2026 09:20:45 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Simon Horman <horms@kernel.org>, Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: eth: fbnic: Fix addr validation in
 pcs write
Message-ID: <afyRrWW8XVeO55Ob@PF5YBGDS.localdomain>
References: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
 <20260504135815.44226-2-mike.marciniszyn@gmail.com>
 <20260506185819.1c68a71b@kernel.org>
 <1cd8256c-286a-4a73-b0a0-89233cb3c2d0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd8256c-286a-4a73-b0a0-89233cb3c2d0@redhat.com>
X-Rspamd-Queue-Id: 34B7A4E921E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285329-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,fb.com,meta.com,lunn.ch,davemloft.net,google.com,gmail.com,armlinux.org.uk,intel.com,trager.us,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 09:20:53AM +0200, Paolo Abeni wrote:
> On 5/7/26 3:58 AM, Jakub Kicinski wrote:
> > On Mon,  4 May 2026 09:58:12 -0400 mike.marciniszyn@gmail.com wrote:
> >> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> >>
> >> The DW IP has two distinct PCS address ranges cooresponding
> >> to the C45 PCS registers.
> >>
> >> The shim translates the PCS addr/regno into specific CSR writes
> >> into one of those two zero-relative.
> >>
> >> This patch fixes a one off in the test that could allow an invalid
> >> CSR write if an addr == 2 was called.
> >>
> >> This patch contains a fix for addr validation in fbnic_mdio_write_pcs()
> >> to only return actual CSR reads for addr 0 and 1.
> >>
> >> There are as of yet, no real impact for the bug as no PCS writes are
> >> not yet present.
> >
> > Hi Paolo! Was there a reason / do you recall why this was not applied?
> > (I dropped it from patchwork now. If the omission was accidental it has
> > to be reposted)
>
> Darn, limited capacity here plus re-submission glitch: v3 had a slightly
> different cover title (due to typo) WRT v2 so PW did not mark v2 as
> superseded. I process patches via PW in sequence, when I reached v2 I
> considered the sashiko comment not blocking and I apply it. I was unable
> to reach v3 until now.
>
> TL;DR: @Mike: please re-submit 1/4 and double check there are not other
> differences between v2 and v3 - otherwise more patches needed. Also
> please ensure you keep the series title consistent among revision, or at
> least manually remove old revisions from PW upon resubmission.
>
> Thanks,
>
> Paolo
>

I double checked v2 -> v3 for the other patches are ok.

I'm just now resending 1/4 of the series.  I reworded the commit message
to fix the AI review comment.

Mike

