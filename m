Return-Path: <netdev+bounces-258614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMKHN6guj2nTLgEAu9opvQ
	(envelope-from <netdev+bounces-258614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:01:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B73D9136D84
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D8C307B7D5
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31631360751;
	Fri, 13 Feb 2026 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5OSF0fx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE21360757
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991207; cv=none; b=Nfzd47lLRje5XazcUaw+/i1+bwTtxg/mWENYoraTRWbg1jmnvK6e+PJvVfcAjlvFgtUTM1YuXhOPxpIBGysU1o1nYhcVl0qvD3RJvewxo5FnQG42zj8Te1Y4E2oS7c7QESZbooS9860tdsbkohsXVl1kF7fce6qzuInb6fgCyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991207; c=relaxed/simple;
	bh=UdIkoZqCT1hnLV6OWOhcQc+fWJ3rxg8Gk/wxOzlbato=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJYrT7PNawY0g+0TS/kRpYvFp4ADu4VGqUu8NUC+Xfl5fCYp7rG6xTQ/bAGW8XJRTKwV49dEEKWZYFXZibmdme627rgpWFJOBFHEmslys7rXA4/+F2T3iYF5aezioS71NGi0woMZxylpxAwRAx5Csgcir5nEs+/QytqjpVjNMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5OSF0fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23224C116C6;
	Fri, 13 Feb 2026 14:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770991206;
	bh=UdIkoZqCT1hnLV6OWOhcQc+fWJ3rxg8Gk/wxOzlbato=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5OSF0fxdYZ0Bk315wJjHy/n/RhcT7Qr3MNXQt9bsqKUBxw76p3hw8FcTD7UEeKPV
	 JhScSTjyNO0iCSOdX9+c81/N9rNIvZNeSHAHiX4QmlElz6/C77v8+DSyKK7hgkYbu7
	 0zS3YEu6LvjM10hf588WAx80kZkly1phpYsoHXiLPVypnbC7Rgzx+NxZGTifk+gxeD
	 zA5/6u1dUdAhIoqXpjI83MtzEnb38PIsTb6EW66DuFowGQ5LUUE586P5FYktJkaLBZ
	 1E9g2zYWSCT05vl21krkx/co68tTKLh8ZMbqwi6j0iwky4iro5x84Bd/q93ba+vvea
	 LD0FODnodTLSQ==
Date: Fri, 13 Feb 2026 14:00:02 +0000
From: Simon Horman <horms@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, fgont@si6networks.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net
Subject: Re: [PATCH net] ipv6: addrconf: reduce default temp_valid_lft to 2
 days
Message-ID: <aY8uYmy1adhPqqbm@horms.kernel.org>
References: <20260211202003.4550-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211202003.4550-1-fmancera@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258614-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[fmancera.suse.de:query timed out];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: B73D9136D84
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 09:20:03PM +0100, Fernando Fernandez Mancera wrote:
> This is a recommendation from RFC 8981 and it was intended to be changed
> by commit 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
> but it only changed the sysctl documentation.
> 
> Fixes: 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Simon Horman <horms@kernel.org>


