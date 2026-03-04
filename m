Return-Path: <netdev+bounces-263512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDXRNH+Kp2nliAAAu9opvQ
	(envelope-from <netdev+bounces-263512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:27:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB1F1F936F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F793301F9BC
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091D2FA0C6;
	Wed,  4 Mar 2026 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlB/6TJb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF330648A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587606; cv=none; b=fFjp/Owt39ONl7OmXLPd58TVRhES3LnOXvUgNOnF2XPW2fLCixqS/Ox6TtfZ7afjMxrvo6tJIbuZ5TuD7eHmxx4Zr8YatUfusfapVMiOtyntHIskcxyNi7p8PyISjSQxarALC9djpEquXHk4yzNbMc44/kxGCZHttQNbXzawDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587606; c=relaxed/simple;
	bh=MKXffcBlhdsmLowCe0Cbj2NjLTgcMZg9V7RP83H1teI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAS2FV7pIJDLahfwD3BCvObSxxTKs/jOYQ52Qfhq0R2SaE+hn/snuezxgF957F3iprzagZn4mrquFXd7lgi0OjmPwyEFBlJ2MoXkANdL3nNhRF0ug/siDwEVIM9Y2I83o9Jd1PIkqnmgWKEdYesLH4GQobs7bGWWZgXVLbkGFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlB/6TJb; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35995cb33a8so1393504a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 17:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772587605; x=1773192405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TvL4T82lJ0Z3eFNaUzcI2Uhgdhk5xNvX1HDYLocZBk=;
        b=XlB/6TJbx7pAv7APjKuDD8+UQH1uV3/ACOinG+K7PAV6L1Y/WG0F0J8QQq4ZjsBPQ4
         Zw/CeJfp26CDdwTpn57Sq9D+O+XUo0uvGccHZuz6ToTlKpgE6FapLtBE9TevzWQglnyn
         j6J4v81UZChE9sKrt76CzezYNgbXVXvvJm84Dr6oXSY+XrEcybbqfcwr/HmQYIeDq2eA
         GpP2EC8pvlW1A4lnE56mCYUXrhAgRvbvS7s1FA53wi53zMWc7cTR9ovOkGvnHx7RArlf
         UsFy7x4hwjtyRVkVVFnx7i5u8J0hSytzcY/3V88VZDXDd7XYGrNRgV6bRMUf1+NLjNON
         PE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772587605; x=1773192405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TvL4T82lJ0Z3eFNaUzcI2Uhgdhk5xNvX1HDYLocZBk=;
        b=ePh+hTSAo0mhld5mrTc5tNh+pAeVMEZr7EcDe03FZPy8y673F7AaIVGPIKTBPOQJY5
         rz6yll0VNQGjrJrrY9MVF4BOD6D2Q51t+zZQkfV6o0bOGmfNHC7AdnDsr+z52/AJuUQs
         MYafmhuJGAM8qH4Wgky+2s6YNZLA1dptXG0sF4slUcrYxek/a7v2QqAtCvLOFZHdGOp0
         6pqFzT0Kx5qPJiYgBEQ+Tp8XvRHhDuV/F80t6uSBu+bHQD+ZtHWq+Ss9PLnZxFmOzlmq
         qkFFODDin29rlnWaiyJ1IX5vrXzG5q40iC56PkDfy6JetRIoWJIjLn9N33ty45mbbL+u
         66bg==
X-Forwarded-Encrypted: i=1; AJvYcCW3FvP6w3wN01m02sxYsxf0f/WH49tBLk0tW1EcvxaXyHJ31Ga9JcMw6nqpdwrmkpe9eOWsXzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynwESrxgqE/sp3vS0lun6JOhV5+NxgSJTDjFcT5VTavnVg82Nm
	bq8cf9toDmmUNbw2Y4mCnO52UJ2IzXPYU71JMbM2PkAm1rR0cKHvg3wV
X-Gm-Gg: ATEYQzx8qYGwBbcxFtTgm1vbuS7t3nLsr7b212hQc3i5sU7VD4UApcOm2bIGXvXt2WJ
	P0u6jqbpYPd2SxRABehAjuGJOTHPIeKyXQ0yP/zhGKHMCK+75XR6k+FbJvtyWtRaxjf74073MDJ
	oGsRhB0mCvBkoYfpiYbJLXeAK7Pu70n3Srly+6yTTQbUlkVHcVvpfgdY0iSaInIeq/7hHBus7dD
	IZ7Wbvk+JqHIRVNFrzwFaNonTKn73mdrV8+2rnWfD4jbYsXdZK1yVoQICOKmau6in5KCgeYAN6O
	BljZl8tn3uGLmm8GJUp6bLgs6X6tVVuT1ZBzpVwkHtk5qCcldx3yZKOSmKJVPdLNSCkK4RU5wzy
	lwR8MbPgSiZMoqev5D41KfQugGxnbVSqmgsUWn428EoiwtG5mlyjVUiF6f3Sewea/qZ1drNICvl
	R0CgCDXpz97LeIXpPeyxC+vkTCXnM=
X-Received: by 2002:a17:90b:48ce:b0:359:86f4:bc7a with SMTP id 98e67ed59e1d1-3599ce32c37mr3380587a91.5.1772587604950;
        Tue, 03 Mar 2026 17:26:44 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6bb5b2sm183907475ad.69.2026.03.03.17.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:26:44 -0800 (PST)
Date: Wed, 4 Mar 2026 01:26:38 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	matttbe@kernel.org, donald.hunter@gmail.com
Subject: Re: [PATCH net-next 0/4] tools: ynl: tests: adjust Makefile to mimic
 ksft
Message-ID: <aaeKTktO3Q1jiHSG@fedora>
References: <20260303163504.2084981-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303163504.2084981-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 7BB1F1F936F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263512-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:35:00AM -0800, Jakub Kicinski wrote:
> Make a few minor adjustments to tools/net/ynl/tests/Makefile
> to align its behavior more with how real kselftests behave.
> This series allows running the YNL tests in NIPA with little
> extra integration effort.
> 
> If anyone already integrated these tests into their CI minor
> adjustments to the integration may be needed (due to patch 2).
> 
> Jakub Kicinski (4):
>   tools: ynl: rename TESTS variable to TEST_PROGS
>   tools: ynl: don't install tests in /usr/bin/
>   tools: ynl: support INSTALL_PATH in the tests Makefile
>   tools: ynl: produce kselftest-list.txt from tests
> 
>  tools/net/ynl/tests/Makefile | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> -- 
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

