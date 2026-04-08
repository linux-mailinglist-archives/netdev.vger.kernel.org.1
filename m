Return-Path: <netdev+bounces-276639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOFWJv6F1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:44:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E85213BF06B
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF5283060ACE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8380538CFF4;
	Wed,  8 Apr 2026 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk/M92cc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE5219EB
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666290; cv=none; b=Pl69hPiIsPeFsOL8m7r9Tx/g9IdLvh+FqCXC2K76tUxoqjDKdKfox1hivbY4pk9IvSfrwKn6AVwgxOSSAQvhn/FCyUEJMOPvDBQdy6Xe0D5O/VqbBwkTNC7rS2XftI8J9Uwu+zdUSp1cK+XlC7krIiT1PMw1IY/Qvq93ABhjQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666290; c=relaxed/simple;
	bh=UZpjk2rwv9DrzgTipg4R54x9Lq6ioklw97lvibJFFrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANUDi4n7NsXuPn9vUXF0ZCMDXygVwC+semNHJBpvKGIk9L6FoYfJOAYzPG76fbqbWBUXURASQIzKZoEKAqEgrGNJWKOwsHfWATp1alefbaj2WvNM6XI0OJvx55Am4wGU3l1ViXnRqJ3hOV5xQfaM8ufaZzrcehQ1W51WtTcF1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk/M92cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC41DC19421;
	Wed,  8 Apr 2026 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775666290;
	bh=UZpjk2rwv9DrzgTipg4R54x9Lq6ioklw97lvibJFFrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gk/M92cchNVbZaHOMZRkdnKswZBHAhTEE4VGolz3HV7DYvKQfR1MjMcZg0Trvl3am
	 vlpybo294ZhZPfBAdx/MexQ6/D+CGPfPyubJQkVmwsy/HMfutVo6mhBU8zzo/sT155
	 7oBtiSrd/jGW9fA7tHJOvi/GsaSv6IiB1mgccs/yp5eBSkgcYG5Fn3ujM4a3soxeJ8
	 Hx0ZxzmMsjD40yuB0pE06YRxVsq7vfqsjGlJsHQqpbdm2Kyx9i6dfgPFDRePUpjL+Q
	 St81VZ/u/90tbWTD0rWqnUCxEH5KQVHt9AClYPWiz9+fsQNwD5RILqHAMo+RYRr6mP
	 +rbBPmKSdvTPA==
Date: Wed, 8 Apr 2026 09:38:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net
Subject: Re: [PATCH net-next v2 2/2] selftests: net: add ECMP rehash test
Message-ID: <20260408093808.49d2b183@kernel.org>
In-Reply-To: <20260408070514.1840227-3-ntspring@meta.com>
References: <20260408002802.2448424-1-ntspring@meta.com>
	<20260408070514.1840227-1-ntspring@meta.com>
	<20260408070514.1840227-3-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276639-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ecmp_rehash.sh:url]
X-Rspamd-Queue-Id: E85213BF06B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed,  8 Apr 2026 00:05:14 -0700 Neil Spring wrote:
> Add ecmp_rehash.sh to exercise TCP ECMP path re-selection on
> retransmission timeout.  Three tests cover client SYN rehash, server
> SYN/ACK rehash, and midstream RTO rehash of an established connection
> over a two-path ECMP topology with one leg blocked by tc.
>=20
> The SYN test retries 26 times, so has a false negative probability
> of ~(1/2)^25 =E2=89=88 3e-8.

I think this is failing in netdev CI:

TAP version 13
1..1
# timeout set to 3600
# selftests: net: ecmp_rehash.sh
# 30.31 [+30.31] TEST: ECMP RTO rehash: establish with blocked paths       =
          [FAIL]
# 30.31 [+0.00] SYNs did not appear on both paths (rehash not working)
# 30.32 [+0.01] 2026/04/07 23:36:18 socat[18706] W exiting on signal 15
# 33.44 [+3.12] 2026/04/07 23:36:21 socat[21325] E read(7, 0x560db4041000, =
8192): Connection reset by peer
# 33.45 [+0.01] TEST: ECMP SYN/ACK rehash: blocked return path             =
         [ OK ]
# 33.45 [+0.01] 2026/04/07 23:36:21 socat[21137] W exiting on signal 15
# 34.76 [+1.31] 51TEST: ECMP midstream rehash: block active path           =
           [FAIL]
# 99.81 [+65.04] data transfer failed after blocking veth0a
# 99.82 [+0.01] 2026/04/07 23:37:27 socat[21345] W exiting on signal 15
not ok 1 selftests: net: ecmp_rehash.sh # exit=3D1


Also please start a new thread when you post v3.

