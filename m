Return-Path: <netdev+bounces-260690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AZCBD5FnmmlUQQAu9opvQ
	(envelope-from <netdev+bounces-260690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:41:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A43218E678
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 443AA302A7E5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427F3238C0B;
	Wed, 25 Feb 2026 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMh/g5ts"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1970186331;
	Wed, 25 Feb 2026 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771980091; cv=none; b=fhFrju35eNfRDEkirTKKbpFzEot6MmlqCX1fzrCDnzwPYZVAZUuyqX4ndcT5zzLb4rUO2c8OyPOHNIp5PP13fQNpG9KoHjJ6e5H2nG9KtrESTsxQdAeFr93VETBoiJq5I/FfWOMIDufBohvGyStlN49jx8JCh2zTNJGi3QboCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771980091; c=relaxed/simple;
	bh=vwe5dFFwMOFByTgQ83FcjP8a/Q/NhiVSAYipIkukHJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFOd8Gt0JbuWs4rWlG4ENlYGk5kk4ZwJbx3ZdlMiRx/ZHgbGGLufBNY8YIVsbS04gTmb4ADvcyGwTwuii/A+gEDDQ1VNYyw1Q3Lw+SI+oIisXEJRDr9X2EdFsKRfoit0Znj3hGl5mEq+8euLa250T2jWf/ERanhw8wmnnnK9ecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMh/g5ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8C5C19423;
	Wed, 25 Feb 2026 00:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771980090;
	bh=vwe5dFFwMOFByTgQ83FcjP8a/Q/NhiVSAYipIkukHJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TMh/g5ts77a7E+SB6ErJq+vIsOp8FHQAZCnPK93pTo/UjQCE+bF8Je/HOrsG9QLNJ
	 C7tTh0MMtdX2SBHp0R7l1keOR/ABBXCLphuwuJELRmyUdt9W5fNG+zzWCZ5r9Lyyq5
	 0MkiluIe2fJluD/PGmV4IjmlzXRVR5I4tQprDp+SBDFyKEgO/tOe03W0Q1TbgDYrBq
	 a5d7MBERlpfBcRFafaxdgX8kOxx0TePtyLyyRHH43OVGiVppTBK8RI2UjAALhH6Oz8
	 s3LkQpTk5kXxdNWezaIDEGmAHINz44USiYxvb7+UVMQPwC4tQPs0b2vumI+ss7wY3d
	 dy/rU46LYEecw==
Date: Tue, 24 Feb 2026 16:41:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: dsa: yt921x: Use u64_stats_t for
 MIB stats
Message-ID: <20260224164129.2ec3e309@kernel.org>
In-Reply-To: <20260224112411.1561917-4-mmyangfl@gmail.com>
References: <20260224112411.1561917-1-mmyangfl@gmail.com>
	<20260224112411.1561917-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260690-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A43218E678
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 19:24:07 +0800 David Yang wrote:
> 64-bit variables might not be atomic on 32-bit architectures, and could
> lead to load/store tearing. Use u64_stats_t to ensure consistency.

drivers/net/dsa/yt921x.c:791:15: warning: unused variable 'start' [-Wunused-variable]
  791 |         unsigned int start;
      |                      ^~~~~

