Return-Path: <netdev+bounces-263988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLaXBl97qGmHuwAAu9opvQ
	(envelope-from <netdev+bounces-263988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:35:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7006E206715
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B0732ED3FE
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B533D75AE;
	Wed,  4 Mar 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7igiJLU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A93D75A7;
	Wed,  4 Mar 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648257; cv=none; b=lEc3wnLsbpkuyzNWLt9Y+dQ4NscwpnQLUu6EN1ARhVadU6Tqb29A0TZgwIYcqYpDrjdGJPHct7g5fF9CDPiKdqILmi1AD35BEwo/Xi4ytNgE5nEfF+Qk/oZoKZGBR/7UFy3NpBYCdghVp7lTDjI31H7PH1zlm4lvcD/kKQzOeII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648257; c=relaxed/simple;
	bh=9dyBZ5aCtMBIkcEwRcBVuwfowNsWWphrWBWKbim6R2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgyzloaCJDnjL8xBtJuFVppfD30yebIy+ND0uF4lNZ3eOJ1ymhqtEfA5DmJc7RIJqbpmarlcCnceNShESfn3iNLD2Of40On9rPbNdodx5HOCLkYK6HgIhvl6On07F7J61025gufNcGfSKitV5xhmmMmhbhf3IvF1mcfInL8R5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7igiJLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80784C4CEF7;
	Wed,  4 Mar 2026 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648257;
	bh=9dyBZ5aCtMBIkcEwRcBVuwfowNsWWphrWBWKbim6R2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l7igiJLUAMhc5GmhSG3HTFROQRaTif4Zw9BwBVKKt9k68jpgmQ52HgvM6TxIiJCYB
	 MKqscKdwIG0PA2+zr6+qk0BtMDVqgOXo9tgwFnkiVrU2QWYTYdCikY+VsKqq0Ws0a6
	 GIlRXQuVIPUj5wB8e7YKdKva2uCtkphJ3hDC2bBoEM+0Yk+S4xTMX203l+b68Egjka
	 rxspaHZYziPSpWxAtkDWKZ7Hpoj8yPIsiF4sYukgc/ZUd5JV1msg3qmhxSmSm2plSD
	 YhAwLupah4U39OS2iE0sAkyEu59r/yyvu30hJPMXokMCZhRbGm0HNeWVJr8p+2sD7/
	 /7DU4F6xlUmhw==
Date: Wed, 4 Mar 2026 10:17:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: edumazet@google.com, andrew+netdev@lunn.ch, ajit.khaparde@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, michael.chan@broadcom.com,
 linux-kernel@vger.kernel.org, vsrama-krishna.nemani@broadcom.com,
 davem@davemloft.net, netdev@vger.kernel.org,
 rajashekar.hudumula@broadcom.com, vikas.gupta@broadcom.com,
 pavan.chebbi@broadcom.com, rahul-rg.gupta@broadcom.com
Subject: Re: [net-next,v3,3/8] bng_en: add ethtool link settings, get_link,
 and nway_reset
Message-ID: <20260304101735.41b247eb@kernel.org>
In-Reply-To: <CANXQDtZZTmh1axG3AnM0WH4FgDh0b9Mm5JqdUd+41CqdMg7Zjg@mail.gmail.com>
References: <20260228072715.1632280-4-bhargava.marreddy@broadcom.com>
	<20260303030029.1884718-1-kuba@kernel.org>
	<CANXQDtZZTmh1axG3AnM0WH4FgDh0b9Mm5JqdUd+41CqdMg7Zjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7006E206715
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263988-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 16:07:09 +0530 Bhargava Chenna Marreddy wrote:
> The code was functionally safe, but I agree the inconsistency in the
> array patterns was not ideal.

Well TBH I think AI is being generous in how it phrases it's feedback.
Assuming an arbitrary value in an enum is and always will be the last
one is asking for bugs.

