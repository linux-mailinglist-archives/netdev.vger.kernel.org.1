Return-Path: <netdev+bounces-295828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ooRsMPXJImrddgEAu9opvQ
	(envelope-from <netdev+bounces-295828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 15:07:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D28648657
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 15:07:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=krC6lIYC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295828-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295828-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2760F305DEDA
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE273B1B3;
	Fri,  5 Jun 2026 12:54:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F93C768A
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 12:54:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664047; cv=none; b=Kn6B8k/6/Y5cfgHqVE8MkPXW9vI7LmBc9+7Bxipy/WnCgfqR9cEjH9WbUFlzvUOs+qOChiFQNKckHWrZy9+vRMciwQCpzEdeOQfdE64XfXb8o2Bzbq9Oy97CnGt2eX66kfq+ssnYqkA8DvU+PjTyD6dVLvaYtWFo3Z6MgqCpgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664047; c=relaxed/simple;
	bh=4BdkasZGBWmvzkcQMzObxj+iFSYJKYsxLTlK/a/FMVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L13oRt6oyUiZAMUJ9rA7mP7VUWAdXqFs93yudtrzUxkNAgBVQYUTConhGkt2gZ+XzjS9qMvduXCJa9In9zF0AjiCINCMhZebdqSi0udAUrXN8Sb50q6zcCMjfZJFTH0lc9Q/3E4vIcJ5I9HYqf6czLuzlqzEdMcb8HEYs5Ntkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krC6lIYC; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so10543835e9.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 05:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780664044; x=1781268844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ESsFWXNVrBZDPrJPvZQn7pIbZnaDRK4mOzY9lR1X5Y4=;
        b=krC6lIYCDmBYbqlBAiOXoHC70WWFbukC4Dkm+eYlhfALb7U7lFBHESdZBOaHOcLs8d
         zlA6g/NZkv18O4Ze/lPHM91YEX8Rs79PA4Lqt0/wEaqx4KxVUVm24IOFADneyjpU28/N
         ybMVqsqxq1Ecm8Nt8eZWKCpP2temVh9DUj0kT9Fp4/dw2m2lHI/Oin/dYGnLtKnYSFHb
         baNdZkyITSWhYjdZz3yc5L/Yd/aDhGA1qmFqe3AbR0YaXlEbSPa3iWdVWp6Zdw4SLVaf
         Z67JMu38pj/Fe6iqxQ5OEc2a5/ygtOzwbNaiFKHlCHFq/ZlPA3p5BgtskY7mF+Nr75x7
         rMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780664044; x=1781268844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESsFWXNVrBZDPrJPvZQn7pIbZnaDRK4mOzY9lR1X5Y4=;
        b=WUa6Uf/iMWYiu7H/uaYl7ntbpUS6X9J6xdSpWWNc0iRFlZgywtOKBj6na+aA/+5zUh
         ysIuCZ2XojAGuDG52mhacRkKSBNtCm0BjbPqtZFSyKg7PdNMmSZPW9fms6xKvhxXtIIJ
         vFTrYLWSjLL922VoT/wOuw1VzM1Gmo+vDMd0Sks7SO102E9W2F48YCV+qU4SrH+MRpLC
         1rqJzaBLWmIIInfUPEL6aOpmj5HMAz4Rpvw+4PI/5epWVqZ1LUms70p3zZVCf3cLin4m
         nwjnzii5r/Wj33yHyMSy6aKm/PqQWuRUGCfMrLRI+X3Ua/x1hQ5H2U3KFf841UtLXpHo
         PpQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tbHDKNNRSn9cbHUOazk5g8uPeKLQAURLheqhvOlkZqzYp2CMGY40b9+xEmiZIy4SP10DBvYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69VVQKqRybCIZdquR6gfW7dfladyEO57C1oYfxf979ORKMbIc
	oP5M3akoGnK4GmqLH6zRnySFIbQT6jq4mD91zE0OUaOfcZNNEzyEOhsv
X-Gm-Gg: Acq92OF8HGvwb2Ou+lfOnOsPX2ZNM8wBSmus/DYBTi6imBoMmikkMpS7bZFnlu8H49Z
	mqg7jQsC5bExXqWPMAk1xaQbkIIbybkYRPZ9VAbpEl/I84mtc9SwhpJ2gwwrCgMzQ5l+pHwKo2I
	gVq2otn5jvePkclgx2MReumV6GMTtWGy1oCYsZaTQJ5V7S2rA97kLR3BcTONlwJ5GEHe5B7z334
	kOE9MjpdQcwoEBmZF5V16gZCCp8VF1ksEwUpjtAhfOKnAP4v0nfqSWhbrbAn4uHBTZCREWtJPcN
	3Ba1tMGpGPmry0gGdun5Oqviybg/ZxDPn3DPO4IW/6svhPras/8Y2SnaSGoDnFmIO25M5i+kCvv
	tI8aPik1+66YvDDAM/hquw9CLcpmBF4SaK49/AHuWvOtDYULwAz1kO9KcPNn7xxvtB2pFZj8dGJ
	kSv0TzuuzRqFNarnMRwUt4ofns5ek23mfDfAG+oXwZALk=
X-Received: by 2002:a05:600c:190b:b0:490:be9e:fd03 with SMTP id 5b1f17b1804b1-490c2589a02mr52233325e9.7.1780664044371;
        Fri, 05 Jun 2026 05:54:04 -0700 (PDT)
Received: from cedric-laptop ([195.225.166.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d60a79sm27083045e9.2.2026.06.05.05.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:54:03 -0700 (PDT)
Date: Fri, 5 Jun 2026 14:53:57 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Luke Howard <lukeh@padl.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, 
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
Message-ID: <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:razor@blackwall.org,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[blackwall.org,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,nvidia.com,lunn.ch,gmail.com,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25D28648657

On Thu, Jun 04, 2026 at 03:39:25PM +1000, Luke Howard wrote:
> On 3 Jun 2026, at 5:35 pm, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> > So looking at how this is implemented, why not put most of it in TC?
> > It is testing for skb class, for tc qdisc, I don't see a reason for it
> > to be in the bridge at all. You can filter the mcast groups and simulate
> > the "reserved" flag, it has to be set manually anyway. Adding new
> > tests in the bridge software fast-path just for this is a waste.
> 
> This makes sense. Maybe it’s better to use flower+TCAM to implement this, and have our SRP daemon manage flower entries in addition to MDB entries. The mv88e6xxx driver’s TCAM support is recent (hi Cedric!) and does not yet appear to support the 6352 or matching on PCP/DA, but one presumes this is possible to add.
> 
> Alternatively, responding to your comments, the bridge could mark frames with a “stream reserved” DA with a new tc_skb_ext bit, which would be surfaced to flower similarly to l2_miss. The rest of the policy would live in the flower rule. MDB_FLAGS_STREAM_RESERVED would remain but IFLA_BRPORT_FILTER_STREAM_RESERVED could go (we would dynamically enable the equivalent in mv88e6xxx by refcounting MDB_FLAGS_STREAM_RESERVED entries).
> 

I don't know if this can be done in TC.
For the usecase of SRP the Marvell has bits in it's mac entries to specify is
an AVB entry. This looks vendor specific, and other vendors don't have it.
But the concept comes from the 802.1Q spec. The spec describes different types
of FDB entries. One of these is Dynamic Reservation Entries, which are created
from the Stream Reservation Protocol.
The issue here is the Marvell switch has an implementation where we need to
know if an entry is a Dynamic Reservation Entry. But the linux bridge has a
simplified version of the FDB described in 802.1Q.
By adding a way to distinguish between the type of FDB entries, it's possible
to program a Marvell which has this distinction between Dynamic Reservation
Entries (or AVB entries) and other entries.

Cedric


