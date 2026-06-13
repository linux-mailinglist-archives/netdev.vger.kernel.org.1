Return-Path: <netdev+bounces-298949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zHaMB0c8LWrTeAQAu9opvQ
	(envelope-from <netdev+bounces-298949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:17:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D167E71C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:17:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rE+IFwC3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298949-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298949-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DC1B300D879
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688DD3DD859;
	Sat, 13 Jun 2026 11:16:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FFF37418C
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 11:16:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349389; cv=none; b=VdiDGGr4Mwf8zt/4NfHbnQiRQ2QcuaRdvsi1/elExY7DSPZC1FmDwYgqq6NRoZtYaFjDzI28hz+bQ/kMB42wq3T5DOJUQRbmbUJjf5PhyT7I+Y/K3nCQL+MAPQBKwIjT0w3RJ752oDQy0rNnZF9YIj3Ygs9N2Yz1OxwOvN0a/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349389; c=relaxed/simple;
	bh=mbelUA9ampyYa4CbvEWtyIDmWwuprT1EWZUBsr2YrII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkbXb8f8+oDoMQM8K49Z+nOSS68ykEA9CV3fnhrXcqX0JIbLg8HZWmRkVr+i8aMPGYc8gUhsIkB9C5q4Yeam8oJtTMpM2Mn3pgFCNFWjXRF1vRWN+dKNBZEIxXP1vJhJZgrFW475j2mojYS/v1Dk13qNQIUQRBscnFLYWv6P6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rE+IFwC3; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b613a17bso15406565e9.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781349386; x=1781954186; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8QOOlnMRvxmfl//EENHYWi6g2FxXLw74yKxLSW4RBeo=;
        b=rE+IFwC3UH2n62AIiMFZWOywsuncwFCz/gz5Gm/hTyPL/pLKD1A8Ki0/ap4h3XJJ0q
         4rL0gvoK7Gn4GUf8meWYHCnVSslDt5Et5cWBnpCAYzgofryWRL6tvQZvXE2KEz5NKz6p
         3eEeTAVJsDRQLZPTrDdAa060zWsKI4SsCvob1kVXzEKq5b/zvIL/SjvP3LIBaha64jdU
         fRCcVjnaZFmEUA7KFMP4wpeVHXYz7Pls6GcHVfBp1BxQS71zyg1eazvSjQCcsEIRCkhT
         Z5uLrtdLBvQujyFSfAYASwVML1HCOPdoCOBO4EFlEechM8EnD4JUpPkmxG58ZT4MY2bT
         ns6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781349386; x=1781954186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QOOlnMRvxmfl//EENHYWi6g2FxXLw74yKxLSW4RBeo=;
        b=G5XRifmpY3ptvKl0PBXS/Z6S4BzKDKMgUaU2gbIVECcmrPHOQ/rxCq9ZJ9V4G+jVoQ
         MCRmHePiGfWzB42gde6rQ5tkCKyfB0SvP9VYecG52gW+WaOEJ4+RJZRiwphhBNyc2CDC
         wxt1ccpbBZHyDd5ldR/T1gOjqFlf7dtfH36MBajzTvQf4Ja797NcUZTVaWQdjYOTbr0O
         idMmO/IVo7RGK2L/CSCK43vsYCHtCXR0QhL2WoHZhSEzJ56KGTDn+3scC2ltj50WqWpz
         ne3QnMFHYaUI1QNZO7AbYavfTe7RZfrGDVnxDg8FE/kpOkxTNWEfsIPP1xl+LldgbSjC
         DE7w==
X-Forwarded-Encrypted: i=1; AFNElJ9Zdj8X+7rpEyuD+N4/Yp/ciinXPoMF80vPnOVO8wHdMKeu/WJnIKdT1vTzw0ZephwkzBySNvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTU8YoNrpPBfnyNRgkdI4jxDnhiGwF9pfPJe1oT8tq7E/an94E
	6e/2GbuZYZGn/hkMO70Md1/43yVkg0qVcwE8/nN9kOKr41iuDsCGTopb
X-Gm-Gg: Acq92OGIjYhfOfSrxe82N397+IkKSkXDtqyGRVKBt+LlCTV+3xX1K1DDV/n5GZ25Jb8
	p2CvCm2bnW6m69+W+mFXbGXydH+zkLLZjB2+3QMRovKOp9SoAT4qmwvWSx8mQQrkErbwBx1NfRq
	jxLcCJpCtp8+wtVccju3ZIrrdfbCelt60dElO8xKN+IoNnoTmTVBS/l/9I1SI/85hiGLbVStWwS
	ms774w1tai4j4WwSin/Psmzs/132MyoMUlE3m4oDfM0yh9WhFVfYQ6CQpR9pYclwqO67r84rLsZ
	kC1GD6Z02preSVatgzB1ZI/yTkN94MaDbG6YTdRIFwBggzEgiQ9NBt+HByke5IuJBUp8fmbuBh0
	eUIZ1T860hXREbPK1l0psS4rrv7ct6YfFFgq3JLlXrzzQvbC1PaRM/UyhM7DTR04ozuBY9cTYcx
	mzamEUV9XTbdxr6QLk5l9zX/iDryXnEPSKj2gNl22NKuU+IsGpnbB3ARGkveOA7kNbv3XDXzPuk
	GUYN83pvKgIE5k5XEwsoCfd5oPcrloIooA=
X-Received: by 2002:a05:600c:3b15:b0:490:ec79:3077 with SMTP id 5b1f17b1804b1-490ec79315dmr96114205e9.16.1781349386167;
        Sat, 13 Jun 2026 04:16:26 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f38df00921b0efffe889e28.dip0.t-ipconnect.de. [2003:c1:4f38:df00:921b:eff:fe88:9e28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220207efesm59902115e9.0.2026.06.13.04.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 04:16:25 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id EF94431BC505; Sat, 13 Jun 2026 13:16:24 +0200 (CEST)
Date: Sat, 13 Jun 2026 13:16:24 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next v2 05/15] tcp: allow mptcp to drop TS for some
 packets
Message-ID: <ai08CJDkKzQIeCRK@gandalf.schnuecks.de>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
 <airt3_dPSfV54Aph@gandalf.schnuecks.de>
 <8d744049-65b7-4652-ae9f-a4a159fff56c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d744049-65b7-4652-ae9f-a4a159fff56c@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-298949-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,2003:c1:4f38:df00:921b:eff:fe88:9e28:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C7D167E71C

Hi Matt,

On Thu, Jun 11, 2026 at 09:40:23PM +0200, Matthieu Baerts wrote:
> Hi Simon,
> 
> Thank you for you review.
> 
> 11 Jun 2026 19:18:29 Simon Baatz <gmbnomis@gmail.com>:
> 
> > Hi Matt,
> >
> > On Fri, Jun 05, 2026 at 07:21:49PM +1000, Matthieu Baerts (NGI0) wrote:
> >> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> >> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> >> this case, it is then not possible to send the address signal.
> >>
> >> The idea is to let MPTCP dropping the TCP-timestamps option for some
> >> specific packets, to be able to send some specific pure ACK carrying >28
> >> bytes of MPTCP options, like with this specific ADD_ADDR. A new
> >> parameter is passed from tcp_established_options to the MPTCP side to
> >> indicate if the TCP TS option is used, and if it should be dropped. The
> >> next commit implements the part on MPTCP side, but split into two
> >> patches to help TCP maintainers to identify the modifications on TCP
> >> side. This feature will be controlled by a new add_addr_v6_port_drop_ts
> >> MPTCP sysctl knob.
> >>
> >> It is important to keep in mind that dropping the TCP timestamps option
> >> for one packet of the connection could eventually disrupt some
> >> middleboxes: even if it should be unlikely, they could drop the packet
> >> or even block the connection. That's why this new feature will be
> >> controlled by a sysctl knob.
> >
> > RFC 7323 (which obsoletes RFC 1323) specifies an "all or nothing"
> > approach for the TS option.  Section 3.2 states:
> >
> >    Once TSopt has been successfully negotiated, that is both <SYN> and
> >    <SYN,ACK> contain TSopt, the TSopt MUST be sent in every non-<RST>
> >    segment for the duration of the connection, [...] If a
> >    non-<RST> segment is received without a TSopt, a TCP SHOULD silently
> >    drop the segment.
> >
> > So, selectively omitting the TS option on established subflows
> > appears to go against RFC 7323 at the TCP level.  Do we consider that
> > an acceptable deviation for MPTCP subflows?
> 
> Yes, to me, it is acceptable. Please note that here, TCP TS is only
> dropped on some specific packets -- ADD_ADDR with v6 + port --
> which are TCP pure ACK acking the same sequence as the previous
> one (dupack from a TCP point of view). So it is just a signalling packet,
> specific to MPTCP. If it is dropped by a middlebox, that's not nice, but
> that's OK.
> 
> Or do you think something would break when this happens?

No, I just wanted to point out that an MPTCP peer with an underlying
TCP implementation that follows RFC 7323 strictly might drop these
packets (not only middleboxes).  But given your explanation, this
sounds more like "bad luck" than a real breakage.

Thanks for the clarification.

- Simon

-- 
Simon Baatz <gmbnomis@gmail.com>

