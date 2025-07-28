Return-Path: <netdev+bounces-210589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F9B13F7C
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44D616DF3B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDBF277030;
	Mon, 28 Jul 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9WTJHLh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B792274B38;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718543; cv=none; b=F0esV9kE9Cx9yv0HQmZOnntIRyOWhsqRGfLBz3yq6vyWb2o18MitJfrUnRlFtUnrb44juAN7WyaIYqm+mfhX8G9zkdHdl+OXdy3yf60hVFrBvsj+VA/xN/dsnXbScFBgnFSDed+HmZZRfG5ip121w96ij/Tq5Osirjvj8v1AKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718543; c=relaxed/simple;
	bh=Re34NdFIFBEjM60ZOokQBSoSZa53NQDJZGofuj8tscY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXWKxw7GzPE3+WQCow0teMXm4uFYweB81o4miEvo6yoU32KAAKl9cQ+0t65FmhTxfXEY0x+4QPHn8EfUWVBDStfZolJs/rtM3Kz8iORyJpjPsN8rYDIR6EaZ2p1NjeJBwbObfxwM6zpzMZGZKfy8PZaYYyivUMc3M12OaYQ3zlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9WTJHLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73773C113D0;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718542;
	bh=Re34NdFIFBEjM60ZOokQBSoSZa53NQDJZGofuj8tscY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9WTJHLhvpI0HtXYEFfFu5EMSp8YbHOPg/6SAELkZ/NBvbshoF0lnSEUXAJxlCiiw
	 zWB3hl78PbGnmveFYqIYmfsJ/08ybTVyAwNjo0JoVw2SsFApYell+BNRf/cQn/+JF5
	 bu8R9BMJMeBzQbWwJfnkoWQONyMEBXX9KH8dhVDGoin1KAkYAXqbuFADweJyACwb8t
	 Fp6JOyo56SDrWCQ55JgAcLZeDMbWdQE7ao4ygMqjHoFdiBdQ7fZvmE8dI4UiIR8szz
	 pHBjAtNyzZIzsTvJu8/nM7N177MrOV7TrfaKAn1iqYI/18nyYm2mTE8K8hG/70atWr
	 ISLUt9Yu7jkDg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugQIq-00000000GdK-2OZs;
	Mon, 28 Jul 2025 18:02:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Message-ID :" <cover.1752076293.git.mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Marco Elver" <elver@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Simon Horman" <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v10 14/14] sphinx: parser_yaml.py: fix line numbers information
Date: Mon, 28 Jul 2025 18:02:07 +0200
Message-ID: <af12fc33278d4da49ca4960f896768e311578461.1753718185.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753718185.git.mchehab+huawei@kernel.org>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

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
2.49.0


