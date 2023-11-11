Return-Path: <netdev+bounces-47185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9F7E8B82
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 17:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A101C2074F
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F618AFA;
	Sat, 11 Nov 2023 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfQt+5Vg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE818E06
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 16:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4A1C433C8;
	Sat, 11 Nov 2023 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699719081;
	bh=7hFDkPY40TSUqr/I2+vQYFELs1jchsJhchkqz8iEWmI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OfQt+5Vgr0DueZVEZ9T7dwlKICLyvoT7y/mxCq61FoVR6l9sQrRAt6hZePMGA0vlO
	 TgXJ0VrqErt6VqIXZ4kyA6R8yOsyBGKK760XGIRSnW7xUpfEn5qIkNLRfhVL1MvFhE
	 x9we1cJotdwoCFmOusncfo1QOgtU7sd5uwFLOLDXBxmlHLNHqQp9CRlljkgExruPnF
	 dC8jAv3eYGAXe6fd9tJoGrTACccp8wNIpMUwEOKLc7bXCCCwqeusNRtsM2coEqBcoK
	 z5nnoj51htn63An89T72EqmSSGdRbW2sfCZI4YDX7deaNDwNLI8lYX33euuzWxHDfU
	 RBjsNCg31PZZQ==
Message-ID: <8d92ee52-fa77-4fba-88bf-2cf24f43d985@kernel.org>
Date: Sat, 11 Nov 2023 18:11:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix error cleanup on
 failing pruss_request_mem_region
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 MD Danish Anwar <danishanwar@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
 Nishanth Menon <nm@ti.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>
References: <bbc536dd-f64e-4ccf-89df-3afbe02b59ca@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <bbc536dd-f64e-4ccf-89df-3afbe02b59ca@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/2023 18:13, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We were just continuing in this case, surely not desired.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

