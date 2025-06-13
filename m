Return-Path: <netdev+bounces-197481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24049AD8C10
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670413BA54B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8A2E1733;
	Fri, 13 Jun 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRRv9PvB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4F22688C;
	Fri, 13 Jun 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817680; cv=none; b=tj3hkrrRsZPTgKV6kihFbm52VnLZKBHETtl04Z0tCq0Xht6nk7motK00RTI3qEMYdYn4VIhjoSorfw7YH/+81JD5i0QNCA9hkUEq2QsDQ32lwwclF16MYiFDGkxzigy/RBLg311ueM3GM/a2F131J7N9+6s6dTjOK7dGO9qXgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817680; c=relaxed/simple;
	bh=3oIMFvqo3WcAdkiD4QKXRpC4YU8kdL/fZ71Cbmcah5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJyxji44AxOr/q3kj6GxAKNAZrGd1Om+oJRjGmu6OK9dOXi2Wm5E2hRGAr3b5IKucwZOW9KVCAXhGMaTktjWwLUWGiZ8SpjSM9RFkhjZbJ3IBkX2YLgK9mQzB4h0bYsqb8+qJkrUVbkG54JZogiFwDrF+KnMjGB4B/6etzPoySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRRv9PvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18654C4CEE3;
	Fri, 13 Jun 2025 12:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749817680;
	bh=3oIMFvqo3WcAdkiD4QKXRpC4YU8kdL/fZ71Cbmcah5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IRRv9PvB4yilwpMx+kNltzvXi2b116X30eLSMtCijmmPHjZIoJGKdNfm+vPrCr+Yh
	 ORz8FMZdq4RPtLKtR6xYKgc4wOL3Hnx3l6nlotMuLKuVSi1bNUZ7nHW7/B4YKTtoZr
	 gWxBy/4mJorEtdDpo6q6pXoRI102ZbaztmNso7ketLkv38uQyClF/eTSsLi1NlzXZW
	 BrFPNHl8uS/jM8huxjXud4CiA+EcasBQ0tA4JAHE9LngsXzLnaFGwu2PKota/5SPmP
	 6zAmQ7FLtaU6/pf+QveKJljXI4yc0kbxDQMjmay0r6rZXytxPgxKtEDxcFYCSdqmso
	 6MpX2yawrJrjA==
Date: Fri, 13 Jun 2025 14:27:52 +0200
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
Subject: Re: [PATCH v2 10/12] docs: sphinx: parser_yaml.py: add Netlink
 specs parser
Message-ID: <20250613142752.01ae67d4@foz.lan>
In-Reply-To: <m2plf7n9vd.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<095fba5224a22b86a7604773ddaf9b5193157bc1.1749723671.git.mchehab+huawei@kernel.org>
	<m2plf7n9vd.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 13 Jun 2025 12:45:10 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Place the code at parser_yaml.py to handle Netlink specs. All
> > other yaml files are ignored.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .pylintrc                           |  2 +-
> >  Documentation/sphinx/parser_yaml.py | 39 +++++++++++++++++++++--------
> >  2 files changed, 29 insertions(+), 12 deletions(-)
> >
> > diff --git a/.pylintrc b/.pylintrc
> > index 30b8ae1659f8..f1d21379254b 100644
> > --- a/.pylintrc
> > +++ b/.pylintrc
> > @@ -1,2 +1,2 @@
> >  [MASTER]
> > -init-hook='import sys; sys.path += ["scripts/lib/kdoc", "scripts/lib/abi"]'
> > +init-hook='import sys; sys.path += ["scripts/lib", "scripts/lib/kdoc", "scripts/lib/abi"]'
> > diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> > index b3cde9cf7aac..eb32e3249274 100755
> > --- a/Documentation/sphinx/parser_yaml.py
> > +++ b/Documentation/sphinx/parser_yaml.py
> > @@ -3,6 +3,10 @@ Sphinx extension for processing YAML files
> >  """
> >  
> >  import os
> > +import re
> > +import sys
> > +
> > +from pprint import pformat
> >  
> >  from docutils.parsers.rst import Parser as RSTParser
> >  from docutils.statemachine import ViewList
> > @@ -10,7 +14,10 @@ from docutils.statemachine import ViewList
> >  from sphinx.util import logging
> >  from sphinx.parsers import Parser
> >  
> > -from pprint import pformat
> > +srctree = os.path.abspath(os.environ["srctree"])
> > +sys.path.insert(0, os.path.join(srctree, "scripts/lib"))
> > +
> > +from netlink_yml_parser import NetlinkYamlParser      # pylint: disable=C0413
> >  
> >  logger = logging.getLogger(__name__)
> >  
> > @@ -19,8 +26,9 @@ class YamlParser(Parser):
> >  
> >      supported = ('yaml', 'yml')
> >  
> > -    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
> > -    def parse(self, inputstring, document):
> > +    netlink_parser = NetlinkYamlParser()
> > +
> > +    def do_parse(self, inputstring, document, msg):
> >          """Parse YAML and generate a document tree."""
> >  
> >          self.setup_parse(inputstring, document)
> > @@ -28,14 +36,6 @@ class YamlParser(Parser):
> >          result = ViewList()
> >  
> >          try:
> > -            # FIXME: Test logic to generate some ReST content
> > -            basename = os.path.basename(document.current_source)
> > -            title = os.path.splitext(basename)[0].replace('_', ' ').title()
> > -
> > -            msg = f"{title}\n"
> > -            msg += "=" * len(title) + "\n\n"
> > -            msg += "Something\n"
> > -
> >              # Parse message with RSTParser
> >              for i, line in enumerate(msg.split('\n')):
> >                  result.append(line, document.current_source, i)
> > @@ -48,6 +48,23 @@ class YamlParser(Parser):
> >  
> >          self.finish_parse()
> >  
> > +    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
> > +    def parse(self, inputstring, document):
> > +        """Check if a YAML is meant to be parsed."""
> > +
> > +        fname = document.current_source
> > +
> > +        # Handle netlink yaml specs
> > +        if re.search("/netlink/specs/", fname):  
> 
> The re.search is overkill since it is not a regexp. You can instead say:
> 
>     if '/netlink/specs/' in fname:

OK.

> > +            if fname.endswith("index.yaml"):
> > +                msg = self.netlink_parser.generate_main_index_rst(fname, None)
> > +            else:  
> 
> I'm guessing we can drop these lines if the static index.rst approach works.

Agreed. Will test and drop it if it works.

> 
> > +                msg = self.netlink_parser.parse_yaml_file(fname)
> > +
> > +            self.do_parse(inputstring, document, msg)
> > +
> > +        # All other yaml files are ignored
> > +
> >  def setup(app):
> >      """Setup function for the Sphinx extension."""  

Thanks,
Mauro

