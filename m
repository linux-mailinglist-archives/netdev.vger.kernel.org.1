Return-Path: <netdev+bounces-206222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B9FB022CA
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F40A46DA5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900272EF670;
	Fri, 11 Jul 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEvXuqzN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B4219A91;
	Fri, 11 Jul 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255655; cv=none; b=MPCN7zQS8zZWn0OET7pAyUeaEw1Zr8spx8IhZ9wBRBxvHRZ46bDkykM8fOuJQXdxSmnzar8koogCRmFgUDGEH9AA4S5foswBXc84AhX1yx3av8djthHpxcImRuLD5WDIvt3m1HeazpxN9KyZwv960sVsfBrcukYoEC8w+D3OYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255655; c=relaxed/simple;
	bh=Z5h8RYJc6k17AEf7UTbWHnSOM2I8FCkIKpXNIERJo78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XR1LaYu3pLN0X+0iupIRFSRtBRvdGSZlWNWQ8UZ0wSCgCQeiYpTCAcS3Yxohi03Lus9F9PWx3Qi3FB8a1rHdIjhfBOET6VwjMyEI+5Vf+3h5o1XPWe/4k/8wZkQo2k4oOty6piEaegxLVAL6FWCwvHv4EB0gj4HAv4ZdFdnIih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEvXuqzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37011C4CEED;
	Fri, 11 Jul 2025 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752255654;
	bh=Z5h8RYJc6k17AEf7UTbWHnSOM2I8FCkIKpXNIERJo78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UEvXuqzNsjkR9n9ms5hU7W4gRqcQOTFDIMNJfU/Mk4UVCDaKfkzCI893GKZx9DIAo
	 qdt4OvG0eBTuEjiINckV9baYfNAgqRE2a2pqn1yoDRHy7nD7eO/7I80Q1LJ2jtSIsI
	 vlkx7iHkzfOc1q3umC23An6lHW2kRxmnAIiz9KUTCy4wi2XifdjsQg9y49fgyfSZ6y
	 TvvEOCYZgZit6f/jFA2PwTV5h0be8ZewiOWw31vMyYRc+mTz5joOrbbucZgBNBjuc3
	 zxLgsNCW9R3CltpYWl0vtEQlvShg/v01SXWTlv8AFFrL6BQpzssSO7M3qmRJioVfps
	 mP3tvhoeldj0g==
Date: Fri, 11 Jul 2025 19:40:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "Akira Yokosawa" <akiyks@gmail.com>, "Breno Leitao"
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>, "Jan Stancek" <jstancek@redhat.com>, "Marco Elver"
 <elver@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Ruben Wauters" <rubenru09@aol.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH v9 12/13] docs: parser_yaml.py: add support for line
 numbers from the parser
Message-ID: <20250711194047.4be0df4c@foz.lan>
In-Reply-To: <m2ecun5a3a.fsf@gmail.com>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
	<3b18b30b1b50b01a014fd4b5a38423e529cde2fb.1752076293.git.mchehab+huawei@kernel.org>
	<m2zfdc5ltn.fsf@gmail.com>
	<m2ms9c5din.fsf@gmail.com>
	<20250710195757.02e8844a@sal.lan>
	<m2ecun5a3a.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 11 Jul 2025 10:51:37 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Em Thu, 10 Jul 2025 15:25:20 +0100
> > Donald Hunter <donald.hunter@gmail.com> escreveu:
> >  
> >> Donald Hunter <donald.hunter@gmail.com> writes:
> >>   
> >> >>              # Parse message with RSTParser
> >> >> -            for i, line in enumerate(msg.split('\n')):
> >> >> -                result.append(line, document.current_source, i)
> >> >> +            lineoffset = 0;
> >> >> +            for line in msg.split('\n'):
> >> >> +                match = self.re_lineno.match(line)
> >> >> +                if match:
> >> >> +                    lineoffset = int(match.group(1))
> >> >> +                    continue
> >> >> +
> >> >> +                result.append(line, document.current_source, lineoffset)    
> >> >
> >> > I expect this would need to be source=document.current_source, offset=lineoffset    
> >> 
> >> Ignore that. I see it's not kwargs. It's just the issue below.
> >>   
> >> >>              rst_parser = RSTParser()
> >> >>              rst_parser.parse('\n'.join(result), document)    
> >> >
> >> > But anyway this discards any line information by just concatenating the
> >> > lines together again.    
> >> 
> >> Looks to me like there's no Parser() API that works with ViewList() so
> >> it would be necessary to directly use the docutils RSTStateMachine() for
> >> this approach to work.  
> >
> > It sounds so.
> >
> > The enclosed patch seems to address it:
> >
> > 	$ make cleandocs; make SPHINXDIRS="netlink/specs" htmldocs
> > 	...
> > 	Using alabaster theme
> > 	source directory: netlink/specs
> > 	Using Python kernel-doc
> > 	/new_devel/v4l/docs/Documentation/netlink/specs/rt-neigh.yaml:13: ERROR: Unknown directive type "bogus".
> >
> > 	.. bogus:: [docutils]
> >
> > Please notice that I added a hunk there to generate the error, just
> > to make easier to test - I'll drop it at the final version, and add
> > the proper reported-by/closes/... tags once you test it.
> >
> > Regards,
> > Mauro  
> 
> Awesome!
> 
> Tested-by: Donald Hunter <donald.hunter@gmail.com>
> 
> Patch comments below.
> 
> > [PATCH RFC] sphinx: parser_yaml.py: preserve line numbers
> >
> > Instead of converting viewlist to text, use it directly, if
> > docutils supports it.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >
> > diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
> > index e9cba164e3d1..937d2563f151 100644
> > --- a/Documentation/netlink/specs/rt-neigh.yaml
> > +++ b/Documentation/netlink/specs/rt-neigh.yaml
> > @@ -11,6 +11,7 @@ doc:
> >  definitions:
> >    -
> >      name: ndmsg
> > +    doc: ".. bogus::"
> >      type: struct
> >      members:
> >        -
> > diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> > index 1602b31f448e..2a2faaf759ef 100755
> > --- a/Documentation/sphinx/parser_yaml.py
> > +++ b/Documentation/sphinx/parser_yaml.py
> > @@ -11,7 +11,9 @@ import sys
> >  
> >  from pprint import pformat
> >  
> > +from docutils import nodes, statemachine  
> 
> nodes is not used

I dropped it on patch 14/13.

> 
> >  from docutils.parsers.rst import Parser as RSTParser  
> 
> This import is no longer needed

I'll drop on a next spin.
> 
> > +from docutils.parsers.rst import states
> >  from docutils.statemachine import ViewList
> >  
> >  from sphinx.util import logging
> > @@ -66,10 +68,24 @@ class YamlParser(Parser):  
> 
> I'm wondering if it makes much sense for this to inherit from Parser any
> more?

Yes. It still needs other things from the Parser class.

> >          result = ViewList()
> >  
> > +        tab_width = 8
> > +
> > +        self.state_classes = states.state_classes
> > +        self.initial_state = 'Body'
> > +
> > +        self.statemachine = states.RSTStateMachine(
> > +              state_classes=self.state_classes,
> > +              initial_state=self.initial_state,
> > +              debug=document.reporter.debug_flag)  
> 
> I don't think 'self.' is needed for any of these. They can be local to
> the method. You could just inline states.state_classes and 'Body' into
> the parameter list.

I dropped from most stuff, but self.statemachine is still needed.

I suspect that because of some other stuff inside the Parser class.

> 
> > +
> >          try:
> >              # Parse message with RSTParser  
> 
> Comment is out of date.
> 
> >              lineoffset = 0;  
> 
> Rogue semicolon

I dropped at patch 14/13.

> 
> > -            for line in msg.split('\n'):
> > +
> > +            lines = statemachine.string2lines(msg, tab_width,
> > +                                            convert_whitespace=True)
> > +
> > +            for line in lines:
> >                  match = self.re_lineno.match(line)
> >                  if match:
> >                      lineoffset = int(match.group(1))
> > @@ -77,12 +93,7 @@ class YamlParser(Parser):
> >  
> >                  result.append(line, document.current_source, lineoffset)
> >  
> > -            # Fix backward compatibility with docutils < 0.17.1
> > -            if "tab_width" not in vars(document.settings):
> > -                document.settings.tab_width = 8
> > -
> > -            rst_parser = RSTParser()
> > -            rst_parser.parse('\n'.join(result), document)
> > +            self.statemachine.run(result, document, inliner=None)
> >  
> >          except Exception as e:  
> 
> I think you could catch StateMachineError here.

Good point. will try that.

> >              document.reporter.error("YAML parsing error: %s" % pformat(e))  
> 
> Can you change this to an f"" string.

I prefer f-strings as well, but usually logger classes are recommended
to use the old way. I guess this came from a previous check with pylint.

Thanks,
Mauro

