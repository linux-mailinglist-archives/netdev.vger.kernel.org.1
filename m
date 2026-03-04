Return-Path: <netdev+bounces-263483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFErASN4p2kchwAAu9opvQ
	(envelope-from <netdev+bounces-263483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:09:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3F61F8B9B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93CFB3080F17
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823EF191F91;
	Wed,  4 Mar 2026 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obiVGJyg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0481AF513;
	Wed,  4 Mar 2026 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582856; cv=none; b=NN/rpq2VnnVjuFMbqxkI6F2b+BDc5yDsxQnFhI0r3DItPaNdCuY6PLQKDcpqgReVNuhxHpiEgrACoK16knytyOlASx3ZnZa0PuOKXaHBlif/rGu/uGZ4IIyaJJG6khB4J7zmeIrpBnvCfeDcsqGsxLqPJULDxvCxFZjC76fVcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582856; c=relaxed/simple;
	bh=PH/bBb9YuapmtJ5CDJ4GuQpwu++vN76bDAchAeNUtx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKrNtQWTp/ZUwD+5vHwJmAnhq/7dvRsrjLtnpqdEnrTOU7n44DW6Cznq+BNStCqpwLYTnOtS4OiB/+G6uZtIFgJs4uensN0LLIrIiacC/Q64+TK/fUBp8uarUM1k+Ng2xeFmy4s0aE0T8FRbUz5N7nfcZ3XUEUL6HA/i46Ch5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obiVGJyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5646C116C6;
	Wed,  4 Mar 2026 00:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772582855;
	bh=PH/bBb9YuapmtJ5CDJ4GuQpwu++vN76bDAchAeNUtx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obiVGJygzjQJUQfowtzziDiq7mbpWNIJTS189cBFiXD17e5cciSoxwSoJ4ZlDClDm
	 zvbRsmVP0KRXq+/se93mr849ieVaHxAdOlvEv28uYZxs2kmzD3Rabj2+tkvVq2Wl7Q
	 ODTAJKslAPMUVLsxyxQ7Fv49kQaRRsTpCMbyHHk6nIl5EKI535A091A77UWFw49nUN
	 CHWx2u+51vxkoa/Huk0doTZ63Ikwdg6ES6huhfjMGolDo8EPw9yO8ye3nGdCt56cxG
	 03CqF/Sk1ye72HBWxUul/pyLCMgw2VoukUTmPyBBHYswh6/ndV5/90NCvmP4gYhwM6
	 Ipfzp3OCWlYqw==
Date: Tue, 3 Mar 2026 16:07:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 4/5] selftests: netdevsim: Add RSS indirection
 table resize test
Message-ID: <20260303160734.2cbe3c90@kernel.org>
In-Reply-To: <20260303181535.2671734-5-bjorn@kernel.org>
References: <20260303181535.2671734-1-bjorn@kernel.org>
	<20260303181535.2671734-5-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3C3F61F8B9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-263483-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue,  3 Mar 2026 19:15:32 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> Test fold/unfold of RSS indirection tables on channel changes
> using netdevsim:
>=20
>  - default table regenerates on channel change
>  - periodic table folds on shrink and unfolds on grow
>  - non-periodic table blocks channel reduction
>  - non-default RSS context resizes on channel change
>  - non-periodic non-default context blocks fold
>  - table and channel count unchanged after failed reduction

netdevsim-only tests are a thing of the past.
I should probably update our documentation to reflect that..

