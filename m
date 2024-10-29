Return-Path: <netdev+bounces-140136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C199B5562
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF81F283C94
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07191209693;
	Tue, 29 Oct 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0A4gwjv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273619258A;
	Tue, 29 Oct 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239027; cv=none; b=TcRJTN+XlCpdWX7LTR2je/m0iIisVYhYxmP8oXECoe04xCeUBnIgDfgWGvoDjHC7hDqlc3+9rvpAcwkdM0AUrXxlQPk+BcKXRUHm27zmzMC6lb6RpdpXlB07v7AC8iPCj0W282db2/eTWPADHkYSMMulM1rto5tEFsIJf3OM89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239027; c=relaxed/simple;
	bh=BjDfOdY3EHx1R9jUXLtwOeMN+Xv7x6euYTPmeTsQxtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uw/rmQS9GskYQ3BGXmXHTHJ70BnFbCH3cqb6wBWvfS6CKoSrMsiA4OSTWgVvq4IHCKwHxLwQEW4kfu3XnXjsQs0C/Bs11oglKoweZvoP8Vdj3cMYynLsid9yw6F3SGrbbiY07G9LkA5RQMrSmHinqpZdftQhZGNTdHXHrDYK8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0A4gwjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3D8C4CECD;
	Tue, 29 Oct 2024 21:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730239027;
	bh=BjDfOdY3EHx1R9jUXLtwOeMN+Xv7x6euYTPmeTsQxtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N0A4gwjvJJ3FEY/hXICbLQN9Cs78y8m7fTw956bd3fRfPl0Z6e9VAAh66V+jOeymc
	 uUQifQsC29Z7euFM0EtNP8C1Qzfp0IOYgjFloIKV9riZ/T1msCvFTVOzvyJ5eL0J5u
	 JSbNYQNGvwbct0Ujk6BF/xJ0wYyYNw1aQZ+RzrCwtU3Xg2EDUcFhRC9OiA5QXjVEW1
	 R+alksPbbZi7NoXGYlblt4V36pl6mlyVDElTpOQabkxB/7JfUJC5XZUpqmc4TVWv+x
	 oApsGMY32ZGbOFowA+o+PgdcgddGMgPse1nD5GrFFxpBnmiW8+LhiVqbsJmRYfFw66
	 EMPdu1bqSHUjg==
Date: Tue, 29 Oct 2024 14:57:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ronnie.Kunin@microchip.com, Fabi.Benschuh@fau.de,
 Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] Add LAN78XX OTP_ACCESS flag support
Message-ID: <20241029145705.4a841723@kernel.org>
In-Reply-To: <75302a2c-f13e-4a5c-ac46-2a8da98a7b7c@lunn.ch>
References: <20241025230550.25536-1-Fabi.Benschuh@fau.de>
	<c4503364-78c7-4bd5-9a77-0d98ae1786bf@lunn.ch>
	<PH8PR11MB796575D608575FAA5233DBD4954A2@PH8PR11MB7965.namprd11.prod.outlook.com>
	<a0d6ef0c-5615-40fd-964d-11844389dc29@lunn.ch>
	<20241029104313.6d15fd08@kernel.org>
	<75302a2c-f13e-4a5c-ac46-2a8da98a7b7c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 22:14:12 +0100 Andrew Lunn wrote:
> > > That is good, it gives some degree of consistency. But i wounder if we
> > > should go further. I doubt these are the only two devices which
> > > support both EEPROM and OTP. It would be nicer to extend ethtool:
> > > 
> > >        ethtool -e|--eeprom-dump devname [raw on|off] [offset N] [length N] [otp] [eeprom]  
> > 
> > After a cursory look at the conversation I wonder if it wouldn't 
> > be easier to register devlink regions for eeprom and otp?  
> 
> devlink regions don't allow write. ethtool does.

Sorry I missed the write part.
I see you already asked the "why" but I don't think the answer 
is entirely to the point. We need to know more - netdev focuses on
production use cases. Burning an OTP seems like a manufacturing action.

