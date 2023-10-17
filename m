Return-Path: <netdev+bounces-41851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9717CC0DD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04801B211D4
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551CF3FB1B;
	Tue, 17 Oct 2023 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="v1VTrk5a"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763E41754
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:43:30 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2EEA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:43:29 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9beb863816so2125488276.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1697539408; x=1698144208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OmZ/33TllYLHL47d/dVmhdUXpMsytcSlpt83kTPbFEw=;
        b=v1VTrk5a5bMTOZAKX2/e+XVcQcJmyGbghSCmPgyIzGBryi3CaKjqN09EYPuAacxJov
         p4wKEgL0UQafikbFUpuJOkA/w53hSzC7ZgBZ07Y+wYJDStMoMyXaRqZB9+y+nISGMtdy
         yT+NpBh5oPbMyKZ8XWbR32SUWLMYQN1rglWYApNNliuC/fg+owINkQyqZqv2lwpjhk2b
         lfjKfelGs7rBxb/EHzUHvDErgZiAPYhXwruP4Zl9BOyqgxYWsfQHeD47xgs0drMYjNsY
         xDt6RvYRGOXdbyU50V0/yHNVIX+I/XtRTsplsryIh+ZcuwK16EDTsKGqBp0AqP0zC4ut
         uGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697539408; x=1698144208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmZ/33TllYLHL47d/dVmhdUXpMsytcSlpt83kTPbFEw=;
        b=osg37cYL74vknLlwaZoR1tEhniykC5koPYeUioH4fml1RMuqm1MPgX72j+1f6+0G3X
         cjaVTBDf3nD1yqWHSTp+b963sxVxnavnMFwoMGbgo4/4ANAEkaoLqxKXifRZEfSzopnf
         P9/Xfm9KeqU3ss8TapKR9YyE795NyoGDEEpPCXLhpvB10HORoEwYbJiSbmjteLbX+B2z
         so1rGH6fAkQP4zr62k0wRTytq52X5ezjw1ch3dpsiGz81GJhDYkv8nNvEF4cv2pZDF7K
         FkALvRcXNRcsKE3wQ8G0A4UhRI+fsCV9RSTWDaFYnGGRkSvg4R7rw2JaZUoQdaeBZZTx
         yXug==
X-Gm-Message-State: AOJu0Yzi27+iL74SU+xHWJnUrh0xUjiaCH2rfGvcelutTeRZEXf2s2T0
	p7H/O8MZD9G03J1aMpSqgEm25Qz+ms9pO3XuFY0kKQ==
X-Google-Smtp-Source: AGHT+IEguG9VkvSZyN+YQKkbnzU4bPPMH68Gm77P3bS20bpQvkVCehXFFJFu9p/7GSuuBt2Sz4dkmWLIuiXDJ62NRdc=
X-Received: by 2002:a25:cd44:0:b0:d9b:6c9d:e6a with SMTP id
 d65-20020a25cd44000000b00d9b6c9d0e6amr1563929ybf.0.1697539408286; Tue, 17 Oct
 2023 03:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013155727.2217781-1-dhowells@redhat.com>
In-Reply-To: <20231013155727.2217781-1-dhowells@redhat.com>
From: Daire Byrne <daire@dneg.com>
Date: Tue, 17 Oct 2023 11:42:52 +0100
Message-ID: <CAPt2mGNpo0Uw0Ud18N4dV=ojoGK-xyj1P29tzWEhZw0i4FNVPg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/53] netfs, afs, cifs: Delegate high-level I/O to netfslib
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Marc Dionne <marc.dionne@auristor.com>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Christian Brauner <christian@brauner.io>, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 13 Oct 2023 at 16:58, David Howells <dhowells@redhat.com> wrote:
>
>  (2) Use of fscache is not yet tested.  I'm not sure whether to allow a
>      cache to be used with a write-through write.

Just adding a quick end user "thumbs up" for this potential feature.
We currently use fscache as the backend for "NFS re-export" servers to
extend our onprem storage to remote cloud compute (which works great).

But batch compute hosts (think VFX render farm) often chunk up stages
of work into multiple batch jobs such that they read data, write
results and then read the same data on different clients. Having the
ability to also cache the recent writes closer to the compute clients
(on the re-export server) would open up a lot of new workload
possibilities for us.

>  (5) Write-through caching will generate and dispatch write subrequests as
>      it gathers enough data to hit wsize and has whole pages that at least
>      span that size.  This needs to be a bit more flexible, allowing for a
>      filesystem such as CIFS to have a variable wsize.

If I understand correctly, this is above and beyond the normal write
back cache and is more in tune with the wsize (of NFS, CIFS etc) for
each file? Again, our workloads are over longer latencies than are
normal (NFS over 200ms!) so this sounds like a nice optimisation when
dealing with slow stuttering file writes over high latency.

I can definitely volunteer for some of the fscache + NFS testing.

Cheers,

Daire

