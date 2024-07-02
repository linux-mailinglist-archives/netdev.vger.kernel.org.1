Return-Path: <netdev+bounces-108550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A71924275
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860FF1C20A9F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2901BBBD0;
	Tue,  2 Jul 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO8T+rxM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D11AD9E7
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934418; cv=none; b=idqfWTatGDAecBhcnPuBTmPZXRJADpSrwh2hKvLc3DTtbUpbHRU1745H7VSdEG8KlryYi2fofQmj+rl/odKlst3Di50gC/qxRpgrMzG7FWhWRiENQYhKlzjMTX/VZeI7PRBWvl8ypdrp2HNzQQFLd3jCHHkcspaH5sq7xDQo/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934418; c=relaxed/simple;
	bh=QtFQgStn7dzJh7XpZn79afYyM1u1Xf/ZYoQ0douzN4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KVXdnfRTUat06gFohCPymZx89mDW3NolXBx8rer4zMrYPLOByH9uHZrODFY7VwO2ppDcAttLgj10cQ+Oug9U9JOPcZE5rHjHemViUTPwGUs+H68h0Ai0+x6j7PidSR2MFtKNc6NMEh48t8mKUPTWL+1y1XnvsS6VojkK3xLjE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO8T+rxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6662BC116B1;
	Tue,  2 Jul 2024 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719934417;
	bh=QtFQgStn7dzJh7XpZn79afYyM1u1Xf/ZYoQ0douzN4U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TO8T+rxMmnASVAAfLNB0+/n1UML0HqjjgTSHAONMX9TgHpFKJxUwLJQY09UTTFW4D
	 ChZIG++jx51w7B3dIyxcvlUooKxK4cgVueB4tfZz23kW3F21jLcN7Owx3MqjMEGk6Z
	 TmVKJWjgRd3dgNVdeh4mwRKDW+7XtVcQBsX4EcKoqghN0JKc+2haLeGYmBsYrPde/U
	 2PUK2Bg9Z7Q5XTbeQ78EYpK0/fP++80n2v3lqpEzmQNDS2vORoAmw1Wu9/Ycn/e71b
	 GndPtXuhAmA4MLlmCZ1zWf4oFWyUpmGiKDCsI2Opr8sD4IL9GqzsEzmTCoYA2Dtob1
	 mfuLR4NpHiErg==
Message-ID: <8cf52a65-1397-42f4-8e81-34e45dc7cfc5@kernel.org>
Date: Tue, 2 Jul 2024 09:33:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] netdev call - Jul 2nd
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20240701132727.4e023a1e@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240701132727.4e023a1e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/24 2:27 PM, Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> 

URL does not seem to be working.


