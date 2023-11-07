Return-Path: <netdev+bounces-46482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F277E479D
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 18:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317411C20A31
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA634CEA;
	Tue,  7 Nov 2023 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqrJyybL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F734CE6
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 17:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DF2C433C8;
	Tue,  7 Nov 2023 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699379620;
	bh=Nu1d7qStr3LIgexWUymfoceI7ol57JxZEo2yh+rBJQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WqrJyybL3V1OwpOh1RoDUrm6cA7m4VtpbXW0ji/49OHt9r7xkYZDXyzDT/ZbDNace
	 yDRRDgkLkRpzDVyTRP7Yk2lyXGQ2nOBPOsa28kaj5X5iAQJGLwcmgY93OLC+9rH44C
	 To+gAD8RBhgaiqmhGM0C4uW9bNXxSxT4t5ZJrtI3GtxFM08xnTq2arSXvI20mVGqnm
	 VBsMeXkL6/awAoK3ehF1vbWuoNIaXLWgEz2mllOb9j5RN7ia8EZubsS0wFPyRKQACv
	 Y69BfqzhmwqIGO8pylyv7Au6g8G2WKc3jnJaJMIr7oGmZB+Dtqx0OOsjUZF5gR/Lyz
	 47tU3UFLmcFOA==
Date: Tue, 7 Nov 2023 09:53:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: ChunHao Lin <hau@realtek.com>
Cc: <hkallweit1@gmail.com>, <netdev@vger.kernel.org>, <nic_swsd@realtek.com>
Subject: Re: [PATCH net 0/2] r8169: fix DASH deviceis network lost issue
Message-ID: <20231107095339.49309193@kernel.org>
In-Reply-To: <20231106151124.9175-1-hau@realtek.com>
References: <20231106151124.9175-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Nov 2023 23:11:22 +0800 ChunHao Lin wrote:
> This series are used to fix network lost issue on systems that support
> DASH.

Please use get_maintainer on the patch files to make sure you CC all
relevant people.

