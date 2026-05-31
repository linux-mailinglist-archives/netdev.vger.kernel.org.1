Return-Path: <netdev+bounces-293461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO7zJMRnHGqDNgkAu9opvQ
	(envelope-from <netdev+bounces-293461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:54:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A75617338
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B2D301B93B
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52C1246BCD;
	Sun, 31 May 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOjK4ikv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E012233932
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246323; cv=none; b=nC3WqzcvKkW8yBvEH+Mta6SOqyzkfn5BEwT98jV6EJ722zkG5ct0UJHxZg5F6QY6sXIhXCSLaxFGkFerXF03yOoRNNsSkHfd7ekfRhs2NsgKHc4nJOhir8a/8TLWth+eFaYy0A6O9/DTkuOcs7W9SistiSxBo7O/eQLjkNXyfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246323; c=relaxed/simple;
	bh=ETJ17eBY5O93VTPEIBaSekNB8o8vlwmC6BJXVm/Q3wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWQ0ow2/Gf5cwK9F6zl/1MU8IGckkvhbQWSd88k1kFFag+Aplw81TLX4lcc3BvS56kYWYoGjk0dPyOvTSdEW8e2l6qnwi+9PU0aoAeWj3IHrCtGDxBXpDQ2zEH23mUtmU0vMXhM75uW6ie5QAC3v0v9pAr+vDDOmS0PQtHFActY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOjK4ikv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a7678b2dso4672835e9.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780246321; x=1780851121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLw6H5FaCb4ARPLWZKR31mPVJ2FOkbDT+EfN1ex2QpA=;
        b=KOjK4ikv5Yvic1aA1xdg0dHSaWX0xGZsXuc0EuPEn69f0uzOx63fEfXZaaymoycWzJ
         14BySwKEdqn3Fj7n7WNU8WFrN+Fk5NZB0DciaMcrVEoYPtEM1Y0Of7n4E9AlFZ8tEeg+
         afG2dW3fZcIxZbE+rfu4tXR7IVbyKGKUzUzktHCFK4oEY5t2kNrbU92udk7qFUzsl6kP
         hoEV3WORMkdhyjjYY/+muNGf4SHhg3bP+ZaIdwtNkxHenI321WUCaMedK0zKjmsSLoMQ
         kTdwlpkDIf4f0yn29S5BfS6l9eElqRS+6Wk+ICypnqbtGNyKGkFH3E1XhI7SuedU2IBg
         z9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780246321; x=1780851121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLw6H5FaCb4ARPLWZKR31mPVJ2FOkbDT+EfN1ex2QpA=;
        b=jDGo5d2JZQHLaBeOZf6MQhkcR6XmwAYTuOaNlLEx3wNMsq/GdYDmHGakU+WluRqEeR
         P0w6Na8ZvQNqBnHr3inGnis2KzmbtzWxZ8BswgYsOUwzLxfobCPCDlfWix3ibPYD12Fe
         5F5c2YWhSQw4ZyYv7GFBXIbaNs0cRic7MLqYubL8wOV5eylPLJpLNfD9CbrTc8ATBTOx
         sLskJ2HNIfnTtporAZbkKUhiWkw7FdjPgue2a3H/F2exbSn1hA1iUbHX8en4kwDibea7
         QTwKPBVd3ExGJDTQpKK0cRyJP+9c/O2lZ4T3iohBZ7Dqn12Y/MJPQN4AwbP+ghrIVLQm
         RoeQ==
X-Gm-Message-State: AOJu0YyyyxzdrNfEbNMT13vBQCGGXwjEPvDWQWsKjNsSrAlDRcCYMWZ8
	/TAMJDVACPqgrFMyjOoE/MQsXDud05zyT3e2oDAAKjgwas+wHWSbjtA9
X-Gm-Gg: Acq92OGc/7uxMPc9G1EkHvXC+hVQSz554cWXwST+Tq5dDszXEsTESD8VFxo2ycl9htd
	4NzAWf78pRICH1JIaj5uvvXVgsv7NjfclPovIogn4Q9oLvX8k5BaWXj4dPW6MD+r4rolYpqWHo6
	ErMi1JHs6UzMqOVR2AT0f9+T9Rva8PVWh5SX4ysAgJEJ7+QSIvTtXfY0m4HAmEuHRxMwHmxVlTz
	djad8xAqCk/XiRq0rwVUUBjAHi3jpOaMvhYtv0cwaQbiDtoBCVPJzXb5FQIf9cqqoq+lIaCY+gx
	hsFFh48KZTKdBSNgfvwsxMj8/eqLDnNsnrPG+/MC/qn/ekCokQ2nRga/ggPiPGAE2U3g+SKpWAT
	pZ5/lw0TWcd3zaJTGME9eJWq5l8113y1T+R/QeSPRL8DkzjiYNWyCc4aiBlP+2pklcORe7zCfRa
	xkpB73Uc03Dr4R0DMVoS06rcPErABZ1kz6ZMvV7RIJ3dqt
X-Received: by 2002:a05:600c:4e92:b0:490:8fd1:72a with SMTP id 5b1f17b1804b1-490a2900dacmr142037475e9.3.1780246320687;
        Sun, 31 May 2026 09:52:00 -0700 (PDT)
Received: from localhost.localdomain ([79.127.164.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c123406sm75965815e9.5.2026.05.31.09.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 09:51:59 -0700 (PDT)
Date: Sun, 31 May 2026 18:51:40 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] pcnet32: switch to napi_alloc_skb() and
 napi_gro_receive()
Message-ID: <20260531165140-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
 <20260525125437.4061-3-oscmaes92@gmail.com>
 <20260525084528.547fe263@kernel.org>
 <20260528142851-oscmaes92@gmail.com>
 <20260528080748.3e74355f@kernel.org>
 <20260528170510-oscmaes92@gmail.com>
 <20260528121210.40b0e493@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528121210.40b0e493@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293461-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 07A75617338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 12:12:10PM -0700, Jakub Kicinski wrote:
> On Thu, 28 May 2026 19:05:10 +0200 Oscar Maes wrote:
> > On Thu, May 28, 2026 at 08:07:48AM -0700, Jakub Kicinski wrote:
> > > On Thu, 28 May 2026 16:28:51 +0200 Oscar Maes wrote:  
> > > > On Mon, May 25, 2026 at 08:45:28AM -0700, Jakub Kicinski wrote:  
> > > > Intel x86  
> > > 
> > > LOL. Please. Which _hardware_ platform.
> > > Or to ask more directly - is it QEMU.  
> > 
> > It was indeed tested on QEMU.
> > Either way, the performance measurements were just a sanity check.
> > Changing the code to use the modern API is just better.
> 
> Please don't waste our time with optimizations to unused code.

It's not unused code. VMware emulates this device by default in some cases.
I've encountered it when installing QubesOS in vmware which is based on
relatively modern Linux.

