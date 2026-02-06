Return-Path: <netdev+bounces-257509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0INDIpK5hWmOFgQAu9opvQ
	(envelope-from <netdev+bounces-257509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:51:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB2FC3C6
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B39BA300A138
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C82F6922;
	Fri,  6 Feb 2026 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wM+bOJWV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0335B64F
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770371346; cv=none; b=pLJ3G0jrC9uLqrbcdBGe6cVxpqGe17nRPfUTbKl1tRgACEbpajcU9Zm8S/465wdFduTGtlrFWK/W8GRD0d4QvOc5dNYsmsk2U2L0bCEGk3OuS2NtFNAqIByJewpash/jeGiVvKf2k85BtCICfWS119NcMlv8DzlktEDpnzhoaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770371346; c=relaxed/simple;
	bh=hU/RLBAOV4XrbbdTmqSB9Tu3AMo99dmKAhouWBwfKJ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3V5GqVklLiS7vFetAVXnp0qcNjLBeGhSDMt5MryeYQ2qo5Ds3CUuzWtWpHHJGEvsHgBnjxQPMaPcDzQFgep/Vw1ThQe0HqkBs241P8Qt0YUBcStDyKfVQjuLl4qTymG7UCJh34z5mtfuKrhotXX3jKK759XS9/pvMRJzxMwzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wM+bOJWV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8CEBB2076B;
	Fri,  6 Feb 2026 10:48:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BBwboM7pteky; Fri,  6 Feb 2026 10:48:57 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 09A25208A5;
	Fri,  6 Feb 2026 10:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 09A25208A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770371337;
	bh=I/ATgQeNYias3sQtTVDiwfz6wjFBF8H/u+csKa6CWCE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wM+bOJWVvcXEBFOw/UXU25A47cL4yHHV4OIWEaJ/4/finEixaayNMnOdkryTCKsUG
	 gk5ee7uUuaKNUSpPat2n/69Ssme6XWUVs/1a+rF5XaxmI7qjg2PN4iPQ4rDndyxJ2X
	 SDTjoESd7UNTNaDbuuAq/KsISnAkbH3YATWnH6VZ4jOek3dMzE8Pm0H5NwaCqEeqnO
	 FNjrNmOfcPEF9Qgr1xFBvEP2qUbb4rbZCvSoktvgzNlweelLir4NJizRmRdr9coi64
	 zSA+5XKMJ3+vkP8kW25a+OPOPDOEphRTNTA3dQlxNWA41znZBKAVjvl/sPVMRHrucD
	 k9mkG1o5qc+fw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 10:48:56 +0100
Received: (nullmailer pid 2132387 invoked by uid 1000);
	Fri, 06 Feb 2026 09:48:56 -0000
Date: Fri, 6 Feb 2026 10:48:56 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Florian Westphal <fw@strlen.de>, <netdev@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>
Subject: Re: [RFC PATCH] xfrm: reduce struct sec_path size
Message-ID: <aYW5CHT70Q7LDoWa@secunet.com>
References: <a2552992ca2fa29754340eaa05b1a185fca7a381.1770309837.git.pabeni@redhat.com>
 <aYUxubug67eqQ6aH@strlen.de>
 <57948250-bfbe-4d36-909a-987458374423@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <57948250-bfbe-4d36-909a-987458374423@redhat.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	TAGGED_FROM(0.00)[bounces-257509-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:mid,secunet.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DDAB2FC3C6
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 10:37:51AM +0100, Paolo Abeni wrote:
> 
> I'm trying to understand why XFRM_MAX_OFFLOAD_DEPTH is 6 exactly, but
> it's not obvious to me skimming over the code.

That is beause we allow 6 transformations per packet as a maximum.
But for offloading we currently support just one transformation,
and we probably won't support more in future. This transfomation
bundle stuff if from the old RFC 2401. This was obsoleted by RFC
4301 which does not have the concept of transformation bundles.

I'm currently looking how to move our inplementation from RFC 2401
to RFC 4301. This should remove a lot of complexity that came with
the old RFC 2401.

