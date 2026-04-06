Return-Path: <netdev+bounces-275645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Oy7E1Xf02lxngcAu9opvQ
	(envelope-from <netdev+bounces-275645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:29:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B06323A54CA
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7457A3004265
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C42D0614;
	Mon,  6 Apr 2026 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="t8q1C19V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408592F28E3
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492946; cv=none; b=YvPsuuaLHfM67Mw0PVVP2obiiDKLUFwj6WLpTaRlj4vYRuGD/ybrOeqOXml/xp00n7Ds+g/hV3qoFqOaPAaPKECEvn/Ufei50q4PB+E0CVq4xUaQsUYjXMSlW7YbSwl1Lq9remv3Qvi4h3yMmGd4FkDIN0I+U40LkMdX3RU3T3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492946; c=relaxed/simple;
	bh=iCvep39//9NLefQPV20ZhHbFZSdUVLuDQcuwC4G0bBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtzHH6VBaf3SAZQoWUfCRHcLEDdJSGxw5ZOjWmhDML8BhEdIvEqu0iYAGJaS1xH20Zd8GQpi1DbgkwKSKBSdLGo5Lmh/ot6quB4ewHultYpPnp+dkJTg4VXaarYxZcxpD4ISwjlg0vrvrO8ePqRHo2IwKQbPqBBQiXHW/sC0b3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=t8q1C19V; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82cf636dac8so1851967b3a.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775492945; x=1776097745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/wAT1jsHY9cPPblI6OsQOt14GLFZSNrLQJUq5KK/xg=;
        b=t8q1C19VqcPPn/WsCfArLYucAhGB+YreQwvmcIc9QE5z4K6V9WvaPRPjBmlee5X5ED
         qPc0Bw0UoGdFSIlsASmAQ77GxffkSyfZzYnnu3/VP/W9qI7OegKaKr2NegTVNquEy/5R
         zFgq8Hy8OFWGeIHm0SnVemKa7gB9ZPeP6rxzlgRKYHp8c65bppOD5uuBrRpSi945Vp2C
         tMfzVwKdcpPUSVhwtu40j9+jX1FW/Kok9+VIKu+qU7TMqt6/U4c4vMuwPL5i2QW1Hqtm
         1Fo1aOJKPNfhf6M/tp+pdgCrLT8lOl8a3I0mW9fM8WuJswAe8Aj/bkB3PE5rB/RuaFeu
         6Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775492945; x=1776097745;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/wAT1jsHY9cPPblI6OsQOt14GLFZSNrLQJUq5KK/xg=;
        b=TAINq0SnaPHVle2x1mfczVZEisZb42iVbpXtaTwu+uPIG/RzKchOAq7HhNNKx+IeJf
         bzNQwv5vflxPrZQna4YtPAN9FATCLS35A494v4TO/XsN3xC69rwvuZAKzbLKyMiRYP/x
         hsfzyMD/xqJfkgUlX5Iewtt8+i7IoIEiVVFvRwoqkNcfyw0UkVXUsLt2Q0HFT3FKZ9O7
         k5zkQ+RoQktKI8WPaiZehATgFniwJsJ6vpWeNqlhUgc3eP5SM/zgdjt3ixxo4FeKmTqW
         AFxTjv1X8pEnv1jUuOQByu5LBoy2QMRilY4TqlO+YjI7ZsE0JsLRROtK1DgYNDTlWxkA
         wyjA==
X-Gm-Message-State: AOJu0YzBTHw2HCwtIpVRNKtohdUeWWyrbjskOZp3QSRQU8DoKVUBqJw2
	GcFi0rOp2dkW7lgsoX8ue10IGMwaG3lwoAyb2dMH4qZtLoxznihMDBM8xFDajFfp2ww=
X-Gm-Gg: AeBDieu1zrrGskoz87zSKoTs4wN9LdGrWv7evmmZkUzm0OGM5Zp6PAvqFArABnRiXnp
	dxl90leNAKTmoAqOI+8r/99Mc9KD5pU6WRfAOjLcTrHx0+Xur1MusayjgBcnRAw5nYSYxSIrXvK
	57PbosY+JlRn9JrcgB9texCX9SqZd6Tb1EpmCGzT2+s3cL+dJm9AXuyLRQIH3WqsxP6viIIw94g
	ZJ7fcLFFIn+wO1/2s1vEHbN123PrIXNqzzt8gwv9/gLzZMKYoXMYLCgtI2aq9AJyIaXXZuL41X8
	Ykg+3kKJFia+2BI34P91iZDYRteGtrv4yIUdJSWudbkj8LJjIZQGBAijgGUqM0s1YdnEiJiZaQW
	iaDrXfPrbx9Bl/wvdshlJKPPB8QTmy5XBJ+bafivZ7vQ4OPCmE40fF/McWVH+vIEirvvjQVxai7
	EcLhYR
X-Received: by 2002:a05:6a00:3e12:b0:82c:7876:a03e with SMTP id d2e1a72fcca58-82d0da8f384mr12417654b3a.17.1775492944661;
        Mon, 06 Apr 2026 09:29:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d1d6b221csm8590318b3a.56.2026.04.06.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:29:04 -0700 (PDT)
Date: Mon, 6 Apr 2026 09:29:03 -0700
From: Joe Damato <joe@dama.to>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [net-next v2 2/3] selftests/net: Test PACKET_STATISTICS drops
Message-ID: <adPfTwbARPVFLys8@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	willemb@google.com, linux-kselftest@vger.kernel.org
References: <20260403233240.178948-1-joe@dama.to>
 <20260403233240.178948-3-joe@dama.to>
 <willemdebruijn.kernel.aa6e2a3e845d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.aa6e2a3e845d@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	TAGGED_FROM(0.00)[bounces-275645-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: B06323A54CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 11:08:15AM -0400, Willem de Bruijn wrote:
> Joe Damato wrote:

[...]

> > @@ -396,6 +424,11 @@ static void run_test(void)
> >  
> >  	total_len = do_tx();
> >  
> > +	if (cfg_drop) {
> > +		check_packet_stats(fds);
> > +		goto out;
> > +	}
> 
> Sashiko pointed out

In the future, please link to the AI report.

> that there may be a race here between rx
> processing in the softirq and check_packet_stats. Seems plausible.

Can you elaborate why this is true?

I could be wrong, but I scanned the code and __local_bh_enable_ip seems to run
softirq synchronously in this case, so I think the code is correct.

