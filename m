Return-Path: <netdev+bounces-205464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F72AFED7F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE8A1890EA1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD032E6D3D;
	Wed,  9 Jul 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkS//Q1k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9952E6D22;
	Wed,  9 Jul 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074215; cv=none; b=B+8fWsCqT8MCLSB+mIa7WL703+KuEv4MwcoqfwWAhz75ZClDkq2C1vvYJn9KDo5HjG8wez9qo4d7anwJYcuCZOI495XgNqR5tQx2L1T8Q9VAoVyklzH+/V/s8R/r6VsRJSX+2iy7zl1x+XO6ja7hcGFZXHICvHV84GOsAcYc19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074215; c=relaxed/simple;
	bh=iWKG7shbDgcr0xClHM4lQkPVA2iCWBv/0OhRqHv7AWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPErNlIwZ7+sCUswYXa5OeLf/3Tpvx9mrzqdUz7p2vvlc80WidUqidhBB3XNn9+lHVmkEY75sjht2PRA8T1b49kmxNBTBbxk3DoLbQ5EMkPRiQBFFM7WxBER2p8U8D/1nbLP7gmz0eV/lOT9E9F7PuVLa18d8J5HnIXh69WwDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkS//Q1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB1FC4CEEF;
	Wed,  9 Jul 2025 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752074215;
	bh=iWKG7shbDgcr0xClHM4lQkPVA2iCWBv/0OhRqHv7AWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GkS//Q1kfZOyfDxjhC+1vi1io1WNzEf6bcxavk3NU/3B4bTWSO82svc6M1LQsUbgF
	 FNPUhl22NNaHF+PbmE1Q0rCGfOY8w1km+KA9ZGwD+CtuZ9LqL2UmLumNx3X3Q6eqUm
	 VGLhr5JeC7LN3VQ5iSle93WE9kJMqPD9zb6lkKStKb/m3D2L9MFXcjaSN4JFN5o8OI
	 V9gFt1BlUqUsdF8RLrV9T1kini4bMQSnBl3ujAUrugaznia2w7OefNL3uGNyQnRAQO
	 JcdeB7fRA8jDnOIGr2OZOU7iwJcknj/qf+QmO2Yu6MWvieLxThMHS6hEPORhB3XMO2
	 p8x2/aCLLYKfA==
Date: Wed, 9 Jul 2025 17:16:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Matthew Wilcox
 <willy@infradead.org>
Subject: Re: [PATCH v8 13/13] docs: parser_yaml.py: fix backward
 compatibility with old docutils
Message-ID: <20250709171643.1780011f@sal.lan>
In-Reply-To: <57be9f77-9a94-4cde-aacb-184cae111506@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<d00a73776167e486a1804cf87746fa342294c943.1750925410.git.mchehab+huawei@kernel.org>
	<ebdb0f12-0573-4023-bb7f-c51a94dedb27@gmail.com>
	<20250627084814.7f4a43d4@foz.lan>
	<57be9f77-9a94-4cde-aacb-184cae111506@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 27 Jun 2025 17:37:16 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> [Dropping most CCs, +CC: Matthew]
> 
> Hi Mauro,
> 
> On Fri, 27 Jun 2025 08:48:14 +0200, Mauro Carvalho Chehab wrote:
> > Hi Akira,
> > 
> > Em Fri, 27 Jun 2025 08:59:16 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:  
> [...]
> 
> >>
> >> opensuse/leap:15.6's Sphinx 4.2.0 has docutils 0.16 with it, but it is
> >> python 3.6 base and it does't work with the ynl integration.
> >> As opensuse/leap:15.6 provides Sphinx 7.2.6 (on top of python 3.11) as
> >> an alternative, obsoleting it should be acceptable.    
> > 
> > Thank you for the tests! At changes.rst we updated the minimum
> > python requirement to:
> > 
> > 	Python (optional)      3.9.x            python3 --version
> > 
> > So, I guess we can keep this way. 
> > 
> > The 3.9 requirement reflects the needs of most scripts. Still, for doc build, 
> > the min requirement was to support f-string, so Python 3.6.
> >   
> 
> Sorry, I was barking up the wrong tree.
> 
> An example of messages from opensuse/leap:15.6's Sphinx looks like this:
> 
> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno -export ./fs/pstore/blk.c' processing failed with: AttributeError("'str' object has no attribute 'removesuffix'",)
> 
> The "removesuffix" is already there in scripts/lib/kdoc/kdoc_parser.py at
> current docs-next.  It was added by commit 27ad33b6b349 ("kernel-doc: Fix
> symbol matching for dropped suffixes") submitted by Matthew.
> 
> But I have to ask, do we really want the compatibility with python <3.9
> restored?

I actually wrote a patch addressing that. Yet, looking at the results 
from the tests I did for the sphinx-pre-install script, what we have is:

  PASSED 1 - OS: AlmaLinux release 9.6 (Sage Margay), Python: 3.9.21, hostname: almalinux-test
  PASSED 1 - OS: Arch Linux, Python: 3.13.5
  PASSED 1 - OS: CentOS Stream release 9, Python: 3.9.23, hostname: centos-test
  PASSED 1 - OS: Debian GNU/Linux 12, Python: 3.11.2, hostname: debian-test
  PASSED 1 - OS: Devuan GNU/Linux 5, Python: 3.11.2, hostname: devuan-test
  PASSED 1 - OS: Fedora release 42 (Adams), Python: 3.13.5
  PASSED 1 - OS: Gentoo Base System release 2.17, Python: 3.13.3
  PASSED 1 - OS: Kali GNU/Linux 2025.2, Python: 3.13.3, hostname: kali-test
  PASSED 1 - OS: Mageia 9, Python: 3.10.11, hostname: mageia-test
  PASSED 1 - OS: Linux Mint 22, Python: 3.10.12, hostname: mint-test
  PASSED 1 - OS: openEuler release 25.03, Python: 3.11.11, hostname: openeuler-test
  PASSED 1 - OS: OpenMandriva Lx 4.3, Python: 3.9.8, hostname: openmandriva-test
  PASSED 1 - OS: openSUSE Tumbleweed, Python: 3.13.5, hostname: opensuse-test
  PASSED 1 - OS: Rocky Linux release 8.9 (Green Obsidian), Python: 3.6.8, hostname: rockylinux8-test
  PASSED 3 - Sphinx on venv: Sphinx Sphinx 7.4.7, Docutils 0.21.2, Python3.9.20
  PASSED 1 - OS: Rocky Linux release 9.6 (Blue Onyx), Python: 3.9.21, hostname: rockylinux-test
  PASSED 1 - OS: Springdale Open Enterprise Linux release 9.2 (Parma), Python: 3.9.16, hostname: springdalelinux-test
  PASSED 1 - OS: Ubuntu 24.04.2 LTS, Python: 3.12.3, hostname: ubuntu-lts-test
  PASSED 1 - OS: Ubuntu 25.04, Python: 3.13.3, hostname: ubuntu-test

This is after running the script a second time after installing
either python 311 or python39 on openSUSE and OpenMandriva. On
both, it is possible to install distro-provided packages with
Python 3.9 or 3.11.

The only exception for RHEL8-based distros. On those, the
installed version is 3.6.x, which doesn't have f-strings. So,
it won't work anyway. Yet, RHEL8 powertools/epel repositories
have enough to install python 3.9 and Sphinx via venv.

With that in mind, I don't see any reason why restoring
backward-compatibility with 3.7.

But, someone things otherwise, the patch addressing it is
enclosed.


---

[PATCH] scripts: kdoc: make it backward-compatible with Python 3.7

There was a change at kdoc that ended breaking compatibility
with Python 3.7: str.removesuffix() was introduced on version
3.9.

Restore backward compatibility.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/57be9f77-9a94-4cde-aacb-184cae111506@gmail.com/
Fixes: 27ad33b6b349 ("kernel-doc: Fix symbol matching for dropped suffixes")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 831f061f61b8..6273141033a8 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1214,7 +1214,9 @@ class KernelDoc:
         # Found an export, trim out any special suffixes
         #
         for suffix in suffixes:
-            symbol = symbol.removesuffix(suffix)
+            # Be backward compatible with Python < 3.9
+            if symbol.endswith(suffix):
+                symbol = symbol[:-len(suffix)]
         function_set.add(symbol)
         return True
 




