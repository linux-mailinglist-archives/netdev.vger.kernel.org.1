Return-Path: <netdev+bounces-288975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIQLAZriCmoV9AQAu9opvQ
	(envelope-from <netdev+bounces-288975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:57:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A02756A2A4
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B9B30087A4
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EE2322B87;
	Mon, 18 May 2026 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BouaaGhh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754CA3176FD
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097922; cv=none; b=EgMYQyoWLgfQGwke+J8FvK9HRVsSWZrAWDhL10JV/zFEkMNdF5RHj4XulC3ODPnduvmO7u559Lgm9GNrP2bsfRW/yohsH8Z5aKMN2x1YnE76yr/w0daE4RIfHDaInCEjDGskyM/QLmC4U3bXaF80VPnaXXza1o1/akv+nh14iVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097922; c=relaxed/simple;
	bh=eapnlP3Dii9NeflAVcuwmaNdRIFlC5BD64zBajNygPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH7j+mM6qMCcfc//upFSu2WRR3+2TD6MBjX/mSsoj+saxT1cqq0JBdSZPDIrSJiCl/acNePThEVRmavlk37rLE4dDbRjYPLYx3XNNSx8D1UxdbSnp8kqVbMyN5HRdL5UflUI14xjEKDDtwziMn2snzYVC1JMoNlaKP8423pEQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BouaaGhh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3664df32e91so2121730a91.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779097921; x=1779702721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cBDGhHwraee1lZ5hSwUN0YTjFh6ogBdQJHLaS9nuFd8=;
        b=BouaaGhh1dnqXmRsnpvuOQHfs1cDwyIZYc9Um+YEmXRNqiUQ4H/7dcuRCSbCsZ8dGt
         oHg28ss5ETLsyHG+kdz8QPxSXRgzfd8zmkm8hxm9J4Ii+8Fn4MJIjfc/DfLwJa4v3n5H
         avQQ7W5hDeULvWCjFiROaDV0jFo4BeWJuYJkUCSx0HtZuTPWtilkS9YkvHc/Kzjemz8+
         2BMuPzNGxraCbctTmz32sQb6jIb4RIOgkL8LHL88p8fj+lvJx1D6MezmakRzGGnIRyL/
         RwSzV+EeDjy9Ppsga6AeSye/dLy18ymVNodIQvOJcSWUMwiL5d2KkQE4JtBva5v+ElFV
         a85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097921; x=1779702721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBDGhHwraee1lZ5hSwUN0YTjFh6ogBdQJHLaS9nuFd8=;
        b=L2RUlcVPSx1j0p94pR5pPbB71bocxIAYhKYPVzKSwILoIdOqi7WVKAyddEVdO3VauH
         6aWgZFTyOu8Y2uRzMUBuhCRefs4ysvKTgAU1+avjfVZe9u58R3jG0v0jQuhXLRtMwxQo
         mnVEsZCfoWbd+GPyry6+rlgCYmifPINzPXaWaaV8NRt1r6A0XA0KuZ7Z897dKNbiO9gR
         3lMkIphfFfWoTsYU834OcWKMqAKQw7Ntq/d3x8Mr97hTtgjBKWMDGnjfRb17MCpcBtBY
         B/XNJGWaaFCw6BLh/VqnCvJ3MAaQCNGt+lTteF4qV4IkB2UScPFKwR7grfcowFagj/dT
         ocPA==
X-Forwarded-Encrypted: i=1; AFNElJ+tV2dgwHnF8jpgJBavKPG98p0J3N6HWCArQ/7o9b+h6j0GD8UwsypNfD7m6g/Pl8YYg9f6hNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLptQbTHXEEW9ObwtUh+t/A+yHMpHKGn7zmOqeXls7W8YHeUY
	rMVd6O9zFAr974q4HBEoM3mpycxcYFirctsn3cRl2G/GmiNNphMYMfulrqXYxQYJqz0=
X-Gm-Gg: Acq92OFUpjBCtjNOSzJodXk1heR8vAMctRIvDyZ3Ai7JsmnQsafBcGlIjphOAIjpbhH
	Ifj3jESbqx0ndh5gvASq4eNFoBXu+sjqDN75p1eVP1GRx4ZJHRhoAwjf8NJgloNvsu16yeyCna2
	0JJq6kWuWSz5o+yVfTcTmdgR9bH432q13lWecpQjVBfbLGTLzLqOalkOHneR8EgiONrdX2MZjM3
	rYuItyjQqQKT1o+gBEH7GL6QxF+7aqnShPISFGQK0Kd1B4gBbnvMDGAzeOntxOMF24lrUZjoi2H
	Do9Pwz22eqNySFXp7bB/YTJBo8JhUC4CLsDg6GVUAPraegGTPKoQ5LUYdMX0/3feE8nl7EHuQb4
	Hzhr0HcpPJlRKVoNY1FnkKinW+IoVSCtU7V7Mj+t3JWR+5m+4OmwCt70BJqk2OzPLMWrQhj5X7m
	VYjllc84USiliGtHjB+vAJrmSssQzPrpNI/uJd1Stjn1ma2yM97Fc=
X-Received: by 2002:a17:90b:5848:b0:366:1172:597e with SMTP id 98e67ed59e1d1-369519f2d87mr13918414a91.9.1779097920800;
        Mon, 18 May 2026 02:52:00 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062941sm16420465a12.2.2026.05.18.02.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:52:00 -0700 (PDT)
Date: Mon, 18 May 2026 17:51:54 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <agrdjt6CjpJo3AYF@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
 <20260510082509.1530a1a3@kernel.org>
 <agCtGqWLK53TWCaS@Air.local>
 <20260510095937.598c27a6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510095937.598c27a6@kernel.org>
X-Rspamd-Queue-Id: 6A02756A2A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288975-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Air.local:mid]
X-Rspamd-Action: no action

On 26-05-10 09:59, Jakub Kicinski wrote:
> On Mon, 11 May 2026 00:06:50 +0800 Weiming Shi wrote:
> > > Barriers are between things. What are the release / acquire barriers
> > > synchronizing.  
> > 
> > The handler function pointer against the mode_priv state it operates
> > on.  On setup, init() writes mode_priv, then smp_store_release()
> > publishes the real handler - the paired smp_load_acquire() in the
> > reader ensures the handler sees that state.  On teardown,
> > smp_store_release() publishes the dummy before synchronize_net()
> > drains readers, so exit_op() won't tear down state under an
> > in-flight reader.
> 
> Still does not make sense to me. You already add sync_net().
> And if it's possible to switch from dummy to non-dummy mode
> the ordering is inverted.
> 
> > > Why is AF_PACKET relevant here??
> > >   
> > 
> > Not specific to the bug, just a reproducer detail.  Dropped.
> > 
> > Sending v3 with the updated changelog shortly.
> 
> Please don't rush new versions out.

Hi Jakub,

Apologies for the late reply and for rushing v3.

I was muddling two things. On teardown synchronize_net() is the protection,
the release/acquire is for the setup path where init() writes
mode_priv before team_adjust_ops() publishes the handler.

If that makes sense I'll send v4 with the corrected commit message.

Thanks,
Weiming Shi





