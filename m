Return-Path: <netdev+bounces-254636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHlcB0Aae2msBQIAu9opvQ
	(envelope-from <netdev+bounces-254636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:28:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5F8AD807
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9254F30BE7D9
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09637BE7E;
	Thu, 29 Jan 2026 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+5FPY3q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB523F26A;
	Thu, 29 Jan 2026 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674449; cv=none; b=ZHuLd9sfl+OWskA4XhpEl94vk9QYon8qyuJ/CfI+nAnPkdx1EEYEiomlMnUMZNok6rUTvmdgnFjN6oYYAolB6R0IO9d6zeThqAYcmg7gyMObGbBD6CRMdwdiUuxBPWKgUOfbd7ZyaWT7ajTULEPXUbE3+SrDidliPGHWpWwuM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674449; c=relaxed/simple;
	bh=7IsBi6ODhtIKV2zts0kTXbGdo6yrQVlVFdfuQtskjHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhhDwbNT2OFaexdtGPb/F2AUhu+R5fiU0pJFzIAR1TG5CHqzoq5gVdDCiaMLtRQqQfB5vmnwfagBuWvsfDtcgABOj/9gLuF+W3awKKkS1WRNx7998rOgT0Oy4mxMj2EN3mGiPuR7OmJVd3L4aJP2x4aKyQXPPBMh+TH5qMMXqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+5FPY3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC4FC4CEF7;
	Thu, 29 Jan 2026 08:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674448;
	bh=7IsBi6ODhtIKV2zts0kTXbGdo6yrQVlVFdfuQtskjHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+5FPY3qcPpvkQ9sAaI2KNUJHnl83VGZFBDJDwDqIxgZA02L660cmx1Bm60xYV5nI
	 vLffxok4X+HFiGw38gYgNDtCo6rTyKmILPzk6tjTbFEq4sL+ZiBeZFPYzSeLS7zvSr
	 T9Bswk/yR6F1zuJZGGV7KknByLqYDwRy2toSG9q2jSiuyKPCdQppZzOwZHeSdbNRBU
	 YnsRZMqb+PDlrBYnNu+Hj+0C04QyP9qDiReu20XMjtg7q7LGddB3aFrPJngmTy9Dbv
	 KdmASKroZhC8GdqGF1TXcPoDY9vVaWFqZrM1taeoMwYCIi9wlsCCEUJ0eb9cynsyux
	 5kMDjD7DORw5w==
Date: Thu, 29 Jan 2026 09:14:01 +0100
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
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>
Subject: Re: [PATCH v2 00/25] kernel-doc: make it parse new functions and
 structs
Message-ID: <20260129091401.0b86926c@foz.lan>
In-Reply-To: <09681668-57ca-4294-afa8-95af7eebe630@intel.com>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
	<87ecn97ild.fsf@trenco.lwn.net>
	<fced629d-2470-4673-ab0b-80de11f0e4c5@intel.com>
	<20260128230045.781937b5@foz.lan>
	<09681668-57ca-4294-afa8-95af7eebe630@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254636-lists,netdev=lfdr.de,huawei];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foz.lan:mid,intel.com:email]
X-Rspamd-Queue-Id: 3D5F8AD807
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 14:08:50 -0800
Jacob Keller <jacob.e.keller@intel.com> wrote:

> On 1/28/2026 2:00 PM, Mauro Carvalho Chehab wrote:
> > On Wed, 28 Jan 2026 10:15:51 -0800
> > Jacob Keller <jacob.e.keller@intel.com> wrote:  
> >> On 1/28/2026 9:27 AM, Jonathan Corbet wrote:  
> >>> Do we really need another unit-testing setup in the kernel?  I can't say
> >>> I'm familiar enough with kunit to say whether it would work for
> >>> non-kernel code; have you looked and verified that it isn't suitable?
> >>>      
> >>
> >> I'm not sure kunit would be suitable here, since its meant for running
> >> kernel code and does a lot of stuff to make that possible. It might be
> >> able to be extended, but.. this is python code. Why *shouldn't* we use
> >> one of the python unit test frameworks for it?  
> > 
> > This is not using kunit. It is using standard "import unittest" from
> > Python internal lib.
> >   
> 
> Right. I think it makes perfect sense to use unittest for python files. 
> That was the point of my reply above :D
> 
> >> We have other python code in tree. Does any of that code have unit tests?  
> > 
> > Good question. On a quick grep, it sounds so:
> > 
> > 	$ git grep "import unittest" tools scripts
> > 	scripts/rust_is_available_test.py:import unittest
> > 	tools/crypto/ccp/test_dbc.py:import unittest
> > 	tools/perf/pmu-events/metric_test.py:import unittest
> > 	tools/testing/kunit/kunit_tool_test.py:import unittest
> > 	tools/testing/selftests/bpf/test_bpftool.py:import unittest
> > 	tools/testing/selftests/tpm2/tpm2.py:import unittest
> > 	tools/testing/selftests/tpm2/tpm2_tests.py:import unittest
> >   
> >> I agree that it doesn't make sense to build new bespoke unit tests
> >> different or unique per each python module, so if we want to adopt
> >> python unit tests we should try to pick something that works for the
> >> python tools in the kernel.
> >>
> >> Perhaps finding a way to integrate this with kunit so that you can use
> >> "kunit run" and get python tests executed as well would make sense?
> >> But.. then again this isn't kernel code so I'm not sure it makes sense
> >> to conflate the tests with kernel unit tests.  
> > 
> > It shouldn't be hard to add it there - or to have a separate script
> > to run python unittests.
> >   
> 
> Right. Some way to have all unit tests run is nice so that its easy to 
> hook up into various CI processes. Sounds like you have a solid idea on 
> that.
> 
> > That's said, some integration with kunit can be interesting
> > to have it producing a KTAP output if needed by some CI.
> >   
> That could also be interesting, as it would make it easier for other 
> tooling to work with all the tests.
> 
> Personally I am not sure how useful that would be vs just making use of 
> the unittest stuff provided as-is with python.

I'd say that, for now, we don't need a KTAP output, but as things go
more complex and more parts of the tools get unittests added, it 
could make sense to add it.

Adding proper support for it shouldn't be hard with the definitions
inside unittest_helper. All we need to do would be to write a new
inherited class from unittest.TestResult, placing there a 
printResults() method that would generate the KTAP format. We may
add a new "--ktap" argparse argument that, if enabled, it would
use the newer class instead of the Summary class.

Thanks,
Mauro

