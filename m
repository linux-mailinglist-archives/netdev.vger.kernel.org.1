Return-Path: <netdev+bounces-48456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C47EE641
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B342B1C20962
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D73046540;
	Thu, 16 Nov 2023 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvkSz397"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151834557
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 17:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABEEC433C7;
	Thu, 16 Nov 2023 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700157448;
	bh=079Pe3XGihXMQHu0ceh9H6g0JWvnDy8gtyhx9MMkQNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvkSz397Sn+qS6t4bocQTXP8ivxDxbDs8N5vHG64NgRh0S91nKa8456WVf+EXFJkU
	 OBxWj0fuTlrwoSrYAiuXflr+ZQYCTx86ss4V3lhVPYJe5yqSc5Amzx1c/RP6NbiaWr
	 kk6lhBYsgofdEUxCY8QyaOIS9VXSP2O5LH6zpUL/oJwdoglLfNNyY0Y46v9dXH1sh7
	 oHoL2Ji404/Lw5DeAihBhYGTrXfG6g9XVYAl5BVPXXaunVDPljtMrU+aSIjc1MWqRK
	 EQ+C56T69LcJXvu4qEI0ifULiP1kpI8I6J+UUseEqJdqc+L6CiOevvw9ZglJpaPBl6
	 RhjOY/dTlEfLQ==
Date: Thu, 16 Nov 2023 17:57:24 +0000
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v11 00/13] Add Realtek automotive PCIe driver
Message-ID: <20231116175724.GF109951@vergenet.net>
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115133414.1221480-1-justinlai0215@realtek.com>

On Wed, Nov 15, 2023 at 09:34:01PM +0800, Justin Lai wrote:
> This series includes adding realtek automotive ethernet driver 
> and adding rtase ethernet driver entry in MAINTAINERS file.
> 
> This ethernet device driver for the PCIe interface of 
> Realtek Automotive Ethernet Switch,applicable to 
> RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.

...

>  MAINTAINERS                                   |    7 +
>  drivers/net/ethernet/realtek/Kconfig          |   17 +
>  drivers/net/ethernet/realtek/Makefile         |    1 +
>  drivers/net/ethernet/realtek/rtase/Makefile   |   10 +
>  drivers/net/ethernet/realtek/rtase/rtase.h    |  353 +++
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 2542 +++++++++++++++++
>  drivers/net/ethernet/realtek/rtase/tt.c       | 2542 +++++++++++++++++
>  drivers/net/ethernet/realtek/rtase/tt.h       |  353 +++

Hi Justin,

Unless I am mistaken, by the end of this patch set tt.c is identical to
rtase_main.c, and tt.h is identical to rtase.h.

If so, why?

$ cd drivers/net/ethernet/realtek/rtase
$ sha1sum *.[ch] | sort
9762c7f0fc1acb214d1705905495fad6b902a3c8  rtase.h
9762c7f0fc1acb214d1705905495fad6b902a3c8  tt.h
ccfe889f5ae3b6ecfa0dfba91d30fd7beffd4291  rtase_main.c
ccfe889f5ae3b6ecfa0dfba91d30fd7beffd4291  tt.c


