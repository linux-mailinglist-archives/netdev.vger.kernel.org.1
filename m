Return-Path: <netdev+bounces-150420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3FB9EA2F4
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF2A16675D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4342224899;
	Mon,  9 Dec 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kztj4lA8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0119B3EE;
	Mon,  9 Dec 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787632; cv=none; b=CJcsU1aJcDOgUmLw3LrYQI0X1a/TIK5UQBlNSkNNjLTlX84FNzaDVCaTfyUyp9r0r5ICrPIVM0a4ZVZRhz1C81/9bo5xZC2rd1+c7z60YqK1vINNFZNsYyX4eAOJv5FNq+iLopBFDklhdEPPnztQD+eufablqNJ30IYsd/rc7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787632; c=relaxed/simple;
	bh=BA3duGjUYPvGt2f4+K5L5RH1loqbyxLxJMRIpyaILmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTMwlQweUMA95E/h/8e7fl2+TcrsfVENAKzmIBpgj+cm7vRrVJhlLV3LhGwKu1DIMugjNKiIsHGqMq5usmmBKGRBfFNLbN4LF1k2WdjxwxkFAK24+WLP3cdZkhgfeX0NVQRbpDiHZtoNBUrLGI+z6r4tNMOZrq3uLP0hQfTmm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kztj4lA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CABC4CED1;
	Mon,  9 Dec 2024 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733787632;
	bh=BA3duGjUYPvGt2f4+K5L5RH1loqbyxLxJMRIpyaILmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kztj4lA8lDAmSnUT5tJAv2cjEFrlBhTk0sI+1anlxEucU7S3ppmCiiWp5j4UokfY5
	 m2BSlb5gR8sB7vJTcTjbsusvlp3qeZySOwq+xumA8ySDM1kPDzfUE3UC28tuXfdOyu
	 h9nNK1YCihA7AkI/xYMpeyyJxxf7458SLNL4wVNwRdACYpZ7SqOup4EI6ovshHP8ue
	 bUE/M59+4CE35vCbPFYegUUYE71neBMWZK/ac0t4DUOfz6rZf1CEdOYHKAGhr1VfCj
	 6CxapaXrpuDI4Lupv+e3t3V242MpkykZGjpXu5omW31b4jYWhtn/ZVMAlPgZ+UFFBx
	 bp7H1SQcIDumw==
Date: Mon, 9 Dec 2024 15:40:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <olteanv@gmail.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [net-next PATCH v11 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20241209154030.0f34d5dd@kernel.org>
In-Reply-To: <67577bd7.7b0a0220.1ce6b5.fe93@mx.google.com>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
	<20241209134459.27110-6-ansuelsmth@gmail.com>
	<20241209151813.106eda03@kernel.org>
	<67577bd7.7b0a0220.1ce6b5.fe93@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 00:22:59 +0100 Christian Marangi wrote:
> Also hope we won't have to request multiple stable tag for this multi
> subsystem patch. Any hint on that?

Sorry I haven't payed much attention to earlier discussions.
Why multiple stable tags? AFAICT all trees will need patches 
4 and 5, so we can put that on a stable tag / branch, the rest 
can go directly into respective trees (assuming the table tag
has been merged in). No?

