Return-Path: <netdev+bounces-24115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C3976ED5E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9611C2153A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E91F18A;
	Thu,  3 Aug 2023 14:58:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B51ED48
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD23C433C8;
	Thu,  3 Aug 2023 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691074714;
	bh=yMg1YEwuJlIFczOQZY8fQXTUaLaqCwPe1K5AJfailb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnZo4TfWlyzyTmeTVwJWce2tqZsbJPYrVVSOM8snyxCcEa18Q473++Mm5TzoZbXF4
	 XG/fbkrFrX8fv2hmeJHqpy34ohk+n3uYw4VyKDaeQBvKAblqmLjRXZOr+s5scO1P3S
	 ISgoZraioxE44UFUuwofEcSSikNuLQl4qrcUE5ALRpzMgRVvoYVKXBBKu0QWubvLXt
	 +nivNO666XHDvB7isEqr2AOhNL3doay5dUfd9BsKgbeuSd3Yr2LPd49UxnVCd5HG4b
	 ingQ56KYEVvDxjWb8/cBWUsziSCYyn3eCzRX5ThpJinsY6AVmqyIzTpdAkt/Z5JQKA
	 dqb99rMqyWC/A==
Date: Thu, 3 Aug 2023 16:58:28 +0200
From: Simon Horman <horms@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] bluetooth: qca: use switch case for soc type
 behavior
Message-ID: <ZMvAlO2Y9CfJtOlE@kernel.org>
References: <20230803-topic-sm8550-upstream-bt-v3-0-6874a1507288@linaro.org>
 <20230803-topic-sm8550-upstream-bt-v3-2-6874a1507288@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803-topic-sm8550-upstream-bt-v3-2-6874a1507288@linaro.org>

On Thu, Aug 03, 2023 at 10:45:27AM +0200, Neil Armstrong wrote:
> Use switch/case to handle soc type specific behaviour,
> the permit dropping the qca_is_xxx() inline functions
> and maked the code clearer and easier to update for new

nit: maked -> make

> SoCs.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

...

