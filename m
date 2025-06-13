Return-Path: <netdev+bounces-197483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28196AD8C1F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E47F18970A1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8383D76;
	Fri, 13 Jun 2025 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reVKfuRv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C53C26;
	Fri, 13 Jun 2025 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817805; cv=none; b=FJYNSYc5YuAh+HiBd7mkj+MThGW6BQBrfsT0zxoycMkK5EXnvg3M7zpU+QCNi8ugPcD2PVzqeICVXFAQyKC3eEXmqFHV69dNu0ZyZuML4FISz9yjHyPb3/TZxQiKjmI1xEQ17P35zHGsV6F0zhHE6pQMj/VV1iHW4yNL7X0zDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817805; c=relaxed/simple;
	bh=bvrBb7TJAzx9kC/eHHu6hVfqRao0Qn/rdOJhsxYrWBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iE4PUCF1QED4kfH3xzivChr54WmUI+ad4Y+HfG/QQBaolDLBPGORxas+xXyO5nzvNxgwiOpd8DHlMxeSuAZV9XqqheRiOev8v/phtxtq95lXNuFLQULT05uOJOfgZg1c9RPS8/T+YQRZYb8WW7ZB2hwOtxpiMjt0O0gKuq8SpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reVKfuRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BACDC4CEEF;
	Fri, 13 Jun 2025 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749817805;
	bh=bvrBb7TJAzx9kC/eHHu6hVfqRao0Qn/rdOJhsxYrWBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=reVKfuRvoLVC3JVyGbdMNMObhWSTDUy4lXEHsPTGK/zy5j9NjYnjDLzVf+XxgUeXq
	 lJWQkCXG71U+z3R/ft+BlQFdT5/IzHBRC5ONX0ODg9WfKpN2N3by7tLirM7W6MULVB
	 QyzVErlnaty0dSNNu1DvRkkmpsgdXFpWKRWsop9wDdTi0RJ42nVOiF70UWPLpc+IMx
	 +2EXjIGuqfBZA2ivEYGI4iv+NbdgTm22vNeKMXCZY1CYjiPhLCV1v+k6Pn3xpI/E95
	 B0K4jPV7568smddo2fpzTaghxxBupRX7pUIMHo0Xrds7ehsKQlW5W740wMb/jlzh6U
	 4nBPrn054PXoQ==
Date: Fri, 13 Jun 2025 14:29:58 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "Akira Yokosawa" <akiyks@gmail.com>, "Breno Leitao"
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>, "Jan Stancek" <jstancek@redhat.com>, "Marco Elver"
 <elver@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Ruben Wauters"
 <rubenru09@aol.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v2 11/12] docs: use parser_yaml extension to handle
 Netlink specs
Message-ID: <20250613142958.5876fd27@foz.lan>
In-Reply-To: <m2ldpvn9lz.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<931e46a6fdda4fa67df731b052c121b9094fbd8a.1749723671.git.mchehab+huawei@kernel.org>
	<m2ldpvn9lz.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 13 Jun 2025 12:50:48 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Instead of manually calling ynl_gen_rst.py, use a Sphinx extension.
> > This way, no .rst files would be written to the Kernel source
> > directories.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/Makefile                        | 17 ---------
> >  Documentation/conf.py                         | 11 +++---
> >  Documentation/netlink/specs/index.rst         | 38 +++++++++++++++++++
> >  Documentation/networking/index.rst            |  2 +-
> >  .../networking/netlink_spec/readme.txt        |  4 --
> >  Documentation/sphinx/parser_yaml.py           |  2 +-
> >  6 files changed, 46 insertions(+), 28 deletions(-)
> >  create mode 100644 Documentation/netlink/specs/index.rst
> >  delete mode 100644 Documentation/networking/netlink_spec/readme.txt
> >
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index d30d66ddf1ad..9185680b1e86 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -102,22 +102,6 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
> >  		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
> >  	fi
> >  
> > -YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
> > -YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
> > -YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
> > -YNL_TOOL:=$(srctree)/tools/net/ynl/pyynl/ynl_gen_rst.py
> > -
> > -YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
> > -YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
> > -
> > -$(YNL_INDEX): $(YNL_RST_FILES)
> > -	$(Q)$(YNL_TOOL) -o $@ -x
> > -
> > -$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
> > -	$(Q)$(YNL_TOOL) -i $< -o $@
> > -
> > -htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX)
> > -
> >  htmldocs:
> >  	@$(srctree)/scripts/sphinx-pre-install --version-check
> >  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
> > @@ -184,7 +168,6 @@ refcheckdocs:
> >  	$(Q)cd $(srctree);scripts/documentation-file-ref-check
> >  
> >  cleandocs:
> > -	$(Q)rm -f $(YNL_INDEX) $(YNL_RST_FILES)
> >  	$(Q)rm -rf $(BUILDDIR)
> >  	$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean
> >  
> > diff --git a/Documentation/conf.py b/Documentation/conf.py
> > index 12de52a2b17e..add6ce78dd80 100644
> > --- a/Documentation/conf.py
> > +++ b/Documentation/conf.py
> > @@ -45,7 +45,7 @@ needs_sphinx = '3.4.3'
> >  extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
> >                'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
> >                'maintainers_include', 'sphinx.ext.autosectionlabel',
> > -              'kernel_abi', 'kernel_feat', 'translations']
> > +              'kernel_abi', 'kernel_feat', 'translations', 'parser_yaml']
> >  
> >  # Since Sphinx version 3, the C function parser is more pedantic with regards
> >  # to type checking. Due to that, having macros at c:function cause problems.
> > @@ -143,10 +143,11 @@ else:
> >  # Add any paths that contain templates here, relative to this directory.
> >  templates_path = ['sphinx/templates']
> >  
> > -# The suffix(es) of source filenames.
> > -# You can specify multiple suffix as a list of string:
> > -# source_suffix = ['.rst', '.md']
> > -source_suffix = '.rst'
> > +# The suffixes of source filenames that will be automatically parsed
> > +source_suffix = {
> > +        '.rst': 'restructuredtext',
> > +        '.yaml': 'yaml',  
> 
> The handler name should probably be netlink_yaml 

See my comments on earlier patches.

> 
> > +}
> >  
> >  # The encoding of source files.
> >  #source_encoding = 'utf-8-sig'
> > diff --git a/Documentation/netlink/specs/index.rst b/Documentation/netlink/specs/index.rst
> > new file mode 100644
> > index 000000000000..ca0bf816dc3f
> > --- /dev/null
> > +++ b/Documentation/netlink/specs/index.rst
> > @@ -0,0 +1,38 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. NOTE: This document was auto-generated.
> > +
> > +.. _specs:
> > +
> > +=============================
> > +Netlink Family Specifications
> > +=============================
> > +
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   conntrack
> > +   devlink
> > +   dpll
> > +   ethtool
> > +   fou
> > +   handshake
> > +   lockd
> > +   mptcp_pm
> > +   net_shaper
> > +   netdev
> > +   nfsd
> > +   nftables
> > +   nl80211
> > +   nlctrl
> > +   ovpn
> > +   ovs_datapath
> > +   ovs_flow
> > +   ovs_vport
> > +   rt-addr
> > +   rt-link
> > +   rt-neigh
> > +   rt-route
> > +   rt-rule
> > +   tc
> > +   tcp_metrics
> > +   team
> > diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> > index ac90b82f3ce9..b7a4969e9bc9 100644
> > --- a/Documentation/networking/index.rst
> > +++ b/Documentation/networking/index.rst
> > @@ -57,7 +57,7 @@ Contents:
> >     filter
> >     generic-hdlc
> >     generic_netlink
> > -   netlink_spec/index
> > +   ../netlink/specs/index
> >     gen_stats
> >     gtp
> >     ila
> > diff --git a/Documentation/networking/netlink_spec/readme.txt b/Documentation/networking/netlink_spec/readme.txt
> > deleted file mode 100644
> > index 030b44aca4e6..000000000000
> > --- a/Documentation/networking/netlink_spec/readme.txt
> > +++ /dev/null
> > @@ -1,4 +0,0 @@
> > -SPDX-License-Identifier: GPL-2.0
> > -
> > -This file is populated during the build of the documentation (htmldocs) by the
> > -tools/net/ynl/pyynl/ynl_gen_rst.py script.
> > diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> > index eb32e3249274..cdcafe5b3937 100755
> > --- a/Documentation/sphinx/parser_yaml.py
> > +++ b/Documentation/sphinx/parser_yaml.py
> > @@ -55,7 +55,7 @@ class YamlParser(Parser):
> >          fname = document.current_source
> >  
> >          # Handle netlink yaml specs
> > -        if re.search("/netlink/specs/", fname):
> > +        if re.search("netlink/specs/", fname):  
> 
> Please combine this change into the earlier patch so that the series
> doesn't have unnecessary changes.

OK.

> 
> >              if fname.endswith("index.yaml"):
> >                  msg = self.netlink_parser.generate_main_index_rst(fname, None)
> >              else:  

Thanks,
Mauro

