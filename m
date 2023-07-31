Return-Path: <netdev+bounces-22715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C45C768EDE
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBD51C20B64
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E263A2;
	Mon, 31 Jul 2023 07:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25E612C
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 07:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001D6C433C7;
	Mon, 31 Jul 2023 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690788785;
	bh=ZwKZS0bLTyf8mihvJXFDGn7ylNI9iRCV2TKg/Z6yhBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KshohDWOy8x6NeVf+J0o2gYUY2KTWH51sQsBsaMOGiZGxk/H8AGKJOVECpOo8U8Op
	 vzdZJzD9DDSaA/NjU3Z38TlY0J6MaTcXPVWFwLiPZVTh9frdRURiI4wPtK+w/nYzLT
	 mrqKgtHxNk5PHOOl3k7zH8X3halVF3G+2bEdWn49yk9BLraw4Et2wGERf4vdueWuin
	 pp7K9/L8miD5uhC8z1CqfyCnJUiOr2ikQjsCjK60S0kKQlm9liDQi8Bl+CvBWdRAAY
	 6B2k2z5ZkHL/RsCNfVtcjtfrNC3kkLsVCfNZybg1ryOBoPecnjhp/viRhQFDrC4qUY
	 fSBPpKIE/eckA==
Date: Mon, 31 Jul 2023 09:33:01 +0200
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: bcmgenet: Remove TX ring full logging
Message-ID: <ZMdjrXBiyfixTGRn@kernel.org>
References: <20230728183945.760531-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728183945.760531-1-florian.fainelli@broadcom.com>

On Fri, Jul 28, 2023 at 11:39:45AM -0700, Florian Fainelli wrote:
> There is no need to spam the kernel log with such an indication, remove
> this message.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



