Return-Path: <netdev+bounces-255481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDOiIApBfmmPWgIAu9opvQ
	(envelope-from <netdev+bounces-255481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:51:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF883C3695
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 234E33012240
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E5E361DB7;
	Sat, 31 Jan 2026 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNQ4kv2k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2C155757;
	Sat, 31 Jan 2026 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881849; cv=none; b=bNaAGCP81ABsdGsACL7BS8egReHr+0RhRPuieyBjririI4+QethxUfViNHXeScnRxrpSntCFPStqOv/qf4jAMVGqRVnCd/XSffyjl1LmAFIVjW+GJaoLaMZrLkhs6K0bjCygzvfXxNbyT1Oe2Q4H5a7V1l5bNAL6tCV/QxL6z1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881849; c=relaxed/simple;
	bh=q0T8b+UAEAQOtNc3XJm5Jfy6vBCFYxNtHnU0E6OypNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwJoYZfsVqaKqJKSsDvaAi/A1vgVZQU7aCGngeq6A4atdEGM1lRCQGmuMHpC3fXPgoi2dmADj4eVBVhhQC9CNgKH/TMyVoKr5NmOKFzWN6U0yjDO++TZIR71VvSrjxR+iJfWeHp5TYk2G4Rc/wsyT+CME99HpmbQ96oPegRjvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNQ4kv2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A198AC4CEF1;
	Sat, 31 Jan 2026 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769881849;
	bh=q0T8b+UAEAQOtNc3XJm5Jfy6vBCFYxNtHnU0E6OypNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fNQ4kv2kegCfNR6OoRapRvvbKJPKMiXS8mKmjBAVppBGTNFvlNm1SAszSwg2WdBVD
	 NF5Cei/NEvDPRqlX1HM4CYzD4Ju4IqIKwF0oh3PzchTsJvr1uef74QVOCqmcZke2LO
	 Uj/M5Dm7VR6RCp/qSESmXdIC8V6eQsVxYvoysupsmynAan1WEeTwlk7eKZ5KbpyNwu
	 51TijE8l3egwU+sr0VHRHwyiF12tqDJtiGWV4o9QwrmIsNpaKBw1G+mV0OwDkF7vlP
	 F6JYSkBu+grEPqG/TtCWrkcEtYTqbqVL0uSeXSUEa4uRfLd/oGdEafLYhYJwA9UwN1
	 Y/EEvbsI//SXg==
Date: Sat, 31 Jan 2026 09:50:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: rss: validate min RSS
 table size
Message-ID: <20260131095047.2096ac8f@kernel.org>
In-Reply-To: <willemdebruijn.kernel.29ba7c9e89f32@gmail.com>
References: <20260130192912.826454-1-kuba@kernel.org>
	<willemdebruijn.kernel.29ba7c9e89f32@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255481-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF883C3695
X-Rspamd-Action: no action

On Sat, 31 Jan 2026 12:18:55 -0500 Willem de Bruijn wrote:
> > +def _test_rss_indir_size(cfg, qcnt, context=0):
> > +    """Test that indirection table size is at least 4x queue count."""
> > +    ethtool(f"-L {cfg.ifname} combined {qcnt}")  
> 
> Remind me: does this work with devices that advertise RX N TX N rather
> than combined N?

It doesn't. But I haven't seen a device which doesn't at least
advertise combined made in this decade. I started typing this with
support for "rx" vs "combined" initially, but it complicates the code
for no real benefit.

If a driver which doesn't have "combined" starts reporting results 
to NIPA I'll care, right now - CBA.

> > +    rss = _get_rss(cfg, context=context)
> > +    indir = rss['rss-indirection-table']
> > +    ksft_ge(len(indir), 4 * qcnt, "Table smaller than 4x")
> > +    return len(indir)
> > +
> > +
> > +@ksft_variants([
> > +    KsftNamedVariant("main", False),
> > +    KsftNamedVariant("ctx", True),
> > +])
> > +def indir_size_4x(cfg, create_context):
> > +    """
> > +    Test that the indirection table has at least 4 entries per queue.
> > +    Empirically network-heavy workloads like memcache suffer with the 33%
> > +    imbalance of a 2x indirection table size.
> > +    4x table translates to a 16% imbalance.
> > +    """
> > +    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> > +    ch_max = channels.get('combined-max', 0)  
> 
> Same here: not all drivers set this.
> 
> Perhaps we should skip if absent?
> 
> And does combined-max mean all queues across all contexts, or per
> context?

Could you rephrase? Not sure I understand.

channels are interrupts, we use it in place of max Rx queues because 
we don't have an API to allocate queues directly.

When queue count is changed and the user did not set the indirection
table of the main context the main context's indir table is auto-
-repopulated. It may also be resized.

The indir tables of additional contexts are not repopulated.
We do not have the concept of "default" indirection table in 
an additional context because it has no practical use (just use
the main table if you don't care about the queue selection!?)
Since we don't have an explicit API to size them, (yet),
we expect the size of additional contexts to follow the size 
of the main indirection table.

If a table is resized the expectation should be that the driver
folds/unfolds the existing table eg [0, 1, 0, 1] can fold into [0, 1]
or unfold into [0, 1, 0, 1, 0, 1, 0, 1]. Resizing tables of additional
contexts is currently broken / no possible. My colleague is supposed
to be working on fixing that but appears to be making slow progress :/

> The test seems to imply the second. My intuition was the
> first. Is it clearly defined across devices. per ethtool_channels,
> seems per device?
> 
>   * @max_combined: Read only. Maximum number of combined channel the driver
>   *      support. Set of queues RX, TX or other.


