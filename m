Return-Path: <netdev+bounces-236954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01BC4273A
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 05:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFD9F4E11AB
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 04:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401B1265CD0;
	Sat,  8 Nov 2025 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM20A4u6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FF25A338
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762577605; cv=none; b=S+UeG6uCgybrkURMxyqeoHIEliVOuq/RrzASqVMc2CMiqQQr1Jz7DL8NJOriC3E7jApANKZImd5Ko2bc7TZo+6bc6JbcY5lLGbssRqBJpVF7tMS+TN7I0lDxb07Fmjo6lwM0oNpqMymlwuGES0Whr67JQThYatVwMn/ov6f8WUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762577605; c=relaxed/simple;
	bh=vJX0eIUZFxC2hINVpsQowlxvjsyJ24VZq9eHNoCM3xA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zg+dqnOzN82NAot/1yaJouJ15WnFRjvH4sSKkSgudRXvRpHSY6wcmGke49lsVlD2UwkvjoZpfu2iw0WjvH2pO44JKlm3AHkeZwwj0sXndNJVE8KyEGFjMuluC3VKW9gA6N2l9eimV5wmXUkbD0ir25N/aro7vEVkq1Wrrm7jIUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM20A4u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE7FC19422;
	Sat,  8 Nov 2025 04:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762577604;
	bh=vJX0eIUZFxC2hINVpsQowlxvjsyJ24VZq9eHNoCM3xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UM20A4u66qpmNUJCsPLyyvBZ6/xvz6XO3qjLH2C6W1VpREP5NgJbzjW870Pk0f+Ju
	 hYYZlQq7yUibv6OT3LVW3bkK7UAORTtVMBm4BNags4X7GAbnOI9CxykHn6TdSWqm9+
	 b7oxFcuEg0IeS1qTK29SLslG+P8CfsAlp3PrtyfiSR9vDpfcbcwsYub+0Z6ZeLwShR
	 +aobIxAtGOPVjlfkuWcUtOniwMrpSpofsBWVdN7YBo5qHVb0qGHN1kZxfnz50Gb5iF
	 rcKEkM4RLM5fbPBF3tMe3dExV5is1XxhPk+MdoMGa/Dk+/oNUkGGpQYgIcXKnBrDlw
	 xFU8NAtH/ZjZg==
Date: Fri, 7 Nov 2025 20:53:22 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	mbloch@nvidia.com, Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next V2 3/3] net/mlx5: E-Switch, support eswitch
 inactive mode
Message-ID: <aQ7MwqRiCsR6aNq3@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107182813.737c2d73@kernel.org>

On 07 Nov 18:28, Jakub Kicinski wrote:
>On Thu,  6 Nov 2025 16:08:31 -0800 Saeed Mahameed wrote:
>> +	if (IS_ERR(table)) {
>> +		esw_warn(dev, "Failed to create fdb drop root table, err %ld\n",
>> +			 PTR_ERR(table));
>> +		return PTR_ERR(table);
>> +	}
>
>cocci says:
>
>drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:2397:4-11: WARNING: Consider using %pe to print PTR_ERR()
>

I was planing to do this now, but then saw your message bellow :).

>While I have you, could you please help this one along (dare I say,
>first, due to the extack propagation?):

Sure, what do you need just review? I see that the series is straight
forward, but let me take a deeper look.

>https://lore.kernel.org/all/20251107204347.4060542-1-daniel.zahka@gmail.com/

