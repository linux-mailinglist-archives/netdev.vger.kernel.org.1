Return-Path: <netdev+bounces-14452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161727419C8
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 22:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF2B1C204AB
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5D107A9;
	Wed, 28 Jun 2023 20:38:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3CDA23
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 20:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6642FC433C0;
	Wed, 28 Jun 2023 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687984732;
	bh=gbPT71ueY++FFfVXPWNZrmY/iVBXkebDJfbxtxDqAos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RVB0Q5g7c4ziMQpA+WWA5mHPsxbG/HdkbQzBw7h7oGeOgDx8cR13jpz6gIM5tDwuU
	 F8pas0DFfgTlIC9/yxDgYpOEcA/O6duWjIZ35tSDOiw6Vjm/4ADx6wGjeLsq87LB8x
	 gqfOjQQbyiUL8Z4CCTx/6Dz5sMxrkv/mU7Ww/OompYY/6dJj3eXH7JdTjgbHEbAuWo
	 gNEhKXyzf9i9tXUvtkfvLYNsy0rNTCNszihcdAR3TsyXHIDIQ7nd85Gpc7D0MY36xf
	 i/d6OPBccRcCHqLyLktT4kD9OyVhgmGSw3rIR3TKN7JeH4oUVouQF4w+m8vbQRoaZs
	 W5pd9NY74h9xg==
Date: Wed, 28 Jun 2023 13:38:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Saeed Mahameed <saeed@kernel.org>, Gal Pressman
 <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>, Nathan
 Chancellor <nathan@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
Message-ID: <20230628133850.0d01d503@kernel.org>
In-Reply-To: <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
	<7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 03:16:43 +0200 Andrew Lunn wrote:
> > +	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
> > +		if (!info->adjphase || !info->getmaxphase)
> > +			mode = 0;  
> 
> Maybe it is time to turn this into a switch statement?

I don't think we can switch on pointers in C.
The patch is good as is, right?
(The tree we'll pick appropriately when applying.)

