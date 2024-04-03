Return-Path: <netdev+bounces-84259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5EE896296
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 04:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3625B282A77
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02518168DE;
	Wed,  3 Apr 2024 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAWSzlC7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290EE56E
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111753; cv=none; b=bGQKCVJ+1dt8n9wqFHm8cRcx012qX+gKrxxywPAdqqjZec0jlTQ9iceOOechznycxeolUIDq1VpJD1AyLpH/0UzVNta7r9NdoEamdcG+/RMsxYCwmNcDRY3KuG9PGujNNyOcyUUFDAvEEZrUHh5vUyRIY9SpZDpxBAfE+vq0Pa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111753; c=relaxed/simple;
	bh=qw1OS9ZdE4/nClA9/Md9MQYxCcjt5VNEzb7EeEIK1gU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpmVZpsupln3nyg6Lr38WxqahFkWPwe09kRNqGGH+KZ1PI9Tk1YBOPAAm28YZ9a6hVnNLauhO+t+aT+tIW3WChKicMNDk43hQrv2VAscj2j5QvREvWOt33j6VcnvgizaWTOzgOuBP8qQVR+JH1Rpy9Ug8UHfn3RJ0wN1jidn4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAWSzlC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B11C433F1;
	Wed,  3 Apr 2024 02:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712111753;
	bh=qw1OS9ZdE4/nClA9/Md9MQYxCcjt5VNEzb7EeEIK1gU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aAWSzlC7o92QTs0PLxETHm0pJTsPIsYfKTSlW/4pVuyUU+kE5ugPopfG/4yT65fTs
	 Sj3CBHAjWq3OAE2kNjiXyvX7KPzkpII+pHpib9hbwLSS/E759aNoqGU4wrp0olvCoe
	 3teztzgEiJBzj1FNGlDVrYwNbDZVTF+IZzRV/WmGjx/C1c0tYPVoTT9hlWwZ/UAH0X
	 PYYGSQbIjv/yS89mjeNOv+NouafTRtt09+9vI3R7nGMJ9B/r/O0T436lc/2Jisz3QF
	 NvaxMllpq5CNj9G/Atvmvkq4cQ7WYAbx73u4XBZ2JKYB3/ab5S7/9DbPIUbWOwrQFf
	 6DZPVdRBtsRIQ==
Date: Tue, 2 Apr 2024 19:35:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/2] ynl: support binary/u32 sub-type for
 indexed-array
Message-ID: <20240402193551.38a5aead@kernel.org>
In-Reply-To: <Zgy-0vYLeaY-lMnR@Laptop-X1>
References: <20240401035651.1251874-1-liuhangbin@gmail.com>
	<20240401035651.1251874-3-liuhangbin@gmail.com>
	<20240401214331.149e0437@kernel.org>
	<Zgy-0vYLeaY-lMnR@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 10:28:34 +0800 Hangbin Liu wrote:
> I didn't check other subsystem. For bonding only, if we don't have the hint.
> e.g.
> 
>   -
>     name: arp-ip-target
>     type: indexed-array
>     sub-type: u32
> 
> The result will looks like:
> 
>     "arp-ip-target": [
>       "c0a80101",
>       "c0a80102"
>     ],
> 
> Which looks good to me. Do you have other suggestion?

That doesn't look right, without the format hint if the type is u32 
the members should be plain integers not hex strings.

