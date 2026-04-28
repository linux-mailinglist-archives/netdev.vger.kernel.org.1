Return-Path: <netdev+bounces-281907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLweLY6/8GnSYAEAu9opvQ
	(envelope-from <netdev+bounces-281907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:09:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321B48692F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE1163037E35
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBFF43E49D;
	Tue, 28 Apr 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEQYITIP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4143DA53;
	Tue, 28 Apr 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385235; cv=none; b=CVWNR2DNEh/RBvNVikA4cs39VsHdr7J/HAo2UWk9fqNP5/BoXlYj+GgI+9+TxhY/aPGQsIDgFFbXBUled7JCEeMjAJVCp0EG/YjrTNBvOEgwQh2rjipqsvLMxNukx/mNgbE0QKC/21zOvmbkgAEC75nMDgGVqAZaHJ9f4ul2shc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385235; c=relaxed/simple;
	bh=IwEdFjJyzelMlAa5vLL++KLwvh6z8xmj4ZZewfeb6SI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=by8wleojZ0OZ5i95iM9r3Q7kShqA0ZwAHnMvmLu3MGBFEDwtV8A1Lg4iFo+Cq3KAN8MoHqbxJBzi+Km40xabdyHueXOmb/S++b9ETFOlWQvYQaGP9kN6Vf//gufwtwEAXq2bHXoBXQFFt96JR3tSib8kGfiZPFgHZHT6luDMZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEQYITIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CDFC2BCAF;
	Tue, 28 Apr 2026 14:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777385234;
	bh=IwEdFjJyzelMlAa5vLL++KLwvh6z8xmj4ZZewfeb6SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rEQYITIPO8MlQObiRzhSdqrgzQ4JP1gpF/Wm9kdyeF4atQnkEiMl8jUWRbzvLFFIf
	 jxIonOksgZYr529AQW/ZJDfwjNH5+E/U2hOvEmU8c7An2T4FgKyFUuiTWtwCrSjl6l
	 TdEn3+5QfXA86H7WNhG7q0qmntb8T7NxZ2s+uY8vJB9fbicGAs02JXPB/lxa3ndQjJ
	 5VRVilIBMkobf3w66V8hXYNzgZzChC8E8E3unCTsXm2FPpHuQ7mYpZTjMHUCTi7q0X
	 dGhpz9BP/g1WBahTWPL8Dq0CqCnblOLvFEw2KIInZh1HQlwctyGO8kABn6NRKjxXWQ
	 n/u6ceMyVyrDQ==
Date: Tue, 28 Apr 2026 07:07:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/3] net: dsa: yt921x: Add port police
 support
Message-ID: <20260428070713.3747858b@kernel.org>
In-Reply-To: <20260428112606.1917230-4-mmyangfl@gmail.com>
References: <20260428112606.1917230-1-mmyangfl@gmail.com>
	<20260428112606.1917230-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6321B48692F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281907-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 19:26:03 +0800 David Yang wrote:
> +	if (burst_sug > burst)
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				      "Consider burst at least %llu to match rate %llu\n",
> +				      burst_sug, rate);

No new line chars in extact messages, please.
-- 
pw-bot: cr

