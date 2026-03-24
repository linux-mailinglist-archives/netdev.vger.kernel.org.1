Return-Path: <netdev+bounces-270896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICmRFow7wmmCagQAu9opvQ
	(envelope-from <netdev+bounces-270896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:21:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E9303E42
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E056318DF33
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645B3E9584;
	Tue, 24 Mar 2026 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzsvAMTt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F363DB636;
	Tue, 24 Mar 2026 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334918; cv=none; b=KCNNIHseJLMQ7oj2FGJsg8cpyHOJv24kAx04iYWAAUwWXYhHj5YwIGKI5MeqD64wEu66xdlrnv9AlW5IiCHPDILL8CxOWMRsY0NiW19wtZjZSVOnQPvYxLpQ7+bD6gIoXvcRaUhonOncroqUFrznBqEF8Wmevb5a+Dpehfspmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334918; c=relaxed/simple;
	bh=odvQZT5+RQNdWSOpTEVg/D+eh/9ZL9qJd+SCdaLEbWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grCpdFUkdIRbMLieMF74IePyKJh/v6SLLXNKVJ8DiTTE8XV8fvZxNwo4ye2AapVJCunYqsWZbrNgVsKszPaDWYiYbCzHRBoo0LEerdR302JTl0xObKeepINrea5OomnCJ1U9ZolxcRjTjzniLiWRgdEAv3pb416lEpdhduhODQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzsvAMTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE76C19424;
	Tue, 24 Mar 2026 06:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774334917;
	bh=odvQZT5+RQNdWSOpTEVg/D+eh/9ZL9qJd+SCdaLEbWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzsvAMTtHq02M8vTpvj4+z3C//6/rTk0CvNXkWZfWGgDXl+UthVLSfzAUgytZFmo0
	 xx/36ErRwBTVzMPxLlJPNLzKK0sMDldnKRHqOvVtgPzEP6E0UXd+ctxTVRcluCM6AX
	 KccT28tnAz3SJXQyWHQMPzr/AkTVjPVDKBgvspu+PuWH9vLKtaDcvoLQ6TFCSDpYUh
	 BtBLWc0iCQUX/C0uIv3FD/uCGQkz8fcuAZII5ng7U0tr/zRf//8jIJTvDljaR0UoKm
	 burhCtW/stTZv0rw+RxPXM1yGj39USxc2hvcmGvQFVh/wCL2yBS5gutEYnvsIdbaWT
	 OXs+ge+SE25Gg==
Date: Tue, 24 Mar 2026 14:48:33 +0800
From: Yixun Lan <dlan@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5] riscv: dts: spacemit: Add ethernet device for K3
Message-ID: <20260324064833-GKA736590@kernel.org>
References: <20260324063714.750428-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324063714.750428-1-inochiama@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270896-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,gentoo.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D56E9303E42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Inochi, 

On 14:37 Tue 24 Mar     , Inochi Amaoto wrote:
> Add all ethernet device nodes for K3 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Looks good to me, thanks
Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)

