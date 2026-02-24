Return-Path: <netdev+bounces-260379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFusMJJanWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:00:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E11835B2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9888630440AF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076A83644BA;
	Tue, 24 Feb 2026 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDRoFjJ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0534BA24;
	Tue, 24 Feb 2026 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920008; cv=none; b=dCcR9vN4uERnMwHiDyf5+EaNnxEKWcXEkI/JOB7m3LS3GxeXSeZh1481yBzW0/ZnOVCcjdaOt8lMgFK/h/IfngV7gt5iSG98OiZ73rURZKP9jGVjWXarNwTPRhneZFqRgog2MiZt4MMOtW7qpy7vbIQMWNZqM5vH25OUTYJx9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920008; c=relaxed/simple;
	bh=sgme3bQ0nUoKfcm0X8HOtYXNAj8w6y8lQPgGsjjU5/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLJIXL3/gtwIyOFU0jLUUXpTH73AEKnPRdqYlimfxye9r92q++xd4zSZifJ0mDfBPzpeeB89QwJJ+0NO03jqN87sbSmgh3uJCtkun+Inm0CETYxdtqsDCVwOkxE8CESacDX3iOpjCZEMcS8upiVp0gnMD7YwF3ffQjhONaoCQjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDRoFjJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3549C116D0;
	Tue, 24 Feb 2026 08:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771920008;
	bh=sgme3bQ0nUoKfcm0X8HOtYXNAj8w6y8lQPgGsjjU5/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDRoFjJ7gxjhAUyYUItdUGy6Y/Oj2uidONpOGTLCqdxVLLHCpTm3kVzrMLs/pJQUN
	 e7ITrBIpxqaiXtHP+vHchj8MgIbNLwvUgH7TnISPHXzOReSQt6ZVUaGsVDr/Vl53cj
	 nckKs0Or1YgsahidqkeuNW+jL1davzXQvKsgj2nBjxwfafcLfd+fknoqStj7ZVFo2G
	 7/9LTwH3EUuNDu06l8oU1huWT5e0AS69BVpCAlIqCg5/B3mUqFCn4NoBGN5TmAqont
	 8mx6r7aQBakPxmGsPoNNqI650bab5bMpkJpxg6jQiNLfIYzjxvNjo4L5RlsRbI9n0I
	 o+bkx0LgY6Fyw==
Date: Tue, 24 Feb 2026 08:00:03 +0000
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net 2/2] selftests: net: Add bridge VLAN range grouping
 tests
Message-ID: <aZ1agwUGRt2Qqzv3@horms.kernel.org>
References: <20260222085338.3143823-1-danieller@nvidia.com>
 <20260222085338.3143823-3-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222085338.3143823-3-danieller@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260379-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bridge_vlan_dump.sh:url]
X-Rspamd-Queue-Id: 676E11835B2
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 10:53:38AM +0200, Danielle Ratson wrote:
> Add a new test file bridge_vlan_dump.sh with four test cases that verify
> VLANs with different per-VLAN options are not incorrectly grouped into
> ranges in the dump output.
> 
> The tests verify the kernel's br_vlan_opts_eq_range() function correctly
> prevents VLAN range grouping when neigh_suppress, mcast_max_groups,
> mcast_n_groups, or mcast_enabled options differ.
> 
> Each test verifies that VLANs with different option values appear as
> individual entries rather than ranges, and that VLANs with matching
> values are properly grouped together.
> 
> Example output:
> 
> $ ./bridge_vlan_dump.sh
> TEST: VLAN range grouping with neigh_suppress                       [ OK ]
> TEST: VLAN range grouping with mcast_max_groups                     [ OK ]
> TEST: VLAN range grouping with mcast_n_groups                       [ OK ]
> TEST: VLAN range grouping with mcast_enabled                        [ OK ]
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../testing/selftests/net/bridge_vlan_dump.sh | 203 ++++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100755 tools/testing/selftests/net/bridge_vlan_dump.sh

Hi Danielle,

I'm wondering if you could consider running running shellcheck over this
and cleaning  things up a little.

I see SC2086 which I think can be trivially addressed.
And SC2329, which I think would be best ignored using #shellcheck disable=SC2086

Thanks!

