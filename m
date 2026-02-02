Return-Path: <netdev+bounces-255690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AswNJz6f2m90wIAu9opvQ
	(envelope-from <netdev+bounces-255690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 02:15:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D69C7BDE
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 02:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0753E300463E
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7211E5B7A;
	Mon,  2 Feb 2026 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBeRH6/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F418871F
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769994905; cv=none; b=B5KGbUdyGgz3V3v8xDH/BOAdqWdgAbDkkCcaUlHU7ldNdLAJhlRcNVWVX40o6zMxwD3l2LZX6moyYELbP9ALVxtY5s+NVTLJHjk6805qXOVf0jOP/6miqdPQN7nwh9AKu11fMyg7rDxz8oHh0GiJeVsS7cAYtVxTrC2j/OG7odM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769994905; c=relaxed/simple;
	bh=syzntiNe7cMdUYOVhT2KP31mPnru7JZE8PNdiV1OMh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmCcTUC6aq2p61qQmtqA2TObhb5leu0rqTmdgHs4JoEh/waoMa77EXqslg4Qo88aTIN/UGkNpMo3aMb5p/6LxIqEsqIGrP1v73owMf6ZIStcvfX+MxPikMrs64qH6Pp9lwbj0np8hSVlgUPJ8LsMAU6dM3H3pG/uT7/n0oyXG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBeRH6/n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a743050256so24354665ad.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 17:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769994903; x=1770599703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wuc/jGt1/k/NrtrWQcCBMsVvTpJg7wRrACpBUDrc7M0=;
        b=LBeRH6/nQgbjxFEdwr+45orN6IfDgjSOUi1mBUpJ4E3Ghxq6uzNkk9QXhcTFYf41N6
         R/zjBEnB8+zIq3Kffxk8HJJtZHQp1K5NQxNzdQ/MoQqvsEJl6P/wJ8tRIMlvDmlXfcqq
         jLAh/Qgb0w69Jasr4o9n9TEs5Ul6jAagAN8DQEw0oKWdSPjp7Yph3WmT5qs/fAQWiAb+
         dYmjS+YwfrN6ZPnOdUPTg6/4XTLG32clwOlOBnW2zitwJoskBU4CJOekuH3Cgqp1XCCy
         EX6fSn7ZUyzPcq379W8eUKwX5UZHrz84DCpnhDMDXo2Ik7pWnr0bYrT7ld8R9BxZuCOa
         bqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769994903; x=1770599703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wuc/jGt1/k/NrtrWQcCBMsVvTpJg7wRrACpBUDrc7M0=;
        b=RLGOxc8uaofkikFyAyrIqVnX1yNTcSlcKtpvd1Hn3g5kdWRCyGd7MDm4oW3YvByZqS
         dc2Z8aN0c7xsmpJiXK6yQ9RhujU3a2YUVoVaCAUE9b/4nuijvISyv1P/kLca0YWpt7sH
         5vFj7fmW3+xYjmZ4h/0K0ka0pe+o1ZP3JdBKoWpaQ1z/jYmAUxQNuS0fYYv+BK9IjbTV
         2WICTRHYZvp8V6r8jzMctTKLCZxgHOoCHwGZOrtsoq8oqjDe7dG7MXJBNQZ1Nvy1O8uG
         5SMmAu99ay8+FKcjQWJPzPaIrFgUA/Uc+5kybCe/OoeMDwOyhRsTKvGrR+soIhqDJ34p
         zPiw==
X-Forwarded-Encrypted: i=1; AJvYcCUN7eV3HleQoADRElU7EUFrSxybE8GH453WhapqEqkPQTRAuKVUDVly43mPiN6Ss6uaXPWq/mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+KhBiASrx622F+flXMkSMzjh+Ro7S7ZLXYu9/yPV0+fSqx2S
	Km42/u/ndZcBlkaNMmRSYqtiIWZ+7We3Pnc+ib/YiH/uHd1/g6arH91J
X-Gm-Gg: AZuq6aKwUBlSlXzmWFTUCAFD5gpBMXq9CzJ6/eMOcXvKXiAfSv9foHQUuX91CFmLW+k
	9THA42FC0j2C//pBe/gnAvjwHC7c4LmvtrnxQwylviusp0C2MeEYPhAb2OGzKY3oDi/NiXW0sVq
	n0f5LwEQcDjj54rDpL0k6argZLSTr54kdzEaxnMGJZOdb3LPFReM7vPe9Jyx1wfKPnkgA/0Rsyi
	4gCZ+dPOo2l9JzQFYaHfHz/ZGSaTE4hmx/B0by6lHg+9OOWiLXslAff5oXhwrDuT7n2lYgyel36
	jreMRDX6nac7k9T31ceWLOiDrFJHroUqtO1rvjJQCMDTVHzR+mBQQ9hMYW4gOwBgpLIx/M3Ivad
	EIj5+dR59P+0eKKO9gHqL86j7uJhGhGHV/meC+OcYQpfb1XkA6hwt3+jSivZBb8w7wU9P52qoDY
	ek6GjGiQOXOdpUQu4=
X-Received: by 2002:a17:902:db01:b0:2a0:d692:5681 with SMTP id d9443c01a7336-2a8d96df1b2mr94411485ad.24.1769994903033;
        Sun, 01 Feb 2026 17:15:03 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6427da8441sm11937631a12.9.2026.02.01.17.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 17:15:02 -0800 (PST)
Date: Mon, 2 Feb 2026 01:14:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 0/3] bonding: fix 802.3ad churn machine and
 port state issues
Message-ID: <aX_6jyAQaDoqsR3G@fedora>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114064921.57686-1-liuhangbin@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255690-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bond_lacp_prio.sh:url,bond_lacp_ad_select.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35D69C7BDE
X-Rspamd-Action: no action


Hi Jakub, Paolo,

Is there anything I should do for this patchset ?

Thanks
Hangbin
On Wed, Jan 14, 2026 at 06:49:18AM +0000, Hangbin Liu wrote:
> This series fixes two issues in the bonding 802.3ad implementation
> related to port state management and churn detection:
> 
> 1. When disabling a port, we need to set AD_RX_PORT_DISABLED to ensure
>    proper state machine transitions, preventing ports from getting stuck
>    in AD_RX_CURRENT state.
> 
> 2. The ad_churn_machine implementation is restructured to follow IEEE
>    802.1AX-2014 specifications correctly. The current implementation has
>    several issues: it doesn't transition to "none" state immediately when
>    synchronization is achieved, and can get stuck in churned state in
>    multi-aggregator scenarios.
> 
> 3. Selftests are enhanced to validate both mux state machine and churn
>    state logic under aggregator selection and failover scenarios.
> 
> These changes ensure proper LACP state machine behavior and fix issues
> where ports could remain in incorrect states during aggregator failover.
> 
> 
> v2:
>   * The changes are large and not urgent. Post to net-next as Paolo suggested
>   * set AD_RX_PORT_DISABLED only in ad_agg_selection_logic to avoid side effect. (Paolo Abeni)
>   * remove actor_churn as it can only be true when the state is ACTOR_CHURN (Paolo Abeni)
>   * remove AD_PORT_CHURNED since we don't need it anywhere (Paolo Abeni)
>   * I didn't add new helper for ad_churn_machine() as it looks not help much.
> 
> v1: https://lore.kernel.org/netdev/20251124043310.34073-1-liuhangbin@gmail.com
> 
> Hangbin Liu (3):
>   bonding: set AD_RX_PORT_DISABLED when disabling a port
>   bonding: restructure ad_churn_machine
>   selftests: bonding: add mux and churn state testing
> 
>  drivers/net/bonding/bond_3ad.c                | 97 ++++++++++++++-----
>  .../selftests/drivers/net/bonding/Makefile    |  2 +-
>  ...nd_lacp_prio.sh => bond_lacp_ad_select.sh} | 73 ++++++++++++++
>  3 files changed, 146 insertions(+), 26 deletions(-)
>  rename tools/testing/selftests/drivers/net/bonding/{bond_lacp_prio.sh => bond_lacp_ad_select.sh} (64%)
> 
> -- 
> 2.50.1
> 

