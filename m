Return-Path: <netdev+bounces-197480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9A5AD8C07
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE68617FD5B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837FA2E1740;
	Fri, 13 Jun 2025 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JczsvHHL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D62E0B79;
	Fri, 13 Jun 2025 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817612; cv=none; b=GBSsAuqcEQQ4W/FEOQLAn41fyQgqY6YCbMyC4aYt5AiZJIWZKT331EXUdSRp0ihyJ0Xy17Rv52gS3S/TGKk7P8UZ/GH8cjiCcjMctI+URHv8rnTmNjINvJt445O2imJI8fGssJgf4v7GrmVWj9TVaLXJdK7O3K6dW3s7+k8PIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817612; c=relaxed/simple;
	bh=oRAQU8Aut4buXdrDfUT8Q4hhOEUiJydkITnkPgyONHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufiYivBXddyzA+2hdjk9S7bAh0EVMsDGz8jeCovqs4SI64S+8uvQt+1wywQl71jIpSAmdx15kmuhw5x12B8N6DnR6AuCpHAMAnGWBE+ciMc0RLoCu6t4I9av0nwcwUTVfVVYD5ubB61pbrWgJXa1WC8a9Iu5J3AGpR007WZ1B/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JczsvHHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268E4C4CEE3;
	Fri, 13 Jun 2025 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749817612;
	bh=oRAQU8Aut4buXdrDfUT8Q4hhOEUiJydkITnkPgyONHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JczsvHHLCLG7SVEAebXTCP+vM7v+EQukeV8ovojKrWKHxXT570QVcy2f8aXiUq6QP
	 UuOKMFHFUyOzM/VTmnEujDE2z5qMLjoTOlUCKPT94AOv+1cOTGCacPx9B8U232X1o3
	 Rfj8KbRYqxCqzBn4+fjluyslndcDibEymrDm5WDQpsHGlIdghiYYSqH1b6+yCKOs2L
	 zV50apG/aPQnY8/zTWyR6cynshmz7Kizyw6ThUxwuHP/n1t2yaFLqfKxRX/dzraodD
	 gt5iQVjV21mIrGk+SZdNQc2/fjwFg3kBRgxn5QK7IjnvucC8K29BRIbP2YlybcRDVf
	 38ndpabT4SoqA==
Date: Fri, 13 Jun 2025 14:26:44 +0200
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
Subject: Re: [PATCH v2 09/12] docs: sphinx: add a parser template for yaml
 files
Message-ID: <20250613142644.6497ed9b@foz.lan>
In-Reply-To: <m2tt4jnald.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<39789f17215178892544ffc408a4d0d9f4017f37.1749723671.git.mchehab+huawei@kernel.org>
	<m2tt4jnald.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 13 Jun 2025 12:29:34 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Add a simple sphinx.Parser class meant to handle yaml files.
> >
> > For now, it just replaces a yaml file by a simple ReST
> > code. I opted to do this way, as this patch can be used as
> > basis for new file format parsers. We may use this as an
> > example to parse other types of files.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/sphinx/parser_yaml.py | 63 +++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100755 Documentation/sphinx/parser_yaml.py  
> 
> It's not a generic yaml parser so the file should be
> netlink_doc_generator.py or something.

There's no way I'm aware of to have two yaml parsers. So, assuming that
some other subsystem would also use yaml (*), the same parser will need to
handle yaml files from different parts.

That's why I opted to have a generic name here. Besides that, there's
nothing there which is specific to Netlink, as the actual parser is
implemented inside a class on a separate file.

(*) as I said, media is considering using yaml for sensors. Nothing yet
    materialized, as we just had our summit last month. Yet, as DT also
    uses yaml, so I won't doubt that other subsystems may end using it
    as well.

> > diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> > new file mode 100755
> > index 000000000000..b3cde9cf7aac
> > --- /dev/null
> > +++ b/Documentation/sphinx/parser_yaml.py
> > @@ -0,0 +1,63 @@
> > +"""
> > +Sphinx extension for processing YAML files
> > +"""
> > +
> > +import os
> > +
> > +from docutils.parsers.rst import Parser as RSTParser
> > +from docutils.statemachine import ViewList
> > +
> > +from sphinx.util import logging
> > +from sphinx.parsers import Parser
> > +
> > +from pprint import pformat
> > +
> > +logger = logging.getLogger(__name__)
> > +
> > +class YamlParser(Parser):
> > +    """Custom parser for YAML files."""  
> 
> The class is only intended to be a netlink doc generator so I sugget
> calling it NetlinkDocGenerator

See above.

> > +
> > +    supported = ('yaml', 'yml')  
> 
> I don't think we need to support the .yml extension.

Ok, will drop "yml".

> > +
> > +    # Overrides docutils.parsers.Parser. See sphinx.parsers.RSTParser
> > +    def parse(self, inputstring, document):
> > +        """Parse YAML and generate a document tree."""
> > +
> > +        self.setup_parse(inputstring, document)
> > +
> > +        result = ViewList()
> > +
> > +        try:
> > +            # FIXME: Test logic to generate some ReST content
> > +            basename = os.path.basename(document.current_source)
> > +            title = os.path.splitext(basename)[0].replace('_', ' ').title()
> > +
> > +            msg = f"{title}\n"
> > +            msg += "=" * len(title) + "\n\n"
> > +            msg += "Something\n"
> > +
> > +            # Parse message with RSTParser
> > +            for i, line in enumerate(msg.split('\n')):
> > +                result.append(line, document.current_source, i)
> > +
> > +            rst_parser = RSTParser()
> > +            rst_parser.parse('\n'.join(result), document)
> > +
> > +        except Exception as e:
> > +            document.reporter.error("YAML parsing error: %s" % pformat(e))
> > +
> > +        self.finish_parse()
> > +
> > +def setup(app):
> > +    """Setup function for the Sphinx extension."""
> > +
> > +    # Add YAML parser
> > +    app.add_source_parser(YamlParser)
> > +    app.add_source_suffix('.yaml', 'yaml')
> > +    app.add_source_suffix('.yml', 'yaml')  
> 
> No need to support the .yml extension.

Ok.

> > +
> > +    return {
> > +        'version': '1.0',
> > +        'parallel_read_safe': True,
> > +        'parallel_write_safe': True,
> > +    }  

Thanks,
Mauro

