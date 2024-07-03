Return-Path: <netdev+bounces-108977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE7B9266AD
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9B4B21069
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BEA18307F;
	Wed,  3 Jul 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsjR4EWu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75B170836;
	Wed,  3 Jul 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026224; cv=none; b=o8hhEZgaZ5ebpJYNFvLx9ke9oSyIqPeoMbnrVBtx+Fqe3Br/51BhSEjmCFZ+rpGu8QhgDliAH3CGTe29IvpQIg5kYHCm2P22fXHjUEsXUrOLsuykGiS2pZQXpb1FeGjSVgTZUdc65b7/mdASD8ZdnCp4LjsvmAc2kp+CtRDUmTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026224; c=relaxed/simple;
	bh=eG4hXBWlxUmQ7rJcyBWXvDQU0AevoqNlx1Qhy5g+EE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5c8kAH4EQq0voiinxLXsPgP+CEYuRJttfH8x9kOThTw9sJwNIHnaT7B5bEDlZRK6Mi3efZfveZE+boT+iJMW4F6s3vP2msQHlZQkMutjKQmbYTgTbzVjn2aEHNHiINqk0jnrLfYvzI0QkCecmZZg+Ou8d9bPKegYxBI4hEmaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsjR4EWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB08C2BD10;
	Wed,  3 Jul 2024 17:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026224;
	bh=eG4hXBWlxUmQ7rJcyBWXvDQU0AevoqNlx1Qhy5g+EE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsjR4EWuo1HukIkNJdsDvczvCDpchZmdpDQhZh5NgOjXgXtonRdmnAISYPZ/CwOi1
	 0rijqTD3LPHTiZRfeaqdWjbrCSMCHiAowJR7MKqjJ2aeCZPaIsVUF+GunqV0LdI3mQ
	 pUtKRpsK4jIKEg4dYBHNCCkHPXM/vLhM6vZIXJ35szEsB3LvXJcxLetSbOSrQdjYab
	 A77qUb5Vg2eTp2gQ2MTsYY4uazKQ22Xi+QLZjmGkObx83OQwXfZ1e0z8vBrERIJ1vV
	 8v7h2rKO140+PFTFshKg3ueg0JE+6V0aN8M0QsStS8lXeL1aXnrgA7TplQsC1sAZP6
	 vajMSKlEp8hPA==
Date: Wed, 3 Jul 2024 18:03:39 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 08/13] rtase: Implement net_device_ops
Message-ID: <20240703170339.GA598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-9-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-9-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:58PM +0800, Justin Lai wrote:
> 1. Implement .ndo_set_rx_mode so that the device can change address
> list filtering.
> 2. Implement .ndo_set_mac_address so that mac address can be changed.
> 3. Implement .ndo_change_mtu so that mtu can be changed.
> 4. Implement .ndo_tx_timeout to perform related processing when the
> transmitter does not make any progress.
> 5. Implement .ndo_get_stats64 to provide statistics that are called
> when the user wants to get network device usage.
> 6. Implement .ndo_vlan_rx_add_vid to register VLAN ID when the device
> supports VLAN filtering.
> 7. Implement .ndo_vlan_rx_kill_vid to unregister VLAN ID when the device
> supports VLAN filtering.
> 8. Implement the .ndo_setup_tc to enable setting any "tc" scheduler,
> classifier or action on dev.
> 9. Implement .ndo_fix_features enables adjusting requested feature flags
> based on device-specific constraints.
> 10. Implement .ndo_set_features enables updating device configuration to
> new features.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


