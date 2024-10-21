Return-Path: <netdev+bounces-137455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6BC9A67E2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027CE1F222F2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7B51F473E;
	Mon, 21 Oct 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GwQw+G+M"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006221F429E;
	Mon, 21 Oct 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513058; cv=none; b=hohg0zcPoKj44Gt6fIUbG9ycOGpup40PuT10cZvY4MW/vilG1CAu2M84PqvFkFmFNIpEo/Jy/xaU6nGqN/+MHXQJMlH+mrt0GiPz51Ba4MBNxpJg251+iWnAVPrEJtXnaHs5rmz2rSi9oXqScMOV0s3mW9/+ECEg1lfaZIX4csA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513058; c=relaxed/simple;
	bh=ujbXw7vejmRZ9o6zJBfdBwm0wEDn5AWwnG56UXmaBlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyFET+igfMSdeU/DCDYv7AtYS4l5AKcAvZy3z4HuhOjhGnb0TT63RrWMJVNNuTxwstVeWrqMRT3uQxgoIyxJh5mBZ3NGO7XXg7XyB4inQlvDyna7TGKUt8vw5v3m1IuY5IuKZ95eMpG4tYk5dAkfp3xgNW+3lMqTlG0hxlLG5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GwQw+G+M; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729513054;
	bh=ujbXw7vejmRZ9o6zJBfdBwm0wEDn5AWwnG56UXmaBlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GwQw+G+MUTYxZMJPwdXQsoDJHrIl6mSPOyA1rYqOmJ1eidGZONpqWlY3f+Jd5ypvs
	 khYewhHEjKXQG9Pjs085kKFo8yf4NpGww3wB/9k00wV97618W5cKk3wj92Y8Geew7O
	 KaW5ccVg2ow599sItmnP+0A7ag2asIpwhh2QDAL5yVV0OyAWd8bYOYZ+vxeuCtTeiZ
	 6Ypgmqk4jthdiCMIWkqtUP3AxlJTw5sI2aljmNLysxSakn+LHpf1uWqV6mgKPkL+PQ
	 Dwdu0y4I8XaQBjTtiGHn6qHoAshWOaJd2VoHMoGlcloMScy5hU/SeHwVR2va/devGH
	 7ZmilP7uugRTg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C69517E35D9;
	Mon, 21 Oct 2024 14:17:33 +0200 (CEST)
Message-ID: <1c54febc-4031-4706-9cfa-ecf090854691@collabora.com>
Date: Mon, 21 Oct 2024 14:17:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: mt8188: Add ethernet node
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Jianguo Zhang <jianguo.zhang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Hsuan-Yu Lin <shane.lin@canonical.com>
References: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
 <20241018-genio700-eth-v2-1-f3c73b85507b@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018-genio700-eth-v2-1-f3c73b85507b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/10/24 17:19, Nícolas F. R. A. Prado ha scritto:
> Describe the ethernet present on the MT8188.
> 
> Signed-off-by: Jianguo Zhang <jianguo.zhang@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: Hsuan-Yu Lin <shane.lin@canonical.com>
> [Cleaned up to pass dtbs_check, follow DTS style guidelines, removed
> hardcoded mac address and split between mt8188 and genio700 commits,
> and addressed further feedback from the mailing list]
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



