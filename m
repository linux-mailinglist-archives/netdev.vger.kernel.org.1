Return-Path: <netdev+bounces-32718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC70799B31
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 22:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84F11C2087B
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347B67496;
	Sat,  9 Sep 2023 20:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870C1377
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 20:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F18C433C8;
	Sat,  9 Sep 2023 20:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694291795;
	bh=Xf+w8zYhiUqzWIg+UadRkXGxIMQHclTc1NmTatQavRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i31qxi4GuNH8wOSOiAf4qGMzeCsKUMFdvp6wowD5imberHgmz7j79h/dOerZZVKT5
	 jMW8km80RHetnpmD2aq3QuVHc31FhJ9gKaxUOUBqg1x/42sND+8sAry0rVLgIB8KFY
	 ZBWI1BIxqU0zO0Qd+2wPiJ9jk2QUOQn488Qjr01REl13Qcd8hjO81hVRPFjvHZfTYX
	 yCAzNVaCu6pmn2nW4ObxveIAbKNqaUWJ0N0V8GY091rQCVUTMQtDMfgMTj6iiXNfof
	 tXCl83QlV5DDSBxK/9ZvL746bQycKlBDpC/8u+kQIWf6oDNPWOZsvIw6Bg7eqb01pl
	 7uWBZbZXneaQg==
Message-ID: <27fa265e-eb89-7438-7796-9fc39bc63f5c@kernel.org>
Date: Sat, 9 Sep 2023 13:36:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] vdpa: consume device_features parameter
Content-Language: en-US
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: allen.hubbe@amd.com, drivers@pensando.io, jasowang@redhat.com,
 mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, shannon.nelson@amd.com
References: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
 <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
 <060ee8d4-3b78-c360-ac36-3f6609a5da89@kernel.org>
 <b4014822-48af-ea9e-853f-0a0af3fc47ed@oracle.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <b4014822-48af-ea9e-853f-0a0af3fc47ed@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/23 12:37 PM, Si-Wei Liu wrote:
> Just out of my own curiosity, the patch is not applicable simply because
> the iproute2 was missing from the subject, or the code base somehow got

most likely missing the iproute2 label in the Subject line

> changed that isn't aligned with the patch any more?
> 
> Thanks,
> -Siwei


