Return-Path: <netdev+bounces-51991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA3C7FCDB0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DA72832D9
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CBE63A3;
	Wed, 29 Nov 2023 03:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH0PQrWJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26C44371
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E620C433C9;
	Wed, 29 Nov 2023 03:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701230292;
	bh=pTybYc9tif82m6rvKK0P6WNpbwK/7q1cBpB8C582wDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iH0PQrWJfV0Xc1bTlcNd7f77++W/SvVxhzI13J6J5xiDiCMAokvs5iPE/oBh4FuIQ
	 BhaiDCNVUYez7eIkWx59lyyyVzbZlmxy4SxuKoI7ljmfwtbyn0Prdu+LBF7cQBPOY1
	 O2CHLC3PWgk30wPnXKMryQcmsWbgs9EvlGMw0zVhUPbAHzVTvVMrCP1MoTqq2FDjSf
	 VemDDctfjRbaEqcKVbanRipoiifMuf32aHJ7CmKR/pTxpAYmZTqEL0g2V2I4dHxAZ/
	 ohR2CJ7ki5x0saLWlk4RmzHS7jt82/M/8/01ksk/FITIxFVv1NYe3kM6UjrAV9rRRL
	 o6PKsd98Sszrw==
Date: Tue, 28 Nov 2023 19:58:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for
 the measured external offset
Message-ID: <20231128195811.06bd301d@kernel.org>
In-Reply-To: <PH7PR03MB706497752B942B2C33C45E58A0BDA@PH7PR03MB7064.namprd03.prod.outlook.com>
References: <PH7PR03MB706497752B942B2C33C45E58A0BDA@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 15:01:29 -0500 Min Li wrote:
> This change is for the PHC devices that can measure the phase offset
> between PHC signal and the external signal, such as the 1PPS signal of
> GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
> the existing ptp_extts_event so that application such as ts2phc can
> poll the external offset the same way as extts. Hence, ts2phc can use
> the offset to achieve the alignment between PHC and the external signal
> by the help of either SW or HW filters.

Does not apply to net-next.
-- 
pw-bot: cr

