Return-Path: <netdev+bounces-196988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5224EAD73D0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0191885B68
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77518FC91;
	Thu, 12 Jun 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO6sgXw3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FF1F16B;
	Thu, 12 Jun 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738264; cv=none; b=l8vTfBTF2z0ZqsLG3IkYMB6LkGIeWhNAXNJJ9Py0JxVNA2Q9cl82qkr6Xa0lNVJDEo7JxaxzJB6EBN4yTocXMquTD37uGXXZ/hA5Uq5B0VwHwmVCN968+xFtEwc4hVEp6HSD6FNpgt8XW/bigO1bzfhL1YB9PgMwcbDea50wiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738264; c=relaxed/simple;
	bh=nEsTlMah9gnHESH6LtPtgD7WWncfqtpDL9THG9p2xXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcKAQjCgXEd62rLdP6kUohkaNe9SvJUGy7T6QsLNPOm6s6BEuFRAXZMLzUiFlG8hasx1gwqIVfXyJQQnnzIsEBXQBlEK+vWtHZvT6i5pt9RcFUOeqc7Vly7aduTGwKySnjFINrUskq1n0lUVQKGqLIXQFiOswOl5hDKtZ+qixx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO6sgXw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84867C4CEEA;
	Thu, 12 Jun 2025 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749738264;
	bh=nEsTlMah9gnHESH6LtPtgD7WWncfqtpDL9THG9p2xXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sO6sgXw3fo/7aQQ2yyZVu1pNbu3CzmCpSKk4o9R9YUwGlzNMt4Grgr4pBj2bzwe0Z
	 M/ZOpNw7C3yDcTW2qvXHaQtCTHQTQ7gam9dEsRITXK1LS1p9P/sCd5UQCC3QE35r5h
	 QGLhf/GOcCZ6jYBaWz1xi2bVoR+53sSXD9YFP5jJ5h+yDHZMXML3kscumnXQ48aRyt
	 8N3bXnDzvV8VkMDMCDHdMZoOugHZDhNfRzKE6A3qsKKQ4gluICBFoLgYdskdZ4+5yZ
	 X43al6UXGDdNn++SvXQALgpqhykVaYeyAm5+qy45TV+76zszH9QnR2ADUvpy9xstd4
	 uI+FcJ1FtXWeQ==
Date: Thu, 12 Jun 2025 16:24:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Ignacio Encinas Rubio
 <ignacio@iencinas.com>, Marco Elver <elver@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Jan Stancek <jstancek@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v2 0/2] Some extra patches for netlink doc generation
Message-ID: <20250612162416.507c8a12@sal.lan>
In-Reply-To: <cover.1749735022.git.mchehab+huawei@kernel.org>
References: <cover.1749735022.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 12 Jun 2025 15:41:29 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> This patch series comes after:
> 	https://lore.kernel.org/linux-doc/cover.1749723671.git.mchehab+huawei@kernel.org/T/#t	
> The first patch is meant to speedup glob time by not adding all yaml to the parser.
> 
> The second one adjusts the location of netlink/specs/index.rst.
> 
> With that, on my AMD Ryzen 9 7900 machine, the time to do a full build after a
> cleanup is:
> 
> real    7m29,196s
> user    14m21,893s
> sys     2m28,510s

Heh, funny enough, my laptop with i5-10210U CPU @ 1.60GHz builds it faster:

real	6m2,075s
user	18m47,334s
sys	1m24,931s

Both are running Sphinx version 8.1.3 with standard Fedora package. At my
laptop, this is a bit slower than no using the extension:

real	5m13,334s
user	15m56,441s
sys	1m4,072s

but it is a lot cleaner, as, with the original way, there are several
warnings after make cleandocs:

	Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt-link<../../networking/netlink_spec/rt-link>`
	Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
	Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
	Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
	Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
	Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt

Because they refer to the temp .rst source files generated inside
the source directory by the yaml conversion script.

Regards,
Mauro

