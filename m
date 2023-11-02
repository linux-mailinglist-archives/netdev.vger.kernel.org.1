Return-Path: <netdev+bounces-45706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBEE7DF1F6
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91D2281A96
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1015AD9;
	Thu,  2 Nov 2023 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NKDhxjaA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C01A15490;
	Thu,  2 Nov 2023 12:05:11 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DBDD4A;
	Thu,  2 Nov 2023 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HntS3je0QXLdwZ1+s0cY5G8BrYYXr4+VZLC8JT4/rII=;
	t=1698926705; x=1700136305; b=NKDhxjaAUuI3JDJyd63RPVH0Ptk1lRm3c4N4FLFL7HCbwP3
	qad+oA1OBfZi6Pky9vv3z6SziT5Tjd9TVHB6nWBQzJsYWyHLEgeudp2iHvbLjgYVtS/7eXlPXj4xU
	y2BFi3iZAJqmM7w/HILq0SawjaPkjJj1vYppozyY40oCM8NsShLWFSKrP+rfTNL0h/sQygkK1Ztqm
	ok/jOPXAeC3/fv6jn2QJHUAK2Mr5zgxFFmBJUtf+gTO9UQxwAkQQJtSSdUwnW9oyCN+Pd2BLl7PSH
	iptIrFL3Erv1RKZ17+aJNFvRfKnL0vEGabYlOX21LpETe+MKUKWLvjqe/qRHcUSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qyWRS-0000000BHyX-0ieC;
	Thu, 02 Nov 2023 13:04:54 +0100
Message-ID: <b080757463a1f55a38484e3ea39fd3697e98409e.camel@sipsolutions.net>
Subject: Re: [Patch v13 4/9] wifi: mac80211: Add support for WBRF features
From: Johannes Berg <johannes@sipsolutions.net>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Ma Jun
	 <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lenb@kernel.org, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alexander.deucher@amd.com,  Lijo.Lazar@amd.com, mario.limonciello@amd.com,
 Netdev <netdev@vger.kernel.org>,  linux-wireless@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>,  linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, majun@amd.com,  Evan Quan
 <quanliangl@hotmail.com>
Date: Thu, 02 Nov 2023 13:04:52 +0100
In-Reply-To: <5b8ea81c-dd4c-7f2a-c862-b9a0aab16044@linux.intel.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
	 <20231030071832.2217118-5-Jun.Ma2@amd.com>
	 <5b8ea81c-dd4c-7f2a-c862-b9a0aab16044@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-11-02 at 13:55 +0200, Ilpo J=C3=A4rvinen wrote:


[please trim your quotes]

> > +static void get_chan_freq_boundary(u32 center_freq, u32 bandwidth, u64=
 *start, u64 *end)
> > +{
> > +	bandwidth =3D MHZ_TO_KHZ(bandwidth);
> > +	center_freq =3D MHZ_TO_KHZ(center_freq);
>=20
> Please use include/linux/units.h ones for these too.

Now we're feature creeping though - this has existed for *years* in the
wireless stack with many instances? We can convert them over, I guess,
but not sure that makes much sense here - we'd want to add such macros
to units.h, but ... moving them can be independent of this patch?

johannes

