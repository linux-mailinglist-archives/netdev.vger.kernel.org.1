Return-Path: <netdev+bounces-44846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D57DA1B5
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F0F1C21072
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CD53E015;
	Fri, 27 Oct 2023 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a73g1mVe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543DD3E011
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 20:20:51 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B881B9
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G1kMmDRuPXLdNDRerDMZ+cXR4TfQqKf0hFrS0vERlaA=; b=a73g1mVekOaqaZH1puqxqhlygP
	wNMz42xmW08yfL9832ycIU+QR13mTu6dhv/hshrZUt1dhuAh8SnO1P4eH6pkZQDJbJ8FJszHd+mbx
	EH09ecSpKEDl9yfCE5gkM7pknRU+5Rvt9ikzhGfMv2J2GOQXeIAQDRjDiBzYSPn56QQM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwTK0-000Muq-W6; Fri, 27 Oct 2023 22:20:44 +0200
Date: Fri, 27 Oct 2023 22:20:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzk+dt@kernel.org, arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset
 controller
Message-ID: <469fc880-016d-4b92-9fb3-7b465a1a8046@lunn.ch>
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-4-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027190910.27044-4-luizluca@gmail.com>

> -	/* TODO: if power is software controlled, set up any regulators here */

Please don't remove these comments. The switch might be powered using
a regulator. And this does look like the correct place to get the
regulator, and turn it on before doing the reset. Somebody thought
such boards might exist...

> -	/* TODO: if power is software controlled, set up any regulators here */

etc.

    Andrew

---
pw-bot: cr

