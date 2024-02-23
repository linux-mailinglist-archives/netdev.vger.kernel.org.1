Return-Path: <netdev+bounces-74424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D5B8613ED
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B97B2159C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A17FBC5;
	Fri, 23 Feb 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZiOUqQb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F237D413
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698479; cv=none; b=KuO43n9+z2V7qovUK4qoVd9hto2alJ1rAOeNohlJXcali7rCSTxggppj9X+AnVGx1bdMLYVwo/ihpYLDBJC9MV0OWYeKPOPRl0+fB/HWbaExISb6kHSir26XjPVm0E3ica6kh006rsZBzemreVIh2UR0WWTlLOoDHwuHV/ftU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698479; c=relaxed/simple;
	bh=dUmWQ9n7sIkmFlhrGkOwc5gWZDmdaEyboZBntzW4NCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WS7LDyFPzhpvuBdswT9n+EOPAifPQXYmjXYld0t4gFRUgiHSpRO8f9Pc6IkLkR0GXHRmpkWTgaIcXaQ70wluaVIlAjz/Kz2N3Nc9srG2MhRPkO+tfxHtKpgIYuM9mTYO0WzZl7PXD+bLI4f3R2jvVK2SLJzmyriB1yn73xFOpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZiOUqQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D761C433C7;
	Fri, 23 Feb 2024 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708698478;
	bh=dUmWQ9n7sIkmFlhrGkOwc5gWZDmdaEyboZBntzW4NCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZiOUqQbiTzJhC4dRHtzLn3RJK5XLUqNdWgPFw8q92Ju9AwDwLcEzii9k4FzGpndb
	 ZNMQCIkQ0arvoOv3HfYqBhVvbnAnYZwC4NRKgHaY6tCf31tHEyPS4XM9yehTpXs9Ap
	 kJtuYwlEChOKtOy86qGFE6GcoUfpRaMoGkvSGFiPq9CKQCbW/dbzChIArFjQW5YMLx
	 2B7avkBHfIw1lAK6vRtZ1VcutYZx3pZ8rq6VJWRj3dIVTOAa1KrYfkJdODze/EvZCa
	 AManKNhaPZ2qqjJYgyAtHrEkxw7MqhpYy2aSzjwEEl6OA5QhIfIECVmIx+KK7PXTsr
	 Sg023Gj/g7yog==
Date: Fri, 23 Feb 2024 06:27:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <20240223062757.788e686d@kernel.org>
In-Reply-To: <ZdhpHSWIbcTE-LQh@nanopsycho>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
	<20240219100555.7220-5-mateusz.polchlopek@intel.com>
	<ZdNLkJm2qr1kZCis@nanopsycho>
	<20240221153805.20fbaf47@kernel.org>
	<df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
	<20240222150717.627209a9@kernel.org>
	<ZdhpHSWIbcTE-LQh@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 10:45:01 +0100 Jiri Pirko wrote:
>> Jiri, I'm not aware of any other devices with this sort of trade off.
>> We shouldn't add the param if either:
>>  - this can be changed dynamically as user instantiates rate limiters;
>>  - we know other devices have similar needs.
>> If neither of those is true, param seems fine to me..  
> 
> Where is this policy documented? If not, could you please? Let's make
> this policy clear for now and for the future.

Because you think it's good as a policy or because not so much?
Both of the points are a judgment call, at least from upstream
perspective since we're working with very limited information.
So enshrining this as a "policy" is not very practical.

Do you recall any specific param that got rejected from mlx5?
Y'all were allowed to add the eq sizing params, which I think
is not going to be mlx5-only for long. Otherwise I only remember
cases where I'd try to push people to use the resource API, which
IMO is better for setting limits and delegating resources.

