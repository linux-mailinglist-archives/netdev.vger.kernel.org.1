Return-Path: <netdev+bounces-271318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKMEFwgFw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:41:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E33BE31CEDE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E28143065862
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2B635F5FB;
	Tue, 24 Mar 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbPVKDD0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4271A9FA0
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388486; cv=none; b=My2ZK/Vwsmwli+SE+WqoaH/yCsD/ZVUJWd+5EKy8v9wSNx+k+A1qHfZrUVsLlfTR8ohUwYrUKM35Xg7UQMMkt9gt6yvQjVG3WzhCF5DHA3Vu87Gb/1KX2C6q/Wk4Jg3ttccHZ1fS/JLgaBK3WrFG+RWtXXAw87sZj9LBaOQwk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388486; c=relaxed/simple;
	bh=JfiDoVAbrkEcy6+p8DsgzbKKCnCa9MZn4dtouLf63ks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMFJtyn8/u3S58Zm0VXQPgOwDPruPmvagPHBWCn2ACBVnXd6A24/RFYB4SyswZOelg1Jsj10n35VklTLD0yV2am+UpyS3HpuZsy+rL7LqwBgvXHfpc+8SuHcBVf527dCdzNoLQIFp8Db8BGIiWBcboDsK1zojT2sVEeYFu17AbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbPVKDD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BC8C2BC9E;
	Tue, 24 Mar 2026 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774388486;
	bh=JfiDoVAbrkEcy6+p8DsgzbKKCnCa9MZn4dtouLf63ks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZbPVKDD0x4aqfdjNivBo411CQjL2LQho7UM4wSDKmrjqgJWYI1LE3kJxwAtDxC/LV
	 +bfUgHL6eLYqm/fOru5fsHpiTNs8wUST+1rzkVO7P0SsH/WKMr7/8A2oLVA8xmZ+pg
	 Aj2phVr23VJt1i15rIIcW7GdWP7I7rvdDLr4kevNO8hEPm9FxKqs+5Cvnnt3bUvNBD
	 U2cdatyDQDA7pg0leWAjncaZAGC90nIA9Ojx6lxt0b+0bAG/Z/dAmT81jOOdEzIdc4
	 Df5lA5guqpecM2r+44ozxUc47ElIZOxRIB+4ioTo7VpqfstIj1KwJvgu1dX7wgx/Ea
	 VWHq2K1AKnLmQ==
Date: Tue, 24 Mar 2026 14:41:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 leon@kernel.org, Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: Re: [PATCH net-next v9 0/6] tls: Add TLS 1.3 hardware offload
 support
Message-ID: <20260324144124.311ef587@kernel.org>
In-Reply-To: <acK5_hW2dMKpWqdZ@krikkit>
References: <20260320235706.636531-1-rjethwani@purestorage.com>
	<acK5_hW2dMKpWqdZ@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271318-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,vger.kernel.org,nvidia.com,gmail.com,kernel.org,purestorage.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E33BE31CEDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 17:21:18 +0100 Sabrina Dubroca wrote:
> @maintainers sorry, I haven't had time to look at this revision
> yet. Can I get a bit more time?

sure thing! If it bubbles up to the top of review queue for me I may
review, but will wait for you with applying.

