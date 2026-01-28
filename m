Return-Path: <netdev+bounces-254347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM/UHXhEemn34wEAu9opvQ
	(envelope-from <netdev+bounces-254347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:16:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E2A6AD1
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DB0F305FAA9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61323168E6;
	Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/bdnRb0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EBF2505AA;
	Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619031; cv=none; b=qKx+H1tX/tZ11l7SiymKJkPepP0Jm0+8dV0S89/d5iZfSE5B2/KuIk9MQC8p9MzsSF8ZrnXN51BDcxlGUMkk/4F+yj/qWO6qGZhhppKhxN/BBX9ngBaexTRDZCnu4PVuTU2m5R4saJJpKrVDdplFK74Dh45MzTnP1lAvKRGpt/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619031; c=relaxed/simple;
	bh=UbNYriofE/WtsPUbSLmtYEzz8gqiNFUggra4R8CS2BA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YiELS/bkMocNlI0aQpDojze/2LXJIOem4VPfTk3wDskrU66rJA1jvYOLGZzhlaetiLnWHqtqRfI3HCtyT+LWTZ8nDKHVhmu0i7NEMdKwxrkSw8f35JGdRzWWnlBysoVlbIpXQTWtIhA0h2HQ7UPufQuvtXgA3RE08XieWdlOtQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/bdnRb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753F6C4CEF7;
	Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619031;
	bh=UbNYriofE/WtsPUbSLmtYEzz8gqiNFUggra4R8CS2BA=;
	h=From:To:Cc:Subject:Date:From;
	b=Q/bdnRb0F86wJ7HS6Cyp6eWiPP3TJGKOgmFgxuJ65RsPq579vdhDYe+fVzfjLjpLR
	 bQYW+sP2LP2epfwlQnKZ7Sp22sArGB4RfarEhMojtoVcVZuGNjjgTLoA1ymxA0r+to
	 kP/2G5C4fu05NnC5O28IizXy4gZWEIwSO78HZr+ThT2dHlAa3PqE1WljduYbzBO8GD
	 +2voYYHnYZuKawWPO5aq7HCXmKy1+8FAFsvpwkfsgF8nQeqJyhksIk+T2sAhkT2xfA
	 zfiqrzk1X+y0tkaDhJWpouTEzvcLDNVYlsu0f/192Y0ZCnDptrESgdzA6VARMzTMBt
	 c/PsNGftn3uNg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kO-0000000DAjS-2j79;
	Wed, 28 Jan 2026 17:50:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v2 00/25] kernel-doc: make it parse new functions and structs
Date: Wed, 28 Jan 2026 17:49:58 +0100
Message-ID: <cover.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254347-lists,netdev=lfdr.de,huawei];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,intel.com,kernel.org,iogearbox.net,gmail.com,lwn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB0E2A6AD1
X-Rspamd-Action: no action

Hi Jon,

It is impressive how a single patch became a series with 25 ones ;-)

This version was rebased on next-20260127, which is after docs-mw
got merged with my doc patches, solving some merge conflicts.

It should now apply cleanly on the top of upstream and it will address
the kernel-doc issues with context analysis patches that are already
at linux-next.

On this version, I opted to do something I always wanted when
porting from the venerable kernel-doc perl logic: properly handle
macros without writing really complex regular expressions.

After those changes, the replacement logic becomes a lot more
easier to write, as we can have a cleaner logic to handle
function calls:

	function_xforms = [
	    (KernRe(r"^static +"), ""),
	    (KernRe(r"^extern +"), ""),
	...
	    (NestedMatch(r"__cond_acquires\s*\("), ""),
	    (NestedMatch(r"__cond_releases\s*\("), ""),
	...
	}

It can even be used to replace comma-separated arguments like here:

	struct_xforms = [
	...
	    (NestedMatch(r'\bstruct_group\s*\('), r'\2'),
	    (NestedMatch(r'\bstruct_group_attr\s*\('), r'\3'),
	    (NestedMatch(r'\bstruct_group_tagged\s*\('), r'struct \1 { \3 } \2;'),
	    (NestedMatch(r'\b__struct_group\s*\('), r'\4'),
	...
	]

As both KernRe and NestedMatch have sub methods, they can be placed
altogether at the same transforms tables.

The regex syntax for them are quite simple: they should end with a
delimiter (usually open parenthesis, but brackets and square
brackets are also supported).

The first 15 patches on this series were co-developed with Randy,
with came up with the original patch. I ended helping identifying
kernel-doc issues and doing some changes to make the parser more
reliable.

Then, I added 10 other patches to improve NestedMatch.

The final two patches on it fixes an issue when parsing
include/net/page_pool/types.h. Right now, it doesn't parse
well struct page_pool_params, as the second struct_group_tagged()
has a /* private */ on it, causing the end parenthesis to be
commented out. After the series, the documentation for it
should be ok.

-

Even NestedMatch being more complex than KernRe, on my machine,
parsing all files is 5% faster than before, because we're not
parsing anymore macro definitions.

Ah, due to the complexity of NestedMatch, I opted to write
some unit tests to verify that the logic there is correct.
We can use it to add other border cases.

Using it is as easy as running:

	$ tools/unittests/nested_match.py

(I opted to create a separate directory for it, as this
is not really documentation)

Mauro Carvalho Chehab (23):
  docs: kdoc_re: add support for groups()
  docs: kdoc_re: don't go past the end of a line
  docs: kdoc_parser: move var transformers to the beginning
  docs: kdoc_parser: don't mangle with function defines
  docs: kdoc_parser: add functions support for NestedMatch
  docs: kdoc_parser: use NestedMatch to handle __attribute__ on
    functions
  docs: kdoc_parser: fix variable regexes to work with size_t
  docs: kdoc_parser: fix the default_value logic for variables
  docs: kdoc_parser: add some debug for variable parsing
  docs: kdoc_parser: don't exclude defaults from prototype
  docs: kdoc_parser: fix parser to support multi-word types
  docs: kdoc_parser: add support for LIST_HEAD
  docs: kdoc_re: properly handle strings and escape chars on it
  docs: kdoc_re: better show KernRe() at documentation
  docs: kdoc_re: don't recompile NextMatch regex every time
  docs: kdoc_re: Change NestedMath args replacement to \0
  docs: kdoc_re: make NextedMatch use KernRe
  tools: kdoc_re: add support on NestedMatch for argument replacement
  tools: python: add helpers to run unit tests
  unittests: add tests for NestedMatch class
  tools/lib/python/unittest_helper.py
  docs: kdoc_parser: better handle struct_group macros
  docs: kdoc_re: fix a parse bug on struct page_pool_params

Randy Dunlap (2):
  docs: kdoc_parser: ignore context analysis and lock attributes
  kdoc_parser: handle struct member macro VIRTIO_DECLARE_FEATURES(name)

 tools/lib/python/kdoc/kdoc_parser.py | 109 +++--
 tools/lib/python/kdoc/kdoc_re.py     | 154 +++++--
 tools/lib/python/unittest_helper.py  | 279 +++++++++++++
 tools/unittests/nested_match.py      | 589 +++++++++++++++++++++++++++
 4 files changed, 1063 insertions(+), 68 deletions(-)
 create mode 100755 tools/lib/python/unittest_helper.py
 create mode 100755 tools/unittests/nested_match.py

-- 
2.52.0


