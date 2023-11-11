Return-Path: <netdev+bounces-47186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9C7E8B85
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1601F20EF7
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF1418E1A;
	Sat, 11 Nov 2023 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF5gdkzU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528918E06
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 16:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659A4C433C7;
	Sat, 11 Nov 2023 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699719150;
	bh=M4cgVMDKzhYpBMH/LUO/PfNZ4j2b9ExabWjMZLqhdjs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MF5gdkzUKg0jbq0Yf0rvdUbqLntJ0gulxA/HkQ7fkQz9WAvwzLTfXIfcRASGjtC9h
	 dUJMMgrxrXlp2Fy7jsnUP59X41WffIWU0wCTSfdKp56Xyr3I9VMgWOd+Kfeo47bkcJ
	 DgNTQx8orJHsAqIm8lqvOy/6gKdwO0eRmzz132JyxWYMRiWoggMfEVkOYPFTPTvEp3
	 IhlG3bNd68Ib84h7PZMq+0jsqohHcx7E4yZr1IEQG57NlNeuACWljIXbtKMzg1Rqej
	 21BBS0U96wkJxhsSSUZHV7AHiiz8FIX2em2iFLcj5KaFM3QD4MHDTD7FTqxnvLisTV
	 IC4o7l02D7XQQ==
Message-ID: <deb2c0f5-3e5e-4136-bc80-eac8bfef9228@kernel.org>
Date: Sat, 11 Nov 2023 18:12:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
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
References: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/2023 18:13, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to prueth_remove, just also taking care for NULL'ing the
> iep pointers.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

