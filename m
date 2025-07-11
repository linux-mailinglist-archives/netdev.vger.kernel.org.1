Return-Path: <netdev+bounces-206093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C3B01689
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 10:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE4F1697D2
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EF420AF98;
	Fri, 11 Jul 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThKvuZwq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9518D;
	Fri, 11 Jul 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223049; cv=none; b=ATdC5B8f9fjSR4Z/oEzI4EqbJ+yPLIKXIxycKfp71vW/Hptc+W5bYQ9GvzHvzoddTU9uQBZxXMCPU5AAIakF1AIJEqh+OlyBRysbCgLgvoFVXqnZ6AiK70O/49EODP5XHH8NBodcprDQ81aoBE9f+nOJgXIBUkJ3BAY3gPQYjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223049; c=relaxed/simple;
	bh=OHCIgiPuGTOLfp8ArVy61aLbLOSN/ySRGK+gWTBkLBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEivNZbl4eyYC8HoDhlmpsfkhplal+htTtXDOKWBcQPV02qbTYFEYfMWrxiRLygHvAhLaztfgN+K3GUgfJS64DP2kEYKHq3xUxMSd60Tm5+cD7VkmMboJ4AG/vXWtZvUaT8KiS3ZUh4aK0O1LStBV7lhS7FeZ9x9HlaUkjJWdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThKvuZwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118FDC4CEED;
	Fri, 11 Jul 2025 08:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752223049;
	bh=OHCIgiPuGTOLfp8ArVy61aLbLOSN/ySRGK+gWTBkLBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThKvuZwqdhuC5eWcMREi5ebn4Hmn8EDthtu/b4le/mSaNIBuNYYylhL6n4PDhDmwr
	 pZFAawYh3d/ut4Qn1EMA3rLfjFwZilVks1Cy1aoRcPGg86XlABdrTbwOzA7tgqYaI5
	 KR3mnMI6irZwn3I6+9LKtn4rQfiMPqxmiBI7sWTEhg0uFl3HYenoT2vT+9d7n92RyX
	 6A1Gaeah2C+NOV3jPlZGcwB15BM89zYPBsGwby2yvWiDUkINI/u8OLWJqpB3JfXkOL
	 WkDSFMf57nXRT/JkfsOMM25KTIEXZJBYj/+fH4hGGGcdrk9+sHU2Wn6QvYBA0r0Gl5
	 gfKjee6RjqbYg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ua9G3-0000000FXSq-0eVb;
	Fri, 11 Jul 2025 10:37:27 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v9 14/13] sphinx: parser_yaml.py: fix line numbers information
Date: Fri, 11 Jul 2025 10:36:23 +0200
Message-ID: <4d1e0f5283ae1c6874cef272c5760035eb51278a.1752222934.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752076293.git.mchehab+huawei@kernel.org>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As reported by Donald, this code:

	rst_parser = RSTParser()
	rst_parser.parse('\n'.join(result), document)

breaks line parsing. As an alternative, I tested a variant of it:

	rst_parser.parse(result, document)

but still line number was not preserved. As Donald noted,
standard Parser classes don't have a direct mechanism to preserve
line numbers from ViewList().

So, instead, let's use a mechanism similar to what we do already at
kerneldoc.py: call the statemachine mechanism directly there.

I double-checked when states and statemachine were introduced:
both were back in 2002. I also tested doc build with docutils 0.16
and 0.21.2. It worked with both, so it seems to be stable enough
for our needs.

Reported-by: Donald Hunter <donald.hunter@gmail.com>
Closes: https://lore.kernel.org/linux-doc/m24ivk78ng.fsf@gmail.com/T/#u
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

PS.: I'm opting to send this as 14/13 to avoid respanning the entire
series again just due to this extra change.

 Documentation/sphinx/parser_yaml.py | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
index 1602b31f448e..634d84a202fc 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -11,7 +11,9 @@ import sys
 
 from pprint import pformat
 
+from docutils import statemachine
 from docutils.parsers.rst import Parser as RSTParser
+from docutils.parsers.rst import states
 from docutils.statemachine import ViewList
 
 from sphinx.util import logging
@@ -56,6 +58,8 @@ class YamlParser(Parser):
 
     re_lineno = re.compile(r"\.\. LINENO ([0-9]+)$")
 
+    tab_width = 8
+
     def rst_parse(self, inputstring, document, msg):
         """
         Receives a ReST content that was previously converted by the
@@ -66,10 +70,18 @@ class YamlParser(Parser):
 
         result = ViewList()
 
+        self.statemachine = states.RSTStateMachine(state_classes=states.state_classes,
+                                                   initial_state='Body',
+                                                   debug=document.reporter.debug_flag)
+
         try:
             # Parse message with RSTParser
             lineoffset = 0;
-            for line in msg.split('\n'):
+
+            lines = statemachine.string2lines(msg, self.tab_width,
+                                              convert_whitespace=True)
+
+            for line in lines:
                 match = self.re_lineno.match(line)
                 if match:
                     lineoffset = int(match.group(1))
@@ -77,12 +89,7 @@ class YamlParser(Parser):
 
                 result.append(line, document.current_source, lineoffset)
 
-            # Fix backward compatibility with docutils < 0.17.1
-            if "tab_width" not in vars(document.settings):
-                document.settings.tab_width = 8
-
-            rst_parser = RSTParser()
-            rst_parser.parse('\n'.join(result), document)
+            self.statemachine.run(result, document)
 
         except Exception as e:
             document.reporter.error("YAML parsing error: %s" % pformat(e))
-- 
2.50.0



