Return-Path: <netdev+bounces-275154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPQsFk/zz2mt1wYAu9opvQ
	(envelope-from <netdev+bounces-275154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:05:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A8396BEC
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64BEA3074F21
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DFA3CAE73;
	Fri,  3 Apr 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Ca+0lN8a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF74351C24
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775235743; cv=none; b=gGI2aU/VjeUA07xi3otjPNd8QOG1KGMy8Iz1HQTusj+uaD+JWgUQEdsYwDBm0Atpx7juykeXPM4llr/HKWMitQO4R+ecnw9a3qOS2+RnnwLV2/Ckbm8sFADKSG13FXsaL1ay28f2/H6CLnMvsdR/psDJutP6uHaucFTTS4qoMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775235743; c=relaxed/simple;
	bh=fjWWSKtr1jihoXzExgBgCJYTURbpDQDzI0eptamNsyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndzdZmWHveC8s/kxOyuXUchm9+VwcbAXwoVY1a7DTNOJvSXmbJ7O8WqP7H8m9izbs40ORE1AXiRFfNUh1H8LS5envjc+KpPQ109D5RuHMaujs8xZLwVJ7/xY74TFpxKNbVQgNJosOh6l9SAdN9i6C6mzIimbav44+bPzzSKsFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Ca+0lN8a; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a7539851fso945603b3a.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775235742; x=1775840542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9eHpYvA3tq0xgSZlAcNsaH335YcgPNXfqBqXXJlhfs=;
        b=Ca+0lN8aIKSPFBZ8zqARj058oGp7WNHqe1oP/UOPX5w/cP7Cr0p3Tt9s6a4UrMIemA
         HtlO/ctdmAXlvsR6G0Epgep0Dzjz46c2O9xiDfmBOeKtEmHBzPR5vTuigy0S+a1WepPd
         Wvr0QKILm4R8DC3N07wWkLJslQoN7Q5BTtIGUMlBGMwg+mSN+3RnvFhK72ilYMkjFXTu
         zaVOg0j654INcISzE3RnjcYfqNreARGlCDALKDnE+rOGMsdtozT4aEHcEkXPed5TyPnM
         JTZtfXilJM+g9Acyjh6m/83D8pAXOj1aW0i9Dj4wtdCtafDRwb78M00fn+cYKExooC88
         7kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775235742; x=1775840542;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9eHpYvA3tq0xgSZlAcNsaH335YcgPNXfqBqXXJlhfs=;
        b=eVbsAra+jd2apl6ukI1C8TxCbyJmUAdyj8oKMpZaHPNk6HqtYUX4zNlbVVog5aP+/D
         p+Za+dtzZuNF3tlOWrM+zPtN2ZU4q2aVRYOYNALmibjGvoxi/tuWCxmu0edayxibDQ8x
         o8LVwbGnh4hG73XiYLiq8Cbj9vDS0C2tQmlfCOaEyE3aeDdnb3OlCbnCUqtSj1GN/CF4
         +3OpKEF9UJt1bCj+Kjg1O7KVI3LP+rL/VG0Fz6ZDkGCvaY2vaT0ODbAYaDsKRwqQFlvW
         CUKb1SeyR560HBDx72KEyVLB6fAL7dLznaSUHp/Yf3smcek8bgw4WWSNLgRoFqxmNXK+
         jruA==
X-Gm-Message-State: AOJu0YwOWyu78XnmuQqYEeKnIBoIfzLErBnIy7iaLUBnmaMVBuFI4Mrj
	M9E6UVYBWVBLwfcFDtaleyetBKfvGY3LKmjMOHdoTypXywEPOdrtQWG9kbs78U+nMClUE4oFzaI
	cTAEc8hU=
X-Gm-Gg: AeBDietMwKuaoVAUVbOZ0j802TSKddlPGNUdeZ0+aq29k1YNM3F4uQ2KZ+4DOac1anO
	+9/8cUYDlhXYZP6ECLln32S5XAl4LjqXdnZxEyRi+NGrVBTV+GJa6xYqQH1hllOppnaXTEh/YbQ
	ljExOkUK3wOGP09E1AkkrVGQoaiTfpqRPf4D4ScrYGqL90LHfJBxB/ek42HzpRyTE09VOneRySE
	m/Z0YZ9CPmFguxzHY9SGyGO2s27oNx9ecqKLR1Rv2fv4xFXXsxWn+xzA+RZWcyserAlkaKRKZpu
	YfwBO+OB6itpofTvCpjRBC58WouyKyQ0rml3dk5FuVge5gKxUcJaVRvj8TCX4TBYkL8qyptxh6b
	lNCbEbKZ7YEVwK4qja/r74y2MBBWx9yDYdj6wbAlcfNvgBtI8UUp0CfkBThptT30P3vofhWkPOm
	nu44mEcOs/rL/3LPI=
X-Received: by 2002:a05:6a00:2d15:b0:82a:780f:a187 with SMTP id d2e1a72fcca58-82d0db6c414mr3532103b3a.36.1775235741468;
        Fri, 03 Apr 2026 10:02:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b76c0fsm5956785b3a.15.2026.04.03.10.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 10:02:21 -0700 (PDT)
Date: Fri, 3 Apr 2026 10:02:20 -0700
From: Joe Damato <joe@dama.to>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [net-next 2/3] selftests/net: Test PACKET_STATISTICS drops
Message-ID: <ac/ynCrKQj6SjsXP@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	willemb@google.com, linux-kselftest@vger.kernel.org
References: <20260402232203.2004496-1-joe@dama.to>
 <20260402232203.2004496-3-joe@dama.to>
 <willemdebruijn.kernel.886450145305@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.886450145305@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	TAGGED_FROM(0.00)[bounces-275154-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A59A8396BEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 11:26:01AM -0400, Willem de Bruijn wrote:

[...]

> > +
> > +	if (cfg_drop) {
> > +		check_packet_stats(fds);
> > +		goto out;
> > +	}
> 
> can this not use the check_packet_stats added in the previous patch
> right below?

IIRC: no it can't because when I tested this the do_rx hits the error path in
the drop case which makes sense because of the tiny receive buffer.

