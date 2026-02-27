Return-Path: <netdev+bounces-261645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDfbAjHroGnynwQAu9opvQ
	(envelope-from <netdev+bounces-261645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:54:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 647BA1B1564
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93BF3058B94
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B8287508;
	Fri, 27 Feb 2026 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMBJobID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDEF28312D
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153586; cv=none; b=BlV2VD2wOWOisb2oPCJ8rW67m4jq6EcSbXqaGGPySjQJhZcTk4bTerHqx+BKZIUnuYGeIunDixt6FEYCtW5A4N6b5L2DDmyURFOmpYxsZftbL8uIcvpQo5QODGseacYBkQXH5Yzd6qFtNmaRdggWHLf9RS/vUWe23GTo4SeSX/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153586; c=relaxed/simple;
	bh=V58AsEXtDlXDbNdeDBd1zzEWI/NozXCvECRYKv0veUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhBrdlL9uKzO3942IkhwQDe5FT4Gj3E32KTI7QF2s1Pc8e8xwPjboGu6AecG0GiwHaXdnxOGDGW2CP27/IrtpIreVB8lPvqNBEM2GWVLHhWi1qfXs6TuIbY8ajPZPX5kztYC3Z6CMScckAj/wg9blbcfHxeAK8WgjpkMLCLLCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMBJobID; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a9296b3926so11929865ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772153583; x=1772758383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9gbpHB3N8fWBNDFn5ovPsYhngGHkPr0G2QGOAHfoIKs=;
        b=YMBJobIDBmh570RCF1WW+1QFR6izNsYPEATR801y2qMr0DFqBi8cu1OZQOqa+ViNnM
         J28EloQ+m8/8Tx93S3qPD3b0fdFfuSDAXdtPyLLYA354KRtoTMeWewnyE61lZYoFOg/y
         iX+COvhxI9VG0+AbSk40LQZXQDazOO+Eq+tpBuQrOlB2pn4VG2jExZF9iOj+tx32ldfg
         QfwK7yxxpkaAtEWzszcluFrM7eL+RTotwo6Jt7vAABxVwAsraLrwBdetHzWNWbWLFzAJ
         989HNfjN5I1nuOw8WspmHdMiWHr1dfz5B0JLseLeSUssJfs4zgHtl0KVjRW7be/CInvR
         lmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153583; x=1772758383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gbpHB3N8fWBNDFn5ovPsYhngGHkPr0G2QGOAHfoIKs=;
        b=IPmkJMQnGlaXr6zKgWq8aBKhb8ozQKwuQr+fvkiY4R2OXvswgZa2VVhZthluIyCrUf
         itcljTmvyyQlXrUYm980hxV/fhXkYIsAcWQ/p4Oj+f0fHv+O5dM3XvtxiatBYJ36Q6TA
         D+cyvv6g3JKZxiPS6Zb2/OX6SWsc2adNWfWl669OgTvE1LVHuPQIB8tWVOZGg/1b9Z+o
         JtSRQ3KanS0m7e1NojsaUzSnntDrowrg6JCzzX5hE/fbUBdXG0uFougvRZLKxTVuu2Ox
         IRY2Rrl9NLwQeLg4r+bR6yoV3xcrV94RFYMPu79Cam1YaV2/am1Hfoz7FKGk9LXXJNqM
         r3lA==
X-Gm-Message-State: AOJu0YwAahGxWOKaKX6TqWeLsrsC2nq1C5uaGWgp+APGtDseALDCnNcR
	ezVhtb1Z0F1v7rv/x6P9UQLtAA9VPt8bHzDC8tYtMd74SOTt9yJgctVXjDv2uSmmw7I=
X-Gm-Gg: ATEYQzxYwEusPv4/NnduGOcZgBj4QDxi+qM+UW9BFTuJQrxiKtcYVQwm20VUGqIm+YX
	MvS2aJtkm1gd14srp0kUEGQS4ZTZI38DMOGD6FVWT3auK4O7ycrjCrEqtlQdh6kAZNVnSf4QT8D
	alJANVo9PfZgSLcvSy4A80dPvjhkJyqpP3rv+ww4aqe/d462BGiE04fm912P6wkY5A72pvtF6y3
	P7xV5WxAkZhFeypsYtEmWsol+cF1et0sMqBJLgIppsWPeo3ad+fd5HzGa45+45Htrzk2kig2vnG
	/weYO6Di/S67mLYwNP5jAhuA0tVGECdCI1oF8KdP2hgO0h72NBfvZndMRacSj7IHDrKnIRbinl8
	we4CmQmzi+5c/3ARmGJxrT/RKTrFe+JCJaiQOpT1Xp3MWvrVTrFH0q8DqRZL+GAksS0bvwZapPB
	o/4mPm23zgpNMTehSM1jhqDZUWlQc=
X-Received: by 2002:a17:903:2312:b0:2a9:cb10:42b with SMTP id d9443c01a7336-2ae2e3f7cc2mr8443145ad.44.1772153582912;
        Thu, 26 Feb 2026 16:53:02 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22fesm51253065ad.2.2026.02.26.16.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 16:53:02 -0800 (PST)
Date: Fri, 27 Feb 2026 00:52:54 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCHv3 net 2/3] bonding: restructure ad_churn_machine
Message-ID: <aaDq5vTsk8SW4bIA@fedora>
References: <20260226125331.28147-1-liuhangbin@gmail.com>
 <20260226125331.28147-3-liuhangbin@gmail.com>
 <941081.1772152606@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <941081.1772152606@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261645-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 647BA1B1564
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 04:36:46PM -0800, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >The current ad_churn_machine implementation only transitions the
> >actor/partner churn state to churned or none after the churn timer expires.
> >However, IEEE 802.1AX-2014 specifies that a port should enter the none
> >state immediately once the actor’s port state enters synchronization.
> >
> >Another issue is that if the churn timer expires while the churn machine is
> >not in the monitor state (e.g. already in churn), the state may remain
> >stuck indefinitely with no further transitions. This becomes visible in
> >multi-aggregator scenarios. For example:
> >
> >Ports 1 and 2 are in aggregator 1 (active)
> >Ports 3 and 4 are in aggregator 2 (backup)
> >
> >Ports 1 and 2 should be in none
> >Ports 3 and 4 should be in churned
> >
> >If a failover occurs due to port 2 link down/up, aggregator 2 becomes active.
> >Under the current implementation, the resulting states may look like:
> >
> >agg 1 (backup): port 1 -> none, port 2 -> churned
> >agg 2 (active): ports 3,4 keep in churned.
> >
> >The root cause is that ad_churn_machine() only clears the
> >AD_PORT_CHURNED flag and starts a timer. When a churned port becomes active,
> >its RX state becomes AD_RX_CURRENT, preventing the churn flag from being set
> >again, leaving no way to retrigger the timer. Fixing this solely in
> >ad_rx_machine() is insufficient.
> >
> >This patch rewrites ad_churn_machine according to IEEE 802.1AX-2014
> >(Figures 6-23 and 6-24), ensuring correct churn detection, state transitions,
> >and timer behavior. With new implementation, there is no need to set
> >AD_PORT_CHURNED in ad_rx_machine().
> >
> >Fixes: 14c9551a32eb ("bonding: Implement port churn-machine (AD standard 43.4.17).")
> >Reported-by: Liang Li <liali@redhat.com>
> >Tested-by: Liang Li <liali@redhat.com>
> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> 	I missed this last time it was posted, but reading it now I
> think the functional change looks good, but I question the usefulness of
> including the 25 line ASCII art version of the state diagram.
> 
> 	The standard is publicly available, so a comment saying that the
> state machine logic conforms to IEEE 802.1AX-2014 figures 6-23 and 6-24
> should be sufficient.  Anyone seriously checking the code against the
> standard will need to read the relevant text, so they'll be looking it
> up anyway.

I added it here to help new readers and reviewers understand the logic
quickly. If you think there’s no need to include it in the code, maybe
we can move it to the commit description?

Thanks
Hangbin

