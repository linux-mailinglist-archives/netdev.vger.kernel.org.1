Return-Path: <netdev+bounces-277055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPHhFfzH12n6SwgAu9opvQ
	(envelope-from <netdev+bounces-277055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:38:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A903CCD68
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F65E30166ED
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB003DE428;
	Thu,  9 Apr 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPDQJn9z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1E3CB2FE
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749030; cv=none; b=rFKQOR5TjqLZilKVid+uAhf3UNc2Mhx6ZvJriN726sQYbPQ/1FYd9/mXMuC6S7K0FIeh/DtghF0Sn975TrDDsgD8pu8i6uB6UYsw0hbkJk4139WpWVsLfMMrbG4YvApp+lIqvaZbnduQ4GJ2SmERQzqVOLDsNpYdS2OAG0KZaC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749030; c=relaxed/simple;
	bh=QdbJoop8F6WUCHtK2jKo8EiZNDeMxXFVpx1o53KKEsM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TADXLdBhdobm5le3lXmDCrv9rfVUWCEPTVmxKJ2MgiHYFlAoxyb4tpFN8V68h+zXU/SqEprkKq8wYhf7LjtuXHTeQPYkr41/1JJ6MAfqzZcjfIwKTPVkgiPZRMHxkzIDMy8NjD3Gnfzhug5FNX88T1Yl9ddPZRpZw26cOofg01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPDQJn9z; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-4710c186d15so565986b6e.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775749028; x=1776353828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoUvb32JF6evSc4jt8i6LUGICotsiB1SCO2ERGQh4Ig=;
        b=VPDQJn9zVsgHUpY33xROmCCF4GW4lrnFtpu1mTEdPjy8iWigJhWbf0YwbrD5pjdpfH
         t85zSjmuqHN71kKQzjLsMRnfqH9ryIwrjzlLd2WRBIKh/mq555ZU0zLlVfGldHCNKfuv
         K1fcXBF9z/rYgg4EHw2SEUqEJhnEHSEpXz8yxmPBgL1Ujg1GPMIJRLT5HsWZ1xTKjzIu
         t3CgAN7YqTAfVV+C/6sRXSpFHWCmEN7mmOs8PafJwoKOgjBD19GI36QFwF4BU4AQoVI+
         2J/ptGqRSj5NjkzupVdP1vdbnG5DwX7FiDx/tIhiE2a/lT6ZE6GKL9bpAmB4nZmY8xOI
         7qrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749028; x=1776353828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoUvb32JF6evSc4jt8i6LUGICotsiB1SCO2ERGQh4Ig=;
        b=n1CQjiCVujvRdgrOoU5xnHl/I4cje3j9BIMDR7sgvs59gNYcP0s5/8VY4onszefwCD
         eqDhrovF9EzwRCuXP/U6SzDfLWrk0CjciKzQHLegTgLOTplQCJ6MpynWFJhPMQgSBChh
         gym1UCOyRhCHX1hBCZvxOj0TraWEdww2gnUbmUkkukBYPy1IIob59RZmWzMJHzvJxuhz
         PVrbEAbj+NTxwoDvsunJw9/b7uNxc+bFdlM+mWWoX0fcnezayIPVpLjr5QnbkItjAxmz
         LT9P1XitcBXrDf5a9KURuVw+wnpKNt2SK+dx0g0AMHH7OQICBUDML+MtCilElB9oXQVJ
         vPDg==
X-Forwarded-Encrypted: i=1; AJvYcCVXLfLzcifhZ0VYh5RS7f1uinh7JrzbzE4PJAT1fPdlhlKb5BLWyPBwVPMIYp6ft7XSRFkjsoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7wmwa0mCmdQcJFog/KErWx6UDJLossaei6mC8zMDRL0BaFJ/
	GYaTTzVwnP2I43tc7zHkdgl55iqadH8VciWJ9vfzXGaYwc1ipO7K3EgA
X-Gm-Gg: AeBDieuvsEl/p0a1svzBKQIsGxLdlgBxrdFLeHk02whRiQ+W9LluSNgwfvIEXpZNm1X
	DPzOPY0ahIe6o91/OxsrJ1if+pEhfb9cZtzmwD0nmpjA9ZO5EG6LiRxBjDC/xgBfK/Hs0g5L2qe
	BjB/EXLLp8qZVdDky46FB5kGUua2dEaD5bzIchoKX3mha1DcMsY1p7KzWGR2BQjE2JUBhU7BDvX
	+uOddUtpjCpg5zQrHFV6NT99tMPqsPalakfHtcI0oZTftm5gXruneYXaoTjSk6TA8Xn4L/yq1eL
	TTiFtq/BDIQpCte1/MK6lnWwqwVGTjBi1eQwEVcC0gIl88kSphPWBx/Ilili2f3am4IcUNVjZKm
	usOJdZnIibRf0z+R4tKEz6eBD2ODc9behb7WFLWftX8IHL1ojVXxPgcaSR9Xjtqj7fQL7NbQfvb
	MjlYjaD1+o9LtEg3s4pw==
X-Received: by 2002:a05:6808:1513:b0:467:1462:a9b3 with SMTP id 5614622812f47-46ef8217b05mr13237077b6e.38.1775749028389;
        Thu, 09 Apr 2026 08:37:08 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2660ef75sm59468a34.10.2026.04.09.08.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:37:07 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Thu, 9 Apr 2026 08:37:07 -0700
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] ethtool: strset: check nla_len overflow
Message-ID: <adfG99Pb-4QewoQ7@devvm17672.vll0.facebook.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
 <20260408-b4-ynl_ethtool-v2-5-7623a5e8f70b@gmail.com>
 <adaFjwkOrPoBgzoc@devvm17672.vll0.facebook.com>
 <20260408173943.2c239ae8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408173943.2c239ae8@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277055-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7A903CCD68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/08, Jakub Kicinski wrote:
> On Wed, 8 Apr 2026 09:43:35 -0700 Stanislav Fomichev wrote:
> > On 04/08, Hangbin Liu wrote:
> > > The netlink attribute length field nla_len is a __u16, which can only
> > > represent values up to 65535 bytes. NICs with a large number of
> > > statistics strings (e.g. mlx5_core with thousands of ETH_SS_STATS
> > > entries) can produce a ETHTOOL_A_STRINGSET_STRINGS nest that exceeds
> > > this limit.
> > > 
> > > When nla_nest_end() writes the actual nest size back to nla_len, the
> > > value is silently truncated. This results in a corrupted netlink message
> > > being sent to userspace: the parser reads a wrong (truncated) attribute
> > > length and misaligns all subsequent attribute boundaries, causing decode
> > > errors.
> > > 
> > > Fix this by using the new helper nla_nest_end_safe and error out if
> > > the size exceeds U16_MAX.  
> > 
> > Not sure that's the user supposed to do? Does it mean there is no way
> > to retrieve ETHTOOL_A_STRINGSET_STRINGS for those devices with too
> > many strings?
> 
> Not via Netlink, they can still read them via the ioctl?
> Since the legacy stats themselves can't be fetched over Netlink 
> I'm not sure we should lose sleep over reading the stats strings 
> via Netlink.

I guess... Should we update ethtool.yaml doc to tell the users to prefer
ioctl over netlink for strset-get and mention this new EMSGSIZE?

