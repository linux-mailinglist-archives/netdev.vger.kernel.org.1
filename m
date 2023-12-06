Return-Path: <netdev+bounces-54262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E81A80660C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521371F216DD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775FEDF52;
	Wed,  6 Dec 2023 04:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muWWkMAv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08A7E4
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C01C433C8;
	Wed,  6 Dec 2023 04:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701836014;
	bh=N6d3WDQXBpUUJYFB5GkMxiZ9zKIcfiD6CL5VKF+5wmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=muWWkMAviTyNj2UxWStdY3fmRURd7XI31heKH4w2rX9WG6FiwcitTPjF22yFsOBcJ
	 SPA1J//+KEMiVFQTDqRDYJnpTOyT2KDcp4/LutxyM9mecCgwSCWCTiPWlQG+RJy+K1
	 CqM1jDmnEZ3MHrMKdI9bDEuGNt66qQn9g6WAXsZEgnq6KVa/8l74+IAk6wIAFY+v0q
	 JCSb/zvE8HwMO/Kh98KWWMw5WXO/EIbsWHuN9xO5p9TlgofJN1CgpAx1GeuRQ8Fx81
	 IIpV1PMkNUHKGZSUtisFjB3/UoIvJD+HXor8VRbum6etDiE+SE+ECay1oKMntzLF78
	 QuO7bE6HQe9gg==
Date: Tue, 5 Dec 2023 20:13:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/3] arm64: dts: marvell: cp11x: Provide
 clock names for MDIO controllers
Message-ID: <20231205201333.4b8445c3@kernel.org>
In-Reply-To: <20231204100811.2708884-2-tobias@waldekranz.com>
References: <20231204100811.2708884-1-tobias@waldekranz.com>
	<20231204100811.2708884-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Dec 2023 11:08:09 +0100 Tobias Waldekranz wrote:
> This will let the driver figure out the rate of the core clk, such
> that custom MDC frequencies can be supported.

Leaving this one to Gregory.

