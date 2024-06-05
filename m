Return-Path: <netdev+bounces-101032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EAE8FD00B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4ADB2825BC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3E19306C;
	Wed,  5 Jun 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mbxf/831"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB9194A65;
	Wed,  5 Jun 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594680; cv=none; b=ZP2RP5B/s9qBrz6I6kGVnQ24hIWO7WQsr4Nb+s3036LHaV5OxAgGsVG/66/7+nU62TC7s1LQqcrjtoA+DiP5/PMnThNCKvp956dinl+4JGF8MU34P7hgSWEuh7ydu0IZ/kq3h6MC6O4X41hKxs1MP1YJjX9t2wVqcMLdf0UgS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594680; c=relaxed/simple;
	bh=HpQsgsyp5lfIf8J9S9f8ea/9SbGsXblH8vUfH669E8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rONJ4pAd51eNBBodsyaXuVkvZl/AfNMyx08cXsVrH/4UqfQw0YilPmIqtuQwHkvTyCdPHEvk8RHMRvCdJtiFQQmeHCSZrxumD2+Ld+Lz2uMQuhWqlNquwYNF/NSrGtROjLm2WlZkUhY8x4WzPFL17nEvxAYprGqolp7ekkn4Rug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mbxf/831; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0CB1CA0771;
	Wed,  5 Jun 2024 15:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=So/Ya7Og+X+sYxPIpOm9
	KuvI4HQUxRWAE6tooiOs/d8=; b=mbxf/831nm3FzwIp+Wkrz7bP/zpqAo7/1AQU
	0L9VwdKd6zCQ1elsiQGTn6QN0GtLgexEVZzmthhlhfkb6lpZIiHvlW9xJDfrJkv2
	1pM/h5iuJcKsBJS9jpMxxBIgQgcfonjExLIE1YF/iAVqdtwfVEAD0x2TaZpviv4U
	qXkXRRskqCv32TU0jH17GLUTRc3xB5PP+WNDtvG3+MDbuKQnKa6POPzyiikY2O3z
	2dNYfrgfcDOCRbevXzNiMCEHZf3dr/iy1+bEaATIAxBmKFiB4887UQRGrlIA08RZ
	Ms6ugZfhhFwzvwvJA9SZf6LgOWoXlnVDrFjj3lQfPon9IzmrPUEw4wnO7L6h3cw+
	4K0Ow8A0UgDdMZd8UmcyhEo3aXcLvHzgIjVCqMLX8oGvFEK54IP4hgnTbiLUTyGk
	uOX42xmtV0WJsBw+Vj8n/rN7t0T46X8KMq1IrsFirIDGGPQ8AAMu+5Fke+HFaepY
	9n8F/0fi/WSJkEZNI4bVAkqZYBHjSl6VhizyGzF/jAuz3C9nlGlBe7RDqCzRnvsn
	Do+aRw9+yUPBSL0CQ/IOGLCPt/WypLqHnENWti6wOQ3ao/2oB8JcGDamCgVEnnXr
	k5dENtmHqZjNAhuezHx18vKs49sdW7E6yD4BD83A/Yp+prl48garEEPx/5CNa63L
	f+s/rAg=
Message-ID: <3f9b6129-e81e-4cc1-93ff-9d4cc6ffc035@prolan.hu>
Date: Wed, 5 Jun 2024 15:37:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] net: include: mii: Refactor: Define LPA_* in
 terms of ADVERTISE_*
To: Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<trivial@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
References: <20240605121648.69779-1-csokas.bence@prolan.hu>
 <331930db-f5a1-4ad7-947f-7aaf5618c646@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <331930db-f5a1-4ad7-947f-7aaf5618c646@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A12957627661

Hi!

On 6/5/24 14:51, Andrew Lunn wrote:
> On Wed, Jun 05, 2024 at 02:16:47PM +0200, Csókás, Bence wrote:
>> Ethernet specification mandates that these bits will be equal.
>> To reduce the amount of magix hex'es in the code, just define
>> them in terms of each other.
> 
> Are magic hexes in this context actually bad?

Yes, as if it ever needs to be changed (for instance in the 2/2 of the 
series, when I replaced them with BIT() macros), it needs to be changed 
twice in the file.

> In .c files i would
> agree. But what you have in effect done is force me into jump another
> hoop to find the actual hex value so i can manually decode a register
> value.

True. I expected this concern, hence why I tagged this as RFC. However, 
I believe that from a maintainability perspective, it's best to only 
have one definition, and since these #define's are right under one 
another, the "jumping around" is minimal anyways.

> And you have made the compile slightly slower.

C'mon, that's negligible. The time it takes to load the header file from 
disk will probably take longer than it does to resolve an extra layer of 
simple #define's.

> These defines have been like this since the beginning of the git
> history. Is there a good reason to change them after all that time?

Just because something was "always like this" doesn't mean that it 
cannot be changed. Especially since this patch is 100% 
backwards-compatible, just maybe slightly more future-proof.

> 	Andrew
> 

Bence


