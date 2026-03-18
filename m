Return-Path: <netdev+bounces-268842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG/8ELn8uWnZQAIAu9opvQ
	(envelope-from <netdev+bounces-268842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:15:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D9F2B4DE9
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6858305DA4E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9CC22173D;
	Wed, 18 Mar 2026 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEUmSmkb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF3175A6F
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796531; cv=none; b=PlwQ24wTEPS4jB9UCjBq0K77zEe7ibYEVNiJuAdXfjkMwTLzBSa8tjbycRo4TxR28NCxnMsC3JMoM7fCNVPp7S/rKYQiZ8agPh9ExOnh6NCFV/sszJtiinRLd8IvyPeT3yqE/Dl/fU/3+OH+4+U5Dxjj8QJObTd+QUxXuptllfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796531; c=relaxed/simple;
	bh=hh57UKn9VSRdodC3JOjSt7y866f7q5fgZGr8SQQaUPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfY5ZCJ6Wrw2CmWFuzeCdbxGOwb5kKPZ32W6Ew4tQGqYXk6j/kH9ShY5x2clytXMANqf4uheY5RrpNLybOV6h2HSbbofU1Az7VqjH8GMmIIgWM0dpIgel6otyqidMyLC0cOCSTxmZf2G0DL59Mg71u3fRN4NdAb+Y31cad859TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEUmSmkb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab232cc803so30114855ad.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773796530; x=1774401330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSSXG9ti9V7P3y2+q+M4hK0U/NatY0Rkc8bPv7HEMJc=;
        b=XEUmSmkbY3Obe4Mfbw5x+yFTGKeLzg0ZI383V6J5qwFT27aEZQfhOfM4edSwOQat0q
         ZwjFf3ABchPlqsstT0nQZUqIPSW621sUwOJULR1e2swLcI/DcTzl6Ml809tekcV9jEL6
         547inq09NlwLZ1/wbiMMEuDacQB0kjBxLTfCbFjs+xFwTCEGHuwUApHTJ/A/B9bTXiox
         Bmh1NFLobZQJeHuwV3be9LmwTPplWYB2NUlVPzjrJkVOwwjtvnWk5f0y0Gj9V0gcVGUw
         T/6yg8Ki70wC3dNeVToIjE/4zNRxIiITnEnpg+OZ1oru/EqPqfA2bt8yiJjuB8zvtJQ/
         UcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773796530; x=1774401330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSSXG9ti9V7P3y2+q+M4hK0U/NatY0Rkc8bPv7HEMJc=;
        b=SUaSeetyiGLISYZCrphxKlOGD5MbeEg1CZiRl2XpMrHTVGYkj7LyzEQqUIcljo2/LU
         29KR2jKlIMHGVTU1tkMj/WIwbO1ltvK3l3TtHBvQyLGHK2/wOM+fXcL5gFKyfU8tvPGT
         NGtCl3Wq+LLekngrqCjSIA2fYDdu/Scoq/ut2hQxL+pVB3eFUPC5iLzpYFcB8zJzw7/5
         zBOeW0T1xff8raHQXTWZAUf0s5uRcu/U7CJ2sOp4+wvdJhUVz1HdxKIMAe1aLBygzxN8
         6ogCWf+KoqXUgGUGqDYwnan9NzbLokt75toI7gUSkr+7MY2XiZj0ZGuGmpwk3FfuXiTW
         LC9A==
X-Forwarded-Encrypted: i=1; AJvYcCUZO3n4Kcc7kWlJUpN7eeXBTQqKte0OW4MjZ+YvPYTJdHBLgaxrGCF7rBHp0/0aRHwlHCWQe3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywi/7B+Wkp2LnhUaO2OaUb+KDV1YK15RIjIlaIlZgKuTSkMk+j
	lUTJ+y51SMHG6SPxgoXwnAfw0jHr1TeJIfKE5Q8CjEJ9FVrSGt4UrDf6ZvquwT0/
X-Gm-Gg: ATEYQzxdAmN9Vf0qShkWUJpa6vki7NdmpXnOVRjkgsNuZTswKFiCoPJ6cVJuDDcQOJ8
	MwxGrXq5mMJOQ5bxG+dxlvB6UknsvV+UPaEQLd5IrId8D86Fb6kE8zwXWzK3Lba15aqhsD168zt
	838GT42aRbo/JFTtwHVnT0bGs5ybHavX6IPgLCFhTqArWhaK6z4vsBpwm/efRX4i8kn5+JSDLwd
	ehDIxnyi3uzLBzDN4dHTg/FGdK5rU9Eak3rVoQk621i0+Xhgna6ykLd+MyUKMzu3tRU0Oc3OtWD
	exnhtZCED6flat0k2KMHHQPPohSkc82S9Dw+B+z2OwAkTIgVM+hDLdn8O8il20/qCXg6GlWv8v1
	zdhN2VPkZw+E4W5pnxI9Y7wEKc3MnYb0vZo5l++v9e/rUb/qJrQZWyOGTXtfYDpGu3VuGFLhy1B
	3TC66LAU7AjjHrZGSgMy12p3Az6ukx8BDn9K+6xQ==
X-Received: by 2002:a17:902:ec87:b0:2ae:bf32:20c8 with SMTP id d9443c01a7336-2b06e39c5admr14882505ad.31.1773796530061;
        Tue, 17 Mar 2026 18:15:30 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e445075sm8904115ad.31.2026.03.17.18.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 18:15:29 -0700 (PDT)
Date: Wed, 18 Mar 2026 01:15:20 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/5] net: add ndo_update_offloads for offload
 computation
Message-ID: <abn8qFyE7pDuM4oN@fedora>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
 <20260316-offload_compute-v3-1-a5d4a07d86d3@gmail.com>
 <ablv266AIETvJwpP@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ablv266AIETvJwpP@krikkit>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268842-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2D9F2B4DE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:14:35PM +0100, Sabrina Dubroca wrote:
> 2026-03-16, 12:26:09 +0800, Hangbin Liu wrote:
> > Add a new ndo_update_offloads callback to net_device_ops that allows
> > devices to compute and update their offload features during feature
> > updates.
> > 
> > This callback enables master devices to recompute their features
> > based on current slave device configuration. This is particularly
> > useful for bonding, bridging, team, and failover devices that need
> > to aggregate features from their lower devices.
> > 
> > The callback is optional and only implemented by devices that need
> > dynamic offload feature computation.
> 
> Maybe a dumb idea (and sorry to suggest this quite late in your
> submissions): since all implementations of this callback are only
> calling netdev_compute_master_upper_features(), does this need to be a
> new ndo, or could this be some kind of flag within struct net_device

Ideally all dev with IFF_MASTER should re-compute the offload. But at present
some master devices do have this flag, or have their own offload
implementation.

Do you mean add a new private flag, like IFF_RECOMPUTE_OFFLOAD? For the second
parameter, maybe we can pass false for bridge specifically.

Thanks
Hangbin

> (2 flags since netdev_compute_master_upper_features takes a bool
> argument) that changes __netdev_update_features()'s behavior? Since
> the goal for the netdev_compute_master_upper_features() work was to
> make this code more common, not introducing a new ndo where random
> hacks can accumulate separately in each driver would maybe make more
> sense?
> 
> -- 
> Sabrina

