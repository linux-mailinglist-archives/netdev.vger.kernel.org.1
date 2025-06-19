Return-Path: <netdev+bounces-199329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774E2ADFD97
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5F3189C620
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E0246764;
	Thu, 19 Jun 2025 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ7Wifff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A31DDC3F;
	Thu, 19 Jun 2025 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750314205; cv=none; b=ZyQJWEwtX3r2Qf7rnkYTOERrCKYjIhDatTAh6Ed6oVKYLDCdzGElvGN7nRrXptx7r0dvjzdOrqNEkMWIqM4xnbSW3pd+USPFGSN67kTTuf33nVm+M/9nvzETA2OfWxkds5McBUXW8be5jM5hznHSXEgNxlQJl6xRX7suS1+c2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750314205; c=relaxed/simple;
	bh=3c5lKu3ERIrxQCRZitVKfr7EkbtCphwpBOu10sQCKLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3cHnfdHcqP74lSderslDoCxCLb70ZFGcXCET90sTI5O10ppMcZWB/UXel48iUUgyHJmdUBNuQILF2pFiplH6XQ4YfCfjPmvkLSGzM8hajabw/BlQPwWNw04cY2BgsPqvjKa0+ucavllcv9TaF+KNLm936AI1NzR8IAUjyd4B4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ7Wifff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2DDC4CEEA;
	Thu, 19 Jun 2025 06:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750314205;
	bh=3c5lKu3ERIrxQCRZitVKfr7EkbtCphwpBOu10sQCKLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lZ7Wifff3vQNAaIYSjj+AXJCug9/GiIoxCHb5rsq31C1cJZAnjm9T4qPTwd+7nItS
	 cZtjg9wQQ3HLSiI7KLYP86TyCBsgaoHZGN+y2euToTfZ9eM/i5xqQPjJeQgZhFduuC
	 SYypV8u3sAlCnlIecStbKmQ9vI76ds6PEpzpQ2udHv7WV5rcaY0U/NkVjqwNSY0v+3
	 UrQiX7X5tgUoIzp7wnLd7tgB1xnTj+uryOSX0q60VCAHQ+m/38yavUhEfkCAvkDxpl
	 BQhxDWQRk2CBc4w/MAuiBJ9GD4tWu2YiK0sDYon7Djsja7QVXexoSdu5k+VU3a52FZ
	 LzP/zhYNmcSeQ==
Date: Thu, 19 Jun 2025 08:23:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco Elver
 <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jan Stancek
 <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters
 <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, lkmm@lists.linux.dev,
 netdev@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 00/15] Don't generate netlink .rst files inside
 $(srctree)
Message-ID: <20250619082318.32f754f6@foz.lan>
In-Reply-To: <598b2cb7-2fd7-4388-96ba-2ddf0ab55d2a@gmail.com>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
	<17f2a9ce-85ac-414a-b872-fbcd30354473@gmail.com>
	<20250618182032.03e7a727@sal.lan>
	<598b2cb7-2fd7-4388-96ba-2ddf0ab55d2a@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 19 Jun 2025 10:34:59 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Wed, 18 Jun 2025 18:20:32 +0200, Mauro Carvalho Chehab wrote:
> > Em Thu, 19 Jun 2025 00:46:15 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> >   
> >> Quick tests against Sphinx 3.4.3 using container images based on
> >> debian:bullseye and almalinux:9, both of which have 3.4.3 as their distro
> >> packages, emits a *bunch* of warnings like the following:
> >>
> >> /<srcdir>/Documentation/netlink/specs/conntrack.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
> >> /<srcdir>/Documentation/netlink/specs/devlink.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
> >> /<srcdir>/Documentation/netlink/specs/dpll.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
> >> /<srcdir>/Documentation/netlink/specs/ethtool.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
> >> /<srcdir>/Documentation/netlink/specs/fou.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
> >> [...]
> >>
> >> I suspect there should be a minimal required minimal version of PyYAML.  
> > 
> > Likely yes. From my side, I didn't change anything related to PyYAML, 
> > except by adding a loader at the latest patch to add line numbers.
> > 
> > The above warnings don't seem related. So, probably this was already
> > an issue.
> > 
> > Funny enough, I did, on my venv:
> > 
> > 	$ pip install PyYAML==5.1
> > 	$ tools/net/ynl/pyynl/ynl_gen_rst.py -i Documentation/netlink/specs/dpll.yaml -o Documentation/output/netlink/specs/dpll.rst -v
> > 	...
> > 	$ make clean; make SPHINXDIRS="netlink/specs" htmldocs
> > 	...
> > 
> > but didn't get any issue (I have a later version installed outside
> > venv - not sure it it will do the right thing).
> > 
> > That's what I have at venv:
> > 
> > ----------------------------- ---------
> > Package                       Version
> > ----------------------------- ---------
> > alabaster                     0.7.13
> > babel                         2.17.0
> > certifi                       2025.6.15
> > charset-normalizer            3.4.2
> > docutils                      0.17.1
> > idna                          3.10
> > imagesize                     1.4.1
> > Jinja2                        2.8.1
> > MarkupSafe                    1.1.1
> > packaging                     25.0
> > pip                           25.1.1
> > Pygments                      2.19.1
> > PyYAML                        5.1
> > requests                      2.32.4
> > setuptools                    80.1.0
> > snowballstemmer               3.0.1
> > Sphinx                        3.4.3
> > sphinxcontrib-applehelp       1.0.4
> > sphinxcontrib-devhelp         1.0.2
> > sphinxcontrib-htmlhelp        2.0.1
> > sphinxcontrib-jsmath          1.0.1
> > sphinxcontrib-qthelp          1.0.3
> > sphinxcontrib-serializinghtml 1.1.5
> > urllib3                       2.4.0
> > ----------------------------- ---------
> >   
> [...]
> 
> > Please compare the versions that you're using on your test
> > environment with the ones I used here.  
> 
> It looks to me like the minimal required version of docutils is 0.17.1
> for PyYAML integration.  Both almalinux:9 and debian:11 have 0.16.
> 
> Sphinx 4.3.2 of Ubuntu 22.04 comes with docutils 0.17.1, and it is
> free of the warnings from PyYAML.

Yes, it seems so. As I commented on my past e-mail, I think we need
a validation logic that will warn if versions are incompatible.
Using the experimental checks you and me did, and checking the minimal
version on Sphinx release notes (*), it seems to be that a good start
point is this:

            ========  ============  ============
            Sphinx    Min Docutils  Max Docutils
            Version   Version       Version
            --------  ------------  ------------
            < 4.0.0   0.17.1        0.17.1
            < 6.0.0   0.17.1        0.18.1
            < 7.0.0   0.18.0        0.18.1
            >= 7.0.0  0.20.0        0.21.2
            ========  ============  ============

Eventually, we may need to blacklist or whitelist other
combinations, but this would require a lot of time.

(*) I asked a LLM AI to check Sphinx release notes and docutils
    versions at the time Sphinx versions were released to aid
    creating such table. I also added your feedback about
    docutils 0.19 and your and my tests with docutils < 0.17.1.

Thanks,
Mauro

