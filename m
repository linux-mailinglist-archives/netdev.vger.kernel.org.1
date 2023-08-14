Return-Path: <netdev+bounces-27213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723277AF86
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 04:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CD31C2086B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 02:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070915BE;
	Mon, 14 Aug 2023 02:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27231381
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 02:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69D3C433C7;
	Mon, 14 Aug 2023 02:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691980263;
	bh=VWxsrgrmzgiFVeh4uApFFOq1bvVtEbfmqGxK5dcHgJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqNYowo89QH+fv5UYg6/rjtlSX8A654pS4ZglHks3eafCI4ipt5BTaf8h2y1eUBkK
	 KKUWawzDfLHRwDYCXYWmHgIYFpbmhkcSR4avxjw7AGHLB5vH5jIMSjpSGzQqz3Y8FL
	 rZWeuQEhJbzyz6C+gUUDIiAXrZFyvTYWN6eN4jNsyuloz01ncxvPuLi8cz+7pwIf2l
	 546uPdmjU1Cu01L7CK3vpdLnL+QX2vp/FF5RU1IvTxLvh+2nzUYLm6x8a/6X7YhR5Y
	 NMHuEsHCpiuYk6O1FlUO9eE79p7M0yZRNMOxK8UGFtb2NLc20YWYSvubBLmiikhMoT
	 WgdQYSnyEOzPg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Chris Lew <quic_clew@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Alex Elder <elder@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: (subset) [PATCH v2 0/4] soc: qcom: aoss: Introduce debugfs interface and cleanup things
Date: Sun, 13 Aug 2023 19:33:50 -0700
Message-ID: <169198038111.2378845.5285992748905331833.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811205839.727373-1-quic_bjorande@quicinc.com>
References: <20230811205839.727373-1-quic_bjorande@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 11 Aug 2023 13:58:35 -0700, Bjorn Andersson wrote:
> The Always On Processor supports a number useful commands for affecting
> system resources during in various debug scenarious. Introduce a debugfs
> interface for allowing the debugger/tester to send these commands.
> 
> While at it, let's make some improvements to the qmp_send() API.
> 
> 
> [...]

Applied, thanks!

[1/4] soc: qcom: aoss: Move length requirements from caller
      commit: 59e09100836fdb618b107c37189d6001b5825872
[3/4] soc: qcom: aoss: Format string in qmp_send()
      commit: 8873d1e2f88afbe89c99d8f49f88934a2da2991f
[4/4] soc: qcom: aoss: Tidy up qmp_send() callers
      commit: b4f63bbff96e4510676b1e78b00d14baaee9ad29


Please note that I did not pick the debugfs interface (patch 2/4).

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

