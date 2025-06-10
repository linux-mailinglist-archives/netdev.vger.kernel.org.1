Return-Path: <netdev+bounces-196330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565CFAD444F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59EE7A9956
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 20:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3386B266F00;
	Tue, 10 Jun 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ave7stBt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00230238D56;
	Tue, 10 Jun 2025 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589159; cv=none; b=WbRm8MNiZCerObdfUOY1qZ7cZCj29ouLI0Q2hyhy9TJNqDOTAiARUtvO5GNEtTfP4pAh5VHP+DfhK9ZjJ6TVAKOySYCUKHRWFiB3NJI2ko1XsAX5r9NfHBazQUraieCraVwwmfeWBHlGABkXARhB8Cd++Rxvo0kntfiHtxzM9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589159; c=relaxed/simple;
	bh=/V45mCxwZayqDibcRfztftOiwWg6CFuhhRtsIABS/1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYHez1Cw5bA1873vBVosnmAkBs45W6+p5/Hgu2W/HkK7WaZ8H0TPtSGgrUaEC8ybjm4dnei9WBiDmWLBS1jXOvW76T3cc/rF8n0XFJTGFvhUwxqjqW2rBa30w4JTULWZR7wITeDYDYowTk4DCIACNz9Xzoz4M/0jVTBf4bw23FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ave7stBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFBFC4CEED;
	Tue, 10 Jun 2025 20:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589158;
	bh=/V45mCxwZayqDibcRfztftOiwWg6CFuhhRtsIABS/1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ave7stBtreimQhaXk4FkhstP7lpIi0w1/H4HpWqBpTc3hzO+E6Y6xrNBuiMauLrWd
	 ChQesAuKmbLeBV8EaWoAoGJLVe4rb0RoKn9pYXh+jbv/XSTw+hBUQnQ6Br99w/TMWt
	 tHVbQTf7rfHQuaZo078PTIDcA8/6eozElFlJqTwX12SxoFAvYIgw9KvI1Z4QsPlmXx
	 fKro8cLre0739FN74yd2hcr/pxZcg1YLAkkTZhmIzgMf1I5Z5m9H93PUT/BVhN/2XO
	 oBuskkl1SQ8JMAshsFvHRwd0JrMgL0W1IgaU+sgsEeJ+iQPjl0BxrC6XvSKpu/4gak
	 CWx/zu2iEnh8A==
Date: Tue, 10 Jun 2025 22:59:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco
 Elver <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Donald
 Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jan
 Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben
 Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH 4/4] docs: netlink: store generated .rst files at
 Documentation/output
Message-ID: <20250610225911.09677024@foz.lan>
In-Reply-To: <aEhSu56ePZ/QPHUW@gmail.com>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
	<5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
	<aEhSu56ePZ/QPHUW@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Breno,

Em Tue, 10 Jun 2025 08:43:55 -0700
Breno Leitao <leitao@debian.org> escreveu:

> Hello Mauro,
> 
> On Tue, Jun 10, 2025 at 12:46:07PM +0200, Mauro Carvalho Chehab wrote:
> > A better long term solution is to have an extension at
> > Documentation/sphinx that parses *.yaml files for netlink files,
> > which could internally be calling ynl_gen_rst.py. Yet, some care
> > needs to be taken, as yaml extensions are also used inside device
> > tree.  
> 
> In fact, This is very similar to what I did initially in v1. And I was
> creating a sphinx extension to handle the generation, have a look here:
> 
> https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/

Heh, I liked that ;-) 

Still, I would try to make the template there just a single line, e.g.
instead of:

	--- /dev/null
	+++ b/Documentation/networking/netlink_spec/devlink.rst
	@@ -0,0 +1,9 @@
	+.. SPDX-License-Identifier: GPL-2.0
	+
	+========================================
	+Family ``devlink`` netlink specification
	+========================================
	+
	+.. contents::
	+
	+.. netlink-spec:: devlink.yaml

I would just add:

	.. netlink-spec:: devlink.yaml

-

With regards to the code itself, IMHO the best would be to place
the yaml conversion code inside a python library (just like we did
with scripts/lib/kdoc) and keep having a command line program to
call it, as it is easier to test/debug parser issues via command line.

> During the review, we agree to move out of the sphinx extension.
> the reasons are the stubs/templates that needs to be created and you are
> creating here.
> 
> So, if we decide to come back to sphinx extension, we can leverage that
> code from v1 ?!

For me, that's fine. Still, I wonder if are there a way to avoid
creating a template for every yaml, while still using a Sphinx extension.

As there is an 1:1 mapping between .yaml files and output files, perhaps
there's a way to teach Sphinx to do the right thing, creating one html
per file. If so, ideally, the best would be to have an index.rst file similar
to this:

	.. SPDX-License-Identifier: GPL-2.0

	======================
	Netlink Specifications
	======================

	.. netlink-specs:: netlink/specs

which would teach the Sphinx extension to look for *.yaml files 
inside Documentation/netlink/specs, parsing them, creating one html
per file and create a TOC here. As there are some Sphinx extensions
that handle non-ReST formats, maybe this or something similar to
it could be possible.

> 
> > -def generate_main_index_rst(output: str) -> None:
> > +def generate_main_index_rst(output: str, index_dir: str, ) -> None:  
> 
> You probably don't need the last , before ).

Sure. 

> 
> Other than that, LGTM.
> 
> The question is, are we OK with the templates that need to be created
> for netlink specs?! 

If there's no other way, one might have a tool for maintainers to use
to update templates, but yeah, having one template per each yaml
is not ideal. I think we need to investigate it better and seek for
some alternatives to avoid it.

Thanks,
Mauro

