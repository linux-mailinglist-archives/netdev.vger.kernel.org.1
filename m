Return-Path: <netdev+bounces-67748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E5844DBD
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 01:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FB21C25C4C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5C2184;
	Thu,  1 Feb 2024 00:19:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE3386
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746761; cv=none; b=LuwhoLKEoVxBhY6ytcNP4Dc2Y7K7aI4CSo26SDYrOel6u2AEquQQW3kxAcNmrPgFCMukZMSb1bQd4taicF0zRn15YLYW7eVMK7V7eiuq3KA1gad7yl6RnbDgsmfCfj3W+GUcrphksaLvyoYqkrUdUkF1Lgqecdmt1D6UgrkGH0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746761; c=relaxed/simple;
	bh=SXoSUb25N4SIhzDyHycEEGGNHFWUa2jrgC425uOAoDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6tF0T5uPzjAcl+eDTinMpYSRCQkYQ6dvRwAb1MCxNmMHki6S/iNPoVu4mnpG7NJpBsv0dVxqLD9Wg3zZn18d+F6dRKpAF0zaDm41/NtHk2eatnQC3Iqk9Zb8+tEXIFX+F/z4wDXeB3dh5qbxUXmN9XSfMTC0a5CXtwAKmYW9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c794970d5so1746066d6.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746758; x=1707351558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOGWXS4vIGOtPO57OizB9tZVNU4X/XL4dLBYqD+darE=;
        b=DHuBT64leFU0rmBjxr24xdHeEPu1ccXX923eqlHi6EGH9t4JVwYYDFSOfyK9uPmyey
         KvFMTtEzuz50QXtgCUt0Xzajul9Fg7zKXPHB9vD4OLzHD8HgHdyQZ+5JHElJhPR9WWu1
         BVvkyE/1mn4/PRsL61N+TwW5wT11WJm7IkUnjJvWAhKnmjLTTQZnZI4Qcd8ofFNdp9nN
         eRcHYV2gYXxc2+XYI9Umh2n+CPUrdrRFupKXIK95sSZ9A9lnnhYyMJtbHY+BRKAOpOcg
         00/DwuyvoxX3oLExPzddlduq4CuBFytZEqB9LohU6Q5DRmR2b4uxWKvuyae93t7sRGvt
         SC2w==
X-Gm-Message-State: AOJu0YwfWjr5nA5r2n8xftffSVQlDahSdN1UaB+MIi4/A+wKnf3ArmHD
	EjPlHjLMoLCh9rTzP9nKGxXeeq2OmghlBLgGCVtX6c6T6vp+D6VjK6PzIqZKjw==
X-Google-Smtp-Source: AGHT+IFz2ZMJEVVJyslGbL2NC9jJRXeluErPH4TTAKBoKq5hLhQo2sNCISfpNnDx3bysA3PSYCdTaw==
X-Received: by 2002:a0c:f3cb:0:b0:68c:5a3b:330f with SMTP id f11-20020a0cf3cb000000b0068c5a3b330fmr6629455qvm.0.1706746758679;
        Wed, 31 Jan 2024 16:19:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUM/cFc6R6aZLbDsLKxeq42vMwKC0o7KnnDGJCJ3KsJJPmIYoFQ5SBpKU2Sbat2qv3A8jiuYLvVic3C0NCl1MXyn/r5kUL7DbN38/3NkhYv0d4+gLEnl4NOyrdW/+90eMg+x7A+3tggeoxVSZ+9uPhUgg5e5CyuytXUVms9rKmtsaUnU8BcLNdHQnBFzzNODgVRhhp/S/vyHVAV+7chsE/dfcMwc20O9d15aMpf/MxT3YTk7Lq0dcajFy1MACFnKiVvs3EYVwV4+LtZm4pDknbu6VEUi6lhMXIekjCHOsd09JGgB/spEReR/fyS3EwQg2DiX5GFfHJ/3ktzCsFxtInPQs/lb6FH6Y3NRWPS0B0uKaQUT+vxXTHq2hSbFJsNFoyVUA1zmPMVpviNmFcMXU42RrqO9WWuGy9q+3AXX3abD0/BV0Cxx7/hTd5+QwsvMeFF23vzfmX8TIHJ4ntDHNK6Dw==
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id ob9-20020a0562142f8900b0068c56e0f8aesm2864309qvb.138.2024.01.31.16.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 16:19:18 -0800 (PST)
Date: Wed, 31 Jan 2024 19:19:16 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com,
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com,
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
Message-ID: <ZbrjhJFMttj8lh3X@redhat.com>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
 <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
 <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
 <ZbrgCPEolPJNfg1x@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbrgCPEolPJNfg1x@slm.duckdns.org>

On Wed, Jan 31 2024 at  7:04P -0500,
Tejun Heo <tj@kernel.org> wrote:

> Hello, Linus.
> 
> On Wed, Jan 31, 2024 at 03:19:01PM -0800, Linus Torvalds wrote:
> > On Wed, 31 Jan 2024 at 13:32, Tejun Heo <tj@kernel.org> wrote:
> > >
> > > I don't know, so just did the dumb thing. If the caller always guarantees
> > > that the work items are never queued at the same time, reusing is fine.
> > 
> > So the reason I thought it would be a good cleanup to introduce that
> > "atomic" workqueue thing (now "bh") was that this case literally has a
> > switch between "use tasklets' or "use workqueues".
> > 
> > So it's not even about "reusing" the workqueue, it's literally a
> > matter of making it always just use workqueues, and the switch then
> > becomes just *which* workqueue to use - system or bh.
> 
> Yeah, that's how the dm-crypt got converted. The patch just before this one.
> This one probably can be converted the same way. I don't see the work item
> being re-initialized. It probably is better to initialize the work item
> together with the enclosing struct and then just queue it when needed.

Sounds good.
 
> Mikulas, I couldn't decide what to do with the "try_verify_in_tasklet"
> option and just decided to do the minimal thing hoping that someone more
> familiar with the code can take over the actual conversion. How much of user
> interface commitment is that? Should it be renamed or would it be better to
> leave it be?

cryptsetup did add support for it, so I think it worthwhile to
preserve the option; but it'd be fine to have it just be a backward
compatible alias for a more appropriately named option?

Mike

