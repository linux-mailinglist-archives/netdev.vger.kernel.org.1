Return-Path: <netdev+bounces-258113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA4HFX5Oi2mWTwAAu9opvQ
	(envelope-from <netdev+bounces-258113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:27:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB611C751
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 982813004900
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3ED3803DB;
	Tue, 10 Feb 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkbDL2+0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D6327C1C;
	Tue, 10 Feb 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737275; cv=none; b=SjDXZ+RjRCN+N5qHBIOHa+/29E0wtVOnqsatoFZDiy9wUCboi7WhJGPujlazeszXl7s+YfvIdkZReiHqI8zGqzHAzUGnuyDWFTQFe5z8hGWhywwKUNMKkicwq68ekL5W+t2rnLcIeMzrKRVeV81ZZTpIy2NCbPbY623t2N6vkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737275; c=relaxed/simple;
	bh=/+KOAp07MLHz2UajjqRp0iV6Ut1gJSwomndWsRRW/lM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmKgNVODh0EQABK/nJMqofOolq18EXhiQlvMtLhqJMXm5gG1in7sKddWFvsWTd/5pvBqrKmR+19gMwQIlX5pkkE93rSI59sElDVfnVDhySGIozPGCDCgFmhAScL6833F6PDQzSmHu8z3/3u/RocB9ZUSHk3oVVF+vhD4l6om9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkbDL2+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BB2C116C6;
	Tue, 10 Feb 2026 15:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770737274;
	bh=/+KOAp07MLHz2UajjqRp0iV6Ut1gJSwomndWsRRW/lM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EkbDL2+00gX1IMxuRnq4mK8Ym8kww+9pO5Rrwf7Vqp2vLiKMA1nkLu88PWLG7KkjB
	 HhS9qW0B+tLklTRD0PSzDMtGPx26Sh0+33n3lIfL7DdwdwY3x4CjbrGylcPZ2uF7bV
	 CYxzU/3C05ngmoNVbprorCvWA0BskBs17aw5Kw1OkeCEksANHB9xK3x7hCSytEhHHC
	 uISUMmkk7vnyjP6UMdpesngvg9Q5wJmtf981+xRlBrOXgVApLBTmf9AnNMy9iSQ5qo
	 wnb8qRI5Fs+c+ZXWP4r24sTEJe09CIQRn5zVqZqDStWK15khf8HMLYxAzSU0aTLMM5
	 v5urAt/+HtZkg==
Received: from localhost ([::1])
	by mail.kernel.org with esmtp (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vppeZ-000000009O1-3uH1;
	Tue, 10 Feb 2026 16:27:52 +0100
Date: Tue, 10 Feb 2026 16:27:49 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>, Stanislav
 Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v2 00/25] kernel-doc: make it parse new functions and
 structs
Message-ID: <20260210162749.30e84be5@localhost>
In-Reply-To: <87ecn97ild.fsf@trenco.lwn.net>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
	<87ecn97ild.fsf@trenco.lwn.net>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258113-lists,netdev=lfdr.de,huawei];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,intel.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,lists.osuosl.org,infradead.org,linuxfoundation.org,fomichev.me];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9EB611C751
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 10:27:58 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Jon,
> >
> > It is impressive how a single patch became a series with 25 ones ;-)  
> 
> *sigh*
> 
> I will try to have a good look at these shortly.  It seems pretty clear
> that this isn't 7.0 material at this point, though.

I ended missing your e-mail...

Yeah, it is too late for 7.0.

> 
> One thing that jumped at me:
> 
> > Ah, due to the complexity of NestedMatch, I opted to write
> > some unit tests to verify that the logic there is correct.
> > We can use it to add other border cases.
> >
> > Using it is as easy as running:
> >
> > 	$ tools/unittests/nested_match.py
> >
> > (I opted to create a separate directory for it, as this
> > is not really documentation)  
> 
> Do we really need another unit-testing setup in the kernel?  I can't say
> I'm familiar enough with kunit to say whether it would work for
> non-kernel code; have you looked and verified that it isn't suitable?

I'm familiar with kunit: I wrote myself a bunch of tests using
it for some DRM stuff.

Kunit is focused on testing kernel content. It basically adds
a way for a python script to run self-test logic inside a kernel 
module. It is not meant to test things outside the Kernel.

Also, I'm using the python internal library for it. The only
"fancy" thing I added is a helper module to better work with
unit tests:

- it formats unittest output;
- it passes some parameters to the unittest discover to make
  it more useable;
- it adds argparse parameters to filter tests and control their
  verbosity levels;
- it adds a way to pass argparse values to the tests, as
  some tests may require parameters (like passing a different
  yaml file to a dynamically-generated unit test).

- 

Anyway, I intend to send a new version of this series either
later this week or at the next one.

I'll probably split the unittest part from the part meant to
avoid new warnings after merging from linux-next.

-- 
Thanks,
Mauro

