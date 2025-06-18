Return-Path: <netdev+bounces-199016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 240F4ADEA93
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97301189DF3A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98172BEC28;
	Wed, 18 Jun 2025 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1by10cV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B92BDC28;
	Wed, 18 Jun 2025 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247106; cv=none; b=H2/ZT3ZfCvkPk3ltVEhjIn1e1lCkCGAlfJlO65NVxMKJa+7LAp0DKNTZO2SWZBum92Rfde3YSo6toLBAKlM/S7XS94CmMxFhmz3n/+gAc5/rjSz6yT2bI5XTO5MFrG1Wlpgx0wd3qGo9uF7kQaCfGglk1GtoSa0hFuknRYIOlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247106; c=relaxed/simple;
	bh=4DxwVQzbl8QL94anK1H5LVZzfWgTCdM52+1S4HzI3ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLBYNZdrUP9u7E2AwEil64Fts374GF2i+wSVlBh7QulQY7ReJw00bD564L7wTIogLRRC6QOiuudoOnor/NCDWehuctIJ3q9qjqh7YYKPlu+G1brXmUCSW15GNrmAN3kOLLu8yynssx2STiOhYBe9apaJIQVme+TqzXhw0l7Jj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1by10cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173A1C4CEE7;
	Wed, 18 Jun 2025 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247105;
	bh=4DxwVQzbl8QL94anK1H5LVZzfWgTCdM52+1S4HzI3ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S1by10cVaTcMICpnEDqlgbOe8aUivg0S0v1Kvhsq0/j8p/YYIShdcKZZP0ShuNsVG
	 zlylBS9qv53ZCFlKU6W+QmUtC3IOXSThr7eFL5aNvavpWfimK4ADaNcj/ocPXON5LK
	 cIC5RLpTVbtuRI7JJSerbbGNJJKOphW2jP6WiZVIdi/aLc4+32X6/nBvBseod1AfYd
	 HcYrKZwe5V2PIxC304RaFkV1sUiww7wmiawn0EAhwcPwJoUoJXzaA69Mt9KwndogXV
	 ONnbuXkivC2xfUOBS+zg4kf+mPxLGfmdzTR6JecL/Ss3XtCZGs9T8seF+UFOqwVt4V
	 NhRJ4p3DcJBYA==
Date: Wed, 18 Jun 2025 13:44:58 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Ignacio Encinas Rubio
 <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, Marco Elver
 <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters
 <rubenru09@aol.com>, Shuah Khan <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v5 01/15] docs: conf.py: properly handle include and
 exclude patterns
Message-ID: <20250618134458.10ee8412@foz.lan>
In-Reply-To: <1adba2c6-e4c3-4da2-874e-a304a1fdfd25@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<cca10f879998c8f0ea78658bf9eabf94beb0af2b.1750146719.git.mchehab+huawei@kernel.org>
	<1adba2c6-e4c3-4da2-874e-a304a1fdfd25@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Akira,

Em Wed, 18 Jun 2025 11:42:14 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi Mauro,
> 
> A comment on compatibility with earlier Sphinx.
> 
> On Tue, 17 Jun 2025 10:01:58 +0200, Mauro Carvalho Chehab wrote:
> > When one does:
> > 	make SPHINXDIRS="foo" htmldocs
> > 
> > All patterns would be relative to Documentation/foo, which
> > causes the include/exclude patterns like:
> > 
> > 	include_patterns = [
> > 		...
> > 		f'foo/*.{ext}',
> > 	]
> > 
> > to break. This is not what it is expected. Address it by
> > adding a logic to dynamically adjust the pattern when
> > SPHINXDIRS is used.
> > 
> > That allows adding parsers for other file types.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/conf.py | 52 +++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 48 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/conf.py b/Documentation/conf.py
> > index 12de52a2b17e..e887c1b786a4 100644
> > --- a/Documentation/conf.py
> > +++ b/Documentation/conf.py
> > @@ -17,6 +17,54 @@ import os
> >  import sphinx
> >  import shutil
> >  
> > +# Location of Documentation/ directory
> > +doctree = os.path.abspath('.')
> > +
> > +# List of patterns that don't contain directory names, in glob format.
> > +include_patterns = ['**.rst']
> > +exclude_patterns = []
> > +  
> 
> Where "exclude_patterns" has been with us ever since Sphinx 1.0,
> "include_patterns" was added fairly recently in Sphinx 5.1 [1].
> 
> [1]: https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-include_patterns
> 
> So, this breaks earlier Sphinx versions.

Heh, testing against old versions is harder with python 3.13 (Fedora
42 default), as one library used by older Sphinx versions were dropped.

I found a way to make it backward compatible up to 3.4.3, with a
backward-compatible logic at conf.py. I'll send the new version in a few.

> Also, after applying all of v5 on top of docs-next, I see these new
> warnings with Sphinx 7.2.6 (of Ubuntu 24.04):
> 
> /<srcdir>/Documentation/output/ca.h.rst: WARNING: document isn't included in any toctree
> /<srcdir>/Documentation/output/cec.h.rst: WARNING: document isn't included in any toctree
> /<srcdir>/Documentation/output/dmx.h.rst: WARNING: document isn't included in any toctree
> /<srcdir>/Documentation/output/frontend.h.rst: WARNING: document isn't included in any toctree
> /<srcdir>/Documentation/output/lirc.h.rst: WARNING: document isn't included in any toctree
> /<srcdir>/Documentation/output/media.h.rst: WARNING: document isn't included in any toctree
> /<srcdir>/Documentation/output/net.h.rst: WARNING: document isn't included in any toctree
> /<srcdir>/Documentation/output/videodev2.h.rst: WARNING: document isn't included in any toctree

We should likely use a Sphinx extension for those as well. Building those
are also made via some Makefile tricks that predates the time we start
adding our own extensions at the tree.

> Sphinx 7.3.7 and later are free of them.  I have no idea which change in
> Sphinx 7.3 got rid of them.
> 
> Now that the parallel build performance regression has be resolved in
> Sphinx 7.4, I don't think there is much demand for keeping Sphinx versions
> compatible.
> These build errors and extra warnings would encourage people to upgrade
> there Sphinx.  So I'm not going to nack this.
> 
> Of course, getting rid of above warnings with < Sphinx 7.3 would be ideal.

I'm all for using newer versions, but we need to check what LTS distros
are using those days.

On my machine, with -jauto, 3.4.3 is taking 11 minutes to build, which
is twice the time of 8.2.3. IMO, this is a very good reason for people
stop using legacy versions when possible :-)

Regards,
Mauro

