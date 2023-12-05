Return-Path: <netdev+bounces-53744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F8804544
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52ABD1F21D84
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06974C6C;
	Tue,  5 Dec 2023 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+3cvUXi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46784A3E
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD52CC433C8;
	Tue,  5 Dec 2023 02:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701744268;
	bh=IHTeEY6xAwIklEypulw2bMOeouKK1Rphc7/TbH7wzjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L+3cvUXi92VN8yr3PVhH+xnN4oAJN9W1P5SBBLr81mSNhXPdTxlnAVZq5+ZaG4uEr
	 vJxV9VsTDXVMpPx/HPOfckNGkPWxPrZ2HswUtVOSR+bz6WQmhE7Y1fxsnEVxhCRjwE
	 CTKdPfw1cX4IyUBaRGjq0/sNaTSsrx5ISbSmV7UL9rZHHh/5PdOAwAQNpmZ8VzDuiD
	 0IkBT/RWvzjuCJQqFEeyW7CGQskv1ShnovKHL8NzFj6cYGYHyEbpL08zO4d1sBMfwx
	 cLR+B8lZdRf3dTKOt5zJn49Qsfrg6w9FIfsrbsv7A8fQ6HlZWVeT6tUjD8jp2A0BQp
	 NRy+R58QsDD7Q==
Date: Mon, 4 Dec 2023 18:44:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v6 4/6] ptp: clockmatrix: dco input-to-output
 delay is 20 FOD cycles + 8ns
Message-ID: <20231204184426.41b99c37@kernel.org>
In-Reply-To: <PH7PR03MB7064A9C11FB1252AEED5EF13A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
References: <20231130184634.22577-1-lnimi@hotmail.com>
	<PH7PR03MB7064A9C11FB1252AEED5EF13A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 13:46:32 -0500 Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>

This one is missing a commit message.
-- 
pw-bot: cr

