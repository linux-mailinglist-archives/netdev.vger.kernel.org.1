Return-Path: <netdev+bounces-58810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9619E818447
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB29E1C214AA
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E812B98;
	Tue, 19 Dec 2023 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmjKCQVm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88312E48;
	Tue, 19 Dec 2023 09:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95180C433C7;
	Tue, 19 Dec 2023 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702977725;
	bh=Z21dUfsapgtIWyYATafp6nz9R/e935bEpMDxj+E68o4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GmjKCQVm8XjWw+ADmlXxiOrv4jR7zxPj7hMPSWru7PV6Cs+IOQBoRMYZnfPF1RCeH
	 RDkOl0n3eiQMVFC9NNt/3lSmRpDH6eauaHkxfayvRUYCtwLSVaIt4RM/PG5PYO4MbR
	 MsCW1JwPINE7VvV3rQWyTK5hxykGqxPxMQmPX7TVj2h754oJxNjAE0awkbLmJ1SsvU
	 gCl3Bey7C3+CFU+Hg0avuHBCNJzRgrKWjuSRAGt0B1y65roUWthGWKZ1wPcinwLnyv
	 ft0GBjL/QaMDw1DzzwXVyy2ntrYO0LKQCEQx1APaCBVQ65y1dtiAfGuihGmQILmJKm
	 dwQkeTqDWROZg==
Date: Tue, 19 Dec 2023 10:22:00 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
Message-ID: <20231219102200.2d07ff2f@dellmb>
In-Reply-To: <20231214201442.660447-2-tobias@waldekranz.com>
References: <20231214201442.660447-1-tobias@waldekranz.com>
	<20231214201442.660447-2-tobias@waldekranz.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 21:14:39 +0100
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> +MODULE_FIRMWARE("mrvl/x3310fw.hdr");

And do you have permission to publish this firmware into linux-firmware?

Because when we tried this with Marvell, their lawyer guy said we can't
do that...

Marek

