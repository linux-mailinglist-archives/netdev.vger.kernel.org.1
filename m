Return-Path: <netdev+bounces-294030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLHkFH1uHmrEjAkAu9opvQ
	(envelope-from <netdev+bounces-294030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:47:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2D628B2C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02E493012227
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51BA3932CB;
	Tue,  2 Jun 2026 05:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="foYU2uFe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD1392C52
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379236; cv=none; b=LVGGldp9wJrnBXkwPP8p3Ud66Qg4ftNPoh81yDUWCybtlJu6brtQ7BWuiXPi0Pyoucygsx1JjB2esetcugRuwzYDk2oALb5Onrh/F7H8b7//b+LEq7rE/TXcXMNercUr1XrmG6cb+5H7tTkoLbVzdlJ1ODK+1cLIoc96yvWcVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379236; c=relaxed/simple;
	bh=gt4DXyUMK+4E/fE2Ex3K88HkST93/FqQaubscf4ycQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0oGAhXCYBs7dSxx1/1eYZO8ALylDQVBfFLXsXyftNk1hmx43/bjO94sfoJ11rE2xPbQngvvi7gAwHrC/MwoK5buWhKQnIixLujTai7VhiXBuoXIrH/g61n6onSLjb3FlgtwZ0CL20sgV1wRIhLjA1kB/N33LB3foZUlllQo4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=foYU2uFe; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bed19623d6eso267708466b.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780379233; x=1780984033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI3N+hg4XqY5ZLMNbq1e38j35o45dSTupckxs1bB1Cg=;
        b=foYU2uFepYyGOM+zT3zzXvXlMNT3T1X2BeLfQrMF/02n7fhufme1fN68hkNfVoybZ4
         jghWzsWDunEOGTfQcIS4adzC7ZJnJ+/3qFJgAaHwMkmeyvRkoxuZ11Q8xYznOvPQ3JTL
         SYcyEdaEY1hooy5zb/Ln02Xug/+Vos6KSsHPs8VAkhwGzxeyk7vehDPUSWijhZEBjZTl
         Up2ik+VXd0ymLooae/P/IvRmezQ7iw6t9Od+Vf4+W94BfSZOh30iW87Ob1URxtQemtj4
         k+H9QuiY72k5txgXU1WsPLZSBVk1/Pfr6mFhD+6jvEjBaLutG1R5xtDDXOprImu+QgNo
         Nt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780379233; x=1780984033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vI3N+hg4XqY5ZLMNbq1e38j35o45dSTupckxs1bB1Cg=;
        b=lndwQEgO0fjP65d/jVcky0bb4FzDoVP0ravZbU3o/6Zdrw2UfC/jSE9FdTmlHtpj1c
         JySpJUEd1EUcuxZ+6Wv4XPSj4eEQQK9cN8lTYFMWOEX5bT7HW3QQbpzK7ywcEaqo/16W
         2mMnAMeufHRW8LDTiDCTz8IgPddYL4G4OuLtCYu8KLfQWGoB+MzxpXj5Rmanj0Gq1z/2
         tzshE7qV1Pz8mjU4owcXjoIy10ZWKpQ2ud4xYify7FA4v/1WSNQc8dA5RjD4CkiQsgVG
         aQ0WTym0POcWq19s+XF4yLCEIhPXp8OZ+UbLV5KmHiMmpKmyuV8Mk0ReHb6Yj4Ul3Li+
         gZpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QQtfzFaNqtGQV69zgWAslggCsupuNzqMxWQxB2lpMyKesHth2uhRLCCN1WXGUbNfMAIZq6gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuvShzbmWYxNrV8ccxyfWszT0uFxrzvzlSnNE5urp5ueNwiAM6
	cqXLemH62n69eyZJo01em54inIi7tFwtM6n4ER1htimQ5rLDUIBV1Hmg25zQuft2eIQ=
X-Gm-Gg: Acq92OHc4AQatjl/lEG5etP5h4a93jRmUKoH64tHCzZP2+EEU7jhrEvJvbAwOssjzDQ
	4vL8U4Cg8NGZLwLOuKlQvts1ZVZ/E5kZBIBzxFsUJBCUYVM0QrzNd8y/oMph5TPzjo+FMuFgCRl
	vxcX+5hflLj28EdzQDbEtiBiaVnmHOo2w9OJZDNEdi/jcZUjfr72bF23yiboojAckCzTPOpqegV
	3j1odADr22wv0OI8q7BVoGU+2QAz4PBw/3W0mfgpgyUl6796lr/CFFtVGOhJ/teH3s8/rTWkQF6
	G0PUwBhoAI5xu82IR6e3dHXzGZ4JStpuqHl420NAKd7fo17hvUk8Cq/tJqgippXwRIDJRDXy45H
	xG6CJ9zGY+/Cop2+V5XAoRrRqT6amlMtv2ThO8sCT0WqT04RtjydoTcYlH8alda8QrAIIVV9qfB
	lYZ4rcIj1h/cOKI1tjilWyK7tWrr+ke5r9JRoWD8HTyKTFTGlCAsD0rQ==
X-Received: by 2002:a17:907:9282:b0:bd4:6da5:d5b2 with SMTP id a640c23a62f3a-beab0dd8aecmr706227266b.1.1780379233570;
        Mon, 01 Jun 2026 22:47:13 -0700 (PDT)
Received: from u94a (27-240-75-84.adsl.fetnet.net. [27.240.75.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd9877d85sm1381496a91.14.2026.06.01.22.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:47:12 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:47:01 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>, eddyz87@gmail.com
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	menglong8.dong@gmail.com, tamird@kernel.org
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking
 fixes
Message-ID: <ah5pf25fhVH9WuU-@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601180400.1381736-1-jt26wzz@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294030-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:dkim]
X-Rspamd-Queue-Id: 10B2D628B2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Zhenzhong,

Thanks for looking at the stable kernel branch!

Since this patchset is intended for stable 6.1 I'd suggest to also
include stable@vger.kernel.org even if this is an RFC (and ideally with
'PATCH stable ...' as subject prefix, but that's just minor), so that
the stable team is aware.

On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> Hi BPF maintainers,
> 
> This RFC backports two BPF verifier scalar range-tracking fixes to 6.1.y.
> The series is intended to fix a verifier state-pruning issue where an
> impossible scalar path can be kept while the real success path is pruned.
> 
> This is a verifier scalar range-tracking issue, not a helper-specific
> issue.
> The visible failure is that the verifier can prune the real success
> continuation, which should not be skipped, and keep only an impossible one.
...

This sounds somewhat similar to the issue fixed in "backport of iterator
and callback handling fixes" for stable 6.6[1] by @Eduard. Could you try
to test on the latest stable 6.6.y as well at see if you can reproduce
the issue there?

Also per stable policy[2] we have backport the patches in the series to
6.6 first if we want it in 6.1 anyway.

  When using option 2 or 3 you can ask for your change to be included in specific
  stable series. When doing so, ensure the fix or an equivalent is applicable,
  submitted, or already present in all newer stable trees still supported. This is
  meant to prevent regressions that users might later encounter on updating...

Cheers,
Shung-Hsi Yu

1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmail.com/
2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

