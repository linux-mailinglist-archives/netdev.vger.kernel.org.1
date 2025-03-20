Return-Path: <netdev+bounces-176574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CC4A6AE31
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 20:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E78C4A2C7D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F8F20297C;
	Thu, 20 Mar 2025 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anjrm6n8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726692A1C9;
	Thu, 20 Mar 2025 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497593; cv=none; b=Gw0e3JKzobkHs1fNUmSKvfMrY+9WL0GATcut3wpxOkIGbyVACPfDkd5Xf5A1MXcRxOA9ahXZtIj8q3SvnMWnjvd+ge7is+QMsgR4H40Khzypa3aio1QyLNeEie1mgDti1V37LBDlZZ3SCKIJabFexEdgx9FWCz9Rqo+fEoNqnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497593; c=relaxed/simple;
	bh=/px3BqNMbPHWLCXRxNUcra9vXoLW3hw4K7VHgFQ3lOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxh98RnMg5spk1kBSZs1rRRULcacIW2TIm5+4RpfcurhFr9aNxxEmrauRa7tVrHbkg3dFnFxFNthCKYg/m7nREGb1vDF8mzQ8XDDdBPLvXvYtAGxHycB9w5VozM0IfkIWt7aN1n5+Ee6x9ClP38uYsIOvQGgTBpkAi0WWylBLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Anjrm6n8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4769bbc21b0so12297261cf.2;
        Thu, 20 Mar 2025 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742497590; x=1743102390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mnb6lyNd7igzp/CicC20iPX81bx4jEU7QnRb/QVxc4=;
        b=Anjrm6n8cbQSWGqt7vLdkKerb3OjPILdjAFkxtxWvl7oFhMVzl7pB5Y9IcCJ1MaUo1
         yglmWJFydCFysGqm31Axz+4QuJWgykIBCWqXS7/eyENmi/ijMqf0OcMG3hxqtDF5tiGz
         sBhk7FLz3+tycPsPQPx+MRKqG2XnZ0sC/hlkGm4nzQVSBKp30gWYRw1Jb8jABv6GCnuq
         MzKfh4ZT7akk6i0MXbG/LsXN2a5xTa5+Z/zIFlWnYMonnGgvG847f/946QsL8aARhe4+
         qWPVBQvfBQ4aBTdlej1IVo3ELlWoiNnYhN9LKb0cNpWPMeYLhsXWStCHj1EOIxrZptI7
         McOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497590; x=1743102390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mnb6lyNd7igzp/CicC20iPX81bx4jEU7QnRb/QVxc4=;
        b=VvMnxeGsv8DickgP1tOuF0287uTCpCjRyVVqkbQtNKawIhl/GBVEI4q2jz+3a+MOFS
         FeznehX67iFofvPOuHTPflyCEu5chwZbPJ6oaszsD/tjRAAlqYZpW/zXcObFjenbB4yA
         IQLaTiDcfCl9M5cNV742QEVLgJmfeUEByGidA/CFRdLAQmjZBq7UHmO6kLA3FRqvfp1Z
         gc6Ylt291Db3UuXgUY1XiRZdrgP21LpSZSK6H1O/bdeiUGCmFfNbdysTSwY/yVm0yxMO
         cnbxBw5pk4qntW54DCn8G69J5IUPr5U3PVC9OMFTA+VJlrmIrRPMs3BaMcnayX67/X80
         yAtA==
X-Forwarded-Encrypted: i=1; AJvYcCWs+/JwV25KMmlRtwhGocC5tPyMhui9sSqTKsu1iKQh01yDOsBteJ6YCMpQS0QdcrzJTM0EgE2zgm0tPjHwbtY=@vger.kernel.org, AJvYcCXSmoH+6MVXeWYmYC4Z9QzxBZJ4b9XZuOEj19FAygnqE4/wllhqmYwj5Y4fimyz2m++XR6oc4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4YSL7AfijOwE4Hr4hhkyX1nF6WV/DXcmtQp3ZOL/LD7edFwbR
	VAEkKHP2aS8psgqNntpJS1u6FDpHDwm9cUo0ZQ3Qvb/43dbWO4s/
X-Gm-Gg: ASbGnctKdJUtrRNNfT1/SngHg0VXp+0ZWXXqpNBqkp1MgyyUqy73juumm9ssbCXqGv1
	z1DoVTtOTAvJ6V5IpkBnIdCYLha0zBQEfQXmm89TWNLROvPZY5yrhd11FGH8kB/+pNE3ZRsJGIK
	joH73El8N8AhGjTLh7VcAH548wtqngAiQIHpq8mi52JNoPlSBMSyRkVGS4gZ6mb2teY+QRJIGgj
	cowSu8hdYteM0P42Ell2rHYQJeZRCMID2Dck8pACVgAQFb0S7/I/wZG+6Y+YGaDYr2priIFfX/8
	N2ZbmOBWApZFh/KCrzjOT+AHP6xpmZRgYONoYfyueIzQF/4UN2zgHBFzY77hlqy3lQCWuvLzXzE
	VexWJ7VabFAcrJyDeMs52aZnimQuPA8UDYwqysvU6BvtJXw==
X-Google-Smtp-Source: AGHT+IGh+Ux1w+LaYHoaoSFF8ZczjbD4Zf6eFbXcDDwSmA22jsHLm8nL+fDb5w1IvcHDqGokeOdA6w==
X-Received: by 2002:a05:622a:22a5:b0:476:aa7a:2f78 with SMTP id d75a77b69052e-4771de5b160mr6838581cf.49.1742497590189;
        Thu, 20 Mar 2025 12:06:30 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d51fee7sm2029131cf.64.2025.03.20.12.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:06:29 -0700 (PDT)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id B29AD1200068;
	Thu, 20 Mar 2025 15:06:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Thu, 20 Mar 2025 15:06:28 -0400
X-ME-Sender: <xms:NGfcZ6R_hNcbzmwa9nB5bGrwu7_Tim1KfaSRUiBV56sJbwulUw6WkQ>
    <xme:NGfcZ_zMPfm1rg5FyIT2Can_Jg_t7cPSSfr7Rwl0ey3Jq_eqOpP4O_hcNK4WS6hzp
    f-HMFpouILUhbVvQA>
X-ME-Received: <xmr:NGfcZ30HKx2jMRJ20asFFpxSaHY9PR4MJ-KyPgXtpU85QRkDfjTxbWIla10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpth
    htohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhr
    ohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NGfcZ2DqK6aACT2Pe9uAbXM4m_IJA__jOOmvTEyUDUC67UzyKj-WCg>
    <xmx:NGfcZzjPCMLX_xPkhz7S-A2SNpf-WTjkfdjR86rBZmcI2EpbDX7ENQ>
    <xmx:NGfcZyonc6CR61KXO-weAEzBdft5Kg_tL-rOch6g6NiNj9zBc6I10A>
    <xmx:NGfcZ2j6jL8oKZpkAPzLju72coSxB7BvEG4K0aLgKDnnMOpjvwrpTw>
    <xmx:NGfcZyTbkEg9VPFsG--gLp6ntliyl3-67rPd8y3B3zijFOGrlpPpiBxr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 15:06:27 -0400 (EDT)
Date: Thu, 20 Mar 2025 12:05:51 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
Message-ID: <Z9xnDzwixCbbBm0o@boqun-archlinux>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220070611.214262-7-fujita.tomonori@gmail.com>

Hi Tomo,

On Thu, Feb 20, 2025 at 04:06:08PM +0900, FUJITA Tomonori wrote:
> Add new sections for DELAY/SLEEP and TIMEKEEPING abstractions
> respectively. It was possible to include both abstractions in a single
> section, but following precedent, two sections were created to
> correspond with the entries for the C language APIs.
> 

Could you add me as a reviewer in these entries?

Thanks!

Regards,
Boqun

> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d9e8187eb0..775ea845f011 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10355,6 +10355,13 @@ F:	kernel/time/timer_list.c
>  F:	kernel/time/timer_migration.*
>  F:	tools/testing/selftests/timers/
>  
> +DELAY AND SLEEP API [RUST]
> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+R:Boqun Feng <boqun.feng@gmail.com>
> +L:	rust-for-linux@vger.kernel.org
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	rust/kernel/time/delay.rs
> +
>  HIGH-SPEED SCC DRIVER FOR AX.25
>  L:	linux-hams@vger.kernel.org
>  S:	Orphan
> @@ -23854,6 +23861,13 @@ F:	kernel/time/timekeeping*
>  F:	kernel/time/time_test.c
>  F:	tools/testing/selftests/timers/
>  
> +TIMEKEEPING API [RUST]
> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+R:Boqun Feng <boqun.feng@gmail.com>
> +L:	rust-for-linux@vger.kernel.org
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	rust/kernel/time.rs
> +
>  TIPC NETWORK LAYER
>  M:	Jon Maloy <jmaloy@redhat.com>
>  L:	netdev@vger.kernel.org (core kernel code)
> -- 
> 2.43.0
> 
> 

