Return-Path: <netdev+bounces-197000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CAAAD745D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF57018851D7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AA9257449;
	Thu, 12 Jun 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+6CLNru"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C884255E23;
	Thu, 12 Jun 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739154; cv=none; b=Fi7BtSt0DNT7zJGcz+C7BR8wBaJsCdpSTPFb43wv6IHU1AsIKVynsX4YAjZKcO6S8HC3mtmKUAkpsGauj3oo28BNoGPQmI6+OJPlzzdoGUcoH0CvpGeTcP0MRVUjjrcATGWSBFID9pFVHKG9aOhc383a460Rl2yYzKZABxEQf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739154; c=relaxed/simple;
	bh=lywKl1oGAQhuP2oPqsrGxy4CcarRSsbmvioixo5Xv8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XB4I1KH5h+NV0rnFsolM4uVCPgqGSTzHeozUomVbIBsK//fhR5K/5FI8sIOR+sOinezfLZ4Jav+shK/lF7PwJydK9VEfbZpITgnoWPUzyKdkbj0qRUvdpBR9o6MxVKul3CMXjAYQEOz3RzRk3Px0+wRpjkTsHlQdH53fNoCarV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+6CLNru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B6AC4CEEB;
	Thu, 12 Jun 2025 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749739154;
	bh=lywKl1oGAQhuP2oPqsrGxy4CcarRSsbmvioixo5Xv8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D+6CLNru1CM7/I3LoAcBvoEee6LwcN6Bo1ESeeg7TKlTFMDQH1J41f344ArnUcVyG
	 A8jC5ReSiJVaM7oz1ugi9nlvNe03N+W1nra/l3jLPa1QDCUmK3u6dRo71NMRTz1szR
	 s/b8YWMIVEWKmxj8BD4kJD/2+LlovDGU9gC+DvdaXMsuUxpcGFqsq5qO/XQDlAPhND
	 khzmsm8oprDcH9M9Z0MrnT8keOcH9aK0O0Ohn6Cgorst0/oXsOSc60ZX4jzZrmABIV
	 JAdnzzXpI0kzwyRo0caPosqwth1sak5jb7d77leDJ6LZS5/wQIlM+Kad5jsRF9/Teq
	 yQHNHcNt2DNOQ==
Date: Thu, 12 Jun 2025 16:39:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Akira
 Yokosawa <akiyks@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco Elver
 <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jan Stancek
 <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters
 <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH 4/4] docs: netlink: store generated .rst files at
 Documentation/output
Message-ID: <20250612163905.119c2b5e@sal.lan>
In-Reply-To: <20250610140724.5f183759@kernel.org>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
	<5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
	<aEhSu56ePZ/QPHUW@gmail.com>
	<20250610225911.09677024@foz.lan>
	<20250610140724.5f183759@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 10 Jun 2025 14:07:24 -0700
Jakub Kicinski <kuba@kernel.org> escreveu:

> On Tue, 10 Jun 2025 22:59:11 +0200 Mauro Carvalho Chehab wrote:
> > > The question is, are we OK with the templates that need to be created
> > > for netlink specs?!     
> > 
> > If there's no other way, one might have a tool for maintainers to use
> > to update templates, but yeah, having one template per each yaml
> > is not ideal. I think we need to investigate it better and seek for
> > some alternatives to avoid it.  
> 
> FWIW we have tools/net/ynl/ynl-regen.sh, it regenerates the C code 
> we have committed in the tree (uAPI headers mostly).
> We could add it there. Which is not to distract from your main
> point that not having the templates would be ideal.

With the new Sphinx extension for netlink specs I posted:

	https://lore.kernel.org/linux-doc/cover.1749723671.git.mchehab+huawei@kernel.org/T/#t
	https://lore.kernel.org/linux-doc/20250612142438.MED5SEN3C-3RDQI5I1ELC-u8QJEjH8W4vUQRBdyK1tI@z/T/#t

There's no need for a template for each file, although it does require
updating Documentation/netlink/specs/index.rst. There are a couple
of reasons:

	1. on my tests, I got some errors auto-generating it while
	   using:
		 make SPHINXDIRS="networking netlink" htmldocs

	2. a dynamically-generated file will cause a extra
	   warnings at the userspace files that contain the name of the
           netlink spec index.html. Basically, kernel build runs a script
	   which validates that all files under Documentation/ actually
	   exist

	3. adding/renaming files typically require changing
	   MAINTAINERS and/or Makefiles. Updating index.rst
	   accordingly is already expected for documentation.

In any case, as I didn't drop the existing script, you could add a
call inside tools/net/ynl/ynl-regen.sh to:

	tools/net/ynl/pyynl/ynl_gen_rst.py -x  -v -o Documentation/netlink/specs/index.rst

To ensure that nobody would forget updating it.

Regards,
Mauro

