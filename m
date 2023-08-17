Return-Path: <netdev+bounces-28326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E60877F0F1
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5694281D9F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0B138A;
	Thu, 17 Aug 2023 07:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518615AB
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D087C433C7;
	Thu, 17 Aug 2023 07:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692256301;
	bh=yv2TAjno/2XSqR01RSo83cWXb8Ohcy5ubt63pFTBP08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/To5bK/mHhMFGnVc16virPz8qxig0+v5u8nfohVKP7TlQWZFC+RGDeCsPrzY070u
	 Pr2mYyskfZ0i86DjrX6IK8lLhbrpZrwdJ+vpokolHUM3PBBHLNSZFP8ATsW8JII97h
	 zwz/H3dYSyhuKsit1eeka/GKOQ04LRzzqXJGU6XzoRAosoE0tN/KQ26S+akys+69L7
	 nEXhQW1l/IMFyPwaV9ILuMWZtS8CIomoj5J+pdWpuyFRJt7bi0oM8bzeoOW1nnNqzv
	 03R7uvl6SFcW5wAHYmS4yhT5I7t2fn4gxOm2QqczI+24G+wLQPyTJ8u6NrttlaZd49
	 itR5X0Zi6YcOg==
Date: Thu, 17 Aug 2023 09:11:36 +0200
From: Simon Horman <horms@kernel.org>
To: Manish Chopra <manishc@marvell.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, aelior@marvell.com,
	palok@marvell.com, njavali@marvell.com, skashyap@marvell.com,
	jmeneghi@redhat.com, yuval.mintz@qlogic.com, skalluru@marvell.com,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 net] qede: fix firmware halt over suspend and resume
Message-ID: <ZN3IKMw/lz0Extx0@vergenet.net>
References: <20230816150711.59035-1-manishc@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816150711.59035-1-manishc@marvell.com>

On Wed, Aug 16, 2023 at 08:37:11PM +0530, Manish Chopra wrote:
> While performing certain power-off sequences, PCI drivers are
> called to suspend and resume their underlying devices through
> PCI PM (power management) interface. However this NIC hardware
> does not support PCI PM suspend/resume operations so system wide
> suspend/resume leads to bad MFW (management firmware) state which
> causes various follow-up errors in driver when communicating with
> the device/firmware afterwards.
> 
> To fix this driver implements PCI PM suspend handler to indicate
> unsupported operation to the PCI subsystem explicitly, thus avoiding
> system to go into suspended/standby mode.
> 
> Without this fix device/firmware does not recover unless system
> is power cycled.
> 
> Fixes: 2950219d87b0 ("qede: Add basic network device support")
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Manish Chopra <manishc@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


