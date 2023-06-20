Return-Path: <netdev+bounces-12374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E245873738D
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 20:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1ABD281396
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62F17745;
	Tue, 20 Jun 2023 18:12:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A462AB5D
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 18:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C45C433C0;
	Tue, 20 Jun 2023 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687284762;
	bh=d6HqvUlVxX8pKRJNTswSkal7YXJ0HM0W5Thip03LgF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iCrv0pPlbuRGKVA8FpAamMjgYkah5B7wKQjMOyzq7Cigmz0tHJQ7HVT4pA5w0tXMS
	 NlWerblEUcXg6yNrG1Z+Dwr+cbRJvQZwNhoTiDB3M2Sza/t/gOHZH098r/SqnWRDvw
	 O5CBdDQ2amk3LIIX7kulIwa1cYfMV7/q1C9d+hQ8iCvLcK5t0xdmtVxr6tehDC55ms
	 RjuCHtJDBxs7zW4dmmrfcLdPgXS0DcJrc81jEdptCCkHxvOs2/L36W5lAfggrGbpl6
	 R9ZV3Fsfp5AlHvrzu117qaPh4AC4h93ipjjgDQu0SYVRvy2JiZ4Q9sBvfkWVRYuKWl
	 bHlcjAtXrVPfg==
Date: Tue, 20 Jun 2023 11:12:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 wojciech.drewek@intel.com, jiri@resnulli.us, ivecera@redhat.com,
 simon.horman@corigine.com
Subject: Re: [PATCH net-next 00/12][pull request] ice: switchdev bridge
 offload
Message-ID: <20230620111240.24b1f6a9@kernel.org>
In-Reply-To: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 10:44:11 -0700 Tony Nguyen wrote:
> Linux bridge provides ability to learn MAC addresses and vlans
> detected on bridge's ports. As a result of this, FDB (forward data base)
> entries are created and they can be offloaded to the HW. By adding
> VF's port representors to the bridge together with the uplink netdev,
> we can learn VF's and link partner's MAC addresses. This is achieved
> by slow/exception-path, where packets that do not match any filters
> (FDB entries in this case) are send to the bridge ports.

Hi Vlad, it would be great to have your review on this one!

