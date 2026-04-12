Return-Path: <netdev+bounces-277819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCA8GcO722noFwkAu9opvQ
	(envelope-from <netdev+bounces-277819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:35:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C07713E4874
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9367B30073C4
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23E8F4A;
	Sun, 12 Apr 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVdxTwSD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9F40DFA7;
	Sun, 12 Apr 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776008126; cv=none; b=TGNHpV305hyFyrbsZOZURW9y4PNLefo2FmSKAgQ7HDzYEnRr/DdaIztZmwklLsvE1LJElX4O82JRssHeTK773ov5IYuzywPtXgoUF4a4CyULfqcxOymn/IU+cY6XFCG0BEVn9uMThrB3Kl1zUYa/BeYzlRVTLJvYKL+6ikRUNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776008126; c=relaxed/simple;
	bh=5YsvttyngPGYtQHRbR3CxIzo+j2kGqpaD2R2KW1/pB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgI6MxW3x4eRlTdMrfjA/EEGQa8ijcYnl4TVtoEPgfd+TqWHnGN+3HMJdKoqjIy6UOBWND20JFpWF4DfJuuA5aR4+eyX99f2lCDd12IRfuivuprnU0GMOniZit9lwAYpu0LfweTsYpVS0LsIC5xFzAUlbS5VgjFElR7rWOcO5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVdxTwSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDEAC19424;
	Sun, 12 Apr 2026 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776008126;
	bh=5YsvttyngPGYtQHRbR3CxIzo+j2kGqpaD2R2KW1/pB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mVdxTwSD9Wpl4ABfUV2s6te6KMgijk3kTCjJc1NOjpp809TpU6Hv/7oXUuFK3e4EX
	 K7TH88Tu40sMTj/eZaOaN4G0/dANM0LnlmEpDpXAKnGpex64+k0j/0bESTwRkQoaxs
	 EDZeFPtIZmI5K7As5vOyWMCtwYeC8O0fklsvvDfQh8VlG47/AkGEbiPqbtSpCJzvfY
	 djOxBUjdmvUZvX960T9sSMjLLSIevVqY4kV8p29K6bwn/mPNfyld5vWlClmhO9+2IU
	 OG14w9Zibknmb7BvZViZesy2MCdY9utRLipqOhE50WV8ibwUl4uH07UvxMaQgSwkUI
	 CuqciGtyUMGPg==
Date: Sun, 12 Apr 2026 08:35:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] NFC: digital: bound SENSF response copy into
 nfc_target
Message-ID: <20260412083525.7bf26414@kernel.org>
In-Reply-To: <20260407120004.4-nfc-sensf-v2-pengpeng@iscas.ac.cn>
References: <20260322031922.57949-1-pengpeng@iscas.ac.cn>
	<20260407120004.4-nfc-sensf-v2-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-277819-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C07713E4874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 7 Apr 2026 09:57:36 +0800 Pengpeng Hou wrote:
> digital_in_recv_sensf_res() copies the received SENSF response into
> struct nfc_target without bounding the copy to target.sensf_res. A full
> on-wire digital_sensf_res is 19 bytes long, while nfc_target stores 18
> bytes, so oversized or full-length frames can overwrite adjacent stack
> fields before digital_target_found() sees the target.
> 
> Reject payloads larger than struct digital_sensf_res and clamp the copy
> into target.sensf_res so valid 19-byte responses keep working while the
> fixed destination buffer stays bounded.

You need to solve the riddle why this driver thinks the response is 19
bytes but the core wants to store only 18...

> Fixes: 8c0695e4998dd268ff2a05951961247b7e015651 ("NFC Digital: Add NFC-F technology support")

nit: the hash in the Fixes tag should be only 12 chars
-- 
pw-bot: cr

