Return-Path: <netdev+bounces-256551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABqINcbCgmkpaAMAu9opvQ
	(envelope-from <netdev+bounces-256551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:53:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A4E1662
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E48330C35B3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AA52D5419;
	Wed,  4 Feb 2026 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQxyYKu1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05F276049;
	Wed,  4 Feb 2026 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177220; cv=none; b=jC3v6v7T3Yjch3qnFuXmyRiD6mE8Gt/WUyxCQCNIWndCOOq2KY7e25ey+XLzNpIDTe6qhi7dvtCP5c/l5qeRKTWdTp5eTtEOmw2JH9QZMDpNQrW3L+fN7fKdHF8t/U6g1K5DNJdhPW+riKsd6C/3Nh9aTxy8b4WZiu2DlWdsfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177220; c=relaxed/simple;
	bh=UfRs511v7MaOyHm8KruW+g4+kqEQ4Ew3EFRIYH3G4lk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePVYMmC1RS9lRzVaWsM2/G6zhZvUT/Img/hIyE+5WfwwuHDMca5AKXJHB8T3yFXL+LOVgUXFxAzY3uTchsNBpNRuUTQSUEtoQhHPJQlW5XBg+//QByVsgxquU6II+mW6mDv+oqjPp03DzbqedHcvYXMcVJR+Z/lGnvz+u22COBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQxyYKu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB14DC4CEF7;
	Wed,  4 Feb 2026 03:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770177220;
	bh=UfRs511v7MaOyHm8KruW+g4+kqEQ4Ew3EFRIYH3G4lk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eQxyYKu11elnL80EqQiDBWMxVkVQI92+6gPoo/xYhWf+NAEq8noS+TDwUK+LvsUls
	 ll3K2UgxbFFk/HcPxT8j6Y5Ja3ep2YxeNGuLgYugtSX45Y99psXg5cLSRWMZsm6JjP
	 qcJ6XgvbLIt7FsGgwkfsI4znIWQ/JpPeRuywsE2b4k4+DppXw+LwbGwtzo63sgV1HO
	 UIYE7pEDb7RyBpB4KpdiVH/Zo4e3Rmeq0BQylBDuebSID4wjchdktfesgclQ3un8zw
	 T/31nmMFFYZon1tp71hE+s1xdCgs1us5JtwHhgvz91JjlydX0oIu/PDywkOovNuVIb
	 8QfNDqh13wAmA==
Date: Tue, 3 Feb 2026 19:53:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yohei Kojima <yk@y-koj.net>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: ethtool: clarify the bit-by-bit bitset
 format description
Message-ID: <20260203195338.1b1fa65a@kernel.org>
In-Reply-To: <e9ea0fe8bf7935d6439e4dc883414b685afbaf58.1770045398.git.yk@y-koj.net>
References: <e9ea0fe8bf7935d6439e4dc883414b685afbaf58.1770045398.git.yk@y-koj.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-256551-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 834A4E1662
X-Rspamd-Action: no action

On Tue,  3 Feb 2026 00:17:19 +0900 Yohei Kojima wrote:
> Clarify the format and semantics of the bit-by-bit bitset by the
> following changes:
> * Explicitly describe the mandatory and optional fields in one paragraph
> * Detail what happens if ETHTOOL_A_BITSET_NOMASK is set
> * Clarify that users can set both BIT_INDEX and BIT_NAME fields

To be honest I'm not entirely sure which doc is easier to follow,
before or after this patch :(
-- 
pw-bot: cr

