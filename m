Return-Path: <netdev+bounces-121626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145D95DC4E
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 08:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAA31C216DF
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0499315381A;
	Sat, 24 Aug 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj7VzI3/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EBD41C72;
	Sat, 24 Aug 2024 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724481641; cv=none; b=CWYJK1RrjAL96ak9djW7R3J953pfzGEYyCrCmAJ1Byz7cVs8LoDuf2X0VzSROrn/FqpJ9lBcGl6kfZ4NQsZHwEq+Uikda/Vj6y51e7nT09QBzPnzzWvf1KZ5BRX4ZTqLfryZH1r+QmXP9bERb+95427DLyzAosbIsdxqQxdMWJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724481641; c=relaxed/simple;
	bh=5TxGJM2lgfOwOS4MoY4u+yR3Tar/t5YK8uVyAbo38c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFAXY+tkkapvdwmYZzmDljDAM0R6IrBM7a/ipyQnqsqPU8UHz810E7kZ7HPnA3WEh8R5F04hrRQUdQvfOZnds+AyAy2EpUPLh+051Hz4/Glz8O2a57MrN9aamMrqlaOdf2A+p/vpW6N6r391b1UAGIr2LMYpSRh2twRzDS70VZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj7VzI3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599F1C32781;
	Sat, 24 Aug 2024 06:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724481641;
	bh=5TxGJM2lgfOwOS4MoY4u+yR3Tar/t5YK8uVyAbo38c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qj7VzI3/OvwOO57IW7w/frLuIeu/UUBh9154QnWVBW3THRktxfEHcp59FPjzJvJ+B
	 e/qGYryowsbz2U7j1TpkjvKwlktZszRRlmzHpwy4Pk8lwNYsCrM7Yp4nsXkcjbWpOB
	 ceyVEZ9ORPAtk+PvGJkvt+uT575akgR7byPm79/ezzgelIzyOk7CeFwNh+ujIChjrB
	 HCd9ukIru4DxYFLIM8gOpwbSpXdUGi+CueGJWOKEKnkf18dFx091L5IlX7gT9+LFnv
	 6NJS4tmOLTC1ck1Y8uc9Ekqa3b3aCPcogVLVqqsyvxberJBbDQxBPlbU/NRJuAcRvY
	 LSluoWOk310Sw==
Date: Sat, 24 Aug 2024 08:40:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, 
	devicetree@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, 
	pieter.van.trappen@cern.ch, o.rempel@pengutronix.de, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, marex@denx.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: dsa: microchip: Add
 KSZ8895/KSZ8864 switch support
Message-ID: <3dqh5ccseh2kk6otsqybgzs3awtxt4swvtmwokr4xrworn3wkv@sf2u2x6ao5l2>
References: <BYAPR11MB355841E229A2CBB9907C673EEC882@BYAPR11MB3558.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR11MB355841E229A2CBB9907C673EEC882@BYAPR11MB3558.namprd11.prod.outlook.com>

On Fri, Aug 23, 2024 at 11:07:03PM +0000, Tristram.Ha@microchip.com wrote:
> KSZ8895/KSZ8864 is a switch family developed before KSZ8795 and after
> KSZ8863, so it shares some registers and functions in those switches.
> KSZ8895 has 5 ports and so is more similar to KSZ8795.
> 
> KSZ8864 is a 4-port version of KSZ8895.  The first port is removed
> while port 5 remains as a host port.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Your From and Sob still do not match. Please run checkpatch before you
post.

Best regards,
Krzysztof


