Return-Path: <netdev+bounces-199132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58916ADF279
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACDA3AD18F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC772EF9D5;
	Wed, 18 Jun 2025 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9/zZbRF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62121C861F;
	Wed, 18 Jun 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263641; cv=none; b=Ui2O6qZuEEfUFUmW8u9XHt0/CZ03ER5GNWWyRoZXagQAlsW1fVMTcCb0rOL1XgV69BHaDc6KGlmm3GeoFnaV4fbMGpBW5idlsa7J7BxdTD4BX3qeG80sjHk+4XwLR5j8RolxjA1e+H5un0BnYIR9u/Qd5tK2yoCt/NS05Q4KejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263641; c=relaxed/simple;
	bh=IkySy5pTUIaa1j80e/sSRvJR71Vpo8qwgLf6v3TA6as=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGAlDhvsyBSzlqX4zRYF6lpHUy2FaxKgjKWNEySThJYKVLvB+c8aWl76X2Y0nD7/hXlHnfjrXL9TJRUhc2rUDA3tXQ4jXrNRtxqDBbZf7ck8e8mTsqbcsXzvl2qxRtsnS/y7ttGAFMoObfAi7SjXfH3i7GMOvgxWbdMVCzj0TQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9/zZbRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DA4C4CEE7;
	Wed, 18 Jun 2025 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750263640;
	bh=IkySy5pTUIaa1j80e/sSRvJR71Vpo8qwgLf6v3TA6as=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B9/zZbRFgUlUjn1SvFThE5Oars1U8O/jKfPUmrref+JR6AdcjD43bqeNQsK5J91vf
	 TAEZTCRZru5ZwjP1QKJuYegddPHlQ+hMGMf/pFcT7WxDCjutITnxs8E1CqWhs9j6Sl
	 8s47TFgICxVNvyxm1jtzbDfjGvEHpSDoJjBGKLP5v+2nI0xTvNHOQSlPF9i84+YPTm
	 26zOvmoOKXhSRDRvH1H01TvKP42ZngFGxa6hBZq/yJEeSz0jZW10OIaf/kdRqLsd9P
	 6GMfbiE4gpXNdTr5/ubXM43Li8PbaUbuQLxZaLl6LPiIqB2GM4ExTvRheNNy/vPDUh
	 ZEK4fjNxVCOlg==
Date: Wed, 18 Jun 2025 18:20:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco
 Elver <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Donald
 Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jan
 Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben
 Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, lkmm@lists.linux.dev,
 netdev@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 00/15] Don't generate netlink .rst files inside
 $(srctree)
Message-ID: <20250618182032.03e7a727@sal.lan>
In-Reply-To: <17f2a9ce-85ac-414a-b872-fbcd30354473@gmail.com>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
	<17f2a9ce-85ac-414a-b872-fbcd30354473@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 19 Jun 2025 00:46:15 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi Mauro,
> 
> On 2025/06/18 20:46, Mauro Carvalho Chehab wrote:
> > As discussed at:
> >    https://lore.kernel.org/all/20250610101331.62ba466f@foz.lan/
> > 
> > changeset f061c9f7d058 ("Documentation: Document each netlink family")
> > added a logic which generates *.rst files inside $(srctree). This is bad
> > when O=<BUILDDIR> is used.
> > 
> > A recent change renamed the yaml files used by Netlink, revealing a bad
> > side effect: as "make cleandocs" don't clean the produced files and symbols
> > appear duplicated for people that don't build the kernel from scratch.
> > 
> > This series adds an yaml parser extension and uses an index file with glob for
> > *. We opted to write such extension in a way that no actual yaml conversion
> > code is inside it. This makes it flexible enough to handle other types of yaml
> > files in the future. The actual yaml conversion logic were placed at 
> > netlink_yml_parser.py. 
> > 
> > As requested by YNL maintainers, this version has netlink_yml_parser.py
> > inside tools/net/ynl/pyynl/ directory. I don't like mixing libraries with
> > binaries, nor to have Python libraries spread all over the Kernel. IMO,
> > the best is to put all of them on a common place (scripts/lib, python/lib,
> > lib/python, ...) but, as this can be solved later, for now let's keep it this
> > way.
> > 
> > ---
> > 
> > v6:
> > - YNL doc parser is now at tools/net/ynl/pyynl/lib/doc_generator.py;
> > - two patches got merged;
> > - added instructions to test docs with Sphinx 3.4.3 (minimal supported
> >   version);
> > - minor fixes.  
> 
> Quick tests against Sphinx 3.4.3 using container images based on
> debian:bullseye and almalinux:9, both of which have 3.4.3 as their distro
> packages, emits a *bunch* of warnings like the following:
> 
> /<srcdir>/Documentation/netlink/specs/conntrack.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
> /<srcdir>/Documentation/netlink/specs/devlink.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
> /<srcdir>/Documentation/netlink/specs/dpll.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
> /<srcdir>/Documentation/netlink/specs/ethtool.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
> /<srcdir>/Documentation/netlink/specs/fou.yaml:: WARNING: YAML parsing error: AttributeError("'Values' object has no attribute 'tab_width'")
> [...]
> 
> I suspect there should be a minimal required minimal version of PyYAML.

Likely yes. From my side, I didn't change anything related to PyYAML, 
except by adding a loader at the latest patch to add line numbers.

The above warnings don't seem related. So, probably this was already
an issue.

Funny enough, I did, on my venv:

	$ pip install PyYAML==5.1
	$ tools/net/ynl/pyynl/ynl_gen_rst.py -i Documentation/netlink/specs/dpll.yaml -o Documentation/output/netlink/specs/dpll.rst -v
	...
	$ make clean; make SPHINXDIRS="netlink/specs" htmldocs
	...

but didn't get any issue (I have a later version installed outside
venv - not sure it it will do the right thing).

That's what I have at venv:

----------------------------- ---------
Package                       Version
----------------------------- ---------
alabaster                     0.7.13
babel                         2.17.0
certifi                       2025.6.15
charset-normalizer            3.4.2
docutils                      0.17.1
idna                          3.10
imagesize                     1.4.1
Jinja2                        2.8.1
MarkupSafe                    1.1.1
packaging                     25.0
pip                           25.1.1
Pygments                      2.19.1
PyYAML                        5.1
requests                      2.32.4
setuptools                    80.1.0
snowballstemmer               3.0.1
Sphinx                        3.4.3
sphinxcontrib-applehelp       1.0.4
sphinxcontrib-devhelp         1.0.2
sphinxcontrib-htmlhelp        2.0.1
sphinxcontrib-jsmath          1.0.1
sphinxcontrib-qthelp          1.0.3
sphinxcontrib-serializinghtml 1.1.5
urllib3                       2.4.0
----------------------------- ---------

> "pip freeze" based on almalinux:9 says:
> 
>     PyYAML==5.4.1
> 
> "pip freeze" based on debian:bullseye says:
> 
>     PyYAML==5.3.1
> 
> What is the minimal required version here?

Breno, what's the minimal version? Please update requirements.txt
to ensure that, and modify ./scripts/sphinx-pre-install to
check for it.

> 
> And if users of those old distros need to manually upgrade PyYAML,
> why don't you suggest them to upgrade Sphinx as well?

The criteria we used to define minimal version for python/sphinx
was having them released at the end of 2020/beginning 2021. So,
up to ~4 years old. We also double-checked latest LTS versions
from major distros.

With that, PyYAML 5.4.1 met the ~4 years old, and so 5.3.1 and
5.1.

funny enough:

	$ git grep tab_width Documentation/netlink/

doesn't return anything. Yet, tab_width is used by sphinx
extensions. The in-kernel ones do it the right way using
get:

	tab_width = self.options.get('tab-width',
				     self.state.document.settings.tab_width)

But perhaps some other extension you might have installed on your
environment has issues, or maybe Documentation/sphinx/parser_yaml.py
need to expand tabs with certain versions of docutils.

Please compare the versions that you're using on your test
environment with the ones I used here.

Regards,
Mauro

