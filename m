Return-Path: <netdev+bounces-220727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D95B4861D
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D633B70F1
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF032E2EF2;
	Mon,  8 Sep 2025 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jiEpRuP3"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329D2E8DEF;
	Mon,  8 Sep 2025 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318065; cv=none; b=i78L8ZndpVG2cLI5lNLru7ufS3/74yP8Ajrut0gEzOm8MEFO9P6QAlBTFOzNiX5f8CEHsfj7pIMj+vgDFEg+FKMqWkK+YFvRLDOBkV9NUDRf57Hb77FZ9lFKzsT8WzRiltBtXtjHHpRq1nKYQ3qmz80VW4b4EZG91fjKhkDaL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318065; c=relaxed/simple;
	bh=xRtcOqdjtsdZI6kf5ebzBEjwO+H4XBq0PeK8BgyDANI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O7wMx8xI9uYsijbI7SSn45jTBbIDaXoXNwN2JzaTPFbadMNLVTZ61WEbO+B36fpmLRjSWVkV/qGxWugAm0pbSEltxkZ0ucletlWXI5n1+XtznqFX1xu6qcxVCfRZcvDG9VT0hz4rHMLGo8fcwambTBA8MonE6IQZ/vzUe1Ylj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jiEpRuP3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xRtcOqdjtsdZI6kf5ebzBEjwO+H4XBq0PeK8BgyDANI=;
	t=1757318063; x=1758527663; b=jiEpRuP3+MBrszoAF1ZYOtGZhnsE3NDZshlqBrPFKtyzTck
	quDgBBFJF1mQznXN3Iz/d1/Oxq4PP8lc+xTv/6Ju6HT1sPh8a3fuU1JmLmG36lhWQqBaIQSJ3w6mW
	uNXofnvVkUOJuC3IQvOiUKAwKDCKLQS+Ei4xUrcKyU0FPOFNe7etTTCddA9dvP5sd7lGATs2KtG6E
	R0yl++3H7ysS+ODol2fiSIyTOwbm5Xx3jlzXnTqoG6eenV1uS+IXH41rHWqAm/1xD8S6kcxLimqAO
	U886NQjeOgJWIqPCnaFCpUGDX+KXkYsr8TTqZXH2gifUauXk54gsUSMj4poO5ypg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvWhQ-00000006zQ9-1xiK;
	Mon, 08 Sep 2025 09:54:04 +0200
Message-ID: <c1a4da4cb54c0436d5f67efacf6866b4bc057b3e.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 02/11] tools: ynl-gen: generate nested array
 policies
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Asbj=F8rn?= Sloth =?ISO-8859-1?Q?T=F8nnesen?=	
 <ast@fiberby.net>, "Keller, Jacob E" <jacob.e.keller@intel.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>, 
 "netdev@vger.kernel.org"	 <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Date: Mon, 08 Sep 2025 09:54:03 +0200
In-Reply-To: <6e31a9e0-5450-4b45-a557-2aa08d23c25a@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	 <20250904220156.1006541-2-ast@fiberby.net>
	 <e24f5baf-7085-4db0-aaad-5318555988b3@intel.com>
	 <6e31a9e0-5450-4b45-a557-2aa08d23c25a@fiberby.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2025-09-06 at 14:13 +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
>=20
> Johannes introduced NLA_NESTED_ARRAY and the NLA_POLICY_NESTED_ARRAY()
> macro in commit 1501d13596b9 for use in nl80211, and it's therefore
> used in net/wireless/nl80211.c, but outside of that the macro is
> only sparsely adopted (only by mac80211_hwsim.c and nf_tables_api.c).
>=20
> Wireguard adopts the macro in this RFC patch:
> https://lore.kernel.org/netdev/20250904220255.1006675-2-ast@fiberby.net/

I think the general consensus now is that preference should be towards
arrays being expressed by giving the attribute holding the array
multiple times, i.e. each occurrence of an attribute holds a single
entry of the array:

[header][type1:a1][type2:b][type1:a2][type1:a3]

resulting in an array

[a1, a2, a3] and a separate value "b",

rather than a nested array:

[header][type1:[1:a1][2:a2][3:a3]][type2:b]


Of course if each entry has multiple values, then you'd still need
nesting:

[header][type1:[subtype1:x1][subtype2:x2]][type1:[subtype1:y1][subtype2:y2]=
]

would be an array

[[x1, x2], [y1, y2]].


I can't get rid of the nested array types in nl80211 though, of course.

I'm not sure the nl80211 ynl code was ever merged, but it wasn't
authoritative anyway, just for some limited userspace generation, so I'm
not sure the whole ynl handling this is needed at all?


johannes

