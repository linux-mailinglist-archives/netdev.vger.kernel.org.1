Return-Path: <netdev+bounces-100275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B6F8D8611
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393081C21DC1
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266912D205;
	Mon,  3 Jun 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MOHacoKn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04681292FF
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428687; cv=none; b=cyOK6k0dNKEIiUpI+KpMPbRu3qctUqPXJ6qQXv2O90a9vIEdDkyPKM8HARg0HAfYNeu2qIMpG3o+u908Gp7CtVQjn9uJGsEyaNKpSt1e0JpyM3ZP3WDvAdzoEYdIgNpefxAIGRQdhVt4i3U7BHS8vt2JJPh8XKM4h2kvEJOydi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428687; c=relaxed/simple;
	bh=xNpIqSAJ+IR/S4D91TR1T0KcaPZl9sguX4obyMNl3hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jELo1w++DijpiDGzpM3Z8CO0mjEtewAJWMfYCThkTwyOX7r0VLZ2Ef29tdAxmgrJFFTex+XtiYTjTgRXc8LcuBe0o/jgl9tD/ql6g1ZOd2zj2UI/8Fp2ZWBWxYcOvTk2TP8hm229bK0b1mHVLzYgqsRnNK9xeG6djNtxrTo4Lfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MOHacoKn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=EtW8M+mhzN+wN5RYsOFsIUMPx/KKMqJ9OI393s6MVYI=; b=MO
	HacoKnq6GOLop1ZxNhQWIyC/1326ALNh8WhQE85FCENNhjvcgc48nnmZcDOJ6Wfr58zUCSEIdT17p
	RzBJpSocAIC3i3yUvlR1xM54wdjuu12t3+Ld66n5CNTOY4camZDky3N94kACd41aGF3+x7Da2awjk
	cB8mNURvTRHUdfw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sE9eb-00GixU-Gs; Mon, 03 Jun 2024 17:31:21 +0200
Date: Mon, 3 Jun 2024 17:31:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yangfeng59949 <yangfeng59949@163.com>
Cc: netdev <netdev@vger.kernel.org>
Subject: Re: Re: [PATCH] net: phy: rtl8211f add ethtool set wol function
Message-ID: <e43bacfc-0143-4291-97a6-34c02b92d059@lunn.ch>
References: <20240529153821.5675-1-yangfeng59949@163.com>
 <b60c3bd3-d5f6-46a3-9dd3-f63e6178d2f3@lunn.ch>
 <5478156d.1b33.18fd81e0d9d.Coremail.yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5478156d.1b33.18fd81e0d9d.Coremail.yangfeng59949@163.com>

On Sun, Jun 02, 2024 at 04:43:19PM +0800, yangfeng59949 wrote:
> The RTL8211F series can monitor the network for a link change event, a Wake-Up
> Frame, or a Magic  Packet, and notify the system via the INTB/PMEB (Power
> Management Event; ‘B’ means low active) pin  when such a packet or event
> occurs. The system can then be restored to a normal state to process incoming 
> jobs. The INTB/PMEB pin needs to be connected with a 4.7k ohm resistor and
> pulled up to 3.3V. When  the Wake-Up Frame or a Magic Packet is sent to the
> PHY, the INTB/PMEB pin will be set low to notify  the system to wake up. 
> 
> 
>  1.Set MAC Address Page 0x0d8c, Reg16~Reg18 
> 
>  2.Set Max packet length Page 0xd8a, Reg17 = 0x9fff
> 
>  3.WOL event select and enable Page 0x0d8a Reg16 =  0x1000 //enable Magic
> Packet Event

Some of this needs to be in the commit message.

[Goes and reads the datasheet]

So you are using it in its PMEB mode. This only indicates WoL. It
would be good to document this somewhere, since i would not be too
surprised if somebody added interrupt support for link changes etc,
rather than having phylib parse once per second. Such code will want
the pin in INTB mode. There is a danger that will break your code.

Do you actually need it in PMEB mode? Bit 7 of the interrupt enable
register allows WoL to be indicated with INTB mode. Using that will
make it easier to add full interrupt support, and is simpler, not
having to switch between INTB and PMEB during suspend and resume.

	Andrew

