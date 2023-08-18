Return-Path: <netdev+bounces-28928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABBC781301
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB51C2145D
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206E819BC8;
	Fri, 18 Aug 2023 18:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5E319BB0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE0CC433C7;
	Fri, 18 Aug 2023 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692384136;
	bh=ZHDXVI0EBt/q6Py5tdnQXvWhmVVAseKooP+/mA/x7iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MGPAFYYOivuJDykLQEssMqR97gM5fnxZmYFpEZAnNP5ryN1dbsyDFvBLwLqNTfzb7
	 /LJv071eC+2VzqQH5zA7ZFG9NbEyKxUXRDFMKjYJL1ak2gWMT7CRnCDdEj7ucQ4+h1
	 NK5UiKuEh0339YRdCHAJow4EUjSsD0184K4dN3zpNQogGJBiSGZh/6cjMeNp25dxB2
	 VqOUx+HtFbfOa0w9gu+xZ1OPnspPrYK2H6n/r3c9kO4+6Q1+KVK0E4N8jZmGw9pgfQ
	 ZD/ba978EwHURUyvK47KN2ZVvB3LIYPoL/INyn+wYIplkmTQlElsURJV92POW+jjJk
	 /XY+AkZ7HjQQg==
Date: Fri, 18 Aug 2023 11:42:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Joshua Hay <joshua.a.hay@intel.com>,
 pavan.kumar.linga@intel.com, emil.s.tantilov@intel.com,
 jesse.brandeburg@intel.com, sridhar.samudrala@intel.com,
 shiraz.saleem@intel.com, sindhu.devale@intel.com, willemb@google.com,
 decot@google.com, andrew@lunn.ch, leon@kernel.org, mst@redhat.com,
 simon.horman@corigine.com, shannon.nelson@amd.com,
 stephen@networkplumber.org, Alan Brady <alan.brady@intel.com>, Madhu
 Chittim <madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v5 11/15] idpf: add TX splitq napi poll support
Message-ID: <20230818114214.45051922@kernel.org>
In-Reply-To: <20230816004305.216136-12-anthony.l.nguyen@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
	<20230816004305.216136-12-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 17:43:01 -0700 Tony Nguyen wrote:
> From: Joshua Hay <joshua.a.hay@intel.com>
> 
> Add support to handle the interrupts for the TX completion queue and
> process the various completion types.

Acked-by: Jakub Kicinski <kuba@kernel.org>

