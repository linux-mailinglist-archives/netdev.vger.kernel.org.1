Return-Path: <netdev+bounces-52804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D648800418
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CD72813E7
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18648C8E0;
	Fri,  1 Dec 2023 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYFS8nnn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5D3D75;
	Fri,  1 Dec 2023 06:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE24C433C7;
	Fri,  1 Dec 2023 06:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701412994;
	bh=gy86aBRFM5ntewX0ZWm8ng5yRP0xd8Rja2LMdU2Bcig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bYFS8nnnwr5FxuEdaHlZzR89ekJRVbLOnMByvsOHLnOwVk723yvgGQd6QhdgRXpiD
	 kI4n8oZHVts0pzoeyy18GDPzAb2tTBOf/16AnhGzyUTTlwrs9xYLwIwVgOMEO2lrmB
	 QI8YxwB+bJT88Q1f2etWkLhwbZ+DUG/BSx8nhOQGWbsa9n/JWpNrd8X+2QPBGczd9l
	 VfhIG0XBKro2uPMUCMpcYC/8yQEKs5qMxUDCSmB3LP1Mf0I57WDvxrM/Q+WOSgmPoU
	 M3j5Ye/6u6ZfE/OX0oQujFzNCjEoSOAvGTLKOdT65yP0UX6i34CnMofHL28wIACnDc
	 T8tVh2eHEDfEg==
Date: Thu, 30 Nov 2023 22:43:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra
 <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qlcnic: replace deprecated strncpy with strscpy
Message-ID: <20231130224312.15317a12@kernel.org>
In-Reply-To: <170138162711.3649080.9337007847087027672.b4-ty@chromium.org>
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
	<170138162711.3649080.9337007847087027672.b4-ty@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 14:00:28 -0800 Kees Cook wrote:
> [1/1] qlcnic: replace deprecated strncpy with strscpy
>       https://git.kernel.org/kees/c/f8bef1ef8095

You asked for changes yourself here, please drop all the networking
patches you applied today :|

