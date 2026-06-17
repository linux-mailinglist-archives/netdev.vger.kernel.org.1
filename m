Return-Path: <netdev+bounces-300186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ETDsMVKqMmqw3QUAu9opvQ
	(envelope-from <netdev+bounces-300186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5769A6B5
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:08:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=m3RVYOQZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300186-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300186-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E063320A483
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0445230C153;
	Wed, 17 Jun 2026 14:02:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4273425CEE
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 14:02:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704973; cv=none; b=g4vAnW8xst4YBL7IBoI5L6DIQ5Cx2Lg0JaZKGu1TlgG3g5NgE3DUw9kixkz482L3xKW1B2YWG4ixkFNftH6lNEMgfqcverdzinrNy0pN0NtJxFXIHIY75bTAMUSfUITw9eSixkJwFyKsBUkJAvMd2+i0+HW5sQFZ6C53pzVboSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704973; c=relaxed/simple;
	bh=+6XwXCxcdL4XG8HBGHkESHoVKQwE3MJ6bTGvlkv/L24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c24ObzBIg930dlHujvifTZLmxXvpxb8j/XOH/5WpWJLs5QOzqxLEcIEQBXmxWnK5Xo4nFrub9kzwrMcfIK67EUJRKK1fIQl1goS83NpTyamhcrMGY6WYIRHjwzG+yYqPK8VEEy7bOHCizaaK89KzV1ex0afiBC2XFl8isYzxuD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3RVYOQZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BE61F000E9;
	Wed, 17 Jun 2026 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781704972;
	bh=kPNqD+T3iRSriXn9LX09fTW2rqHtaNypWCtMdCA+UMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m3RVYOQZ77bCrremqYoGfcAgBeoI/CL2rojN0F30fLnJXaAJ0Tlva8cI1+iui4z8+
	 P576Cx63mIJZrw7OPy57StQuNksZ4H+mljUuYfA9Jrnq7jjiNVxWv+Xmxye39sni+v
	 z86mat1O/M3VrY2nyyJA7nly3UuEQ27ZKuYwo3quRQROPxFDAELMhf4BYpunB4tQQs
	 LPTYR1XKvyd/aV+SMWG+VPM9AMqyOqOOpiftPmEpXd6OhXD6SurlDL6rGXhhpPf9pw
	 LPaeZ5d+RBo7EG8bTnP8MLqQfBbGBwrVfMCY95rbAxVk++nzpfLh3XmOhzJ8YVlaBV
	 qAndyiCmy6iww==
Date: Wed, 17 Jun 2026 15:02:48 +0100
From: Simon Horman <horms@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net 0/2] devlink: Fix a couple parent ref leaks
Message-ID: <20260617140248.GE827683@horms.kernel.org>
References: <20260616110633.1449432-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616110633.1449432-1-cratiu@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300186-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cratiu@nvidia.com,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michal.wilczynski@intel.com,m:cjubran@nvidia.com,m:mbloch@nvidia.com,m:tariqt@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43A5769A6B5

On Tue, Jun 16, 2026 at 02:06:31PM +0300, Cosmin Ratiu wrote:
> These two patches fix parent ref leaks on errors.
> 
> Cosmin Ratiu (2):
>   devlink: Fix parent ref leak in devl_rate_node_create()
>   devlink: Fix parent ref leak on tc-bw failure

Thanks Cosmin,

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


