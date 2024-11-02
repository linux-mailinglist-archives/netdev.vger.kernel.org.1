Return-Path: <netdev+bounces-141209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C819BA0D1
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF92E28253B
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D7518B477;
	Sat,  2 Nov 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtI2VunK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8707175D47
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730558304; cv=none; b=ds2n9Is54WWnVHHMSjAdx8S5+9kqoVNmmVAn03Lb03qBd+u1wDyLeQADpTqjITYJCIRBD5UN8GGeLcFlcb9trLvOe1IgGAiQvxBTwVpjVA0NQP6BVLl4ieGgcUd+8QY/ArbS0K6IOLsOSExM+0t84wuPPMgd60zyRnOkk80C3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730558304; c=relaxed/simple;
	bh=+N+p9T5iVSPg9AVXsMwjJAI3S/vgv/iNp2VTOBZkfdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=af/T+89oQ8kKjBzIfzBN0Aw3nkJYVFY6MAjNhMYs6cnZCpOtC4L5DM4PpCipuPBJymHI2JLIvL92sDNXJTVvWEtClmypTVWz6LALnxEh14gHlR0c30o4kQLB4RJmBuqAIVMUKgyj4klPDRX0y1bydpIp5t+8jQM1HBmlZzgXvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtI2VunK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF18C4CEC3;
	Sat,  2 Nov 2024 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730558303;
	bh=+N+p9T5iVSPg9AVXsMwjJAI3S/vgv/iNp2VTOBZkfdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RtI2VunKTSYj7mLSSq4wP/VDU7Sc8KNK9EzVrMeMqqQsiitcFGJpAhyVxVfCZiNh+
	 DbS2eKYCc/3PxwylDoDR/ZYFQHTnO2EwK1l16icDEd2lyBmpf1dtTulbDxnUp00CTr
	 H/7h9Gz5EnZ71DR1oD0tz6JAS5VtlI7s1AYpUZb5QLI6t2ogChLF5zKZ2hSgZNi/nE
	 Xbt9npfTeCSEkfkuQ8QkzzQ8tpK4gvRA51AkxBdlLah7LecAHqSrlWXwTd0w9sZ+i+
	 G7/3qrCNcstaGc/8e7NDSufO8LiYYRi6V2IwNmtVVO30JH4qQJ038qnECNBPRDJy2f
	 kstrBSFjPH00A==
Date: Sat, 2 Nov 2024 14:38:18 +0000
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, david.m.ertman@intel.com,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: change q_index variable
 type to s16 to store -1 value
Message-ID: <20241102143818.GM1838431@kernel.org>
References: <20241028165922.7188-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028165922.7188-1-mateusz.polchlopek@intel.com>

On Mon, Oct 28, 2024 at 12:59:22PM -0400, Mateusz Polchlopek wrote:
> Fix Flow Director not allowing to re-map traffic to 0th queue when action
> is configured to drop (and vice versa).
> 
> The current implementation of ethtool callback in the ice driver forbids
> change Flow Director action from 0 to -1 and from -1 to 0 with an error,
> e.g:
> 
>  # ethtool -U eth2 flow-type tcp4 src-ip 1.1.1.1 loc 1 action 0
>  # ethtool -U eth2 flow-type tcp4 src-ip 1.1.1.1 loc 1 action -1
>  rmgr: Cannot insert RX class rule: Invalid argument
> 
> We set the value of `u16 q_index = 0` at the beginning of the function
> ice_set_fdir_input_set(). In case of "drop traffic" action (which is
> equal to -1 in ethtool) we store the 0 value. Later, when want to change
> traffic rule to redirect to queue with index 0 it returns an error
> caused by duplicate found.
> 
> Fix this behaviour by change of the type of field `q_index` from u16 to s16
> in `struct ice_fdir_fltr`. This allows to store -1 in the field in case
> of "drop traffic" action. What is more, change the variable type in the
> function ice_set_fdir_input_set() and assign at the beginning the new
> `#define ICE_FDIR_NO_QUEUE_IDX` which is -1. Later, if the action is set
> to another value (point specific queue index) the variable value is
> overwritten in the function.
> 
> Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

This looks good, although I am interested to know what the maximum value
for q_index is. And, considering unsigned values are used elsewhere, if
using 0xffff within this driver was considered instead of -1.

That notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

