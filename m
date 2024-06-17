Return-Path: <netdev+bounces-104230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 652A690BA31
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02E1B226D7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AF4198A33;
	Mon, 17 Jun 2024 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t9et28Y3"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6878364BE;
	Mon, 17 Jun 2024 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650248; cv=none; b=NvY2Q0fjMV1e9lXTRU/kqLQT3Ov4O0Ivqg8ioL2rWgJyJLYf5kul6mKUM/3jcySVPegUtPKsA9s1hpJl3ttAy9ArUrksdXXktyhno9RJ3xH/uG4I941Np2KihSnj1DL7+wzCBelhbHfzQ/4vADy45DWg1B2vb5Ss+JMK3Q+29d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650248; c=relaxed/simple;
	bh=pIlXwzTrfunMUXJb/xXJ5sOlg/1IsGV67uv1ad4VBfk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMUh5syEHgJS27tUv7ItfLcPbLq31Evc+W8wRJbfDaJvaAniKHvIi7aEcytaISw6oTXO8oGOtaIQLcmtJrck1KZlRK01KfVd8NSttv225o/WCOGEAGjcq2JsIyFtCHqj2NpoQ4osO06mt29tcdPgWfksv+rGMQ90I6uQTWIBmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t9et28Y3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718650246; x=1750186246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pIlXwzTrfunMUXJb/xXJ5sOlg/1IsGV67uv1ad4VBfk=;
  b=t9et28Y3QzO6iud8+m+38yCYntATdyrUWgwcaiFfA4xG7RZAdmnxRusB
   7Lg2qHw6/Kkw+BY6sQt1Ibx1xaPuw4mybssy6ag7jk4KF4Fo8fwUNGs/7
   nQ3ajie9CMgX0gnyIYD+fTi0qBd9Kl7ron1NEww11L4SL8tV8le4YQ7Qo
   aq5c3JwOCubeHogDnBuQUE2rGj/5i+nHCo8wCumT8OXVfW/NGZRs4yIgO
   U3lc0JnTAoaIxn9VbS1MW5cbNQvgvQ4m3KzU2l45qddp8C7lfaZ/hgzOc
   OOraJxAQ9bt+/nNkG/b8qX/pRZVPqrtnzAsMwH3jy4YqNFR+zgL4sM/3H
   g==;
X-CSE-ConnectionGUID: ZN8F39vCSVmgAkJoWJFifQ==
X-CSE-MsgGUID: iMFW4qdqSem4hFB60qxTxw==
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="258810120"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2024 11:50:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 17 Jun 2024 11:50:29 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 17 Jun 2024 11:50:26 -0700
Date: Mon, 17 Jun 2024 18:50:26 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next] net: microchip: Constify struct vcap_operations
Message-ID: <20240617185026.lgpspvyjsygh4lry@DEN-DL-M70577>
References: <d8e76094d2e98ebb5bfc8205799b3a9db0b46220.1718524644.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d8e76094d2e98ebb5bfc8205799b3a9db0b46220.1718524644.git.christophe.jaillet@wanadoo.fr>

> "struct vcap_operations" are not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> In order to do it, "struct vcap_control" also needs to be adjusted to this
> new const qualifier.
> 
> As an example, on a x86_64, with allmodconfig:
> Before:
> ======
>    text    data     bss     dec     hex filename
>   15176    1094      16   16286    3f9e drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.o
> 
> After:
> =====
>    text    data     bss     dec     hex filename
>   15268     998      16   16282    3f9a drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I hope this can be applied as a single patch.
> I think it can be split between lan966x, sparx5 and vcap if really needed.
> ---

LGTM.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

