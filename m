Return-Path: <netdev+bounces-260542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EzuCG6onWmgQwQAu9opvQ
	(envelope-from <netdev+bounces-260542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:32:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D37187BC0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6F9B31FE475
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1939C648;
	Tue, 24 Feb 2026 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaoJ9568"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC8396B8E;
	Tue, 24 Feb 2026 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939550; cv=none; b=OuTQgF19Wm9Ii6AxcOy8XDciDrHTp6LE6gentbV24PFRJgmy0Aj6wutAKaYWQT0tPnKR6kdINZTNRkeMQDmKbFLqtfsT4ZjIEcyJcDHqLiPo/SYwfvo34+eUEQsSEhInfb+9PgsvHly6gC0qYkTe8+qL4ApVUpH04oCYXB8GASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939550; c=relaxed/simple;
	bh=OH226xpf6OFBkdLB/rlmhdXNbboVu+PgHRuJNn31ygA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KF94zdaMt5RI0wBR9NNXTZx6yfg+Fq0bxmsF3pUl7aMP2DDX96oymxnHfii62Zqa+t9gz9rcZlgnFzYky/bBZxSCWEpYsAmiXDB9V24SWo483H6pA7dAgqT/oxWgqFRwVW2fvKD3TdLSEhunIKTmvLc6Bl/1MAIa/lanSsM6+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaoJ9568; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C34C19422;
	Tue, 24 Feb 2026 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771939550;
	bh=OH226xpf6OFBkdLB/rlmhdXNbboVu+PgHRuJNn31ygA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MaoJ9568OOoCR1H3e1IZa3TXWhhHUxPVWefiXSWJ2H04Ml2WRp0YZFrfYixr85VSq
	 xgLhEU4O++7qwHs4z7H6w+2Z83T8ixWcwtEoznNyTXw3SQRBIbxl7vnfiIFdMeDwb6
	 D58Fq4EwRtzjQUa2SQ6x0QZyq15d4tjJXkhZMfYnAzbYXstciiMANFs7Mqr2MlvcxE
	 nGme0QMlaUWVcc0XIS9/p+yJC0bk35W57YSjtBmnMj05sAvqYGbrv783MqSmT2s88s
	 lQso4Cd6fZP60LmlsXOD22HuXICgwgDsLtgOtpb2uhpjH3wq6r9GHsBW9AnSZIduyL
	 UMPdivEE1xDbg==
Received: from localhost ([::1])
	by mail.kernel.org with esmtp (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vusQ7-0000000Gpru-39rz;
	Tue, 24 Feb 2026 14:25:47 +0100
Date: Tue, 24 Feb 2026 14:25:46 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kees Cook <kees@kernel.org>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
Message-ID: <20260224142546.3eb7c38b@localhost>
In-Reply-To: <878qcj8pvw.fsf@trenco.lwn.net>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
	<33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
	<878qcj8pvw.fsf@trenco.lwn.net>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260542-lists,netdev=lfdr.de,huawei];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,lwn.net:email]
X-Rspamd-Queue-Id: 92D37187BC0
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 08:02:11 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Jani Nikula <jani.nikula@linux.intel.com> writes:
> 
> > There's always the question, if you're putting a lot of effort into
> > making kernel-doc closer to an actual C parser, why not put all that
> > effort into using and adapting to, you know, an actual C parser?  
> 
> Not speaking to the current effort but ... in the past, when I have
> contemplated this (using, say, tree-sitter), the real problem is that
> those parsers simply strip out the comments.  Kerneldoc without comments
> ... doesn't work very well.  If there were a parser without those
> problems, and which could be made to do the right thing with all of our
> weird macro usage, it would certainly be worth considering.

Parser is only needed for statement prototypes. There, stripping
comments (after we parse public/private) should be OK. Yet, we
want a python library to do the parsing, using it only for the
things we want to be parsed.

Assuming we have something like that, we'll still need to teach
the parser about the macro transforms, as those are very Linux
specific.

Maybe something like: https://github.com/eliben/pycparser would
help (didn't test nor tried to check if it does what we want).

There is an additional problem that this will add an extra
dependency for the Kernel build itself, because kernel-doc can
run at Kernel build time.


-- 
Thanks,
Mauro

