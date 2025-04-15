Return-Path: <netdev+bounces-182875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D47A8A419
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4973E1675E3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0E121772D;
	Tue, 15 Apr 2025 16:29:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0B19F11F;
	Tue, 15 Apr 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734560; cv=none; b=u1VRam7Zt8MrOLkEIN5l1teAE9e0uqgqoSZe80F9sYezzrLX4HF71Qgwyexm4XoYMhZsPyaPzurZ0dXbIm0+l5tuDnjRuCQLhUOEjhO4BZU/EgYaaZMXuXaDHwwVGkyrN+sSzIvTB/r2SzO1JWsFee/6R+giFvIpScsz3tVKKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734560; c=relaxed/simple;
	bh=qYTBtHM2zWSA7h6E/SoGd7meHiwUJZ8Z0pEB3y9DUbw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZrTDqpHwoTS6WvYxSjiwJQh8q0Y8lYV/Pac6TPnMRpwjAZTRxzUxmOIoubpHgmRxgBj6bYxuRrxz/42uhNT7paRRlz2q4l7HjjM1RsUF9OEt13kI4ROwBWHqNk9Pl19/tu1mVO8bAnqzbrsQp5caXH/J1FAeH9u2QglDrPQXXJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id CE4651212FC;
	Tue, 15 Apr 2025 16:11:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id CDFE820025;
	Tue, 15 Apr 2025 16:11:11 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Apr 2025 09:11:11 -0700
From: Joe Perches <joe@perches.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH net-next 4/4] checkpatch: check for comment explaining
 rgmii(|-rxid|-txid) PHY modes
In-Reply-To: <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
Message-ID: <f3acd53796a44576408a2a14aa5baaed@perches.com>
X-Sender: joe@perches.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jh3nqazk1jc3b5jt4mi3gt34yip7om1u
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: CDFE820025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+5zct2ruo7E6hoPc/hJUfsW7XPRtFJmdg=
X-HE-Tag: 1744733471-828432
X-HE-Meta: U2FsdGVkX19tqmX0rgSBcUP9E/t3KWTRFktRBaWmUsQ4KGi9uYcqiGhovIVKP6pAI4rVekGl1QVJDA50D1+Lrtr9m/ZswlJxmFu8ADGYsLOSWJHP4VmV/ligfFokJ1G2C1VGar8DWuqzC5l6RupMwZjeQlU3t9oTvFZA88BL6AK9O5g9b+N5mFDLw/SNfqzOhfR0oYphVPMVzTQnzrgZ7ztXhxcgbg/RNsvX2AYTNFWIBIiUnkJznYkGtJioV5EJhg7adrhusTqKmPRPfoV34w==

On 2025-04-15 03:18, Matthias Schiffer wrote:
> Historially, the RGMII PHY modes specified in Device Trees have been
> used inconsistently, often referring to the usage of delays on the PHY
> side rather than describing the board; many drivers still implement 
> this
> incorrectly.
> 
> Require a comment in Devices Trees using these modes (usually 
> mentioning
> that the delay is relalized

realized

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 784912f570e9d..57fcbd4b63ede 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3735,6 +3735,17 @@ sub process {
>  			}
>  		}
> 
> +# Check for RGMII phy-mode with delay on PCB
> +		if ($realfile =~ /\.dtsi?$/ && $line =~ 
> /^\+\s*(phy-mode|phy-connection-type)\s*=\s*"/ &&
> +		    !ctx_has_comment($first_line, $linenr)) {

Not sure where $first_line comes from and unsure if this works on 
patches rather than complete files.

Does it?

