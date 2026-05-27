Return-Path: <netdev+bounces-292133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIDJGbKaFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:18:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE35E0556
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 465D43003EFB
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC973BAD99;
	Wed, 27 May 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="fnkplXqq"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F727E07E;
	Wed, 27 May 2026 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866210; cv=none; b=ZPbxMg33X52O4axSlkSAvWILTgHSGCdtbS3I4o5UqtzffyadSDipIDIpLFTOBe33axpCz/SIUv0aj/bEXjZbMvJ2RIeVXj5BgcUG74w4phBXZ5UQGidpkSI2XGn22hDZvNuFCNKx49/hoFWgDErNyWiFk31VeiwLNiJMomEZYB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866210; c=relaxed/simple;
	bh=vIxdAAp8PLpZ7PFhmWuqtC4SuKqVVjfiU2X5PLRSPSU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=U936HW8xqw2qjsYUbqLDvEfLpnZfg5/VX2GcQOi8qiGcAb8UblzrcebVoe8In9aIya5cDF3iId2H1IfX9hkreZ04gichweV2hCkn0Hm54XTXO7g/XVeGzUGpdDVCSPJCIDzmtGkLFHO534o7/BO24omg7+Aq0hG3ZwS9T/ezP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=fnkplXqq; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64R7G6Vl002262
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 08:16:09 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64R7G6Vl002262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779866179; bh=vIxdAAp8PLpZ7PFhmWuqtC4SuKqVVjfiU2X5PLRSPSU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=fnkplXqq1W7tBpY10raBDNXPnWh/hy7hSDTEHEITN4r+5gPg6kHeXyIwfh5U/5cnG
	 Kh/V4PkkvGpI/b7dzqB11kz5oLcJnc5jd/fodJfrK2ms7aZgkQQV3Od9rdfXr1E5X0
	 0y6Xw5NuAYfdeIKy34rqj9LQ7xiCxnG3HWXk8WX34RvcguyY+XRM8k2drIRm+yGKSF
	 CnrPdVDNIGKfiFj9dyM6WWzwkUrpEDZxgimUzThWPmVOB8hLyb2tRbMXdLOEUS+m1d
	 bbKSmYZEHT9xMiqwNqH/ASU9aJmGA8wkPEY8v2t4OQeY6x9tobP2tcSyfELeyyOH4O
	 /ERegxyFUjGIw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next 1/6] net: bridge: mdb: add
 MDB_FLAGS_STREAM_RESERVED flag
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <946d52d4-1456-4cf8-9dfa-9bba96121dcb@blackwall.org>
Date: Wed, 27 May 2026 17:15:54 +1000
Cc: netdev@vger.kernel.org, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>,
        Cedric Jehasse <cedric.jehasse@luminex.be>,
        Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CEA01D0-0C3C-4617-AFEE-6B213C4B731D@padl.com>
References: <cover.1779841530.git.lukeh@padl.com>
 <45e7cd01f9449c8ef15a5affd587fe7645ecddb7.1779841530.git.lukeh@padl.com>
 <946d52d4-1456-4cf8-9dfa-9bba96121dcb@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292133-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.859];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BDFE35E0556
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Nik,

> We don't add hw-only functionality, if you'd like to have this flag
> you'll have to do a software implementation of this feature first.
> Also please check the slop(code) that Claude generates before sending
> it, there are obvious issues in this patch.

Noted, will review. I do have a software bridge implementation which I =
shall include in the next revision if it progresses. I didn=E2=80=99t =
include it as it still needs configuration knobs to associate one or =
more traffic classes (or priorities) with this flag.

Cheers,
Luke=

