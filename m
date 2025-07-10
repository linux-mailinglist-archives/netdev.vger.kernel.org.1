Return-Path: <netdev+bounces-205885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D107EB00AEA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157A51762A3
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8AE2F19B1;
	Thu, 10 Jul 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUq+tznF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6135D14BFA2;
	Thu, 10 Jul 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170289; cv=none; b=t6Y4AOAfDyv59oHftDgnDygzxJoUtIW3J2Qvi/oriDrjuShuW0ixWnX1LkKsao1IhycrQmQ4VmrbQqGd/pixajdlVv0W0+2jdfO+JZ2dvBjKZyJzsimQ5rhOGdUuUi1Zyzb5kIdrUeVlaAccPSnh+8CDKa3BrA3h7O13swV7l4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170289; c=relaxed/simple;
	bh=WEKyWjui7yR4mTuj5NwlW094lhOHGHFuA1ZIooDQedQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9lOY3b16AmVkkHQW5AjwCnuGpEljc0YVuAzH9DxC0/ghqGlRHHUEeK160LVugUV66NVmh9Yu46xeKjVVEnnpwLPXrCsewI6ArNbNe8W70+T2AAyuUGnpJO1RQQnWX3hImEUE+wt47T+EAO0r/slbQGbZILpPP2mm7iPxs/AdBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUq+tznF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7D4C4CEE3;
	Thu, 10 Jul 2025 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752170288;
	bh=WEKyWjui7yR4mTuj5NwlW094lhOHGHFuA1ZIooDQedQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OUq+tznFCWcj0o3VfdRE113t6g6KEk+oa/vbjSDOdrTsSU8oUj0Vr0r966EqPRew0
	 pDFWGRxjPNfFLrk1b4g9EsusgYhv3jQQrQOVdESZn5cOJlLAErwzqv3mPbR/9pW3mG
	 lTD9PfjNjXhw2knUrm31TH7wBlbBIK1Vsltg1UcChEmAeDk3DReNu+ITDpvBlHl8Kf
	 M9fD24hCvo4RiFaMUSDYED751cmeh1esSRjpZtowXdMWYVvzLwTN2AFvx4PBTqKHx6
	 SJZpx+uGVL88dT3zaFRz8RmbBWTeKgGLtGE/ii80iC6mwW9E2QaILcGE1FuPFHdgt9
	 VsxhaS2nWkf5A==
Date: Thu, 10 Jul 2025 19:57:57 +0200
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
Message-ID: <20250710195757.02e8844a@sal.lan>
In-Reply-To: <m2ms9c5din.fsf@gmail.com>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
	<3b18b30b1b50b01a014fd4b5a38423e529cde2fb.1752076293.git.mchehab+huawei@kernel.org>
	<m2zfdc5ltn.fsf@gmail.com>
	<m2ms9c5din.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 10 Jul 2025 15:25:20 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Donald Hunter <donald.hunter@gmail.com> writes:
> 
> >>              # Parse message with RSTParser
> >> -            for i, line in enumerate(msg.split('\n')):
> >> -                result.append(line, document.current_source, i)
> >> +            lineoffset = 0;
> >> +            for line in msg.split('\n'):
> >> +                match = self.re_lineno.match(line)
> >> +                if match:
> >> +                    lineoffset = int(match.group(1))
> >> +                    continue
> >> +
> >> +                result.append(line, document.current_source, lineoffset)  
> >
> > I expect this would need to be source=document.current_source, offset=lineoffset  
> 
> Ignore that. I see it's not kwargs. It's just the issue below.
> 
> >>              rst_parser = RSTParser()
> >>              rst_parser.parse('\n'.join(result), document)  
> >
> > But anyway this discards any line information by just concatenating the
> > lines together again.  
> 
> Looks to me like there's no Parser() API that works with ViewList() so
> it would be necessary to directly use the docutils RSTStateMachine() for
> this approach to work.

It sounds so.

The enclosed patch seems to address it:

	$ make cleandocs; make SPHINXDIRS="netlink/specs" htmldocs
	...
	Using alabaster theme
	source directory: netlink/specs
	Using Python kernel-doc
	/new_devel/v4l/docs/Documentation/netlink/specs/rt-neigh.yaml:13: ERROR: Unknown directive type "bogus".

	.. bogus:: [docutils]

Please notice that I added a hunk there to generate the error, just
to make easier to test - I'll drop it at the final version, and add
the proper reported-by/closes/... tags once you test it.

Regards,
Mauro

[PATCH RFC] sphinx: parser_yaml.py: preserve line numbers

Instead of converting viewlist to text, use it directly, if
docutils supports it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index e9cba164e3d1..937d2563f151 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -11,6 +11,7 @@ doc:
 definitions:
   -
     name: ndmsg
+    doc: ".. bogus::"
     type: struct
     members:
       -
diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
index 1602b31f448e..2a2faaf759ef 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -11,7 +11,9 @@ import sys
 
 from pprint import pformat
 
+from docutils import nodes, statemachine
 from docutils.parsers.rst import Parser as RSTParser
+from docutils.parsers.rst import states
 from docutils.statemachine import ViewList
 
 from sphinx.util import logging
@@ -66,10 +68,24 @@ class YamlParser(Parser):
 
         result = ViewList()
 
+        tab_width = 8
+
+        self.state_classes = states.state_classes
+        self.initial_state = 'Body'
+
+        self.statemachine = states.RSTStateMachine(
+              state_classes=self.state_classes,
+              initial_state=self.initial_state,
+              debug=document.reporter.debug_flag)
+
         try:
             # Parse message with RSTParser
             lineoffset = 0;
-            for line in msg.split('\n'):
+
+            lines = statemachine.string2lines(msg, tab_width,
+                                            convert_whitespace=True)
+
+            for line in lines:
                 match = self.re_lineno.match(line)
                 if match:
                     lineoffset = int(match.group(1))
@@ -77,12 +93,7 @@ class YamlParser(Parser):
 
                 result.append(line, document.current_source, lineoffset)
 
-            # Fix backward compatibility with docutils < 0.17.1
-            if "tab_width" not in vars(document.settings):
-                document.settings.tab_width = 8
-
-            rst_parser = RSTParser()
-            rst_parser.parse('\n'.join(result), document)
+            self.statemachine.run(result, document, inliner=None)
 
         except Exception as e:
             document.reporter.error("YAML parsing error: %s" % pformat(e))



