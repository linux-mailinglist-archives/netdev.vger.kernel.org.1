Return-Path: <netdev+bounces-28931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768278130B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390BF1C21670
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CFF1AA8A;
	Fri, 18 Aug 2023 18:46:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2A1B7C2
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639BAC433C8;
	Fri, 18 Aug 2023 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692384395;
	bh=Ec9E/glXuJb9fOp/MxWKIXOKH8y1Hb91Z380MWLit3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQxiYcueHV2n324eNsYOUtqHrkRZdAWamBTUmwRTceZkyH3+wI+pyBXLX5rEcJk5p
	 5sIZGiDhr6ui4l+/fQ7kY5V4M5MInsUrY4lazGEJdEFhNKTTZYPRgjpOLWZdJdQD/F
	 OY36Ol+6zc2C7lHfsSIl3pY52uD6arIKoqKROs/EdhU7ArB/hjWSgQaZeALFiRb8fk
	 +CtSNQkUfrHCGRA0TeF/8Z1y4NTKDWKpgAEV3TgvgTi7puZ8NLf+KnzAyPzq1LsQ5I
	 DhQOlhwsnRSruoYRy3MuiSZPGZa8LH0sMtzPsYH1y1q+3TT/iXLE/esB9G7B3+c9Cs
	 64tduluga7fgg==
Date: Fri, 18 Aug 2023 11:46:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Alan Brady <alan.brady@intel.com>,
 pavan.kumar.linga@intel.com, emil.s.tantilov@intel.com,
 jesse.brandeburg@intel.com, sridhar.samudrala@intel.com,
 shiraz.saleem@intel.com, sindhu.devale@intel.com, willemb@google.com,
 decot@google.com, andrew@lunn.ch, leon@kernel.org, mst@redhat.com,
 simon.horman@corigine.com, shannon.nelson@amd.com,
 stephen@networkplumber.org, Joshua Hay <joshua.a.hay@intel.com>, Madhu
 Chittim <madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v5 12/15] idpf: add RX splitq napi poll support
Message-ID: <20230818114633.0743c860@kernel.org>
In-Reply-To: <20230816004305.216136-13-anthony.l.nguyen@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
	<20230816004305.216136-13-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 17:43:02 -0700 Tony Nguyen wrote:
> Add support to handle interrupts for the RX completion queue and
> RX buffer queue. When the interrupt fires on RX completion queue,
> process the RX descriptors that are received. Allocate and prepare
> the SKB with the RX packet info, for both data and header buffer.

Acked-by: Jakub Kicinski <kuba@kernel.org>

