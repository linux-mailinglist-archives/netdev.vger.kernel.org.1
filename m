Return-Path: <netdev+bounces-120519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE83959B06
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0021C21739
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE47158A23;
	Wed, 21 Aug 2024 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cde4s+0k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF11531F7;
	Wed, 21 Aug 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241243; cv=none; b=IoFJxQnDHZ+4/bSYKm1BVYtM+SlEgaEivQcs+Pe7tjS5lJWIgofXkNwIINDd94PWhvN+dJ+lvOlU2icIaf1yizXY1Gj7sajspuk2uZadgT1AhPdgoIkEycm5Tlx+Vi8If/IP7vBXee19crwKRaL5WyDRciSsuBN7YtJaRvsed2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241243; c=relaxed/simple;
	bh=ccWW1aDL5G44XpifJHFPS+BgMXPGNSeKEn7fwBM7Wo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugXgxWKkLufPJ3kr4654ykNJthfQ+N2hpmsxgoQKMEEGP/FpeQ3exKkn0tP3KfZyGMzFV5ZmPRI2jvwXdiE+X2z/v+u3TkfxEqPwuA+RWe1Tm7CZ674B8fMv96jF6XG+/HALmgnfqnNPxlLATgGWXbIUGVXs3E31vh2cUW7lFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cde4s+0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A9DC32782;
	Wed, 21 Aug 2024 11:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724241242;
	bh=ccWW1aDL5G44XpifJHFPS+BgMXPGNSeKEn7fwBM7Wo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cde4s+0kMaXg1JgdClff5dTLH9ix/lO9DL7fCsJXKaUP2wEE5XFKhg4Amc3ZCZdwd
	 g0fICrMwVtHADiWJIEdHy/m1b6nffiP7HXF5r7lvXqDVghhP+5I8xgsyEo0tgdsKTS
	 jzNJL4lrXKyVUYRTKyTuZsyTuJ3KSlLHUogIUFUcxPulKk5yyokpHNA4IGrfymeQO2
	 BX29Mcqt9lrXtXQ4xg9/BLtmg7N/hWRoOmqnAJkFneLwVbfNTy2snxgVnmukRzlKXQ
	 xWKEq6qMqLWwTXT6wz9HQ6n3Q3SmsEFcLTRlBqZWgXmWm37q+HCWRnbBKPrnzvPg7m
	 o/MqUh+AjX0wA==
Message-ID: <a3542717-45f6-422b-b88c-bc68bcbbfb86@kernel.org>
Date: Wed, 21 Aug 2024 14:53:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/7] net: ti: icss-iep: Move icss_iep
 structure
To: MD Danish Anwar <danishanwar@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Jan Kiszka <jan.kiszka@siemens.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-3-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240813074233.2473876-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/08/2024 10:42, MD Danish Anwar wrote:
> Move icss_iep structure definition and to icss_iep.h file so that the
> structure members can be used / accessed by all icssg driver files.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

