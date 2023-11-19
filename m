Return-Path: <netdev+bounces-48972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CC27F03C2
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 01:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F850280EDA
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 00:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166336E;
	Sun, 19 Nov 2023 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogU1lkuB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CC3367;
	Sun, 19 Nov 2023 00:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2133BC433C8;
	Sun, 19 Nov 2023 00:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700353335;
	bh=njhZ+VEXY43nM/ztzb1ihZasqdd6Cd8C+mifV4uY/i8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ogU1lkuBP7h3e4Pzq67ZPDXlPApu6eBJFWXVCwbtfba0b6iRlchETP6JbVXt2Kg84
	 WZk1ID/f0CPrv4pqA0cFpbM6CD2vfLwYyXNFHF0caNHVbUBFKA2xzPmG2C8foB+24A
	 RPnMARKe0y7cL6DzwBSiqWCXhErVcnGHSFb7MUCG2zk7jFXAaVKLPiltp08JGmHpB7
	 B1QVwwqNMEfvL5Vx6tdlZQIHR7TqrYaHPZziEtgbJn1C4GiUkiCf3X8GZj/N2bRWcK
	 fic+xmWgPANV0O9gwxO5dLDpwlMzmyNWqsoLqQXjk2UjsuYY810GFeH9mrD/awKNP6
	 ZSP1DPLEUqe7A==
Date: Sat, 18 Nov 2023 16:22:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] net: phy: at803x: add the function
 phydev_id_is_qca808x
Message-ID: <20231118162214.7093d46c@kernel.org>
In-Reply-To: <20231118062754.2453-5-quic_luoj@quicinc.com>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
	<20231118062754.2453-5-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Nov 2023 14:27:52 +0800 Luo Jie wrote:
> +static inline bool phydev_id_is_qca808x(struct phy_device *phydev)

Please drop the "inline" keyword. The compiler will decide what's best.

