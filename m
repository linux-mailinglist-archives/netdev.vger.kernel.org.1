Return-Path: <netdev+bounces-26519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6179777FE4
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA06281BFF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E0D2151A;
	Thu, 10 Aug 2023 18:02:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C221512
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4CBC433C8;
	Thu, 10 Aug 2023 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691690565;
	bh=QzkqRf6Xz43OVoXzm5ojqDiH4MwIbGsDsGuhLwqIR34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tslKUHzhbl5l3w/TcdRhlbcJG7f2okGpEZ6fQPGtqI7VMxeSOHJvpDiOaFlgtTKpw
	 8CCod1de2LYEtSvhzP46GnrinCUbZq9tUEhPiDXGxflsyWrwxtKIbQgmPzJ4DNTwtO
	 HrWjuX2YoPzrshnwxSw7A4WGEmN15GQjrzUPAOwmyF7ULBFxBLk1kPBpxo7FhCK8k/
	 hSqzRTeFkUyH/YurrqZjoWwqm8w+7prqNGUUWmvCI4n88ufw/pLp92Sqpv66RdUxBi
	 aMXOc6pjmVIx3lYGXWnCxgmBqaHLE/nnRC52qN3QSkL0UBXUKYf+XV1bGY4H+mnDQ4
	 8ddRQU/qb+A6Q==
Date: Thu, 10 Aug 2023 20:02:40 +0200
From: Simon Horman <horms@kernel.org>
To: Manish Chopra <manishc@marvell.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, aelior@marvell.com,
	palok@marvell.com, njavali@marvell.com, skashyap@marvell.com,
	jmeneghi@redhat.com, yuval.mintz@qlogic.com, skalluru@marvell.com,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 net] qede: fix firmware halt over suspend and resume
Message-ID: <ZNUmQKI2bcT98QQ4@vergenet.net>
References: <20230809134339.698074-1-manishc@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809134339.698074-1-manishc@marvell.com>

On Wed, Aug 09, 2023 at 07:13:39PM +0530, Manish Chopra wrote:
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
> Fixes: 2950219d87b0 ("qede: Add basic network device support")
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Manish Chopra <manishc@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> ---
> V1->V2:
> * Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS

Thanks!

Reviewed-by: Simon Horman <horms@kernel.org>


