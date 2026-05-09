Return-Path: <netdev+bounces-286205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPbZB3GC/2kw7QAAu9opvQ
	(envelope-from <netdev+bounces-286205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 20:52:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0BA5010D4
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 20:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D181300CE57
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB43016FB;
	Sat,  9 May 2026 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="LyoAhjHK"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F201A316E
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778352749; cv=none; b=MMUOXjxMklEXyOw2tB4S+4kJXgH8/8jTBKc8ofIMbESHQA9Tp+zimQuHlLYI57QCxV15ehRWSlM2xBUbTtO1p1viUOgbJlGq/BOYDOt7cqMFLI7Tex8gtkxe8irGZxsXamdh0v5GpdlWMdmqDNbnO+lyOgv9uDxXtFjkyIccHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778352749; c=relaxed/simple;
	bh=HZHt5UnNHM4fq8LRHVHs/+rY5GUISWj4CytrOs4zPU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Khc7f9B/5ggETwCOyHjayzcLgKWHwmTR+wKWIXXrAhdNQIBeBJRgUHzs7yUK/d3LvxCAnMymp2d7N7g9JXyQMyi55kfj00XZkSP6v7F5reJiVShJ69A3Ygq75F530iEBhsG1wsMeCBKfGxDaTfXzZkq1ZXgqbX0VdgYWPC1/PXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=LyoAhjHK; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5D223200D8;
	Sat, 09 May 2026 18:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778352739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z/ruzjO2dAp5Qhc8D/RklsPkL7EIdY0uHbRyRHUl0n0=;
	b=LyoAhjHKR4P5zbiFNnm90Kg9nefP/hFGfXE+J+dI29I1xeFggwI8UXTenbFY0pn6OShqKD
	2kneufAntsmYMCRQSkdrgA/bozGXSMgewTaMs4ehRpUwA3nFCfoduR0kIfngQDp0lr1Fs/
	kOLD9eUd29H/18AiTw0Mr4HKOwp+5VA=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Jiexun Wang <wangjiexun2025@gmail.com>,
 stable@kernel.org, Yuan Tan <yuantan098@gmail.com>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net 3/8] batman-adv: stop tp_meter sessions during mesh teardown
Date: Sat, 09 May 2026 20:52:06 +0200
Message-ID: <118589593.nniJfEyVGO@sven-desktop>
In-Reply-To: <20260508154314.12817-4-sw@simonwunderlich.de>
References:
 <20260508154314.12817-1-sw@simonwunderlich.de>
 <20260508154314.12817-4-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2580528.jE0xQCEvom";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 6E0BA5010D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286205-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lists.open-mesh.org,gmail.com,lzu.edu.cn,simonwunderlich.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Action: no action

--nextPart2580528.jE0xQCEvom
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 09 May 2026 20:52:06 +0200
Message-ID: <118589593.nniJfEyVGO@sven-desktop>
In-Reply-To: <20260508154314.12817-4-sw@simonwunderlich.de>
MIME-Version: 1.0

On Friday, 8 May 2026 17:43:09 CEST Simon Wunderlich wrote:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> TP meter sessions remain linked on bat_priv->tp_list after the netlink
> request has already finished. When the mesh interface is removed,
> batadv_mesh_free() currently tears down the mesh without first draining
> these sessions.
> 
> A running sender thread or a late incoming tp_meter packet can then keep
> processing against a mesh instance which is already shutting down.
> Synchronize tp_meter with the mesh lifetime by stopping all active
> sessions from batadv_mesh_free() and waiting for sender threads to exit
> before teardown continues.

Regarding the review under 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260508154314.12817-1-sw%40simonwunderlich.de

The fix for this existing problem is planned for the second net PR - splitted 
due to the amount of patches. Besides this split, was not included in this one 
because I am waiting for the author to submit the v2 with my change request 
(to also fix the second occurrence of the invalid `atomic_dec_and_test`): 
https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/df73e607bda0c84b22d64d80f8ac887190242baf.1778118303.git.rakukuip@gmail.com/

Regards,
	Sven
--nextPart2580528.jE0xQCEvom
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaf+CVgAKCRBND3cr0xT1
y72WAQDFVBUWAp8X7PrjoHI5CYUliUxo+U68UkaetrdQ2NlviwEAjXrfUF7sl2fU
8m2gEvsXHESwepGe/I1fVjZGMipanQ0=
=MKqp
-----END PGP SIGNATURE-----

--nextPart2580528.jE0xQCEvom--




