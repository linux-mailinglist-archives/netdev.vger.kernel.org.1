Return-Path: <netdev+bounces-12433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63C7377E5
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 01:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98331C20D0B
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 23:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F60C18AED;
	Tue, 20 Jun 2023 23:12:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D41800D
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 23:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA044C433C0;
	Tue, 20 Jun 2023 23:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687302773;
	bh=/5bo5g8W/lm+VG0x/hbqsgLrUWsHXxhUqcF2voXbXaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecuBldW1MvxlzxJCGJu7MuN+UooZhW2XgN/sTn8vil32wpc2DSVeX1y5MQ+XlMOtE
	 20bi7GSxt3neVcORbjudncSX91n3XQ5IQvoBRxry6j4J5vqh9e0orakpxAPgZA+0ik
	 +xVgd2D8AQiXpl8NWb+ZFjkV8PuW7IRwQYZgGd/vJCHGiN2P/o+eJqmwG09bdBjuMV
	 AJju+DAOliwcjI1+dGhCSToLHa/LqNJE1jjeFj0KYs1YkaHtiWQ/9C6ARTMLg+8OOn
	 rZSES3KnxefFtkUu47U7Bs7csUdVpIbA2sr3sZxrB/fxpiSnvEhl2Yjs/5kPM2/yOh
	 +Nje54+2iBFBQ==
Date: Tue, 20 Jun 2023 16:12:52 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Miller <davem@davemloft.net>,
	Networking <netdev@vger.kernel.org>, Shay Drory <shayd@nvidia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the net-next tree
Message-ID: <ZJIydCHR5dB3PoKO@x130>
References: <20230613163114.1ad2f38d@canb.auug.org.au>
 <20230620091547.43aae17e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230620091547.43aae17e@kernel.org>

On 20 Jun 09:15, Jakub Kicinski wrote:
>On Tue, 13 Jun 2023 16:31:14 +1000 Stephen Rothwell wrote:
>> Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst:57: ERROR: Unexpected indentation.
>> Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst:61: ERROR: Unexpected indentation.
>
>Hi Saeed, what's the ETA on the fix for this?
>
Hi, I will provide a fix by tomorrow.

Thanks.



