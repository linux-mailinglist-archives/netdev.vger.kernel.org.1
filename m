Return-Path: <netdev+bounces-260457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF7aHJeDnWlsQQQAu9opvQ
	(envelope-from <netdev+bounces-260457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:55:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5262185B40
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6216330D87A8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5CD36EAA6;
	Tue, 24 Feb 2026 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIz5C4LV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E1378D91
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930469; cv=none; b=Fi5VqQsZL91DvZIsCHn5wf+Pptt7tX+HUnvn40SSjq5ZULvChaX+CrZFTaLiVhmEoENyINafSs3w2XQwyFYvcAQbahPN3eQRz4bRQpSexXPBjFBK7qx/NMitMj2icyS3QEQT7UtRpVHl/baBn8rIzTioJwKyzaCbT62yR+VMZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930469; c=relaxed/simple;
	bh=ggOBgUlgnDUGvS3o+o6A+b3bloz8IFdveaiD+S4suA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q02KUnc2qQdpQKgzU8v/JN9buAJ3u/7FvoRrsutYWO+YVG4zf0TtufIPrLcg/HKB79l+Ayr39fdPxw1sK8v8jZ8bD7cIuI/Z4NBAI1J9gQV+nlrtH9DwgCA6byeIUPi+qQgDAi2SHvCG3qGDCzqsAmg/C7V8b3hTTmixVatGdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIz5C4LV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84B4C2BC9E;
	Tue, 24 Feb 2026 10:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771930469;
	bh=ggOBgUlgnDUGvS3o+o6A+b3bloz8IFdveaiD+S4suA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIz5C4LVG6BNNgk6ws3S/eQUBL+KXKSN8kpN8xXZL73ywHLs9OoL01SsusySx3Wf/
	 bj9+eBSkoKEyHXTq39bEXsrkCvUMXuTUjGGfiSf3U40MbLKl67U2/v093OalMwP672
	 Ss+DAHZ5szwYwv5SWYzAXJuRn3GR1FGsZSkUQOGQkVPX8eEZiq0kEYh8uCAO2TYqPR
	 5DNgcfM4ulvZcrzdFNamU8JhU1vHdtCqJdKO9lNGOs2jsqB47JbRoWhiNTj6s0LH3X
	 UMUk9rADd7IERus0RzDIo7jXqwRX3cZ6HJHk1tsggjK5axGnCqGmw99IRrTvJUTHRL
	 Urv9gpjHa8crw==
Date: Tue, 24 Feb 2026 10:54:25 +0000
From: Simon Horman <horms@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	milena.olech@intel.com, willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch, vadim.fedorenko@linux.dev
Subject: Re: [PATCH v2 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
Message-ID: <aZ2DYSitNqQwkqCu@horms.kernel.org>
References: <20260222094110.127927-1-maciek@machnikowski.net>
 <20260222094110.127927-4-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222094110.127927-4-maciek@machnikowski.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,intel.com,lunn.ch,linux.dev];
	TAGGED_FROM(0.00)[bounces-260457-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ptp.sh:url,horms.kernel.org:mid]
X-Rspamd-Queue-Id: D5262185B40
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 10:41:10AM +0100, Maciek Machnikowski wrote:
> Add PTP synchronization test using ptp4l and netdevsim.
> 
> The test creates two netdevsim adapters, links them together
> and runs the ptp4l leader and ptp4l follower on two ends
> of the netdevsim link and waits for the follower to report the
> synchronized state (s2) in its output log.
> 
> This implementation runs the test runs over IPv4 link.
> 
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> ---
>  tools/testing/selftests/net/ptp.sh | 93 ++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100755 tools/testing/selftests/net/ptp.sh

Hi Maciek,

I'm wondering if you could consider running running shellcheck over this
and cleaning  things up a little.

I see SC2086 which I think can be trivially addressed.
And SC2329, which I think would be best ignored using #shellcheck disable=SC2329

Also, I think you need to add ptp.sh to tools/testing/selftests/net/Makefile

Thanks

