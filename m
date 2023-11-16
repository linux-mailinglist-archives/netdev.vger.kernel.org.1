Return-Path: <netdev+bounces-48434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D007EE547
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8B21F251A3
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF3734559;
	Thu, 16 Nov 2023 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nEZnt2rc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09D43146;
	Thu, 16 Nov 2023 16:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E18AC433C8;
	Thu, 16 Nov 2023 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700152637;
	bh=QGjuNZrD+uRw5CuViihG4gkRO4nc7+UCIp3DDIGJCWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEZnt2rcF36Yic6XVYN9V7YFXGbOoN+z0mEYoVo86GMMaHQNLTfoLmnkzS1r4GHsi
	 wjR01MtYN5Si+JSkGzCStjEzj61iFNifWTQfZVVGci2KIDbHSt9XSIDJbaWHCpWYx5
	 Oz3dt/QRG2IGVOuZFFn6zsx7zrMf8jKbAnM6Jj0o=
Date: Thu, 16 Nov 2023 11:37:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 7/9] firmware_loader: Expand Firmware upload
 error codes
Message-ID: <2023111604-visitor-urgency-a97a@gregkh>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-7-be48044bf249@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-feature_poe-v1-7-be48044bf249@bootlin.com>

On Thu, Nov 16, 2023 at 03:01:39PM +0100, Kory Maincent wrote:
> No error code are available to signal an invalid firmware content.
> Drivers that can check the firmware content validity can not return this
> specific failure to the user-space
> 
> Expand the firmware error code with an additional code:
> - "firmware invalid" code which can be used when the provided firmware
>   is invalid
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/base/firmware_loader/sysfs_upload.c | 1 +
>  include/linux/firmware.h                    | 2 ++
>  2 files changed, 3 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

