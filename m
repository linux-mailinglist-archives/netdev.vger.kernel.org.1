Return-Path: <netdev+bounces-302362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HkKjBMtRQGoLewkAu9opvQ
	(envelope-from <netdev+bounces-302362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:42:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1A6D2C3E
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:42:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Rrt2w0Fu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302362-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302362-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F33DD3016838
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E0737DADD;
	Sat, 27 Jun 2026 22:42:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620973112BD;
	Sat, 27 Jun 2026 22:42:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600134; cv=none; b=M7mTaE7xdsk+yq6qo4gLd2Acb4Fvd9asEzkleK2VXd7+IyS33HpzrvW73nJAP7n6wuCsp9W2CJD7k7kIiNHSWpaaR0RfaFz3EHQ4D0Av08BMUR72keRNmxd4Sy5prUUCsVm2mSC8NWV3oTZLVmXfpqltwC0zNjaKPjORqVPFg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600134; c=relaxed/simple;
	bh=eCnQsGUFKlGLqmnsbUyFi5GKS0WYhvRrrIXshT/swyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZpkp5+uPKSd9byrPGbgepkP375MDITcOQ/fkWWfd1Wh8yrKcdTP645aE7VK9UF8LK7NAd5PQYEuoO6E6C7wzmQSfm191NTVTHF74mhBqKbfmL06txG0vELvS7RIuz2z68+qmEYQSgfDJuyacrd7J26rq5a1fF1SaGQy156VvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrt2w0Fu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C4F1F000E9;
	Sat, 27 Jun 2026 22:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600133;
	bh=+WU6Nm3UAzz1lJfTyKmC+aPncx0urnLp7yRTIpxGwaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rrt2w0Fuy1QK7DComCXc4aA8aWcrsQwNvb80io6wEuv07J+VXOt+quuloXHof1v1J
	 7uo/TFy8RLSMVmb4tstdowKJDkDEx/j6XuSV8uAflyAQzLmojgNgdGfW3mF4ASAMrJ
	 pQe/hsaQJ5ar4QgqoXbnDSO8cttSbqNMjGf5pzJrZ5ybpkNzNHIR0g9ZnCuu3ab+Fb
	 g1gzJ3v0JEYsW/I2liDGXVQrtwwrB7c45g5eWL/oPvXuFEC3nlBmnDSzpJzHMxGbvE
	 ddLWqTmyZfRH/PDR6Z7z4M/43jJ3y0EPLH5pk4J8FfiTzIuvs84GKf2Zo53LahuITU
	 gIZ2jlM4JLDCQ==
Date: Sat, 27 Jun 2026 15:42:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH v2 net-next] selftests/xsk: Preserve UMEM view in
 BIDIRECTIONAL test
Message-ID: <20260627154212.353d9b1a@kernel.org>
In-Reply-To: <20260625115215.1101928-1-maciej.fijalkowski@intel.com>
References: <20260625115215.1101928-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-302362-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:pabeni@redhat.com,m:horms@kernel.org,m:tushar.vyavahare@intel.com,m:kerneljasonxing@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77B1A6D2C3E

On Thu, 25 Jun 2026 13:52:15 +0200 Maciej Fijalkowski wrote:
> Subject: [PATCH v2 net-next] selftests/xsk: Preserve UMEM view in BIDIRECTIONAL test
> 
> Fixes: b17631032769 ("selftests/xsk: Move UMEM state from ifobject to xsk_socket_info")

Yup, doesn't apply, conflicts with the patches that went via net
but are now in both trees.
-- 
pw-bot: cr

