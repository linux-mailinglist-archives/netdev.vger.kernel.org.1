Return-Path: <netdev+bounces-198608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A38EADCDA4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0FF168696
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431CC2C030A;
	Tue, 17 Jun 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv0V1RLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7EE2E7167;
	Tue, 17 Jun 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167663; cv=none; b=XXRWyTEjwI1n0CIBpTWBvi8HlkPU9y3ids1VCu5FPsvPqeNH1OaNKxddv1kUlVJ5gz0G9IUfBGJfcxZJcBtB6lje8AgzI+ddL39nLTQ4kUJEx5lCAsb7+k5ddC38yFmQ3uw8UE2cwF0FCUjgj0k11GEhC9NnG+K4r2qjUcyPV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167663; c=relaxed/simple;
	bh=TAVrs0+mXS1jrVvmD693F7sgF44l4EVASYuCqGNwGlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2KBm2oXU0vNYYwBMsAzIUArKadhaUMC4qBIkqi2ra4ffKXSxU68yuwfckgX6B5+XjkFaRrpgjR8S/q+SQRBRrJ0c2YdBPpilTo+BeZjiLwnfty6FYl6t7vH6jM1XV1Lufz0Q3x3+WFRvdb2wG83cNdj6fjYkVuLXyj3Iy5tUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv0V1RLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48355C4CEE3;
	Tue, 17 Jun 2025 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750167662;
	bh=TAVrs0+mXS1jrVvmD693F7sgF44l4EVASYuCqGNwGlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kv0V1RLOE7PNwrVm8b7DOS6QKP21Xew66lc2FHDgE3n0gZMwHEc7qxA3lYu2230ur
	 9vJRgUoF8WCc0heQ9zZUInPzOTM51a9XujdBV3Xyq9QDMfhW3QPTtg83vlL2Ny/lZO
	 EDJmkxeI5KEza8b94GHhHe8lG5Xk0hFr78uqPRwV62XA/2K0l6TUs0NJ2c/CWth6tm
	 WR+xs9dyOk4aDkkcAz0fhL4k6HTXqO9Tz9jD0AzM4WXAcBPmoZwNQM5N/12tfsxjkA
	 n5R5yG0MRAN9QWx7tI/G/MOkQ8kEkQkMnMIkfrgotBaJ6zqn+kk0WpjJ8YlQ7KlgzI
	 XQXK1/DaftlAQ==
Date: Tue, 17 Jun 2025 15:40:49 +0200
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
Subject: Re: [PATCH v5 10/15] docs: sphinx: add a parser for yaml files for
 Netlink specs
Message-ID: <20250617154049.104ef6ff@sal.lan>
In-Reply-To: <m27c1ak0k9.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<c407d769c9f47083e8f411c13989522e32262562.1750146719.git.mchehab+huawei@kernel.org>
	<m27c1ak0k9.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 17 Jun 2025 13:35:50 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Add a simple sphinx.Parser to handle yaml files and add the
> > the code to handle Netlink specs. All other yaml files are
> > ignored.
> >
> > The code was written in a way that parsing yaml for different
> > subsystems and even for different parts of Netlink are easy.
> >
> > All it takes to have a different parser is to add an
> > import line similar to:
> >
> > 	from netlink_yml_parser import YnlDocGenerator
> >
> > adding the corresponding parser somewhere at the extension:
> >
> > 	netlink_parser = YnlDocGenerator()
> >
> > And then add a logic inside parse() to handle different
> > doc outputs, depending on the file location, similar to:
> >
> >         if "/netlink/specs/" in fname:
> >             msg = self.netlink_parser.parse_yaml_file(fname)
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/sphinx/parser_yaml.py | 76 +++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100755 Documentation/sphinx/parser_yaml.py
> >
> > diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> > new file mode 100755
> > index 000000000000..635945e1c5ba
> > --- /dev/null
> > +++ b/Documentation/sphinx/parser_yaml.py
> > @@ -0,0 +1,76 @@
> > +"""
> > +Sphinx extension for processing YAML files
> > +"""
> > +
> > +import os
> > +import re
> > +import sys
> > +
> > +from pprint import pformat
> > +
> > +from docutils.parsers.rst import Parser as RSTParser
> > +from docutils.statemachine import ViewList
> > +
> > +from sphinx.util import logging
> > +from sphinx.parsers import Parser
> > +
> > +srctree = os.path.abspath(os.environ["srctree"])
> > +sys.path.insert(0, os.path.join(srctree, "tools/net/ynl/pyynl"))
> > +
> > +from netlink_yml_parser import YnlDocGenerator        # pylint: disable=C0413
> > +
> > +logger = logging.getLogger(__name__)
> > +
> > +class YamlParser(Parser):
> > +    """Custom parser for YAML files."""  
> 
> Would be good to say that this is a common YAML parser that calls
> different subsystems, e.g. how you described it in the commit message.

Makes sense. Will fix at the next version.

> 
> > +
> > +    # Need at least two elements on this set  
> 
> I think you can drop this comment. It's not that it must be two
> elements, it's that supported needs to be a list and the python syntax
> to force parsing as a list would be ('item', )

Ah, ok.

> > +    supported = ('yaml', 'yml')
> > +
> > +    netlink_parser = YnlDocGenerator()
> > +
> > +    def do_parse(self, inputstring, document, msg):  
> 
> Maybe a better name for this is parse_rst?

Ok.

> 
> > +        """Parse YAML and generate a document tree."""  
> 
> Also update comment.

Ok.

> > +
> > +        self.setup_parse(inputstring, document)
> > +
> > +        result = ViewList()
> > +
> > +        try:
> > +            # Parse message with RSTParser
> > +            for i, line in enumerate(msg.split('\n')):
> > +                result.append(line, document.current_source, i)  
> 
> This has the effect of associating line numbers from the generated ReST
> with the source .yaml file, right? So errors will be reported against
> the wrong place in the file. Is there any way to show the cause of the
> error in the intermediate ReST?

Yes, but this will require modifying the parser. I prefer merging this
series without such change, and then having a separate changeset
addressing it.

There are two ways we can do that:

1. The parser can add a ReST comment with the line number. This
   is what it is done by kerneldoc.py Sphinx extension:

	lineoffset = 0
	line_regex = re.compile(r"^\.\. LINENO ([0-9]+)$")
        for line in lines:
            match = line_regex.search(line)
            if match:
                lineoffset = int(match.group(1)) - 1 # sphinx counts lines from 0
            else:
                doc = str(env.srcdir) + "/" + env.docname + ":" + str(self.lineno)
                result.append(line, doc + ": " + filename, lineoffset)
                lineoffset += 1

   I kept the same way after its conversion to Python, as right now,
   it supports both a Python class and a command lin command. I may
   eventually clean it up in the future.

2. making the parser return a tuple. At kernel_abi.py, as the parser
   returns content from multiple files, such tuple is:

		 (rst_output, filename, line_number)

   and the code for it is (cleaned up):

	for msg, f, ln in kernel_abi.doc(show_file=show_file,
                                         show_symbols=show_symbols,
                                         filter_path=abi_type):

            lines = statemachine.string2lines(msg, tab_width,
                                              convert_whitespace=True)

            for line in lines:
                content.append(line, f, ln - 1) # sphinx counts lines from 0

(2) is cleaner and faster, but (1) is easier to implement on an 
already-existing code.

> As an example if I modify tc.yaml like this:
> 
> diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
> index 4cc1f6a45001..c36d86d2dc72 100644
> --- a/Documentation/netlink/specs/tc.yaml
> +++ b/Documentation/netlink/specs/tc.yaml
> @@ -4044,7 +4044,9 @@ operations:
>              - chain
>      -
>        name: getchain
> -      doc: Get / dump tc chain information.
> +      doc: |
> +        Get / dump tc chain information.
> +        .. bogus-directive:: 
>        attribute-set: attrs
>        fixed-header: tcmsg
>        do:
> 
> This is the resuting error which will be really hard to track down:
> 
> /home/donaldh/net-next/Documentation/netlink/specs/tc.yaml:216: ERROR: Unexpected indentation. [docutils]
> 
> > +
> > +            rst_parser = RSTParser()
> > +            rst_parser.parse('\n'.join(result), document)
> > +
> > +        except Exception as e:
> > +            document.reporter.error("YAML parsing error: %s" % pformat(e))
> > +
> > +        self.finish_parse()
> > +
> > +    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
> > +    def parse(self, inputstring, document):
> > +        """Check if a YAML is meant to be parsed."""
> > +
> > +        fname = document.current_source
> > +
> > +        # Handle netlink yaml specs
> > +        if "/netlink/specs/" in fname:
> > +            msg = self.netlink_parser.parse_yaml_file(fname)
> > +            self.do_parse(inputstring, document, msg)
> > +
> > +        # All other yaml files are ignored
> > +
> > +def setup(app):
> > +    """Setup function for the Sphinx extension."""
> > +
> > +    # Add YAML parser
> > +    app.add_source_parser(YamlParser)
> > +    app.add_source_suffix('.yaml', 'yaml')
> > +
> > +    return {
> > +        'version': '1.0',
> > +        'parallel_read_safe': True,
> > +        'parallel_write_safe': True,
> > +    }  

