Return-Path: <netdev+bounces-70028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA884D697
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D480E1F226DE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B12032C;
	Wed,  7 Feb 2024 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="chei/zHQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257A42031D
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707348767; cv=none; b=mMdWk5FJoVlv1Sl5bYhqVS3S2YvqthFR3TVVg9Xu7uqe0md1+ABySRMvnAwa7Yxs01HuGJhQZFqpPHIgyaxyieTV1zEn1m5tRy6DXgDhHZk+J8432n89r/cIcgJpMTru+JP5J55pw5nS44Cqeqh/pKCh3gp+ZjDG0Xl2accLuB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707348767; c=relaxed/simple;
	bh=lMSeWEAEW3e9YpOtFWMHabO1Hw+koH9ODU4p15A+100=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq/AlLe2MGnrec66rn6Ovj6o+xy14Z2zaxD8bvE5cZj72xbrQL1ZBdn2XXgJhf8K7P2S90sTR8WcVRnx+GhhcdEG+Hc52czA6QGOZBCHivXMjRovl+OaDwfs5CU1KmA575dw7+aXoGNqk/acbHcLplFFeopqY7KYjwqghphBXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=chei/zHQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=o9dboBhax+dFkWjrudMeDPXIZghvWcknt9PhVdpX2xs=; b=ch
	ei/zHQD7t83iKm+Qx5hj8lvOZPeUh1CksBeEP1lEcPF/Jkz3fW+LUTDRFkHiqf3ENg2sU2zf8aSMs
	jg6G7rIonHf9JzOd0IzPF7e0ZXJ1c+IrQ96UnBcuyigOsNrjgENqttIkss5E38IqeHxsrq4FPxJlY
	8rgNtoQN/+oP0fw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXrPH-007GDO-5X; Thu, 08 Feb 2024 00:32:43 +0100
Date: Thu, 8 Feb 2024 00:32:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, Taras Chornyi <taras.chornyi@plvision.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: Prestera driver fail to probe twice
Message-ID: <c70a4c93-909e-4a94-8e46-d3d62aa7b487@lunn.ch>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206165406.24008997@kmaincent-XPS-13-7390>

On Tue, Feb 06, 2024 at 04:54:06PM +0100, Köry Maincent wrote:
> Hello,
> 
> It seems the prestera driver has never been tested as a module or in a
> probe defer case:

Hi Köry

Could you hack a -EPROBE_DEFER failure? If you can show that does not
work, the driver is clearly broken because phylink could return that.

      Andrew

