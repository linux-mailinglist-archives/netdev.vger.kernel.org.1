Return-Path: <netdev+bounces-267400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LBLOpPrs2n5dAAAu9opvQ
	(envelope-from <netdev+bounces-267400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:48:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B144281B9C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7ADD3012B72
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B7D38A70E;
	Fri, 13 Mar 2026 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARydesxE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB82734B1AC;
	Fri, 13 Mar 2026 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398929; cv=none; b=nLJ5tCDFRtrT22WGtS7d03WL/ncxR7Bga4ro/GZtJHkWixXULLLLoRb1RO2/u2a5lJ9g6Y4Rk7nrQxOC2sQOpRP94W55AQEEolvIVVtz7oHB9PVM2UgefQ85WYgARY3KBa86bsVN8BIGPDSZh2XHED6MSwIrB14A+Y35wpcOV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398929; c=relaxed/simple;
	bh=hcIKGzxi9FPC6ciwT2qD9crW1zuaPgbtuY9uGNw5N0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO2mCcxpfrPc/nFW0yIOcLTMRe9iMe9AuhuZ7Mix+BX22SDWLkLBhdwS7javrQPGyjWHOp7zewkN2kgAqTvT4in05szsDyzuPHV/SZP5+hh/CGOj4HD0o6J6YWnoqa4WWpQ+HbW4Ll9l+ci2hBYBsJM+H/fER0NU8nNOZVYl2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARydesxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E063C19421;
	Fri, 13 Mar 2026 10:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773398929;
	bh=hcIKGzxi9FPC6ciwT2qD9crW1zuaPgbtuY9uGNw5N0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ARydesxEfRdZSJh5YH1nLEXtBYDGtQUZ9qBJjuESJTSIXFTaEjFyeLBydy0K721ir
	 2HkppxDSs75wl/niZhL66IRKxOSD+/IycCgdzOyMtehhtBi3NbG8LGtoxpM4Q0015+
	 ioUdObR2FM250f2wYqd/2GVsCxUJtEpgg+E9mQN6c9f1miCrai8ehWTTpndwtWrbkz
	 9tH9sqt92Yr1KlG9KwbchKFdud0b9rjS1WQGb9SsRyx9zLrugJEO78t47P99vI52D2
	 EGDJg1SGs/nFASKjoDzWCS61dHVNMc1WcEdn+rADrzbEobfWchwcG7ooj1f0dPUF7A
	 7/BFpBjZUhjYA==
Received: from localhost ([::1])
	by mail.kernel.org with esmtp (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w104V-0000000DgCV-0VdX;
	Fri, 13 Mar 2026 11:48:47 +0100
Date: Fri, 13 Mar 2026 11:48:45 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kees Cook <kees@kernel.org>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
Message-ID: <20260313114845.53eb8611@localhost>
In-Reply-To: <352c3f9f8ffd2d031c86a476e532a8ea6ffcf1ed@intel.com>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
	<33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
	<878qcj8pvw.fsf@trenco.lwn.net>
	<352c3f9f8ffd2d031c86a476e532a8ea6ffcf1ed@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267400-lists,netdev=lfdr.de,huawei];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lwn.net:email,intel.com:email,kdoc_parser.py:url]
X-Rspamd-Queue-Id: 8B144281B9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 04 Mar 2026 12:07:45 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Mon, 23 Feb 2026, Jonathan Corbet <corbet@lwn.net> wrote:
> > Jani Nikula <jani.nikula@linux.intel.com> writes:
> >  
> >> There's always the question, if you're putting a lot of effort into
> >> making kernel-doc closer to an actual C parser, why not put all that
> >> effort into using and adapting to, you know, an actual C parser?  
> >
> > Not speaking to the current effort but ... in the past, when I have
> > contemplated this (using, say, tree-sitter), the real problem is that
> > those parsers simply strip out the comments.  Kerneldoc without comments
> > ... doesn't work very well.  If there were a parser without those
> > problems, and which could be made to do the right thing with all of our
> > weird macro usage, it would certainly be worth considering.  
> 
> I think e.g. libclang and its Python bindings can be made to work. The
> main problems with that are passing proper compiler options (because
> it'll need to include stuff to know about types etc. because it is a
> proper parser), preprocessing everything is going to take time, you need
> to invest a bunch into it to know how slow exactly compared to the
> current thing and whether it's prohitive, and it introduces an extra
> dependency.
> 
> So yeah, there are definitely tradeoffs there. But it's not like this
> constant patching of kernel-doc is exactly burden free either. 

On my tests with a simple C tokenizer:

	https://lore.kernel.org/linux-doc/cover.1773326442.git.mchehab+huawei@kernel.org/

The tokenizer is working fine and didn't make it much slow: it
increases the time to pass the entire Kernel tree from 37s to 47s
for man pages generation, but should not change much the time for
htmldocs, as right now only ~4 seconds is needed to read files
pointed by Documentation kernel-doc tags and parse them.

The code can still be cleaned up, as there are still some things
hardcoded on the various dump_* functions that could be better
implemented (*).

The advantage of the approach I'm using is that it allows to
gradually migrate to rely at the tokenized code, as it can be done
incrementally.

(*) for instance, __attribute__ and a couple of other macros are parsed
    twice at dump_struct() logic, on different places.

> I don't
> know, is it just me, but I'd like to think as a profession we'd be past
> writing ad hoc C parsers by now.

Probably not, but I don't think we need a C parser, as kernel-doc
just needs to understand data types (enum, struct, typedef, union,
vars) and function/macro prototypes.

For such purpose, a tokenizer sounds enough.

Now, there is the code that it is now inside:
	https://github.com/mchehab/linux/blob/tokenizer-v5/tools/lib/python/kdoc/xforms_lists.py

which contains a list of C/gcc/clang keywords that will
be ignored, like:

	__attribute__
	static
	extern
	inline

Together with a sanitized version of the kernel macros it needs
to handle or ignore:

	DECLARE_BITMAP
	DECLARE_HASHTABLE
 	__acquires
	__init
	__exit
	struct_group
	...


Once we finish cleaning up kdoc_parser.py to rely only
on it for prototype transformations, this will be the only file
that will require changes when more macros start affecting 
kernel-doc.

As this is complex, and may require manual adjustments, it
is probably better to not try to auto-generate xforms list
in runtime. A better approach is, IMO, to have a C pre-processor
code to help periodically update it, like using a target like:

	make kdoc-xforms

that would use either cpp or clang to generate a patch to
update xforms_list content after adding new macros that
affect docs generation.

-- 
Thanks,
Mauro

