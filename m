Return-Path: <netdev+bounces-258020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAs+JGufimniMQAAu9opvQ
	(envelope-from <netdev+bounces-258020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 04:00:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC474116A04
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 04:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7173302E913
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F5F6FC3;
	Tue, 10 Feb 2026 02:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="dSfbX1wm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130B3A1C9
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692321; cv=none; b=d9aEgFnxdeolWRtZKPaTiZ6O6tDk4ydoVAHIWf6l1Z7WILJlKI4/2KvzjAytRMQKTGJlxZmxVanrTlG8ah9v7CxtDZnQ/YChDKGABYewzy7UUdvpFUmrhxhW1Hbpew2Ko/zeqlzShv02X1Ml3rFKVPDsowWoAQRfv8WSgzr49yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692321; c=relaxed/simple;
	bh=wcNuawem38szn8pCJK0M8DrYPXH8yZr4GLi/D3UWPAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRy7k/BMTxFg3pquICyfonkdPWY1OsQRmBdJSAw0YvEvm2EhsMPl54TiJx3P15/oEbS9Izj8B8hUkzgDKaqF3Zz2m50qaZSuHDgXV8u2ImtF8WjZdEjbIaa2Mp7BEbIsf4kJ2/a7l6hh8fQAwfb1VarLiYTMBRi4RlLg+HX/wYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=dSfbX1wm; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so516207eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 18:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1770692319; x=1771297119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BdGlTwEli3lugkkGzY2UmQ9sP2pwEoB5g3RrPsU/xk=;
        b=dSfbX1wmo6ZG+RHcm4ZQYwVDNUnfByVc1mz//t0q5r6IdMPf5zwAJQ+WhECR7EC5xw
         FGs0X3OTARgPOcp1ODS893C8zKm+OQk7mPbRecnXllEu8x2frpogNJ4wJGxFEOU3ssHy
         Zzc5xmMqxWBFmS0/e6k7G8ZiDLsx37Sx3r6uZ2XLFwEYij73ydOoCGmzSbNSRUyr8Ns/
         dKndng1CQLuLdbOnLSOuGvPhfRn/Hm+wpB1+GoM0ji+MPuJDtEjmE1hRqxk5TvYpFMxt
         HdHdNI9zZyes0BR05zYUsn8KyfcUUiMg9mhQUphqjlxKDpZkU5mG5gHPYOhZKiHro0hQ
         nvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770692319; x=1771297119;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BdGlTwEli3lugkkGzY2UmQ9sP2pwEoB5g3RrPsU/xk=;
        b=LhN5debvXvkynVug4hST0hIPhVPqXKCKKmuD406KPXv42uezVhbIyipPC8QtC2wxUE
         Maw3uA+YqJxbSFdTxX0OlmkNuH75bVbtXIB6Wt3JrZHrcO9rIV2Zm52vSxQSFBENxu5j
         sid+w0afjz5gL5ahbDvK/rxlNO2jrcPe43g+A+53+Y86lf1w2MQ0S6reFA5WMJ580k38
         R7ihvNhyAjhX1Rm9TilZOhSkuc1SjFZknVbsqz0RKqV7tV2704+SJIn9ZBLA1Y84XOtV
         6bQLg1FrQSzweC54CCfP1gGjoottTLFSmy3OF/nQHUn7jJ1Ss7gOwTGqMHyGbTBDnL9c
         hgww==
X-Forwarded-Encrypted: i=1; AJvYcCU948nP+77LwR9P5Ye0Axdn3GpLRTU8T6kAYlOXIcTdZ1dqhwWfdQ2ZN3du+c+fVCJm29TZdZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9AOZCcvNcGaLNiIkdP5jR6noNUrqP1ihC+p/RDuoysVXGJyR
	OHIBIR/ubSLaJ/EkPBUwcVQ4wBSBrEt3wYHUZvX7vZiapcbN8vlCnjV7ysrvK8avsnc=
X-Gm-Gg: AZuq6aIXFHfegjN8GX5xxmeQSsi3OMLln1LZd8IpVN899e9Eji4chPrnRRQmY2o+vYp
	vgxqzHJ8sIqwL2UfLypS0pj6dbtG6j662RZcYLYWisj93nbj+QOZTvHM1wx2xdBHlJo1oYfbj0w
	VtQidhD77yg27J8dwRObCq4+3d/QlsBEc20jU5wjj/v/dA3aX35V0eR3AfouEnmSb1ZAHV9OLUr
	PHGHzlUcoZguW9LOI4vevCHeSNwHPXwW+KaRjTmudGpgfFBPg9NahAoQ0a1J9kjzVmsOwoxIQir
	IqhHl3h/Tr0v29ZlDdchQkuZEsHu+DNRRVfLyAxVVGBjDYdzJocIKJTfK1/JRey/UTIHzTX7WZe
	cGnIQd9bWH6LpT37jQ5A5ipKa9IczuUb4oFYCwFZoDaFNnp3WBSh0a5zPiw/fSYdqqq20gMFrdY
	dPSRbG1XIj2xrOm3wGfv91A5F3iMF4tXnUpYQX6Ps9LmRxqZFJEo/9GWAxKDzIqZx56K29GkXN1
	k0=
X-Received: by 2002:a05:7301:1f0d:b0:2a4:3593:466d with SMTP id 5a478bee46e88-2b85642ee82mr5949384eec.9.1770692319502;
        Mon, 09 Feb 2026 18:58:39 -0800 (PST)
Received: from MacBook-Air-2.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af7806sm8719678eec.10.2026.02.09.18.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:58:37 -0800 (PST)
Date: Mon, 9 Feb 2026 18:58:35 -0800
From: Joe Damato <joe@dama.to>
To: Thomas Gleixner <tglx@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org
Subject: Re: i40e: Fix preempt count leak in napi poll tracepoint
Message-ID: <aYqe20qJ9sKc30K3@MacBook-Air-2.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Thomas Gleixner <tglx@kernel.org>, intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org
References: <87v7g8zv2o.ffs@tglx>
 <aYpalNvTIiD4nym4@devvm20253.cco0.facebook.com>
 <87a4xhbk6a.ffs@tglx>
 <877bslbg2g.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bslbg2g.ffs@tglx>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258020-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,MacBook-Air-2.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC474116A04
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 01:25:11AM +0100, Thomas Gleixner wrote:
> On Mon, Feb 09 2026 at 23:56, Thomas Gleixner wrote:
> > On Mon, Feb 09 2026 at 14:07, Joe Damato wrote:
> >
> >> On Sat, Feb 07, 2026 at 11:50:23AM +0100, Thomas Gleixner wrote:
> >>> Using get_cpu() in the tracepoint assignment causes an obvious preempt
> >>> count leak because nothing invokes put_cpu() to undo it:
> >>> 
> >>>   softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?
> >>> 
> >>> This clearly has seen a lot of testing in the last 3+ years...
> >>
> >> I'm the author who introduced the bug. FWIW, I did use it quite a bit when I
> >> had i40e devices.
> >
> > Right, but always with PREEMPT_NONE and no debug option which would
> > enforce PREEMPT_COUNT ...
> 
> Forgot to mention that's what is required before submitting patches
> according to Documentation/process/submit-checklist.rst

This is a very helpful reply, thanks!

> But who cares about documentation aside of the people who write it?

I've written a lot of documentation, too, but sometimes people just make
mistakes.

- Joe

