Return-Path: <netdev+bounces-201511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938EAE99D2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E075A1FA9
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F63298270;
	Thu, 26 Jun 2025 09:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D21E9B35;
	Thu, 26 Jun 2025 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929743; cv=none; b=oXH+qsrDnN88r8J/diPCZs30RkXXkJ3yPjlrOVo0VOir9b87pB+WVl02IOemUhQR4BjvNUXu9ZPsOpPLihbnVGLJCabax6fHB+i0Q55v/T0WX1wntPOWomNQxXNxpvWyicjWcvomXALvaQnS8v4ScHxodUZS+Cdm8gG6Q0xDzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929743; c=relaxed/simple;
	bh=NzFDlsLuM/iaBakSJFMWtsb2SnQd/z1CHs2oGFR7Zqw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n1NttsBHkdHya6/2blEtDGECwCv2ybP54+2ajeSB6W/1QpuRNUMpcPPsuecFudDcN8VydTZcesvHn6Zc5siql6JgT0FLZQ29ZceQhDFZtp7dYiIPyIb3OeTOcCtoHkD3z9vW+7UrsGGKOzdNgm662EjUTcFwoykvgc3aJHsQI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5876BBC42F;
	Thu, 26 Jun 2025 09:22:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id BAEC92002A;
	Thu, 26 Jun 2025 09:22:10 +0000 (UTC)
Message-ID: <2856e6204315895e5f87e7cb9dddbd40056ae4a4.camel@perches.com>
Subject: Re: [PATCH net-next v2 3/3] checkpatch: check for comment
 explaining rgmii(|-rxid|-txid) PHY modes
From: Joe Perches <joe@perches.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Andrew Lunn
	 <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray	
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,  Siddharth Vadapalli	 <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Tero Kristo	 <kristo@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Date: Thu, 26 Jun 2025 02:22:09 -0700
In-Reply-To: <f593ed6162e34aa354eff6cc286cb24294195ee1.camel@ew.tq-group.com>
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
		 <bc112b8aa510cf9df9ab33178d122f234d0aebf7.1750756583.git.matthias.schiffer@ew.tq-group.com>
		 <c954eabf-aa75-4373-8144-19ef88e1e696@lunn.ch>
	 <f593ed6162e34aa354eff6cc286cb24294195ee1.camel@ew.tq-group.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: fdsczjqjnzc3q1naeru8np581p4obdjn
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BAEC92002A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX199FlgeWTMybsnD9KqIg0025hPZzeZgi3I=
X-HE-Tag: 1750929730-464223
X-HE-Meta: U2FsdGVkX18YQsU6+EI8XeumX4oi9QkmeOW4FifwSa78bSxfz3sAy+vY4EU6fgqcTc3nCoLPgopnIuP3KrbAqiTmOUvxJpdzcDtqOgN8A7UA5eZrWcP0pkSkRGXk678Mftkha41gKzEsqWDjQ8RnZb7BzsWNwam9doI7gOeVZdV76fY2RW1eP6V2BFhSFJZACUq4cgc/q+PDsrGrCButEfXjtiGF1eylFu5BgJFl7KyvdepWJfxI+92AZ+WLnsiuNWMCmWsk60fMz68bQNVJERdenQHBqIsY5pgNBGJ4kgwCe2elSTemC3badHvGVYZs

On Thu, 2025-06-26 at 10:11 +0200, Matthias Schiffer wrote:
> I don't know what tree checkpatch usually goes through, MAINTAINERS doesn=
't list
> a specific repo. The whole series could be merged via net-next if that's =
fine
> with the checkpatch maintainers.

Merging via net-next is fine with me.

Andrew Morton is the typical upstream path for random checkpatch
changes.

