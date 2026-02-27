Return-Path: <netdev+bounces-261680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOmuKvUBoWlVpQQAu9opvQ
	(envelope-from <netdev+bounces-261680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:31:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C49A1B20E3
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7000C300F582
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3E31DE2C9;
	Fri, 27 Feb 2026 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGHRCG76"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFB2D3231
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159475; cv=none; b=r+CRLej0+IbxV3VOUCCb7f7UQ125f64hKKFOwkP5JmE23sfNc4wIktFGMzWJ8RnBZEXIT/tMIOSTMQEWJ1AWFqJ+Gps0h4YexONts+Cf15KxKrzfmZW/ZuVhfTj8CAOMtt+LjHJckgq4Ib8ZRGTFwjkqOInrQ4eVdAPuecyMAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159475; c=relaxed/simple;
	bh=4JHlwT/Yu7ajcqtEUyhud7CE8o2J493+1Itcav9ilXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJEZAZrFeCBFLAjyIw+YVdaBmxQYpfmmMkvzlpAsfTOlcUd2H9fG79hqt5raQGfy9XDeBhfManHkrkFoMW/z809Y7rTyWh2sxDKpa8fypaGxqWohWCU5L8LVbXCeMCHbVNcU2SviZhkHA6GRaXRqrKlXhF7IB2HgFbMIM7JalDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGHRCG76; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70bb8ffb24so596707a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772159473; x=1772764273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QWTjg9cfCivxy21OkK4YMlplEZZRzQTGceSoJr86ceY=;
        b=dGHRCG76hRvK7Wrlw0HNSvnJ4sFueIKDAQKc511NJZMqyIgdfvBrzjm3RsAl8G9AyQ
         Pjv2Siu6wqTmSpWesahJBdshr2VzRQ4iWjAkPvh+OpB4Kzqq05bRBoP3YMUSNhg7WaQk
         Vjt5t9KpFZtFL5ee7noyv8xwyk2QCs4KWsLjJTxKqQLreKE0hJXby1H5DsbHgJavBPvS
         cfanH8W713uyQAKFCP1UxU86Am3N7FlAZ35wEKGseXwy/rKvRv4Cr8sKVnfGCsyVMTjR
         W4J90lKtlbkYLpzlUJNMywPOziQfK0aZLF2o5vDsj+LulSjLIAGZouM4lppUwhMEjW10
         nPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772159473; x=1772764273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWTjg9cfCivxy21OkK4YMlplEZZRzQTGceSoJr86ceY=;
        b=DSPpzxbpXCpAQrgntTFe5cmEFnXWaDFa8Vi+5n701G5vsM6/r1CrTyxI4zgjRCARc2
         nfDVMRJ+eZn4meCuwXI7VvTr0I2v4binlLCY7t3mZ4vEu/0R390SY2twVFobgbZ/jPbZ
         R4xcjzTYAbYWsiwq380pNODLdKr73A94Af9d23lsAKyj3vk8dIXgUSOF0Q9T+Ru/YocF
         BWbrQKJCX7hxnvtyXVlHd9FmvmtcdMWf2Q9d9otcjSGUCA1jz0XG7uuN5gS6A8JP7XEx
         qcRBEC+Z4xfm0brxOj+zblUIZv3yyg98SSZCdUhOP8FmhPKmoqgZmu7xNq25trNud91p
         0VUg==
X-Gm-Message-State: AOJu0YwLOifx6PC93vN3MV50QnAuc66HOJ0577z9Wg/n6Mt6JpHHRX58
	PDFJB8gcSusNF4ZFf6VoVGXQPq5eUm8j0B6CvKAxd7GVv/RO9j0XD6cA
X-Gm-Gg: ATEYQzxqovh6lQ4vM7C18HcifWBABTp2kfNfB6mOBsmFa+CXKKSytDC3vgHXLS9TX35
	p5k0e2c9FfZmo3xmUn1NiHyQ4K0hmydcL6JEV8jytng9U02W9JDSEA1+19/7a14x5Z//8g/jDu0
	NzYpAp2JLUYPFeUrNGH/GbNB26RF35rK6rdXpKdHIYzFh4QlMAvLYXXdFCb2daInzD806AmRXJq
	E1btoZj4S6hWZ2HUCqETbBsrvqEA5TG64sydYmAvDKrMGp73yOL6Q4gR61Nd1MAURNtioAG31j4
	1xBIcRFgfEMazwmrfxCPnS5Qqn25daPgcRlvUkz3vZIoE5qjHOJUahQC9X2pzJIndvg0Ye01p7p
	SL9nG0CNhaJUKme+7yp6p4C2ZQMMmBRcYn04NE2i8fhH4qs47LbVG9aM/9osCoOAnLe3FzVPYDR
	tAzNt1EzvtaX9JfzGQnkWZTRzYw/0=
X-Received: by 2002:a05:6a20:a12c:b0:38b:e68f:4648 with SMTP id adf61e73a8af0-395c39e0edfmr1273869637.14.1772159473315;
        Thu, 26 Feb 2026 18:31:13 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4abcsm2970390a12.5.2026.02.26.18.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 18:31:12 -0800 (PST)
Date: Fri, 27 Feb 2026 02:31:05 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net 1/3] bonding: set AD_RX_PORT_DISABLED when
 disabling a port
Message-ID: <aaEB6X6WPs7EBM33@fedora>
References: <20260226125331.28147-1-liuhangbin@gmail.com>
 <20260226125331.28147-2-liuhangbin@gmail.com>
 <942584.1772155015@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <942584.1772155015@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261680-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C49A1B20E3
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 05:16:55PM -0800, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >When disabling a port’s collecting and distributing states, updating only
> >rx_disabled is not sufficient. We also need to set AD_RX_PORT_DISABLED
> >so that the rx_machine transitions into the AD_RX_EXPIRED state.
> >
> >One example is in ad_agg_selection_logic(): when a new aggregator is
> >selected and old active aggregator is disabled, if AD_RX_PORT_DISABLED is
> >not set, the disabled port may remain stuck in AD_RX_CURRENT due to
> >continuing to receive partner LACP messages.
> 
> 	I'm not sure I'm seeing the problem here, is there an actual
> misbehavior being fixed here?  The port is receiving LACPDUs, and from
> the receive state machine point of view (Figure 6-18) there's no issue.
> The "port_enabled" variable (6.4.7) also informs the state machine
> behavior, but that's not the same as what's changed by bonding's
> __disable_port function.

Yes, the reason I do it here is we select another aggregator and called
__disable_port() for the old one. If we don't update sm_rx_state, the port
will be keep in collecting/distributing state, and the partner will also
keep in the c/d state.

Here we entered a logical paradox, on one hand we want to disable the port,
on the other hand we keep the port in collecting/distributing state.

> 
> 	Where I'm going with this is that, when multiple aggregator
> support was originally implemented, the theory was to keep aggregators
> other than the active agg in a state such that they could be put into
> service immediately, without having to do LACPDU exchanges in order to
> transition into the appropriate state.  A hot standby, basically,
> analogous to an active-backup mode backup interface with link state up.

This sounds good. But without LACPDU exchange, the hot standby actor and
partner should be in collecting/distributing state. What should we do when
partner start send packets to us?
> 
> 	I haven't tested this in some time, though, so my question is
> whether this change affects the failover time when an active aggregator
> is de-selected in favor of another aggregator.  By "failover time," I
> mean how long transmission and/or reception are interrupted when
> changing from one aggregator to another.  I presume that if aggregator
> failover ater this change requires LACPDU exchanges, etc, it will take
> longer to fail over.

I haven't tested it yet. I think the failover time should be in 1 second.
Let me do some testing today.

Thanks
Hangbin

