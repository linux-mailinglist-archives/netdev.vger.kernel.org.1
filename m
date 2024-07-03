Return-Path: <netdev+bounces-108982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C679266B7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F077BB255AB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782791836FB;
	Wed,  3 Jul 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llKGFeg8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523DD170836;
	Wed,  3 Jul 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026386; cv=none; b=ZOB0D2AftsPU/f2Fy//SPs//z9oHxo7+w0/bfqqzudADYcoXjuvwwQt1qWaNSiqOUuZA+sA55JMcs8z3ccxY1T4ecMB9YV7zH0eaGBxzMrFehVlfp02aCszf2Q/5W5Wv7EV9JjFRBJE75N/VMnA/qQd4vu0bT8oKJP7LsT34giQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026386; c=relaxed/simple;
	bh=jxIQkXZuz5iYQPi2dkmR/Sj4t0u8aOUXDzgZYt2iVkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQnFiSiDjQNgcEoTH545FbruFq1t+n0XFSVIfrJpAtJbuEBhgyKnPz5XwIZWeEe7t8XaRzrrFMsiGEyY7QiHICvOS8Ffl5F1ZdhgKx0c/J4iOwEa/fWqX9ylBMailfibLaQ6QDkVTJXWNOBlfXy8JKXYe+6gAnCAww/qpIk9Wjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llKGFeg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F830C2BD10;
	Wed,  3 Jul 2024 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026386;
	bh=jxIQkXZuz5iYQPi2dkmR/Sj4t0u8aOUXDzgZYt2iVkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=llKGFeg8FyjUq+BoiNAkwfUjJ8URUwlUjsSR2rg37EvCb3b0GokbiEMg5nJp6NU+l
	 tyAdXuTIfH05bzDZseHcOK/rqUsdiCI+DSaOYNN146WO23EZTzN8oIiSbVKPtcyjzq
	 em7fxN2kyMMt5319VBFm0/qF2i8IJHbeYFPA4SaROj7SBTOZlr/xsFiS7UKLNS4lW+
	 ++fK+kcoubYFcpyh8gt5GN13WbwElfXj4DI8u/BKlclVfvC8DQEC75IC0XDNd8cdd2
	 rvYgf8A0pc6c962dyr0AT+p8twdWhsZ/YY+ikhQ1krnbkcLTrv4t3Ed8aImyALbbNH
	 7SZR8k+zg7tuw==
Date: Wed, 3 Jul 2024 18:06:21 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Message-ID: <20240703170621.GF598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-13-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-13-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:54:02PM +0800, Justin Lai wrote:
> 1. Add the RTASE entry in the Kconfig.
> 2. Add the CONFIG_RTASE entry in the Makefile.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


