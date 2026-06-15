Return-Path: <netdev+bounces-299620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bAzQES1sMGqkSwUAu9opvQ
	(envelope-from <netdev+bounces-299620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:18:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E1D68A264
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:18:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b3J1KaSD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299620-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299620-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E075230DAFF5
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ACE39C015;
	Mon, 15 Jun 2026 21:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12903911CA;
	Mon, 15 Jun 2026 21:17:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558270; cv=none; b=Wo3yjfTlHodG9IQHx39uQtiDPlLAQT3DiTnm/AeH+RWJm68+tM2dJf2SrfqfTYafS+ycSSS3hgwVFMb9rUeyhdLYUhrGHkfY998YIkG+jrhj1GNZV2CFxFI/aEb6lBxl5tfwv9jqwVTzgUDoA4YeyJfMvM9RbVmNwcc+3e45aok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558270; c=relaxed/simple;
	bh=PGjHLy8gUmlEaxpU/sRE2uDEISa0evA0wO7LwE5fXQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wcn5fR4QsRRTB53T4RpM5UZM7vQCe3kBdf/gsBO02pvNeEITXAHSUEjHOqT5YtsaGsSfA69wlGTG84Bxy4XYV+MBKi7hPi0WhXmp6pBfeDxAFiubwv2zB2ZEuD1asFfuR1wpPdL8r6aqATGDevOR48pW6D+zwD/eD7kN9WW2xNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3J1KaSD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C4E1F000E9;
	Mon, 15 Jun 2026 21:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558269;
	bh=rq36+ejyps814ZAAfW2Em7q8ECHOQKpLtojfRHIy6lI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b3J1KaSDpnrBYOvPqLhpJjeMDS5IVi+4kOo2BFS/A0VjOSb4MMfY7Wu+aMYn+jcZG
	 Oo1y2AMoajz4nVmFAuU/bS+LG7QO8dt4X6WGHCJGtwvm0x5aRGaXt6XpASSZxZbSI9
	 R1N/CeJJzyHGxMb0VeX02AhkS+wZOU2INca1gdYCBG5g4sxdooz+U9T+mDUvS8tJwP
	 DNCT1xf08JjgZdo5mLnM2cM4BaNG39iIxTDeh3yfHJ9EW89XWGVSPvt4owFPSDVWUV
	 cpikwGtZsQG3pMpL+4LuKm34pUvIL6U0yXpPnaSEvTvhaPpqKtMSDyStCgEg6op/ZX
	 ii9B1Myy6NZwQ==
Date: Mon, 15 Jun 2026 14:17:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests/net/openvswitch: add ICMPv6 echo
 type match test
Message-ID: <20260615141748.17887b53@kernel.org>
In-Reply-To: <20260615090507.3647256-1-houminxi@gmail.com>
References: <20260613141429.3084962-1-houminxi@gmail.com>
	<20260615090507.3647256-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-299620-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07E1D68A264

On Mon, 15 Jun 2026 17:05:07 +0800 Minxi Hou wrote:
> Register OVS_KEY_ATTR_ICMPV6 in the flow key parser so that
> icmpv6(type=...) can be used in flow specifications. Without this
> registration the parser silently drops the token and the kernel
> rejects the flow with EINVAL because the expected ICMPv6 key
> attribute is missing.

net-next is closed
-- 
pw-bot: defer

