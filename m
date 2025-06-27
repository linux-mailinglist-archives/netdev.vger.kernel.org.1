Return-Path: <netdev+bounces-201705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3036BAEAB93
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3855E1890B84
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C720522F;
	Fri, 27 Jun 2025 00:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXOOh3NA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109B28371;
	Fri, 27 Jun 2025 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750982746; cv=none; b=ZCyIf2xNq/jTHARleWM0Lg7weuppuLgGNy1Rqa7aL7l6K9yMvS1/v7NDmMQ5KAGNEksvwEcI0RpP2gzkeb735olSQNFUP9khecMgQP7TxAJuK57Hxh6e70wUb34P8GAesCkOeWKXqYqAFofxB3bzlS+GQY0AvlFIHQz5tURRDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750982746; c=relaxed/simple;
	bh=Ck+DzOXAxdqOO+jxI+vUNr8Y2kNlJLXxkINzJ1YAIWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9/2cBVubaBH1YTiIkbF2oJH2pRdvQj6rcO/rqo5hA8z1DcEz6G8E1B7mRHSHWU0yfp7+qebnsyKjc5SrjjtYgjWqKsOkmGWRC+xcbKgPfMlA+EWbG5OI2RlB8GlZEAFoKrWxGGMKksLvlpFcO3QXMR4AbP4x1fEbqG1PipRa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXOOh3NA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEC7C4CEEB;
	Fri, 27 Jun 2025 00:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750982745;
	bh=Ck+DzOXAxdqOO+jxI+vUNr8Y2kNlJLXxkINzJ1YAIWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GXOOh3NA9gmywj39wIs+aigKeNMeViNksWSk/5y28zohFx5WMCY1eLtcSzpdzXU87
	 VX3w9Xk1/v3Oyt/q4VsNpOGuxQYZYFkaBuDSV+pQcMu0oOwVZZAAl0H/Jx2/hp78+Q
	 4G7cybaPKiRznAIICJW+8KA38s8MPCywWbABM/BgXMHHikQ0I8mg+H0p0RiRLuo2ch
	 vm7SeUCxCVzi61OIuPKt7oBnydhcGEx7lDXQ7GsmwPy04yjNnlv2NWJZtgeUNFjqCo
	 cPSSlOVHksN5Kiqwb/wa/AXUQPbIzka2jCmLDz48p7Nl4hz3cr5m2s4BWC7P3rbHV1
	 4alWUEk09msug==
Date: Thu, 26 Jun 2025 17:05:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, Matthew Gerlach
 <matthew.gerlach@altera.com>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Mun Yew Tham
 <mun.yew.tham@altera.com>
Subject: Re: [PATCH v6] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
Message-ID: <20250626170543.6696868d@kernel.org>
In-Reply-To: <20250626234119.GA1398428-robh@kernel.org>
References: <20250613225844.43148-1-matthew.gerlach@altera.com>
	<20250623111913.1b387b90@kernel.org>
	<20250626234119.GA1398428-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jun 2025 18:41:19 -0500 Rob Herring wrote:
> No need to ping us. Like netdev, you can check the PW queue:
>=20
> https://patchwork.ozlabs.org/project/devicetree-bindings/list/

Thanks, noted!

> In any case, we're a bit behind ATM.
>=20
>=20
> It looks like we have 2 competing conversions of this binding. This one=20
> and this one which I reviewed:
>=20
> https://lore.kernel.org/all/20250624191549.474686-1-dinguyen@kernel.org/
>=20
> Looks like there are some differences which need resolving, so I revoke=20
> my review. Will follow-up separately on both.

=F0=9F=91=8D=EF=B8=8F

