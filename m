Return-Path: <netdev+bounces-289771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBtaFkRRDWqgvwUAu9opvQ
	(envelope-from <netdev+bounces-289771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:14:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CE85880B1
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B51E33002A29
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CBC372ED0;
	Wed, 20 May 2026 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwNgBdWX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E32372662
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257658; cv=none; b=ml6/7ie5+KdCVRUT2fXA4MjjBVHhiTcu7HJpeXNw2XLVrdxdTY+TiKg+YgK7OtmFZCSxvFv9/uiwlF0fMNT2hDpshygwEwRnDqdHgqbqeWXsV3OLlfCaq8diFvoeel3qg7JUPnQX7+wCW2PsVciMVkHHI+v7djd52S+QtI+cAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257658; c=relaxed/simple;
	bh=M8qiunqkOgQWkAf3O82exmt0DGwWErUn3BZbkU3o/L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNVJSrT6pnFVJQQ4Dm106PALWf3n5nE/qJEX/gvWQZAitI0GYIooXLzriied6MjyziYhGSCmAFTmpX68JZK09C+s0lP85M1/gxf6WTE5pUBq2wlv5s0U5W/a6mXJl5Y7HfYMgJQNCR8vrtEsaTM0iaPcd6AbHOzDYwhPDS0usm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwNgBdWX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-369002b26f4so2310384a91.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779257656; x=1779862456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BbDIO2nNjsh71VERM5YNtwUxx3QhNEjyFxEw9Mfb5o=;
        b=QwNgBdWXZQYyD55vBG8Nev3qHYFW7dSUdmW7Im7EODMcOE57USOOgcVx/N+9W8Qga3
         zo53vVqQD0PIT+gwNCYfSOGCd6Q6QHj5GLgjnjAWXfD2Py2mGJjhJARktObOYlWj8obK
         YKncubevZN2TDQYL+xiblI0VXleNYl8+L3P9/9juvhbqgp1yzwT6EonvY0+YnStS9hkF
         Isj+Fc7BgWJFocbc+X0dkhaqapeTGb+uvK5yzAP0u2d5+WywSQbyweZb9ZFpqVoLNZmt
         Zqd/ypyKLT2j4dP+hEuu96J4xqZ2z5S9nz7bqOM/vaHNCT1okG2TzNHAFkhVyg+pRqMj
         mC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779257656; x=1779862456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BbDIO2nNjsh71VERM5YNtwUxx3QhNEjyFxEw9Mfb5o=;
        b=C0IiqW2uj4Sorbn2rlnV8HOynQf/WLBytddBwwmj9/herc6RAHKI9sRC4e9bpsVuou
         lgsgBIwwjfSd+3J3CumYtwx/luq8Tg2245ucj8KajaWXZcVAClfSK5xDzPJO1Cxzoj+z
         f9HJUeWgOEy4YMJhrK51VZISMY/HvxaSc3vNSAO7UPJIARN4tyS9F4kUyqhd1NHJnhvW
         xj1fIz41Q/SLBuZV9PKgK2HHASago8ZHg4XWhF1x2nCYGxE6FcDAte7rImVhk30HbqTc
         A2Cw+F655bsGiWyyUiC/PXkoagnvxuoKSFO9yoYU5WkX/NFnbU5I0+nBXzPFDy2ZOHFx
         e/vg==
X-Forwarded-Encrypted: i=1; AFNElJ+RE4JPj9z1o5MtAgfciKJPQU5azzoAumVCgSV0eC23eBjqrbxkdUvaFTpG4P940coyXFOgNzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx67lp1w3LBrMnVvqTZ3XZEn/S8lrQvv6GUZ2Q08EMkXYS4FBfm
	RPKAIncMDbPNRORXdIsEhFi29ULfEIVqLxajPnfjOdaM4aMVmXvcTTkY
X-Gm-Gg: Acq92OEUl1zSrtlVK1kY7MRZu3hQRiEU3/Wzw4xIB0M4IWiQUCN9uba7jf+geo0GsA3
	8TDhSbovluspRU4ZtX4L6AIIEDOTmYX3dXGCfOZfpHhzB2ZkDs4Z9HSOM2qCKjsW6hRRiZOCnpn
	7Ga2PKOwu8hnlj/VZnLEhEEuO3IBWzVdkW/zsYwAscLyzKJHtvsGLMafSMJiHN6yZ8p/FWA2jTw
	LQBxPt4j0KdZSJSUXv6IWSQPAucBVbgayhaoxwugvx8q8ePUxk/ozgXKMQeLQyUeJHuk8S3SB61
	L+couAXJduYYe/6ZYZuq8V3qApykFwoY7skbtiip1uQx37TUgwUrUCnTMNvJ5mWXE9HL3na6odu
	2+UdwzZ/zUI/gqkIDzOXrcrFt09q+h64wcxOrzJMuT8Mdbd3CZCpuI/9DRa7fus49Vo/rORJ27X
	DZirInd2Gmvn+SGR3f0IT1ZStDv9FW/nMS2vctehXW71CwRxgb+rdJhQQNdl7IIg==
X-Received: by 2002:a17:90b:48ca:b0:359:d54:846f with SMTP id 98e67ed59e1d1-369519c103emr21212757a91.7.1779257656282;
        Tue, 19 May 2026 23:14:16 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424b2sm16006801a91.3.2026.05.19.23.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:14:15 -0700 (PDT)
Date: Wed, 20 May 2026 14:14:10 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <ag1PTfcsbowK68g5@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
 <20260510082509.1530a1a3@kernel.org>
 <agCtGqWLK53TWCaS@Air.local>
 <20260510095937.598c27a6@kernel.org>
 <agrdjt6CjpJo3AYF@Air.local>
 <20260518142230.4403b3ce@kernel.org>
 <agwJNX-q0NmmrMpy@Air.local>
 <20260519162145.524da69e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519162145.524da69e@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289771-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Air.local:mid]
X-Rspamd-Queue-Id: A5CE85880B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-05-19 16:21, Jakub Kicinski wrote:
> On Tue, 19 May 2026 16:51:28 +0800 Weiming Shi wrote:
> > On 26-05-18 14:22, Jakub Kicinski wrote:
> > > On Mon, 18 May 2026 17:51:54 +0800 Weiming Shi wrote:  
> > > > On 26-05-10 09:59, Jakub Kicinski wrote:  
> > > > Apologies for the late reply and for rushing v3.
> > > > 
> > > > I was muddling two things. On teardown synchronize_net() is the protection,
> > > > the release/acquire is for the setup path where init() writes
> > > > mode_priv before team_adjust_ops() publishes the handler.
> > > > 
> > > > If that makes sense I'll send v4 with the corrected commit message.  
> > > 
> > > Can you provide more details for the init() path race?
> > > What's the sequence of events?  
> > 
> > With loadbalance mode:
> >  
> >   lb_init() stores select_tx_port_func (team_mode_loadbalance.c:595).
> >   When a port is later enabled, team_adjust_ops() publishes
> >   lb_transmit with a plain store (team_core.c:539).
> > 
> > Without the release/acquire, a concurrent team_xmit() on a weakly-ordered 
> > arch can see lb_transmit but not the select_tx_port_func store, and lb_transmit 
> > dereferences it at line 227.
> > 
> > I'll send a PoC in the next mail so you can reproduce it.
> 
> Not sure this is enough. But feel free to send the v3 if you prefer.
> 
> From looking at the repro it seems like you never add any ports?
> I suspect that the author of this code assumed that if there are 
> no ports there must be no traffic, so it's safe to be flipping the
> modes. I'd rather prevent the race than make it safe. Could we defer
> setting the real handler until after the first port is added?

The next version will drops the release/acquire and replaces memset/memcpy 
with per-field updates that skip transmit/receive entirely. They stay as dummies 
throughout mode change since team_adjust_ops() already handles them based on port count.
WRITE_ONCE/READ_ONCE for tearing, synchronize_net() before exit_op() to drain old readers.

Does that match what you had in mind, or would you prefer a different structure?

