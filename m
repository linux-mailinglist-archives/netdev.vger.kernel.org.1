Return-Path: <netdev+bounces-254480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO8XCxiHemkE7gEAu9opvQ
	(envelope-from <netdev+bounces-254480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:00:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 999A5A953C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E6C630185A0
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23834340D93;
	Wed, 28 Jan 2026 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1wqms2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0517228CA9;
	Wed, 28 Jan 2026 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637653; cv=none; b=rEmqAIMgKfWHS6CwPVsoF2hLCDvhk10LwBmdOgm1+8Q9gtxPpcPvTCyNtCX/tJrzs0IvCuAsuALarr3N7WENY4lOgCwmO55HsTiKU4TftwwYMcUsZPCoPyixZ/9iL4tObTnmnm4tRDmaisemJ5fmK8tzf6kaKdwwoVCrE5WpNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637653; c=relaxed/simple;
	bh=v6wbKzh3F7F644v0ovvi+Y5SHZExUe48wIX7iPPR5t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vd27gXOueunlUUsP7AR+RCmZ+lEd/hKv7gHuKBvfvVMHFPK9YiJO4iBcWC5XyW1OyI55NoVfXTXUyWwzZtnnBBOzvrC8zdQ4kulcmjQFWAJgKoJckFwzSZfiCMH0qz94hbEjNX2yzlwNYx/QgnGlYnHsJqei661K4VaAQEUuJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1wqms2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B3FC4CEF1;
	Wed, 28 Jan 2026 22:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769637652;
	bh=v6wbKzh3F7F644v0ovvi+Y5SHZExUe48wIX7iPPR5t8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b1wqms2r8OrzKJ/zJa0gAn8jDGSPMeUhVLnYn9xRQTdvsSp/Gwa6249fcMvM5QOpq
	 NH27SeEvLSY9TDIZ7AsosgcOBPLM7p1eXM82SAcKOFD2enOdkKZqNRtEa4NdQ4IHKh
	 ysmGxpU5XEXMisRRs0S9UXEypFzi98wdbvwqYIjTKnU933lCEvRXu8uqGfnqXiHx8y
	 cEJZEVuRUn2KQjXpNjgUt4HJd1D5SFghS7vhN0SF4ANNyt6qEcixWQKEAzz4xFiftb
	 h6JX/1aXplZMngfkoTkModJcg9dKiskhi7825/vvKW5j/tb3n6bZqBXnyqpklzHBSD
	 oxrV52swzM0Sw==
Date: Wed, 28 Jan 2026 23:00:45 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "David S. Miller"
 <davem@davemloft.net>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, <bpf@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>, Stanislav
 Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v2 00/25] kernel-doc: make it parse new functions and
 structs
Message-ID: <20260128230045.781937b5@foz.lan>
In-Reply-To: <fced629d-2470-4673-ab0b-80de11f0e4c5@intel.com>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
	<87ecn97ild.fsf@trenco.lwn.net>
	<fced629d-2470-4673-ab0b-80de11f0e4c5@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254480-lists,netdev=lfdr.de,huawei];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lwn.net,davemloft.net,intel.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,lists.osuosl.org,infradead.org,linuxfoundation.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 999A5A953C
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 10:15:51 -0800
Jacob Keller <jacob.e.keller@intel.com> wrote:

> On 1/28/2026 9:27 AM, Jonathan Corbet wrote:
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >   
> >> Hi Jon,
> >>
> >> It is impressive how a single patch became a series with 25 ones ;-)  
> > 
> > *sigh*
> >   
> 
> Splitting things up helped me understand all the changes at least :)
> 
> > I will try to have a good look at these shortly.  It seems pretty clear
> > that this isn't 7.0 material at this point, though.
> > 
> > One thing that jumped at me:
> >   
> >> Ah, due to the complexity of NestedMatch, I opted to write
> >> some unit tests to verify that the logic there is correct.
> >> We can use it to add other border cases.
> >>
> >> Using it is as easy as running:
> >>
> >> 	$ tools/unittests/nested_match.py
> >>
> >> (I opted to create a separate directory for it, as this
> >> is not really documentation)  
> > 
> > Do we really need another unit-testing setup in the kernel?  I can't say
> > I'm familiar enough with kunit to say whether it would work for
> > non-kernel code; have you looked and verified that it isn't suitable?
> >   
> 
> I'm not sure kunit would be suitable here, since its meant for running 
> kernel code and does a lot of stuff to make that possible. It might be 
> able to be extended, but.. this is python code. Why *shouldn't* we use 
> one of the python unit test frameworks for it?

This is not using kunit. It is using standard "import unittest" from
Python internal lib.

> We have other python code in tree. Does any of that code have unit tests?

Good question. On a quick grep, it sounds so:

	$ git grep "import unittest" tools scripts
	scripts/rust_is_available_test.py:import unittest
	tools/crypto/ccp/test_dbc.py:import unittest
	tools/perf/pmu-events/metric_test.py:import unittest
	tools/testing/kunit/kunit_tool_test.py:import unittest
	tools/testing/selftests/bpf/test_bpftool.py:import unittest
	tools/testing/selftests/tpm2/tpm2.py:import unittest
	tools/testing/selftests/tpm2/tpm2_tests.py:import unittest

> I agree that it doesn't make sense to build new bespoke unit tests 
> different or unique per each python module, so if we want to adopt 
> python unit tests we should try to pick something that works for the 
> python tools in the kernel.
> 
> Perhaps finding a way to integrate this with kunit so that you can use 
> "kunit run" and get python tests executed as well would make sense? 
> But.. then again this isn't kernel code so I'm not sure it makes sense 
> to conflate the tests with kernel unit tests.

It shouldn't be hard to add it there - or to have a separate script
to run python unittests.

Assuming that we place all unittests at the same directory
(tools/unittests), the enclosed path will run all of them
altogether:

	$ tools/unittests/run.py
	Ran 35 tests in 0.001s

	OK
	nested_match:
	    TestStructGroup:
	        test_struct_group_01:            OK
	        test_struct_group_02:            OK
	        test_struct_group_03:            OK
	        test_struct_group_04:            OK
	        test_struct_group_05:            OK
	        test_struct_group_06:            OK
	        test_struct_group_07:            OK
	        test_struct_group_08:            OK
	        test_struct_group_09:            OK
	        test_struct_group_10:            OK
	        test_struct_group_11:            OK
        	test_struct_group_12:            OK
	        test_struct_group_13:            OK
	        test_struct_group_14:            OK
	        test_struct_group_15:            OK
	        test_struct_group_16:            OK
	        test_struct_group_17:            OK
	        test_struct_group_18:            OK
	        test_struct_group_19:            OK
	        test_struct_group_sub:           OK
	    TestSubMacros:
	        test_acquires_multiple:          OK
        	test_acquires_nested_paren:      OK
	        test_acquires_simple:            OK
        	test_mixed_macros:               OK
	        test_must_hold:                  OK
        	test_must_hold_shared:           OK
	        test_no_false_positive:          OK
	        test_no_macro_remains:           OK
	    TestSubReplacement:
	        test_sub_count_parameter:        OK
	        test_sub_mixed_placeholders:     OK
	        test_sub_multiple_placeholders:  OK
	        test_sub_no_placeholder:         OK
	        test_sub_single_placeholder:     OK
	        test_sub_with_capture:           OK
	        test_sub_zero_placeholder:       OK


	Ran 35 tests

And the helper will also provide an argparse to allow filtering
tests, change verbosity and filtering them with a regex:

	$ tools/unittests/run.py --help
	usage: run.py [-h] [-v] [-f] [-k KEYWORD]

	Test runner with regex filtering

	options:
	  -h, --help            show this help message and exit
	  -v, --verbose
	  -f, --failfast
	  -k, --keyword KEYWORD
	                        Regex pattern to filter test methods

That's said, some integration with kunit can be interesting
to have it producing a KTAP output if needed by some CI.

---

[PATCH] [RFC] Run all tests from tools/unittests

This small example runs all unittests from tools/unittests with:

    $ tools/unittests/run.py

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/tools/lib/python/unittest_helper.py b/tools/lib/python/unittest_helper.py
index 3cf1075b1de4..af16acc3af17 100755
--- a/tools/lib/python/unittest_helper.py
+++ b/tools/lib/python/unittest_helper.py
@@ -213,7 +213,7 @@ class TestUnits:
                             help="Regex pattern to filter test methods")
         return parser
 
-    def run(self, caller_file, parser=None, args=None, env=None):
+    def run(self, caller_file, suite=None, parser=None, args=None, env=None):
         """Execute all tests from the unity test file"""
         if not args:
             if not parser:
@@ -232,9 +232,10 @@ class TestUnits:
             unittest.TextTestRunner(verbosity=verbose).run = lambda suite: suite
 
         # Load ONLY tests from the calling file
-        loader = unittest.TestLoader()
-        suite = loader.discover(start_dir=os.path.dirname(caller_file),
-                                pattern=os.path.basename(caller_file))
+        if not suite:
+            loader = unittest.TestLoader()
+            suite = loader.discover(start_dir=os.path.dirname(caller_file),
+                                    pattern=os.path.basename(caller_file))
 
         # Flatten the suite for environment injection
         tests_to_inject = flatten_suite(suite)
diff --git a/tools/unittests/run.py b/tools/unittests/run.py
new file mode 100755
index 000000000000..2a5a754219de
--- /dev/null
+++ b/tools/unittests/run.py
@@ -0,0 +1,17 @@
+#!/bin/env python3
+import os
+import unittest
+import sys
+
+TOOLS_DIR=os.path.join(os.path.dirname(os.path.realpath(__file__)), "..")
+sys.path.insert(0, TOOLS_DIR)
+
+from lib.python.unittest_helper import TestUnits
+
+if __name__ == "__main__":
+    loader = unittest.TestLoader()
+
+    suite = loader.discover(start_dir=os.path.join(TOOLS_DIR, "unittests"),
+                            pattern="*.py")
+
+    TestUnits().run("", suite=suite)

Thanks,
Mauro

